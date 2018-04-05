class StepLinksForRules
  def initialize(step_by_step_page:, step_content_parser: StepContentParser.new)
    @step_by_step_page = step_by_step_page
    @step_content_parser = step_content_parser
  end

  def self.update(step_by_step_page)
    new(step_by_step_page: step_by_step_page).call
  end

  def call
    navigation_rules.each do |rule|
      set_navigation_state(rule) if step_by_step_page_has_link_to_content?(rule.content_id)
    end

    # clear out the existing rules
    delete_rules

    # replace with fresh rules
    add_rules(rules: updated_rules)
  end

private

  attr_reader :step_content_parser, :step_by_step_page

  def set_navigation_state(rule)
    rules_from_step_content[rule.content_id][:include_in_links] = rule.include_in_links
  end

  def step_by_step_page_has_link_to_content?(content_id)
    rules_from_step_content[content_id].present?
  end

  def navigation_rules
    step_by_step_page.navigation_rules
  end

  def updated_rules
    rules_from_step_content.values
  end

  # hash of rules payloads keyed by content_id
  def rules_from_step_content
    @step_rules ||= content_items.each_with_object({}) do |content_item, items|
      items[content_item["content_id"]] = build_rule(content_item)
    end
  end

  def build_rule(content_item)
    {
      content_id: content_item["content_id"],
      title: content_item["title"],
      base_path: content_item["base_path"],
      include_in_links: true
    }
  end

  def base_paths
    @base_paths ||=
      begin
        all_contents = step_by_step_page.steps.map(&:contents).join('\n')
        step_content_parser.base_paths(all_contents).uniq
      end
  end

  def content_ids
    return [] if base_paths.empty?

    results_from_lookup = lookup_content_ids(base_paths)

    results_from_lookup.values.uniq
  end

  def lookup_content_ids(base_paths)
    # this returns something like { "base_path_1" => "content_id_1", "base_path_2" => "content_id_2"}
    Services.publishing_api.lookup_content_ids(base_paths: base_paths, with_drafts: true)
  end

  def content_items
    @content_items ||= content_ids.map do |content_id|
      Services.publishing_api.get_content(content_id)
    end
  end

  def navigation_rule_paths
    step_by_step_page.navigation_rules.pluck(&:base_path)
  end

  def delete_rules
    step_by_step_page.navigation_rules.delete_all
  end

  def add_rules(rules:)
    rules.each do |rule|
      step_by_step_page.navigation_rules.create!(rule)
    end
  end
end
