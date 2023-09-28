

class UserModal {
  int? userId;
  String? uniqueUserId;
  String? email;
  int? reminders;
  dynamic accountDeleteRequestedAt;
  NotificationManage? notificationManage;
  Auth? auth;

  UserModal({
    this.userId,
    this.uniqueUserId,
    this.email,
    this.reminders,
    this.accountDeleteRequestedAt,
    this.notificationManage,
    this.auth,
  });

  factory UserModal.fromJson(Map<String, dynamic> json) => UserModal(
    userId: json["user_id"],
    uniqueUserId: json["unique_user_id"],
    email: json["email"],
    reminders: json["reminders"],
    accountDeleteRequestedAt: json["account_delete_requested_at"],
    notificationManage: json["notification_manage"] == null ? null : NotificationManage.fromJson(json["notification_manage"]),
    auth: json["auth"] == null ? null : Auth.fromJson(json["auth"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "unique_user_id": uniqueUserId,
    "email": email,
    "reminders": reminders,
    "account_delete_requested_at": accountDeleteRequestedAt,
    "notification_manage": notificationManage?.toJson(),
    "auth": auth?.toJson(),
  };
}

class Auth {
  String? tokenType;
  int? expiresIn;
  String? accessToken;
  String? refreshToken;

  Auth({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
  });

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "token_type": tokenType,
    "expires_in": expiresIn,
    "access_token": accessToken,
    "refresh_token": refreshToken,
  };
}

class NotificationManage {
  int? userId;
  String? schedulePlanning;
  String? takeBreaks;
  String? noReminders;
  String? createBreakTimes;
  String? recommendations;

  NotificationManage({
    this.userId,
    this.schedulePlanning,
    this.takeBreaks,
    this.noReminders,
    this.createBreakTimes,
    this.recommendations,
  });

  factory NotificationManage.fromJson(Map<String, dynamic> json) => NotificationManage(
    userId: json["user_id"],
    schedulePlanning: json["schedule_planning"],
    takeBreaks: json["take_breaks"],
    noReminders: json["no_reminders"],
    createBreakTimes: json["create_break_times"],
    recommendations: json["recommendations"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "schedule_planning": schedulePlanning,
    "take_breaks": takeBreaks,
    "no_reminders": noReminders,
    "create_break_times": createBreakTimes,
    "recommendations": recommendations,
  };
}
