#!/bin/sh
# par le meilleur Nathan fork par joris pour printf

Clone()
{
	if [ -d "$UPSTREAM" ]; then
		printf "%s\n" "cp -R $UPSTREAM $CLONE_DIST"
		cp -R "$UPSTREAM" "$CLONE_DIST" || PanicExit
		make -C "$UPSTREAM" fclean
	else
		git clone "$UPSTREAM" "$CLONE_DIST/ft_printf" || PanicExit
	fi
}

Usage()
{
	printf "usage: sh mtpf.sh <git source>\n"
	exit 1
}

PanicExit()
{
	rm -rf "$CLONE_DIST"
	exit 1
}

PressEnter()
{
	printf "Press enter to continue" || PanicExit
	read NOTHING || PanicExit
}

PrintfTester()
{
	printf "RUNNING PRINTF TESTER\n" || PanicExit
	git clone "https://github.com/Tripouille/printfTester.git" "$CLONE_DIST/ft_printf/printfTester" || PanicExit
	cd "$CLONE_DIST/ft_printf/printfTester" || PanicExit
	make m || PanicExit
}

PrintfTester2()
{
	printf "RUNNING PRINTF TESTER\n" || PanicExit
	git clone "https://github.com/paulo-santana/ft_printf_tester.git" "$CLONE_DIST/ft_printf/ft_printf_tester" || PanicExit
	cd "$CLONE_DIST/ft_printf/ft_printf_tester" || PanicExit
	sh test m || PanicExit
}

UPSTREAM="$1"
[ "$UPSTREAM" = "" ] && Usage
CLONE_DIST="$(mktemp -d || exit 1)"
RESULT_DIR="$PWD"
Clone
PrintfTester
PressEnter
PrintfTester2
PressEnter
