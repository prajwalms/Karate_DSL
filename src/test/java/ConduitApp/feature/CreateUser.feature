Feature: Create User Registration

  Background: Pre condition
    Given url apiURL
    * def randomData = Java.type('helpers.DataGenerator')
    * def randomEmail = randomData.generateRandomEmail()
    * def randomUserName = randomData.generateRandomUserName()


  Scenario: Create User
    Given path 'users'
    And request
    """
   {
    "user": {
        "email": "#(randomEmail)",
        "password": "Prajwaltest",
        "username": "#(randomUserName)"
    }
}
    """
    When method Post
    Then status 201
    And match response ==
    """
    {
    "user": {
        "email": "#(randomEmail)",
        "username": "#(randomUserName)",
        "bio": null,
        "image": "#string",
        "token": "#string"
    }
}
    """
  @user
    Scenario Outline: Validate error messages


    * def randomemail = "#(randomEmail)"
    * def randomuserName = "#(randomUserName)"
      Given path 'users'
      And request
    """
   {
    "user": {
        "email": "<email>",
        "password": "<password>",
        "username": "<username>"
    }
}
    """
      When method Post
      Then status 422
      And match response == errorMSG
       Examples:
       |email                   |password   |username           |errorMSG!                                                                              |
       |prajwaltest2322gmail.com|Prajwaltest|PrajwalTest122423  |{"errors":{"email":["has already been taken"],"username":["has already been taken"]}} |
       |prajwaltest2322gmail.com|Prajwaltest|randomemail     |{"errors":{"email":["has already been taken"]}}|
       |randomemail             |Prajwaltest|PrajwalTest122423  |{"errors":{"username":["has already been taken"]}}|
       |                        |Prajwaltest|PrajwalTest122423  |{"errors":{"email":["can't be blank"]}}|
       |prajwaltest2322gmail.com|           |PrajwalTest122423  |{"errors":{"password":["can't be blank"]}}|
       |prajwaltest2322gmail.com|Prajwaltest|                   |{"errors":{"username":["can't be blank"]}}|



