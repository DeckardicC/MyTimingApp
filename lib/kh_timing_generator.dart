class KHTimingGenerator {
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

  String generateTiming({
    required String place,
    required String hall,
    required String timing,
    required String time,
    required String food,
    String? game,
    String? program,
    String? show,
  }) {
    final buffer = StringBuffer();
    String currentTime = time;

    buffer.writeln('Здравствуйте! Это развлекательный центр «$place» 😊.');
    buffer.writeln('Приходим без опозданий минут за 10-15 до начала мероприятия. В $time начнется ваше время! Кто опоздает может присоединиться в процессе ❗️❗️❗️');
    buffer.writeln();

    if (food == "Еда в начале") {
      buffer.writeln('$currentTime - ${addMinutes(currentTime, 15)} Кушаем в банкетном зале 🍕');
      currentTime = addMinutes(currentTime, 15);
    }

    // Логика для Большого Зала
    if (hall == "Большой зал") {
      if (timing == "Минимальный БЗ") {
        if (place == "Крейзи Хаус") {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} 8 квест-аттракционов 👾');
          currentTime = addMinutes(currentTime, 45);
        } else {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} Игра на арене: ${game ?? ""} 👽');
          currentTime = addMinutes(currentTime, 45);
        }
        if (food == "Еда после игры") {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 15)} Кушаем в банкетном зале 🍕');
          currentTime = addMinutes(currentTime, 15);
        }
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} Программа с ведущим: ${program ?? ""} 💥');
        currentTime = addMinutes(currentTime, 45);
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 20)} Кушаем тортик 🎂');
        currentTime = addMinutes(currentTime, 20);

      } else if (timing == "Стандарт БЗ") {
        if (place == "Крейзи Хаус") {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} 8 квест-аттракционов 👾');
          currentTime = addMinutes(currentTime, 45);
        } else {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} Игра на арене: ${game ?? ""} 👽');
          currentTime = addMinutes(currentTime, 45);
        }
        if (food == "Еда после игры") {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 15)} Кушаем в банкетном зале 🍕');
          currentTime = addMinutes(currentTime, 15);
        }
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} Программа с ведущим: ${program ?? ""} 💥');
        currentTime = addMinutes(currentTime, 45);
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 20)} ${show ?? ""} ✨');
        currentTime = addMinutes(currentTime, 20);
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 15)} Кушаем тортик 🎂');
        currentTime = addMinutes(currentTime, 15);

      } else if (timing == "Максимальный БЗ") {
        if (place == "Крейзи Хаус") {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} 8 квест-аттракционов 👾');
          currentTime = addMinutes(currentTime, 45);
        } else {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} Игра на арене: ${game ?? ""} 👽');
          currentTime = addMinutes(currentTime, 45);
        }
        if (food == "Еда после игры") {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 15)} Кушаем в банкетном зале 🍕');
          currentTime = addMinutes(currentTime, 15);
        }
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} Программа с ведущим: ${program ?? ""} 💥');
        currentTime = addMinutes(currentTime, 45);
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 20)} Шоу блеск-диско 🎊');
        currentTime = addMinutes(currentTime, 20);
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 20)} ${show ?? ""} ✨');
        currentTime = addMinutes(currentTime, 20);
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 25)} Кушаем тортик 🎂');
        currentTime = addMinutes(currentTime, 25);

      } else if (timing == "Мега БЗ") {
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} 8 квест-аттракционов 👾');
        currentTime = addMinutes(currentTime, 45);
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} Игра на арене: ${game ?? ""} 👽');
        currentTime = addMinutes(currentTime, 45);
        if (food == "Еда после игры") {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 15)} Кушаем в банкетном зале 🍕');
          currentTime = addMinutes(currentTime, 15);
        }
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} Программа с ведущим: ${program ?? ""} 💥');
        currentTime = addMinutes(currentTime, 45);
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 20)} Шоу блеск-диско 🎊');
        currentTime = addMinutes(currentTime, 20);
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 20)} ${show ?? ""} ✨');
        currentTime = addMinutes(currentTime, 20);
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 25)} Кушаем тортик 🎂');
        currentTime = addMinutes(currentTime, 25);
      }
    }
    // Логика для Малого Зала
    else if (hall == "Малый зал") {
      if (timing == "Минимальный МЗ") {
        if (place == "Крейзи Хаус") {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} 8 квест-аттракционов 👾');
          currentTime = addMinutes(currentTime, 45);
        } else {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} Игра на арене: ${game ?? ""} 👽');
          currentTime = addMinutes(currentTime, 45);
        }
        if (food == "Еда после игры") {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 15)} Кушаем в банкетном зале 🍕');
          currentTime = addMinutes(currentTime, 15);
        }
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 30)} ${show ?? ""} ✨');
        currentTime = addMinutes(currentTime, 30);
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 20)} Кушаем тортик 🎂');
        currentTime = addMinutes(currentTime, 20);

      } else if (timing == "Стандарт МЗ") {
        if (place == "Крейзи Хаус") {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} 8 квест-аттракционов 👾');
          currentTime = addMinutes(currentTime, 45);
        } else {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} Игра на арене: ${game ?? ""} 👽');
          currentTime = addMinutes(currentTime, 45);
        }
        if (food == "Еда после игры") {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 15)} Кушаем в банкетном зале 🍕');
          currentTime = addMinutes(currentTime, 15);
        }
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} Программа с ведущим: ${program ?? ""} 💥');
        currentTime = addMinutes(currentTime, 45);
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 20)} Кушаем тортик 🎂');
        currentTime = addMinutes(currentTime, 20);

      } else if (timing == "Максимальный МЗ") {
        if (place == "Крейзи Хаус") {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} 8 квест-аттракционов 👾');
          currentTime = addMinutes(currentTime, 45);
        } else {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} Игра на арене: ${game ?? ""} 👽');
          currentTime = addMinutes(currentTime, 45);
        }
        if (food == "Еда после игры") {
          buffer.writeln('$currentTime - ${addMinutes(currentTime, 15)} Кушаем в банкетном зале 🍕');
          currentTime = addMinutes(currentTime, 15);
        }
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 45)} Программа с ведущим: ${program ?? ""} 💥');
        currentTime = addMinutes(currentTime, 45);
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 20)} ${show ?? ""} ✨');
        currentTime = addMinutes(currentTime, 20);
        buffer.writeln('$currentTime - ${addMinutes(currentTime, 15)} Кушаем тортик 🎂');
        currentTime = addMinutes(currentTime, 15);
      }
    }

    buffer.writeln('$currentTime - ${addMinutes(currentTime, 10)} Время на сборы 🎒');
    currentTime = addMinutes(currentTime, 10);
    final endTime = currentTime;
    buffer.writeln();
    buffer.writeln('Домой в $endTime 🥳');
    buffer.writeln();
    final floor = place == 'Крейзи Хаус' ? 3 : 4;
    buffer.write('Всем с собой сменную обувь и хорошее настроение. Ждем вас по адресу Ленина 130/1 вход со стороны Ленина этаж $floor 🎉🎉🎉');

    return buffer.toString();
  }
}

