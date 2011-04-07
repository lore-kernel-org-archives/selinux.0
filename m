Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p37Fs0ob032436
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2011 11:54:00 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p37FrxaQ008662
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2011 15:53:59 GMT
Message-ID: <4D9DDE14.8070100@redhat.com>
Date: Thu, 07 Apr 2011 11:53:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Elia Pinto <andronicus.spiros@gmail.com>
CC: selinux@tycho.nsa.gov, Elia Pinto <yersinia.spiros@gmail.com>,
        pinto.elia@gmail.com
Subject: Re: [PATCH] Permit fixfiles to skip configurable directory from relabelling
References: <1302191243-604822-1-git-send-email-andronicus.spiros@gmail.com>
In-Reply-To: <1302191243-604822-1-git-send-email-andronicus.spiros@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------070508000806050707000402"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070508000806050707000402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/07/2011 11:47 AM, Elia Pinto wrote:
> From: Elia Pinto <yersinia.spiros@gmail.com>
> 
> This patch permit fixfiles to check /.autorelabel_excluded
> for a list of directories to exclude from relabelling.
> 
> Inspired by this blog http://danwalsh.livejournal.com/38157.html.
> 
> Signed-off-by: Elia Pinto <yersinia.spiros@gmail.com>
> ---
>  policycoreutils/scripts/fixfiles   |   44 ++++++++++++++++++++++++++++++++---
>  policycoreutils/scripts/fixfiles.8 |    2 +
>  2 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index ae519fc..ba4d4b1 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -28,6 +28,7 @@ FORCEFLAG=""
>  DIRS=""
>  RPMILES=""
>  LOGFILE=`tty`
> +FINDEXCLUDEDPATH=""
>  if [ $? != 0 ]; then
>      LOGFILE="/dev/null"
>  fi
> @@ -46,6 +47,24 @@ else
>      FC=/etc/security/selinux/file_contexts
>  fi
>  
> +# Add an excluded path for the following
> +# find in the function restore, relabel
> +
> +if [ -e /.autorelabel_excluded ]
> +then
> +	while read _p
> +	do
> +          # skip blank line and comment 
> +          # skip not absolute path
> +          # skip not directory
> +          [ -z "${_p}" ] && continue
> +          [[ "${_p}" =~ "^[[:blank:]]*#" ]] && continue
> +          [[ ! "${_p}" =~ "^/.*" ]] && continue
> +          [[ ! -d "${_p}" ]] && continue
> +	  FINDEXCLUDEDPATH="${FINDEXCLUDEDPATH} -o -path \"${_p}\""
> +	done < /.autorelabel_excluded
> +fi
> +
>  #
>  # Log to either syslog or a LOGFILE
>  #
> @@ -88,7 +107,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
>                 fi; \
>              done | \
>  	while read pattern ; do sh -c "find $pattern \
> -		      ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev  -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs \) -prune  -o \
> +		      ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev  -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs ${FINDEXCLUDEDPATH}\) -prune  -o \
>  		      \( -wholename /home -o -wholename /root -o -wholename /tmp -wholename /dev \) -prune -o -print0"; \
>  		      done 2> /dev/null | \
>  	 ${RESTORECON} $* -0 -f - 
> @@ -127,8 +146,9 @@ if [ ! -z "$RPMFILES" ]; then
>  fi
>  if [ ! -z "$FILEPATH" ]; then
>      if [ -x /usr/bin/find ]; then
> +        loggit "skipping the directory ${FINDEXCLUDEDPATH//-o -path/} from relabelling"
>  	/usr/bin/find "$FILEPATH" \
> -	    ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs \) -prune  -o -print0 | \
> +	    ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs ${FINDEXCLUDEDPATH}\) -prune  -o -print0 | \
>  	    ${RESTORECON} ${FORCEFLAG} $* -0 -f - 2>&1 >> $LOGFILE
>      else
>  	${RESTORECON} ${FORCEFLAG} -R $* $FILEPATH 2>&1 >> $LOGFILE
> @@ -137,8 +157,24 @@ if [ ! -z "$FILEPATH" ]; then
>  fi
>  [ -x /usr/sbin/genhomedircon ] && /usr/sbin/genhomedircon
>  LogReadOnly
> -${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
> -rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*
> +# 
> +# 
> +# "<<none>>" '/md/distro?(/.*)?'
> +TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
> +test -z "$TEMPFILE" && exit
> +cp -p ${FC} ${TEMPFILE} 
> +FINDEXCLUDEDPATH=${FINDEXCLUDEDPATH//-o -path/}
> +FINDEXCLUDEDPATH=${FINDEXCLUDEDPATH//\"/}
> +for _p in $FINDEXCLUDEDPATH
> +do
> +	_p="${_p%/}"
> +	_p1="${_p}(/.*)? -- <<none>>"
> +	echo "${_p1}" >> $TEMPFILE
> +        logit "skipping the directory ${_p} from relabelling"
> +done
> +
> +${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${TEMPFILE} ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
> +rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-* $TEMPFILE
>  find /tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t tmp_t {} \;
>  find /var/tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t tmp_t {} \;
>  exit $?
> diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/fixfiles.8
> index dfe8aa9..865aab4 100644
> --- a/policycoreutils/scripts/fixfiles.8
> +++ b/policycoreutils/scripts/fixfiles.8
> @@ -29,6 +29,8 @@ new policy, or  just check whether the file contexts are all
>  as you expect.  By default it will relabel all mounted ext2, ext3, xfs and 
>  jfs file systems as long as they do not have a security context mount 
>  option.  You can use the -R flag to use rpmpackages as an alternative.
> +The file /.autorelabel_exclude can contain a list of directory path
> +that fixfiles don't relabel.
>  .P
>  .B fixfiles onboot 
>  will setup the machine to relabel on the next reboot.

This file should not be in /, I think it would be better to put it in
/etc/selinux

I have attached the current Fedora fixfiles.  Which has some similar fixes.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2d3hQACgkQrlYvE4MpobNgYACg4hHDc5kgHLVPdfjb2KmytGNY
rggAn0INl+1Mf5odXoUq5rJQR6FT/RzD
=KAVX
-----END PGP SIGNATURE-----

--------------070508000806050707000402
Content-Type: text/plain;
 name="fixfiles"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fixfiles"

#!/bin/bash
# fixfiles
#
# Script to restore labels on a SELinux box
#
# Copyright (C) 2004-2009 Red Hat, Inc.
# Authors: Dan Walsh <dwalsh@redhat.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

#
# Get all mounted rw file systems that support seclabel
#
get_labeled_mounts() {
# /dev is not listed in the mountab
FS="`mount | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/\(rw/{print $3}';` /dev"
for i in $FS; do 
    grep --silent "$i ".*seclabel /proc/self/mounts && echo $i
done
}

exclude_dirs() {
    exclude= 
    for i in /var/lib/BackupPC /home /tmp /dev; do 
        [ -e $i ]  && exclude="$exclude -e $i"; 
    done 
    echo "$exclude"
}

#
# Set global Variables
#
fullFlag=0
FORCEFLAG=""
DIRS=""
RPMILES=""
LOGFILE=`tty`
if [ $? != 0 ]; then
    LOGFILE="/dev/null"
fi
SYSLOGFLAG="-l"
LOGGER=/usr/sbin/logger
SETFILES=/sbin/setfiles
RESTORECON=/sbin/restorecon
FILESYSTEMS=`get_labeled_mounts`
SELINUXTYPE="targeted"
if [ -e /etc/selinux/config ]; then
    . /etc/selinux/config
    FC=/etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts 
else
    FC=/etc/security/selinux/file_contexts
fi

#
# Log to either syslog or a LOGFILE
#
logit () {
if [ -n $LOGFILE ]; then
    echo $1 >> $LOGFILE
fi
}
#
# Compare PREVious File Context to currently installed File Context and 
# run restorecon on all files affected by the differences.
#
diff_filecontext() {
if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
	TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
	test -z "$TEMPFILE" && exit
	PREFCTEMPFILE=`mktemp ${PREFC}.XXXXXXXXXX`
	sed -r -e 's,:s0, ,g' $PREFC | sort -u > ${PREFCTEMPFILE}
	sed -r -e 's,:s0, ,g' $FC | sort -u | \
	/usr/bin/diff -b ${PREFCTEMPFILE} - | \
	    grep '^[<>]'|cut -c3-| grep ^/ | \
	    egrep -v '(^/home|^/root|^/tmp|^/dev)' |\
	sed -r -e 's,[[:blank:]].*,,g' \
               -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
	       -e 's|([/[:alnum:]])\?|{\1,}|g' \
               -e 's|\?.*|*|g' \
	       -e 's|\(.*|*|g' \
	       -e 's|\[.*|*|g' \
               -e 's|\.\*.*|*|g' \
               -e 's|\.\+.*|*|g' | \
	    # These two sorts need to be separate commands \
	sort -u | \
	sort -d | \
        while read pattern ; \
	    do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null; then \
                  echo "$pattern"; \
                  case "$pattern" in *"*") \
	               echo "$pattern" | sed -e 's,^,^,' -e 's,\*$,,g' >> ${TEMPFILE};;  
                  esac; \
               fi; \
            done | \
		      ${RESTORECON} -f - -R -p `exclude_dirs`; \
	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
fi
}

rpmlist() {
rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | grep '^0 ' | cut -f2- -d ' '
[ ${PIPESTATUS[0]} != 0 ] && echo "$1 not found" >/dev/stderr
}

# 
# restore
# if called with -n will only check file context
#
restore () {
if [ ! -z "$PREFC" ]; then
    diff_filecontext $*
    exit $?
fi
if [ ! -z "$RPMFILES" ]; then
    for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
	rpmlist $i | ${RESTORECON} ${FORCEFLAG} $* -R -i -f - 2>&1 | cat >> $LOGFILE
    done
    exit $?
fi
if [ ! -z "$FILEPATH" ]; then
    ${RESTORECON} ${FORCEFLAG} -R $* $FILEPATH 2>&1 | cat >> $LOGFILE
    return
fi
[ -x /usr/sbin/genhomedircon ] && /usr/sbin/genhomedircon
${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMS} 2>&1 | cat >> $LOGFILE
rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*
find /tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t tmp_t {} \;
find /var/tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec chcon -t tmp_t {} \;
exit $?
}

fullrelabel() {
    logit "Cleaning out /tmp"
    find /tmp/ -mindepth 1 -delete
    restore
}

relabel() {
    if [ ! -z "$RPMFILES" ]; then
	restore 
    fi

    if [ $fullFlag == 1  ]; then
	fullrelabel
    fi

    echo -n "
    Files in the /tmp directory may be labeled incorrectly, this command 
    can remove all files in /tmp.  If you choose to remove files from /tmp, 
    a reboot will be required after completion.
    
    Do you wish to clean out the /tmp directory [N]? "
    read answer
    if [ "$answer" = y -o  "$answer" = Y ]; then 
	fullrelabel
    else
	restore
    fi
}

process() {
#
# Make sure they specified one of the three valid commands
#
case "$1" in
    restore) restore -p ;;
    check) restore -n -v;;
    verify) restore -n -o -;;
    relabel) relabel;;
    onboot)
	touch /.autorelabel
	echo "System will relabel on next boot"
	;;
    *)
    usage
    exit 1
esac
}
usage() {
      	echo $"""
Usage: $0 [-F] [-l logfile ] { check | restore| [-f] relabel | verify } [[dir/file] ... ] 
or
Usage: $0 [-F] -R rpmpackage[,rpmpackage...] [-l logfile ] { check | restore | verify }
or
Usage: $0 [-F] -C PREVIOUS_FILECONTEXT { check | restore | verify }
or
Usage: $0 onboot
"""
}

if [ $# = 0 ]; then
	usage
	exit 1
fi

# See how we were called.
while getopts "C:FfR:l:" i; do
    case "$i" in
	f)
		fullFlag=1
		;;
        R)
		RPMFILES=$OPTARG
		;;
        l)
		LOGFILE=$OPTARG
		;;
        C)
		PREFC=$OPTARG
		;;
	F)
		FORCEFLAG="-F"
		;;
	*)
	    usage
	    exit 1
esac
done

# Move out processed options from arguments
shift $(( OPTIND - 1 ))

# Check for the command
command=$1
if [ -z $command ]; then
    usage
fi

# Move out command from arguments
shift

#
# check if they specified both DIRS and RPMFILES
#

if [ ! -z "$RPMFILES" ]; then
    process $command
    if [ $# -gt 0 ]; then
	    usage
    fi
else
    if [ -z "$1" ]; then
	process $command
    else
	while [ -n "$1" ]; do 
	    FILEPATH=$1
	    process $command 
	    shift
    	done
    fi
fi
exit $?

--------------070508000806050707000402
Content-Type: application/pgp-signature;
 name="fixfiles.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="fixfiles.sig"

iEYEABECAAYFAk2d3hQACgkQrlYvE4MpobPYLgCdESi25HquizOI/NBtmspWvOCalngAnj8G
wFZ5/2AC3qnXVpfbQU5trgB3
--------------070508000806050707000402--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
