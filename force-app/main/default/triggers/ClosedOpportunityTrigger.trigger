trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
	List<Task> TaskList = new List<Task>();
    
    for(Opportunity opp : Trigger.New) 
        {
        	if(opp.StageName=='Closed Won')
            {
                TaskList.add(new Task(Subject='Follow Up Test Task', WhatId=opp.Id));
            }
    	}
    if (TaskList.size() > 0) {
        insert TaskList;
    }
}