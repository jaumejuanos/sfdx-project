@isTest
public class AddPrimaryContactTest {
	@testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
        // add 50 CA accounts
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(Name='Test Account'+i,BillingState='CA'));
        }
        // add 50 NY accounts
        for (Integer j = 0; j < 50; j++) {
            accounts.add(new Account(Name='Test Account'+j,BillingState='NY'));
        }
        insert accounts;
	}
    static testmethod void testQueueable() {
        Contact co = new Contact();
        co.FirstName='demo';
        co.LastName ='demo';
        insert co;
        String state = 'CA';
        // Create our Queueable instance
        AddPrimaryContact creator = new AddPrimaryContact(co, state);
        // startTest/stopTest block to force async processes to run
        Test.startTest();        
        System.enqueueJob(creator);
        Test.stopTest();        
    }
}