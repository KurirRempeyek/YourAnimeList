import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prototyping/components/bottom_up_transition.dart';
import 'package:prototyping/dto/issue.dart';
import 'package:prototyping/endpoints/endpoints.dart';
//import 'package:prototyping/edit_cs.dart';
import 'package:prototyping/form_customerservice.dart';
import 'package:prototyping/services/data_services.dart';

class IssueListScreen extends StatefulWidget {
  const IssueListScreen({Key? key}) : super(key: key);

  @override
  _CustomerServiceState createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<IssueListScreen> {
  Future<List<Issue>>? _CustomerService;

  @override
  void initState() {
    super.initState();
    _CustomerService = DataService.fetchCustomerService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Issue List'),
        backgroundColor: const Color.fromARGB(255, 103, 80, 164),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons
              .arrow_back), // Customize icon (optional)// Customize color (optional)
          onPressed: () {
            //Your custom back button functionality here
            Navigator.pushReplacementNamed(
                context, '/'); // Default back button behavior
            // You can add additional actions here (e.g., show confirmation dialog)
          },
        ),
      ),
      body: FutureBuilder<List<Issue>>(
        future: _CustomerService,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  title: item.imageUrl != null
                      ? Row(
                          children: [
                            Image.network(
                                fit: BoxFit.fitWidth,
                                width: 350,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error),
                                '${Endpoints.baseURLLive}/public/${item.imageUrl!}'),
                          ],
                        )
                      : null,
                  subtitle: Column(children: [
                    Text('Title : ${item.titleIssues}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 36, 31, 31),
                          fontWeight: FontWeight.normal,
                        )),
                    Text('Deskripsi : ${item.descriptionIssues}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 36, 31, 31),
                          fontWeight: FontWeight.normal,
                        )),
                    Text('NIM : ${item.nim}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 36, 31, 31),
                          fontWeight: FontWeight.normal,
                        )),
                    RatingBar(
                      minRating: 1,
                      maxRating: 5,
                      ignoreGestures: true,
                      allowHalfRating: false,
                      initialRating: item.rating.toDouble(),
                      ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.amber,
                        ),
                        empty: const Icon(
                          Icons.star_border,
                          color: Colors.amber,
                        ),
                      ),
                      onRatingUpdate: (double ratings) {},
                    ),
                    const Divider(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _showDeleteConfirmationDialog(context, item);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        // IconButton(
                        //   onPressed: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 EditScreen(object: item)));
                        //   },
                        //   icon: Icon(Icons.edit),
                        // ),
                      ],
                    )
                  ]),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 103, 80, 164),
        tooltip: 'Increment',
        onPressed: () {
          // Navigator.pushNamed(context, '/form-screen');
          // BottomUpRoute(page: const FormScreen());
          Navigator.push(context, BottomUpRoute(page: const CSForm()));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, Issue datas) async {
    final bool confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Data'),
        content:
            Text('Are you sure you want to delete this ${datas.titleIssues}?'),
        actions: [
          TextButton(
            onPressed: () {
              // Tidak jadi menghapus, kembali dengan nilai false
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Konfirmasi untuk menghapus, kembali dengan nilai true
              Navigator.of(context).pop(true);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    // Jika pengguna mengonfirmasi penghapusan, lanjutkan penghapusan
    if (confirmed) {
      try {
        // Memanggil metode deleteDatas untuk menghapus data dengan ID tertentu
        await DataService.deleteDatas(datas.idCustomerService);
        // Refresh data setelah berhasil menghapus
        setState(() {
          _CustomerService = DataService.fetchCustomerService();
        });
        // Tampilkan snackbar atau pesan berhasil dihapus
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data deleted successfully'),
          ),
        );
      } catch (e) {
        // Tangani kesalahan jika gagal menghapus data
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete data: $e'),
          ),
        );
      }
    }
  }
}
