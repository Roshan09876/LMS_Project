import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/features/book/model/book_model.dart';
import 'package:learn_management_system/features/competedbook/presentation/viewmodel/book_complted_view_model.dart';

class BooksDetailView extends ConsumerStatefulWidget {
  const BooksDetailView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BooksDetailViewState();
}

class _BooksDetailViewState extends ConsumerState<BooksDetailView> {
  @override
  Widget build(BuildContext context) {
    var book = ModalRoute.of(context)!.settings.arguments as BookModel;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: kLight,
          ),
        ),
        title: ReusableText(
          text: 'Books Details',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: kLight,
        ),
        backgroundColor: kButton,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          FullScreenImage(imageUrl: "${book.image}"),
                    ),
                  );
                },
                child: Hero(
                  tag:
                      'bookImage${book.title}', // Unique tag for the Hero widget
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: _getImageProvider("${book.image}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ReusableText(
                  text: '${book.title}',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kButton,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  '${book.subtitle}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kButton,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${book.description}',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  color: kDark,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            print('${book.id}');
            print('object');
            if (book.id != null) {
              await ref
                  .read(bookCompletedViewModelProvider.notifier)
                  .markAsComplete(book.id!);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kButton,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Mark as Complete',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  ImageProvider _getImageProvider(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl);
    } else if (imageUrl.startsWith('data:image')) {
      return MemoryImage(base64Decode(imageUrl.split(',').last));
    } else if (imageUrl.isNotEmpty) {
      // Assuming this case handles local file paths.
      return FileImage(File(imageUrl));
    } else {
      // Use a default image for invalid URLs
      return AssetImage('assets/images/logo.png');
    }
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl; 

  const FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: ReusableText(
          text: 'Image',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        backgroundColor: Color(kButton.value),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 150),
            child: Hero(
              tag: 'bookImage',
              child: Image(
                image: NetworkImage(imageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
