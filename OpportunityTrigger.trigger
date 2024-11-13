trigger OpportunityTrigger on Opportunity (before insert, before update) {
    List<Opportunity> newList = Trigger.new;
    List<Opportunity> oldList = Trigger.old;
    Map<Id, Opportunity> newMap = Trigger.newMap;
    Map<Id, Opportunity> oldMap = Trigger.oldMap;

    List<Opportunity> listToUpdate = new List<Opportunity>();
    List<Opportunity> oldListToUpdate = new List<Opportunity>();

    if(Trigger.isInsert){
        Opportunities.assignOpps(newList);
    }
}