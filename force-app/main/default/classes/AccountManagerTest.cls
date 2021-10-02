@IsTest
private class AccountManagerTest 
{
	@isTest static void testGetAccount() 
    {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = 'https://appbuilderjaume-dev-ed.my.salesforce.com/services/apexrest/Accounts/'+recordId+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('Test Account James', thisAccount.Name);
    }
        // Helper method
    	static Id createTestRecord() 
        {
            // Create test record
            Account accTest = new Account(Name='Test Account James');
            insert accTest;
            Contact conTest = new Contact(LastName = 'Test Contact James',AccountId = accTest.Id);
	        insert conTest;
            return accTest.Id;
    }
}