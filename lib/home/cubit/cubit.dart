import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2_admin/home/cubit/states.dart';
import 'package:uuid/uuid.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  String? bookType;
  final List<String> booksTypesList = [
    'OurTopPicks',
    'Bestsellers',
    'Genres',
    'RecentlyViewed',
  ];


  File? file;
  Future uploadOnlyImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ["jpg", "png", "jpeg"],
      type: FileType.custom,
    );
    file = File(result?.files.single.path ?? "");
    debugPrint("---------- upload is done ------------");
    uploadImageToFirebase();
    emit(UploadImageSuccessState());
  }

  String? imageUrl;
  Future<void> uploadImageToFirebase() async {
    if (file == null) return;
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child('books_images/${DateTime.now()}.jpg');
      final UploadTask uploadTask = storageReference.putFile(file!);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrl = downloadUrl;
      log(imageUrl!);
      emit(UploadImageToFireStorageSuccessState());
    } catch (error) {
      log('Error uploading image: $error');
    }
  }


  var bookNameCon = TextEditingController();
  var bookPriceCon = TextEditingController();
  var bookAuthorNameCon = TextEditingController();
  var bookLinkCon = TextEditingController();
  var bookPagesNumberCon = TextEditingController();
  var bookResourceCon = TextEditingController();
  var bookRateCon = TextEditingController();
  var bookDesCon = TextEditingController();




  String newId = "";
  addNewBook({
      String? bookImage,
    required String bookName,
    required String bookAuthorName,
    required String bookId,
    required String bookType,
    required String bookUrl,
    required String bookPagesNumber,
    required String bookResource,
    required String bookRate,
    required String bookDes,
  })
  {
    emit(AddBookLoadingState());
    FirebaseFirestore.instance.collection("AllBooks").add(
        {
          "bookImage" : bookImage ?? "",
          "bookId" : bookId,
          "bookName" : bookName,
          "bookAuthorName" : bookAuthorName,
          "bookType" : bookType,
          "bookUrl" : bookUrl,
          "bookResource" : bookResource,
          "bookPagesNumber" : bookPagesNumber,
          "bookRate" : bookRate,
          "des" : bookDes,
        }
    ).then((value)
    {
      debugPrint("Add book is done");
      debugPrint("50"*10);
      debugPrint(value.id);
      newId = value.id;
      emit(AddBookSuccessState());
    }).catchError((error)
    {
      debugPrint("error in add new book ${error.toString()}");
      emit(AddBookErrorState());
    });
  }

  var uuidBook = const Uuid().v4();
  var userUuid = const Uuid().v4();
  final auth = FirebaseAuth.instance;

}