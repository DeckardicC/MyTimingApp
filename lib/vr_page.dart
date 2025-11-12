import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'timing_generator.dart';

class VRPage extends StatefulWidget {
  const VRPage({super.key});

  @override
  State<VRPage> createState() => _VRPageState();
}

class _VRPageState extends State<VRPage> {
  String? selectedEvent;
  String? selectedPackage;
  DateTime? selectedDate;
  final TextEditingController timeController = TextEditingController();
  final TextEditingController leadProgramController = TextEditingController();
  final TextEditingController showProgramController = TextEditingController();
  final TextEditingController masterClassController = TextEditingController();
  final TextEditingController resultController = TextEditingController();
  final TimingGenerator timingGenerator = TimingGenerator();
  final ScrollController scrollController = ScrollController();

  final List<String> packages = ['Мини', 'Оптимал', 'Макси', 'Стандарт', 'VIP'];
  final List<String> events = ['Another World', 'Ели Пели'];

  @override
  void dispose() {
    timeController.dispose();
    leadProgramController.dispose();
    showProgramController.dispose();
    masterClassController.dispose();
    resultController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _selectEvent(String event) {
    setState(() {
      selectedEvent = event;
      selectedPackage = null;
      resultController.clear();
    });
  }

  void _selectPackage(String package) {
    setState(() {
      selectedPackage = package;
    });
  }

  void _generateTiming() {
    if (selectedEvent == null || 
        selectedPackage == null || 
        selectedDate == null || 
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

    String result = '';
    
    switch (selectedPackage) {
      case 'Мини':
        result = timingGenerator.generateMiniTiming(
          DateFormat('dd.MM.yyyy').format(selectedDate!),
          timeController.text,
          _getAddress(),
        );
        break;
      case 'Оптимал':
        result = timingGenerator.generateOptimalTiming(
          DateFormat('dd.MM.yyyy').format(selectedDate!),
          timeController.text,
          _getAddress(),
          leadProgramController.text,
          showProgramController.text,
        );
        break;
      case 'Макси':
        result = timingGenerator.generateMaxiTiming(
          DateFormat('dd.MM.yyyy').format(selectedDate!),
          timeController.text,
          _getAddress(),
          leadProgramController.text,
          masterClassController.text,
        );
        break;
      case 'Стандарт':
        result = timingGenerator.generateStandardTiming(
          DateFormat('dd.MM.yyyy').format(selectedDate!),
          timeController.text,
          _getAddress(),
          leadProgramController.text,
          masterClassController.text,
        );
        break;
      case 'VIP':
        result = timingGenerator.generateVIPTiming(
          DateFormat('dd.MM.yyyy').format(selectedDate!),
          timeController.text,
          _getAddress(),
          leadProgramController.text,
          masterClassController.text,
        );
        break;
    }

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

  String _getAddress() {
    return selectedEvent == 'Another World'
        ? 'Ленинградский проспект 28/1 - 2 этаж'
        : 'Шахтеров 48а тц. Магнит - 2 этаж';
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
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
          'Генератор таймингов',
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
                  _buildSection('1. Выберите событие', [
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: events.map((event) => _buildEventChip(event)).toList(),
                    ),
                  ]),
                  if (selectedEvent != null) ...[
                    const SizedBox(height: 24),
                    _buildSection('2. Выберите пакет', [
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: packages.map((package) => _buildPackageChip(package)).toList(),
                      ),
                    ]),
                  ],
                  if (selectedPackage != null) ...[
                    const SizedBox(height: 24),
                    _buildSection('3. Заполните данные', [
                      const SizedBox(height: 16),
                      _buildDateField(),
                      const SizedBox(height: 16),
                      _buildTimeField(),
                      if (_needsLeadProgram()) ...[
                        const SizedBox(height: 16),
                        _buildLeadProgramField(),
                      ],
                      if (_needsShowProgram()) ...[
                        const SizedBox(height: 16),
                        _buildShowProgramField(),
                      ],
                      if (_needsMasterClass()) ...[
                        const SizedBox(height: 16),
                        _buildMasterClassField(),
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

  Widget _buildEventChip(String event) {
    final isSelected = selectedEvent == event;
    return FilterChip(
      selected: isSelected,
      label: Text(
        event,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: isSelected ? Colors.white : const Color(0xFF1F2937),
        ),
      ),
      selectedColor: const Color(0xFF6366F1),
      backgroundColor: Colors.white,
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: isSelected ? const Color(0xFF6366F1) : Colors.grey[300]!,
        width: isSelected ? 0 : 1,
      ),
      onSelected: (_) => _selectEvent(event),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildPackageChip(String package) {
    final isSelected = selectedPackage == package;
    return FilterChip(
      selected: isSelected,
      label: Text(
        package,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: isSelected ? Colors.white : const Color(0xFF1F2937),
        ),
      ),
      selectedColor: const Color(0xFF6366F1),
      backgroundColor: Colors.white,
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: isSelected ? const Color(0xFF6366F1) : Colors.grey[300]!,
        width: isSelected ? 0 : 1,
      ),
      onSelected: (_) => _selectPackage(package),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: _selectDate,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: Color(0xFF6366F1), size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Дата',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedDate != null
                        ? DateFormat('dd.MM.yyyy').format(selectedDate!)
                        : 'Выберите дату',
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedDate != null 
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

  Widget _buildLeadProgramField() {
    return TextField(
      controller: leadProgramController,
      decoration: const InputDecoration(
        labelText: 'Программа с ведущим',
        prefixIcon: Icon(Icons.person, color: Color(0xFF6366F1)),
      ),
    );
  }

  Widget _buildShowProgramField() {
    return TextField(
      controller: showProgramController,
      decoration: const InputDecoration(
        labelText: 'Шоу-программа',
        prefixIcon: Icon(Icons.theater_comedy, color: Color(0xFF6366F1)),
      ),
    );
  }

  Widget _buildMasterClassField() {
    return TextField(
      controller: masterClassController,
      decoration: const InputDecoration(
        labelText: 'Мастер-класс',
        prefixIcon: Icon(Icons.school, color: Color(0xFF6366F1)),
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

  bool _needsLeadProgram() {
    return selectedPackage == 'Оптимал' ||
        selectedPackage == 'Макси' ||
        selectedPackage == 'Стандарт' ||
        selectedPackage == 'VIP';
  }

  bool _needsShowProgram() {
    return selectedPackage == 'Оптимал';
  }

  bool _needsMasterClass() {
    return selectedPackage == 'Макси' ||
        selectedPackage == 'Стандарт' ||
        selectedPackage == 'VIP';
  }
}
