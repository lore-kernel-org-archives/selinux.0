Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p37FkBl2031886
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2011 11:46:11 -0400
Received: from mail-ww0-f49.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p37FkAw7027368
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2011 15:46:10 GMT
Received: by wwb39 with SMTP id 39so2743115wwb.30
        for <selinux@tycho.nsa.gov>; Thu, 07 Apr 2011 08:46:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1302190826-600638-1-git-send-email-andronicus.spiros@gmail.com>
References: <1302190826-600638-1-git-send-email-andronicus.spiros@gmail.com>
Date: Thu, 7 Apr 2011 17:46:09 +0200
Message-ID: <BANLkTim4aU+yo1-VRBG-AYJwatafU=-o=Q@mail.gmail.com>
Subject: Re: [PATCH] Permit fixfiles to skip configurable directory from relabelling
From: Elia Pinto <andronicus.spiros@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Elia Pinto <yersinia.spiros@gmail.com>, pinto.elia@gmail.com
Content-Type: multipart/alternative; boundary=0022158defe31379a404a05602c3
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0022158defe31379a404a05602c3
Content-Type: text/plain; charset=ISO-8859-1

Sorry there was a typo, i will repost shortly. Please ignore this patch

2011/4/7 Elia Pinto <andronicus.spiros@gmail.com>

> From: Elia Pinto <yersinia.spiros@gmail.com>
>
> This patch permit fixfiles to check /.autorelabel_excluded
> for a list of directories to exclude from relabelling.
>
> Inspired by this blog http://danwalsh.livejournal.com/38157.html.
>
> Signed-off-by: Elia Pinto <yersinia.spiros@gmail.com>
> ---
>  policycoreutils/scripts/fixfiles   |   45
> ++++++++++++++++++++++++++++++++---
>  policycoreutils/scripts/fixfiles.8 |    2 +
>  2 files changed, 43 insertions(+), 4 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles
> b/policycoreutils/scripts/fixfiles
> index ae519fc..2a39d74 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -28,6 +28,7 @@ FORCEFLAG=""
>  DIRS=""
>  RPMILES=""
>  LOGFILE=`tty`
> +FINDEXCLUDEDPATH=""
>  if [ $? != 0 ]; then
>     LOGFILE="/dev/null"
>  fi
> @@ -46,6 +47,24 @@ else
>     FC=/etc/security/selinux/file_contexts
>  fi
>
> +# Add an excluded path for the following
> +# find in the function restore, relabel
> +
> +if [ -e /.autorelabel_excluded ]
> +then
> +       while read _p
> +       do
> +          # skip blank line and comment
> +          # skip not absolute path
> +          # skip not directory
> +          [ -z "${_p}" ] && continue
> +          [[ "${_p}" =~ "^[[:blank:]]*#" ]] && continue
> +          [[ ! "${_p}" =~ "^/.*" ]] && continue
> +          [[ ! -d "${_p}" ]] && continue
> +         FINDEXCLUDEDPATH="${FINDEXCLUDEDPATH} -o -path \"${_p}\""
> +       done < /.autorelabel_excluded
> +fi
> +
>  #
>  # Log to either syslog or a LOGFILE
>  #
> @@ -88,7 +107,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
>                fi; \
>             done | \
>        while read pattern ; do sh -c "find $pattern \
> -                     ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o
> -fstype ext4dev  -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype
> btrfs \) -prune  -o \
> +                     ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o
> -fstype ext4dev  -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype
> btrfs ${FINDEXCLUDEDPATH}\) -prune  -o \
>                      \( -wholename /home -o -wholename /root -o -wholename
> /tmp -wholename /dev \) -prune -o -print0"; \
>                      done 2> /dev/null | \
>         ${RESTORECON} $* -0 -f -
> @@ -115,6 +134,7 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" |
> grep '^0 ' | cut -f2- -d ' '
>  # if called with -n will only check file context
>  #
>  restore () {
> +set -x
>  if [ ! -z "$PREFC" ]; then
>     diff_filecontext $*
>     exit $?
> @@ -127,8 +147,9 @@ if [ ! -z "$RPMFILES" ]; then
>  fi
>  if [ ! -z "$FILEPATH" ]; then
>     if [ -x /usr/bin/find ]; then
> +        loggit "skipping the directory ${FINDEXCLUDEDPATH//-o -path/} from
> relabelling"
>        /usr/bin/find "$FILEPATH" \
> -           ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype
> ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs \)
> -prune  -o -print0 | \
> +           ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype
> ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs
> ${FINDEXCLUDEDPATH}\) -prune  -o -print0 | \
>            ${RESTORECON} ${FORCEFLAG} $* -0 -f - 2>&1 >> $LOGFILE
>     else
>        ${RESTORECON} ${FORCEFLAG} -R $* $FILEPATH 2>&1 >> $LOGFILE
> @@ -137,8 +158,24 @@ if [ ! -z "$FILEPATH" ]; then
>  fi
>  [ -x /usr/sbin/genhomedircon ] && /usr/sbin/genhomedircon
>  LogReadOnly
> -${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1
> >> $LOGFILE
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
> +       _p="${_p%/}"
> +       _p1="${_p}(/.*)? -- <<none>>"
> +       echo "${_p1}" >> $TEMPFILE
> +        logit "skipping the directory ${_p} from relabelling"
> +done
> +
> +${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${TEMPFILE} ${FILESYSTEMSRW}
> 2>&1 >> $LOGFILE
> +rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-* $TEMPFILE
>  find /tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec
> chcon -t tmp_t {} \;
>  find /var/tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \)
> -exec chcon -t tmp_t {} \;
>  exit $?
> diff --git a/policycoreutils/scripts/fixfiles.8
> b/policycoreutils/scripts/fixfiles.8
> index dfe8aa9..865aab4 100644
> --- a/policycoreutils/scripts/fixfiles.8
> +++ b/policycoreutils/scripts/fixfiles.8
> @@ -29,6 +29,8 @@ new policy, or  just check whether the file contexts are
> all
>  as you expect.  By default it will relabel all mounted ext2, ext3, xfs and
>  jfs file systems as long as they do not have a security context mount
>  option.  You can use the -R flag to use rpmpackages as an alternative.
> +The file /.autorelabel_exclude can contain a list of directory path
> +that fixfiles don't relabel.
>  .P
>  .B fixfiles onboot
>  will setup the machine to relabel on the next reboot.
> --
> 1.7.2.1.44.g721e7
>
>

--0022158defe31379a404a05602c3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry there was a typo, i will repost shortly. Please ignore this patch<br>=
<br><div class=3D"gmail_quote">2011/4/7 Elia Pinto <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:andronicus.spiros@gmail.com">andronicus.spiros@gmail.com</a=
>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">From: Elia Pinto =
&lt;<a href=3D"mailto:yersinia.spiros@gmail.com">yersinia.spiros@gmail.com<=
/a>&gt;<br>

<br>
This patch permit fixfiles to check /.autorelabel_excluded<br>
for a list of directories to exclude from relabelling.<br>
<br>
Inspired by this blog <a href=3D"http://danwalsh.livejournal.com/38157.html=
" target=3D"_blank">http://danwalsh.livejournal.com/38157.html</a>.<br>
<br>
Signed-off-by: Elia Pinto &lt;<a href=3D"mailto:yersinia.spiros@gmail.com">=
yersinia.spiros@gmail.com</a>&gt;<br>
---<br>
=A0policycoreutils/scripts/fixfiles =A0 | =A0 45 ++++++++++++++++++++++++++=
++++++---<br>
=A0policycoreutils/scripts/fixfiles.8 | =A0 =A02 +<br>
=A02 files changed, 43 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fix=
files<br>
index ae519fc..2a39d74 100755<br>
--- a/policycoreutils/scripts/fixfiles<br>
+++ b/policycoreutils/scripts/fixfiles<br>
@@ -28,6 +28,7 @@ FORCEFLAG=3D&quot;&quot;<br>
=A0DIRS=3D&quot;&quot;<br>
=A0RPMILES=3D&quot;&quot;<br>
=A0LOGFILE=3D`tty`<br>
+FINDEXCLUDEDPATH=3D&quot;&quot;<br>
=A0if [ $? !=3D 0 ]; then<br>
 =A0 =A0 LOGFILE=3D&quot;/dev/null&quot;<br>
=A0fi<br>
@@ -46,6 +47,24 @@ else<br>
 =A0 =A0 FC=3D/etc/security/selinux/file_contexts<br>
=A0fi<br>
<br>
+# Add an excluded path for the following<br>
+# find in the function restore, relabel<br>
+<br>
+if [ -e /.autorelabel_excluded ]<br>
+then<br>
+ =A0 =A0 =A0 while read _p<br>
+ =A0 =A0 =A0 do<br>
+ =A0 =A0 =A0 =A0 =A0# skip blank line and comment<br>
+ =A0 =A0 =A0 =A0 =A0# skip not absolute path<br>
+ =A0 =A0 =A0 =A0 =A0# skip not directory<br>
+ =A0 =A0 =A0 =A0 =A0[ -z &quot;${_p}&quot; ] &amp;&amp; continue<br>
+ =A0 =A0 =A0 =A0 =A0[[ &quot;${_p}&quot; =3D~ &quot;^[[:blank:]]*#&quot; ]=
] &amp;&amp; continue<br>
+ =A0 =A0 =A0 =A0 =A0[[ ! &quot;${_p}&quot; =3D~ &quot;^/.*&quot; ]] &amp;&=
amp; continue<br>
+ =A0 =A0 =A0 =A0 =A0[[ ! -d &quot;${_p}&quot; ]] &amp;&amp; continue<br>
+ =A0 =A0 =A0 =A0 FINDEXCLUDEDPATH=3D&quot;${FINDEXCLUDEDPATH} -o -path \&q=
uot;${_p}\&quot;&quot;<br>
+ =A0 =A0 =A0 done &lt; /.autorelabel_excluded<br>
+fi<br>
+<br>
=A0#<br>
=A0# Log to either syslog or a LOGFILE<br>
=A0#<br>
@@ -88,7 +107,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fi; \<br>
 =A0 =A0 =A0 =A0 =A0 =A0 done | \<br>
 =A0 =A0 =A0 =A0while read pattern ; do sh -c &quot;find $pattern \<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ! \( -fstype ext2 -o -fstype ext3=
 -o -fstype ext4 -o -fstype ext4dev =A0-o -fstype gfs2 -o -fstype jfs -o -f=
stype xfs -o -fstype btrfs \) -prune =A0-o \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ! \( -fstype ext2 -o -fstype ext3=
 -o -fstype ext4 -o -fstype ext4dev =A0-o -fstype gfs2 -o -fstype jfs -o -f=
stype xfs -o -fstype btrfs ${FINDEXCLUDEDPATH}\) -prune =A0-o \<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\( -wholename /home -o -wholena=
me /root -o -wholename /tmp -wholename /dev \) -prune -o -print0&quot;; \<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0done 2&gt; /dev/null | \<br>
 =A0 =A0 =A0 =A0 ${RESTORECON} $* -0 -f -<br>
@@ -115,6 +134,7 @@ rpm -q --qf &#39;[%{FILESTATES} %{FILENAMES}\n]&#39; &q=
uot;$1&quot; | grep &#39;^0 &#39; | cut -f2- -d &#39; &#39;<br>
=A0# if called with -n will only check file context<br>
=A0#<br>
=A0restore () {<br>
+set -x<br>
=A0if [ ! -z &quot;$PREFC&quot; ]; then<br>
 =A0 =A0 diff_filecontext $*<br>
 =A0 =A0 exit $?<br>
@@ -127,8 +147,9 @@ if [ ! -z &quot;$RPMFILES&quot; ]; then<br>
=A0fi<br>
=A0if [ ! -z &quot;$FILEPATH&quot; ]; then<br>
 =A0 =A0 if [ -x /usr/bin/find ]; then<br>
+ =A0 =A0 =A0 =A0loggit &quot;skipping the directory ${FINDEXCLUDEDPATH//-o=
 -path/} from relabelling&quot;<br>
 =A0 =A0 =A0 =A0/usr/bin/find &quot;$FILEPATH&quot; \<br>
- =A0 =A0 =A0 =A0 =A0 ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o =
-fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype bt=
rfs \) -prune =A0-o -print0 | \<br>
+ =A0 =A0 =A0 =A0 =A0 ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o =
-fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype bt=
rfs ${FINDEXCLUDEDPATH}\) -prune =A0-o -print0 | \<br>
 =A0 =A0 =A0 =A0 =A0 =A0${RESTORECON} ${FORCEFLAG} $* -0 -f - 2&gt;&amp;1 &=
gt;&gt; $LOGFILE<br>
 =A0 =A0 else<br>
 =A0 =A0 =A0 =A0${RESTORECON} ${FORCEFLAG} -R $* $FILEPATH 2&gt;&amp;1 &gt;=
&gt; $LOGFILE<br>
@@ -137,8 +158,24 @@ if [ ! -z &quot;$FILEPATH&quot; ]; then<br>
=A0fi<br>
=A0[ -x /usr/sbin/genhomedircon ] &amp;&amp; /usr/sbin/genhomedircon<br>
=A0LogReadOnly<br>
-${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2&gt;&=
amp;1 &gt;&gt; $LOGFILE<br>
-rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*<br>
+#<br>
+#<br>
+# &quot;&lt;&lt;none&gt;&gt;&quot; &#39;/md/distro?(/.*)?&#39;<br>
+TEMPFILE=3D`mktemp ${FC}.XXXXXXXXXX`<br>
+test -z &quot;$TEMPFILE&quot; &amp;&amp; exit<br>
+cp -p ${FC} ${TEMPFILE}<br>
+FINDEXCLUDEDPATH=3D${FINDEXCLUDEDPATH//-o -path/}<br>
+FINDEXCLUDEDPATH=3D${FINDEXCLUDEDPATH//\&quot;/}<br>
+for _p in $FINDEXCLUDEDPATH<br>
+do<br>
+ =A0 =A0 =A0 _p=3D&quot;${_p%/}&quot;<br>
+ =A0 =A0 =A0 _p1=3D&quot;${_p}(/.*)? -- &lt;&lt;none&gt;&gt;&quot;<br>
+ =A0 =A0 =A0 echo &quot;${_p1}&quot; &gt;&gt; $TEMPFILE<br>
+ =A0 =A0 =A0 =A0logit &quot;skipping the directory ${_p} from relabelling&=
quot;<br>
+done<br>
+<br>
+${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${TEMPFILE} ${FILESYSTEMSRW} =
2&gt;&amp;1 &gt;&gt; $LOGFILE<br>
+rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-* $TEMPFILE<br>
=A0find /tmp \( -context &quot;*:file_t*&quot; -o -context &quot;*:unlabele=
d_t*&quot; \) -exec chcon -t tmp_t {} \;<br>
=A0find /var/tmp \( -context &quot;*:file_t*&quot; -o -context &quot;*:unla=
beled_t*&quot; \) -exec chcon -t tmp_t {} \;<br>
=A0exit $?<br>
diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/f=
ixfiles.8<br>
index dfe8aa9..865aab4 100644<br>
--- a/policycoreutils/scripts/fixfiles.8<br>
+++ b/policycoreutils/scripts/fixfiles.8<br>
@@ -29,6 +29,8 @@ new policy, or =A0just check whether the file contexts ar=
e all<br>
=A0as you expect. =A0By default it will relabel all mounted ext2, ext3, xfs=
 and<br>
=A0jfs file systems as long as they do not have a security context mount<br=
>
=A0option. =A0You can use the -R flag to use rpmpackages as an alternative.=
<br>
+The file /.autorelabel_exclude can contain a list of directory path<br>
+that fixfiles don&#39;t relabel.<br>
=A0.P<br>
=A0.B fixfiles onboot<br>
=A0will setup the machine to relabel on the next reboot.<br>
<font color=3D"#888888">--<br>
1.7.2.1.44.g721e7<br>
<br>
</font></blockquote></div><br>

--0022158defe31379a404a05602c3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
