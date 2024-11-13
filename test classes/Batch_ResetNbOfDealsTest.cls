@isTest
public with sharing class Batch_ResetNbOfDealsTest {
    @isTest
    public static void testBatch() {
        Test.startTest();
        User u1 = TestDataFactory.createUser('Standard User');
        String product = 'Meal Voucher';
        String employeeRange = '1 - 100';
        String countryCode = 'FR';
        Commercial_Team__c ct = new Commercial_Team__c(product_interest__c = product, employee_range__c = employeeRange, country_code__c = countryCode, Name = 'Meal Voucher FR 1-100');
        insert ct;
        Commercial_Team_Related_User__c ctu1 = new Commercial_Team_Related_User__c(
            Name = 'CT User 1',
            user__c = u1.Id,
            commercial_team__c = ct.Id,
            number_of_deals_received__c = 3
        );
        insert ctu1;
        
        Database.executeBatch(new Batch_ResetNbOfDeals());
        Test.stopTest();
        Commercial_Team_Related_User__c updatedCTUser = [SELECT number_of_deals_received__c FROM Commercial_Team_Related_User__c WHERE Id = :ctu1.Id];
        System.assertEquals(0, updatedCTUser.number_of_deals_received__c, 'Number of deals should be reset to 0.'); 
    }
}