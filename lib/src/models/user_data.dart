import 'package:take_a_break/take_a_break.dart';

class UserData {
  UserData({this.userCredentials, this.questionnaire});

  ///[userCredentials] are the credentials an User might use to access their data
  final UserCredentials? userCredentials;

  ///[questionnaire] contain answers to the questionnaire
  final Questionnaire? questionnaire;

  // factory City.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return City(
  //     name: data?['name'],
  //     state: data?['state'],
  //     country: data?['country'],
  //     capital: data?['capital'],
  //     population: data?['population'],
  //     regions:
  //         data?['regions'] is Iterable ? List.from(data?['regions']) : null,
  //   );
  // }
  //
  // Map<String, dynamic> toFirestore() {
  //   return {
  //     if (name != null) "name": name,
  //     if (state != null) "state": state,
  //     if (country != null) "country": country,
  //     if (capital != null) "capital": capital,
  //     if (population != null) "population": population,
  //     if (regions != null) "regions": regions,
  //   };
  // }

  Map<String, dynamic> toJson() {
    return {
      'userCredentials': userCredentials?.toJson(),
      'questionnaire': questionnaire?.toJson()
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    final userCredentials = json['userCredentials'];
    final questionnaire = json['questionnaire'];
    return UserData(
        userCredentials: userCredentials != null
            ? UserCredentials.fromJson(userCredentials)
            : null,
        questionnaire: questionnaire != null
            ? Questionnaire.fromJson(questionnaire)
            : null);
  }
}
