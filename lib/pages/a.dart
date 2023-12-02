import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class HomePostsPage extends StatefulWidget {
  const HomePostsPage({Key? key}) : super(key: key);

  @override
  State<HomePostsPage> createState() => _HomePostsPageState();
}

class _HomePostsPageState extends State<HomePostsPage> {
  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 15),
      maxNrOfCacheObjects: 100,
    ),
  );
  late Future<List<FileData>> imageFilesData;
  final Reference logoImageRef =
      FirebaseStorage.instance.ref('assets/Agri-Transformers.png');
  late Future<String> logoImageUrl;

  @override
  void initState() {
    super.initState();
    imageFilesData = listFilesData();
    logoImageUrl = getLogoImageUrl();
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
      return '';
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
              return CircularProgressIndicator();
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

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: snapshot.data!.length > maxImages
                ? maxImages
                : snapshot.data!.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final FileData fileData = snapshot.data![index];

              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      cacheManager: customCacheManager,
                      key: UniqueKey(),
                      imageUrl: fileData.downloadURL,
                      width: screenWidth / maxImages,
                      height: 200,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
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
        },
      ),
    );
  }
}

class FileData {
  final String fileName;
  final String downloadURL;

  FileData(this.fileName, this.downloadURL);
}
