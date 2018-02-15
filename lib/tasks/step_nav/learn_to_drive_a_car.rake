namespace :step_nav do
  desc "Publish /learn-to-drive-a-car step navigation to publishing api"
  task publish_learn_to_drive_a_car: :environment do
    content_id = "e01e924b-9c7c-4c71-8241-66a575c2f61f"
    params = {
      base_path: "/learn-to-drive-a-car",
      publishing_app: "collections-publisher",
      rendering_app: "collections",
      public_updated_at: Time.zone.now.iso8601,
      update_type: "major",
      change_note: "updating the content to match the new step_by_step_nav schema",
      schema_name: "step_by_step_nav",
      document_type: "step_by_step_nav",
      title: "Learn to drive a car: step by step",
      description: "Learn to drive a car in the UK - get a provisional licence, take driving lessons, prepare for your theory test, book your practical test.",
      details: {
        step_by_step_nav: {
          steps: [
            {
              title: "Check you're allowed to drive",
              contents: [
                {
                  type: "paragraph",
                  text: "Most people can start learning to drive when they’re 17."
                },
                {
                  type: "list",
                  style: "required",
                  contents: [
                    {
                      href: "/vehicles-can-drive",
                      text: "Check what age you can drive"
                    },
                    {
                      href: "/legal-obligations-drivers-riders",
                      text: "Requirements for driving legally"
                    },
                    {
                      href: "/driving-eyesight-rules",
                      text: "Driving eyesight rules"
                    }
                  ]
                }
              ]
            },
            {
              title: "Get a provisional driving licence",
              contents: [
                {
                  type: "list",
                  style: "required",
                  contents: [
                    {
                      href: "/apply-first-provisional-driving-licence",
                      text: "Apply for your first provisional driving licence",
                      context: "£34"
                    }
                  ]
                }
              ]
            },
            {
              title: "Driving lessons and practice",
              contents: [
                {
                  type: "paragraph",
                  text: "You need a provisional driving licence to take lessons or practice."
                },
                {
                  type: "list",
                  style: "required",
                  contents: [
                    {
                      href: "/guidance/the-highway-code",
                      text: "The Highway Code"
                    },
                    {
                      href: "/driving-lessons-learning-to-drive",
                      text: "Taking driving lessons"
                    },
                    {
                      href: "/find-driving-schools-and-lessons",
                      text: "Find driving schools, lessons and instructors"
                    },
                    {
                      href: "/government/publications/car-show-me-tell-me-vehicle-safety-questions",
                      text: "Practise vehicle safety questions"
                    }
                  ]
                }
              ]
            },
            {
              title: "Prepare for your theory test",
              logic: "and",
              contents: [
                {
                  type: "list",
                  style: "required",
                  contents: [
                    {
                      href: "/theory-test/revision-and-practice",
                      text: "Theory test revision and practice"
                    },
                    {
                      href: "/take-practice-theory-test",
                      text: "Take a practice theory test"
                    },
                    {
                      href: "https://www.safedrivingforlife.info/shop/product/official-dvsa-theory-test-kit-app-app",
                      text: "Theory and hazard perception test app"
                    }
                  ]
                }
              ]
            },
            {
              title: "Book and manage your theory test",
              contents: [
                {
                  type: "paragraph",
                  text: "You need a provisional driving licence to book your theory test."
                },
                {
                  type: "list",
                  style: "required",
                  contents: [
                    {
                      href: "/book-theory-test",
                      text: "Book your theory test",
                      context: "£23"
                    },
                    {
                      href: "/theory-test/what-to-take",
                      text: "What to take to your test"
                    },
                    {
                      href: "/change-theory-test",
                      text: "Change your theory test appointment"
                    },
                    {
                      href: "/check-theory-test",
                      text: "Check your theory test appointment details"
                    },
                    {
                      href: "/cancel-theory-test",
                      text: "Cancel your theory test"
                    }
                  ]
                }
              ]
            },
            {
              title: "Book and manage your driving test",
              contents: [
                {
                  type: "paragraph",
                  text: "You must pass your theory test before you can book your driving test."
                },
                {
                  type: "list",
                  style: "required",
                  contents: [
                    {
                      href: "/book-driving-test",
                      text: "Book your driving test",
                      context: "£62"
                    },
                    {
                      href: "/driving-test/what-to-take",
                      text: "What to take to your test"
                    },
                    {
                      href: "/change-driving-test",
                      text: "Change your driving test appointment"
                    },
                    {
                      href: "/check-driving-test",
                      text: "Check your driving test appointment details"
                    },
                    {
                      href: "/cancel-driving-test",
                      text: "Cancel your driving test"
                    }
                  ]
                }
              ]
            },
            {
              title: "When you pass",
              contents: [
                {
                  type: "paragraph",
                  text: "You can start driving as soon as you pass your driving test."
                },
                {
                  type: "paragraph",
                  text: "You must have an insurance policy that allows you to drive without supervision."
                },
                {
                  type: "list",
                  style: "required",
                  contents: [
                    {
                      href: "/pass-plus",
                      text: "Find out about Pass Plus training courses"
                    }
                  ]
                }
              ]
            }
          ]
        }
      },
      locale: "en",
      routes: [
        {
          path: "/learn-to-drive-a-car",
          type: "exact"
        }
      ]
    }

    Services.publishing_api.put_content(content_id, params)
    Services.publishing_api.publish(content_id)
  end
end
