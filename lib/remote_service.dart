import 'dart:io';
import 'package:http/http.dart' as http;
import 'models/word_details.dart';

class RemoteService{

  Future<List<WordDetails>> fetchWordDetails({String? word}) async {
    final url = "https://api.dictionaryapi.dev/api/v2/entries/en/$word";
    try {
      final req = await http.get(Uri.parse(url));
      if (req.statusCode == 200) {
        final dictionaryModel = wordDetailsFromJson(req.body);
        return dictionaryModel;
      }
      else{
        final dictionaryModel = wordDetailsFromJson(req.body);

        return dictionaryModel;
      }

    }on SocketException catch(e){
      return Future.error('No network');
    }
    catch(e){
      return Future.error('Error');
    }





  }














  
}