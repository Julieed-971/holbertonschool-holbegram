import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    // Get Current User Data
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final currentUser = userProvider.user;

    // Safety Check: If user isn't logged in yet, show login prompt
    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text("Please log in to view favorites")),
      );
    }

    // Get the list of saved Post IDs
    final List<dynamic> savedIds = currentUser.saved;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Favorites",
          style: TextStyle(fontFamily: "Billabong", fontSize: 35),
        ),
      ),
      body: StreamBuilder(
        // (Optimization: In a real app with millions of posts, we'd query differently,
        // but for this project, filtering client-side is fine and easier).
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final allPosts = snapshot.data!.docs;

          // Keep only posts where the ID is in the user's 'saved' list
          final filteredPosts = allPosts.where((doc) {
            return savedIds.contains(doc.id);
          }).toList();

          if (filteredPosts.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 60, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "No saved posts yet",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Tap the bookmark icon on posts to save them!",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return MasonryGridView.count(
            crossAxisCount: 1,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            itemCount: filteredPosts.length,
            itemBuilder: (context, index) {
              final postData =
                  filteredPosts[index].data() as Map<String, dynamic>;
              final String postUrl = postData['postUrl'] ?? '';

              return GestureDetector(
                onTap: () {
                  // TODO: Navigate to Post Detail
                },
                child: postUrl.isNotEmpty
                    ? Image.network(
                        postUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                            ),
                          );
                        },
                      )
                    : Container(color: Colors.grey[200]),
              );
            },
          );
        },
      ),
    );
  }
}
