#!/bin/bash
# Скрипт для автоматической сборки релизного APK

cd "$(dirname "$0")"

# Поиск Flutter SDK из запущенных процессов
find_flutter_from_process() {
  ps aux | grep -i "flutter_sdk" | grep -v grep | head -1 | awk '{for(i=1;i<=NF;i++) {
    if($i ~ /flutter_sdk/) {
      path=$i
      gsub(/\/bin\/cache.*/, "", path)
      gsub(/\/cache.*/, "", path)
      print path
      exit
    }
  }}'
}

# Поиск Flutter в стандартных местах
FLUTTER_PATHS=(
  "$HOME/flutter/bin"
  "/usr/local/flutter/bin"
  "/opt/flutter/bin"
  "/Applications/flutter/bin"
  "$HOME/.fvm/default/bin"
  "/usr/local/bin"
  "/opt/homebrew/bin"
  "./flutter_sdk/bin"
  "$(dirname "$0")/flutter_sdk/bin"
)

FLUTTER_CMD=""

# Сначала пробуем найти из процессов
PROCESS_PATH=$(find_flutter_from_process)
if [ -n "$PROCESS_PATH" ] && [ -f "$PROCESS_PATH/bin/flutter" ]; then
  FLUTTER_CMD="$PROCESS_PATH/bin/flutter"
  export PATH="$PROCESS_PATH/bin:$PATH"
  echo "✅ Найден Flutter из процесса: $FLUTTER_CMD"
fi

# Если не нашли, ищем в стандартных местах
if [ -z "$FLUTTER_CMD" ]; then
  for path in "${FLUTTER_PATHS[@]}"; do
    if [ -f "$path/flutter" ]; then
      FLUTTER_CMD="$path/flutter"
      export PATH="$(dirname "$path"):$PATH"
      echo "✅ Найден Flutter: $FLUTTER_CMD"
      break
    fi
  done
fi

# Последняя попытка - через which
if [ -z "$FLUTTER_CMD" ]; then
  FLUTTER_CMD=$(which flutter 2>/dev/null)
  if [ -n "$FLUTTER_CMD" ]; then
    echo "✅ Найден Flutter в PATH: $FLUTTER_CMD"
  fi
fi

if [ -z "$FLUTTER_CMD" ] || [ ! -f "$FLUTTER_CMD" ]; then
  echo "❌ ОШИБКА: Flutter SDK не найден!"
  echo "Установите Flutter или добавьте его в PATH"
  exit 1
fi

echo "Версия Flutter:"
$FLUTTER_CMD --version | head -1
echo ""

echo "📦 Установка зависимостей..."
$FLUTTER_CMD pub get

echo ""
echo "🧹 Очистка предыдущих сборок..."
$FLUTTER_CMD clean

echo ""
echo "🔨 Сборка релизного APK..."
$FLUTTER_CMD build apk --release

APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
if [ -f "$APK_PATH" ]; then
  cp "$APK_PATH" "app-release.apk"
  echo ""
  echo "✅ APK успешно собран и скопирован в корень проекта!"
  echo "📱 Файл: app-release.apk"
  ls -lh app-release.apk
else
  echo ""
  echo "❌ ОШИБКА: APK файл не найден по пути: $APK_PATH"
  exit 1
fi
