# Release Notes

## [1.3.2-unsi9ned.1] - 2026-04-08

### Added
- Добавлены GCC-совместимые startup-файлы для всех поддерживаемых МК:
  - K1986VE9xI
  - K1986VE1xI
  - MDR32F1QI
  - MDR32F9Q2I
  - MDR32FG16S1QI
  - K1986VE94GI
- Добавлено условие "Compiler ARMCC" для файлов линкер-скриптов (`*.sct`)
- Добавлено условие "Compiler ARMCC" для файлов CMSIS CORE
- Добавлено условие "GCC Compiler" для startup-файлов
- Добавлен скрипт автоматической сборки пакета (`create_pack.bat`)
- Добавлен файл Release Notes (`RELEASE.md`)
- Добавлена проверка компилятора в `MDR32FxQI_config.h` при подключении `<RTE_Components.h>`

### Changed
- Изменено имя выходного файла на `Milandr.MDR32FxQI_DFP.1.3.2-unsi9ned.{version}.pack`
- Добавлено определение `__VECTOR_TABLE_ADDRESS` для компилятора GCC в `system_K1986VE9xI.c`

### Initial
- Оригинальная версия пакета Milandr.MDR32FxQI 1.3.2