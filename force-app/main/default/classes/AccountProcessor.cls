public class AccountProcessor {
	@future
  	public static void countContacts(List<Id> recordIds) {
    List<Account> LstAccounts = [select id,Number_of_Contacts__c , (select id from contacts ) from account where id in :recordIds];
    // process account records to do awesome stuff
    for( Account acc : LstAccounts )
      {
          List<Contact> ListCont = acc.contacts;
         
          acc.Number_of_Contacts__c = ListCont.size();
      }
      update LstAccounts;
  }
}