public with sharing class LWGC001_ReassignDeal {
    @AuraEnabled
    public static void reassignLead(String leadId){
        Lead l = [SELECT Id, commercial_team_name__c, OwnerId FROM Lead WHERE Id =: leadId LIMIT 1];
        
        // Retrieve the commercial team associated to the Lead
        List<Commercial_Team_Related_User__c> listCTU = 
        [SELECT Id, number_of_deals_received__c, user__c FROM Commercial_Team_Related_User__c 
        WHERE commercial_team_name__c =: l.commercial_team_name__c AND user__c !=: l.OwnerId AND user_is_available__c = true ORDER BY number_of_deals_received__c ASC];
        
        //Assign the new lead owner and increment the deal counter of the user
        if(!listCTU.isEmpty()){
            l.OwnerId = listCTU[0].user__c;
            listCTU[0].number_of_deals_received__c = listCTU[0].number_of_deals_received__c + 1;
            update l;
            update listCTU[0];
        }
        else{
            throw new AuraHandledException('No available users to assign to this deal');
        }
    }

    @AuraEnabled
    public static void reassignOpp(String oppId){
        Opportunity opp = [SELECT Id, commercial_team_name__c, OwnerId FROM Opportunity WHERE Id =: oppId LIMIT 1];
        
        // Retrieve the commercial team associated to the Lead
        List<Commercial_Team_Related_User__c> listCTU = 
        [SELECT Id, number_of_deals_received__c, user__c FROM Commercial_Team_Related_User__c 
        WHERE commercial_team_name__c =: opp.commercial_team_name__c AND user__c !=: opp.OwnerId AND user_is_available__c = true ORDER BY number_of_deals_received__c ASC];
        
        //Assign the new opportunity owner and increment the deal counter of the user
        if(!listCTU.isEmpty()){
            opp.OwnerId = listCTU[0].user__c;
            listCTU[0].number_of_deals_received__c = listCTU[0].number_of_deals_received__c + 1;
            update opp;
            update listCTU[0];
        }
        else{
            throw new AuraHandledException('No available users to assign to this deal');
        }
    }
}