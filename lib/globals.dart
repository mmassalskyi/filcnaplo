library filcnaplo.globals;
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'Datas/User.dart';
import 'Datas/Average.dart';
import 'Datas/Student.dart';
import 'Datas/Note.dart';
import 'Datas/Homework.dart';
import 'Datas/Lesson.dart';
import 'Datas/Account.dart';

String SETTINGS_API_URL = "https://www.efilc.hu/mirror/settings.json";
String INSTITUTES_API_URL = "https://www.efilc.hu/mirror/school-list.json";
String clientId = "919e0c1c-76a2-4646-a2fb-7085bbbf3c56";
bool firstMain = true;
String version;
String latestVersion = "";
bool isBeta = false;
bool isLoggedIn = false;
bool isLogo = true;
bool isColor = true;
Map < String, List < Absence >> absents;
List searchres;
List jsonres;
List < User > users = new List < User > ();
bool multiAccount;
bool isSingle;
bool smartUserAgent = true;
User selectedUser;
String lang = "";
String selectedSchoolCode = "";
String selectedSchoolUrl = "";
String selectedSchoolName;
int screen = 0;
int sort = 0;
int selectedTimeForHomework = 1;
List < int > idoAdatok = [1, 7, 30, 60];
Average selectedAverage;
List < Evaluation > currentEvals = new List();
int themeID = 0;
String htmlFAQ = "https://t.me/joinchat/PN6EyQ7AVDOs1SI1sPIYrQ";
String userAgent;
List < Account > accounts = new List();
Account selectedAccount;
List < Evaluation > evals = new List();
bool isDark = false;
bool isAmoled = false;
bool canSyncOnData = true;
List < Evaluation > global_evals = new List();
List < Average > avers = new List();
Map < String, List < Absence >> global_absents = new Map();
List < Note > notes = new List();
List < Lesson > lessons = new List();
Color color1 = Colors.red;
Color color2 = Colors.brown;
Color color3 = Colors.orange;
Color color4 = Color.fromARGB(255, 255, 151, 0);
Color color5 = Colors.green;
Color defaultColor = Color.fromARGB(255, 44, 160, 90);
Color colorF1; //Foreground colors calculated for the values specified by the user. See in mainScreen, _initSettings()
Color colorF2;
Color colorF3;
Color colorF4;
Color colorF5;
DatabaseFactory dbFactory = databaseFactoryIo;
Database db;
var store = StoreRef.main();
List < Homework > currentHomeworks = List();