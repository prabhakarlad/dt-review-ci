# SPDX-License-Identifier: GPL-2.0-only
# Copyright 2018-2022 Rob Herring <robh@kernel.org>

my_pwclient() {
	local cmd=$1
	shift
	IFS=' '

	if [ -z "$dryrun" ]; then
		echo "$@" 1>&2
		command pwclient $cmd "$@"
	else
		echo "pwclient $cmd $@" >&2
	fi
}

get_ids_for_subject() {
	grep ' "Not A' | grep "$@" | cut -d' ' -f1 | sort -nr | xargs
}

get_patch_subject() {
	(sed -e 's/.* <.*> "\(.*\)"$/\1/' | sed -e 's/^\[.*\] //') <<< "$*"
}

get_patch_msgid() {
	sed -n -e 's/.* <\([^ ]*\)> ".*/\1/p' <<< "$*"
}

get_patch_pw_id() {
	IFS=' '
	(cut -d' ' -f1 | xargs) <<< "$*"
}
