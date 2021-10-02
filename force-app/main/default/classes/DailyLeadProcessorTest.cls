@isTest
private class DailyLeadProcessorTest {
    // Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    static testmethod void testScheduledJob() 
    {
        // Create 200 Lead records
        List<Lead> LstLeads = new List<Lead>();
        // insert 200 leads
        for (Integer i=0;i<200;i++) 
        {
            LstLeads.add(new Lead(LastName='Lead Schedule '+i,FirstName='Lead FirstName '+i,Company='Hijos de Puta'));
        }
        insert LstLeads;
        
        // Get the IDs of the leads we just inserted
        Map<Id, Lead> leadMap = new Map<Id, Lead>(LstLeads);
        List<Id> LeadIds = new List<Id>(leadMap.keySet());
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',CRON_EXP,new DailyLeadProcessor());
        // Verify the scheduled job has not run yet.
        List<Task> lt = [SELECT Id FROM Task WHERE WhatId IN :LeadIds];
        System.assertEquals(0, lt.size(), 'Tasks exist before job has run');
        // Stopping the test will run the job synchronously
        Test.stopTest();
        
        // Now that the scheduled job has executed,
        // check that our tasks were created
        lt = [SELECT Id FROM Task WHERE WhatId IN :LeadIds];
        System.assertEquals(LeadIds.size(),lt.size(),'Tasks were not created');
    }    
}