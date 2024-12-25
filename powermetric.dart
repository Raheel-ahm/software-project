import 'package:flutter/material.dart';

class PowerMetricsScreen extends StatelessWidget {
  const PowerMetricsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Power Metrics'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              color: Colors.blueGrey.shade900,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Robot Power Metrics',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Key Metrics Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Key Metrics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: MetricCard(
                      title: 'Power Score',
                      value: '85',
                      trend: '+3%',
                      trendColor: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 16), // Spacer between cards
                  Expanded(
                    child: MetricCard(
                      title: 'Consistency Score',
                      value: '78',
                      trend: '+1%',
                      trendColor: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 16), // Spacer between cards
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Tasks Completed',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Icon(
                          Icons.pie_chart,
                          size: 50,
                          color: Colors.purple.shade300,
                        ),
                        const Text(
                          'Total: 150',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        Text(
                          '+5%',
                          style: TextStyle(fontSize: 12, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Historical Metrics Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Historical Metrics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.timeline, color: Colors.purple, size: 30),
              title: Text(
                'Average Power Over Time',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              subtitle: Text(
                'Trending upwards by 3%',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.timeline, color: Colors.purple, size: 30),
              title: Text(
                'Consistency Over Time',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              subtitle: Text(
                'Trending upwards by 1%',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),

            // Power Metrics Trends Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Power Metrics Trends',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const TrendChartCard(
              title: 'Power Usage Over Time',
              chartType: 'Line',
            ),
            const SizedBox(height: 20),
            const TrendChartCard(
              title: 'Consistency Over Time',
              chartType: 'Bar',
            ),
            const SizedBox(height: 20),

            // Power Metrics Summary Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Metrics Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.done_all, color: Colors.green, size: 30),
              title: Text(
                'Overall Performance: Excellent',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              subtitle: Text(
                'Consistently high power and efficiency.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.warning, color: Colors.orange, size: 30),
              title: Text(
                'Actionable Insights',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              subtitle: Text(
                'Consider upgrading certain components.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final Color trendColor;

  const MetricCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.trendColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              trend,
              style: TextStyle(
                fontSize: 12,
                color: trendColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrendChartCard extends StatelessWidget {
  final String title;
  final String chartType;

  const TrendChartCard({
    required this.title,
    required this.chartType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              color: Colors.black,
              child: Center(
                child: Text(
                  chartType == 'Line' ? 'Line Chart' : 'Bar Chart',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Data is represented as a $chartType chart.',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
