import 'dart:async';
import 'dart:convert'
show json, utf8;
import 'package:filcnaplo/Datas/Lesson.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'
as http;
import '../Datas/User.dart';
import '../Utils/Saver.dart';
import '../Utils/StringFormatter.dart';
import '../globals.dart'
as globals;
import "dart:math";
class RequestHelper {
    static
    const String GRANT_TYPE = "password";
    var randomDeviceCodeNames = ["a3xelte", "a5xelte", "a5y17lte", "A6020", "a7y17lte", "addison", "albus", "Amber", "angler", "armani", "athene", "axon7", "bacon", "bardock", "bardockpro", "berkeley", "beryllium", "bullhead", "cancro", "capricorn", "chagalllte", "chagallwifi", "chaozu", "charlotte", "che10", "cheeseburger", "cherry", "cheryl", "chiron", "clark"];
    final _random = new Random();
    void showError(String msg) {
        Fluttertoast.showToast(msg: msg, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
    }
    void showSuccess(String msg) {
        Fluttertoast.showToast(msg: msg, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 16.0);
    }
    Future < String > getInstitutes() async {
        String institutesBody = utf8.decode((await http.get(globals.INSTITUTES_API_URL)).bodyBytes);
        return institutesBody;
    }
    void refreshSzivacsSettigns() async {
        try {
            String settings = utf8.decode((await http.get(globals.SETTINGS_API_URL)).bodyBytes);
            Map settingsJson = json.decode(settings);
            globals.latestVersion = globals.isBeta ? settingsJson["BetaVersion"] : settingsJson["CurrentAppVersion"];
            if (globals.smartUserAgent) {
                // globals.userAgent = settingsJson["FillableUserAgent"];
                var randomCodeName = randomDeviceCodeNames[_random.nextInt(randomDeviceCodeNames.length)];
                globals.userAgent = settingsJson["FillableUserAgent"].replaceAll('<codename>', randomCodeName);
            } else {
                globals.userAgent = "Filc.Naplo." + globals.version;
            }
        } catch (e) {
            print(e);
        }
    }
    /*

  Future<String> getFAQ() async {
    String faq = (await http.get(FAQ_API_URL)).body;
    return faq;
  }


  Future<String> getTOS() async {
    String tos = utf8.decode((await http.get(TOS_API_URL)).bodyBytes);
    return tos;
  }
*/
    Future < String > getStuffFromUrl(String url, String accessToken, String schoolCode) async {
        if (accessToken != null) {
            http.Response response = await http.get(url, headers: {
                "HOST": schoolCode + ".e-kreta.hu",
                "User-Agent": globals.userAgent,
                "Authorization": "Bearer " + accessToken
            });
            return response.body;
        }
    }
    Future < String > getTests(String accessToken, String schoolCode) => getStuffFromUrl("https://" + schoolCode + ".e-kreta.hu/mapi/api/v1/BejelentettSzamonkeres?DatumTol=null&DatumIg=null", accessToken, schoolCode);
    Future < String > getMessages(String accessToken, String schoolCode) => getStuffFromUrl("https://eugyintezes.e-kreta.hu/integration-kretamobile-api/v1/kommunikacio/postaladaelemek/sajat", accessToken, schoolCode);
    Future < String > getMessageById(int id, String accessToken, String schoolCode) => getStuffFromUrl("https://eugyintezes.e-kreta.hu/integration-kretamobile-api/v1/kommunikacio/postaladaelemek/$id", accessToken, schoolCode);
    Future < String > getEvaluations(String accessToken, String schoolCode) => getStuffFromUrl("https://" + schoolCode + ".e-kreta.hu" + "/mapi/api/v1/Student", accessToken, schoolCode);
    Future < String > getHomework(String accessToken, String schoolCode, int id) => getStuffFromUrl("https://" + schoolCode + ".e-kreta.hu/mapi/api/v1/HaziFeladat/TanuloHaziFeladatLista/" + id.toString(), accessToken, schoolCode);
    Future < String > getHomeworkByTeacher(String accessToken, String schoolCode, int id) => getStuffFromUrl("https://" + schoolCode + ".e-kreta.hu/mapi/api/v1/HaziFeladat/TanarHaziFeladat/" + id.toString(), accessToken, schoolCode);
    Future < String > getEvents(String accessToken, String schoolCode) => getStuffFromUrl("https://" + schoolCode + ".e-kreta.hu/mapi/api/v1/Event", accessToken, schoolCode);
    Future < String > getTimeTable(String from, String to, String accessToken, String schoolCode) => getStuffFromUrl("https://" + schoolCode + ".e-kreta.hu/mapi/api/v1/Lesson?fromDate=" + from + "&toDate=" + to, accessToken, schoolCode);
    Future < String > getBearer(String jsonBody, String schoolCode, bool showErrors) async {
        http.Response response;
        try {
            response = await http.post("https://" + schoolCode + ".e-kreta.hu/idp/api/v1/Token", headers: {
                "HOST": schoolCode + ".e-kreta.hu",
                "Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
                "User-Agent": globals.userAgent
            }, body: jsonBody);
            return response.body;
        } catch (e) {
            if (showErrors) showError("Hálózati hiba");
            return null;
        }
    }
    void uploadHomework(String homework, Lesson lesson, User user) async {
        Map body = {
            "OraId": lesson.id.toString(),
            "OraDate": dateToHuman(lesson.date) + "00:00:00",
            "OraType": lesson.calendarOraType,
            "HataridoUtc": dateToHuman(lesson.date.add(Duration(days: 2))) + "23:00:00",
            "FeladatSzovege": homework
        };
        String token = await getBearerToken(user, true);
        String jsonBody = json.encode(body);
        try {
            http.Response response = await http.post("https://" + user.schoolCode + ".e-kreta.hu/mapi/api/v1/HaziFeladat/CreateTanuloHaziFeladat", headers: {
                "HOST": user.schoolCode + ".e-kreta.hu",
                "Authorization": "Bearer " + token,
                "Content-Type": "application/json; charset=utf-8",
                "User-Agent": globals.userAgent
            }, body: jsonBody);
            if (response.statusCode == 200) showSuccess("Házi sikeresen feltöltve");
            else showError("Hiba történt");
        } catch (e) {
            print(e);
            showError("Hálózati hiba");
            return null;
        }
    }
    Future < String > getBearerToken(User user, bool showErrors) async {
        String body = "institute_code=${user.schoolCode}&"
        "userName=${user.username}&"
        "password=${user.password}&"
        "grant_type=password&client_id=" + globals.clientId;
        try {
            String bearerResponse = await RequestHelper().getBearer(body, user.schoolCode, showErrors);
            if (bearerResponse != null) {
                Map < String, dynamic > bearerMap = json.decode(bearerResponse);
                if (bearerMap["error"] == "invalid_grant" && showErrors) showError("Hibás jelszó vagy felhasználónév");
                String code = bearerMap["access_token"];
                return code;
            }
        } catch (e) {
            if (showErrors) showError("hiba");
            print(e);
        }
        return null;
    }
    void seeMessage(int id, User user) async {
        try {
            String code = await getBearerToken(user, true);
            await http.post("https://eugyintezes.e-kreta.hu//integration-kretamobile-api/v1/kommunikacio/uzenetek/olvasott", headers: {
                "Authorization": ("Bearer " + code),
            }, body: "{\"isOlvasott\":true,\"uzenetAzonositoLista\":[$id]}");
        } catch (e) {
            print(e);
            showError("Hálózati hiba");
            return null;
        }
    }
    Future < String > getStudentString(User user, bool showErrors) async {
        String code = await getBearerToken(user, showErrors);
        String evaluationsString = await getEvaluations(code, user.schoolCode);
        return evaluationsString;
    }
    Future < String > getEventsString(User user, bool showErrors) async {
        String code = await getBearerToken(user, showErrors);
        String eventsString = await getEvents(code, user.schoolCode);
        saveEvents(eventsString, user);
        return eventsString;
    }
}