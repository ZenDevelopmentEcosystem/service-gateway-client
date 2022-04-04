Feature: Help

Scenario: Print top help (long)
    Given servicegwc
    And timeout 5 seconds
    When servicegwc run with argument(s) `--help`
    Then exit code 0
    And output contains 'Usage'

Scenario: Print top help (short)
    Given servicegwc
    And timeout 5 seconds
    When servicegwc run with argument(s) `-h`
    Then exit code 0
    And output contains 'Usage'
