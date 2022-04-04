Feature: Version

Scenario: Print version
    Given servicegwc
    And timeout 5 seconds
    When servicegwc run with argument(s) `--version`
    Then exit code 0
    And output contains 'servicegwc, version [\d.\d.\d]'
