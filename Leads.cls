public with sharing class Leads {
    public static void assignLeads(List<Lead> listLeads){
        List<String> listCTName = new List<String>();
        for(Lead l : listLeads){
            listCTName.add(l.commercial_team_name__c);
        }
        //Retrieve the commercial teams related to the leads
        Map<String, Commercial_Team_Related_User__c> mapUserAssignment = Utilities.getCommercialTeamMap(listCTName);

        // Assign the leads to the user & prepare a list of users (nb of deals) to update
        Commercial_Team_Related_User__c relatedUser;
        for(Lead l : listLeads){
            relatedUser = mapUserAssignment.get(l.commercial_team_name__c);
            l.ownerId = relatedUser.user__c;
            relatedUser.number_of_deals_received__c = relatedUser.number_of_deals_received__c + 1;
        }
        update mapUserAssignment.values();
    }
}