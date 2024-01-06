public class QueryContact {
    public static Id getContactID(String lastName, String title) {
      try {
        Contact myContact = Database.query(
          'SELECT ID FROM Contact WHERE lastName = :lastName AND title = :title LIMIT 1'
        );
        return myContact.Id;
      } catch (Exception ex) {
        return null;
      }
    }
    public static Id getContactIDWithBinds(Map<String, Object> bindVars) {
      //do not modify any code above this line
      //implement the logic that will use bindVars to retrieve the contact's ID
      Id contactId = null;

      try {
        String queryStr = 'SELECT ID FROM Contact WHERE lastName = :lastName AND title = :title LIMIT 1';
        List<Contact> contacts = Database.queryWithBinds(queryStr, bindVars, AccessLevel.USER_MODE);
        if (contacts.size() > 0) {
            contactId = contacts[0].Id;
        }
      } catch (Exception ex) {
          system.debug(ex);
      }
    return contactId;
    }
}