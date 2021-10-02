@isTest
public class AccConDataFactory {
    public static List<Account> createAccountsWithContacts(Integer numAccts, Integer numConPerAcct) {
        List<Account> accts = new List<Account>();
        
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;
        
        List<Contact> cons = new List<Contact>();
        for (Integer j=0;j<numAccts;j++) {
            Account acct = accts[j];
            // For each account just inserted, add contacts
            for (Integer k=0;k<numConPerAcct;k++) {
                cons.add(new Contact(LastName=acct.Name + ' LastName ' + k,FirstName=acct.Name + ' FirstName ' + k,

                                       AccountId=acct.Id));
            }
        }
        // Insert all contacts for all accounts.
        insert cons;
        
        return accts;
    }
}