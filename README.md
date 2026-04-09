## Milandr.MDR32FxQI_DFP

Модифицированная версия официального Device Family Pack (DFP) для микроконтроллеров Миландр (MDR32FxQI series).

### Отличия от оригинального пакета

- **Поддержка GCC/CoIDE** — добавлены GCC-совместимые startup-файлы для всех МК серии
- **Условная компиляция** — добавлены условия `Compiler ARMCC` и `GCC Compiler` для корректной сборки в различных средах
- **Исправлен `system_K1986VE9xI.c`** — добавлено определение `__VECTOR_TABLE_ADDRESS` для GCC
- **Добавлен скрипт сборки** — автоматическая упаковка в CMSIS-Pack формат

### Поддерживаемые микроконтроллеры

| Серия | МК | Startup-файл |
|-------|-----|--------------|
| K1986VE9xI | K1986VE92QI, K1986VE93QI, K1986VE94QI | `startup_K1986VE9xI.S` |
| K1986VE1xI | K1986VE12QI, K1986VE13QI, K1986VE14QI | `startup_K1986VE1xI.S` |
| MDR32F1QI | MDR32F1QI | `startup_MDR32F1QI.S` |
| MDR32F9Q2I | MDR32F9Q2I | `startup_MDR32F9Q2I.S` |
| MDR32FG16S1QI | MDR32FG16S1QI | `startup_MDR32FG16S1QI.S` |
| K1986VE94GI | K1986VE94GI | `startup_K1986VE94GI.S` |
