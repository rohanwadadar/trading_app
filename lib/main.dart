import 'package:flutter/material.dart';
import 'profile.dart'; // Import your profile screen here.
import 'topup.dart';
import 'portfolio.dart';
import 'treanding.dart';
import 'stock_details.dart'; // Import the new stock details page

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0; // For tracking the selected tab

  // List of screens to navigate
  final List<Widget> _screens = [
    DashboardContent(), // Dashboard content
    TrendingScreen(),
    TopUpScreen(),
    Center(child: Text('Wish List', style: TextStyle(color: Colors.white))), //to be added later
    ProfileScreen(), // Replace with your Profile screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 8), // Add padding to both sides and bottom
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2), // Transparent background
          borderRadius: BorderRadius.all(Radius.circular(30)), // Curved from every corner
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8.0,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex, // Set the current selected index
          onTap: _onItemTapped, // Handle tap
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Trending',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Add Money',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Wish List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardContent extends StatefulWidget {
  @override
  _DashboardContentState createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  String searchQuery = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'),
              radius: 16,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Hallo Rohan Wadadar',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Stack(
              children: [
                Icon(Icons.notifications, size: 24),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '2',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.blue))
          : SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.black,
                Color(0xFF1A237E).withOpacity(0.8), // Dark blue gradient
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              SizedBox(height: 16),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search stocks...',
                  hintStyle: TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
              SizedBox(height: 24),

              // Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PortfolioPage(),
                        ),
                      );
                    },
                    child: _buildNavigationItem(
                      Icons.pie_chart, 'Portfolio',
                    ),
                  ),
                  _buildNavigationItem(
                      Icons.currency_exchange, 'Currencies'),
                  _buildNavigationItem(Icons.show_chart, 'Indices'),
                  _buildNavigationItem(Icons.new_label, 'IPO',
                      iconColor: Colors.red),
                  _buildNavigationItem(Icons.equalizer, 'Equities'),
                ],
              ),
              SizedBox(height: 24),

              // Welcome Text
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Explore stock market trends and insights here!',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              SizedBox(height: 24),

              // Gainer/Loser Section
              _buildSectionHeader('Gainer / Losers'),
              _buildHorizontalCards(),

              // Most Trending Stocks
              _buildSectionHeader('Most Trending Stocks'),
              _buildHorizontalStockList(),

              // Latest News
              _buildSectionHeader('Latest News'),
              _buildHorizontalNewsList(),

              // Recommended Stocks
              _buildSectionHeader('Recommended Stocks'),
              _buildHorizontalStockList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(IconData icon, String label,
      {Color iconColor = Colors.white}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 28),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              print('See Detail tapped for $title');
            },
            child: Text(
              'See Detail',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalCards() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gainer Info', style: TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Loser Info', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ),
      ],
    );
  }
Widget _buildHorizontalStockList() {
  // List of dummy stocks
  final List<Map<String, String>> dummyStocks = [
    {'name': 'BUKA', 'price': 'Rp278.00'},
    {'name': 'BBN', 'price': 'Rp4,630.00'},
    {'name': 'SDO', 'price': 'Rp24.00'},
    {'name': 'AAPL', 'price': 'Rp150.00'},
    {'name': 'GOOGL', 'price': 'Rp2,800.00'},
  ];

  return Container(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: dummyStocks.length,
      itemBuilder: (context, index) {
        final stock = dummyStocks[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StockDetailsPage(stockName: stock['name']!),
              ),
            );
          },
          child: Container(
            width: 200,
            margin: EdgeInsets.only(right: 16),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stock['name']!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  stock['price']!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

  Widget _buildHorizontalNewsList() {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 200,
            margin: EdgeInsets.only(right: 16),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('News Info $index', style: TextStyle(color: Colors.white)),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Market App',
      theme: ThemeData.dark(),
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
