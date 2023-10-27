public with sharing class LoginEventMonitoringHandler {
    public static List<LoginEvent> getLoginEvents() {
        return [SELECT Username,SourceIP,Country,City FROM LoginEvent where EventDate = Today];
        }
    }