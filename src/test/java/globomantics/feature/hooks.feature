Feature: Test hooks

    Background:

        * url apiUrl
        * def productRequestBody = read('classpath:globomantics/data/newProduct.json')

        * def testData = call read('classpath:helpers/Hooks.feature')
        * def productName = testData.productName

        * configure afterScenario = function() { karate.log('Scenario complete') }

        * configure afterFeature = 
        """
        function() {
            karate.log('Feature completed')
            var testValue = 31
            karate.call('classpath:helpers/PrintMessage.feature')
        }
        """

    Scenario: Create product 

        * set productRequestBody.name = productName
        #    Create product
        Given path 'product'
        And header Content-Type = 'application/json'
        And request productRequestBody
        When method post
        Then status 200
