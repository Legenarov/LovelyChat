import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const LovelyChatApp());
}

List<String> addedFriends = [];

class LovelyChatApp extends StatelessWidget {
  const LovelyChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LovelyChat',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.deepPurpleAccent,
          secondary: Colors.deepPurpleAccent,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _fade = Tween<double>(begin: 0.3, end: 1).animate(_controller);

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.auto_awesome, size: 100, color: Colors.amber),
              const SizedBox(height: 20),
              Text(
                "HEK SOFTWARE GURURLA SUNAR",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[300],
                  shadows: const [
                    Shadow(blurRadius: 20, color: Colors.white),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                "🎆 Hoşgeldiniz 🎆",
                style: TextStyle(fontSize: 22, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      appBar: _currentIndex == 0
          ? AppBar(
              title: const Text("Lov3lyChat"),
              centerTitle: true,
              backgroundColor: Colors.deepPurpleAccent,
              actions: [
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatLobby(friends: addedFriends),
                      ),
                    );
                  },
                ),
              ],
            )
          : null,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Sayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Arkadaşlar"),
        ],
        onTap: (i) {
          setState(() => _currentIndex = i);
        },
      ),
    );
  }
}

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = [
      {"user": "Esra", "content": "Bugün Lov3lyChat’te çok güzel insanlarla tanıştım 💜"},
      {"user": "Can", "content": "Kahvemi aldım, sohbet etmeye geldim ☕"},
      {"user": "Merve", "content": "Uygulama her geçen gün daha keyifli hale geliyor 😍"},
      {"user": "Ahmet", "content": "Yeni insanlarla tanışmak güzel bir his 😊"},
      {"user": "Elif", "content": "Akşam sohbetleri buradaysa, başka yere gitmem 🌙"},
      {"user": "Ayşe", "content": "Günün stresini burada atıyorum 💬"},
      {"user": "Ceyda", "content": "Yeni gün, yeni sohbetler! 💫"},
      {"user": "Derya", "content": "Müzik ve sohbet, mükemmel ikili 🎧"},
      {"user": "Hakan", "content": "Küçük bir mola, büyük bir gülümseme 😄"},
      {"user": "Selin", "content": "Sohbetlerin enerjisi harika bugün! ⚡"},
      {"user": "Efe", "content": "Teknoloji + samimiyet = Lov3lyChat ❤️"},
      {"user": "Zeynep", "content": "Herkese güzel bir gün diliyorum 🌼"},
      {"user": "Kerem", "content": "Biraz muhabbet, biraz kahkaha 😂"},
      {"user": "Melis", "content": "Yeni arkadaşlıklar kurmak ne güzel 💕"},
      {"user": "Tuna", "content": "Günün yorgunluğunu burada atıyorum 😌"},
      {"user": "Gizem", "content": "Bu uygulamayı cidden çok sevdim 💜"},
      {"user": "Emre", "content": "Sohbetler güzel gidiyor, devam! 🚀"},
      {"user": "Nil", "content": "Bugün herkes çok pozitif, bayıldım 🌸"},
      {"user": "Burak", "content": "Biraz sohbet biraz neşe 🎉"},
      {"user": "Yasemin", "content": "Burada olmak çok keyifli 🌈"},
    ];

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (_, index) {
        final post = posts[index];
        return Card(
          color: Colors.grey[900],
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post["user"]!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.amber),
                ),
                const SizedBox(height: 8),
                Text(
                  post["content"]!,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  final List<String> friends = [
    "Esra",
    "Ceyda",
    "Merve",
    "Elif",
    "Ahmet",
    "Ayşe",
    "Can",
    "Derya"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sosyal"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: friends.length,
        itemBuilder: (_, i) {
          final friend = friends[i];
          final isAdded = addedFriends.contains(friend);

          return Card(
            color: Colors.deepPurple[700],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.amber,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                friend,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent),
                onPressed: isAdded
                    ? null
                    : () {
                        setState(() {
                          addedFriends.add(friend);
                        });
                      },
                child: Text(isAdded ? "Eklendi" : "İstek At"),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ChatLobby extends StatelessWidget {
  final List<String> friends;
  const ChatLobby({super.key, required this.friends});

  @override
  Widget build(BuildContext context) {
    if (friends.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("DM"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: const Center(
          child: Text(
            "Henüz arkadaş eklemediniz 😢",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("DM"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: friends.length,
        itemBuilder: (_, i) {
          return Card(
            color: Colors.deepPurple[700],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.amber,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                friends[i],
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(botName: friends[i]),
                  ),
                );
              },
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
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  final Map<String, List<String>> _responses = {
    "Esra": ["Merhaba! Nasılsın?", "Bugün çok güzelim 💜"],
    "Ceyda": ["Kahveye hayır diyemezsin 😄", "Güzel bir sohbet olsun istiyorum."],
    "Merve": ["Yeni bir film izledin mi?", "Anlayamadım canım, tekrar yazar mısın?"],
    "Elif": ["Aynı bildiğin gibi 😅", "Seninle konuşmak keyifli 💫"],
    "Ahmet": ["Selam! Nasılsın?", "Bugün iş yoğun muydu?"],
    "Ayşe": ["Merhaba! Planların nasıl?", "Güzel bir gün dilerim 💖"],
    "Can": ["Nasılsın dostum?", "Eyvallah kral ☕"],
    "Derya": ["Selam!", "Sohbet etmeye hazır mısın? 💫"],
  };

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.insert(0, {"sender": "Sen", "msg": text});
    });
    _controller.clear();

    Future.delayed(const Duration(milliseconds: 700), () {
      final replies = _responses[widget.botName] ??
          ["Merhaba!", "Hahaha 😄", "Bunu anlamadım"];
      final botReply = replies[Random().nextInt(replies.length)];
      setState(() {
        _messages.insert(0, {"sender": widget.botName, "msg": botReply});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.botName),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final msg = _messages[i];
                final isUser = msg["sender"] == "Sen";
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Colors.deepPurpleAccent
                          : Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg["msg"]!,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.black,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Mesaj yaz...",
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                IconButton(
                  icon:
                      const Icon(Icons.send, color: Colors.deepPurpleAccent),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.deepPurpleAccent,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              "Kullanıcı Adı: Guest123",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              "Email: guest123@hotmail.com",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.settings),
              label: const Text("Ayarlar"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
