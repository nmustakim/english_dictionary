import 'package:flutter/material.dart';
import '../../remote_service/dictionary_remote_service.dart';
import '../word_details_model.dart';

class DictionaryHome extends StatefulWidget {
  const DictionaryHome({Key? key}) : super(key: key);

  @override
  State<DictionaryHome> createState() => _DictionaryHomeState();
}

class _DictionaryHomeState extends State<DictionaryHome> {
  TextEditingController? search = TextEditingController();
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Row(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 1.2,
                padding: const EdgeInsets.only(
                  left: 16,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: search,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 8, bottom: 8),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24))),
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    if (search!.text.isNotEmpty) {
                      setState(() {});
                    }
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            search!.text.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Search for something'),
                  )
                : Expanded(
                    child: FutureBuilder(
                        future: DictionaryRemoteService()
                            .fetchWordDetails(word: search!.text),
                        builder: (context,
                            AsyncSnapshot<List<WordDetailsModel>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data!.length.compareTo(0),
                                itemBuilder: (context, index) {
                                  final data = snapshot.data![index];
                                  return Card(
                                      child: ListTile(
                                    title: Text(data.word!),
                                    subtitle: Text((data
                                            .meanings![index]
                                            .definitions![index]
                                            .definition!
                                            .isNotEmpty)
                                        ? data.meanings![index]
                                            .definitions![index].definition!
                                        : "null"),
                                    trailing: Text(
                                        data.meanings![index].partOfSpeech!),
                                  ));
                                });
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
