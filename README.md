# STM32 Projekt

Podstawowy projekt dla mikrokontrolera STM32F4, zawierający konfigurację GPIO i UART.

## Funkcjonalności

- Konfiguracja zegara systemowego (84MHz)
- Inicjalizacja GPIO (LED na pinie PA5)
- Komunikacja UART (115200 baud)
- Miganie LED co 1 sekundę
- Wysyłanie komunikatów przez UART

## Struktura projektu

```
├── Core/
│   ├── Inc/
│   │   ├── main.h
│   │   ├── stm32f4xx_hal_conf.h
│   │   └── stm32f4xx_it.h
│   └── Src/
│       ├── main.c
│       ├── stm32f4xx_it.c
│       └── system_stm32f4xx.c
├── Makefile
├── STM32F401RETx_FLASH.ld
└── README.md
```

## Wymagania

- ARM GCC Toolchain
- ST-Link (do programowania)
- STM32F401RE (lub kompatybilny)

## Kompilacja

```bash
make
```

## Programowanie

```bash
make flash
```

## Debugging

```bash
make debug
```

## Konfiguracja sprzętowa

- **LED**: PA5 (wbudowana LED na Nucleo board)
- **UART2**: PA2 (TX), PA3 (RX)
- **Baudrate**: 115200
- **Częstotliwość**: 84MHz

## Autor

Projekt wygenerowany automatycznie dla STM32F401RE.