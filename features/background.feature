Feature: backgrounds
  In order to provide a context to my scenarios within a feature
  As a feature editor
  I want to write a background section in my features.

  Scenario: run a specific scenario with a background
    When I run cucumber -q features/passing_background.feature:9
    Then it should pass with
    """
    Feature: Passing background sample
    
      Background: 
        Given '10' cukes

      Scenario: another passing background
        Then I should have '10' cukes

    1 scenario
    2 steps passed
    
    """
  
  Scenario: run a feature with a background that passes
    When I run cucumber -q features/passing_background.feature
    Then it should pass with
    """
    Feature: Passing background sample

      Background: 
        Given '10' cukes

      Scenario: passing background
        Then I should have '10' cukes

      Scenario: another passing background
        Then I should have '10' cukes

    2 scenarios
    4 steps passed
    
    """

  Scenario: run a feature with scenario outlines that has a background that passes
    When I run cucumber -q features/scenario_outline_passing_background.feature
    Then it should pass with
    """
    Feature: Passing background with scenario outlines sample

      Background: 
        Given '10' cukes

      Scenario Outline: passing background
        Then I should have '<count>' cukes

      Examples: 
        | count |
        | 10    |

      Scenario Outline: another passing background
        Then I should have '<count>' cukes

      Examples: 
        | count |
        | 10    |

    2 scenarios
    4 steps passed

    """

  Scenario: run a feature with a background that fails
    When I run cucumber -q features/failing_background.feature
    Then it should fail with
    """
    Feature: Failing background sample

      Background: 
        Given failing without a table
          FAIL (RuntimeError)
          ./features/step_definitions/sample_steps.rb:2:in `/^failing without a table$/'
          features/failing_background.feature:4:in `Given failing without a table'

      Scenario: failing background
        Then I should have '10' cukes

      Scenario: another failing background
        Then I should have '10' cukes

    2 scenarios
    2 steps failed
    2 steps skipped

    """

  Scenario: run a feature with scenario outlines that has a background that fails
    When I run cucumber -q features/scenario_outline_failing_background.feature
    Then it should fail with
    """
    Feature: Failing background with scenario outlines sample

      Background: 
        Given failing without a table
          FAIL (RuntimeError)
          ./features/step_definitions/sample_steps.rb:2:in `/^failing without a table$/'
          features/scenario_outline_failing_background.feature:4:in `Given failing without a table'

      Scenario Outline: passing background
        Then I should have '<count>' cukes

      Examples: 
        | count |
        | 10    |

      Scenario Outline: another passing background
        Then I should have '<count>' cukes

      Examples: 
        | count |
        | 10    |

    2 scenarios
    2 steps failed
    2 steps skipped

    """

  Scenario: run a feature with a background that is pending
    When I run cucumber -q features/pending_background.feature
    Then it should pass with
    """
    Feature: Pending background sample

      Background: 
        Given pending

      Scenario: passing background
        Then I should have '10' cukes

      Scenario: another passing background
        Then I should have '10' cukes

    2 scenarios
    2 steps skipped
    2 steps undefined

    """

  Scenario: background passes with first scenario but fails with second
    When I run cucumber -q features/failing_background_after_success.feature
    Then it should fail with
    """
    Feature: Failing background after previously successful background sample

      Background: 
        Given passing without a table
        And '10' global cukes

      Scenario: passing background
        Then I should have '10' global cukes

      Background: 
        Given passing without a table
        And '10' global cukes
          FAIL (RuntimeError)
          ./features/step_definitions/sample_steps.rb:2:in `/^'(.+)' global cukes$/'
          features/failing_background_after_success.feature:3:in `And '10' global cukes'

      Scenario: another passing background
        Then I should have '10' global cukes

    2 scenarios
    1 step failed
    1 step skipped
    4 steps passed

    """

  Scenario: run a scenario showing explicit background steps --explicit-background
