import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "Aska Nafisa";
  String userBio = "Pembaca Setia sejak 2023";
  String userPhoto = "https://randomuser.me/api/portraits/women/65.jpg";

  late TextEditingController nameController;
  late TextEditingController bioController;

  // contoh data stats
  int followers = 240;
  int following = 180;
  int booksRead = 128;
  int favorites = 24;
  int readingHours = 356;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: userName);
    bioController = TextEditingController(text: userBio);
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  // Fungsi logout
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    final colorScheme = Theme.of(context).colorScheme;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Konfirmasi Logout"),
          content: const Text("Apakah kamu yakin ingin keluar?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _logout(context);
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  // Edit profil popup
  void _editProfile() {
    nameController.text = userName;
    bioController.text = userBio;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Profil"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: bioController,
              decoration: const InputDecoration(labelText: "Bio"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                userName = nameController.text;
                userBio = bioController.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    final mainStats = [
      {
        "icon": Icons.menu_book,
        "value": booksRead.toString(),
        "label": "Buku Dibaca",
      },
      {
        "icon": Icons.star_border,
        "value": favorites.toString(),
        "label": "Favorit",
      },
      {
        "icon": Icons.access_time,
        "value": "${readingHours}h",
        "label": "Jam Membaca",
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              title: const Text("Profil Saya"),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary,
                      colorScheme.primary.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Foto profil + ikon edit
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colorScheme.primary,
                            width: 3,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            userPhoto,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.person, size: 60),
                              );
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _editProfile,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark ? Colors.black : Colors.white,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.edit,
                            size: 20,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Nama & bio
                    Text(
                      userName,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(userBio, style: TextStyle(color: textColor)),
                  const SizedBox(height: 20),

                  // Followers & Following (Chip style dari kode 1)
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      _buildFollowChip("Followers", followers, Colors.blue),
                      _buildFollowChip("Following", following, Colors.green),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Stats Grid (versi kode 1)
                  _buildStatsGrid(context, mainStats),
                  const SizedBox(height: 24),

                  // Menu Items
                  _buildProfileMenuItem(
                    context,
                    icon: Icons.person_outline,
                    title: 'Edit Profil',
                    onTap: _editProfile,
                  ),
                  _buildProfileMenuItem(
                    context,
                    icon: Icons.history,
                    title: 'Riwayat Baca',
                    onTap: () {},
                  ),
                  _buildProfileMenuItem(
                    context,
                    icon: Icons.bookmark_border,
                    title: 'Koleksi Saya',
                    onTap: () {},
                  ),
                  _buildProfileMenuItem(
                    context,
                    icon: Icons.settings_outlined,
                    title: 'Pengaturan',
                    onTap: () {},
                  ),
                  _buildProfileMenuItem(
                    context,
                     icon: Icons.storage,
                     title: ' CRUD Test',
                     onTap: () {
                      Navigator.pushNamed(context, '/crud');
                     },
                  ),
                  const SizedBox(height: 30),

                  // Tombol logout
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => _showLogoutDialog(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: colorScheme.error),
                      ),
                      child: Text(
                        "Keluar",
                        style: TextStyle(color: colorScheme.error),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Follow Chip
  Widget _buildFollowChip(String label, int value, Color color) {
    return Chip(
      backgroundColor: color.withOpacity(0.1),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$value ",
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          Text(label, style: GoogleFonts.poppins()),
        ],
      ),
    );
  }

  // Widget Stats Grid
  Widget _buildStatsGrid(
    BuildContext context,
    List<Map<String, dynamic>> stats,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: stats
              .map(
                (s) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(s["icon"], color: colorScheme.primary, size: 28),
                    const SizedBox(height: 6),
                    Text(
                      s["value"].toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(s["label"], textAlign: TextAlign.center),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildProfileMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 28),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
