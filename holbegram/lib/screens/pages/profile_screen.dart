import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/screens/wrappers/login_wrapper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // get User data
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final currentUser = userProvider.user;

    // Safety Check: If user isn't logged in yet, show login prompt
    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text("Please log in to view favorites")),
      );
    }
    // Get the list of user's post IDs, profile pic url, posts, followers and following count
    final List<dynamic> usersPostsIds = currentUser.posts;
    final String userProfilePic = currentUser.photoUrl;
    final int userPostsCount = currentUser.posts.length;
    final int userFollowersCount = currentUser.followers.length;
    final int userFollowingCount = currentUser.following.length;
    final String userBio = currentUser.bio;

    return Scaffold(
      appBar: AppBar(
        // create appBar with "Profile" text and logout action
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(fontFamily: "Billabong", fontSize: 35),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await AuthMethode().signOut();
                if (mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginWrapper(),
                    ),
                    (route) => false,
                  );
                }
              } catch (error) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error logging out: $error')),
                  );
                }
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      // TODO row header with profile pic then three counters : posts, followers, following

      // Masonrygridview with user's post crossAxisCound = 3
      body: Column(
        children: [
          // --- HEADER SECTION ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // 1. Profile Picture
                CircleAvatar(
                  radius: 40,
                  backgroundImage: currentUser.photoUrl.isNotEmpty
                      ? NetworkImage(currentUser.photoUrl)
                      : const AssetImage('assets/images/default_profile.png')
                            as ImageProvider,
                  // Fallback if no image
                  child: currentUser.photoUrl.isEmpty
                      ? const Icon(Icons.person, size: 40)
                      : null,
                ),
                const SizedBox(width: 20),
                // 2. Counters
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCounterColumn(userPostsCount.toString(), "Posts"),
                      _buildCounterColumn(
                        userFollowersCount.toString(),
                        "Followers",
                      ),
                      _buildCounterColumn(
                        userFollowingCount.toString(),
                        "Following",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- USERNAME & BIO ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentUser.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currentUser.bio.isEmpty ? "No bio yet." : currentUser.bio,
                  style: const TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),

          const Divider(height: 20), // Visual separator
          // --- GRID SECTION ---
          Expanded(
            child: StreamBuilder(
              stream: _firestore.collection('posts').snapshots(),
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
                  return usersPostsIds.contains(doc.id);
                }).toList();
                if (filteredPosts.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark_border,
                          size: 60,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "You have no post yet",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Navigate to the Add page to add a post !",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
                return MasonryGridView.count(
                  crossAxisCount: 3,
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
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      color: Colors.grey[200],
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
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
          ),
        ],
      ),
    );
  }

  // Helper widget for the counters to keep code clean
  Widget _buildCounterColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
