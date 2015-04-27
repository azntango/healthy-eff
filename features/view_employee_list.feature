Feature: View Employee List

  As an admin
  So that I can keep track of all employees logged activities for this month
  I want to see a display of all employees and the number of days they have logged activities for this month

Background:
  Given the following admins exist:
  | email                       | password              | password_confirmation | password_changed |
  | 169.healthyeff@gmail.com    | ?Northsidepotato169   | ?Northsidepotato169   | true             |
  And the following users exist:
  | email                      | password        | password_confirmation | password_changed |
  | healthypotato@gmail.com    | ?Hotpotato169   | ?Hotpotato169         | true             |

Scenario: Privileged access
  Given I am logged in as a non-admin
  Then I should not see the "Admin" link
  And I should not see the "Pending" link
  When I visit the admin list page
  Then I should be on the home page
  And I should see that I cannot access this page

Scenario: Admin list view - no records
  Given I am logged in as an admin
  When I follow "Admin"
  And I navigate to the next month
  Then I should see "No records"

Scenario: Admin list view - records
  Given Nick Herson has logged 3 activities
  And I am logged in as an admin
  When I follow "Admin"
  Then I should see a table of employee names
  And I should see "Days of Healthy Activity"
  And I should see "Pending"
