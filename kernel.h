enum class vga_color : uint16_t;

uint8_t make_color(enum vga_color fg, enum vga_color bg);
uint16_t make_vgaentry(char, uint8_t);
size_t strlen(const char*);
void terminal_initialize();
void terminal_setcolor(uint8_t);
void terminal_putentryat(char c, uint8_t color, size_t x, size_t y);
void terminal_putchar(char);
void terminal_writestring(const char*);

extern "C"
void kernel_main();
