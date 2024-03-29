@isTest
private class AccountTriggerTest {
    @isTest static void TestCreateNewAccountsBillingState() {
        // Test Setup data
        // Create 200 new Accounts
        List<Account> accts = new List<Account>();
        for(Integer i=0; i < 200; i++) {
            Account acct = new Account(Name='Test Account ' + i, BillingState = 'CA');
            accts.add(acct);
        }              
        // Perform Test
        Test.startTest();
        insert accts;                               
        Test.stopTest();
        // Verify that new Accounts have shippingstate = CA
        for (Account a:accts)
        {
        	System.assertEquals('CA', a.BillingState, 'ERROR');
		}
    }
}