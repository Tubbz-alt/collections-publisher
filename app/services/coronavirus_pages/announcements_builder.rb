class CoronavirusPages::AnnouncementsBuilder
  def create_announcements
    if announcements_from_yaml.any?
      Announcement.transaction do
        coronavirus_page.announcements.delete_all

        announcements_from_yaml.each do |announcement|
          coronavirus_page.announcements.create!(
            title: announcement["text"],
            path: announcement["href"],
            published_at: Date.parse(announcement["published_text"]),
          )
        end
      end
    end
  end

private

  def announcements_from_yaml
    @github_data ||= YamlFetcher.new(coronavirus_page.raw_content_url).body_as_hash
    @github_data["content"]["announcements"]
  end

  def coronavirus_page
    @coronavirus_page ||= CoronavirusPage.find_by(slug: "landing")
  end
end
