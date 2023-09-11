Feature: Dummy

  Scenario: Dummy data
    * def randomData = Java.type('helpers.DataGenerator')
    * def userName = randomData.generateRandomUserName()
    * print userName