Message-ID: <41FA9FA8.7010008@redhat.com>
Date: Fri, 28 Jan 2005 15:25:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Patch to policycoreutils
References: <1106927779.32737.59.camel@moss-spartans.epoch.ncsc.mil>	 <41FA6861.6080505@redhat.com> <1106941913.32737.138.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1106941913.32737.138.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------080003090305010304050202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080003090305010304050202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Fri, 2005-01-28 at 11:29, Daniel J Walsh wrote:
>  
>
>>Added new fixfiles -C PREVIOUS_FILECONTEXT  (RESTORE | CHECK)
>>
>>Which will take an old version of the file_context file and the 
>>currently installed one and do a
>>diff.  Then it will run a recursive restorecon on all files covered by 
>>the difference.  The idea here
>>is to potentially call this function from within policy spec files on 
>>updates.  So the if the file_context
>>file changes on update, the file context on disk will be updated.
>>    
>>
>
>Interesting idea, although textual diffs of file_contexts may not be
>adequate.
>
>  
>
>>diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.21.5/scripts/fixfiles
>>--- nsapolicycoreutils/scripts/fixfiles	2005-01-26 11:30:57.000000000 -0500
>>+++ policycoreutils-1.21.5/scripts/fixfiles	2005-01-28 11:16:21.000000000 -0500
>>@@ -37,10 +37,12 @@
>> SELINUXTYPE="targeted"
>> if [ -e /etc/selinux/config ]; then
>>     . /etc/selinux/config
>>+    FILE_CONTEXT=/etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts 
>>     FC=`mktemp /etc/selinux/${SELINUXTYPE}/contexts/files/file_context.XXXXXX`
>>-    cat /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts /etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts.local > $FC 2> /dev/null
>>+    cat ${FILE_CONTEXT} ${FILE_CONTEXT}.local > $FC 2> /dev/null
>> else
>>-    FC=/etc/security/selinux/file_contexts
>>+    FILE_CONTEXT=/etc/security/selinux/file_contexts
>>+    FC=${FILE_CONTEXT}
>> fi
>>    
>>
>
>We no longer need to have fixfiles deal with file_contexts.local with
>the latest version of setfiles, since setfiles is now using matchpathcon
>and matchpathcon will internally check it as well.
>
>  
>
>>+#
>>+# Compare PREVious File Context to currently installed File Context and 
>>+# run restorecon on all files affected by the differences.
>>+#
>>+diff_filecontext() {
>>+if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
>>+	TEMPFILE=`mktemp /var/tmp/${SELINUXTYPE}.XXXXXXXXXX`
>>+	test -z "$TEMPFILE" && exit
>>+	/usr/bin/diff $PREFC $FILE_CONTEXT | egrep '^[<>]'|cut -c3-| grep ^/ | \
>>+        sed -e 's,\\.*,*,g' -e 's,(.*,*,g' -e 's,\[.*,*,g' -e 's,\..*,*,g' \
>>+            -e 's,[[:blank:]].*,,g' -e 's,\?.*,*,g' | sort -u | \
>>+        while read pattern ; do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null ; then echo "$pattern"; case "$pattern" in *"*") echo "$pattern" |sed 's,\*$,,g'>> ${TEMPFILE};;  esac; fi; done | \
>>+	while read pattern ; do find $pattern -print; done 2> /dev/null | \
>>+	${RESTORECON} $2 -v -f - 
>>+	rm -f ${TEMPFILE}
>>+fi
>>+}
>>    
>>
>
>Hmmm...I'm a bit concerned about the correctness and robustness of this
>filter pipeline, as well as with the notion of feeding restorecon from a
>temporary file.  Can you explain the stages in the filter pipeline a
>bit?  I think it would be preferable to make the temporary file in a
>directory with the same protections as the file_contexts configuration
>(i.e. /etc/selinux/${SELINUXTYPE}/contexts/files).
>
>  
>
I have attached an updated fixfiles.   TEMP FILE will not be in the 
/etc/selinux/${SELINUXTYPE}/contexts/files directory.
Also changed it to have restorecon to do the recursing instead of find.

Basically the pipeline is finding all files with a < or > output by 
diff, then it is looking for the first occurance of a regular expression
and replacing it with a "*".  Next it is checking if their is any overlap.

IE

/usr
/usr/bin/postgres
 
Only needs /usr since we are going to do a recursive restore.

Then restorecon will recurse on what ever it gets.  Worst case we end up 
doing a restorecon -R /  :^(

Best case we have a minor change in policy and we end up with
restorecon /usr/bin/pg*


Probably should change the script to avoid recursing over /tmp, /var/tmp 
and /home...




--------------080003090305010304050202
Content-Type: text/plain;
 name="fixfiles"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fixfiles"

#!/bin/sh
# fixfiles
#
# Script to restore labels on a SELinux box
#
# Copyright (C) 2004 Red Hat, Inc.
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
# Set global Variables
#
fullFlag=0
DIRS=""
RPMILES=""
OUTFILES=""
LOGFILE=/dev/null
SYSLOGFLAG="-l"
SETFILES=/usr/sbin/setfiles
RESTORECON=/sbin/restorecon
FILESYSTEMSRW=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs | reiserfs ).*\(rw/{print $3}';`
FILESYSTEMSRO=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs | reiserfs ).*\(ro/{print $3}';`
FILESYSTEMS="$FILESYSTEMSRW $FILESYSTEMSRO"
SELINUXTYPE="targeted"
if [ -e /etc/selinux/config ]; then
    . /etc/selinux/config
    FILE_CONTEXT=/etc/selinux/${SELINUXTYPE}/contexts/files/file_contexts 
    FC=`mktemp /etc/selinux/${SELINUXTYPE}/contexts/files/file_context.XXXXXX`
    cat ${FILE_CONTEXT} ${FILE_CONTEXT}.local > $FC 2> /dev/null
else
    FILE_CONTEXT=/etc/security/selinux/file_contexts
    FC=${FILE_CONTEXT}
fi

cleanup() {
    if [ -e /etc/selinux/config -a -f "$FC" ]; then
	rm -f $FC
    fi
}
trap "cleanup" 0 1 2 3 13 15

#
# Log to either syslog or a LOGFILE
#
logit () {
if [ -z $LOGFILE ]; then
    logger -i $1
else
    echo $1 >> $LOGFILE
fi
}
#
# Compare PREVious File Context to currently installed File Context and 
# run restorecon on all files affected by the differences.
#
diff_filecontext() {
if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
	TEMPFILE=`mktemp ${FILE_CONTEXT}.XXXXXXXXXX`
	test -z "$TEMPFILE" && exit
	/usr/bin/diff $PREFC $FILE_CONTEXT | egrep '^[<>]'|cut -c3-| grep ^/ | \
        sed -e 's,\\.*,*,g' -e 's,(.*,*,g' -e 's,\[.*,*,g' -e 's,\..*,*,g' \
            -e 's,[[:blank:]].*,,g' -e 's,\?.*,*,g' | sort -u | \
        while read pattern ; do if ! echo "$pattern" | grep -q -f ${TEMPFILE} 2>/dev/null ; then echo "$pattern"; case "$pattern" in *"*") echo "$pattern" |sed 's,\*$,,g'>> ${TEMPFILE};;  esac; fi; done | \
	while read pattern ; do find $pattern -maxdepth 0 -print; done 2> /dev/null | \
	${RESTORECON} $2 -v -f -R - 
	rm -f ${TEMPFILE}
fi
}
#
# Log all Read Only file systems 
#
LogReadOnly() {
if [ ! -z "$FILESYSTEMSRO" ]; then
    logit "Warning: Skipping the following R/O filesystems:"
    logit "$FILESYSTEMSRO"
fi
}

rpmlist() {
rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | grep '^0 ' | cut -f2- -d ' '
}

# 
# restore
# if called with -n will only check file context
#
restore () {
if [ ! -z "$PREFC" ]; then
    diff_filecontext $1
    exit $?
fi
if [ ! -z "$RPMFILES" ]; then
    for i in `echo $RPMFILES | sed 's/,/ /g'`; do
	rpmlist $i | ${RESTORECON} ${OUTFILES} -R $1 -v -f - 2>&1 >> $LOGFILE
    done
    exit $?
fi
if [ ! -z "$DIRS" ]; then
    ${RESTORECON} ${OUTFILES} -R $1 -v $DIRS 2>&1 >> $LOGFILE
    exit $?
fi
LogReadOnly
${SETFILES} ${OUTFILES} ${SYSLOGFLAG} $1 -v ${FC} ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
exit $?
}

fullrelabel() {
    logit "Cleaning out /tmp"
    rm -rf /tmp/.??* /tmp/*
    LogReadOnly
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

usage() {
      	echo $"Usage: $0 [-l logfile ] [-o outputfile ] { check | restore|[-F] relabel } [[dir] ... ] "
	echo or
      	echo $"Usage: $0 -R rpmpackage[,rpmpackage...] -C PREVIOUS_FILECONTEXT [-l logfile ] [-o outputfile ] { check | restore }"
}

if [ $# = 0 ]; then
	usage
	exit 1
fi

# See how we were called.
while getopts "C:Fo:R:l:" i; do
    case "$i" in
	F)
	fullFlag=1
	;;
        R)
		RPMFILES=$OPTARG
		;;
        o)
		OUTFILES=$OPTARG
		;;
        l)
		LOGFILE=$OPTARG
		;;
        C)
		PREFC=$OPTARG
		;;
	*)
	    usage
	    exit 1
esac
done


# Check for the command
eval command=\$${OPTIND}
let OPTIND=$OPTIND+1
if [ -z $command ]; then
    usage
fi

#
# check if they specified both DIRS and RPMFILES
#

if [ ! -z $RPMFILES ]; then
    if [ $OPTIND -le $# ]; then
	    usage
    fi
else
    while [ $OPTIND -le $# ]; do
	eval DIR=\$${OPTIND}
	DIRS="$DIRS $DIR"
	let OPTIND=$OPTIND+1
    done
fi
#
# Make sure they specified one of the three valid commands
#
case "$command" in
    restore) restore ;;
    check) restore -n ;;
    relabel) relabel;;
    *)
    usage
    exit 1
esac

--------------080003090305010304050202--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
