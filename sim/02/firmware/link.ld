/* link.ld */
OUTPUT_ARCH(riscv)
OUTPUT_FORMAT(elf32-littleriscv)
ENTRY(_start)

MEMORY {
  RAM (rwx) : ORIGIN = 0x00000000, LENGTH = 64K
}

/* Program headers (segments) and their flags: 5 = R|X, 6 = R|W */
PHDRS {
  text PT_LOAD FLAGS(5); /* RX */
  data PT_LOAD FLAGS(6); /* RW */
}

SECTIONS
{
  /* Start at RAM base */
  . = ORIGIN(RAM);

  /* Code + rodata (RX) */
  .text : ALIGN(4) {
    KEEP(*(.init))       /* crt0.S */
    *(.text*)
    *(.rodata*)
  } > RAM :text

  /* Initialized data (RW) */
  .data : ALIGN(4) {
    *(.data*)
  } > RAM :data

  /* Zero-initialized data (RW, not stored in file) */
  .bss (NOLOAD) : ALIGN(4) {
    __bss_start = .;
    *(.bss*)
    *(COMMON)
    __bss_end = .;
  } > RAM :data

  /* Stack at top of RAM */
  . = ORIGIN(RAM) + LENGTH(RAM);
  _stack_top = .;
}

