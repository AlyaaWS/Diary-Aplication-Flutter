import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../viewmodels/diary_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final diaryViewModel = Provider.of<DiaryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              homeViewModel.logout(context);
            },
          ),
        ],
      ),
      body: diaryViewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: diaryViewModel.diaries.length,
        itemBuilder: (context, index) {
          final diary = diaryViewModel.diaries[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diary.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(diary.date),
                  SizedBox(height: 10),
                  Text(diary.content),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return DiaryEntryDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class DiaryEntryDialog extends StatefulWidget {
  @override
  _DiaryEntryDialogState createState() => _DiaryEntryDialogState();
}

class _DiaryEntryDialogState extends State<DiaryEntryDialog> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final diaryViewModel = Provider.of<DiaryViewModel>(context, listen: false);

    return AlertDialog(
      title: Text('New Diary Entry'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _contentController,
            decoration: InputDecoration(labelText: 'Content'),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            await diaryViewModel.addDiary(
              _titleController.text,
              _contentController.text,
            );
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
