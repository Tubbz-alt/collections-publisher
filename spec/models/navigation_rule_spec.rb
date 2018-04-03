require 'rails_helper'

RSpec.describe NavigationRule do
  let(:step_page) { create(:step_by_step_page) }

  it { belong_to :step_by_step_page }

  describe '#valid?' do
    before do
      allow(Services.publishing_api).to receive(:lookup_content_id)
    end

    context 'without a step_by_step_page' do
      it 'is invalid' do
        resource = described_class.new(
          title: 'A Title',
          base_path: '/a-base-path',
          content_id: 'A-CONTENT-ID-BOOM',
        )

        expect(resource).to_not be_valid
        expect(resource.errors).to have_key(:step_by_step_page_id)
      end
    end

    context 'without a title' do
      it 'is invalid' do
        resource = described_class.new(
          base_path: '/a-base-path',
          content_id: 'A-CONTENT-ID-BOOM',
          step_by_step_page: step_page,
        )

        expect(resource).to_not be_valid
        expect(resource.errors).to have_key(:title)
      end
    end

    context 'without a base_path' do
      it 'is invalid' do
        resource = described_class.new(
          title: 'A Title',
          content_id: 'A-CONTENT-ID-BOOM',
          step_by_step_page: step_page,
        )

        expect(resource).to_not be_valid
        expect(resource.errors).to have_key(:base_path)
      end
    end

    context 'without a content_id' do
      it 'is invalid' do
        resource = described_class.new(
          title: 'A Title',
          base_path: '/a-base-path',
          step_by_step_page: step_page,
        )

        expect(resource).to_not be_valid
        expect(resource.errors).to have_key(:content_id)
      end
    end

    context 'with valid attributes' do
      it 'is valid' do
        resource = described_class.new(
          title: 'A Title',
          base_path: '/a-base-path',
          content_id: 'A-CONTENT-ID-BOOM',
          step_by_step_page: step_page,
        )

        expect(resource).to be_valid
        expect(resource.errors).to be_empty
      end
    end
  end
end