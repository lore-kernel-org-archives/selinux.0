Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p38HE3eL014472
	for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2011 13:14:03 -0400
Received: from mail-vx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p38HE2Ft016563
	for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2011 17:14:02 GMT
Received: by vxb39 with SMTP id 39so3364398vxb.12
        for <selinux@tycho.nsa.gov>; Fri, 08 Apr 2011 10:14:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4D9DDE14.8070100@redhat.com>
References: <1302191243-604822-1-git-send-email-andronicus.spiros@gmail.com>
	<4D9DDE14.8070100@redhat.com>
Date: Fri, 8 Apr 2011 19:14:00 +0200
Message-ID: <BANLkTimDnENx5eJ6ueRMFGT_WwLO50K_dA@mail.gmail.com>
Subject: Re: [PATCH] Permit fixfiles to skip configurable directory from relabelling
From: Elia Pinto <andronicus.spiros@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=bcaec53f97851ef0a904a06b5a9b
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec53f97851ef0a904a06b5a9b
Content-Type: multipart/alternative; boundary=bcaec53f97851ef09704a06b5a99

--bcaec53f97851ef09704a06b5a99
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Apr 7, 2011 at 5:53 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 04/07/2011 11:47 AM, Elia Pinto wrote:
> > From: Elia Pinto <yersinia.spiros@gmail.com>
> >
> > This patch permit fixfiles to check /.autorelabel_excluded
> > for a list of directories to exclude from relabelling.
> >
> > Inspired by this blog http://danwalsh.livejournal.com/38157.html.
> >
> > Signed-off-by: Elia Pinto <yersinia.spiros@gmail.com>
> > ---
> >  policycoreutils/scripts/fixfiles   |   44
> ++++++++++++++++++++++++++++++++---
> >  policycoreutils/scripts/fixfiles.8 |    2 +
> >  2 files changed, 42 insertions(+), 4 deletions(-)
> >
> > diff --git a/policycoreutils/scripts/fixfiles
> b/policycoreutils/scripts/fixfiles
> > index ae519fc..ba4d4b1 100755
> > --- a/policycoreutils/scripts/fixfiles
> > +++ b/policycoreutils/scripts/fixfiles
> > @@ -28,6 +28,7 @@ FORCEFLAG=""
> >  DIRS=""
> >  RPMILES=""
> >  LOGFILE=`tty`
> > +FINDEXCLUDEDPATH=""
> >  if [ $? != 0 ]; then
> >      LOGFILE="/dev/null"
> >  fi
> > @@ -46,6 +47,24 @@ else
> >      FC=/etc/security/selinux/file_contexts
> >  fi
> >
> > +# Add an excluded path for the following
> > +# find in the function restore, relabel
> > +
> > +if [ -e /.autorelabel_excluded ]
> > +then
> > +     while read _p
> > +     do
> > +          # skip blank line and comment
> > +          # skip not absolute path
> > +          # skip not directory
> > +          [ -z "${_p}" ] && continue
> > +          [[ "${_p}" =~ "^[[:blank:]]*#" ]] && continue
> > +          [[ ! "${_p}" =~ "^/.*" ]] && continue
> > +          [[ ! -d "${_p}" ]] && continue
> > +       FINDEXCLUDEDPATH="${FINDEXCLUDEDPATH} -o -path \"${_p}\""
> > +     done < /.autorelabel_excluded
> > +fi
> > +
> >  #
> >  # Log to either syslog or a LOGFILE
> >  #
> > @@ -88,7 +107,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
> >                 fi; \
> >              done | \
> >       while read pattern ; do sh -c "find $pattern \
> > -                   ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o
> -fstype ext4dev  -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype
> btrfs \) -prune  -o \
> > +                   ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o
> -fstype ext4dev  -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype
> btrfs ${FINDEXCLUDEDPATH}\) -prune  -o \
> >                     \( -wholename /home -o -wholename /root -o -wholename
> /tmp -wholename /dev \) -prune -o -print0"; \
> >                     done 2> /dev/null | \
> >        ${RESTORECON} $* -0 -f -
> > @@ -127,8 +146,9 @@ if [ ! -z "$RPMFILES" ]; then
> >  fi
> >  if [ ! -z "$FILEPATH" ]; then
> >      if [ -x /usr/bin/find ]; then
> > +        loggit "skipping the directory ${FINDEXCLUDEDPATH//-o -path/}
> from relabelling"
> >       /usr/bin/find "$FILEPATH" \
> > -         ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype
> ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs \)
> -prune  -o -print0 | \
> > +         ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o -fstype
> ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype btrfs
> ${FINDEXCLUDEDPATH}\) -prune  -o -print0 | \
> >           ${RESTORECON} ${FORCEFLAG} $* -0 -f - 2>&1 >> $LOGFILE
> >      else
> >       ${RESTORECON} ${FORCEFLAG} -R $* $FILEPATH 2>&1 >> $LOGFILE
> > @@ -137,8 +157,24 @@ if [ ! -z "$FILEPATH" ]; then
> >  fi
> >  [ -x /usr/sbin/genhomedircon ] && /usr/sbin/genhomedircon
> >  LogReadOnly
> > -${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1
> >> $LOGFILE
> > -rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*
> > +#
> > +#
> > +# "<<none>>" '/md/distro?(/.*)?'
> > +TEMPFILE=`mktemp ${FC}.XXXXXXXXXX`
> > +test -z "$TEMPFILE" && exit
> > +cp -p ${FC} ${TEMPFILE}
> > +FINDEXCLUDEDPATH=${FINDEXCLUDEDPATH//-o -path/}
> > +FINDEXCLUDEDPATH=${FINDEXCLUDEDPATH//\"/}
> > +for _p in $FINDEXCLUDEDPATH
> > +do
> > +     _p="${_p%/}"
> > +     _p1="${_p}(/.*)? -- <<none>>"
> > +     echo "${_p1}" >> $TEMPFILE
> > +        logit "skipping the directory ${_p} from relabelling"
> > +done
> > +
> > +${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${TEMPFILE}
> ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
> > +rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-* $TEMPFILE
> >  find /tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \) -exec
> chcon -t tmp_t {} \;
> >  find /var/tmp \( -context "*:file_t*" -o -context "*:unlabeled_t*" \)
> -exec chcon -t tmp_t {} \;
> >  exit $?
> > diff --git a/policycoreutils/scripts/fixfiles.8
> b/policycoreutils/scripts/fixfiles.8
> > index dfe8aa9..865aab4 100644
> > --- a/policycoreutils/scripts/fixfiles.8
> > +++ b/policycoreutils/scripts/fixfiles.8
> > @@ -29,6 +29,8 @@ new policy, or  just check whether the file contexts
> are all
> >  as you expect.  By default it will relabel all mounted ext2, ext3, xfs
> and
> >  jfs file systems as long as they do not have a security context mount
> >  option.  You can use the -R flag to use rpmpackages as an alternative.
> > +The file /.autorelabel_exclude can contain a list of directory path
> > +that fixfiles don't relabel.
> >  .P
> >  .B fixfiles onboot
> >  will setup the machine to relabel on the next reboot.
>
> This file should not be in /, I think it would be better to put it in
> /etc/selinux
>
> I have attached the current Fedora fixfiles.  Which has some similar fixes.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk2d3hQACgkQrlYvE4MpobNgYACg4hHDc5kgHLVPdfjb2KmytGNY
> rggAn0INl+1Mf5odXoUq5rJQR6FT/RzD
> =KAVX
> -----END PGP SIGNATURE-----
>
I include two simple patch (-p1 were fixfiles and fixfiles.8 live) for
adding a conf file that contain the directory to skip for relabel. I have
followed your advice for the conf path.
Developed with the version contained in
policycoreutils-2.0.85-27.fc15.x86_64 (fc15 last update).

Best Regards

--bcaec53f97851ef09704a06b5a99
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Thu, Apr 7, 2011 at 5:53 PM, Daniel J Walsh <=
span dir=3D"ltr">&lt;<a href=3D"mailto:dwalsh@redhat.com">dwalsh@redhat.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-lef=
t: 1ex;">
-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<div><div></div><div class=3D"h5"><br>
On 04/07/2011 11:47 AM, Elia Pinto wrote:<br>
&gt; From: Elia Pinto &lt;<a href=3D"mailto:yersinia.spiros@gmail.com">yers=
inia.spiros@gmail.com</a>&gt;<br>
&gt;<br>
&gt; This patch permit fixfiles to check /.autorelabel_excluded<br>
&gt; for a list of directories to exclude from relabelling.<br>
&gt;<br>
&gt; Inspired by this blog <a href=3D"http://danwalsh.livejournal.com/38157=
.html" target=3D"_blank">http://danwalsh.livejournal.com/38157.html</a>.<br=
>
&gt;<br>
&gt; Signed-off-by: Elia Pinto &lt;<a href=3D"mailto:yersinia.spiros@gmail.=
com">yersinia.spiros@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0policycoreutils/scripts/fixfiles =A0 | =A0 44 +++++++++++++++++++++=
+++++++++++---<br>
&gt; =A0policycoreutils/scripts/fixfiles.8 | =A0 =A02 +<br>
&gt; =A02 files changed, 42 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/script=
s/fixfiles<br>
&gt; index ae519fc..ba4d4b1 100755<br>
&gt; --- a/policycoreutils/scripts/fixfiles<br>
&gt; +++ b/policycoreutils/scripts/fixfiles<br>
&gt; @@ -28,6 +28,7 @@ FORCEFLAG=3D&quot;&quot;<br>
&gt; =A0DIRS=3D&quot;&quot;<br>
&gt; =A0RPMILES=3D&quot;&quot;<br>
&gt; =A0LOGFILE=3D`tty`<br>
&gt; +FINDEXCLUDEDPATH=3D&quot;&quot;<br>
&gt; =A0if [ $? !=3D 0 ]; then<br>
&gt; =A0 =A0 =A0LOGFILE=3D&quot;/dev/null&quot;<br>
&gt; =A0fi<br>
&gt; @@ -46,6 +47,24 @@ else<br>
&gt; =A0 =A0 =A0FC=3D/etc/security/selinux/file_contexts<br>
&gt; =A0fi<br>
&gt;<br>
&gt; +# Add an excluded path for the following<br>
&gt; +# find in the function restore, relabel<br>
&gt; +<br>
&gt; +if [ -e /.autorelabel_excluded ]<br>
&gt; +then<br>
&gt; + =A0 =A0 while read _p<br>
&gt; + =A0 =A0 do<br>
&gt; + =A0 =A0 =A0 =A0 =A0# skip blank line and comment<br>
&gt; + =A0 =A0 =A0 =A0 =A0# skip not absolute path<br>
&gt; + =A0 =A0 =A0 =A0 =A0# skip not directory<br>
&gt; + =A0 =A0 =A0 =A0 =A0[ -z &quot;${_p}&quot; ] &amp;&amp; continue<br>
&gt; + =A0 =A0 =A0 =A0 =A0[[ &quot;${_p}&quot; =3D~ &quot;^[[:blank:]]*#&qu=
ot; ]] &amp;&amp; continue<br>
&gt; + =A0 =A0 =A0 =A0 =A0[[ ! &quot;${_p}&quot; =3D~ &quot;^/.*&quot; ]] &=
amp;&amp; continue<br>
&gt; + =A0 =A0 =A0 =A0 =A0[[ ! -d &quot;${_p}&quot; ]] &amp;&amp; continue<=
br>
&gt; + =A0 =A0 =A0 FINDEXCLUDEDPATH=3D&quot;${FINDEXCLUDEDPATH} -o -path \&=
quot;${_p}\&quot;&quot;<br>
&gt; + =A0 =A0 done &lt; /.autorelabel_excluded<br>
&gt; +fi<br>
&gt; +<br>
&gt; =A0#<br>
&gt; =A0# Log to either syslog or a LOGFILE<br>
&gt; =A0#<br>
&gt; @@ -88,7 +107,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi; \<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0done | \<br>
&gt; =A0 =A0 =A0 while read pattern ; do sh -c &quot;find $pattern \<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ! \( -fstype ext2 -o -fstype ext=
3 -o -fstype ext4 -o -fstype ext4dev =A0-o -fstype gfs2 -o -fstype jfs -o -=
fstype xfs -o -fstype btrfs \) -prune =A0-o \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ! \( -fstype ext2 -o -fstype ext=
3 -o -fstype ext4 -o -fstype ext4dev =A0-o -fstype gfs2 -o -fstype jfs -o -=
fstype xfs -o -fstype btrfs ${FINDEXCLUDEDPATH}\) -prune =A0-o \<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \( -wholename /home -o -wholen=
ame /root -o -wholename /tmp -wholename /dev \) -prune -o -print0&quot;; \<=
br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 done 2&gt; /dev/null | \<br>
&gt; =A0 =A0 =A0 =A0${RESTORECON} $* -0 -f -<br>
&gt; @@ -127,8 +146,9 @@ if [ ! -z &quot;$RPMFILES&quot; ]; then<br>
&gt; =A0fi<br>
&gt; =A0if [ ! -z &quot;$FILEPATH&quot; ]; then<br>
&gt; =A0 =A0 =A0if [ -x /usr/bin/find ]; then<br>
&gt; + =A0 =A0 =A0 =A0loggit &quot;skipping the directory ${FINDEXCLUDEDPAT=
H//-o -path/} from relabelling&quot;<br>
&gt; =A0 =A0 =A0 /usr/bin/find &quot;$FILEPATH&quot; \<br>
&gt; - =A0 =A0 =A0 =A0 ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o=
 -fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype b=
trfs \) -prune =A0-o -print0 | \<br>
&gt; + =A0 =A0 =A0 =A0 ! \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 -o=
 -fstype ext4dev -o -fstype gfs2 -o -fstype jfs -o -fstype xfs -o -fstype b=
trfs ${FINDEXCLUDEDPATH}\) -prune =A0-o -print0 | \<br>
&gt; =A0 =A0 =A0 =A0 =A0 ${RESTORECON} ${FORCEFLAG} $* -0 -f - 2&gt;&amp;1 =
&gt;&gt; $LOGFILE<br>
&gt; =A0 =A0 =A0else<br>
&gt; =A0 =A0 =A0 ${RESTORECON} ${FORCEFLAG} -R $* $FILEPATH 2&gt;&amp;1 &gt=
;&gt; $LOGFILE<br>
&gt; @@ -137,8 +157,24 @@ if [ ! -z &quot;$FILEPATH&quot; ]; then<br>
&gt; =A0fi<br>
&gt; =A0[ -x /usr/sbin/genhomedircon ] &amp;&amp; /usr/sbin/genhomedircon<b=
r>
&gt; =A0LogReadOnly<br>
&gt; -${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2=
&gt;&amp;1 &gt;&gt; $LOGFILE<br>
&gt; -rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*<br>
&gt; +#<br>
&gt; +#<br>
&gt; +# &quot;&lt;&lt;none&gt;&gt;&quot; &#39;/md/distro?(/.*)?&#39;<br>
&gt; +TEMPFILE=3D`mktemp ${FC}.XXXXXXXXXX`<br>
&gt; +test -z &quot;$TEMPFILE&quot; &amp;&amp; exit<br>
&gt; +cp -p ${FC} ${TEMPFILE}<br>
&gt; +FINDEXCLUDEDPATH=3D${FINDEXCLUDEDPATH//-o -path/}<br>
&gt; +FINDEXCLUDEDPATH=3D${FINDEXCLUDEDPATH//\&quot;/}<br>
&gt; +for _p in $FINDEXCLUDEDPATH<br>
&gt; +do<br>
&gt; + =A0 =A0 _p=3D&quot;${_p%/}&quot;<br>
&gt; + =A0 =A0 _p1=3D&quot;${_p}(/.*)? -- &lt;&lt;none&gt;&gt;&quot;<br>
&gt; + =A0 =A0 echo &quot;${_p1}&quot; &gt;&gt; $TEMPFILE<br>
&gt; + =A0 =A0 =A0 =A0logit &quot;skipping the directory ${_p} from relabel=
ling&quot;<br>
&gt; +done<br>
&gt; +<br>
&gt; +${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${TEMPFILE} ${FILESYSTEM=
SRW} 2&gt;&amp;1 &gt;&gt; $LOGFILE<br>
&gt; +rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-* $TEMPFILE<br>
&gt; =A0find /tmp \( -context &quot;*:file_t*&quot; -o -context &quot;*:unl=
abeled_t*&quot; \) -exec chcon -t tmp_t {} \;<br>
&gt; =A0find /var/tmp \( -context &quot;*:file_t*&quot; -o -context &quot;*=
:unlabeled_t*&quot; \) -exec chcon -t tmp_t {} \;<br>
&gt; =A0exit $?<br>
&gt; diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scri=
pts/fixfiles.8<br>
&gt; index dfe8aa9..865aab4 100644<br>
&gt; --- a/policycoreutils/scripts/fixfiles.8<br>
&gt; +++ b/policycoreutils/scripts/fixfiles.8<br>
&gt; @@ -29,6 +29,8 @@ new policy, or =A0just check whether the file contex=
ts are all<br>
&gt; =A0as you expect. =A0By default it will relabel all mounted ext2, ext3=
, xfs and<br>
&gt; =A0jfs file systems as long as they do not have a security context mou=
nt<br>
&gt; =A0option. =A0You can use the -R flag to use rpmpackages as an alterna=
tive.<br>
&gt; +The file /.autorelabel_exclude can contain a list of directory path<b=
r>
&gt; +that fixfiles don&#39;t relabel.<br>
&gt; =A0.P<br>
&gt; =A0.B fixfiles onboot<br>
&gt; =A0will setup the machine to relabel on the next reboot.<br>
<br>
</div></div>This file should not be in /, I think it would be better to put=
 it in<br>
/etc/selinux<br>
<br>
I have attached the current Fedora fixfiles. =A0Which has some similar fixe=
s.<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.11 (GNU/Linux)<br>
Comment: Using GnuPG with Fedora - <a href=3D"http://enigmail.mozdev.org/" =
target=3D"_blank">http://enigmail.mozdev.org/</a><br>
<br>
iEYEARECAAYFAk2d3hQACgkQrlYvE4MpobNgYACg4hHDc5kgHLVPdfjb2KmytGNY<br>
rggAn0INl+1Mf5odXoUq5rJQR6FT/RzD<br>
=3DKAVX<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div>I include two simple patch (-p1 were fixfiles and fixfil=
es.8 live) for adding a conf file that contain the directory to skip for re=
label. I have followed your advice for the conf path. <br>Developed with th=
e version contained in policycoreutils-2.0.85-27.fc15.x86_64 (fc15 last upd=
ate). <br>
<br>Best Regards<br>

--bcaec53f97851ef09704a06b5a99--

--bcaec53f97851ef0a904a06b5a9b
Content-Type: application/octet-stream; name="fixfiles.patch"
Content-Disposition: attachment; filename="fixfiles.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gm9dh9752

ZGlmZiAtLWdpdCBhL2ZpeGZpbGVzIGIvZml4ZmlsZXMKaW5kZXggMDg5MDgxMS4uN2QyMWVhMyAx
MDA3NTUKLS0tIGEvZml4ZmlsZXMKKysrIGIvZml4ZmlsZXMKQEAgLTMwLDEyICszMCwzMSBAQCBm
b3IgaSBpbiAkRlM7IGRvCiAgICAgZ3JlcCAtLXNpbGVudCAiJGkgIi4qc2VjbGFiZWwgL3Byb2Mv
c2VsZi9tb3VudHMgJiYgZWNobyAkaQogZG9uZQogfQotCitleGNsdWRlX2RpcnNfZnJvbV9yZWxh
YmVsbGluZygpIHsKKyAgICBleGNsdWRlX2Zyb21fcmVsYWJlbGxpbmc9IAorICAgIGlmIFsgLWUg
L2V0Yy9zZWxpbnV4L2ZpeGZpbGVzX2V4Y2x1ZGVfZGlycyBdCisgICAgdGhlbgorICAgICAgICB3
aGlsZSByZWFkIGkKKyAgICAgICAgZG8KKyAgICAgICAgICAjIHNraXAgYmxhbmsgbGluZSBhbmQg
Y29tbWVudAorICAgICAgICAgICMgc2tpcCBub3QgYWJzb2x1dGUgcGF0aAorICAgICAgICAgICMg
c2tpcCBub3QgZGlyZWN0b3J5CisgICAgICAgICAgWyAteiAiJHtpfSIgXSAmJiBjb250aW51ZQor
ICAgICAgICAgIFtbICIke2l9IiA9fiAiXltbOmJsYW5rOl1dKiMiIF1dICYmIGNvbnRpbnVlCisg
ICAgICAgICAgW1sgISAiJHtpfSIgPX4gXi8uKiBdXSAmJiBjb250aW51ZQorICAgICAgICAgIFtb
ICEgLWQgIiR7aX0iIF1dICYmIGNvbnRpbnVlCisgICAgICAgICAgZXhjbHVkZV9mcm9tX3JlbGFi
ZWxsaW5nPSIkZXhjbHVkZV9mcm9tX3JlbGFiZWxsaW5nIC1lICRpIgorICAgICAgICAgIGxvZ2l0
ICJza2lwcGluZyB0aGUgZGlyZWN0b3J5ICRpIGZyb20gcmVsYWJlbGxpbmciCisgICAgICAgIGRv
bmUgPCAvZXRjL3NlbGludXgvZml4ZmlsZXNfZXhjbHVkZV9kaXJzCisgICAgZmkKKyAgICBlY2hv
ICIkZXhjbHVkZV9mcm9tX3JlbGFiZWxsaW5nIgorfQogZXhjbHVkZV9kaXJzKCkgewogICAgIGV4
Y2x1ZGU9IAogICAgIGZvciBpIGluIC92YXIvbGliL0JhY2t1cFBDIC9ob21lIC90bXAgL2Rldjsg
ZG8gCiAgICAgICAgIFsgLWUgJGkgXSAgJiYgZXhjbHVkZT0iJGV4Y2x1ZGUgLWUgJGkiOyAKICAg
ICBkb25lIAorICAgIGV4Y2x1ZGU9IiRleGNsdWRlIGBleGNsdWRlX2RpcnNfZnJvbV9yZWxhYmVs
bGluZ2AiCiAgICAgZWNobyAiJGV4Y2x1ZGUiCiB9CiAKQEAgLTEzNCw4ICsxNTMsMjUgQEAgaWYg
WyAhIC16ICIkRklMRVBBVEgiIF07IHRoZW4KICAgICByZXR1cm4KIGZpCiBbIC14IC91c3Ivc2Jp
bi9nZW5ob21lZGlyY29uIF0gJiYgL3Vzci9zYmluL2dlbmhvbWVkaXJjb24KKyMKK2V4Y2x1ZGVf
ZGlycz0iYGV4Y2x1ZGVfZGlyc19mcm9tX3JlbGFiZWxsaW5nYCIKK2lmIFsgLW4gIiR7ZXhjbHVk
ZV9kaXJzfSIgXSAKK3RoZW4gCisJVEVNUEZDRklMRT1gbWt0ZW1wICR7RkN9LlhYWFhYWFhYWFhg
CisJdGVzdCAteiAiJFRFTVBGQ0ZJTEUiICYmIGV4aXQKKwkvYmluL2NwIC1wICR7RkN9ICR7VEVN
UEZDRklMRX0gJj4vZGV2L251bGwgfHwgZXhpdCAKKwlleGNsdWRlX2RpcnM9JHtleGNsdWRlX2Rp
cnMvLy1lL30KKwlmb3IgcCBpbiAke2V4Y2x1ZGVfZGlyc30KKwlkbworICAgICAgIAkgcD0iJHtw
JS99IgorICAgICAgIAkgcDE9IiR7cH0oLy4qKT8gLS0gPDxub25lPj4iCisgICAgICAgCSBlY2hv
ICIke3AxfSIgPj4gJFRFTVBGQ0ZJTEUKKyAgICAgICAJIGxvZ2l0ICJza2lwcGluZyB0aGUgZGly
ZWN0b3J5ICR7cH0gZnJvbSByZWxhYmVsbGluZyIKKwlkb25lCitGQz0kVEVNUEZDRklMRQorZmkK
ICR7U0VURklMRVN9IC1xICR7U1lTTE9HRkxBR30gJHtGT1JDRUZMQUd9ICQqICR7RkN9ICR7RklM
RVNZU1RFTVN9IDI+JjEgfCBjYXQgPj4gJExPR0ZJTEUKLXJtIC1yZiAvdG1wL2djb25mZC0qIC90
bXAvcHVsc2UtKiAvdG1wL29yYml0LSoKK3JtIC1yZiAvdG1wL2djb25mZC0qIC90bXAvcHVsc2Ut
KiAvdG1wL29yYml0LSogJFRFTVBGQ0ZJTEUKIGZpbmQgL3RtcCBcKCAtY29udGV4dCAiKjpmaWxl
X3QqIiAtbyAtY29udGV4dCAiKjp1bmxhYmVsZWRfdCoiIFwpIC1leGVjIGNoY29uIC10IHRtcF90
IHt9IFw7CiBmaW5kIC92YXIvdG1wIFwoIC1jb250ZXh0ICIqOmZpbGVfdCoiIC1vIC1jb250ZXh0
ICIqOnVubGFiZWxlZF90KiIgXCkgLWV4ZWMgY2hjb24gLXQgdG1wX3Qge30gXDsKIGV4aXQgJD8K
--bcaec53f97851ef0a904a06b5a9b
Content-Type: application/octet-stream; name="fixfiles.8.patch"
Content-Disposition: attachment; filename="fixfiles.8.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gm9di0nk3

ZGlmZiAtLWdpdCBhL2ZpeGZpbGVzLjggYi9maXhmaWxlcy44CmluZGV4IGRmZThhYTkuLjBiNGNi
YWEgMTAwNjQ0Ci0tLSBhL2ZpeGZpbGVzLjgKKysrIGIvZml4ZmlsZXMuOApAQCAtMjksNiArMjks
OCBAQCBuZXcgcG9saWN5LCBvciAganVzdCBjaGVjayB3aGV0aGVyIHRoZSBmaWxlIGNvbnRleHRz
IGFyZSBhbGwKIGFzIHlvdSBleHBlY3QuICBCeSBkZWZhdWx0IGl0IHdpbGwgcmVsYWJlbCBhbGwg
bW91bnRlZCBleHQyLCBleHQzLCB4ZnMgYW5kIAogamZzIGZpbGUgc3lzdGVtcyBhcyBsb25nIGFz
IHRoZXkgZG8gbm90IGhhdmUgYSBzZWN1cml0eSBjb250ZXh0IG1vdW50IAogb3B0aW9uLiAgWW91
IGNhbiB1c2UgdGhlIC1SIGZsYWcgdG8gdXNlIHJwbXBhY2thZ2VzIGFzIGFuIGFsdGVybmF0aXZl
LgorVGhlIGZpbGUgL2V0Yy9zZWxpbnV4L2ZpeGZpbGVzX2V4Y2x1ZGVfZGlycyBjYW4gY29udGFp
biBhIGxpc3Qgb2YgZGlyZWN0b3JpZXMKK2V4Y2x1ZGVkIGZyb20gcmVsYWJlbGxpbmcuCiAuUAog
LkIgZml4ZmlsZXMgb25ib290IAogd2lsbCBzZXR1cCB0aGUgbWFjaGluZSB0byByZWxhYmVsIG9u
IHRoZSBuZXh0IHJlYm9vdC4K
--bcaec53f97851ef0a904a06b5a9b--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
