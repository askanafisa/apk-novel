class Novel {
  final String imagePath;
  final String title;
  final String author;
  final String description;
  final String genre;
  final double rating;
  final int readers;
  final List<String> content;

  Novel({
    required this.imagePath,
    required this.title,
    required this.author,
    required this.description,
    required this.genre,
    required this.rating,
    required this.readers,
    required this.content,
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
    content: [
      'Bab 1: Bayangan Pertama\nCahaya bulan mengungkap sosok misterius di hutan larangan...',
      'Bab 2: Kutukan Malam\nPenduduk desa mulai menghilang satu per satu...',
      'Bab 3: Sang Penjaga Rahasia\nTeka-teki kuno mulai terkuak saat Luna menemukan jurnal tersembunyi...',
    ],
  ),
  Novel(
    imagePath: 'assets/novel2.jpg',
    title: 'Hujan di Tengah Senja',
    author: 'Bima S.',
    description: 'Kisah cinta yang tak biasa di tengah kota yang sepi.',
    genre: 'Romantis',
    rating: 4.6,
    readers: 3100,
    content: [
      'Bab 1: Senja Pertama\nDi halte yang basah, tatapan pertama mereka bertemu...',
      'Bab 2: Rintik Rahasia\nSurat tanpa nama mulai muncul di bangku taman...',
      'Bab 3: Di Antara Hujan\nRahasia yang disimpan akhirnya membawa perpisahan...',
    ],
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
    content: [
      'Bab 1: Surat Tak Terkirim\nIa menulis setiap kata dengan harapan yang dalam...',
      'Bab 2: Kata yang Hilang\nPuisi-puisi itu mengandung jejak masa lalu yang belum usai...',
      'Bab 3: Suara Dalam Hati\nKebenaran akhirnya disuarakan lewat bait terakhir...',
    ],
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
    content: [
      'Bab 1: Sang Pewaris\nPangeran muda menemukan pedang warisan yang bersinar saat disentuh...',
      'Bab 2: Pasukan Kegelapan\nArzalia diserang oleh makhluk dari dimensi lain...',
      'Bab 3: Pengorbanan Terakhir\nHanya sihir kuno dan keberanian yang bisa menyelamatkan dunia...',
    ],
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
    content: [
      'Bab 1: Pintu yang Tidak Pernah Tertutup\nSuara langkah terdengar meski rumah itu kosong...',
      'Bab 2: Cermin Tua\nBayangan dalam cermin mulai bergerak sendiri...',
      'Bab 3: Malam Tanpa Akhir\nWaktu berhenti, dan mimpi buruk pun dimulai...',
    ],
  ),
];
