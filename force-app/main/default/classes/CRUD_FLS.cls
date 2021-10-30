public class CRUD_FLS {
  /*    
  CRUD violation
  Account.sObjectType.getDescribe().isAccessible() 
  Account.sObjectType.getDescribe().isCreateable() 
  Account.sObjectType.getDescribe().isUpdateable() 
  Account.sObjectType.getDescribe().isDeleteable()

  FLS violation
  Schema.SObjectType.Account.fields.Name.isAccessible()
  Schema.SObjectType.Account.fields.Name.isUpdateable()
  Schema.SObjectType.Account.fields.Name.isCreateable()

  we validate if it complies
  if(Contact.SObjectType.getDescribe().isAccessible() && Schema.SObjectType.Contact.fields.Name.isAccessible()) {
    insert contacts;
  }

  We can also validate if it doesn't comply
  if(!Contact.SObjectType.getDescribe().isAccessible() && !Schema.SObjectType.Account.fields.Name.isCreateable()){
    return null;
  }
  */
}