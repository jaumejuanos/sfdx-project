global class DailyLeadProcessor implements Schedulable 
{
    global void execute(SchedulableContext ctx) 
    {
        List<Lead> LstLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = null LIMIT 200];
        // process lead records to do awesome stuff
        for (Lead ld : LstLeads) 
        {
                ld.LeadSource = 'Dreamforce';
        }
        update LstLeads;
    }
}