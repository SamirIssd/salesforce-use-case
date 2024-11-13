trigger LeadTrigger on Lead (before insert, before update) {
    List<Lead> newList = Trigger.new;
    List<Lead> oldList = Trigger.old;
    Map<Id, Lead> newMap = Trigger.newMap;
    Map<Id, Lead> oldMap = Trigger.oldMap;

    List<Lead> listToUpdate = new List<Lead>();
    List<Lead> oldListToUpdate = new List<Lead>();

    if(Trigger.isInsert){
        Leads.assignLeads(newList);
    }
}