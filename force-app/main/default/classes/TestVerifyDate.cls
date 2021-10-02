@isTest
Private class TestVerifyDate {
    @isTest static void testCheckDatesWithin() {
        date testdate1 = Date.newInstance(2019, 12, 5);
        date testdate2 = Date.newInstance(2019, 12, 9);
        date testdate3 = VerifyDate.CheckDates(testdate1,testdate2);
        System.assertEquals(testdate2, testdate3);
    }
    @isTest static void testCheckDatesOut() {
        date testdate1 = Date.newInstance(2019, 11, 5);
        date testdate2 = Date.newInstance(2019, 12, 9);
        date testdate3 = Date.newInstance(2019, 11, 30);
        date testdate4 = VerifyDate.CheckDates(testdate1,testdate2);
        System.assertEquals(testdate3, testdate4);
    }    
    
}