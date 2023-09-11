Feature:
  Scenario:
    Given url apiURL
    Given path 'users/login'
    And request {"user":{"email":"#(userEmail)","password":"#(userPass)"}}
    Then method Post
    When status 200
    * def authtoken = response.user.token