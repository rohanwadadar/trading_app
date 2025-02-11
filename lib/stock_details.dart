import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'buy.dart';
import 'sell.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Tracker',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(backgroundColor: Colors.black),
      ),
      home: StockDetailsPage(stockName: 'AAPL'),
    );
  }
}

class StockDetailsPage extends StatefulWidget {
  final String stockName;

  StockDetailsPage({required this.stockName});

  @override
  _StockDetailsPageState createState() => _StockDetailsPageState();
}

class _StockDetailsPageState extends State<StockDetailsPage> {
  List<FlSpot> stockData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStockData();
  }

  Future<void> fetchStockData() async {
    final String apiKey = 'CF7H37OIS5NWDTN3'; // Replace with your API key
    final String symbol = widget.stockName;
    final String url =
        'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> timeSeries = data['Time Series (Daily)'];

        List<FlSpot> tempData = [];
        int index = 0;

        timeSeries.forEach((date, values) {
          double closePrice = double.parse(values['4. close']);
          tempData.add(FlSpot(index.toDouble(), closePrice));
          index++;
        });

        setState(() {
          stockData = tempData.reversed.toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load stock data');
      }
    } catch (e) {
      print('Error fetching stock data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stockName),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement stock search functionality
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StockGraph(stockData: stockData),
            TimeRangeSelector(),
            SizedBox(height: 20),
            PerformanceSection(),
            SizedBox(height: 20),
            ExpertsRatingSection(),
            SizedBox(height: 20),
            FinancialSection(),
            SizedBox(height: 20),
            ComparedStocks(),
            SizedBox(height: 20),
            KeyStatsSection(),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5), // Transparent black
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: TradeButtons(),
      ),

    );
  }
}

  class StockGraph extends StatelessWidget {
  final List<FlSpot> stockData;

  StockGraph({required this.stockData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rp189.00',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 10),
        Text('-9.00 (-20.6%) Today', style: TextStyle(color: Colors.redAccent, fontSize: 16)),
        SizedBox(height: 20),
        Container(
          height: 250,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: stockData,
                  isCurved: true,
                  color: Colors.greenAccent,
                  barWidth: 3,
                  belowBarData: BarAreaData(show: false), // No background fill
                  dotData: FlDotData(show: false), // No dots on graph
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TimeRangeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ["1D", "5D", "1M", "6M", "YTD", "1Y", "5Y", "MAX"].map((label) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: TextButton(
              onPressed: () {},
              child: Text(label, style: TextStyle(color: Colors.white54)),
            ),
          );
        }).toList(),
      ),
    );
  }
}


class TradeButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SellPage()),
              );
            },
            child: Text("SELL 140.23"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BuyPage()),
              );
            },
            child: Text("BUY 140.13"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
class PerformanceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Performance", style: TextStyle(color: Colors.white70, fontSize: 18)),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildPerformanceRow("Today's Low", "188.51", "Today's High", "189.51"),
              Divider(color: Colors.white24),
              _buildPerformanceRow("52 Week Low", "168.21", "52 Week High", "189.51"),
              Divider(color: Colors.white24),
              _buildPerformanceRow("Open", "188.01", "Prev. Close", "188.01"),
              Divider(color: Colors.white24),
              _buildPerformanceRow("Lower Circuit", "188.01", "Upper Circuit", "188.01"),
              Divider(color: Colors.white24),
              _buildVolumeInfo(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceRow(String label1, String value1, String label2, String value2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label1, style: TextStyle(color: Colors.white54, fontSize: 12)),
              Text(value1, style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(label2, style: TextStyle(color: Colors.white54, fontSize: 12)),
              Text(value2, style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVolumeInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Volume", style: TextStyle(color: Colors.white54, fontSize: 12)),
          Text("1001", style: TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}

class ExpertsRatingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Experts rating", style: TextStyle(color: Colors.white70, fontSize: 18)),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildRatingBar("Buy", 83.0, Colors.green),
              _buildRatingBar("Hold", 0.02, Colors.yellow),
              _buildRatingBar("Sell", 17.08, Colors.red),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBar(String label, double percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: Colors.white54, fontSize: 12)),
          SizedBox(width: 10),
          Expanded(
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.white24,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          SizedBox(width: 10),
          Text("$percentage%", style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}



//Financial
class FinancialSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Financial", style: TextStyle(color: Colors.white70, fontSize: 18)),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildFinancialTabs(),
              SizedBox(height: 10),
              _buildFinancialChart(),
              SizedBox(height: 10),
              _buildAboutCompanySection(),
              SizedBox(height: 10),
              _buildShareholdingPattern(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialTabs() {
    return Row(
      children: ["Revenue", "Profit", "Net worth"].map((tab) {
        return Expanded(
          child: TextButton(
            onPressed: () {},
            child: Text(tab, style: TextStyle(color: Colors.white54)),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFinancialChart() {
    return Container(
      height: 200,
      color: Colors.blue.withOpacity(0.1),
      child: Center(
        child: Text('Financial Chart Placeholder', style: TextStyle(color: Colors.white54)),
      ),
    );
  }


  //about company
  Widget _buildAboutCompanySection() {
    return ExpansionTile(
      title: Text("About Company", style: TextStyle(color: Colors.white70)),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildCompanyInfoRow("Parent Organization", ""),
              _buildCompanyInfoRow("MD/CEO", ""),
              _buildCompanyInfoRow("Founded in", ""),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white54)),
          Text(value, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildShareholdingPattern() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Shareholding Pattern", style: TextStyle(color: Colors.white70)),
        SizedBox(height: 10),
        Container(
          height: 200,
          color: Colors.blue.withOpacity(0.1),
          child: Center(
            child: Text('Shareholding Pie Chart Placeholder', style: TextStyle(color: Colors.white54)),
          ),
        ),
      ],
    );
  }
}

class ComparedStocks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Compared to", style: TextStyle(color: Colors.white70, fontSize: 18)),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StockComparisonTile("BUKA", "Bukalapak Tbk", "Rp276.00", "+2.82%", Colors.green),
              SizedBox(width: 10),
              StockComparisonTile("BBRI", "Bank Rakyat Indonesia", "Rp4,630.00", "+0.82%", Colors.green),
              SizedBox(width: 10),
              StockComparisonTile("SIDO", "PT Indofood", "Rp741.00", "-1.2%", Colors.red),
            ],
          ),
        ),
      ],
    );
  }
}
class StockComparisonTile extends StatelessWidget {
  final String symbol;
  final String name;
  final String price;
  final String change;
  final Color changeColor;

  StockComparisonTile(this.symbol, this.name, this.price, this.change, this.changeColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(symbol, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          Text(name, style: TextStyle(color: Colors.white70, fontSize: 12)),
          Text(price, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          Text(change, style: TextStyle(color: changeColor, fontSize: 14)),
        ],
      ),
    );
  }
}

class KeyStatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Keystats", style: TextStyle(color: Colors.white70, fontSize: 18)),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              KeyStatRow("Previous Close", "Rp4,600.00"),
              Divider(color: Colors.white24),
              KeyStatRow("Day Range", "Rp4,560.00 - Rp4,630.00"),
              Divider(color: Colors.white24),
              KeyStatRow("Year Range", "Rp3,960.00 - Rp4,980.00"),
              Divider(color: Colors.white24),
              KeyStatRow("Market Cap", "694.707 IDR"),
              Divider(color: Colors.white24),
              KeyStatRow("AVG Volume", "167.58M"),
              Divider(color: Colors.white24),
              KeyStatRow("P/E Ratio", "15.50"),
            ],
          ),
        ),
      ],
    );
  }
}

class KeyStatRow extends StatelessWidget {
  final String title;
  final String value;

  KeyStatRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.white70, fontSize: 14)),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
