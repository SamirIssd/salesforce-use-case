@isTest
public with sharing class UsersTest {

    @isTest
    static void updateUserNbOfDealsTest(){
        Test.startTest();
        User u1 = TestDataFactory.createUser('Standard User');
        u1.is_absent__c = true;
        update u1;
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
        u1.is_absent__c = false;
        update u1;

        // Check that user number of deals is correctly incremented
        Commercial_Team_Related_User__c updatedCTUser = [SELECT number_of_deals_received__c FROM Commercial_Team_Related_User__c WHERE Id = :ctu1.Id];
        System.assertEquals(3, updatedCTUser.number_of_deals_received__c, 'Number of deals was not reset to the highest value when user is no longer absent.'); 
        Test.stopTest();
    }
}