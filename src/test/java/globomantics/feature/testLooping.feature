Feature: Test Looping

    Background:

        * url apiUrl

    Scenario: Get categories

        Given path 'category'
        When method get
        Then status 200

        # And match response[0].name == 'Vintage Minature Car'
        * def fun = 
        """
            function() {
                for (var i=0; i<response.length; i++) {
                    karate.log('Loop interation: ' + i); 
                    karate.log('Loop interation: ' + response[i].id); 
                    karate.call('classpath:helpers/PrintMessageWithParam.feature', { param: response[i].name})
                }    
            }
        """

        * call fun
