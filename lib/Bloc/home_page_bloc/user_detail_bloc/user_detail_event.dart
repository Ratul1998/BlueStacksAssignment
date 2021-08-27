abstract class UserDetailEvent{}

class FetchingUserData extends UserDetailEvent{}

class ChangeUserName extends UserDetailEvent{

  String userName;

  ChangeUserName({this.userName});

}

class UserTextFieldVisible extends UserDetailEvent{

  bool visible;

  UserTextFieldVisible({this.visible});

}
