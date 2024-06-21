// // ignore_for_file: prefer_const_constructors, unused_local_variable

// import 'package:flutter/material.dart';
// import 'package:news_api/presentaion/favourite_screen/view/widgets/custom_widgets.dart';
// import 'package:news_api/presentaion/home_page/controller/home_screen_controller.dart';
// import 'package:news_api/presentaion/home_page/view/widgets/custon_news_card.dart';
// import 'package:provider/provider.dart';

// class FavouriteScreen extends StatefulWidget {
//   const FavouriteScreen({super.key});

//   @override
//   State<FavouriteScreen> createState() => _FavouriteScreenState();
// }

// class _FavouriteScreenState extends State<FavouriteScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final provObj = Provider.of<HomeScreenController>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text("Favourite News"),
//         ),
//       ),
//       body: ListView.separated(
//           itemBuilder: (context, index) {
//             var favourite = provObj.myBox.getAt(index);
//             return CustomWidgets(
//               imageUrl: favourite["urlToImage"] ?? "",
//               author: favourite["author"] ?? "Unknown Author",
//               title: favourite["title"],
//             );
//           },
//           separatorBuilder: (context, index) => SizedBox(
//                 height: 10,
//               ),
//           itemCount: provObj.myBox.length),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/presentation/favourite_page/controller/favourites_controller.dart';
import 'package:music_app/presentation/home_page/view/home_page.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  FavouriteController favouriteController = Get.put(FavouriteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePageScreen(),
                  ));
            },
            icon: Icon(
              Icons.chevron_left_sharp,
              size: 30,
            )),
        title: const Text("Favourite Songs"),
      ),
      body: ListView.builder(
        itemCount: favouriteController.myBox.length,
        itemBuilder: (context, index) {
          var favourite = favouriteController.myBox.getAt(index);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://images.pexels.com/photos/25194062/pexels-photo-25194062/free-photo-of-a-small-green-duffel-bag-with-papers-on-it.jpeg?auto=compress&cs=tinysrgb&w=800&lazy=load"),
                    ),
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        favourite['title'] ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        favourite['artist'] ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                favouriteController.deleteData(index);
                                setState(() {});
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
