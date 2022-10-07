import 'dart:convert';

final Map<String, dynamic> chatHistory = const JsonDecoder().convert('''
{
  "1": [
    {"outgoing": true, "message": "Hey James, have you heard of Archer Finance?", "time": "1665075464" },
    {"outgoing": false, "message": "Nope, never heard of it", "time": "1665075594" },
    {"outgoing": true, "message": "Ok. Listen, there is an opportunity for early investment of their funds.\\nThey forecasts a return of 87% by the end of 2023.\\nYou can cash out at any time without penalty, and you get to keep all the profits.", "time": "1665075694" },
    {"outgoing": false, "message": "Really? That sounds too good to be true...", "time": "1665075854" },
    {"outgoing": true, "message": "Hey, Im telling you because you are my friend, and I think this is a perfect opportunity for you to become financial independence.", "time": "1665075894" },
    {"outgoing": false, "message": "but we haven't spoken for two years.", "time": "1665075994" },
    {"outgoing": true, "message": "I have been quite busy lately; Otherwise, I would have contact to you. So what do you think?", "time": "1665076094" },
    {"outgoing": false, "message": "Yeah... that might sound like a good plan, I guess?", "time": "1665076194" },
    {"outgoing": true, "message": "Why hesitate? It is a guarantee return.\\nLet me ask you this, how much money do you earn yearly?", "time": "1665076294" },
    {"outgoing": false, "message": "About 70k", "time": "1665076194" },
    {"outgoing": true, "message": "If you invest 100k into the funds, you can get 87k every year.\\n Without doing anything, just sit in the couch and watch TV, and boom, 87k deposit to your bank account", "time": "1665076294" },
    {"outgoing": false, "message": "That sure sounds great. Are you sure there is no other draw back?", "time": "1665076194" },
    {"outgoing": true, "message": "Of course not!", "time": "1665076294" }
  ],
  "2": [
    {"outgoing": false, "message": "Your sales number is low this month.\\nYou may expect a pay cut at this rate", "time": "1665075464" },
    {"outgoing": true, "message": "Oh, please no, I just need a bit more time. I almost get a hook on a big fish.\\n", "time": "1665075594" },
    {"outgoing": false, "message": "What's the expected number?", "time": "1665075694" },
    {"outgoing": true, "message": "I think we can get at least 100k", "time": "1665075854" },
    {"outgoing": false, "message": "Well, that sounds promising. Keep pushing.", "time": "1665075894" }
  ]
}

''');

class User {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
}

final Map<String, User> contacts = <String, User>{
  '1': const User(id: '1', firstName: 'James', lastName: 'Lin', email: 'jameslin@gmail.com'),
  '2': const User(id: '2', firstName: 'Berry', lastName: 'Vasundhara', email: 'bvasundhara@archerfinance.com'),
  '3': const User(id: '3', firstName: 'Avinash', lastName: 'Aco', email: 'aco@archerfinance.com'),
  '4': const User(id: '4', firstName: 'Teresa', lastName: 'Agapios', email: 'teresa11@gmail.com'),
  '5': const User(id: '5', firstName: 'Mirit Maol', lastName: 'Chaluim', email: 'wonderfulfighter1995@gmail.com'),
  '6': const User(id: '6', firstName: 'Walter', lastName: 'Pat', email: 'walterpat@hotmail.com'),
};
