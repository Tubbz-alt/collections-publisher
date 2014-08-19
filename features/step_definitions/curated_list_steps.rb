Given(/^a number of content items tagged to a specialist sector$/) do
  stub_live_specialist_sectors(
    parent: {slug: 'oil-and-gas', title: 'Oil and Gas'},
    sectors: [
      {slug: 'oil-and-gas/offshore', title: 'Offshore'}
    ],
    content: {
      'oil-and-gas/offshore' => [
        'oil-rig-safety-requirements',
        'oil-rig-staffing',
        'north-sea-shipping-lanes',
        'undersea-piping-restrictions'
      ]
    }
  )
end

When(/^I arrange the content of that specialist sector into lists$/) do
  curate_list(
    sector_name: 'Offshore',
    list_name: 'Oil rigs',
    content: [
      'oil-rig-safety-requirements',
      'oil-rig-staffing'
    ]
  )

  curate_list(
    sector_name: 'Offshore',
    list_name: 'Piping',
    content: [
      'undersea-piping-restrictions'
    ]
  )
end

Then(/^the content should be in the correct lists in the correct order$/) do
  check_for_list_with_content(
    sector_name: 'Offshore',
    list_name: 'Oil rigs',
    content: [
      'oil-rig-safety-requirements',
      'oil-rig-staffing'
    ]
  )

  check_for_list_with_content(
    sector_name: 'Offshore',
    list_name: 'Piping',
    content: [
      'undersea-piping-restrictions'
    ]
  )

  check_for_list_with_content(
    sector_name: 'Offshore',
    list_name: 'Uncategorized (A to Z)',
    content: [
      'north-sea-shipping-lanes'
    ]
  )
end

Given(/^there is curated content which has been untagged$/) do
  stub_live_specialist_sectors(
    parent: {slug: 'oil-and-gas', title: 'Oil and Gas'},
    sectors: [
      {slug: 'oil-and-gas/offshore', title: 'Offshore'}
    ],
    content: {
      'oil-and-gas/offshore' => [
        'oil-rig-safety-requirements',
        'north-sea-shipping-lanes',
        'undersea-piping-restrictions'
      ]
    }
  )

  create_list(name: 'Oil rigs', sector: 'oil-and-gas/offshore', content: [
    'oil-rig-safety-requirements',
    'oil-rig-staffing'
  ])
end

Then(/^the untagged content should be excluded from the curated lists$/) do
  check_for_list_without_content(
    sector_name: 'Offshore',
    list_name: 'Oil rigs',
    content: [
      'oil-rig-staffing'
    ]
  )
end

Then(/^the untagged content should be highlighted as such$/) do
  check_for_untagged_content(sector_name: 'Offshore', content: ['oil-rig-staffing'])
end