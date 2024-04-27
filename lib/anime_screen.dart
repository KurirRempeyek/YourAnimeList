import 'package:flutter/material.dart';
import 'package:prototyping/dto/anime.dart';
import 'package:prototyping/helpers/dbhelper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({super.key});

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Future<List<Anime>>? anime;
  late String _title;
  bool isUpdate = false;
  late int? animeIdForUpdate;
  late DBHelper dbHelper;
  final _animeTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshAnimeLists();
  }

  @override
  void dispose() {
    _animeTitleController.dispose();
    dbHelper.close();
    super.dispose();
  }

  void cancelTextEditing() {
    _animeTitleController.text = '';
    setState(() {
      isUpdate = false;
      animeIdForUpdate = null;
    });
    closeKeyboard();
  }

  void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> refreshAnimeLists() async {
    try {
      await dbHelper.initDatabase();
      setState(() {
        anime = dbHelper.getAnime();
        isUpdate = false;
      });
    } catch (error) {
      debugPrint('Error fetching anime list: $error');
    }
  }

  void createOrUpdateAnime() {
    _formStateKey.currentState?.save();
    if (!isUpdate) {
      dbHelper.add(Anime(null, _title));
    } else {
      dbHelper.update(Anime(animeIdForUpdate, _title));
    }
    _animeTitleController.text = '';
    refreshAnimeLists();
  }

  void editFormAnime(BuildContext context, Anime anime) {
    setState(() {
      isUpdate = true;
      animeIdForUpdate = anime.id!;
    });
    _animeTitleController.text = anime.title;
  }

  void deleteAnime(BuildContext context, int animeID) {
    setState(() {
      isUpdate = false;
    });
    _animeTitleController.text = '';
    dbHelper.delete(animeID);
    refreshAnimeLists();
  }

  @override
  Widget build(BuildContext context) {
    var textFormField = TextFormField(
      onSaved: (value) {
        _title = value!;
      },
      autofocus: false,
      controller: _animeTitleController,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: !isUpdate ? Colors.purple : Colors.blue,
                  width: 2,
                  style: BorderStyle.solid)),
          labelText: !isUpdate ? 'Add Anime Title' : 'Edit Anime Title',
          icon: Icon(Icons.tv, color: !isUpdate ? Colors.purple : Colors.blue),
          fillColor: Colors.white,
          labelStyle:
              TextStyle(color: !isUpdate ? Colors.purple : Colors.blue)),
    );
    return Scaffold(
      body: Column(
        //height: MediaQuery.of(context).size.height,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
            key: _formStateKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: textFormField,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    createOrUpdateAnime();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !isUpdate
                        ? Colors.purple
                        : Colors.blue, // Set background color
                    foregroundColor: Colors.white,
                  ),
                  child: !isUpdate ? const Text('Save') : const Text('Update')),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    cancelTextEditing();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Set background color
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Cancel')),
            ],
          ),
          const Divider(),
          Expanded(
            child: FutureBuilder(
              future: anime,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text('No Data');
                }
                if (snapshot.hasData) {
                  return generateList(snapshot.data!);
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget generateList(List<Anime> anime) {
    return ListView.builder(
      itemCount: anime.length,
      itemBuilder: (context, index) => Slidable(
        // Customize appearance and behavior as needed
        key: ValueKey(index),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              onPressed: (context) => editFormAnime(context, anime[index]),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              // An action can be bigger than the others.
              onPressed: (context) => deleteAnime(context, anime[index].id!),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ), // Assuming each anime has a unique id
        child: ListTile(
          title: Text(anime[index].title),
        ),
      ),
    );
  }
}
