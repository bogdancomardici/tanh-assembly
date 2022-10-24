# tanh-assembly
nasm -f elf64 -g -F dwarf name.asm -l name.lst & gcc -o name name.o -no-pie
where name is the filename.
