#! /bin/bash

patch -p1 </fixups/msrv.diff

deps=`mktemp`
cargo tree --prefix none | sed -re 's/(^.* v[0-9\.]*).*$/\1/' | sort | uniq >$deps

getvers () {
	local pkg=$1
	grep "^$pkg " $deps | sed -e "s/$pkg //" | sed -e "s/^v//"
}

getvers anstream

subpkg () {
	local pkg=$1
	local vrex=$2
	local newv=$3

	for oldv in $(getvers $pkg); do
		echo -n "$pkg	$oldv	:  "
		if echo "$oldv" | grep -q "$vrex"; then
			echo "updating to $newv"
			echo cargo update -p $pkg@$oldv --precise $newv
			cargo update -p $pkg@$oldv --precise $newv || true
		else
			echo "leaving unchanged"
		fi
	done
}

# in future, can improve this by using a horrid hack such
# as: https://gist.github.com/jonlabelle/6691d740f404b9736116c22195a8d706

subpkg anstream		'^0\.5'	0.4.0
subpkg clap_lex		""	0.5.0
subpkg clap_builder 	""	4.3.24
subpkg clap		""	4.3.24
subpkg anstyle		""	1.0.2
