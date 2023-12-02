import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class HomePostsPage extends StatefulWidget {
  const HomePostsPage({Key? key}) : super(key: key);

  @override
  State<HomePostsPage> createState() => _HomePostsPageState();
}

class _HomePostsPageState extends State<HomePostsPage>
    with SingleTickerProviderStateMixin {
  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 15),
      maxNrOfCacheObjects: 100,
    ),
  );
  late Future<List<FileData>> imageFilesData;
  // Firebase Storage reference for the logo image
  final Reference logoImageRef =
      FirebaseStorage.instance.ref('assets/Agri-Transformers.png');
  late Future<String> logoImageUrl;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    imageFilesData = listFilesData();
    logoImageUrl = getLogoImageUrl();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Change the duration as needed
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<FileData>> listFilesData() async {
    final ListResult result = await FirebaseStorage.instance.ref().listAll();
    final List<FileData> filesData = [];

    for (final Reference ref in result.items) {
      final String downloadURL = await ref.getDownloadURL();
      final String fileName = ref.name;
      filesData.add(FileData(fileName, downloadURL));
    }
    return filesData;
  }

  Future<String> getLogoImageUrl() async {
    try {
      final downloadURL = await logoImageRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error loading logo image: $e');
      return ''; // Return an empty URL or a default image URL
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: FutureBuilder<String>(
          future: logoImageUrl,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while the URL is fetched
              return Container(
                width: 30,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: ColorChangingTweenSequence(_controller)
                      .animate(_controller),
                  strokeWidth: 3,
                ),
              );
            } else if (snapshot.hasError || !snapshot.hasData) {
              return Text("App Logo");
            }
            return Image.network(snapshot.data!);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<FileData>>(
          future: imageFilesData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text("Something went wrong");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("No images found.");
            }

            final screenWidth = MediaQuery.of(context).size.width;
            final maxImages = 6;
            final orientation = MediaQuery.of(context).orientation;

            // Display images in a grid layout for landscape mode
            // Calculate columns based on screen width
            // final crossAxisCount = screenWidth ~/(maxImages * 150);
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : maxImages,
                // crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final fileData = snapshot.data![index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        cacheManager: customCacheManager,
                        key: UniqueKey(),
                        imageUrl: fileData.downloadURL,
                        // Adjust width and height based on grid layout
                        // width: screenWidth / crossAxisCount,
                        width: screenWidth,
                        height: 200, // You can adjust this height as needed
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          // width: screenWidth / crossAxisCount,
                          width: screenWidth,
                          height: 200,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.grey[200],
                            valueColor: ColorChangingTweenSequence(_controller)
                                .animate(_controller),
                            strokeWidth: 3,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.black.withOpacity(0.5),
                          child: Text(
                            fileData.fileName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}

class FileData {
  final String fileName;
  final String downloadURL;

  FileData(this.fileName, this.downloadURL);
}

class ColorChangingTweenSequence extends ColorTween {
  ColorChangingTweenSequence(Animation<double> animation)
      : super(begin: Colors.blue, end: Colors.red);

  @override
  Color lerp(double t) {
    final index = t * 10;
    final color = super.lerp((index % 1).clamp(0.0, 1.0));
    return color == null ? Colors.transparent : color; // Handle null case
  }

  // @override
  // Color lerp(double t) {
  //   final index = t * 10;
  //   return super.lerp((index % 1).clamp(0.0, 1.0));
  // }
}
