@isTest
private class TestRestrictContactByName {
    @isTest static void TestContactInvalidName(){
        // Test data setup
        // Create an account with an opportunity, and then try to delete it
        Contact ct = new Contact(LastName='INVALIDNAME');
        insert ct;
        
        // Perform test
        Test.startTest();
        Database.DeleteResult result = Database.delete(ct, false);
        Test.stopTest();   
        // Verify 
        // In this case the deletion should have been stopped by the trigger,
        // so verify that we got back an error.
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Cannot insert contact with invalid Last Name.',
                             result.getErrors()[0].getMessage());        
    }
}