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
  late String _status;
  late int _progress;
  late double _score;
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshAnimeLists();
    _status = 'Watching';
    _progress = 0;
    _score = 0.0;
    _startDate = DateTime.now();
    _endDate = DateTime.now();
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
      dbHelper.add(Anime(
          null, _title, _status, _progress, _score, _startDate, _endDate));
    } else {
      dbHelper.update(Anime(animeIdForUpdate, _title, _status, _progress,
          _score, _startDate, _endDate));
    }
    _animeTitleController.text = '';
    refreshAnimeLists();
    setState(() {});
  }

  void editFormAnime(BuildContext context, Anime anime) {
    setState(() {
      isUpdate = true;
      animeIdForUpdate = anime.id!;
      _title = anime.title;
      _status = anime.status;
      _progress = anime.progress;
      _score = anime.score ?? 0.0;
      _startDate = anime.startDate ?? DateTime.now();
      _endDate = anime.endDate ?? DateTime.now();
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: _formStateKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          textFormField,
                          DropdownButtonFormField<String>(
                            value: _status,
                            onChanged: (value) {
                              setState(() {
                                _status = value!;
                              });
                            },
                            items: ['Watching', 'Completed', 'Plan to Watch']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                              labelText: 'Status',
                              icon: Icon(Icons.info),
                            ),
                          ),
                          TextFormField(
                            onSaved: (value) {
                              _progress = int.parse(value!);
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Episode Progress",
                              icon: Icon(Icons.play_arrow),
                            ),
                          ),
                          TextFormField(
                            onSaved: (value) {
                              _score = double.parse(value!);
                            },
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'Score',
                              icon: Icon(Icons.star),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _startDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null &&
                                  pickedDate != _startDate) {
                                setState(() {
                                  _startDate = pickedDate;
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: TextEditingController(
                                  text: _startDate.toString().split(' ')[0],
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Start Date',
                                  icon: Icon(Icons.calendar_today),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _endDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null &&
                                  pickedDate != _endDate) {
                                setState(() {
                                  _endDate = pickedDate;
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: TextEditingController(
                                    text: _endDate.toString().split(' ')[0]),
                                decoration: const InputDecoration(
                                  labelText: 'End Date',
                                  icon: Icon(Icons.calendar_today),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                      child: !isUpdate
                          ? const Text('Save')
                          : const Text('Update')),
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Data'));
                    } else {
                      return generateList(snapshot.data!);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
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
          subtitle: Text(
            'Status: ${anime[index].status}, Progress: ${anime[index].progress}, Score: ${anime[index].score ?? 'N/A'}, Start Date: ${_formatDateTime(anime[index].startDate) ?? 'N/A'}, End Date: ${_formatDateTime(anime[index].endDate) ?? 'N/A'}',
          ),
        ),
      ),
    );
  }

  String? _formatDateTime(DateTime? dateTime) {
    return dateTime != null
        ? '${dateTime.year}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}'
        : null;
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }
}
