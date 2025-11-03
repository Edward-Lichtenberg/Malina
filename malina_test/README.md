Структура дерева 

lib/
├── src/
│   ├── core/              → Глобальные стили, темы, утилиты
│   ├── data/              → Работа с данными (API, SharedPreferences)
│   ├── domain/            → Бизнес-логика (сущности, use cases)
│   ├── feature/           → Фичи (экраны + их логика)
│   │   ├── welcome_screen/
│   │   ├── add_item_screen/
│   │   ├── cart_screen/
│   │   └── ...
│   ├── providers/         → Состояние (Provider, Riverpod)
│   ├── routes/            → Навигация (auto_route)
│   └── widgets/           → Переиспользуемые виджеты


Проект построен по Feature-First Clean Architecture:
domain — чистые сущности (User, Item)
data — работа с SharedPreferences через AuthService
feature — изолированные экраны с локальными утилитами и виджетами
providers — реактивное состояние через ChangeNotifier
core, widgets, routes — глобальные ресурсы

Почему именно такая структура?
Это обеспечивает: масштабируемость, тестируемость, читаемость и лёгкое удаление фич.
