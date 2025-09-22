// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/core/states.dart';
import 'package:movieapp/screens/movie_details/movie_details_view_model.dart';

class MovieDetails extends StatelessWidget {
  static const String routeName = "movieDetails";

  MovieDetailsViewModel viewModel = MovieDetailsViewModel();

  MovieDetails({super.key});

  TextStyle titlesStyle = GoogleFonts.roboto(
    color: Colors.white,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    height: 1.4.h,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              viewModel
                ..getDetails(10)
                ..getSuggestions(10),
      child: BlocBuilder<MovieDetailsViewModel, States>(
        builder: (BuildContext context, States state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return Center(child: Text("Error"));
          } else {
            return Scaffold(
              backgroundColor: Color(0xff121312),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Opacity(
                          opacity: 0.2,
                          child: Image.network(
                            viewModel.movie!.largeCoverImage ?? "",
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            spacing: 16.h,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AppBar(
                                actions: [
                                  Icon(
                                    Icons.bookmark_border,
                                    color: Colors.white,
                                  ),
                                ],
                                backgroundColor: Colors.transparent,
                              ),
                              GestureDetector(
                                onTap: () {
                                  viewModel.launch(viewModel.movie!.url);
                                },
                                child: Image.asset(
                                  "assets/images/start.png",
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                ),
                              ),
                              Center(
                                child: Text(
                                  viewModel.movie!.title,
                                  style: titlesStyle,
                                ),
                              ),
                              Center(
                                child: Text(
                                  viewModel.movie!.year.toString(),
                                  style: GoogleFonts.roboto(
                                    color: Color(0xffADADAD),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                    height: 1.2.h,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffE82626),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                ),
                                onPressed: () {
                                  viewModel.launch(viewModel.movie!.url);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: Text(
                                    "Watch",
                                    style: GoogleFonts.roboto(
                                      fontSize: 20.sp,
                                      height: 1.2.h,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff282A28),
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    width: 122.w,
                                    height: 48.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          size: 28.sp,
                                          color: Color(0xffF6BD00),
                                        ),
                                        Text(
                                          viewModel.movie!.likeCount.toString(),
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.bold,
                                            height: 1.2.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff282A28),
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    width: 122.w,
                                    height: 48.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.access_time_filled,
                                          size: 28,
                                          color: Color(0xffF6BD00),
                                        ),
                                        Text(
                                          viewModel.movie!.runtime.toString(),
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.bold,
                                            height: 1.2.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff282A28),
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    width: 122.w,
                                    height: 48.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.star_rate_rounded,
                                          size: 34.r,
                                          color: Color(0xffF6BD00),
                                        ),
                                        Text(
                                          viewModel.movie!.rating.toString(),
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.bold,
                                            height: 1.2.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16.h,
                        children: [
                          Text("Screen Shots", style: titlesStyle),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              viewModel.movie!.largeScreenshot1 ?? "",
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              viewModel.movie!.largeScreenshot2 ?? "",
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              viewModel.movie!.largeScreenshot3 ?? "",
                            ),
                          ),
                          Text("Similar", style: titlesStyle),
                          Wrap(
                            spacing: 20.w,
                            runSpacing: 16.h,
                            children:
                                viewModel.movies.map((movie) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, MovieDetails.routeName);
                                    },
                                    child: SizedBox(
                                      width: 188.w,
                                      height: 280.h,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              16.r,
                                            ),
                                            child: Image.network(
                                              movie.mediumCoverImage,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          ),
                                          Positioned(
                                            top: 12.h,
                                            left: 12.w,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 6.w,
                                                vertical: 4.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(
                                                  0.7,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    movie.rating.toString(),
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.white,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                  SizedBox(width: 2.w),
                                                  Icon(
                                                    Icons.star_rate_rounded,
                                                    size: 22.sp,
                                                    color: Color(0xffF6BD00),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                          Text("Summary", style: titlesStyle),
                          Text(
                            viewModel.movie!.descriptionIntro ?? "",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.4.h,
                            ),
                          ),
                          Text("Cast", style: titlesStyle),
                          ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: Color(0xff282A28),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.r),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                        child: Image.network(
                                          viewModel
                                              .movie!
                                              .cast![index]
                                              .urlSmallImage,
                                          height: 70.h,
                                          width: 70.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Name : ${viewModel.movie!.cast![index].name}",
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "Character : ${viewModel.movie!.cast![index].characterName}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (context, index) => SizedBox(height: 16.h),
                            itemCount: viewModel.movie!.cast!.length,
                          ),
                          Text("Genres", style: titlesStyle),
                          Wrap(
                            spacing: 16.w,
                            runSpacing: 8.h,
                            children:
                                viewModel.movie!.genres.map((genre) {
                                  return Container(
                                    width: 122.w,
                                    height: 36.h,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: Color(0xff282A28),
                                    ),
                                    child: Center(
                                      child: Text(
                                        genre,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
