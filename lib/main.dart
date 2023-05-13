// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_bloc/flutter_bloc.dart';

// class UMKMCubit extends Cubit<List<dynamic>> {
//   UMKMCubit() : super([]);

//   Future<void> getData() async {
//     var response = await http.get(
//       Uri.parse("http://178.128.17.76:8000/daftar_umkm"),
//       headers: {"Accept": "application/json"},
//     );

//     var extractedData = json.decode(response.body)["data"];
//     emit(extractedData);
//   }

//   Future<Map<dynamic, dynamic>> getDetailData(int id) async {
//     var response = await http.get(
//       Uri.parse("http://178.128.17.76:8000/detil_umkm/$id"),
//       headers: {"Accept": "application/json"},
//     );

//     var extractedData = json.decode(response.body);
//     return extractedData;
//   }
// }

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   final UMKMCubit _umkmCubit = UMKMCubit();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BlocProvider(
//         create: (context) => _umkmCubit..getData(),
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text("Daftar UMKM"),
//           ),
//           body: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                         "2001521, Surya Alfin Maoludin; 2006945, Hafizh Lutfi Hidayat. Saya berjanji tidak akan berbuat curang atau membantu orang lain berbuat curang"),
//                     ElevatedButton(
//                       onPressed: () {
//                         context.read<UMKMCubit>().getData();
//                       },
//                       child: const Text(
//                         "Reload Data UMKM",
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: BlocBuilder<UMKMCubit, List<dynamic>>(
//                   builder: (context, umkmData) {
//                     return ListView.builder(
//                       itemCount: umkmData.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return ListTile(
//                           leading: Image.network(
//                               'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
//                           trailing: const Icon(Icons.more_vert),
//                           title: Text(umkmData[index]["nama"]),
//                           subtitle: Text(umkmData[index]["jenis"]),
//                           onTap: () => {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => DetailPage(
//                                   id: int.tryParse(umkmData[index]["id"]) ?? 0,
//                                 ),
//                               ),
//                             ),
//                           },
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Define the state for the DetailPage
// class DetailPageState {
//   final Map<dynamic, dynamic>? data;

//   DetailPageState({required this.data});

//   // Create a copy of the state with a new data value
//   DetailPageState copyWith({Map<dynamic, dynamic>? newData}) {
//     return DetailPageState(data: newData ?? data);
//   }
// }

// // Define the events that can occur in the DetailPage
// abstract class DetailPageEvent {}

// class FetchDetailPageData extends DetailPageEvent {
//   final int id;

//   FetchDetailPageData({required this.id});
// }

// // Define the Cubit for the DetailPage
// class DetailPageCubit extends Cubit<DetailPageState> {
//   DetailPageCubit() : super(DetailPageState(data: null));

//   Future<void> fetchData(int id) async {
//     var response = await http.get(
//         Uri.parse("http://178.128.17.76:8000/detil_umkm/$id"),
//         headers: {"Accept": "application/json"});

//     var extractedData = json.decode(response.body);
//     var newData = extractedData as Map<dynamic, dynamic>;

//     emit(state.copyWith(newData: newData));
//   }
// }

// // Define the DetailPage widget
// class DetailPage extends StatelessWidget {
//   final int id;

//   DetailPage({required this.id});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Detail UMKM"),
//       ),
//       body: BlocProvider(
//         create: (context) => DetailPageCubit(),
//         child: BlocBuilder<DetailPageCubit, DetailPageState>(
//           builder: (context, state) {
//             if (state.data == null) {
//               context.read<DetailPageCubit>().fetchData(id);
//               return Center(child: CircularProgressIndicator());
//             }

//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Text('id UMKM: $id'),
//                   SizedBox(height: 20),
//                   ListTile(
//                     title: Text(state.data!["nama"]),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Jenis: ${state.data!["jenis"]}"),
//                         Text("Omzet Bulan: ${state.data!["omzet_bulan"]}"),
//                         Text("Lama Usaha: ${state.data!["lama_usaha"]} bulan"),
//                         Text("Member Sejak: ${state.data!["member_sejak"]}"),
//                         Text(
//                             "Jumlah Pinjaman Sukses: ${state.data!["jumlah_pinjaman_sukses"]}")
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List data = [];

  Future<String> getData() async {
    var response = await http.get(
        Uri.parse("http://178.128.17.76:8000/daftar_umkm"),
        headers: {"Accept": "application/json"});

    setState(() {
      var extractedData = json.decode(response.body)["data"];
      data = extractedData;
    });

    return "Successful";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Daftar UMKM"),
        ),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
              trailing: const Icon(Icons.more_vert),
              title: Text(data[index]["nama"]),
              subtitle: Text(data[index]["jenis"]),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailPage(id: int.tryParse(data[index]["id"]) ?? 0),
                  ),
                ),
              },
            );
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final int id;

  DetailPage({required this.id});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<dynamic, dynamic>? data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.parse("http://178.128.17.76:8000/detil_umkm/${widget.id}"),
        headers: {"Accept": "application/json"});

    setState(() {
      var extractedData = json.decode(response.body);
      data = extractedData;
    });

    return "Successful";
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detil UMKM"),
      ),
      body: Center(
        child: data == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('UMKM ID: ${widget.id}'),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text(data!["nama"]),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Jenis: ${data!["jenis"]}"),
                        Text("Omzet Bulan: ${data!["omzet_bulan"]}"),
                        Text("Lama Usaha: ${data!["lama_usaha"]} bulan"),
                        Text("Member Sejak: ${data!["member_sejak"]}"),
                        Text(
                            "Jumlah Pinjaman Sukses: ${data!["jumlah_pinjaman_sukses"]}")
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
