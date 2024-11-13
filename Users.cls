public with sharing class Users {
    //Update nb of deals to the maximum when user is back from holidays
    public static void updateUserNbOfDeals(Map<Id, User> mapUsers){
        List<Commercial_Team_Related_User__c> listCTU = [SELECT Id, number_of_deals_received__c, maximum_nb_of_deals_received__c 
        FROM Commercial_Team_Related_User__c WHERE user__c IN :mapUsers.keySet()];
        
        //Update the value of the triggering users to the max of their teams
        for(Commercial_Team_Related_User__c ctu : listCTU){
            ctu.number_of_deals_received__c = ctu.maximum_nb_of_deals_received__c;
        }
        update listCTU;
    }
}