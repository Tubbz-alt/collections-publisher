# == Schema Information
#
# Table name: lists
#
#  id       :integer          not null, primary key
#  name     :string(255)
#  index    :integer          default(0), not null
#  dirty    :boolean          default(TRUE), not null
#  topic_id :integer          not null
#
# Indexes
#
#  index_lists_on_topic_id  (topic_id)
#

require "spec_helper"

RSpec.describe List do

  describe "validations" do
    let(:list) { FactoryGirl.build(:list) }

    it "requires a topic" do
      list.topic = nil
      expect(list).not_to be_valid
    end
  end

  describe "marking as published" do
    let(:list) { FactoryGirl.create(:list, dirty: true) }

    describe "#mark_as_published" do
      it "sets #dirty? to false without saving" do
        list.mark_as_published

        expect(list).not_to be_dirty

        list.reload
        expect(list).to be_dirty
      end
    end

    describe "#mark_as_published!" do
      it "sets #dirty? to false and saves" do
        list.mark_as_published!

        expect(list).not_to be_dirty

        list.reload
        expect(list).not_to be_dirty
      end
    end

    describe "#delete" do
      it "deletes list items" do
        list = create(:list)
        item = create(:list_item, list: list)

        list.delete

        expect { item.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
