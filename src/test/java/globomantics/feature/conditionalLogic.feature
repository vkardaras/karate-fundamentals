Feature: Test Conditional Hooks

    Background:

        * url apiUrl

    Scenario: Get single category

        Given path 'category', 1
        When method get
        Then status 200

        * def slug = response.slug
        * if (slug == 'babies-toys') karate.log('Slug is babies-toys')
        * def checkSlug = slug == 'babies-toys' ? 'Slug is expected' : 'NOT expected'
        * print checkSlug

        * if (responseStatus == 200) karate.call('classpath:helpers/PrintMessage.feature')
