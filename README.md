# ELFER
A bash script for assembling and running riscv files

elfer is a quick and dirty riscv compiler. The following commands require an additional flag that will be taken as a filename (except for --help)\
`	-g [file]| --gdb	| compile with the -g flag`\
`	-a [file]| --assemble	| compile the object file and the executable`\
`	-c [file]| --clean	| cleans the object and exe files given a name`\
`	-d [file]| --debug	| runs \e[033;1m$debugger [file]`\
`	-h 	 | --help	| hi`\
\
assembling a file or running an executable will overwrite the ".elfer_exe" file\
as a way to remember the last file run or compiled. This will allow you to run\
said file with zero arguments.\
\
example use:\
`elfer -a hello_world 	| this will create the files hello_world.o and hello_world.exe from hello_world.s`\
`elfer 			| this will run hello_world.exe`\
`elfer hello_world 	| this will also run hello_world.exe`\
`elfer wassup_world 	| this will run wassup_world.exe`\
`elfer 			| this will now run wassup_world.exe`\


## OPTIONS

GDB TOOLCHAIN\
ADDITIONAL ASSEMBLE FLAG\
QEMU-USER\
DEBUGGING TOOL
_____________________
