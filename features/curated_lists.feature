Feature: Curated lists
  As a content designer
  I want to curate groups of content for a specialist subsector browse page
  So that it is easier for users to find the content they need

  Scenario: Curating a tag
    Given a number of content items tagged to a specialist sector
    When I arrange the content of that specialist sector into lists
    Then the content should be in the correct lists in the correct order

  Scenario: Highlighting untagged content
    Given there is curated content which has been untagged
    Then the untagged content should be excluded from the curated lists
    And the untagged content should be highlighted as such