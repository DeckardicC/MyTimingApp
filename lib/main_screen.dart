import 'package:flutter/material.dart';
import 'vr_page.dart';
import 'kh_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController _iconController;
  late AnimationController _button1Controller;
  late AnimationController _button2Controller;
  late Animation<double> _iconAnimation;
  late Animation<double> _button1Animation;
  late Animation<double> _button2Animation;

  @override
  void initState() {
    super.initState();
    
    // Иконка крутится медленно
    _iconController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    
    _iconAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.linear),
    );
    
    // Кнопки появляются с интервалом
    _button1Controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _button2Controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _button1Animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _button1Controller, curve: Curves.easeOutCubic),
    );
    
    _button2Animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _button2Controller, curve: Curves.easeOutCubic),
    );
    
    // Запускаем анимации появления
    Future.delayed(const Duration(milliseconds: 300), () {
      _button1Controller.forward();
    });
    
    Future.delayed(const Duration(milliseconds: 500), () {
      _button2Controller.forward();
    });
  }

  @override
  void dispose() {
    _iconController.dispose();
    _button1Controller.dispose();
    _button2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Анимированная иконка
                    RotationTransition(
                      turns: _iconAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/icon/icon.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'MyTiming',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Генератор таймингов',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 60),
                    // Анимированные кнопки
                    FadeTransition(
                      opacity: _button1Animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(_button1Animation),
                        child: _buildModernButton(
                          context,
                          'Виарки',
                          Icons.view_in_ar,
                          () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const VRPage(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(1.0, 0),
                                        end: Offset.zero,
                                      ).animate(CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeInOutCubic,
                                      )),
                                      child: child,
                                    ),
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 400),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _button2Animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(_button2Animation),
                        child: _buildModernButton(
                          context,
                          'КХ / Космобаза',
                          Icons.home,
                          () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const KHPage(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(1.0, 0),
                                        end: Offset.zero,
                                      ).animate(CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeInOutCubic,
                                      )),
                                      child: child,
                                    ),
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 400),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Разработано Видякиным Дмитрием',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'тг @Deckardic',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 200),
      tween: Tween<double>(begin: 1.0, end: 1.0),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 280,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6366F1).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


