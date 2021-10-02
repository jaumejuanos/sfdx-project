@isTest
private class AnimalLocatorTest 
{
    @isTest static void testGetCalloutAnimalLocator() 
    {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
        // This causes a fake response to be sent from the class that implements HttpCalloutMock. 
        String result = AnimalLocator.getAnimalNameById(1);
        String expectedresult = 'chicken';
        System.assertEquals(result, expectedresult);
    }    
}