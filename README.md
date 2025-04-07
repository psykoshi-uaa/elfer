# elfer
A bash script for assembling and running riscv files

elfer is a quick and dirty \e[33;1m$risc_gdb \e[0mcompiler.
	-g [file]| --gdb| compile with the -g flag
	-a [file]| --assemble| compile the object file and the executable
	-c [file]| --clean| cleans the object and exe files given a name
	-d [file]| --debug| runs \e[033;1m$debugger\e[0m [file]
	-h | --help| hi

assembling a file or running an executable will overwrite the ".elfer_exe" file
as a way to remember the last file run or compiled. This will allow you to run
said file with zero arguments.
example use:
\e[32;1melfer -a hello_world\e[0m| this will create the files hello_world.o and hello_world.exe from hello_world.s.
\e[32;1melfer\e[0m| this will run hello_world.exe
\e[32;1melfer hello_world\e[0m| this will also run hello_world.exe
\e[32;1melfer wassup_world\e[0m| this will run wassup_world.exe
\e[32;1melfer\e[0m | this will now run wassup_world.exe


The following options are adjustable at the top of the elfer.sh file.
_____________________

CURRENT GDB TOOLCHAIN:\e[33;1m$risc_gdb\e[0m
ADDITIONAL ASSEMBLE FLAG:\e[33;1m$m_opt\e[0m
QEMU-USER:\e[33;1m$qemu_opt\e[0m
DEBUGGING TOOL:\e[33;1m$debugger\e[0m
_____________________
fi
