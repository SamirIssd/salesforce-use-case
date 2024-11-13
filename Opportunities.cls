public with sharing class Opportunities {
    public static void assignOpps(List<Opportunity> listOpps){
        List<String> listCTName = new List<String>();
        for(Opportunity opp : listOpps){
            listCTName.add(opp.commercial_team_name__c);
        }
        
        Map<String, Commercial_Team_Related_User__c> mapUserAssignment = Utilities.getCommercialTeamMap(listCTName);

        // Assign the opportunities to the user & prepare a list of users (nb of deals) to update
        Commercial_Team_Related_User__c relatedUser;
        List<Id> listUsersToUpdate = new List<Id>();
        for(Opportunity opp : listOpps){
            relatedUser = mapUserAssignment.get(opp.commercial_team_name__c);
            opp.ownerId = relatedUser.user__c;
            relatedUser.number_of_deals_received__c = relatedUser.number_of_deals_received__c + 1;
        }
        update mapUserAssignment.values();
    }
}