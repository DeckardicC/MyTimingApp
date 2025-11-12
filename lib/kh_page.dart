import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'kh_timing_generator.dart';

class KHPage extends StatefulWidget {
  const KHPage({super.key});

  @override
  State<KHPage> createState() => _KHPageState();
}

class _KHPageState extends State<KHPage> {
  String? selectedPlace;
  String? selectedHall;
  String? selectedTiming;
  String? selectedFood;
  String? selectedGame;
  final TextEditingController timeController = TextEditingController();
  final TextEditingController programController = TextEditingController();
  final TextEditingController showController = TextEditingController();
  final TextEditingController resultController = TextEditingController();
  final KHTimingGenerator timingGenerator = KHTimingGenerator();
  final ScrollController scrollController = ScrollController();

  final List<String> places = ['Крейзи Хаус', 'Космобаза'];
  final List<String> halls = ['Большой зал', 'Малый зал'];
  final List<String> foodOptions = ['Еда в начале', 'Еда после игры'];
  final List<String> games = ['Лазертаг', 'Амонг Ас', 'Прятки в темноте'];

  List<String> get availableTimings {
    if (selectedHall == "Большой зал") {
      return ['Минимальный БЗ', 'Стандарт БЗ', 'Максимальный БЗ', 'Мега БЗ'];
    } else if (selectedHall == "Малый зал") {
      return ['Минимальный МЗ', 'Стандарт МЗ', 'Максимальный МЗ'];
    }
    return [];
  }

  bool get needsGame {
    return selectedPlace == "Космобаза" || selectedTiming == "Мега БЗ";
  }

  bool get needsProgram {
    if (selectedHall == "Большой зал") {
      return true;
    } else if (selectedHall == "Малый зал") {
      return selectedTiming == "Стандарт МЗ" || selectedTiming == "Максимальный МЗ";
    }
    return false;
  }

  bool get needsShow {
    if (selectedHall == "Большой зал") {
      return selectedTiming == "Стандарт БЗ" || 
             selectedTiming == "Максимальный БЗ" || 
             selectedTiming == "Мега БЗ";
    } else if (selectedHall == "Малый зал") {
      return selectedTiming == "Минимальный МЗ" || selectedTiming == "Максимальный МЗ";
    }
    return false;
  }

  @override
  void dispose() {
    timeController.dispose();
    programController.dispose();
    showController.dispose();
    resultController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _selectPlace(String place) {
    setState(() {
      selectedPlace = place;
      selectedHall = null;
      selectedTiming = null;
      selectedGame = null;
      resultController.clear();
    });
  }

  void _selectHall(String hall) {
    setState(() {
      selectedHall = hall;
      selectedTiming = null;
      resultController.clear();
    });
  }

  void _selectTiming(String timing) {
    setState(() {
      selectedTiming = timing;
      resultController.clear();
    });
  }

  void _selectFood(String food) {
    setState(() {
      selectedFood = food;
    });
  }

  void _selectGame(String game) {
    setState(() {
      selectedGame = game;
    });
  }

  void _generateTiming() {
    if (selectedPlace == null || 
        selectedHall == null || 
        selectedTiming == null || 
        selectedFood == null ||
        timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Заполните все обязательные поля'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    if (needsGame && selectedGame == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Выберите игру на арене'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    final result = timingGenerator.generateTiming(
      place: selectedPlace!,
      hall: selectedHall!,
      timing: selectedTiming!,
      time: timeController.text,
      food: selectedFood!,
      game: selectedGame,
      program: programController.text.isNotEmpty ? programController.text : null,
      show: showController.text.isNotEmpty ? showController.text : null,
    );

    setState(() {
      resultController.text = result;
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _copyToClipboard() {
    if (resultController.text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: resultController.text));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Тайминг скопирован в буфер обмена'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'КХ / Космобаза',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 400),
        tween: Tween<double>(begin: 0.0, end: 1.0),
        builder: (context, fadeValue, child) {
          return Opacity(
            opacity: fadeValue,
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection('1. Выберите место', [
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: places.map((place) => _buildPlaceChip(place)).toList(),
                    ),
                  ]),
                  if (selectedPlace != null) ...[
                    const SizedBox(height: 24),
                    _buildSection('2. Выберите зал', [
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: halls.map((hall) => _buildHallChip(hall)).toList(),
                      ),
                    ]),
                  ],
                  if (selectedHall != null) ...[
                    const SizedBox(height: 24),
                    _buildSection('3. Выберите пакет', [
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: availableTimings.map((timing) => _buildTimingChip(timing)).toList(),
                      ),
                    ]),
                  ],
                  if (selectedTiming != null) ...[
                    const SizedBox(height: 24),
                    _buildSection('4. Заполните данные', [
                      const SizedBox(height: 16),
                      _buildFoodSelector(),
                      const SizedBox(height: 16),
                      _buildTimeField(),
                      if (needsGame) ...[
                        const SizedBox(height: 16),
                        _buildGameSelector(),
                      ],
                      if (needsProgram) ...[
                        const SizedBox(height: 16),
                        _buildProgramField(),
                      ],
                      if (needsShow) ...[
                        const SizedBox(height: 16),
                        _buildShowField(),
                      ],
                      const SizedBox(height: 24),
                      _buildGenerateButton(),
                    ]),
                  ],
                  if (resultController.text.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _buildSection('Результат', [
                      const SizedBox(height: 16),
                      _buildResultField(),
                    ]),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
            letterSpacing: -0.3,
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildPlaceChip(String place) {
    final isSelected = selectedPlace == place;
    return FilterChip(
      selected: isSelected,
      label: Text(place),
      selectedColor: const Color(0xFF6366F1),
      backgroundColor: Colors.white,
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: isSelected ? const Color(0xFF6366F1) : Colors.grey[300]!,
        width: isSelected ? 0 : 1,
      ),
      onSelected: (_) => _selectPlace(place),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildHallChip(String hall) {
    final isSelected = selectedHall == hall;
    return FilterChip(
      selected: isSelected,
      label: Text(hall),
      selectedColor: const Color(0xFF6366F1),
      backgroundColor: Colors.white,
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: isSelected ? const Color(0xFF6366F1) : Colors.grey[300]!,
        width: isSelected ? 0 : 1,
      ),
      onSelected: (_) => _selectHall(hall),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildTimingChip(String timing) {
    final isSelected = selectedTiming == timing;
    return FilterChip(
      selected: isSelected,
      label: Text(timing),
      selectedColor: const Color(0xFF6366F1),
      backgroundColor: Colors.white,
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: isSelected ? const Color(0xFF6366F1) : Colors.grey[300]!,
        width: isSelected ? 0 : 1,
      ),
      onSelected: (_) => _selectTiming(timing),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildFoodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Когда будет еда',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: foodOptions.map((food) {
            final isSelected = selectedFood == food;
            return FilterChip(
              selected: isSelected,
              label: Text(food),
              selectedColor: const Color(0xFF6366F1),
              backgroundColor: Colors.white,
              checkmarkColor: Colors.white,
              side: BorderSide(
                color: isSelected ? const Color(0xFF6366F1) : Colors.grey[300]!,
                width: isSelected ? 0 : 1,
              ),
              onSelected: (_) => _selectFood(food),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildGameSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Игра на арене',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: games.map((game) {
            final isSelected = selectedGame == game;
            return FilterChip(
              selected: isSelected,
              label: Text(game),
              selectedColor: const Color(0xFF6366F1),
              backgroundColor: Colors.white,
              checkmarkColor: Colors.white,
              side: BorderSide(
                color: isSelected ? const Color(0xFF6366F1) : Colors.grey[300]!,
                width: isSelected ? 0 : 1,
              ),
              onSelected: (_) => _selectGame(game),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        final hour = picked.hour.toString().padLeft(2, '0');
        final minute = picked.minute.toString().padLeft(2, '0');
        timeController.text = '$hour:$minute';
      });
    }
  }
  
  Widget _buildTimeField() {
    return InkWell(
      onTap: _selectTime,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time, color: Color(0xFF6366F1), size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Время',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeController.text.isNotEmpty
                        ? timeController.text
                        : 'Выберите время',
                    style: TextStyle(
                      fontSize: 16,
                      color: timeController.text.isNotEmpty 
                          ? const Color(0xFF1F2937) 
                          : Colors.grey[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramField() {
    return TextField(
      controller: programController,
      decoration: const InputDecoration(
        labelText: 'Программа с ведущим',
        prefixIcon: Icon(Icons.person, color: Color(0xFF6366F1)),
      ),
    );
  }

  Widget _buildShowField() {
    return TextField(
      controller: showController,
      decoration: const InputDecoration(
        labelText: 'Мастер-класс или шоу',
        prefixIcon: Icon(Icons.theater_comedy, color: Color(0xFF6366F1)),
      ),
    );
  }

  Widget _buildGenerateButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _generateTiming,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6366F1),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_awesome, size: 20),
            SizedBox(width: 8),
            Text(
              'Создать тайминг',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Готовый тайминг',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy, color: Color(0xFF6366F1)),
                  onPressed: _copyToClipboard,
                  tooltip: 'Копировать',
                ),
              ],
            ),
            const Divider(height: 24),
            SelectableText(
              resultController.text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Color(0xFF1F2937),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

