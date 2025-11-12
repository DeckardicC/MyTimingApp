class TimingGenerator {
  String addMinutes(String startTime, int minutes) {
    try {
      final parts = startTime.split(':');
      if (parts.length == 2) {
        int hours = int.parse(parts[0]);
        int mins = int.parse(parts[1]);
        mins += minutes;
        hours += mins ~/ 60;
        mins = mins % 60;
        return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}';
      }
    } catch (e) {
      return startTime;
    }
    return startTime;
  }

  String generateMiniTiming(String date, String time, String address) {
    final buffer = StringBuffer();
    final time15 = addMinutes(time, 15);
    final time30 = addMinutes(time, 30);
    final time75 = addMinutes(time, 75);
    final time90 = addMinutes(time, 90);
    final time100 = addMinutes(time, 100);

    buffer.writeln('Здравствуйте, ваш праздник состоится $date в $time по адресу $address 😊.');
    buffer.writeln('Приходим за 10 минут до начала, раньше приходить не нужно, будет идти подготовка площадки.');
    buffer.writeln();
    buffer.writeln('$time - $time15 Кушаем в банкетном зале 🍕 (15 минут)');
    buffer.writeln('$time15 - $time30 Инструктаж (15 минут)');
    buffer.writeln('$time30 - $time75 Играем (45 минут) 👾');
    buffer.writeln('$time75 - $time90 Кушаем тортик 🎂 (15 минут)');
    buffer.writeln('$time90 - $time100 Собираемся домой 🎒 (10 минут)');
    buffer.writeln();
    buffer.writeln('С собой: детям сменку, взрослым предоставим бахилы. Также возьмите водичку и пластиковые стаканчики, игры очень активные 💧.');
    buffer.writeln();
    buffer.writeln('Родители во время праздника могут посидеть в зоне ожидания, там стоят диванчики, можно сидеть и смотреть, как играют ребятишки, фотографировать 📸.');
    buffer.writeln();
    buffer.write('Будем с нетерпением ждать вас! 🎉🎉🎉');

    return buffer.toString();
  }

  String generateOptimalTiming(String date, String time, String address, String leadProgram, String showProgram) {
    final buffer = StringBuffer();
    final time15 = addMinutes(time, 15);
    final time30 = addMinutes(time, 30);
    final time75 = addMinutes(time, 75);
    final time120 = addMinutes(time, 120);
    final time135 = addMinutes(time, 135);
    final time145 = addMinutes(time, 145);
    final time150 = addMinutes(time, 150);

    buffer.writeln('Здравствуйте, ваш праздник состоится $date в $time по адресу $address 😊.');
    buffer.writeln('Приходим за 10 минут до начала, раньше приходить не нужно, будет идти подготовка площадки.');
    buffer.writeln();
    buffer.writeln('$time - $time15 Кушаем в банкетном зале 🍕 (15 минут)');
    buffer.writeln('$time15 - $time30 Инструктаж (15 минут)');
    buffer.writeln('$time30 - $time75 Играем (45 минут) 👾');
    buffer.writeln('$time75 - $time120 Программа с ведущим: $leadProgram 💥 (45 минут)');
    buffer.writeln('$time120 - $time135 Шоу-программа: $showProgram ✨ (15 минут)');
    buffer.writeln('$time135 - $time145 Кушаем тортик 🎂 (10 минут)');
    buffer.writeln('$time145 - $time150 Собираемся домой 🎒 (5 минут)');
    buffer.writeln();
    buffer.writeln('С собой: детям сменку, взрослым предоставим бахилы. Также возьмите водичку и пластиковые стаканчики, игры очень активные 💧.');
    buffer.writeln();
    buffer.writeln('Родители во время праздника могут посидеть в зоне ожидания, там стоят диванчики, можно сидеть и смотреть, как играют ребятишки, фотографировать 📸.');
    buffer.writeln();
    buffer.write('Будем с нетерпением ждать вас! 🎉🎉🎉');

    return buffer.toString();
  }

  String generateMaxiTiming(String date, String time, String address, String leadProgram, String masterClass) {
    final buffer = StringBuffer();
    final time15 = addMinutes(time, 15);
    final time30 = addMinutes(time, 30);
    final time75 = addMinutes(time, 75);
    final time120 = addMinutes(time, 120);
    final time140 = addMinutes(time, 140);
    final time160 = addMinutes(time, 160);
    final time175 = addMinutes(time, 175);
    final time180 = addMinutes(time, 180);

    buffer.writeln('Здравствуйте, ваш праздник состоится $date в $time по адресу $address 😊.');
    buffer.writeln('Приходим за 10 минут до начала, раньше приходить не нужно, будет идти подготовка площадки.');
    buffer.writeln();
    buffer.writeln('$time - $time15 Кушаем в банкетном зале 🍕 (15 минут)');
    buffer.writeln('$time15 - $time30 Инструктаж (15 минут)');
    buffer.writeln('$time30 - $time75 Играем (45 минут) 👾');
    buffer.writeln('$time75 - $time120 Программа с ведущим: $leadProgram 💥 (45 минут)');
    buffer.writeln('$time120 - $time140 Мастер-класс: $masterClass 🎨 (20 минут)');
    buffer.writeln('$time140 - $time160 Дискотека и караоке 🎊 (20 минут)');
    buffer.writeln('$time160 - $time175 Кушаем тортик 🎂 (15 минут)');
    buffer.writeln('$time175 - $time180 Собираемся домой 🎒 (5 минут)');
    buffer.writeln();
    buffer.writeln('С собой: детям сменку, взрослым предоставим бахилы. Также возьмите водичку и пластиковые стаканчики, игры очень активные 💧.');
    buffer.writeln();
    buffer.writeln('Родители во время праздника могут посидеть в зоне ожидания, там стоят диванчики, можно сидеть и смотреть, как играют ребятишки, фотографировать 📸.');
    buffer.writeln();
    buffer.write('Будем с нетерпением ждать вас! 🎉🎉🎉');

    return buffer.toString();
  }

  String generateStandardTiming(String date, String time, String address, String leadProgram, String masterClass) {
    final buffer = StringBuffer();
    final time15 = addMinutes(time, 15);
    final time20 = addMinutes(time, 20);
    final time60 = addMinutes(time, 60);
    final time100 = addMinutes(time, 100);
    final time140 = addMinutes(time, 140);
    final time155 = addMinutes(time, 155);
    final time160 = addMinutes(time, 160);

    buffer.writeln('Здравствуйте, ваш праздник состоится $date в $time по адресу $address 😊.');
    buffer.writeln('Приходим за 10 минут до начала, раньше приходить не нужно, будет идти подготовка площадки.');
    buffer.writeln();
    buffer.writeln('$time - $time15 Кушаем в банкетном зале 🍕 (15 минут)');
    buffer.writeln('$time15 - $time20 Инструктаж и разделение детей на 2 команды (5 минут)');
    buffer.writeln('$time20 - $time60 Играет первая команда, вторая на мастер-классе: $masterClass 👾🎨 (40 минут)');
    buffer.writeln('$time60 - $time100 Играет вторая команда, первая на мастер-классе: $masterClass 👾🎨 (40 минут)');
    buffer.writeln('$time100 - $time140 Программа с ведущим: $leadProgram 💥 (40 минут)');
    buffer.writeln('$time140 - $time155 Кушаем тортик 🎂 (15 минут)');
    buffer.writeln('$time155 - $time160 Собираемся домой 🎒 (5 минут)');
    buffer.writeln();
    buffer.writeln('С собой: детям сменку, взрослым предоставим бахилы. Также возьмите водичку и пластиковые стаканчики, игры очень активные 💧.');
    buffer.writeln();
    buffer.writeln('Родители во время праздника могут посидеть в зоне ожидания, там стоят диванчики, можно сидеть и смотреть, как играют ребятишки, фотографировать 📸.');
    buffer.writeln();
    buffer.write('Будем с нетерпением ждать вас! 🎉🎉🎉');

    return buffer.toString();
  }

  String generateVIPTiming(String date, String time, String address, String leadProgram, String masterClass) {
    final buffer = StringBuffer();
    final time15 = addMinutes(time, 15);
    final time20 = addMinutes(time, 20);
    final time60 = addMinutes(time, 60);
    final time100 = addMinutes(time, 100);
    final time140 = addMinutes(time, 140);
    final time160 = addMinutes(time, 160);
    final time175 = addMinutes(time, 175);
    final time180 = addMinutes(time, 180);

    buffer.writeln('Здравствуйте, ваш праздник состоится $date в $time по адресу $address 😊.');
    buffer.writeln('Приходим за 10 минут до начала, раньше приходить не нужно, будет идти подготовка площадки.');
    buffer.writeln();
    buffer.writeln('$time - $time15 Кушаем в банкетном зале 🍕 (15 минут)');
    buffer.writeln('$time15 - $time20 Инструктаж и разделение детей на 2 команды (5 минут)');
    buffer.writeln('$time20 - $time60 Играет первая команда, вторая на мастер-классе: $masterClass 👾🎨 (40 минут)');
    buffer.writeln('$time60 - $time100 Играет вторая команда, первая на мастер-классе: $masterClass 👾🎨 (40 минут)');
    buffer.writeln('$time100 - $time140 Программа с ведущим: $leadProgram 💥 (40 минут)');
    buffer.writeln('$time140 - $time160 Дискотека и караоке 🎊 (20 минут)');
    buffer.writeln('$time160 - $time175 Кушаем тортик 🎂 (15 минут)');
    buffer.writeln('$time175 - $time180 Собираемся домой 🎒 (5 минут)');
    buffer.writeln();
    buffer.writeln('С собой: детям сменку, взрослым предоставим бахилы. Также возьмите водичку и пластиковые стаканчики, игры очень активные 💧.');
    buffer.writeln();
    buffer.writeln('Родители во время праздника могут посидеть в зоне ожидания, там стоят диванчики, можно сидеть и смотреть, как играют ребятишки, фотографировать 📸.');
    buffer.writeln();
    buffer.write('Будем с нетерпением ждать вас! 🎉🎉🎉');

    return buffer.toString();
  }
}

