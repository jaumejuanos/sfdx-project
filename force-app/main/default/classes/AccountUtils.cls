public class AccountUtils {
    public static List<Account> accountsByState (String accstate) {
	List<Account> accountlist = [SELECT Id,Name FROM Account WHERE BillingState = :accstate];
	return accountlist; 
    }

}