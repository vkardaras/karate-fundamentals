@data @data-csv
Feature: Data Driven Testing from CSV

    Background:

        * url apiUrl

    Scenario Outline: Create products - <name>

        Given path 'product'
        And header Content-Type = 'application/json'

        And request
        """
        {
            "name": <name>,
            "description": <description>,
            "price": <price>,
            "categoryId": <categoryId>,
            "inStock": <inStock>
        }
        """
        When method post
        Then status 200

        Examples:
            | read('classpath:globomantics/data/products.csv') |
