import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('posts').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final posts = snapshot.data!.docs;
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final postData = posts[index].data() as Map<String, dynamic>;
            final String username = postData['username'] ?? 'Unknown';
            final String profImage = postData['profImage'] ?? '';
            final String caption = postData['caption'] ?? '';
            final String postUrl = postData['postUrl'] ?? '';
            // final String postId = posts[index].id; // You might need this for deletion later

            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsetsGeometry.lerp(
                  const EdgeInsets.all(8),
                  const EdgeInsets.all(8),
                  10,
                ),
                height: 540, // Fixed height as per instructions
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // Profile Image
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: profImage.isNotEmpty
                                  ? Image.network(profImage, fit: BoxFit.cover)
                                  : const Icon(Icons.person), // Fallback
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Username
                          Text(
                            username,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          // More Icon
                          IconButton(
                            icon: const Icon(Icons.more_horiz),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Post Deleted")),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    // --- CAPTION ---
                    SizedBox(
                      child: Text(
                        caption,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // --- POST IMAGE ---
                    Container(
                      width: 350,
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: postUrl.isNotEmpty
                            ? Image.network(postUrl, fit: BoxFit.cover)
                            : const Center(child: Icon(Icons.broken_image)),
                      ),
                    ),

                    // --- ADD MISSING ICONS (Like, Comment, Share) ---
                    // The instructions say "Add the missing Icons that appears in the Picture"
                    // Usually these go below the image.
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite_border),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.mode_comment_outlined),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.send_outlined),
                            onPressed: () {},
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.bookmark_border),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "${postData['likes']?.length ?? 0} Liked", // Safe access in case likes is null
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
