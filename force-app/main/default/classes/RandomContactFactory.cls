public class RandomContactFactory 
{
 	public static List<Contact> GenerateRandomContacts(Integer numCon, String LastNameContact) 
 	{
     List<Contact> cons = new List<Contact>();
            for(Integer i=0;i<numCon;i++) 
            {
            	Contact c = new Contact(LastName='Test' + i,FirstName='First' + i);
            	cons.add(c);
        	}
        insert cons;
        
        return cons;

 }
}