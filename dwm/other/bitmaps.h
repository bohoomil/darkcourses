/* See LICENSE file for copyright and license details. */

const unsigned char allbits[] = {
  0x30, 0x28, 0xE4, 0x27, 0x27, 0xE4, 0x28, 0x30, //  0 AC 1 (plug)
  0xFF, 0xF8, 0xF0, 0xF6, 0x6F, 0x0F, 0x1F, 0xFF, //  1 AC 2 (inverse wave)
  0x10, 0x00, 0x10, 0x00, 0x38, 0x00, 0x38, 0x00, 
  0x7C, 0x00, 0x7C, 0x00, 0xEE, 0x00, 0xC6, 0x00, 
  0xC7, 0x01, 0x01, 0x01,                         //  2 Arch Logo
  0x08, 0x08, 0x1C, 0x1C, 0x36, 0x22, 0x77, 0x41, //  3 Arch Logo
  0x18, 0x7E, 0x42, 0x42, 0x42, 0x42, 0x42, 0x7E, //  4 Bat empty 1 (v)
  0x00, 0x7F, 0x41, 0xC1, 0xC1, 0x41, 0x7F, 0x00, //  5 Bat empty 2 (h)
  0x18, 0x7E, 0x42, 0x42, 0x42, 0x5A, 0x42, 0x7E, //  6 Bat low 1 (v)
  0x00, 0x7F, 0x41, 0xC5, 0xC5, 0x41, 0x7F, 0x00, //  7 Bat low 2 (h)
  0x18, 0x7E, 0x42, 0x5A, 0x5A, 0x5A, 0x42, 0x7E, //  8 Bat full 1 (v)
  0x00, 0x7F, 0x41, 0xDD, 0xDD, 0x41, 0x7F, 0x00, //  9 Bat full 2 (h)

  0x18, 0x2A, 0x6C, 0x38, 0x38, 0x6C, 0x2A, 0x18, // 10 Bluetooth
  0xC3, 0x24, 0x18, 0xDB, 0x3C, 0x7E, 0xBD, 0x99, // 11 Bug 1
  0xC3, 0x24, 0x24, 0xDB, 0x3C, 0x7E, 0x99, 0x42, // 12 Bug 2
  0x81, 0xC3, 0xBD, 0xFF, 0x99, 0xFF, 0x7E, 0xBD, // 13 Cat
  0x3C, 0x5E, 0xEF, 0xF7, 0x87, 0xFF, 0x7E, 0x3C, // 14 Clock
  0xDB, 0x81, 0x3C, 0xBD, 0xBD, 0x3C, 0x81, 0xDB, // 15 CPU
  0x81, 0x7B, 0x46, 0x4E, 0x5C, 0x3E, 0x77, 0xC3, // 16 Disk (satelite dish)
  0xFF, 0x81, 0x81, 0x81, 0xBD, 0xB5, 0xB5, 0xFE, // 17 Floppy
  0x3C, 0x42, 0x81, 0x81, 0x81, 0x81, 0x42, 0x3C, // 18 Empty (circle)
  0x00, 0x00, 0x1B, 0x02, 0x02, 0x84, 0xF9, 0x02, // 19 Eye l (weird)

  0x00, 0x00, 0xD8, 0x40, 0x40, 0x21, 0x9F, 0x40, // 20 Eye r (weird)
  0x81, 0xC3, 0xBD, 0xFF, 0x99, 0xDB, 0x7E, 0x18, // 21 Fox
  0x46, 0x99, 0xBC, 0x66, 0x66, 0x3D, 0x99, 0x62, // 22 FS 1 (circled rays thin)
  0xF1, 0x5B, 0x3D, 0x67, 0xE6, 0xBC, 0xDA, 0x8F, // 23 FS 2 (circled rays thick)
  0x3C, 0x7E, 0xFF, 0xFF, 0xFF, 0xFF, 0x7E, 0x3C, // 24 Full (circle)
  0x00, 0x12, 0x36, 0x7E, 0x7E, 0x36, 0x12, 0x00, // 25 Fwd
  0x3C, 0x4E, 0x8F, 0x8F, 0x8F, 0x8F, 0x4E, 0x3C, // 26 Half (circle)
  0x3C, 0x66, 0xFF, 0xE7, 0xE7, 0xE7, 0x66, 0x3C, // 27 Info 1 (inverse i in circle)
  0xFF, 0xE7, 0xFF, 0xE7, 0xE7, 0xE7, 0xE7, 0xFF, // 28 Info 2 (inverse i in block)
  0x38, 0x38, 0x00, 0x3C, 0x38, 0x38, 0x38, 0x7C, // 29 Info 3 (i)

  0x00, 0xFF, 0x7E, 0xBD, 0xDB, 0xE7, 0xFF, 0x00, // 30 Mail
  0xAA, 0x00, 0xFE, 0xFE, 0xFE, 0xFE, 0x00, 0xAA, // 31 Mem
  0xEE, 0xEE, 0xEE, 0x82, 0xFE, 0xFE, 0xFE, 0x7C, // 32 Mouse
  0x1E, 0x3C, 0x3C, 0x3C, 0xFF, 0x7E, 0x3C, 0x18, // 33 Net down 1 (arrow from left down)
  0x78, 0x3C, 0x3C, 0x3C, 0xFF, 0x7E, 0x3C, 0x18, // 34 Net down 2 (arrow from right down)
  0x38, 0x38, 0x38, 0x38, 0xFE, 0x7C, 0x38, 0x10, // 35 Net down 3 (arrow down)
  0x18, 0x3C, 0x7E, 0xFF, 0x3C, 0x3C, 0x3C, 0x78, // 36 Net up 1 (arrow from left up)
  0x18, 0x3C, 0x7E, 0xFF, 0x3C, 0x3C, 0x3C, 0x1E, // 37 Net up 2 (arrow from right up)
  0x10, 0x38, 0x7C, 0xFE, 0x38, 0x38, 0x38, 0x38, // 38 Net up 3 (arrow up)
  0x00, 0x1C, 0x1C, 0x7F, 0x7F, 0x7F, 0x55, 0x7F, // 39 Net wired (rj plug)

  0x00, 0x42, 0x4E, 0x7E, 0x7E, 0x4E, 0x42, 0x00, // 40 Next
  0xFC, 0xFC, 0x84, 0x84, 0x84, 0x84, 0xE7, 0xE7, // 41 Note
  0x3C, 0x6E, 0xE7, 0xFF, 0x07, 0x1F, 0x7E, 0x3C, // 42 Pacman
  0x00, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x00, // 43 Pause
  0x3C, 0x42, 0x81, 0x81, 0xA5, 0xE7, 0xE7, 0x66, // 44 Phones (headphones)
  0x00, 0x06, 0x1E, 0x7E, 0x7E, 0x1E, 0x06, 0x00, // 45 Play
  0x03, 0x0F, 0x1E, 0x3E, 0x3C, 0x58, 0xA0, 0xC0, // 46 Plug ()
  0x00, 0x42, 0x72, 0x7E, 0x7E, 0x72, 0x42, 0x00, // 47 Prev
  0x00, 0x48, 0x6C, 0x7E, 0x7E, 0x6C, 0x48, 0x00, // 48 Rwd
  0x42, 0x81, 0xDB, 0x3C, 0xDB, 0x5A, 0x99, 0x30, // 49 Scorpio

  0x3C, 0x42, 0x81, 0x81, 0xFF, 0x3C, 0x3C, 0x3C, // 50 Shroom
  0x08, 0x4C, 0x8F, 0xAF, 0xAF, 0x8F, 0x4C, 0x08, // 51 Spkr 1 (with waves)
  0x08, 0x0C, 0x0F, 0x1F, 0x1F, 0x0F, 0x0C, 0x08, // 52 Spkr 2 (w/o waves)
  0x4C, 0x93, 0x93, 0x97, 0x97, 0x93, 0x93, 0x4C, // 53 Ysick (weird)
  0x00, 0x7E, 0x7E, 0x7E, 0x7E, 0x7E, 0x7E, 0x00, // 54 Stop
  0xC8, 0xE0, 0x72, 0x28, 0x16, 0x09, 0x09, 0x06, // 55 Temp (mic)
  0x0E, 0x13, 0x21, 0x41, 0x82, 0x84, 0xC8, 0x70, // 56 Test (hollow oval shap from top left to lower right)
  0x10, 0x50, 0x54, 0x54, 0x34, 0x18, 0x10, 0x10, // 57 USB 1
  0x70, 0x88, 0xC4, 0xE2, 0x7E, 0x32, 0x09, 0x07, // 58 USB 2
  0x80, 0xA0, 0xA8, 0xAB, 0xAB, 0xA8, 0xA0, 0x80, // 59 Wifi 1

  0x40, 0x90, 0xA4, 0xA9, 0xA9, 0xA4, 0x90, 0x40, // 60 Wifi 2
};

Bitmap bitmaps[] = {
  { 0, 8, 8 }, // 0
  { 0, 8, 8 }, // 1
  { 0, 16, 10 }, // 2
  { 0, 8, 8 }, // 3
  { 0, 8, 8 }, // 4
  { 0, 8, 8 }, // 5
  { 0, 8, 8 }, // 6
  { 0, 8, 8 }, // 7
  { 0, 8, 8 }, // 8
  { 0, 8, 8 }, // 9
  { 0, 8, 8 }, // 10
  { 0, 8, 8 }, // 11
  { 0, 8, 8 }, // 12
  { 0, 8, 8 }, // 13
  { 0, 8, 8 }, // 14
  { 0, 8, 8 }, // 15
  { 0, 8, 8 }, // 16
  { 0, 8, 8 }, // 17
  { 0, 8, 8 }, // 18
  { 0, 8, 8 }, // 19
  { 0, 8, 8 }, // 20
  { 0, 8, 8 }, // 21
  { 0, 8, 8 }, // 22
  { 0, 8, 8 }, // 23
  { 0, 8, 8 }, // 24
  { 0, 8, 8 }, // 25
  { 0, 8, 8 }, // 26
  { 0, 8, 8 }, // 27
  { 0, 8, 8 }, // 28
  { 0, 8, 8 }, // 29
  { 0, 8, 8 }, // 30
  { 0, 8, 8 }, // 31
  { 0, 8, 8 }, // 32
  { 0, 8, 8 }, // 33
  { 0, 8, 8 }, // 34
  { 0, 8, 8 }, // 35
  { 0, 8, 8 }, // 36
  { 0, 8, 8 }, // 37
  { 0, 8, 8 }, // 38
  { 0, 8, 8 }, // 39
  { 0, 8, 8 }, // 40
  { 0, 8, 8 }, // 41
  { 0, 8, 8 }, // 42
  { 0, 8, 8 }, // 43
  { 0, 8, 8 }, // 44
  { 0, 8, 8 }, // 45
  { 0, 8, 8 }, // 46
  { 0, 8, 8 }, // 47
  { 0, 8, 8 }, // 48
  { 0, 8, 8 }, // 49
  { 0, 8, 8 }, // 50
  { 0, 8, 8 }, // 51
  { 0, 8, 8 }, // 52
  { 0, 8, 8 }, // 53
  { 0, 8, 8 }, // 54
  { 0, 8, 8 }, // 55
  { 0, 8, 8 }, // 56
  { 0, 8, 8 }, // 57
  { 0, 8, 8 }, // 58
  { 0, 8, 8 }, // 59
  { 0, 8, 8 }, // 60
};
