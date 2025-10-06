import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudTestPage extends StatefulWidget {
  const CrudTestPage({super.key});

  @override
  State<CrudTestPage> createState() => _CrudTestPageState();
}

class _CrudTestPageState extends State<CrudTestPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  final CollectionReference novels =
      FirebaseFirestore.instance.collection('novels');

  // CREATE
  Future<void> addNovel() async {
    if (_titleController.text.isNotEmpty &&
        _authorController.text.isNotEmpty) {
      await novels.add({
        'title': _titleController.text,
        'author': _authorController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });
      _titleController.clear();
      _authorController.clear();
    }
  }

  // (pakai dialog pop-up)
  Future<void> updateNovelDialog(DocumentSnapshot novel) async {
    final TextEditingController editTitleController =
        TextEditingController(text: novel['title']);
    final TextEditingController editAuthorController =
        TextEditingController(text: novel['author']);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Novel"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: editTitleController,
              decoration: const InputDecoration(labelText: "Judul Baru"),
            ),
            TextField(
              controller: editAuthorController,
              decoration: const InputDecoration(labelText: "Penulis Baru"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () async {
              await novels.doc(novel.id).update({
                'title': editTitleController.text,
                'author': editAuthorController.text,
              });
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  // DELETE
  Future<void> deleteNovel(String id) async {
    await novels.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CRUD Test Firestore")),
      body: Column(
        children: [
          // Input judul & penulis
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Judul Novel"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _authorController,
              decoration: const InputDecoration(labelText: "Nama Penulis"),
            ),
          ),
          ElevatedButton(
            onPressed: addNovel,
            child: const Text("Tambah Novel"),
          ),
          const Divider(),
          // READ (list data dari Firestore)
          Expanded(
            child: StreamBuilder(
              stream: novels.orderBy('createdAt', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var novel = docs[index];
                    return ListTile(
                      title: Text(novel['title']),
                      subtitle: Text(novel['author']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              updateNovelDialog(novel);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              deleteNovel(novel.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
