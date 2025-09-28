import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/services/movie_service.dart';
import 'package:movieapp/screens/movie_details/movie_details.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final MovieService _movieService = MovieService();
  late Future<List<Movie>> _moviesFuture;
  final PageController _pageController = PageController(viewportFraction: 0.7);
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  List<Movie> _movies = []; // Store movies locally

  @override
  void initState() {
    super.initState();
    _moviesFuture = _movieService.getMovies().then((movies) {
      _movies = movies; // Store movies for easy access
      return movies;
    });

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121312),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: FutureBuilder<List<Movie>>(
              future: _moviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final movies = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      // Header
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                      ),
                      SizedBox(height: 10.h),
                      // Available Now Section
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Center(
                          child: Image.asset(
                            'assets/images/AvailableNow.png',
                            height: 70,
                            width: 250,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),

                      // Main Carousel Section
                      SizedBox(
                        height: 400.h,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            final isCentered = index == _currentPage;
                            return _buildMovieCard(movie, isCentered, index);
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Watch Now Button
                      Center(
                        child: Image.asset(
                          'assets/images/watchNow.png',
                          height: 115,
                          width: 350,
                        ),
                      ),
                      SizedBox(height: 40.h),

                      // Action Movies Section
                      _buildActionMoviesSection(movies),
                      SizedBox(height: 30.h),
                    ],
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text(
                        'No movies found',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  // Action Movies Section
  Widget _buildActionMoviesSection(List<Movie> movies) {
    final actionMovies = movies.where((movie) =>
        movie.genres.any((genre) => genre.toLowerCase().contains('action'))
    ).toList();

    final displayMovies = actionMovies.isNotEmpty ? actionMovies : movies.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Action',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('See More tapped');
                },
                child: Text(
                  'See More',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xffF6BD00),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),

        // Horizontal Movies List
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: displayMovies.length,
            itemBuilder: (context, index) {
              final movie = displayMovies[index];
              return _buildActionMovieCard(movie);
            },
          ),
        ),
      ],
    );
  }

  // Action Movie Card
  Widget _buildActionMovieCard(Movie movie) {
    return Container(
      width: 120.w,
      margin: EdgeInsets.only(right: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Poster
          GestureDetector(
            onTap: () {
              _navigateToMovieDetails(movie.id);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Stack(
                children: [
                  Container(
                    height: 150.h,
                    width: 120.w,
                    child: Image.network(
                      movie.mediumCoverImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[800],
                          child: Icon(Icons.movie, color: Colors.white54, size: 40.sp),
                        );
                      },
                    ),
                  ),

                  // Rating Badge
                  Positioned(
                    top: 8.w,
                    left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: const Color(0xffF6BD00), size: 12.sp),
                          SizedBox(width: 2.w),
                          Text(
                            '${movie.rating}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),

          // Movie Title
          Text(
            movie.titleEnglish.isNotEmpty ? movie.titleEnglish : movie.title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMovieCard(Movie movie, bool isCentered, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: isCentered ? 0 : 40.h,
      ),
      child: GestureDetector(
        onTap: () {
          if (!isCentered) {
            // Simply navigate to the tapped movie's page
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else {
            // Navigate to movie details
            _navigateToMovieDetails(movie.id);
          }
        },
        child: Stack(
          children: [
            // Movie Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: double.infinity,
                height: isCentered ? 400.h : 300.h,
                child: Image.network(
                  movie.largeCoverImage ?? movie.mediumCoverImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[800],
                      child: Icon(Icons.movie, color: Colors.white54, size: 50.sp),
                    );
                  },
                ),
              ),
            ),

            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
            ),

            // Rating Badge
            Positioned(
              top: 16.w,
              left: 16.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: const Color(0xffF6BD00), size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      '${movie.rating}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToMovieDetails(int movieId) {
    Navigator.pushNamed(
      context,
      MovieDetails.routeName,
      arguments: movieId,
    );
  }
}