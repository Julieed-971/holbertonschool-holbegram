import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                hintText: "Search users or captions...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                hintStyle: TextStyle(fontSize: 20, color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.transparent,
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = "";
                          });
                        },
                      )
                    : null,
              ),
              style: TextStyle(fontSize: 25),
              // 3. Listen to every keystroke
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase(); // Normalize to lowercase
                });
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // 4. Get all posts
          final allPosts = snapshot.data!.docs;

          // 5. FILTER THE LIST
          // If query is empty, show all. Otherwise, check username or caption.
          final filteredPosts = allPosts.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final username = (data['username'] ?? "").toString().toLowerCase();
            final caption = (data['caption'] ?? "").toString().toLowerCase();

            // Check if query exists in username OR caption
            return username.contains(_searchQuery) ||
                caption.contains(_searchQuery);
          }).toList();

          if (filteredPosts.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 50, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("No posts found", style: TextStyle(color: Colors.grey)),
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
