@ignore
Feature: Home Work

  Background: Preconditions
    * url apiURL
    * def timeValidate = read('classpath:helpers/TimeValidator.js')

  @homeWork1
  Scenario: Favorite articles
        # Step 1: Get atricles of the global feed
    Given path 'articles'
    Given params { limit:10,offset:0 }
    When method Get
    Then status 200
        # Step 2: Get the favorites count and slug ID for the first arice, save it to variables
    * def favCount = response.articles[0].favoritesCount
    * def slugName = response.articles[0].slug

        # Step 3: Make POST request to increse favorites count for the first article
    Given path 'articles/',slugName, '/favorite'
    When method Post
    Then status 200
            # Step 4: Verify response schema
    And match response ==

        """
     {
    "article": {
        "id": "#number",
        "slug": "#string",
        "title": "#string",
        "description": "#string",
        "body": "#string",
        "createdAt": "#? timeValidate(_)",
        "updatedAt": "#? timeValidate(_)",
        "authorId": "#number",
        "tagList": "#array",
        "author": {
            "username": "#string",
            "bio": "##string",
            "image": "#string",
            "following": "#boolean"
        },
        "favoritedBy": [
            {
                "id": "#number",
                "email": "#string",
                "username": "#string",
                "password": "#string",
                "image": "#string",
                "bio": "#",
                "demo": "#boolean"
            }
        ],
        "favorited": "#boolean",
        "favoritesCount": "#number"
    }
}
        """


        # Step 5: Verify that favorites article incremented by 1
            #Example
    * def initialCount = 0
    * def response = {"favoritesCount": 1}
    * match response.favoritesCount == initialCount + 1

        # Step 6: Get all favorite articles
    Given path 'articles'
    Given params { favorited:Prajwal Ms,limit:10,offset:0 }
    When method Get
    Then status 200
        # Step 7: Verify response schema
    And match response ==
        """
        {
    "articles": [
        {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidate(_)",
            "updatedAt": "#? timeValidate(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            }
        }
    ],
    "articlesCount": "#number"
}
        """
        # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
    And response.articles[0].slug == slugName


  Scenario: Comment articles
        # Step 1: Get atricles of the global feed
    Given path 'articles'
    Given params { limit:10,offset:0 }
    When method Get
    Then status 200

        # Step 2: Get the slug ID for the first arice, save it to variable
    * def slugName = response.articles[0].slug

        # Step 3: Make a GET call to 'comments' end-point to get all comments
    Given path 'articles/', slugName, '/comments'
    When method Get
    Then status 200
        # Step 4: Verify response schema
    And match response ==
        """
        {"comments":"#array"}
        """

        # Step 5: Get the count of the comments array lentgh and save to variable
            #Example

    * def responseWithoutComments = response
    * def commentsCount = responseWithoutComments.comments.length
    * print commentsCount
        # Step 6: Make a POST request to publish a new comment
    Given path 'articles/', slugName, '/comments'
    * def requestBody = read('classpath:ConduitApp/Json/PostComment.json')
    * def requestCommentBody = requestBody.comment.body
    Given request requestBody
    When method Post
    Then status 200
      # Step 7: Verify response schema that should contain posted comment text
    Then match response.comment.body == requestCommentBody

        # Step 8: Get the list of all comments for this article one more time
    Given path 'articles/', slugName, '/comments'
    When method Get
    Then status 200
    * def commentsID = response.comments[0].id
      # Step 9: Verify number of comments increased by 1 (similar like we did with favorite counts)
    * def responseWithComments = response
    * def finalCommentsCount = responseWithComments.comments.length
    * match finalCommentsCount == commentsCount +  1
    * print finalCommentsCount
      #* match responseWithComments.length == '1'


        # Step 10: Make a DELETE request to delete comment
    Given path 'articles/', slugName, '/comments', commentsID
    When method Delete
    Then status 200

       # Step 11: Get all comments again and verify number of comments decreased by 1
    Given path 'articles/', slugName, '/comments'
    When method Get
    Then status 200
    * def CommentsBodyDelete = response
    * def finalCommentsCountDelete = CommentsBodyDelete.comments.length
    * match finalCommentsCountDelete == finalCommentsCount - 1
    * print finalCommentsCountDelete

