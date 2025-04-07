#!/bin/bash

#CHANGE FOR GNU TOOLCHAIN
risc_gdb="riscv64-linux-gnu"
m_opt="-march=rv64imac"
qemu_opt="qemu-riscv64"
debugger="riscv64-linux-gnu-gdb"
#CHANGE FOR GNU TOOLCHAIN

#PRINT HELP
if [[ $1 == "-h" ]] || [[ $1 == "-help" ]]; then
	local_help_text=$(echo "elfer is a quick and dirty \e[33;1m$risc_gdb \e[0mcompiler.\n\n
		\t-g [file]\t| --gdb\t\t\t| compile with the -g flag\n
		\t-a [file]\t| --assemble\t\t| compile the object file and the executable\n
		\t-c [file]\t| --clean\t\t| cleans the object and exe files given a name\n
		\t-d [file]\t| --debug\t\t| runs \e[033;1m$debugger\e[0m [file]\n
		\t-h \t\t| --help\t\t| hi\n\n
	
	assembling a file or running an executable will overwrite the ".elfer_exe" file\n
	as a way to remember the last file run or compiled. This will allow you to run\n
	said file with zero arguments.\n\n
	example use:\n
	\e[32;1melfer -a hello_world\e[0m\t| this will create the files hello_world.o and hello_world.exe from hello_world.s.\n
	\e[32;1melfer\e[0m\t\t\t| this will run hello_world.exe\n
	\e[32;1melfer hello_world\e[0m\t| this will also run hello_world.exe\n
	\e[32;1melfer wassup_world\e[0m\t| this will run wassup_world.exe\n
	\e[32;1melfer\e[0m \t\t\t| this will now run wassup_world.exe\n\n\n


	The following options are adjustable at the top of the elfer.sh file.\n
	_____________________\n\n

	CURRENT GDB TOOLCHAIN:\t\t\e[33;1m$risc_gdb\e[0m\n
	ADDITIONAL ASSEMBLE FLAG:\t\e[33;1m$m_opt\e[0m\n
	QEMU-USER:\t\t\t\e[33;1m$qemu_opt\e[0m\n
	DEBUGGING TOOL:\t\t\e[33;1m$debugger\e[0m\n
	_____________________\n
	")
	echo -e $local_help_text
	exit 0
fi


#REST OF CODE
function assemble(){
	$($risc_gdb-as $dbg_mode $m_opt -o $obj_file $src_file)
	$($risc_gdb-ld -o $exe_file $obj_file)
	exit 0
}

function set_elfer_exe(){
	if [[ ! -e .elfer_exe ]]; then
		touch .elfer_exe
	fi
	echo $1 > .elfer_exe
}

dbg_mode=""
filename=""
if [[ $# == 0 ]]; then
	if [[ ! -e .elfer_exe ]]; then
		echo -e "\e[31;1mPlease append a filename\e[0m"
		exit 1
	else
		filename=$(echo | cat .elfer_exe)
	fi
	exe_file=$filename.exe
	$qemu_opt $exe_file
	exit 0
elif [[ $# == 1 ]] && [[ $1 != *-* ]]; then
	if [[ -e $1 ]]; then
		$(set_elfer_exe $1)
	fi
	filename=$1
	filename=$(echo $1 | sed "s/\.s//g")
	exe_file=$filename.exe
	$qemu_opt $exe_file
	exit 0
elif [[ $# == 2 ]] && [[ $1 != *-* ]]; then
	$(set_elfer_exe $2)
fi

if [[ $# -ge 1 ]] && [[ $# -lt 3 ]]; then
	filename=$2
	filename=$(echo $filename | sed "s/\.s//g")
	src_file=${filename}.s
	obj_file=${filename}.o
	exe_file=${filename}.exe

	if [ $# -eq 1 ]; then
		echo -e "\e[31;1mToo few arguments\e[0m"
		exit 1
	elif [ $# -eq 2 ]; then
		filename=$2
	fi
	case $1 in
	-g | --gdb)
		dbg_mode='-g'
		$(set_elfer_exe $2)
		$(assemble)
		;;
	-a | --assemble)
		$(set_elfer_exe $2)
		$(assemble)
		;;
	-c | --clean)
		rm ${filename}.o
		rm ${filename}.exe
		rm .elfer_exe
		;;
	-d | --debug)
		if [[ -e ${exe_file} ]]; then
			$debugger ${exe_file}
		else
			echo -e "\e[31;1mCould not find $exe_file\e[0m"
		fi
		;;
	esac
elif [[ $# -gt 2 ]]; then
	echo -e "\e[31;1mToo many arguments\e[0m"
fi
exit 0
