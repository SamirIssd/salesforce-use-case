@isTest
public with sharing class LeadsTest {
    @isTest
    static void assignLeadsTest(){
        Test.startTest();
        User u1 = TestDataFactory.createUser('Standard User');
        User u2 = TestDataFactory.createUser('Standard User');
        String product = 'Meal Voucher';
        String employeeRange = '1 - 100';
        String countryCode = 'FR';
        Commercial_Team__c ct = new Commercial_Team__c(product_interest__c = product, employee_range__c = employeeRange, country_code__c = countryCode, Name = 'Meal Voucher FR 1-100');
        insert ct;
        Commercial_Team_Related_User__c ctu1 = new Commercial_Team_Related_User__c(
            Name = 'CT User 1',
            user__c = u1.Id,
            commercial_team__c = ct.Id
        );
        Commercial_Team_Related_User__c ctu2 = new Commercial_Team_Related_User__c(
            Name = 'CT User 2',
            user__c = u2.Id,
            commercial_team__c = ct.Id,
            number_of_deals_received__c = 3
        );
        insert new List<Commercial_Team_Related_User__c> { ctu1, ctu2 };
        //In this scenario all leads should go to USER 1
        Lead lead1 = new Lead(
            LastName = 'Lead 1',
            Company = 'Company 1',
            product_interest__c = product, 
            employee_range__c = employeeRange, 
            country_code__c = countryCode
        );
        Lead lead2 = new Lead(
            LastName = 'Lead 2',
            Company = 'Company 2',
            product_interest__c = product, 
            employee_range__c = employeeRange, 
            country_code__c = countryCode
        );
        insert new List<Lead> { lead1, lead2 };

        // Check that user number of deals is correctly incremented
        Commercial_Team_Related_User__c updatedCTUser = [SELECT number_of_deals_received__c FROM Commercial_Team_Related_User__c WHERE Id = :ctu1.Id];
        System.assertEquals(2, updatedCTUser.number_of_deals_received__c, 'Number of deals should be incremented by 2'); 
        Test.stopTest();
    }
}