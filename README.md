# ELFER
A bash script for assembling and running riscv files.
#### commands
```
  -g [file] | --gdb      | compile with the -g flag
  -a [file] | --assemble | compile the object file and the executable
  -c [file] | --clean    | cleans the object and exe files given a name
  -d [file] | --debug    | runs your chosen debugger and appends the selected file
  -h 	    | --help     | print the help menu
```
#### example use
```
elfer -a hello_world 	| this will create the files hello_world.o and hello_world.exe from hello_world.s
elfer 			| this will run hello_world.exe
elfer hello_world 	| this will also run hello_world.exe
elfer wassup_world 	| this will run wassup_world.exe
elfer 			| this will now run wassup_world.exe
```
\
assembling a file or running an executable will overwrite the ".elfer_exe" file\
as a way to remember the last file run or compiled. This will allow you to run\
said file with zero arguments.\
\
*The script uses* sed *to extract the filename. If you type example.s or example there will be no difference.*

# OPTIONS
These options can be changed at the top of the elfer.sh file.\
\
**GDB TOOLCHAIN**\
default: *riscv64-linux-gnu*\
\
**ADDITIONAL ASSEMBLE FLAG**\
default: *-march=rv64imac*\
\
**QEMU-USER**\
default: *qemu-riscv64*\
\
**DEBUGGING TOOL**\
default: *riscv64-linux-gnu-gdb*

_____________________
# INSTALLATION
Copy the elfer.sh script into a new file on your computer. I use ~/.scripts/elfer/elfer.sh\
\
`chmod +x {file/location/of/elfer.sh}`\
This will make the file an executable script.\
\
`ln -s {file/location/of/elfer.sh} /bin/elfer`\
This will create a symbolic link (shortcut) to the script.
