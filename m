Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j33IC2Do024475
	for <selinux@tycho.nsa.gov>; Sun, 3 Apr 2005 14:12:02 -0400 (EDT)
Received: from hermes.domdv.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j33I7RuF025219
	for <selinux@tycho.nsa.gov>; Sun, 3 Apr 2005 18:07:28 GMT
Message-ID: <42503182.2010103@domdv.de>
Date: Sun, 03 Apr 2005 20:10:10 +0200
From: Andreas Steinmetz <ast@domdv.de>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: shell based replacement for genhomedircon
Content-Type: multipart/mixed;
 boundary="------------000400040901090905010601"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000400040901090905010601
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Attached is a shell based replacement for genhomedircon that seems to
work properly, at least for me. Not everybody installs python on servers
just for a single script.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------000400040901090905010601
Content-Type: text/plain;
 name="genhomedircon"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="genhomedircon"

#!/bin/sh
usage()
{
echo "Usage: $1 [ -d selinuxdir ] [-n | --nopasswd] [-t selinuxtype ]"
exit 1
}

homelist()
{
minuid="$1"
bdir="$2"
type="$3"
cfile="$bdir/$type/contexts/files/file_contexts"
IFS=":"
while [ 1 ]
do
	read user pw uid gid info dir shell || return 0
	[ $uid -lt $minuid ] && continue
	[ "$shell" = "/bin/false" ] && continue
	[ "$shell" = "/sbin/nologin" ] && continue
	[ "${dir:0:1}" != "/" ] && continue
	[ "$dir" = "/" ] && continue
	[ `echo "$dir" | sed 's#/#\\
#g' | grep -c .` -lt 2 ] && continue
	[ ! -d "$dir" ] && continue
	egrep -q '^$dir[^[:alnum:]_-]' "$cfile" 2> /dev/null
	if [ $? = 0 ]
	then
		(
		echo "$dir is already defined in $cfile,"
		echo "genhomedircon will not create a new context."
		) 1>&2
	else
		echo "$user $dir"
	fi
done
}

rootlist()
{
bdir="$1"
type="$2"
cfile="$bdir/$type/contexts/files/file_contexts"
IFS=":"
while [ 1 ]
do
	read user pw uid gid info dir shell || return 0
	[ "$user" != "root" ] && continue
	[ "$shell" = "/bin/false" ] && continue
	[ "$shell" = "/sbin/nologin" ] && continue
	[ "${dir:0:1}" != "/" ] && continue
	[ ! -d "$dir" ] && continue
	egrep -q '^$dir[^[:alnum:]_-]' "$cfile" 2> /dev/null
	if [ $? = 0 ]
	then
		(
		echo "$dir is already defined in $cfile,"
		echo "genhomedircon will not create a new context."
		) 1>&2
	else
		echo "$user $dir"
	fi
done
}

gen()
{
bdir="$1"
type="$2"
tfile="$bdir/$type/contexts/files/homedir_template"
while [ 1 ]
do
	read user dir || return 0
	[ "$user" = "" ] && continue
	if [ "$dir" = "" ]
	then
		dftdir="$user"
		dir="$user/"'[^/]*'
		user="user_u"
	fi
	mode="user"
	if [ "$user" = "root" ]
	then
		mode="staff"
		sed -n -e "s:HOME_ROOT:&:" -e "t wrk" -e "b done" \
			-e ":wrk" -e "s:^HOME_ROOT:$dftdir:" \
			-e "p" -e ":done" "$tfile" 2> /dev/null
	fi
	echo
	echo
	echo "#"
	echo "# Context for user $user"
	echo "#"
	echo
	sed -n -e "s:^HOME_DIR:$dir:" -e "t wrk" -e "b done" \
		-e ":wrk" -e "s:ROLE:$mode:" -e "s:system_u:$user:" \
		-e "p" -e ":done" "$tfile" 2> /dev/null
done
}

doit()
{
dir="$1"
type="$2"
usepw="$3"

cat - << EOF

#
#
# User-specific file contexts, generated via $self
# edit $dir/$type/users/local.users to change file_context
#
#
EOF

home=`sed -n -e 's#^HOME=##' -e 't out' -e 'b done' \
	-e ':out' -e 'p' -e ':done' /etc/default/useradd 2> /dev/null | \
	tail -n 1`
[ "$home" = "" ] && home="/home"

minuid=`sed -n -e 's#^UID_MIN[ 	]\+##' -e 't out' -e 'b done' \
	-e ':out' -e 'p' -e ':done' /etc/login.defs 2> /dev/null | \
	tail -n 1`
[ "$minuid" = "" ] && minuid="500"

if [ "$usepw" = "1" ]
then
	homes=`getent passwd | homelist "$minuid" "$dir" "$type" | \
		sort -u -k2,2`
	root=`getent passwd | rootlist "$dir" "$type" | tail -n 1`
else
	homes=""
	root=""
fi
( echo "$home" ; echo "$root" ; echo "$homes" ) | gen "$dir" "$type"
echo
}

self=`which "$0"`
dir=/etc/selinux
usepw=1;
type=""

while [ "$1" != "" ]
do
	case "$1" in
	-d|--directory)
		[ "$2" = "" ] && usage $self
		dir="$2"
		shift
		;;
	-n|--nopasswd)
		usepw=0
		;;
	-t|--type)
		[ "$2" = "" ] && usage $self
		type="$2"
		shift
		;;
	*)
		usage $self
		;;
	esac
	shift
done

if [ "$type" = "" ]
then
	type=`sed -n 's#^SELINUXTYPE=##' -e 't out' -e 'b done' \
		-e ':out' -e 'p' -e ':done' $dir/config 2> /dev/null`
	[ "$type" = "" ] && type="targeted"
fi

doit "$dir" "$type" "$usepw" > $dir/$type/contexts/files/file_contexts.homedirs

--------------000400040901090905010601--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
