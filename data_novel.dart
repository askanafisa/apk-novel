class Novel {
  final String imagePath;
  final String title;
  final String author;
  final String description;
  final String genre;
  final double rating;
  final int readers;


  Novel({
    required this.imagePath,
    required this.title,
    required this.author,
    required this.description,
    required this.genre,
    required this.rating,
    required this.readers,
  });
}

List<Novel> populerNovels = [
  Novel(
    imagePath: 'assets/novel1.jpg',
    title: 'Dark Moon',
    author: 'Helen Heney',
    description: 'Sebuah kisah misteri penuh rahasia gelap di balik cahaya bulan.',
    genre: 'Fantasi',
    rating: 4.8,
    readers: 2450,
  ),
  Novel(
    imagePath: 'assets/novel2.jpg',
    title: 'Hujan di Tengah Senja',
    author: 'Bima S.',
    description: 'Kisah cinta yang tak biasa di tengah kota yang sepi.',
    genre: 'Romantis',
    rating: 4.6,
    readers: 3100,
  ),
];

List<Novel> romantisNovels = [
  Novel(
    imagePath: 'assets/novel3.jpg',
    title: 'Cinta di Balik Kata',
    author: 'Nadia F.',
    description: 'Romansa dan drama yang tertulis dalam puisi dan surat cinta.',
    genre: 'Romantis',
    rating: 4.7,
    readers: 4000,
  ),
];

List<Novel> fantasiNovels = [
  Novel(
    imagePath: 'assets/novel4.jpg',
    title: 'Legenda Arzalia',
    author: 'Raihan N.',
    description: 'Pertarungan epik di dunia sihir dan kerajaan yang megah.',
    genre: 'Fantasi',
    rating: 4.9,
    readers: 5000,
  ),
];

List<Novel> hororNovels = [
  Novel(
    imagePath: 'assets/novel5.jpg',
    title: 'Malam Tak Berujung',
    author: 'Laras A.',
    description: 'Sebuah rumah tua menyimpan rahasia mengerikan di setiap sudutnya.',
    genre: 'Horor',
    rating: 4.5,
    readers: 1800,
  ),
];


