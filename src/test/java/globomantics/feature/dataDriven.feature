@data @data-internal
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
            | name | description | price | categoryId | inStock |
            | "name1" | "description1" | "19.96" | "1" | true |
            | "name2" | "description2" | "19.97" | "1" | true |
            | "name3" | "description3" | "19.98" | "2" | false |
            | "name4" | "description4" | "19.99" | "2" | false |
