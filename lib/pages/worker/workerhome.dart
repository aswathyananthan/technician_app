import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tec_app/pages/worker/workerlogin.dart';

class Workershome extends StatefulWidget {
  final String name;
  final String email;
  const Workershome({super.key, required this.name, required this.email});

  @override
  _WorkershomeState createState() => _WorkershomeState();
}

class _WorkershomeState extends State<Workershome> {
  int _selectedIndex = 0;
  final _jobBox = Hive.box('jobs');
  final _historyBox = Hive.box('historyjobs'); // Box for history
  bool _isWorkingToday = false;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Form fields
  String _name = '';
  String _category = 'electrician';
  String _place = '';
  String _timeAvailability = '';
  double _pricePerHour = 0.0;
  String _phoneNumber = '';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => workerlogin()),
    );
  }

  void _toggleWorkingToday(bool value) {
    setState(() {
      _isWorkingToday = value;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Save job details to Hive
      final jobDetails = {
        'name': _name,
        'category': _category,
        'place': _place,
        'timeAvailability': _timeAvailability,
        'pricePerHour': _pricePerHour,
        'phoneNumber': _phoneNumber,
      };
      _jobBox.add(jobDetails);

      // Show SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Updated successfully!')),
      );

      // Clear form and toggle off
      setState(() {
        _isWorkingToday = false;
      });
    }
  }

  void _deleteJob(int index) {
    // Move job to history before deleting
    final job = _jobBox.getAt(index);
    _historyBox.add(job);
    _jobBox.deleteAt(index);

    // Show SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Job moved to history!')),
    );

    setState(() {});
  }

  void _retrieveJob(int index) {
    // Move job back to jobs box
    final job = _historyBox.getAt(index);
    _jobBox.add(job);
    _historyBox.deleteAt(index);

    // Show SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Job retrieved successfully!')),
    );

    setState(() {});
  }

  // Drawer Widget
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(widget.name), // Display username
            accountEmail: Text(widget.email), // Display email
            currentAccountPicture: CircleAvatar(
              foregroundImage: AssetImage("assets/wprofile.jpg"),
            ),
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState
                ?.openDrawer(); // Use the scaffold key to open the drawer
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text("Welcome Home"),
        actions: [
          Container(
            height: 70,
            child: const CircleAvatar(
              foregroundImage: AssetImage("assets/wprofile.jpg"),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      drawer: _buildDrawer(context), // Add the drawer here
      body: _selectedIndex == 0
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text and Toggle Button in a Row
                  Row(
                    children: [
                      const Text(
                        "Add new worker details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Switch(
                        value: _isWorkingToday,
                        onChanged: _toggleWorkingToday,
                        activeColor: Colors.orangeAccent,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (_isWorkingToday)
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Name'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            onSaved: (value) => _name = value!,
                          ),
                          DropdownButtonFormField<String>(
                            value: _category,
                            decoration:
                                const InputDecoration(labelText: 'Category'),
                            items: [
                              'electrician',
                              'plumber',
                              'painter',
                              'driver',
                              'cleaner',
                              'carpenter',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) => _category = value!,
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Place'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the place';
                              }
                              return null;
                            },
                            onSaved: (value) => _place = value!,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Time Availability'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter time availability';
                              }
                              return null;
                            },
                            onSaved: (value) => _timeAvailability = value!,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Price Per Hour'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter price per hour';
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                _pricePerHour = double.parse(value!),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Phone Number'),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            onSaved: (value) => _phoneNumber = value!,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Update'),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                  const Text(
                    "Your Jobs",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ..._jobBox.values.map((job) {
                    final index = _jobBox.values.toList().indexOf(job);
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('Category: ${job['category']}'),
                            Text('Place: ${job['place']}'),
                            Text(
                                'Time Availability: ${job['timeAvailability']}'),
                            Text('Price Per Hour: \$${job['pricePerHour']}'),
                            Text('Phone Number: ${job['phoneNumber']}'),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteJob(index),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            )
          : _buildHistoryPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryPage() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _historyBox.length,
      itemBuilder: (context, index) {
        final job = _historyBox.getAt(index);
        return _buildExpandableJobCard(job, index);
      },
    );
  }

  Widget _buildExpandableJobCard(Map job, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ExpansionTile(
        title: Text(
          job['name'],
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: ${job['category']}'),
                Text('Place: ${job['place']}'),
                Text('Time Availability: ${job['timeAvailability']}'),
                Text('Price Per Hour: \$${job['pricePerHour']}'),
                Text('Phone Number: ${job['phoneNumber']}'),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => _retrieveJob(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Retrieve'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
