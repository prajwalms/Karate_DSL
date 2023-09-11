@ignore
Feature: Test Home Page APIs
  Background: Define URL
    Given url 'https://conduit.productionready.io/api/'


  Scenario:
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['ipsum','cupiditate']
    And match response.tags contains any ['introduction', 'Dog', 'cat']
    And match response.tags == '#array'
    And match response.tags !contains ['Prajwal']
    And match each response.tags == '#string'

  Scenario:
    Given params { limit:10,offset:0 }
    Given path 'articles'
    * def isValidTime = read('classpath:helpers/TimeValidator.js')
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 210
    And match response.articles[*].favoritesCount contains 0
    And match response.articles[0].createdAt contains '2023'
    And match each response..favorited == false
    And match each response..favorited == '#boolean'
    And match each response..author.bio == '##string'
    And match each response.articles ==
    """
         {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? isValidTime(_)",
            "updatedAt": "#? isValidTime(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            }
         }
    """

    Scenario:
      Given params { limit:10,offset:0 }
      Given path 'articles'
      When method Get
      Then status 200
      * def favCount = response.articles[0].favoritesCount
      * def article = response.articles[0]
      #* if (favCount == 0) karate.call('classpath:helpers/AddLikes.feature',article)
      * def result = favCount == 0 ? karate.call('classpath:helpers/AddLikes.feature',article).updatedLikes:favCount

      Given params { limit:10,offset:0 }
      Given path 'articles'
      When method Get
      Then status 200
      And match response.articles[0].favoritesCount == result
      * print result

    Scenario: retry call
      * configure retry = { count: 10 ,interval: 5000}
      Given params { limit:10,offset:0 }
      Given path 'articles'
      And retry until response.articles[0].favoritesCount == 1
      When method Get
      Then status 200

     Scenario: sleep
       * def sleep = function(pause){ java.lang.Thread.sleep(pause) }
       Given params { limit:10,offset:0 }
       Given path 'articles'
       When method Get
       * eval sleep(10000)
       Then status 200


     Scenario: Number to String
       * def value = 10
       * def value2 = {"bar" : "#(value+'')"}
       * match value2 == {"bar" : '10'}

     Scenario: String to Number
       * def value = '10'
       * def value2 = {"bar" : "#(value*1)"}
       * def value3 = {"bar" : "#(parseInt(value))"}
       * match value2 == {"bar" : 10}
       * match value3 == {"bar" : 10}






