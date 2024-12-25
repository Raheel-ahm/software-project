import 'package:flutter/material.dart';
import 'taskscheduler.dart';
import 'powermetric.dart';

void main() {
  runApp(const RobotPerformanceDashboard());
}

class RobotPerformanceDashboard extends StatelessWidget {
  const RobotPerformanceDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Logo and Navigation Links
            Container(
              color: Colors.blueGrey.shade900,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  // Logo Circle
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TaskSchedulerScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Colors.purple, Colors.blue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'RT', // Logo initials
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'RoboTrack',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'AI-Powered Robot Performance Dashboard',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Navigation Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        icon: const Icon(Icons.schedule, color: Colors.white),
                        label: const Text(
                          "Task Management",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TaskSchedulerScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        icon: const Icon(Icons.analytics, color: Colors.white),
                        label: const Text(
                          "Power Metrics",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PowerMetricsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Remaining Original Dashboard Contents
            // Key Metrics Section
            const SectionTitle(title: 'Key Metrics'),
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
                  Expanded(
                    child: MetricCard(
                      title: 'Consistency Score',
                      value: '78',
                      trend: '+1%',
                      trendColor: Colors.green,
                    ),
                  ),
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

            // Error Alerts Section
            const SectionTitle(title: 'Error Alerts'),
            const SizedBox(height: 10),
            const ErrorAlertCard(
              errorTitle: 'Network Failure',
              timestamp: '2023-10-14 15:30',
              icon: Icons.wifi_off,
              iconColor: Colors.red,
            ),
            const ErrorAlertCard(
              errorTitle: 'Low Disk Space',
              timestamp: '2023-10-14 15:31',
              icon: Icons.storage,
              iconColor: Colors.yellow,
            ),
            const ErrorAlertCard(
              errorTitle: 'System Update',
              timestamp: '2023-10-14 15:32',
              icon: Icons.system_update,
              iconColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Components (same as before)

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
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

class ErrorAlertCard extends StatelessWidget {
  final String errorTitle;
  final String timestamp;
  final IconData icon;
  final Color iconColor;

  const ErrorAlertCard({
    required this.errorTitle,
    required this.timestamp,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor,
          size: 30,
        ),
        title: Text(
          errorTitle,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
        subtitle: Text(
          timestamp,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}
