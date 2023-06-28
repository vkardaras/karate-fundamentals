Feature: Video Game Database Test Script
  for API specifcation, see: https://www.videogamedb.uk/swagger-ui/index.html

  Background:
    * url 'https://videogamedb.uk/api/v2'

    # First comment
  Scenario: get all video games and then get the first game by id
    Given path 'videogame'
    When method get
    Then status 200

    * def firstGame = response[0]

    Given path 'videogame', firstGame.id
    When method get
    Then status 200

  Scenario: create a videogame 
    * def videoGame =
      """
        {
          "category": "Platform",
          "name": "Mario",
          "rating": "Mature",
          "releaseDate": "2012-05-04",
          "reviewScore": 85
        }
      """

    Given path 'videogame'
    And request videoGame
    When method post
    Then status 200

    * def id = response.id
    * print 'created id is: ', id  