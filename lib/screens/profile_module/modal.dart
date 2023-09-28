class ProfileModal {
  ProfileModal({required this.userID, required this.email,required this.myCart,required this.myFav,required this.password,required this.profileImage});

  ProfileModal.fromJson(Map<String, Object?> json)
      : this(
    userID: json['userId']! as String,
    email: json['email']! as String,
    myCart: json['myCart']! as List,
    myFav: json['myFav']! as List,
    password: json['password']! as String,
    profileImage: json['profileImage']! as String,
  );

  final String userID;
  final String email;
  final List myCart;
  final List myFav;
  final String password;
  final String profileImage;


  Map<String, Object?> toJson() {
    return {
      'userId': userID,
      'email': email,
      'myCart': myCart,
      'myFav': myFav,
      'password': password,
      'profileImage': profileImage,
    };
  }
}