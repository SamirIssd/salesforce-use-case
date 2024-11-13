public with sharing class TestDataFactory {
    public static user createUser(String profileName) {
        String nickname = String.valueOf(math.random());
        User  newUser = new User(
            Alias = nickname.right(5),
            Email = nickname + '@test123.com',
            CommunityNickName = nickname,
            EmailEncodingKey = 'UTF-8',
            LastName = nickname,
            FirstName = '',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = nickname + '@test.null',
            UserPermissionsInteractionUser = true,
            Profile = new Profile(Name = profileName)
        );
        insert newUser;
        return newUser;
    }
}