trigger UserTrigger on User (before update) {
    List<User> newList = Trigger.new;
    List<User> oldList = Trigger.old;
    Map<Id, User> newMap = Trigger.newMap;
    Map<Id, User> oldMap = Trigger.oldMap;

    List<User> listToUpdate = new List<User>();
    Map<Id, User> mapToUpdate = new Map<Id, User>();

    if(Trigger.isUpdate){
        for(User u : newList){
            if(!u.is_absent__c && u.is_absent__c != oldMap.get(u.Id).is_absent__c){
                mapToUpdate.put(u.Id, u);
            }
        }
        if(!mapToUpdate.isEmpty()){
            Users.updateUserNbOfDeals(mapToUpdate);
            mapToUpdate.clear();
        }
    }
    /*
    Some people/company might rather do this 'assignment logic' directly in the function Users.updateUserNbOfDeals
    OR in a trigger handler (as recommended by Salesforce)
    => but after some performance tests in my previous company,
    we concluded that doing it directly in the trigger is the most efficient and optimal way*/
}