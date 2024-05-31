// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:music_app/core/constants/color.dart';
import 'package:music_app/core/constants/texts.dart';
import 'package:music_app/presentation/home_page/controller/song_data_controller.dart';
import 'package:music_app/presentation/home_page/controller/song_player_controller.dart';

class SongPageScreen extends StatefulWidget {
  const SongPageScreen({
    super.key,
  });

  @override
  State<SongPageScreen> createState() => _SongPageScreenState();
}

class _SongPageScreenState extends State<SongPageScreen>
    with SingleTickerProviderStateMixin {
  SongPlayerController songPlayerController = Get.put(SongPlayerController());
  SongDataController songDataController = Get.put(SongDataController());

  late AnimationController aniController;
  late LottieComposition lotComposition;

  @override
  void initState() {
    super.initState();
    aniController = AnimationController(vsync: this);
    songPlayerController.isPlaying.listen((isPlaying) {
      if (isPlaying) {
        aniController.forward();
      } else {
        aniController.stop();
      }
    });
  }

  // @override
  // void dispose() {
  //   aniController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/564x/3b/52/46/3b524657f01fc92110efa4317d85a979.jpg"),
                    fit: BoxFit.cover)
                // gradient: LinearGradient(
                //     begin: Alignment.topRight,
                //     end: Alignment.bottomLeft,
                //     colors: [
                //   ColorConstants.gradientColor1,
                //   ColorConstants.gradientColor2,
                //   ColorConstants.gradientColor1,
                //   ColorConstants.gradientColor3,
                //   ColorConstants.gradientColor2,
                //   ColorConstants.gradientColor4,
                //   ColorConstants.gradientColor2,
                //   ColorConstants.gradientColor3,
                //   ColorConstants.gradientColor1,
                //   ColorConstants.gradientColor2,
                // ])
                ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   height: 400,
                  //   width: MediaQuery.sizeOf(context).width,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  Center(
                    child: Lottie.asset(
                      filterQuality: FilterQuality.high,
                      'assets/images/Animation - 1717130617436 (1).json',
                      fit: BoxFit.fill,
                      controller: aniController,
                      onLoaded: (composition) {
                        aniController.duration = composition.duration;
                        aniController.repeat();
                      },
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Obx(
                    () => Text(
                      songPlayerController.songTitle.value,
                      style: MytextStyle.customWhiteHeadings,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Obx(
                    () => Text(
                      songPlayerController.songArtist.value,
                      style: MytextStyle.customWhiteHeadings1,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          songPlayerController.currentTime.value,
                          style: TextStyle(color: ColorConstants.customWhite),
                        ),
                        Slider(
                          inactiveColor: ColorConstants.customWhite,
                          activeColor: ColorConstants.customBlack1,
                          value: songPlayerController.sliderValue.value.clamp(
                              0.0, songPlayerController.sliderValue.value),
                          onChanged: (value) {
                            songPlayerController.sliderValue.value = value;
                            Duration songPosition =
                                Duration(seconds: value.toInt());
                            songPlayerController.sliderChange(songPosition);
                          },
                          min: 0,
                          max: songPlayerController.sliderMaxValue.value,
                        ),
                        Text(
                          songPlayerController.totalTime.value,
                          style: TextStyle(color: ColorConstants.customWhite),
                        ),
                      ],
                    ),
                  ),
                  // LinearProgressIndicator(
                  //   backgroundColor: ColorConstants.customBlack,
                  //   value: 9,
                  //   borderRadius: BorderRadius.circular(10),
                  //   color: ColorConstants.customWhite,
                  // ),
                  // Container(
                  //   height: 3,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(5),
                  //       color: ColorConstants.customWhite),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.shuffle,
                              size: 40,
                              color: ColorConstants.customWhite1,
                            )),
                        IconButton(
                            onPressed: () {
                              songDataController.previousSongPlay();
                            },
                            icon: Icon(Icons.skip_previous,
                                size: 40, color: ColorConstants.customWhite1)),
                        Obx(
                          () => songPlayerController.isPlaying.value
                              ? InkWell(
                                  onTap: () {
                                    songPlayerController.pausePlaying();
                                    aniController.stop();
                                  },
                                  child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                          ColorConstants.customWhite1,
                                      child: Icon(Icons.pause,
                                          color: ColorConstants.customGrey1)),
                                )
                              : InkWell(
                                  onTap: () {
                                    songPlayerController.resumePlaying();
                                    aniController.repeat();
                                  },
                                  child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                          ColorConstants.customWhite1,
                                      child: Icon(Icons.play_arrow,
                                          color: ColorConstants.customGrey1)),
                                ),
                        ),
                        IconButton(
                            onPressed: () {
                              songDataController.nextSongPlay();
                            },
                            icon: Icon(Icons.skip_next,
                                size: 40, color: ColorConstants.customWhite1)),
                        IconButton(
                            onPressed: () {
                              songPlayerController.isRepeat.value = true;
                              songPlayerController.repeatSong();
                            },
                            icon: Obx(() => Icon(Icons.refresh_outlined,
                                size: 40,
                                color: songPlayerController.isRepeat.value
                                    ? ColorConstants.containerOrange
                                    : ColorConstants.customWhite1)))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            // left: 3,
            top: 6,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.transparent,
              child: IconButton(
                  color: ColorConstants.customWhite,
                  onPressed: () {
                    Get.back();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => BottomNav(),
                    //     ));
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
