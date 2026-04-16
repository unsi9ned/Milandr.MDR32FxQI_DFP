# Release Notes

## [1.3.2-unsi9ned.2] - 2026-04-16

### Added
- Добавлена поддержка GCC/CoIDE для следующих микроконтроллеров:
  - K1986VE1xI
  - MDR32F1QI
  - MDR32F9Q2I
  - MDR32FG16S1QI
  - K1986VE94GI
- Добавлены GCC-совместимые startup-файлы (`.c`) для всех поддерживаемых МК:
  - `startup_K1986VE9xI.c`
  - `startup_K1986VE1xI.c`
  - `startup_MDR32F1QI.c`
  - `startup_MDR32F9Q2I.c`
  - `startup_MDR32FG16S1QI.c`
- Добавлена реализация ассемблерных функций для GCC:
  - `EEPROM_UpdateDCacheAsm` — обновление кэша данных
  - `DELAY_PROGRAM_WaitLoopsAsm` — программная задержка
- Добавлено описание макроса `__RAMFUNC` для GCC (размещение функций в секции `.data`)
- Добавлен файл `syscalls.c` в пример `RetargetSTDIO` (реализация системных вызовов)
- Добавлены все нативные примеры для MDR32F1QI, MDR32F9Q2I
- Добавлен пример `PORT_Blink` для отладочной платы K1986VE92FI-Mini
- Добавлена зависимость примера `RetargetSTDIO` от компонента PORT
- Добавлен скрипт автоматической сборки пакета (`create_pack.bat`)
- Добавлен файл Release Notes (`RELEASE.md`)
- Добавлена проверка компилятора в `MDR32FxQI_config.h` при подключении `<RTE_Components.h>`
- Добавлено условие "Compiler ARMCC" для файлов линкер-скриптов (`*.sct`) и CMSIS CORE
- Добавлено условие "GCC Compiler" для startup-файлов
- Добавлено определение `__VECTOR_TABLE_ADDRESS` для компилятора GCC в `system_K1986VE9xI.c`

### Changed
- Заменены ассемблерные startup-файлы (`.S`) на C-версии (`.c`) для всех МК
- Адаптирован вызов RAM-функции чтения EEPROM для CoIDE в `system_K1986VE9xI.c` и `system_K1986VE1xI.c`
- Изменены пути к файлам в примере `RetargetSTDIO`
- Увеличен срок хранения артефактов до 30 дней
- Изменено имя выходного файла на `Milandr.MDR32FxQI_DFP.1.3.2-unsi9ned.{version}.pack`

### Fixed
- Адаптированы примеры `RetargetSTDIO` под компилятор GCC

### Initial
- Оригинальная версия пакета Milandr.MDR32FxQI 1.3.2