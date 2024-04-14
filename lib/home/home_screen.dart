 import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2_admin/home/cubit/cubit.dart';
import 'package:task_2_admin/home/cubit/states.dart';

import 'custom_Loading.dart';
import 'custom_button.dart';
import 'custom_text_form_filed (1).dart';
import 'new_toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit , HomeStates>(
      listener: (context , state ){
        if(state is AddBookSuccessState){
          NewToast.showNewSuccessToast(msg: "done", context: context);
          HomeCubit.get(context).file =null;
          HomeCubit.get(context).bookType =null;
          HomeCubit.get(context).bookNameCon.clear();
          HomeCubit.get(context).bookAuthorNameCon.clear();
          HomeCubit.get(context).bookRateCon.clear();
          HomeCubit.get(context).bookDesCon.clear();
          HomeCubit.get(context).bookLinkCon.clear();
          HomeCubit.get(context).bookPagesNumberCon.clear();
          HomeCubit.get(context).bookResourceCon.clear();
        }
      },

      builder: (context , state ){
        return SafeArea(child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:
                            HomeCubit.get(context).file!=null ?
                            Image.file(
                              HomeCubit.get(context).file!,
                              fit: BoxFit.cover,
                              height: 140,
                              width: 140,
                            ) :
                            Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey,
                                  )
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(.5),
                                    border: Border.all(
                                      color: Colors.grey,
                                    )
                                ),
                                child: const Icon(Icons.book_online,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ) ,
                          )) ,
                      InkWell(
                        onTap: () {
                          HomeCubit.get(context).uploadOnlyImage();
                        }, child: const CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 20,
                        child: Icon(
                          Icons.camera_alt, color: Colors.white,),
                      ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: const Text("Type"),
                    items: HomeCubit.get(context).booksTypesList
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                        .toList(),
                    value: HomeCubit.get(context).bookType,
                    onChanged: (value) {
                      setState(() {
                        HomeCubit.get(context).bookType = value as String;
                        print(HomeCubit.get(context).bookType);
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 56,
                      padding:
                      const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                      ),
                      iconSize: 20,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.black,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: MediaQuery.of(context).size.width * 0.7,
                      padding: null,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      elevation: 8,
                      offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness:
                        MaterialStateProperty.all<double>(6),
                        thumbVisibility:
                        MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomTextFormField(
                  controller: HomeCubit.get(context).bookNameCon,
                  keyboardType: TextInputType.name,
                  hintText: "Book Name",
                ),
                const SizedBox(
                  height: 18,
                ),

                CustomTextFormField(
                  controller: HomeCubit.get(context).bookAuthorNameCon,
                  keyboardType: TextInputType.text,
                  hintText: "Author Name",
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomTextFormField(
                  keyboardType : TextInputType.number,
                  controller: HomeCubit.get(context).bookRateCon,
                  hintText: "Book Rate",
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomTextFormField(
                  keyboardType : TextInputType.text,
                  controller: HomeCubit.get(context).bookDesCon,
                  hintText: "Book Description",
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomTextFormField(
                  keyboardType : TextInputType.text,
                  controller: HomeCubit.get(context).bookLinkCon,
                  hintText: "Book Link Url",
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomTextFormField(
                  keyboardType : TextInputType.number,
                  controller: HomeCubit.get(context).bookPagesNumberCon,
                  hintText: "Book Pages Number",
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomTextFormField(
                  keyboardType : TextInputType.text,
                  controller: HomeCubit.get(context).bookResourceCon,
                  hintText: "Book Resource",
                ),
                const SizedBox(
                  height: 18,
                ),
                ConditionalBuilder(
                  condition: state is! AddBookLoadingState,
                  fallback: (context) {
                    return const CustomLoading();
                  },
                  builder: (context) {
                    return CustomButton(
                      height: 60,
                      width: double.infinity,
                      btnColor: Colors.green,
                      borderColor: Colors.green,
                      btnText: const Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        HomeCubit.get(context).addNewBook(
                          bookImage: HomeCubit.get(context).imageUrl.toString(),
                          bookName:  HomeCubit.get(context).bookNameCon.text.toString(),
                          bookAuthorName: HomeCubit.get(context).bookAuthorNameCon.text.toString(),
                          bookType: HomeCubit.get(context).bookType.toString(),
                          bookId:  HomeCubit.get(context).uuidBook.toString(),
                            bookUrl :  HomeCubit.get(context).bookLinkCon.text.toString(),
                          bookResource :  HomeCubit.get(context).bookResourceCon.text.toString(),
                          bookPagesNumber :  HomeCubit.get(context).bookPagesNumberCon.text.toString(),
                          bookDes :  HomeCubit.get(context).bookDesCon.text.toString(),
                          bookRate :  HomeCubit.get(context).bookRateCon.text.toString(),
                        );
                        // if (formKey2.currentState!.validate()) {
                        //   HomeCubit.get(context).addNewBook(
                        //       bookImage: HomeCubit.get(context).imageUrl.toString(),
                        //       bookName:  HomeCubit.get(context).bookNameCon.toString(),
                        //       bookAuthorName: HomeCubit.get(context).bookAuthorNameCon.toString(),
                        //       bookPrice:  HomeCubit.get(context).bookPriceCon.toString(),
                        //     bookType: HomeCubit.get(context).bookType.toString(),
                        //       bookId:  HomeCubit.get(context).uuidBook.toString(),
                        //   );
                        // }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
