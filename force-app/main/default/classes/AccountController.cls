public with sharing class AccountController {
  /**
   * This method is vulnerable to SOQL Injection
   * as the supplied user input is not being sanitized
   * and could be interpreted as part of que query
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsInjection(String searchValue) {
    String likeValue = '\'%' + searchValue + '%\'';
    String sec = 'Security';
    return (List<Account>) Database.query(
      'SELECT Name, AnnualRevenue, Industry FROM Account WHERE Type = :sec AND Name LIKE ' +
      likeValue +
      ' ORDER BY Name'
    );
  }

  /**
   * This method is vulnerable to SOQL Injection
   * as the supplied user input is not being sanitized
   * and could be interpreted as part of que query
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsInjection2(
    String searchValue
  ) {
    String filterValue = String.isEmpty(searchValue) ? '0' : searchValue;
    String sec = 'Security';
    return (List<Account>) Database.query(
      'SELECT Name, AnnualRevenue, Industry FROM Account WHERE Type = :sec AND NumberOfEmployees > ' +
      filterValue +
      ' ORDER BY Name'
    );
  }

  /**
   * In this method we prevent SOQL Injection
   * by making the query static
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsStaticQuery(
    String searchValue
  ) {
    String likeValue = '%' + searchValue + '%';
    return [
      SELECT Name, AnnualRevenue, Industry
      FROM Account
      WHERE Type = 'Security' AND Name LIKE :likeValue
      ORDER BY Name
    ];
  }

  /**
   * In this method we prevent SOQL Injection
   * by binding the using supplied input with :
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsVariableBinding(
    String searchValue
  ) {
    String likeValue = '%' + searchValue + '%';
    String sec = 'Security';
    return (List<Account>) Database.query(
      'SELECT Name, AnnualRevenue, Industry FROM Account WHERE Type = :sec AND Name LIKE :likeValue ORDER BY Name'
    );
  }

   /**
   * In this method we test the stripinaccessible feature :
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsStripped(
    String searchValue
  ) {
    String likeValue = '%' + searchValue + '%';
    String sec = 'Security';
    String soql = 'SELECT Name, AnnualRevenue, Industry, Type FROM Account WHERE Type = :sec AND (Name LIKE :likeValue OR Industry LIKE :likeValue OR Type LIKE :likeValue) ORDER BY Name';
    
    List<Account> acct=Database.query(soql);
    SObjectAccessDecision securityDecision = Security.stripInaccessible(AccessType.READABLE,Database.query(soql));
    if (securityDecision.getRemovedFields().size() > 0 )
    {
        return(securityDecision.getRecords());            
    }
    else
      {
        return (acct);
      }
  }

     /**
   * In this method we test the WITH_SECURITY_ENFORCED feature :
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsEnforced(
    String searchValue
  ) {
    String likeValue = '%' + searchValue + '%';
    String sec = 'Security';
    String soql = 'SELECT Name, AnnualRevenue, Industry, Type FROM Account WHERE Type = :sec AND (Name LIKE :likeValue OR Industry LIKE :likeValue OR Type LIKE :likeValue) WITH SECURITY_ENFORCED ORDER BY Name';
    
    List<Account> acct=Database.query(soql);
    return (acct);
  }
  /**
   * In this method we prevent SOQL Injection
   * by escaping single quotes - not safe in all cases!
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsEscaping(String searchValue) {
    String likeValue = '\'%' + String.escapeSingleQuotes(searchValue) + '%\'';
    String sec = 'Security';
    return (List<Account>) Database.query(
      'SELECT Name, AnnualRevenue, Industry FROM Account WHERE Type = :sec AND Name LIKE ' +
      likeValue +
      ' ORDER BY Name'
    );
  }

  /**
   * In this method we try to prevent SOQL Injection
   * by escaping single quotes - but this is one of the cases in which escaping
   * doesn't fix the problem
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsEscapingNotEffective(
    String searchValue
  ) {
    String sec = 'Security';
    String filterValue = String.isEmpty(searchValue)
      ? '0'
      : String.escapeSingleQuotes(searchValue);
    return (List<Account>) Database.query(
      'SELECT Name, AnnualRevenue, Industry FROM Account WHERE Type = :sec AND NumberOfEmployees > ' +
      filterValue +
      ' ORDER BY Name'
    );
  }

  /**
   * In this method we try to prevent SOQL Injection
   * by type casting
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsTypeCasting(
    String searchValue
  ) {
    Integer filterValue = String.isEmpty(searchValue)
      ? 0
      : Integer.valueOf(searchValue);
      String sec = 'Security';
    return (List<Account>) Database.query(
      'SELECT Name, AnnualRevenue, Industry FROM Account WHERE Type = :sec AND NumberOfEmployees > ' +
      filterValue +
      ' ORDER BY Name'
    );
  }

  /**
   * In this method we try to prevent SOQL Injection
   * by allow listing
   */
  @AuraEnabled(cacheable=true)
  public static List<Account> getFilteredAccountsAllowListing(
    String searchValue
  ) {
    Map<String, Integer> allowedValues = new Map<String, Integer>();
    allowedValues.put('100', 100);
    allowedValues.put('500', 500);
    allowedValues.put('1000', 1000);

    Integer filterValue = allowedValues.get(searchValue);
    String sec = 'Security';

    if (filterValue == null) {
      filterValue = 0;
    }
    return (List<Account>) Database.query(
      'SELECT Name, AnnualRevenue, Industry FROM Account WHERE Type = :sec AND NumberOfEmployees > ' +
      filterValue +
      ' ORDER BY Name'
    );
  }

  @AuraEnabled
  public static Account createAccount() {
    Account acct = new Account();
    acct.Name = 'Cruzcampo';
    acct.AnnualRevenue = 1000000;
    acct.Industry = 'Food & Beverage';
    acct.Type = 'Security';

    insert acct;

    return acct;
  }
}