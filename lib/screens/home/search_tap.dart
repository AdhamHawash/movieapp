import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/core/movies_api_manager.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/screens/movie_details/movie_details.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  final MoviesApiManager _apiManager = MoviesApiManager();
  List<Movie> _searchResults = [];
  bool _isSearching = false;
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults.clear();
        _errorMessage = '';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _isSearching = true;
      _errorMessage = '';
    });

    try {
      final response = await _apiManager.getHttp("list_movies.json", {
        "query_term": query,
        "limit": "20",
      });

      if (response['status'] == 'ok') {
        final moviesData = response['data']['movies'];

        setState(() {
          if (moviesData != null) {
            _searchResults = (moviesData as List<dynamic>)
                .map((movieJson) => Movie.fromJson(movieJson))
                .toList();
          } else {
            _searchResults = [];
          }
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = response['status_message'] ?? 'Search failed';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to search movies';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121312),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // Search Bar
              Container(
                height: 55.h,
                decoration: BoxDecoration(
                  color: const Color(0xff282A28),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _searchMovies,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Image.asset(
                        'assets/icons/search.png', // Your image path
                        width: 17.w,
                        height: 17.h,
                        color: Colors.white,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              // Loading Indicator
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: const Color(0xffF6BD00),
                  ),
                ),

              // Error Message
              if (_errorMessage.isNotEmpty)
                Center(
                  child: Text(
                    _errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.sp,
                    ),
                  ),
                ),

              // Content based on search state
              Expanded(
                child: _isSearching && !_isLoading
                    ? _buildSearchResults()
                    : _buildDefaultContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Center Image
          Image.asset(
            'assets/icons/empty.png', // Replace with your image path
            width: 150.w,
            height: 150.h,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80.sp,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16.h),
            Text(
              'No results found for "${_searchController.text}"',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.only(bottom: 20.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
        childAspectRatio: 0.7, // Adjust aspect ratio for movie posters
      ),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final movie = _searchResults[index];
        return _buildMovieCard(movie);
      },
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          MovieDetails.routeName,
          arguments: movie.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: const Color(0xff282A28),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Movie Poster
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      movie.mediumCoverImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[800],
                          child: Icon(
                            Icons.movie,
                            color: Colors.grey[400],
                            size: 40.sp,
                          ),
                        );
                      },
                    ),

                    // Rating Badge
                    Positioned(
                      top: 8.w,
                      left: 8.w,
                      child: Container(
                        width: 59,
                        height: 28,
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 3.w),
                            Text(
                              movie.rating?.toStringAsFixed(1) ?? 'N/A',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Icon(
                              Icons.star,
                              color: const Color(0xffF6BD00),
                              size: 16.sp,
                            ),
                          ],
                        ),
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

  String _getFirstGenre(List<String>? genres) {
    if (genres == null || genres.isEmpty) return 'Unknown';
    return genres.first;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}