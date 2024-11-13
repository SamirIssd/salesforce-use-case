global class Batch_ResetNbOfDeals implements Schedulable, Database.Batchable<sObject>{
    String query;
    global Batch_ResetNbOfDeals () {
        query = 'select Id, number_of_deals_received__c FROM Commercial_Team_Related_User__c';
        System.debug('Batch Query : ' + query);
        
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Commercial_Team_Related_User__c> scope) {
        for (Commercial_Team_Related_User__c ctu : scope) {
            ctu.number_of_deals_received__c = 0;
        }
        update scope;
    }

    global void finish(Database.BatchableContext BC) {
    }

    global void execute( SchedulableContext SC ) {
        Database.executeBatch( new Batch_ResetNbOfDeals(), 200);
    }
}