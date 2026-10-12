
import 'package:flutter/material.dart';

void main() {
  runApp(const StoryRecapApp());
}

class StoryRecapApp extends StatelessWidget {
  const StoryRecapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StoryRecap AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleController =
      TextEditingController();

  String genre = 'សកម្មភាព';
  double duration = 30;

  final List<String> genres = [
    'សកម្មភាព',
    'ស្នេហា',
    'ភ័យរន្ធត់',
    'កំប្លែង',
    'រន្ធត់អាថ៌កំបាំង',
    'រឿងភាគ',
  ];

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void prepareRecap() {
    final title = titleController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('សូមបញ្ចូលឈ្មោះរឿងជាមុនសិន។'),
        ),
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ព័ត៌មានសម្រាយរឿង'),
        content: Text(
          'ឈ្មោះរឿង៖ $title\n'
          'ប្រភេទ៖ $genre\n'
          'រយៈពេលគោលដៅ៖ ${duration.round()} នាទី\n\n'
          'នេះជាការកំណត់ព័ត៌មានដំបូង។ '
          'មុខងារ AI នឹងត្រូវភ្ជាប់នៅជំហានបន្ទាប់។',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('យល់ព្រម'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StoryRecap AI'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Icon(
              Icons.movie_creation_outlined,
              size: 76,
              color: Colors.deepPurpleAccent,
            ),
            const SizedBox(height: 16),
            const Text(
              'AI Movie Recap Studio',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'បង្កើតស្គ្រីបសម្រាយរឿងសម្រាប់ YouTube',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'ឈ្មោះរឿង',
                hintText: 'បញ្ចូលឈ្មោះភាពយន្ត',
                prefixIcon: Icon(Icons.movie),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: genre,
              decoration: const InputDecoration(
                labelText: 'ប្រភេទរឿង',
                prefixIcon: Icon(Icons.category_outlined),
                border: OutlineInputBorder(),
              ),
              items: genres.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => genre = value);
                }
              },
            ),
            const SizedBox(height: 26),
            Text(
              'រយៈពេលសម្រាយ៖ ${duration.round()} នាទី',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: duration,
              min: 1,
              max: 90,
              divisions: 89,
              label: '${duration.round()} នាទី',
              onChanged: (value) {
                setState(() => duration = value);
              },
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1 នាទី'),
                Text('90 នាទី'),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: prepareRecap,
                icon: const Icon(Icons.auto_awesome),
                label: const Text('រៀបចំសម្រាយរឿង'),
              ),
            ),
            const SizedBox(height: 24),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'ជំហានបន្ទាប់៖ ភ្ជាប់ AI '
                        'បង្កើតស្គ្រីបជាផ្នែកៗ '
                        'បង្កើតសំឡេង និងវីដេអូ MP4។',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
