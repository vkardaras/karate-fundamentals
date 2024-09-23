@debug
Feature: Test on the Globomantics Products API

    Background:
        * url apiUrl

        # * def tokenResponse = callonce read('classpath:helpers/authToken.feature')
        # * def token = tokenResponse.token

        * def productRequestBody = read('classpath:globomantics/data/newProduct.json')
        * callonce read('classpath:helpers/productSchema.feature')

    Scenario: Get all products
        Given path 'product'
        When method get
        Then status 200

        And match response[0].name == 'Vintage Minature Car'
        And match response[0].name == '#string'
        And match response[0].inStock == '#boolean'

        # Assert all names in json regardless of nesting
        And match each response..name == '#string'

        # Assert contains
        And match response[0].createdAt contains '2020'

        # Assert optional
        And match response[0].rating == '##number'

        # Schema validation
        And match each response == productSchema

    Scenario: Create and Delete product

        * def productName = 'Fast train'
        * set productRequestBody.name = productName   

        #    Create product
        Given path 'product'
        # And header Authorization = 'Bearer ' + token
        And header Content-Type = 'application/json'
        And request productRequestBody 
        When method post
        Then status 200
        And match response.name == productName
        * def productId = response.id

        #    Get single product
        Given path 'product', productId
        When method get
        Then status 200
        And match response.id == productId
        And match response.name == productName

        #    Delete product
        Given path 'product', productId
        # And header Authorization = 'Bearer ' + token
        And header Content-Type = 'application/json'
        When method delete
        Then status 200
        And match response == "Product: " + productName + " deleted successfully"

    Scenario: Query Parameters

        * def categoryId = '1'
        Given path 'product'
        And param category = categoryId
        When method get
        Then status 200
        And match each response contains { "categoryId": "1" }
        And match each response contains { "categoryId": #(categoryId) }
        And match each response..categoryId == categoryId
