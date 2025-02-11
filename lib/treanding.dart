import 'package:flutter/material.dart';

class TrendingScreen extends StatefulWidget {
  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  String selectedTimeframe = '24 hour';
  String selectedCategory = 'Global';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Color(0xFF1A237E).withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Header with Title and Settings
              _buildHeader(),
              SizedBox(height: 20),

              // Category Tabs
              _buildCategoryTabs(),
              SizedBox(height: 16),

              // Region Pills
              _buildRegionPills(),
              SizedBox(height: 20),

              // Market Indices Cards
              _buildMarketIndicesCards(),
              SizedBox(height: 24),

              // Trending Section
              _buildTrendingSection(),
              SizedBox(height: 16),

              // Trending Stocks List
              _buildTrendingStocksList(),

              // See More Button
              _buildSeeMoreButton(),
              SizedBox(height: 24),

              // Recommendations Section
              _buildRecommendationsSection(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Trending',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[850]?.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    List<String> categories = ['Global', 'Crypto', 'Mutual funds', 'CFD'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          bool isSelected = category == selectedCategory;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 24),
              padding: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? Colors.green : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.green : Colors.grey,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRegionPills() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildRegionPill('Asia', true),
          _buildRegionPill('Asia', false),
          _buildRegionPill('Eropa', false),
          _buildRegionPill('Amerika', false),
        ],
      ),
    );
  }

  Widget _buildMarketIndicesCards() {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildMarketIndex('IH5G', '27,206.92', true, '+1.2%'),
          _buildMarketIndex('NIKKEI', '2,915.18', false, '-0.8%'),
          _buildMarketIndex('SENSEI', '14,863.10', true, '+2.1%'),
        ],
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Trending',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[850]?.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Text(
                '24 hour',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingStocksList() {
    return Column(
      children: [
        _buildStockItem('ROTI', 'Nippon Indosari Tbk', '8600.00', '+50', '+3.23%', Colors.amber),
        _buildStockItem('GOTO', 'GoTo Gojek Tokopedia', '2421.05', '-121', '-20.6%', Colors.green),
        _buildStockItem('ABNB', 'Airbnb Inc', '5300.50', '+31', '+2.23%', Colors.red),
        _buildStockItem('UNVR', 'Unilever Indonesia', '3867.10', '-71', '-4.1%', Colors.blue),
        _buildStockItem('ADRO', 'Adaro Energy Indonesia', '3600.45', '+21', '+3.23%', Colors.grey),
      ],
    );
  }

  Widget _buildRecommendationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommendation',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildRecommendationCard(
                'NFLX',
                'Netflix, Inc',
                '2,122.340',
                '-0.201%',
                Colors.red,
                false,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildRecommendationCard(
                'META',
                'Meta Platforms',
                '987.890',
                '+1.29%',
                Colors.blue,
                true,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildRecommendationCard(
                'AMZN',
                'Amazon.com, Inc',
                '1,001.333',
                '-8.20%',
                Colors.orange,
                false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecommendationCard(
      String symbol,
      String name,
      String price,
      String change,
      Color tagColor,
      bool isPositive,
      ) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[850]?.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: tagColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              symbol,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(color: Colors.grey[400], fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            change,
            style: TextStyle(
              color: isPositive ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeeMoreButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'See More',
              style: TextStyle(color: Colors.green),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.green, size: 16),
          ],
        ),
      ),
    );
  }

  // Helper widgets maintained from previous version...
  Widget _buildRegionPill(String text, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey[850] : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[850]!),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildMarketIndex(String name, String value, bool isPositive, String percentage) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[850]?.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive ? Colors.green : Colors.red,
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                name,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            percentage,
            style: TextStyle(
              color: isPositive ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockItem(String symbol, String name, String price, String change, String percentage, Color logoColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[850]?.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: logoColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                symbol[0],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symbol,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$change ($percentage)',
                style: TextStyle(
                  color: change.contains('-') ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}