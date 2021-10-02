public class NewCaseListController {
  
	public List<case> getNewCases() 
    {
        List<Case> results = [SELECT Id, CaseNumber FROM Case WHERE Status = 'New'];
        
    return results;
    }    
}