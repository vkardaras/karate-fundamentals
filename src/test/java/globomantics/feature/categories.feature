Feature: Test on the Globomantics Categories API

  Background:
    * url apiUrl

    * def tokenResponse = callonce read('classpath:helpers/authToken.feature')

    * def token = tokenResponse.token

  Scenario: Get all categories
    Given path 'category'
    When method get
    Then status 200

  Scenario: Create, Update and Delete category

    * def categoryName = 'New Toys'
    * def categoryNameUpdated = 'Updated Toys'

#    Create category
    Given path 'category'
    And header Authorization = 'Bearer ' + token
    And header Content-Type = 'application/json'
    And request '{"name": "' + categoryName + '"}'
    When method post
    Then status 200
    And match response.name == categoryName
    * def categoryId = response.id
    
    Given path 'category', categoryId
    When method get
    Then status 200
    And match response.id == categoryId
    And match response.name == categoryName

#    Update category
    Given path 'category', categoryId
    And header Authorization = 'Bearer ' + token
    And header Content-Type = 'application/json'
    And request '{"name": "' + categoryNameUpdated + '"}'
    When method put
    Then status 200
    And match response.name == categoryNameUpdated

    Given path 'category', categoryId
    When method get
    Then status 200
    And match response.id == categoryId
    And match response.name == categoryNameUpdated

#    Delete category
    Given path 'category', categoryId
    And header Authorization = 'Bearer ' + token
    And header Content-Type = 'application/json'
    When method delete
    Then status 200
    And match response == "Category: " + categoryNameUpdated + " deleted successfully" 

