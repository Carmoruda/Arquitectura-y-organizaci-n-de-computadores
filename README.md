# Computer architecture

The exercises will be carried out on a ZX Spectrum emulator (Z80 processor-based computer), using Microsoft's Visual Studio Code as a base.

It is necessary that you have the following elements installed on your computer to approach the exercises:

- **Development environment**: [Visual Studio Code (VSCode)](https://code.visualstudio.com/).

  - DEZOG extension (Debugger and spectrum simulator): [DEZOG](https://marketplace.visualstudio.com/items?itemName=maziac.dezog).
  - Z80 Assembly extension (Syntax highlighting): [Z80 Assembly](https://marketplace.visualstudio.com/items?itemName=devzendo.z80-asm).

- **Assembler**: [SjAsmPlus](https://github.com/z00m128/sjasmplus)

  - Latest release: [SjAsmPlus](https://github.com/z00m128/sjasmplus/releases/latest)
  - Documentation: [SjAsmPlus](https://z00m128.github.io/sjasmplus/documentation.html)

- **Assembler template**: [Z80-asm-template](https://github.com/Carmoruda/Computer-Architecture-ZXSPECTRUM/tree/main/Template)
  - This template includes a hidden directory ".vscode" containing the configuration for Visual Studio Code.
  - Edit the "task.json" file inside the .vscode folder to modify the path of the assembler (sjasmplusz), which depends on the location it's on your computer.
