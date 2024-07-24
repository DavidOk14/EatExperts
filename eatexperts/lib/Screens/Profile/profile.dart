import 'package:flutter/material.dart';
import 'package:eatexperts/theme/style.dart'; // Adjust if necessary

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = "Dylan Nguyen";

  void _editUserName() async {
    final newName = await showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: _userName);

        return AlertDialog(
          title: const Text("Edit Name"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );

    if (newName != null && newName.isNotEmpty) {
      setState(() {
        _userName = newName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: SizedBox(
          height: 80,
          width: 80,
          child: Image.asset("assets/EElogo.png"),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.black),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset("assets/user_profile.JPEG"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: _editUserName,
                    child: Text(
                      _userName,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 20),
            _settingsItem(
              title: "Language",
              prefixIcon: Icons.language,
            ),
            const SizedBox(height: 15),
            _settingsItem(
              title: "Help",
              prefixIcon: Icons.help,
            ),
            const SizedBox(height: 15),
            _settingsItem(
              title: "Theme",
              prefixIcon: Icons.light_mode_outlined,
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _settingsItem({String? title, IconData? prefixIcon}) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: lightGreyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(prefixIcon, size: 30),
              const SizedBox(width: 10),
              Text("$title", style: const TextStyle(fontSize: 16)),
            ],
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
