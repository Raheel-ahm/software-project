import 'package:flutter/material.dart';

class TaskSchedulerScreen extends StatefulWidget {
  const TaskSchedulerScreen({Key? key}) : super(key: key);

  @override
  _TaskSchedulerScreenState createState() => _TaskSchedulerScreenState();
}

class _TaskSchedulerScreenState extends State<TaskSchedulerScreen> {
  String? _taskName;
  String? _taskDescription;
  DateTime? _dueDate;
  String? _selectedPriority;
  String? _selectedStatus;
  final List<Map<String, dynamic>> _tasks = [];

  // Function to format the selected date
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  // Function to add a new task
  void _addTask() {
    if (_taskName != null &&
        _taskDescription != null &&
        _dueDate != null &&
        _selectedPriority != null &&
        _selectedStatus != null) {
      setState(() {
        _tasks.add({
          'name': _taskName,
          'description': _taskDescription,
          'dueDate': _dueDate,
          'priority': _selectedPriority,
          'status': _selectedStatus,
        });
        _taskName = null;
        _taskDescription = null;
        _dueDate = null;
        _selectedPriority = null;
        _selectedStatus = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields!')),
      );
    }
  }

  // Function to delete a task
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // Function to edit a task
  void _editTask(int index) {
    Map<String, dynamic> task = _tasks[index];
    _taskName = task['name'];
    _taskDescription = task['description'];
    _dueDate = task['dueDate'];
    _selectedPriority = task['priority'];
    _selectedStatus = task['status'];

    // Delete the task and allow the user to re-edit it
    _deleteTask(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Task Management'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blueGrey.shade900,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Task Scheduler',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Task Progress Cards
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Current Tasks',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Display list of tasks
            ..._tasks.map((task) {
              return TaskProgressCard(
                taskName: task['name'],
                description: task['description'],
                dueDate: _formatDate(task['dueDate']),
                priority: task['priority'],
                status: task['status'],
                onEdit: () => _editTask(_tasks.indexOf(task)),
                onDelete: () => _deleteTask(_tasks.indexOf(task)),
              );
            }).toList(),

            const SizedBox(height: 20),

            // Add New Task Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Add a New Task',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            // Task Name Input
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _taskName = value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade900,
                  hintText: 'Enter task name',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // Task Description Input
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _taskDescription = value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade900,
                  hintText: 'Enter task description',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // Row for Due Date and Priority
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  // Due Date Picker
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      readOnly: true, // Prevent keyboard from appearing
                      onTap: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            _dueDate = selectedDate;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade900,
                        hintText: _dueDate == null
                            ? 'Due Date'
                            : _formatDate(_dueDate!),
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Priority Dropdown
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedPriority,
                      dropdownColor: Colors.grey.shade900,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade900,
                        hintText: 'Priority',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'High',
                          child: Text('High Priority'),
                        ),
                        DropdownMenuItem(
                          value: 'Medium',
                          child: Text('Medium Priority'),
                        ),
                        DropdownMenuItem(
                          value: 'Low',
                          child: Text('Low Priority'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Task Status Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonFormField<String>(
                value: _selectedStatus,
                dropdownColor: Colors.grey.shade900,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade900,
                  hintText: 'Task Status',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Pending',
                    child: Text('Pending'),
                  ),
                  DropdownMenuItem(
                    value: 'In Progress',
                    child: Text('In Progress'),
                  ),
                  DropdownMenuItem(
                    value: 'Completed',
                    child: Text('Completed'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            // Add Task Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                onPressed: _addTask,
                child: const Text(
                  'Add Task',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskProgressCard extends StatelessWidget {
  final String taskName;
  final String description;
  final String dueDate;
  final String priority;
  final String status;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskProgressCard({
    required this.taskName,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.status,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: Colors.grey.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskName,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 5),
              Text(
                'Due Date: $dueDate',
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                'Priority: $priority',
                style: TextStyle(
                  fontSize: 14,
                  color: priority == 'High'
                      ? Colors.red
                      : priority == 'Medium'
                          ? Colors.orange
                          : Colors.green,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Status: $status',
                style: TextStyle(
                  fontSize: 14,
                  color: status == 'Completed'
                      ? Colors.green
                      : status == 'In Progress'
                          ? Colors.orange
                          : Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  TextButton(
                    onPressed: onEdit,
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  TextButton(
                    onPressed: onDelete,
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
