require 'rails_helper'

RSpec.describe StepByStepPageReverter do
  describe "#repopulate_from_publishing_api" do
    let(:step_by_step_page) { create(:step_by_step_page_with_navigation_rules) }

    subject { described_class.new(step_by_step_page, payload_from_publishing_api(step_by_step_page.content_id)) }

    before do
      allow(Services.publishing_api).to receive(:lookup_content_ids).and_return({})
      subject.repopulate_from_publishing_api
      step_by_step_page.reload
    end

    it "saves the title" do
      expect(step_by_step_page.title).to eq("An existing step by step that has previously been published")
    end

    it "saves the slug" do
      expect(step_by_step_page.slug).to eq("an-existing-step-by-step")
    end

    it "saves the introduction" do
      expect(step_by_step_page.introduction).to eq("An introduction to the step by step journey.")
    end
  end

  def payload_from_publishing_api(content_id)
    {
      "base_path": "/an-existing-step-by-step",
      "content_store": "live",
      "description": "A description of the step by step page from publishing-api",
      "details": {
        "step_by_step_nav": {
          "title": "An existing step by step that has previously been published",
          "introduction": [
            {
              "content_type": "text/govspeak",
              "content": "An introduction to the step by step journey."
            }
          ],
          "steps": [
            {
              "title": "Step one of the step by step",
              "contents": [
                {
                  "type": "paragraph",
                  "text": "A paragraph of text in the first step."
                },
                {
                  "type": "paragraph",
                  "text": "A second paragraph of text in the first step."
                }
              ],
              "optional": false
            },
            {
              "title": "Step two of the step by step",
              "contents": [
                {
                  "type": "list",
                  "contents": [
                    {
                      "text": "The first item in the list for step two",
                      "href": "/first-item-in-list-of-step-two"
                    }
                  ]
                }
              ],
              "optional": false
            },
            {
              "title": "Step three of the step by step",
              "contents": [
                {
                  "type": "list",
                  "style": "choice",
                  "contents": [
                    {
                      "text": "The first item in the bulleted list for step three",
                      "href": "/guidance/first-item-in-bulleted-list-of-step-three"
                    }
                  ]
                }
              ],
              "optional": true,
              "logic": "or"
            },
            {
              "title": "Step four of the step by step",
              "contents": [
                {
                  "type": "list",
                  "contents": [
                    {
                      "text": "The first item in the list for step four",
                      "href": "/first-item-in-list-of-step-four"
                    },
                    {
                      "text": "The second item in the list for step four",
                      "href": "/second-item-in-list-of-step-four"
                    },
                    {
                      "text": "The third item in the list for step four",
                      "href": "https://www.external.link/third-item-in-list-of-step-four"
                    }
                  ]
                }
              ],
              "optional": false,
              "logic": "and"
            },
            {
              "title": "Step five of the step by step",
              "contents": [
                {
                  "type": "list",
                  "style": "choice",
                  "contents": [
                    {
                      "text": "A list of text in the fifth step."
                    }
                  ]
                }
              ],
              "optional": false,
            },
            {
              "title": "Step six of the step by step",
              "contents": [
                {
                  "type": "list",
                  "contents": [
                    {
                      "text": "The first item in the list for step six with context",
                      "href": "/first-item-in-list-of-step-six-with-context",
                      "context": "£23"
                    }
                  ]
                }
              ],
              "optional": false
            },
            {
              "title": "Step seven of the step by step",
              "contents": [
                {
                  "type": "list",
                  "style": "choice",
                  "contents": [
                    {
                      "text": "The first item in the bulleted list for step seven with context",
                      "href": "/first-item-in-list-of-step-seven-with-context",
                      "context": "£62 to £75"
                    }
                  ]
                }
              ],
              "optional": false
            },
            {
              "title": "Step eight of the step by step",
              "contents": [
                {
                  "type": "paragraph",
                  "text": "A paragraph of text in the eighth step."
                },
                {
                  "type": "paragraph",
                  "text": "A second paragraph of text in the eighth step."
                },
                {
                  "type": "list",
                  "contents": [
                    {
                      "text": "The first item in the list for step eight with context",
                      "href": "/first-item-in-list-of-step-eight-with-context",
                      "context": "£100"
                    },
                    {
                      "text": "The second item in the list for step eight",
                      "href": "/second-item-in-list-of-step-eight"
                    }
                  ]
                },
                {
                  "type": "paragraph",
                  "text": "A third paragraph of text in the eighth step."
                },
                {
                  "type": "list",
                  "style": "choice",
                  "contents": [
                    {
                      "text": "The first item in the bulleted list for step eight with context",
                      "href": "/first-item-in-bulleted-list-of-step-eight-with-context",
                      "context": "£100"
                    },
                    {
                      "text": "The second item in the bulleted list for step eight",
                      "href": "/second-item-in-bulleted-list-of-step-eight"
                    }
                  ]
                },
              ],
              "optional": false
            }
          ]
        }
      },
      "document_type": "step_by_step_nav",
      "first_published_at": "2017-11-01T15:31:15Z",
      "last_edited_at": "2018-08-31T11:07:06Z",
      "phase": "live",
      "public_updated_at": "2018-08-31T10:58:30Z",
      "publishing_app": "collections-publisher",
      "redirects": [],
      "rendering_app": "collections",
      "routes": [
        {
          "path": "/an-existing-step-by-step",
          "type": "exact"
        }
      ],
      "schema_name": "step_by_step_nav",
      "title": "An existing step by step that has previously been published",
      "user_facing_version": 7,
      "update_type": "minor",
      "publication_state": "published",
      "content_id": content_id,
      "locale": "en",
      "lock_version": 20,
      "updated_at": "2018-08-31 11:07:06.977105",
      "state_history": {
        "5": "superseded",
        "6": "published",
        "1": "superseded",
        "2": "superseded",
        "3": "superseded",
        "4": "superseded"
      },
      "links": {
        "pages_related_to_step_nav": [
          "8d35443d-7bf1-4f51-b9b1-e398e1d44030",
        ],
        "pages_part_of_step_nav": [
          "a1156b8f-2a46-4fe1-8871-652abce9c925",
          "eca3f3dd-3296-4b86-8dc8-42f91fe0cb6e",
          "45c23180-968a-47bb-adbc-25d5422015ff",
          "d6b1901d-b925-47c5-b1ca-1e52197097e2",
          "b5d8c773-3a31-45f2-838d-255afef5511a",
          "bbf6c11a-7dc6-4fe6-8dd8-68c09bdbe562",
          "1788c387-8680-4454-8923-71ad0f632cbb",
          "2b422e36-85c4-40fb-a40b-5cd40c86c0f8",
          "2148f116-f909-4976-bb05-cb4899f3272a"
        ]
      },
      "warnings": {
      }
    }
  end
end
