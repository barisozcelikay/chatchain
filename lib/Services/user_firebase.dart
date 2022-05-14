/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_encrypter/dart_encrypter.dart';
import 'package:epoder_pay/entities/helper.dart';
import 'package:epoder_pay/entities/measure.dart';

import 'package:logbox_color/extensions.dart';
import 'package:logbox_color/logbox_color.dart';

///User entity firebase class.
class UserFirebase {
  // Create a CollectionReference called users that references the firestore collection
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  ///Document ID
  late String documentID;

  /// UserFirebase debt.
  double userDebt = 0.0;

  /// UserFirebase Name.

  late String userName;

  /// UserFirebase Surname.

  late String userSurname;

  /// Person Code ID.

  late String userID;

  /// Person Pay Code.

  late String userPayCode;

  /// Person Access Code.

  late String userAccessCode;

  /// UserFirebase role.

  late UserType userType;

  /// UserFirebase Email

  late String userEmail;

  /// UserFirebase Phone

  late String userPhone;

  /// UserFirebase userInfo

  late String userInfo;

  /// UserFirebase userAcronym

  late String userAcronym;

  /// UserFirebase log access control key.
  late bool userCanLog;

  /// User join date.

  late DateTime userJoinDate;

  ///CSV Headers.
  static List<String> csvHeaders = [
    'userID',
    'userName',
    'userSurname',
    'userDebt',
    'userPayCode',
    'userType',
    'userAccessCode',
    'userLoginAllowance',
    'userEmail',
    'userPhone',
    'userInfo',
    'userJoinDate'
  ];

  /// UserFirebase classic constructor. [uname] is name, [sname] is surname,  [uID] is user id, [utype] is user role, [ucanlog] is user log control key, [debt] is user debt, [pcode] is pay code,  [acode] is access code, [mail] is user mail., [phn] is user userPhone, [uinfo] is user userInfo, [join] ia user join date.

  UserFirebase(
      String uname,
      String sname,
      String uID,
      UserType utype,
      bool ucanlog,
      double debt,
      String pcode,
      String acode,
      String mail,
      String phn,
      String uinfo,
      DateTime join) {
    userID = uID;
    userCanLog = ucanlog;
    userName = uname.toLowerCase();
    userSurname = sname.toLowerCase();
    userAcronym = '${uname.toLowerCase()} ${sname.toLowerCase()}'.createAcronym;
    userDebt = debt;
    userType = utype;
    userPayCode = pcode;
    userAccessCode = acode;
    userEmail = mail.toLowerCase();
    userPhone = phn;
    userInfo = uinfo;
    userJoinDate = join;
  }

  /// UserFirebase JSON constructor. [uname] is name, [sname] is surname, [uID] is user id, [utype] is user role, [debt] is user debt, [pcode] is pay code,  [acode] is access code,  [mail] is user mail,  [phn] is user userPhone, [uinfo] is user userInfo,[ujoin] is user join date, [docID] is Document ID, [ucanlog] is user log control key.
  UserFirebase.withDocumentID(
      String uname,
      String sname,
      String uID,
      UserType utype,
      double debt,
      String pcode,
      String acode,
      String mail,
      String phn,
      String uinfo,
      DateTime ujoin,
      String docID,
      bool ucanlog) {
    userID = uID;
    userName = uname;
    userSurname = sname;
    userAcronym =
        '${userName.decryptMyData(Helper.key, Helper.iv)} ${userSurname.decryptMyData(Helper.key, Helper.iv)}'
            .createAcronym;
    userDebt = debt;
    userType = utype;
    userPayCode = pcode;
    userAccessCode = acode;
    userEmail = mail;
    userPhone = phn;
    userInfo = uinfo;
    userJoinDate = ujoin;
    documentID = docID;
    userCanLog = ucanlog;
  }

  @override
  String toString() =>
      '[User --> Firebase Document ID: $documentID, Name: $userName, Surname: $userSurname, Acronym: $userAcronym, Person ID: $userID, User Type: $userType, User Debt: $userDebt ₺, Pay Code: $userPayCode, Access Code: $userAccessCode, Mail: $userEmail, Phone: $userPhone, Info: $userInfo, User Join Date: $userJoinDate, User Can Log? : $userCanLog]';

  /// To string decrypted.

  String toDecryptedString() =>
      '[User --> Firebase Document ID: $documentID, Name: ${userName.decryptMyData(Helper.key, Helper.iv)}, Surname: ${userSurname.decryptMyData(Helper.key, Helper.iv)}, Acronym: $userAcronym, Person ID: ${userID.decryptMyData(Helper.key, Helper.iv)}, User Type : $userType, UserFirebase Debt : $userDebt ₺, Pay Code: ${userPayCode.decryptMyData(Helper.key, Helper.iv)}, Access Code: ${userAccessCode.decryptMyData(Helper.key, Helper.iv)}, Mail: ${userEmail.decryptMyData(Helper.key, Helper.iv)}, Phone: ${userPhone.decryptMyData(Helper.key, Helper.iv)}, Info: ${userInfo.decryptMyData(Helper.key, Helper.iv)!}, User Join Date: $userJoinDate, User Can Log? : $userCanLog]';

  /// To JSON.
  Map toJson() => {
        'userName': userName,
        'userSurname': userSurname,
        'userAcronym': userAcronym,
        'userID': userID,
        'userType': userType.getStringFromUserType(),
        'userDebt': userDebt,
        'userPayCode': userPayCode,
        'userAccessCode': userAccessCode,
        'userEmail': userEmail,
        'userPhone': userPhone,
        'userInfo': userInfo,
        'userJoinDate': userJoinDate.toString(),
        'documentID': documentID,
        'userCanLog': userCanLog,
      };

  ///From JSON.
  factory UserFirebase.fromJson(dynamic json) {
    return UserFirebase.withDocumentID(
      json['userName'] as String,
      json['userSurname'] as String,
      json['userID'] as String,
      getUserTypeFromString(json['userType']),
      json['userDebt'] as double,
      json['userPayCode'] as String,
      json['userAccessCode'] as String,
      json['userEmail'] as String,
      json['userPhone'] as String,
      json['userInfo'] as String,
      DateTime.tryParse(json['userJoinDate'].toString())!,
      json['documentID'] as String,
      json['userCanLog'] as bool,
    );
  }

  ///Adds an user item to Firestore.
  /// [name] is name, [surname] is surname, [willHashID] is user id, [userType] is user role, [debt] is user debt, [paucode] is pay code, [acode] is access code, [mail] is UserFirebase me-mail, [userPhone] is user userPhone, [userInfo] is user userInfo, [userJoin] is uuser jon date, [userType] is user userType, [ucanlog] is user log control key.

  static Future<bool> addUserToDatabase(
      String name,
      String surname,
      String willHashID,
      double debt,
      String paycode,
      String acode,
      String mail,
      String userPhone,
      String userInfo,
      DateTime userJoin,
      UserType userType,
      bool ucanlog) async {
    try {
      if (name.isNotEmpty &&
          surname.isNotEmpty &&
          willHashID.isNotEmpty &&
          paycode.isNotEmpty &&
          acode.isNotEmpty &&
          mail.isNotEmpty &&
          userPhone.isNotEmpty &&
          userInfo.isNotEmpty) {
        Measure.validate();

        var checkUser = await getUserFromDatabase(
            willHashID.encryptMyData(Helper.key, Helper.iv)!,
            surname.toLowerCase().encryptMyData(Helper.key, Helper.iv)!,
            name.toLowerCase().encryptMyData(Helper.key, Helper.iv)!);

        var isIDUsable = await isIDAvailable(
            willHashID.encryptMyData(Helper.key, Helper.iv)!);
        if (isIDUsable! == true && checkUser == null) {
          var addInfo = await users.add({
            'UserName':
                '${name.toLowerCase().encryptMyData(Helper.key, Helper.iv)}',
            'UserSurname':
                '${surname.toLowerCase().encryptMyData(Helper.key, Helper.iv)}',
            'UserAcronym':
                '${name.toLowerCase()} ${surname.toLowerCase()}'.createAcronym,
            'UserID': '${willHashID.encryptMyData(Helper.key, Helper.iv)}',
            'UserType': userType.getStringFromUserType(),
            'UserDebt': debt,
            'UserPayCode': '${paycode.encryptMyData(Helper.key, Helper.iv)}',
            'UserAccessCode': '${acode.encryptMyData(Helper.key, Helper.iv)}',
            'UserEmail':
                '${mail.toLowerCase().encryptMyData(Helper.key, Helper.iv)}',
            'UserPhone': '${userPhone.encryptMyData(Helper.key, Helper.iv)}',
            'UserInfo': '${userInfo.encryptMyData(Helper.key, Helper.iv)}',
            'UserJoinDate': userJoin,
            'UserCanLog': ucanlog
          });

          if (addInfo.id.isNotEmpty) {
            // If the server did return a OK or 201 Created response,
            // then tryParse the result.
            var msValue = Measure.invalidate();
            printLog('User added successfully in $msValue ms.', LogLevel.debug);

            return true;
          }
        } else {
          // If the server did not return a OK response,
          // then throw an exception.
          throw Exception('User cannot be added.');
        }
      }

      Measure.invalidate();
      return false;
    } catch (e) {
      printLog('An error occurred while adding the user - $e.', LogLevel.error);
      Measure.invalidate();
      return false;
    }
  }

  ///Deletes an user item from Firestore.
  /// [idEncrypted] is UserFirebase's Encrypted  ID, [surnameEncrypted] is  encrypted user surname, [accessCodeEncrypted] is UserFirebase's encryptted access code.
  static Future<bool> deleteUserFromDatabase(String idEncrypted,
      String surnameEncrypted, String accessCodeEncrypted) async {
    try {
      if (idEncrypted.isNotEmpty &&
          surnameEncrypted.isNotEmpty &&
          accessCodeEncrypted.isNotEmpty) {
        {
          Measure.validate();

          var willDeleteUser = await getUserFromDatabase(
              idEncrypted, surnameEncrypted, accessCodeEncrypted);
          if (willDeleteUser != null) //User is found on firestore.
          {
            users.doc(willDeleteUser.documentID).delete(); // Delete it.
            var msValue = Measure.invalidate();
            printLog(
                'User deleted successfully in $msValue ms.', LogLevel.debug);
            return true;
          } else {
            // If the server did not return a OK response,
            // then throw an exception.
            throw Exception('User cannot be found.');
          }
        }
      }
      Measure.invalidate();
      return false;
    } catch (e) {
      printLog(
          'An error occurred while deleting the user - $e.', LogLevel.error);
      Measure.invalidate();
      return false;
    }
  }

  ///Updates an user item at Firestore.
  ///[willupdateUser] is will be UserFirebase item, [newName] is user name, [newSurname] is user surname, [newDebt] is amount of debt, [newType] id user userType, [newPayCode] is user pay code, newAccessCode is access code, [newEmail] is userEmail, [newPhone] is userPhone, [newInfo] is user info, [newJoin] is new user join date, [newLogAllow] is login kontrol key value.
  static Future<UserFirebase?> updateUserAtDatabase(
      UserFirebase willupdateUser,
      double newDebt,
      String newName,
      String newSurname,
      UserType newType,
      String newPayCode,
      String newAccessCode,
      String newEmail,
      String newPhone,
      String newInfo,
      DateTime newJoin,
      bool newLogAllow) async {
    try {
      if (willupdateUser.userID.isNotEmpty &&
          newName.isNotEmpty &&
          newSurname.isNotEmpty &&
          newPayCode.isNotEmpty &&
          newAccessCode.isNotEmpty &&
          newEmail.isNotEmpty &&
          newPhone.isNotEmpty &&
          newInfo.isNotEmpty) {
        Measure.validate();

        var newAcronym = '${newName.toLowerCase()} ${newSurname.toLowerCase()}'
            .createAcronym;

        var isUserAvailable = await getUserFromDatabase(willupdateUser.userID,
            willupdateUser.userSurname, willupdateUser.userAccessCode);
        if (isUserAvailable != null) //User is found on firestore.
        {
          await users.doc(willupdateUser.documentID).update({
            'UserName':
                '${newName.toLowerCase().encryptMyData(Helper.key, Helper.iv)}',
            'UserSurname':
                '${newSurname.toLowerCase().encryptMyData(Helper.key, Helper.iv)}',
            'UserAcronym': newAcronym,
            'UserID': willupdateUser.userID,
            'UserType': newType.getStringFromUserType(),
            'UserDebt': newDebt,
            'UserPayCode': '${newPayCode.encryptMyData(Helper.key, Helper.iv)}',
            'UserAccessCode':
                '${newAccessCode.encryptMyData(Helper.key, Helper.iv)}',
            'UserEmail':
                '${newEmail.toLowerCase().encryptMyData(Helper.key, Helper.iv)}',
            'UserPhone':
                '${newPhone.toLowerCase().encryptMyData(Helper.key, Helper.iv)}',
            'UserInfo': '${newInfo.encryptMyData(Helper.key, Helper.iv)}',
            'UserJoinDate': newJoin,
            'UserCanLog': newLogAllow
          });

          var updatedUser = UserFirebase.withDocumentID(
              '${newName.toLowerCase().encryptMyData(Helper.key, Helper.iv)}',
              '${newSurname.toLowerCase().encryptMyData(Helper.key, Helper.iv)}',
              willupdateUser.userID,
              newType,
              newDebt,
              '${newPayCode.encryptMyData(Helper.key, Helper.iv)}',
              '${newAccessCode.encryptMyData(Helper.key, Helper.iv)}',
              '${newEmail.toLowerCase().encryptMyData(Helper.key, Helper.iv)}',
              '${newPhone.toLowerCase().encryptMyData(Helper.key, Helper.iv)}',
              '${newInfo.encryptMyData(Helper.key, Helper.iv)}',
              newJoin,
              willupdateUser.documentID,
              newLogAllow);
          var msValue = Measure.invalidate();
          printLog('User updated successfully in $msValue ms.', LogLevel.debug);

          return updatedUser;
        } else {
          // If the server did not return a OK response,
          // then throw an exception.
          throw Exception('User cannot be updated.');
        }
      }
      Measure.invalidate();
      return null;
    } catch (e) {
      printLog(
          'An error occurred while updating the user - $e.', LogLevel.error);
      Measure.invalidate();
      return null;
    }
  }

  ///Gets an user item from Firestore
  ///[encryptedID] is UserFirebase's Encrypted TC ID, [encryptedSurname] is encrypted user surname, [encryptedAccessCode] is access code.
  static Future<UserFirebase?> getUserFromDatabase(String encryptedID,
      String encryptedSurname, String encryptedAccessCode) async {
    try {
      if (encryptedID.isNotEmpty &&
          encryptedSurname.isNotEmpty &&
          encryptedAccessCode.isNotEmpty) {
        Measure.validate();

        var fireUser = await users
            .where('UserID', isEqualTo: encryptedID)
            .where('UserSurname', isEqualTo: encryptedSurname)
            .where('UserAccessCode', isEqualTo: encryptedAccessCode)
            .get();

        if (fireUser.size != 0) {
          // then tryParse the JSON.
          var user = fireUser.docs[0].data() as Map;

          var returnUser = UserFirebase.withDocumentID(
              user['UserName'],
              user['UserSurname'],
              user['UserID'],
              getUserTypeFromString(user['UserType']),
              user['UserDebt'],
              user['UserPayCode'],
              user['UserAccessCode'],
              user['UserEmail'],
              user['UserPhone'],
              user['UserInfo'],
              DateTime.parse(
                  (user['UserJoinDate'] as Timestamp).toDate().toString()),
              fireUser.docs[0].id,
              user['UserCanLog']);

          var msValue = Measure.invalidate();
          printLog(
              'User fetched successfully: ${returnUser.toDecryptedString()} in $msValue ms.',
              LogLevel.debug);
          return returnUser;
        } else {
          // If the server did not return a OK response,
          // then throw an exception.
          throw Exception('User not found.');
        }
      }
      Measure.invalidate();
      return null;
    } catch (e) {
      printLog(
          'An error occurred while getting the user - $e.', LogLevel.error);
      Measure.invalidate();
      return null;
    }
  }

  ///Gets user item list from Firestore
  static Future<List<UserFirebase>?> getUsersFromDatabase() async {
    try {
      Measure.validate();

      var fireUser = await users.get();

      if (fireUser.size != 0) {
        // then tryParse the JSON.

        List<UserFirebase> users = [];

        // then tryParse the JSON.

        for (var item in fireUser.docs) {
          var user = item.data() as Map;

          var willaddedToList = UserFirebase.withDocumentID(
              user['UserName'],
              user['UserSurname'],
              user['UserID'],
              getUserTypeFromString(user['UserType']),
              user['UserDebt'],
              user['UserPayCode'],
              user['UserAccessCode'],
              user['UserEmail'],
              user['UserPhone'],
              user['UserInfo'],
              DateTime.parse(
                  (user['UserJoinDate'] as Timestamp).toDate().toString()),
              item.id,
              user['UserCanLog']);

          users.add(willaddedToList);
        }

        var msValue = Measure.invalidate();
        printLog('Users fetched successfully in $msValue ms.', LogLevel.debug);

        return users;
      } else {
        // If the server did not return a  OK response,
        // then throw an exception.
        throw Exception('Users not found.');
      }
    } catch (e) {
      printLog(
          'An error occurred while fetching the users - $e.', LogLevel.error);
      Measure.invalidate();
      return null;
    }
  }

  ///Checks an user item in Firestore.
  ///[encryptedID] is UserFirebase's Encrypted TC ID.
  static Future<String> getFullUserName(String encryptedID) async {
    try {
      if (encryptedID.isNotEmpty) {
        Measure.validate();

        var fireUser =
            await users.where('UserID', isEqualTo: encryptedID).get();

        if (fireUser.size != 0) {
          // then tryParse the JSON.
          var user = fireUser.docs[0].data() as Map;
          var name =
              user['UserName'].toString().decryptMyData(Helper.key, Helper.iv)!;
          var surname = user['UserSurname']
              .toString()
              .decryptMyData(Helper.key, Helper.iv)!;
          var fullName = '$name $surname';
          var msValue = Measure.invalidate();
          printLog(
              'User fullname fetched successfully: $fullName in $msValue ms.',
              LogLevel.debug);
          return fullName.encryptMyData(Helper.key, Helper.iv)!;
        } else {
          // If the server did not return a OK response,
          // then throw an exception.
          throw Exception('User not found.');
        }
      }
      Measure.invalidate();
      return '';
    } catch (e) {
      printLog(
          'An error occurred while getting the user - $e.', LogLevel.error);
      Measure.invalidate();
      return '';
    }
  }

  ///Gets a boolean value if ID used before or not. [encryptedID] is user ID.
  static Future<bool?> isIDAvailable(String encryptedID) async {
    try {
      Measure.validate();

      var fireUser = await users.where('UserID', isEqualTo: encryptedID).get();

      var msValue = Measure.invalidate();
      printLog('User fetched successfully: $fireUser in $msValue ms.',
          LogLevel.debug);
      if (fireUser.docs.isEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      printLog(
          'An error occurred while checking the User ID in user list - $e.',
          LogLevel.error);
      Measure.invalidate();
      return false;
    }
  }

  ///Updates debt of an user item in Firestore.
  ///[encryptedID] is UserFirebase's Encrypted TC ID,[docID] is Users' document Id on Firestore ,[newDebtUpdate] is update to User debt, [operationMode] is operation mode, 0 is extract, 1 is sum.
  static Future<bool> updateUserDebt(String encryptedID, String docID,
      double newdebtUpdate, int operationMode) async {
    try {
      if (encryptedID.isNotEmpty && docID.isNotEmpty) {
        Measure.validate();

        var isUserAvailable =
            await users.where('UserID', isEqualTo: encryptedID).get();

        if (isUserAvailable.size != 0) {
          // then tryParse the JSON.
          var user = isUserAvailable.docs[0].data() as Map;

          var newDebt = 0.0;
          switch (operationMode) {
            case 0:
              newDebt = user['UserDebt'] - newdebtUpdate;
              break;
            case 1:
              newDebt = user['UserDebt'] + newdebtUpdate;
              break;
            default:
          }

          await users.doc(docID).update({
            'UserDebt': newDebt,
          });

          var msValue = Measure.invalidate();
          printLog(
              'User fetched for updating debt successfully: $user in $msValue ms.',
              LogLevel.debug);
          return true;
        } else {
          // If the server did not return a OK response,
          // then throw an exception.
          throw Exception('User not found.');
        }
      }
      Measure.invalidate();
      return false;
    } catch (e) {
      printLog('An error occurred while updating the user debt - $e.',
          LogLevel.error);
      Measure.invalidate();

      return false;
    }
  }

  ///Searches user item list in Firestore with given criteria. [searchCriteria] is criteria.
  static Future<List<UserFirebase>?> searchInUsers(
      String searchCriteria) async {
    try {
      if (searchCriteria.isNotEmpty) {
        Measure.validate();

        var users = await getUsersFromDatabase();
        var usersFiltered = users!
            .where((element) => (element.userName
                    .decryptMyData(Helper.key, Helper.iv)!
                    .contains(searchCriteria) ||
                element.userSurname
                    .decryptMyData(Helper.key, Helper.iv)!
                    .contains(searchCriteria) ||
                element.userID
                    .decryptMyData(Helper.key, Helper.iv)!
                    .contains(searchCriteria)))
            .toList();
        var msValue = Measure.invalidate();
        printLog(
            'Users filtered by given criteria is fetched successfully in $msValue ms.',
            LogLevel.debug);

        return usersFiltered;
      }

      Measure.invalidate();
      return null;
    } catch (e) {
      printLog(
          'An error occurred while fetching the users filtered by given criteria - $e.',
          LogLevel.error);
      Measure.invalidate();
      return null;
    }
  }
}
*/