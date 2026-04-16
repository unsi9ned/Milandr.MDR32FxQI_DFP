## Milandr.MDR32FxQI_DFP

**Версия: 1.3.2-unsi9ned.2**

Модифицированная версия официального Device Family Pack (DFP) для микроконтроллеров Миландр (MDR32FxQI series).

### Отличия от оригинального пакета

- **Поддержка GCC/CoIDE** — добавлены GCC-совместимые startup-файлы для всех МК серии
- **Условная компиляция** — добавлены условия `Compiler ARMCC` и `GCC Compiler` для корректной сборки в различных средах
- **Адаптация RAM-функций** — исправлен вызов функции чтения EEPROM для CoIDE в `system_K1986VE9xI.c` и `system_K1986VE1xI.c`
- **Исправлен `system_K1986VE9xI.c`** — добавлено определение `__VECTOR_TABLE_ADDRESS` для GCC
- **Добавлен макрос `__RAMFUNC`** — для размещения функций в секции `.data` (GCC)
- **Добавлены ассемблерные функции для GCC**:
  - `EEPROM_UpdateDCacheAsm` — обновление кэша данных (для errata 0007)
  - `DELAY_PROGRAM_WaitLoopsAsm` — программная задержка
- **Добавлен скрипт сборки** — автоматическая упаковка в CMSIS-Pack формат
- **Добавлены примеры** для MDR32F1QI, MDR32F9Q2I и `PORT_Blink` для платы K1986VE92FI-Mini
- **Разделение на два пакета** — DFP и примеры поставляются отдельно:
  - `Milandr.MDR32FxQI_DFP.1.3.2-unsi9ned.2.pack` — Device Family Pack
  - `Milandr.MDR32FxQI_Examples.1.3.2-unsi9ned.2.pack` — Пакет с примерами

### Поддерживаемые микроконтроллеры

| Серия | МК | Startup-файл |
|-------|-----|--------------|
| K1986VE9xI | K1986VE92QI, K1986VE93QI, K1986VE94QI | `startup_K1986VE9xI.S` |
| K1986VE1xI | K1986VE12QI, K1986VE13QI, K1986VE14QI | `startup_K1986VE1xI.S` |
| MDR32F1QI | MDR32F1QI | `startup_MDR32F1QI.S` |
| MDR32F9Q2I | MDR32F9Q2I | `startup_MDR32F9Q2I.S` |
| MDR32FG16S1QI | MDR32FG16S1QI | `startup_MDR32FG16S1QI.S` |
| K1986VE94GI | K1986VE94GI | `startup_K1986VE94GI.S` |
