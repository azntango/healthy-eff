Feature: Signing in

  As an employee
  So that I can access my workout information
  I want to log-in to my account

Background: users in database
  | email                       | password              | password_confirmation |    
  | 169.healthyeff@gmail.com    | 'northsidepotato'     | 'northsidepotato'     |

Scenario: Logging out
  Given I am signed in
  And I am on any page
  When I follow "Sign Out"
  Then I should be on the “Sign In” page

Scenario: Logging in with the correct credentials
  Given I am on the sign in page
  When I fill in my username and password
  And I press “Login”
  Then I should be logged in and at the home page

Scenario: Logging in with incorrect password
  Given I am on the sign in page
  When I fill in my username and the wrong password
  And I press “Login”
  Then I should not be logged in
  And I should be on the sign in page