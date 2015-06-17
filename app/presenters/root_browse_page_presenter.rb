class RootBrowsePagePresenter

  def render_for_publishing_api
    {
      content_id: "8413047e-570a-448b-b8cb-d288a12807dd",
      format: "mainstream_browse_page",
      title: "Browse",
      locale: 'en',
      public_updated_at: public_updated_at,
      publishing_app: "collections-publisher",
      rendering_app: "collections",
      routes: routes,
      update_type: "major",
      links: links,
    }
  end

private

  def top_level_browse_pages
    MainstreamBrowsePage.sorted_parents
  end

  def public_updated_at
    if links["top_level_browse_pages"].empty?
      raise "Top-level pages Array can't be empty"
    else
      top_level_browse_pages
        .map(&:updated_at)
        .max
        .iso8601
    end
  end

  def routes
    [ {path: "/browse", type: "exact"} ]
  end

  def links
    {
      "top_level_browse_pages" => top_level_browse_pages.map(&:content_id)
    }
  end

end
