// import 'package:flutter/material.dart';
// import 'package:tec_app/pages/user/category.dart';

// class Userhome extends StatefulWidget {
//   final String name;

//   final String email;
//   const Userhome({super.key, required this.name, required this.email});

//   @override
//   _UserhomeState createState() => _UserhomeState();
// }

// class _UserhomeState extends State<Userhome> {
//   final TextEditingController _searchController = TextEditingController();
//   final List<Map<String, String>> _categories = [
//     {"name": "Carpenter", "image": "assets/carpenter.jpg"},
//     {"name": "Plumber", "image": "assets/plumber.jpg"},
//     {"name": "Cleaner", "image": "assets/cleaner.jpg"},
//     {"name": "Electrician", "image": "assets/electrician.jpg"},
//     {"name": "Driver", "image": "assets/driver.jpg"},
//     {"name": "Painter", "image": "assets/painter.jpg"},
//   ];

//   List<Map<String, String>> _filteredCategories = [];

//   @override
//   void initState() {
//     super.initState();
//     _filteredCategories = _categories;
//     _searchController.addListener(_filterCategories);
//   }

//   void _filterCategories() {
//     String query = _searchController.text.toLowerCase();
//     setState(() {
//       _filteredCategories = _categories
//           .where((category) => category["name"]!.toLowerCase().contains(query))
//           .toList();
//     });
//   }

//   void _navigateToCategoryPage(String categoryName, String image) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CategoryPage(
//           categoryName: categoryName,
//           image: image,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orangeAccent,
//         foregroundColor: Colors.white,
//         leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
//         title: const Text("Welcome Home"),
//         actions: [
//           const CircleAvatar(
//             foregroundImage: AssetImage("assets/uprofile.jpg"),
//           ),
//           IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           // Search Bar
//           Container(
//             height: 50,
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             margin: const EdgeInsets.only(bottom: 20),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.search, color: Colors.grey),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: TextField(
//                     controller: _searchController,
//                     decoration: const InputDecoration(
//                       hintText: "Search category",
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 if (_searchController.text.isNotEmpty)
//                   IconButton(
//                     icon: const Icon(Icons.clear, color: Colors.grey),
//                     onPressed: () {
//                       _searchController.clear();
//                     },
//                   ),
//               ],
//             ),
//           ),
//           // Grid View for Categories
//           _filteredCategories.isEmpty
//               ? const Center(child: Text("No categories found"))
//               : GridView.builder(
//                   itemCount: _filteredCategories.length,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     childAspectRatio: 1,
//                   ),
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         _navigateToCategoryPage(
//                           _filteredCategories[index]["name"]!,
//                           _filteredCategories[index]["image"]!,
//                         );
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black26,
//                               blurRadius: 4,
//                               offset: const Offset(2, 2),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               _filteredCategories[index]["image"]!,
//                               height: 50,
//                               width: 50,
//                               fit: BoxFit.contain,
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               _filteredCategories[index]["name"]!,
//                               style: const TextStyle(
//                                   fontSize: 14, fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:tec_app/pages/user/category.dart';
// import 'package:tec_app/pages/user/userlogin.dart'; // Import your login page for logout navigation

// class Userhome extends StatefulWidget {
//   final String name;
//   final String email;

//   const Userhome({super.key, required this.name, required this.email});

//   @override
//   _UserhomeState createState() => _UserhomeState();
// }

// class _UserhomeState extends State<Userhome> {
//   final TextEditingController _searchController = TextEditingController();
//   final List<Map<String, String>> _categories = [
//     {"name": "Carpenter", "image": "assets/carpenter.jpg"},
//     {"name": "Plumber", "image": "assets/plumber.jpg"},
//     {"name": "Cleaner", "image": "assets/cleaner.jpg"},
//     {"name": "Electrician", "image": "assets/electrician.jpg"},
//     {"name": "Driver", "image": "assets/driver.jpg"},
//     {"name": "Painter", "image": "assets/painter.jpg"},
//   ];

//   List<Map<String, String>> _filteredCategories = [];

//   @override
//   void initState() {
//     super.initState();
//     _filteredCategories = _categories;
//     _searchController.addListener(_filterCategories);
//   }

//   void _filterCategories() {
//     String query = _searchController.text.toLowerCase();
//     setState(() {
//       _filteredCategories = _categories
//           .where((category) => category["name"]!.toLowerCase().contains(query))
//           .toList();
//     });
//   }

//   void _navigateToCategoryPage(String categoryName, String image) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CategoryPage(
//           categoryName: categoryName,
//           image: image,
//         ),
//       ),
//     );
//   }

//   void _logout() {

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const Userlogin()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orangeAccent,
//         foregroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Scaffold.of(context).openDrawer(); // Open the drawer
//           },
//           icon: const Icon(Icons.menu),
//         ),
//         title: const Text("Welcome Home"),
//         actions: [
//           const CircleAvatar(
//             foregroundImage: AssetImage("assets/uprofile.jpg"),
//           ),
//           IconButton(
//             onPressed: _logout,
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       drawer: _buildDrawer(), // Add the drawer
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           // Search Bar
//           Container(
//             height: 50,
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             margin: const EdgeInsets.only(bottom: 20),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.search, color: Colors.grey),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: TextField(
//                     controller: _searchController,
//                     decoration: const InputDecoration(
//                       hintText: "Search category",
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 if (_searchController.text.isNotEmpty)
//                   IconButton(
//                     icon: const Icon(Icons.clear, color: Colors.grey),
//                     onPressed: () {
//                       _searchController.clear();
//                     },
//                   ),
//               ],
//             ),
//           ),
//           // Grid View for Categories
//           _filteredCategories.isEmpty
//               ? const Center(child: Text("No categories found"))
//               : GridView.builder(
//                   itemCount: _filteredCategories.length,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     childAspectRatio: 1,
//                   ),
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         _navigateToCategoryPage(
//                           _filteredCategories[index]["name"]!,
//                           _filteredCategories[index]["image"]!,
//                         );
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black26,
//                               blurRadius: 4,
//                               offset: const Offset(2, 2),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               _filteredCategories[index]["image"]!,
//                               height: 50,
//                               width: 50,
//                               fit: BoxFit.contain,
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               _filteredCategories[index]["name"]!,
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//         ],
//       ),
//     );
//   }

//   // Build the Drawer
//   Widget _buildDrawer() {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.orangeAccent,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 const CircleAvatar(
//                   foregroundImage: AssetImage("assets/uprofile.jpg"),
//                   radius: 30,
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   widget.name,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   widget.email,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text("Logout"),
//             onTap: _logout,
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:tec_app/pages/user/category.dart';
import 'package:tec_app/pages/user/userlogin.dart'; // Import your login page for logout navigation

class Userhome extends StatefulWidget {
  final String name;
  final String email;

  const Userhome({super.key, required this.name, required this.email});

  @override
  _UserhomeState createState() => _UserhomeState();
}

class _UserhomeState extends State<Userhome> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Global key for Scaffold
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _categories = [
    {"name": "Carpenter", "image": "assets/carpenter.jpg"},
    {"name": "Plumber", "image": "assets/plumber.jpg"},
    {"name": "Cleaner", "image": "assets/cleaner.jpg"},
    {"name": "Electrician", "image": "assets/electrician.jpg"},
    {"name": "Driver", "image": "assets/driver.jpg"},
    {"name": "Painter", "image": "assets/painter.jpg"},
  ];

  List<Map<String, String>> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _filteredCategories = _categories;
    _searchController.addListener(_filterCategories);
  }

  void _filterCategories() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCategories = _categories
          .where((category) => category["name"]!.toLowerCase().contains(query))
          .toList();
    });
  }

  void _navigateToCategoryPage(String categoryName, String image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryPage(
          categoryName: categoryName,
          image: image,
        ),
      ),
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Userlogin()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!
                .openDrawer(); // Open the drawer using GlobalKey
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text("Welcome Home"),
        actions: [
          const CircleAvatar(
            foregroundImage: AssetImage("assets/uprofile.jpg"),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      drawer: _buildDrawer(), // Add the drawer
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Search Bar
          Container(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: "Search category",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                    },
                  ),
              ],
            ),
          ),
          // Grid View for Categories
          _filteredCategories.isEmpty
              ? const Center(child: Text("No categories found"))
              : GridView.builder(
                  itemCount: _filteredCategories.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _navigateToCategoryPage(
                          _filteredCategories[index]["name"]!,
                          _filteredCategories[index]["image"]!,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              _filteredCategories[index]["image"]!,
                              height: 50,
                              width: 50,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _filteredCategories[index]["name"]!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  // Build the Drawer
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  foregroundImage: AssetImage("assets/uprofile.jpg"),
                  radius: 30,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.email,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: _logout,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
