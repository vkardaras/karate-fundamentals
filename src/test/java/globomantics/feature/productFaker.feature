Feature: Create product with faker

    Background:
        * url apiUrl
        * def testDataGenerator = Java.type('helpers.TestDataGenerator')

        * def productRequestBody = read('classpath:globomantics/data/newProduct.json')
        * callonce read('classpath:helpers/productSchema.feature')

    Scenario: Create product 

        * def productName = testDataGenerator.getRandomProductName()
        * set productRequestBody.name = productName

        #    Create product
        Given path 'product'
        And header Content-Type = 'application/json'
        And request productRequestBody
        When method post
        Then status 200
        And match response.name == productName
        * def productId = response.id
