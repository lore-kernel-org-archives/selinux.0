Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3BIZws4030456
	for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2011 14:35:59 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3BIZv4j021840
	for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2011 18:35:57 GMT
Message-ID: <4DA34A0A.6050001@redhat.com>
Date: Mon, 11 Apr 2011 14:35:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Elia Pinto <andronicus.spiros@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Permit fixfiles to skip configurable directory from relabelling
References: <1302191243-604822-1-git-send-email-andronicus.spiros@gmail.com>	<4D9DDE14.8070100@redhat.com> <BANLkTimDnENx5eJ6ueRMFGT_WwLO50K_dA@mail.gmail.com>
In-Reply-To: <BANLkTimDnENx5eJ6ueRMFGT_WwLO50K_dA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/08/2011 01:14 PM, Elia Pinto wrote:
> On Thu, Apr 7, 2011 at 5:53 PM, Daniel J Walsh <dwalsh@redhat.com
> <mailto:dwalsh@redhat.com>> wrote:
> 
> On 04/07/2011 11:47 AM, Elia Pinto wrote:
>> From: Elia Pinto <yersinia.spiros@gmail.com
> <mailto:yersinia.spiros@gmail.com>>
> 
>> This patch permit fixfiles to check /.autorelabel_excluded
>> for a list of directories to exclude from relabelling.
> 
>> Inspired by this blog http://danwalsh.livejournal.com/38157.html.
> 
>> Signed-off-by: Elia Pinto <yersinia.spiros@gmail.com
> <mailto:yersinia.spiros@gmail.com>>
>> ---
>>  policycoreutils/scripts/fixfiles   |   44
> ++++++++++++++++++++++++++++++++---
>>  policycoreutils/scripts/fixfiles.8 |    2 +
>>  2 files changed, 42 insertions(+), 4 deletions(-)
> 
>> diff --git a/policycoreutils/scripts/fixfiles
> b/policycoreutils/scripts/fixfiles
>> index ae519fc..ba4d4b1 100755
>> --- a/policycoreutils/scripts/fixfiles
>> +++ b/policycoreutils/scripts/fixfiles
>> @@ -28,6 +28,7 @@ FORCEFLAG=""
>>  DIRS=""
>>  RPMILES=""
>>  LOGFILE=`tty`
>> +FINDEXCLUDEDPATH=""
>>  if [ $? != 0 ]; then
>>      LOGFILE="/dev/null"
>>  fi
>> @@ -46,6 +47,24 @@ else
>>      FC=/etc/security/selinux/file_contexts
>>  fi
> 
>> +# Add an excluded path for the following
>> +# find in the function restore, relabel
>> +
>> +if [ -e /.autorelabel_excluded ]
>> +then
>> +     while read _p
>> +     do
>> +          # skip blank line and comment
>> +          # skip not absolute path
>> +          # skip not directory
>> +          [ -z "${_p}" ] && continue
>> +          [[ "${_p}" =~ "^[[:blank:]]*#" ]] && continue
>> +          [[ ! "${_p}" =~ "^/.*" ]] && continue
>> +          [[ ! -d "${_p}" ]] && continue
>> +       FINDEXCLUDEDPATH="${FINDEXCLUDEDPATH} -o -path \"${_p}\""
>> +     done < /.autorelabel_excluded
>> +fi
>> +
>>  #
>>  # Log to either syslog or a LOGFILE
>>  #
>> @@ -88,7 +107,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
>>                 fi; \
>>              done | \
>>       while read pattern ; do sh -c "find $pattern \
>> -                   ! \( -fstype ext2 -o -fstype ext3 -o -fstype
> ext4 -o -fstype ext4dev  -o -fstype gfs2 -o -fstype jfs -o -fstype
> xfs -o -fstype btrfs \) -prune  -o \
>> +                   ! \( -fstype ext2 -o -fstype ext3 -o -fstype
> ext4 -o -fstype ext4dev  -o -fstype gfs2 -o -fstype jfs -o -fstype
> xfs -o -fstype btrfs ${FINDEXCLUDEDPATH}\) -prune  -o \
>>                     \( -wholename /home -o -wholename /root -o
> -wholename /tmp -wholename /dev \) -prune -o -print0"; \
>>                     done 2> /dev/null | \
>>        ${RESTORECON} $* -0 -f -
>> @@ -127,8 +146,9 @@ if [ ! -z "$RPMFILES" ]; then
>>  fi
>>  if [ ! -z "$FILEPATH" ]; then
>>      if [ -x /usr/bin/find ]; then
>> +        loggit "skipping the directory ${FINDEXCLUDEDPATH//-o
> -path/} from relabelling"
>>       /usr/bin/find "$FILEPATH" \
>> -         ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o
> -fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o
> -fstype btrfs \) -prune  -o -print0 | \
>> +         ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o
> -fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o
> -fstype btrfs ${FINDEXCLUDEDPATH}\) -prune  -o -print0 | \
>>           ${RESTORECON} ${FORCEFLAG} $* -0 -f - 2>&1 >> $LOGFILE
>>      else
>>       ${RESTORECON} ${FORCEFLAG} -R $* $FILEPATH 2>&1 >> $LOGFILE
>> @@ -137,8 +157,24 @@ if [ ! -z "$FILEPATH" ]; then
>>  fi
>>  [ -x /usr/sbin/genhomedircon ] && /usr/sbin/genhomedircon
>>  LogReadOnly
>> -${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC}
> ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
>> -rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*
>> +#
>> +#
>> +# "<<none>>" '/md/distro?(/.*)?'
>> +TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
>> +test -z "$TEMPFILE" && exit
>> +cp -p ${FC} ${TEMPFILE}
>> +FINDEXCLUDEDPATH=${FINDEXCLUDEDPATH//-o -path/}
>> +FINDEXCLUDEDPATH=${FINDEXCLUDEDPATH//\"/}
>> +for _p in $FINDEXCLUDEDPATH
>> +do
>> +     _p="${_p%/}"
>> +     _p1="${_p}(/.*)? -- <<none>>"
>> +     echo "${_p1}" >> $TEMPFILE
>> +        logit "skipping the directory ${_p} from relabelling"
>> +done
>> +
>> +${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${TEMPFILE}
> ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
>> +rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-* $TEMPFILE
>>  find /tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \)
> -exec chcon -t tmp_t {} \;
>>  find /var/tmp \( -context "*:file_t*" -o -context
> "*:unlabeled_t*" \) -exec chcon -t tmp_t {} \;
>>  exit $?
>> diff --git a/policycoreutils/scripts/fixfiles.8
> b/policycoreutils/scripts/fixfiles.8
>> index dfe8aa9..865aab4 100644
>> --- a/policycoreutils/scripts/fixfiles.8
>> +++ b/policycoreutils/scripts/fixfiles.8
>> @@ -29,6 +29,8 @@ new policy, or  just check whether the file
> contexts are all
>>  as you expect.  By default it will relabel all mounted ext2,
> ext3, xfs and
>>  jfs file systems as long as they do not have a security context mount
>>  option.  You can use the -R flag to use rpmpackages as an
> alternative.
>> +The file /.autorelabel_exclude can contain a list of directory path
>> +that fixfiles don't relabel.
>>  .P
>>  .B fixfiles onboot
>>  will setup the machine to relabel on the next reboot.
> 
> This file should not be in /, I think it would be better to put it in
> /etc/selinux
> 
> I have attached the current Fedora fixfiles.  Which has some similar
> fixes.

Your patch will be in policycoreutils-2.0.85-30.fc15
> I include two simple patch (-p1 were fixfiles and fixfiles.8 live) for
> adding a conf file that contain the directory to skip for relabel. I
> have followed your advice for the conf path.
> Developed with the version contained in
> policycoreutils-2.0.85-27.fc15.x86_64 (fc15 last update).

> Best Regards

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2jSgoACgkQrlYvE4MpobPxgQCcCT4QLEBKxDEPSp2RBCMAZLa5
+lkAoKtkx0ZF4z6omr657KoTYqmFwCpF
=C7Ee
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
