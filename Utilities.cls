public with sharing class Utilities {
    public static Map<String, Commercial_Team_Related_User__c> getCommercialTeamMap(List<String> listCTName){
        //Retrieve the commercial teams related to the leads
        List<Commercial_Team_Related_User__c> listCTUsers = 
        [SELECT Id, user__c, number_of_deals_received__c, commercial_team_name__c FROM Commercial_Team_Related_User__c 
        WHERE commercial_team_name__c =: listCTName AND user_is_available__c = true];
        
        Map<String, Commercial_Team_Related_User__c> mapUserAssignment = new Map<String,Commercial_Team_Related_User__c>();
        
        //Find the user with the least number of deals
        for(Commercial_Team_Related_User__c ctu : listCTUsers){
                Commercial_Team_Related_User__c oldCtu = mapUserAssignment.get(ctu.commercial_team_name__c);
                if(oldCtu == null || ctu.number_of_deals_received__c < oldCtu.number_of_deals_received__c){
                    mapUserAssignment.put(ctu.commercial_team_name__c, ctu);
                }
        }
        return mapUserAssignment;
    }
}