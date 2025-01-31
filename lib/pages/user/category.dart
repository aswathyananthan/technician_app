import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class CategoryPage extends StatefulWidget {
  final String categoryName;
  final String image;

  const CategoryPage({
    super.key,
    required this.categoryName,
    required this.image,
  });

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late List _workers = [];
  final Map<int, bool> _favorites = {}; // Track favorite status for each worker
  bool _showFavoritesOnly =
      false; // Toggle between showing all workers and favorites

  @override
  void initState() {
    super.initState();
    _loadWorkers();
  }

  void _loadWorkers() {
    final jobsBox = Hive.box('jobs');
    _workers = jobsBox.values
        .where(
            (worker) => worker['category'] == widget.categoryName.toLowerCase())
        .toList();
    // Initialize favorites map
    for (int i = 0; i < _workers.length; i++) {
      _favorites[i] = false; // Default to not favorited
    }
    setState(() {});
  }

  void _sendRequest(Map worker) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Request'),
        content: Text('Send request to ${worker['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Request sent to ${worker['name']}!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _toggleFavorite(int index) {
    setState(() {
      _favorites[index] = !_favorites[index]!; // Toggle favorite status
    });
  }

  void _toggleShowFavorites() {
    setState(() {
      _showFavoritesOnly =
          !_showFavoritesOnly; // Toggle between showing all workers and favorites
    });
  }

  // Function to launch the phone dialer
  void _callWorker(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch the dialer.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter workers based on favorites
    final displayedWorkers = _showFavoritesOnly
        ? _workers
            .where((worker) => _favorites[_workers.indexOf(worker)]!)
            .toList()
        : _workers;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
              color: _showFavoritesOnly ? Colors.red : Colors.white,
            ),
            onPressed: _toggleShowFavorites,
          ),
        ],
      ),
      body: displayedWorkers.isEmpty
          ? Center(
              child: Text(
                _showFavoritesOnly
                    ? 'No favorites in this category'
                    : 'No workers available in this category',
                style: const TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: displayedWorkers.length,
              itemBuilder: (context, index) {
                final worker = displayedWorkers[index];
                final workerIndex =
                    _workers.indexOf(worker); // Get the original index
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              worker['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                _favorites[workerIndex]!
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: _favorites[workerIndex]!
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              onPressed: () => _toggleFavorite(workerIndex),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('Location: ${worker['place']}'),
                        Text('Availability: ${worker['timeAvailability']}'),
                        Text('Rate: \$${worker['pricePerHour']}/hour'),
                        Text('Contact: ${worker['phoneNumber']}'),
                        const SizedBox(height: 8),
                        // Rating Stars
                        Row(
                          children: List.generate(5, (starIndex) {
                            return Icon(
                              starIndex < (worker['rating'] ?? 0)
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                            );
                          }),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.call, color: Colors.green),
                              onPressed: () =>
                                  _callWorker(worker['phoneNumber']),
                            ),
                            Text(
                              "Call Now",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 20),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
