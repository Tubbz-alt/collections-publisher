class AnnouncementsController < ApplicationController
  include DateFormatHelper
  before_action :require_coronavirus_editor_permissions!
  layout "admin_layout"

  def new
    @announcement = coronavirus_page.announcements.new
  end

  def create
    @announcement = coronavirus_page.announcements.new(announcement_params)
    if @announcement.save && draft_updater.send
      redirect_to coronavirus_page_path(@coronavirus_page.slug), notice: "Announcement was successfully created."
    else
      render :new
    end
  end

  def destroy
    @announcement = coronavirus_page.announcements.find(params[:id])
    @coronavirus_page = @announcement.coronavirus_page
    attrs = @announcement.attributes.except("id", "created_at", "updated_at")
    if @announcement.destroy && draft_updater.send
      message = { notice: "Announcement was successfully deleted." }
    else
      draft_updater.rebuild_announcement(attrs)
      message = { alert: "Announcement couldn't be deleted" }
    end
    redirect_to coronavirus_page_path(@coronavirus_page.slug), message
  end

  def edit
    @announcement = coronavirus_page.announcements.find(params[:id])
  end

  def update
    @announcement = coronavirus_page.announcements.find(params[:id])

    if @announcement.update(announcement_params) && draft_updater.send
      redirect_to coronavirus_page_path(@coronavirus_page.slug), notice: "Announcement was successfully updated."
    else
      render :edit
    end
  end

private

  def coronavirus_page
    @coronavirus_page ||= CoronavirusPage.find_by(slug: params[:coronavirus_page_slug])
  end

  def announcement_params
    params.require(:announcement)
    .permit(:title, :path, :published_at)
    .merge(format_published_at(
             params["announcement"]["published_at"]["day"],
             params["announcement"]["published_at"]["month"],
             params["announcement"]["published_at"]["year"],
           ))
  end

  def draft_updater
    @draft_updater ||= CoronavirusPages::DraftUpdater.new(@coronavirus_page)
  end
end
