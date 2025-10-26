import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

// Gelişmiş LovelyChat - tek dosyalık örnek
// - Kayıt / profil formu (isim, soyisim, rumuz, kullanıcı adı, ülke)
// - Tüm ülkeler seçeneği (liste içinde)
// - Geliştirilmiş feed kartları, profesyonel tema
// - Basit state yönetimi (uygulama boyu global CurrentUser)
// - Sohbet lobisi / chat ekranı ve arkadaşlar

// =======================================================
// Basit global state (örnek amaçlı)
class CurrentUser {
  String firstName;
  String lastName;
  String nickname;
  String username;
  String country;

  CurrentUser({
    required this.firstName,
    required this.lastName,
    required this.nickname,
    required this.username,
    required this.country,
  });
}

CurrentUser? currentUser;
List<String> addedFriends = [];

void main() {
  runApp(const LovelyChatApp());
}

class LovelyChatApp extends StatelessWidget {
  const LovelyChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData.dark();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LovelyChat Pro',
      theme: base.copyWith(
        colorScheme: base.colorScheme.copyWith(
          primary: Colors.indigoAccent,
          secondary: Colors.pinkAccent,
        ),
        scaffoldBackgroundColor: const Color(0xFF0B1020),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
        ),
        textTheme: base.textTheme.apply(
          bodyColor: Colors.white70,
          displayColor: Colors.white,
        ),
      ),
      home: const EntryDecider(),
    );
  }
}

// Eğer kullanıcı kayıtlıysa direk ana ekrana, yoksa kayıt formuna yönlendir.
class EntryDecider extends StatefulWidget {
  const EntryDecider({super.key});

  @override
  State<EntryDecider> createState() => _EntryDeciderState();
}

class _EntryDeciderState extends State<EntryDecider> {
  @override
  void initState() {
    super.initState();
    // Örnek: 2 saniye splash
    Timer(const Duration(milliseconds: 900), () {
      if (currentUser == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RegistrationScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.auto_awesome, size: 88, color: Colors.pinkAccent),
            SizedBox(height: 12),
            Text('LovelyChat Pro', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 6),
            Text('Gelişmiş arayüz hazırlanıyor...', style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

// =======================================================
// Kayıt / Giriş Ekranı
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstCtrl = TextEditingController();
  final TextEditingController _lastCtrl = TextEditingController();
  final TextEditingController _nickCtrl = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController();
  String? _selectedCountry;

  // Kapsamlı ülke listesi (kısa, ama gerçek uygulamada tam liste eklenebilir)
  final List<String> _countries = [
    'Türkiye', 'United States', 'United Kingdom', 'Germany', 'France', 'Italy', 'Spain', 'Netherlands', 'Belgium', 'Sweden', 'Norway', 'Denmark', 'Finland', 'Switzerland', 'Austria', 'Poland', 'Portugal', 'Greece', 'Russia', 'China', 'Japan', 'South Korea', 'India', 'Brazil', 'Argentina', 'Mexico', 'South Africa', 'Australia', 'New Zealand', 'Egypt', 'Nigeria', 'Kenya', 'Saudi Arabia', 'United Arab Emirates', 'Israel', 'Ireland', 'Czech Republic', 'Hungary', 'Romania', 'Bulgaria', 'Croatia', 'Slovenia', 'Slovakia', 'Iceland', 'Luxembourg', 'Monaco', 'Liechtenstein', 'Andorra', 'San Marino'
  ];

  @override
  void initState() {
    super.initState();
    _selectedCountry = _countries.first;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      currentUser = CurrentUser(
        firstName: _firstCtrl.text.trim(),
        lastName: _lastCtrl.text.trim(),
        nickname: _nickCtrl.text.trim(),
        username: _usernameCtrl.text.trim(),
        country: _selectedCountry ?? '',
      );

      // Basit hoşgeldin ekranını göster ve ana ekrana geç
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: const Color(0xFF0F1624),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.verified_user, size: 36, color: Colors.pinkAccent),
                        SizedBox(width: 12),
                        Text('Hoşgeldin!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Lütfen profil bilgilerini doldur – diğer kullanıcılar seni bu bilgilerle görecek.'),
                    const SizedBox(height: 14),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(_firstCtrl, 'Ad', 'Örn: Ahmet'),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildTextField(_lastCtrl, 'Soyad', 'Örn: Yılmaz'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(_nickCtrl, 'Rumuz (görünen isim)', 'Örn: Ahmet42', required: true),
                          const SizedBox(height: 12),
                          _buildTextField(_usernameCtrl, 'Kullanıcı Adı (tekrarsız)', 'Örn: ahmet_y', required: true),
                          const SizedBox(height: 12),
                          _buildCountryDropdown(),
                          const SizedBox(height: 18),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: _submit,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.play_arrow),
                                SizedBox(width: 8),
                                Text('Uygulamayı Başlat', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              // Demo: hızlı doldur (kullanıcı testleri için)
                              setState(() {
                                _firstCtrl.text = 'Demo';
                                _lastCtrl.text = 'Kullanıcı';
                                _nickCtrl.text = 'DemoRumuz';
                                _usernameCtrl.text = 'demo_user';
                                _selectedCountry = 'Türkiye';
                              });
                            },
                            child: const Text('Hızlı Demo Doldur'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String label, String hint, {bool required = false}) {
    return TextFormField(
      controller: ctrl,
      style: const TextStyle(color: Colors.white),
      validator: (v) {
        if (required && (v == null || v.trim().isEmpty)) return '$label gerekli';
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFF111826),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildCountryDropdown() {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Ülke',
        filled: true,
        fillColor: const Color(0xFF111826),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: _selectedCountry,
          items: _countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
          onChanged: (v) => setState(() => _selectedCountry = v),
        ),
      ),
    );
  }
}

// =======================================================
// Ana Sayfa / Bottom Navigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const FeedScreen(),
    const ProfileScreen(),
    const SocialScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ChatLobby(friends: addedFriends)));
            },
          )
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF071026),
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Akış'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Sosyal'),
        ],
        onTap: (i) => setState(() => _currentIndex = i),
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton.extended(
        onPressed: () => _showCreatePost(context),
        icon: const Icon(Icons.add),
        label: const Text('Gönderi Oluştur'),
        backgroundColor: Colors.pinkAccent,
      )
          : null,
    );
  }

  Widget _buildTitle() {
    if (currentUser == null) return const Text('LovelyChat Pro');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.indigoAccent,
          child: Text(currentUser!.nickname.substring(0, 1).toUpperCase()),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${currentUser!.nickname}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('${currentUser!.country}', style: const TextStyle(fontSize: 10, color: Colors.white70)),
          ],
        )
      ],
    );
  }

  void _showCreatePost(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: const Color(0xFF071026),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        final TextEditingController _postCtrl = TextEditingController();
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Yeni Gönderi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _postCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Ne düşünüyorsun?',
                  filled: true,
                  fillColor: Color(0xFF0F1624),
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('İptal')),
                  ElevatedButton(
                    onPressed: () {
                      if (_postCtrl.text.trim().isNotEmpty) {
                        // Demo: feed'e ekleme için global stream yerine basit çözüm
                        demoPosts.insert(0, {
                          'user': currentUser?.nickname ?? 'Anonim',
                          'content': _postCtrl.text.trim(),
                          'time': DateTime.now().toIso8601String(),
                        });
                        Navigator.pop(ctx);
                        setState(() {});
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                    child: const Text('Paylaş'),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

// =======================================================
// Demo gönderiler (gelişmiş kartlarla gösterilecek)
List<Map<String, String>> demoPosts = [
  {
    'user': 'Esra',
    'content': 'Bugün Lov3lyChat’te çok güzel insanlarla tanıştım 💜',
    'time': '2025-10-01T10:02:00'
  },
  {'user': 'Can', 'content': 'Kahvemi aldım, sohbet etmeye geldim ☕', 'time': '2025-10-05T18:12:00'},
  {'user': 'Merve', 'content': 'Uygulama her geçen gün daha keyifli hale geliyor 😍', 'time': '2025-09-15T08:30:00'},
  {'user': 'Elif', 'content': 'Akşam sohbetleri buradaysa, başka yere gitmem 🌙', 'time': '2025-08-28T21:40:00'},
];

// =======================================================
// Feed Screen (gelişmiş kartlar)
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 700));
        setState(() {});
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: demoPosts.length,
        itemBuilder: (_, i) {
          final post = demoPosts[i];
          return _PostCard(
            author: post['user']!,
            content: post['content']!,
            timeIso: post['time']!,
            onLike: () => setState(() {}),
            onComment: () => _openComments(context, post),
          );
        },
      ),
    );
  }

  void _openComments(BuildContext ctx, Map<String, String> post) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: const Color(0xFF071026),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Yorumlar - ${post['user']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              const Text('Henüz yorum yok. Bu bölüm ileride gerçek yorumlarla dolacak.'),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(hintText: 'Yorum ekle...', filled: true, fillColor: Color(0xFF0F1624), border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(12)))),
              ),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Kapat')), ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent), child: const Text('Gönder'))])
            ],
          ),
        );
      },
    );
  }
}

class _PostCard extends StatelessWidget {
  final String author;
  final String content;
  final String timeIso;
  final VoidCallback onLike;
  final VoidCallback onComment;

  const _PostCard({required this.author, required this.content, required this.timeIso, required this.onLike, required this.onComment});

  String _timeAgo(String iso) {
    try {
      final dt = DateTime.parse(iso);
      final diff = DateTime.now().difference(dt);
      if (diff.inDays > 7) return '${dt.day}/${dt.month}/${dt.year}';
      if (diff.inDays >= 1) return '${diff.inDays}g';
      if (diff.inHours >= 1) return '${diff.inHours}s';
      if (diff.inMinutes >= 1) return '${diff.inMinutes}d';
      return 'az önce';
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF0E1622),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 22, backgroundColor: Colors.indigoAccent, child: Text(author.substring(0, 1).toUpperCase())),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(author, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 2),
                      Text(_timeAgo(timeIso), style: const TextStyle(fontSize: 12, color: Colors.white70)),
                    ],
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz, color: Colors.white70))
              ],
            ),
            const SizedBox(height: 10),
            Text(content, style: const TextStyle(fontSize: 15, height: 1.35)),
            const SizedBox(height: 12),
            Row(
              children: [
                InkWell(onTap: onLike, child: Row(children: const [Icon(Icons.thumb_up, size: 18), SizedBox(width: 6), Text('Beğen')])),
                const SizedBox(width: 18),
                InkWell(onTap: onComment, child: Row(children: const [Icon(Icons.chat_bubble_outline, size: 18), SizedBox(width: 6), Text('Yorum')])),
                const Spacer(),
                ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.indigoAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: const Text('Paylaş'))
              ],
            )
          ],
        ),
      ),
    );
  }
}

// =======================================================
// Sosyal Ekran (Arkadaş ekleme)
class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  final List<String> _friends = ['Esra', 'Ceyda', 'Merve', 'Elif', 'Ahmet', 'Ayşe', 'Can', 'Derya', 'Kadir', 'Selin'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sosyal'), backgroundColor: Colors.transparent),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _friends.length,
        itemBuilder: (_, i) {
          final f = _friends[i];
          final isAdded = addedFriends.contains(f);
          return Card(
            color: const Color(0xFF071026),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.pinkAccent, child: Text(f[0].toUpperCase())),
              title: Text(f, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Aktif • ${Random().nextInt(59)+1} dk önce', style: const TextStyle(fontSize: 12, color: Colors.white70)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: isAdded ? Colors.grey : Colors.indigoAccent),
                onPressed: isAdded
                    ? null
                    : () {
                  setState(() {
                    addedFriends.add(f);
                  });
                },
                child: Text(isAdded ? 'Eklendi' : 'Ekle'),
              ),
            ),
          );
        },
      ),
    );
  }
}

// =======================================================
// Chat Lobisi ve Chat ekranı
class ChatLobby extends StatelessWidget {
  final List<String> friends;
  const ChatLobby({super.key, required this.friends});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DM'), backgroundColor: Colors.transparent),
      body: friends.isEmpty
          ? const Center(child: Text('Henüz arkadaş eklemediniz 😢'))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: friends.length,
        itemBuilder: (_, i) {
          final f = friends[i];
          return Card(
            color: const Color(0xFF071026),
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.indigoAccent, child: Text(f[0].toUpperCase())),
              title: Text(f, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Son mesaj: Görüldü', style: TextStyle(fontSize: 12)),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(botName: f))),
            ),
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String botName;
  const ChatScreen({super.key, required this.botName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _ctrl = TextEditingController();
  final List<Map<String, String>> _msgs = [];
  final Map<String, List<String>> _responses = {
    'Esra': ['Merhaba! Nasılsın?', 'Bugün çok güzelim 💜'],
    'Ceyda': ['Kahveye hayır diyemezsin 😄', 'Güzel bir sohbet olsun istiyorum.'],
    'Merve': ['Yeni bir film izledin mi?', 'Harika!'],
  };

  void _send(String t) {
    if (t.trim().isEmpty) return;
    setState(() {
      _msgs.insert(0, {'sender': 'Sen', 'msg': t});
    });
    _ctrl.clear();
    Future.delayed(const Duration(milliseconds: 700), () {
      final replies = _responses[widget.botName] ?? ['Selam!', 'Anlayamadım 😅', 'Hahaha'];
      final r = replies[Random().nextInt(replies.length)];
      setState(() => _msgs.insert(0, {'sender': widget.botName, 'msg': r}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(children: [CircleAvatar(backgroundColor: Colors.pinkAccent, child: Text(widget.botName[0].toUpperCase())), const SizedBox(width: 8), Text(widget.botName)])),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(12),
              itemCount: _msgs.length,
              itemBuilder: (_, i) {
                final m = _msgs[i];
                final me = m['sender'] == 'Sen';
                return Align(
                  alignment: me ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(color: me ? Colors.pinkAccent : const Color(0xFF0E1622), borderRadius: BorderRadius.circular(12)),
                    child: Text(m['msg']!, style: const TextStyle(color: Colors.white)),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: const Color(0xFF071026),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: const InputDecoration(hintText: 'Mesaj yaz...', filled: true, fillColor: Color(0xFF0F1624), border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(12)))),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(icon: const Icon(Icons.send, color: Colors.pinkAccent), onPressed: () => _send(_ctrl.text))
              ],
            ),
          )
        ],
      ),
    );
  }
}

// =======================================================
// Profil Ekranı
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Profil'), backgroundColor: Colors.transparent),
      body: user == null
          ? const Center(child: Text('Kayıtlı kullanıcı yok'))
          : Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(radius: 46, backgroundColor: Colors.indigoAccent, child: Text(user.nickname.substring(0, 1).toUpperCase(), style: const TextStyle(fontSize: 30))),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${user.firstName} ${user.lastName}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text('@${user.username}', style: const TextStyle(color: Colors.white70)),
                      const SizedBox(height: 6),
                      Row(children: [const Icon(Icons.location_on, size: 14, color: Colors.white70), const SizedBox(width: 6), Text(user.country)]),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Card(
              color: const Color(0xFF071026),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _statColumn('Arkadaş', addedFriends.length.toString()),
                    _statColumn('Gönderi', demoPosts.length.toString()),
                    _statColumn('Beğeni', (Random().nextInt(500) + 20).toString()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.edit), label: const Text('Profili Düzenle'), style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent)),
            const SizedBox(height: 8),
            OutlinedButton.icon(onPressed: () {
              // Çıkış (demo): currentUser'i null yap ve kayıt ekranına yönlendir
              currentUser = null;
              addedFriends.clear();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RegistrationScreen()));
            }, icon: const Icon(Icons.logout), label: const Text('Çıkış Yap'))
          ],
        ),
      ),
    );
  }

  Widget _statColumn(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
