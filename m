Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6GBOKhi020996
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2012 07:24:20 -0400
Message-ID: <1342437857.12451.YahooMailClassic@web87705.mail.ir2.yahoo.com>
Date: Mon, 16 Jul 2012 12:24:17 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH 1/1] Android build project: Fix 'mkyaffs2image -f ...' selabel_lookup error
To: Robert Craig <robertpcraig@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <CADQgGG2J9mvgVdm7oOdsAPoCWnhcc0Hh1ry7yEsawXZOZAb=2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="1877209985-1201460284-1342437857=:12451"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--1877209985-1201460284-1342437857=:12451
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Your yaffs patch worked okay and is the best solution.

Thanks=20
Richard

--- On Sun, 15/7/12, Robert Craig <robertpcraig@gmail.com> wrote:

From: Robert Craig <robertpcraig@gmail.com>
Subject: Re: [PATCH 1/1] Android build project: Fix 'mkyaffs2image -f ...' =
selabel_lookup error
To: "Richard Haines" <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Date: Sunday, 15 July, 2012, 16:31

Thanks for bringing this to our attention. I think we should instead make a=
 change to the yaffs code. This will help with any other wrapper code.=A0Tr=
y the attached patch (worked for me).

On Sat, Jul 14, 2012 at 2:59 PM, Richard Haines <richard_c_haines@btinterne=
t.com> wrote:=0AWhen building SE-Android, mkyaffs2image fails with an selab=
el_lookup error
=0Aas the 'mountpoint' parameter does not match the file_context entry
=0A(requires a leading '/').
=0A
=0ASigned-off-by: Richard Haines <richard_c_haines@btinternet.com>
=0A---
=0A=A0tools/releasetools/build_image.py | =A0 =A06 +++---
=0A=A01 file changed, 3 insertions(+), 3 deletions(-)
=0A
=0Adiff --git a/tools/releasetools/build_image.py b/tools/releasetools/buil=
d_image.py
=0Aindex a615d1a..2b42d7d 100755
=0A--- a/tools/releasetools/build_image.py
=0A+++ b/tools/releasetools/build_image.py
=0A@@ -126,11 +126,11 @@ def main(argv):
=0A=A0 =A0image_filename =3D os.path.basename(out_file)
=0A=A0 =A0mount_point =3D ""
=0A=A0 =A0if image_filename =3D=3D "system.img":
=0A- =A0 =A0mount_point =3D "system"
=0A+ =A0 =A0mount_point =3D "/system"
=0A=A0 =A0elif image_filename =3D=3D "userdata.img":
=0A- =A0 =A0mount_point =3D "data"
=0A+ =A0 =A0mount_point =3D "/data"
=0A=A0 =A0elif image_filename =3D=3D "cache.img":
=0A- =A0 =A0mount_point =3D "cache"
=0A+ =A0 =A0mount_point =3D "/cache"
=0A=A0 =A0else:
=0A=A0 =A0 =A0print >> sys.stderr, "error: unknown image file name ", image=
_filename
=0A=A0 =A0 =A0exit(1)
=0A--
=0A1.7.10.4
=0A
=0A
=0A
=0A--
=0AThis message was distributed to subscribers of the selinux mailing list.
=0AIf you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov=
 with
=0Athe words "unsubscribe selinux" without quotes as the message.
=0A
=0A
--1877209985-1201460284-1342437857=:12451
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Your yaffs patch worked okay and is the best =
solution.<br><br>Thanks <br>Richard<br><br>--- On <b>Sun, 15/7/12, Robert C=
raig <i>&lt;robertpcraig@gmail.com&gt;</i></b> wrote:<br><blockquote style=
=3D"border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left=
: 5px;"><br>From: Robert Craig &lt;robertpcraig@gmail.com&gt;<br>Subject: R=
e: [PATCH 1/1] Android build project: Fix 'mkyaffs2image -f ...' selabel_lo=
okup error<br>To: "Richard Haines" &lt;richard_c_haines@btinternet.com&gt;<=
br>Cc: selinux@tycho.nsa.gov<br>Date: Sunday, 15 July, 2012, 16:31<br><br><=
div id=3D"yiv128809231">Thanks for bringing this to our attention. I think =
we should instead make a change to the yaffs code. This will help with any =
other wrapper code.&nbsp;<div>Try the attached patch (worked for me).<div><=
br></div><div><br><div>On Sat, Jul 14, 2012 at 2:59 PM, Richard Haines <spa=
n
 dir=3D"ltr">&lt;<a rel=3D"nofollow" ymailto=3D"mailto:richard_c_haines@bti=
nternet.com" target=3D"_blank" href=3D"/mc/compose?to=3Drichard_c_haines@bt=
internet.com">richard_c_haines@btinternet.com</a>&gt;</span> wrote:</div>=
=0A<div><div class=3D"yiv128809231gmail_quote"><blockquote class=3D"yiv1288=
09231gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex;">When building SE-Android, mkyaffs2image fails with an selab=
el_lookup error<br>=0Aas the 'mountpoint' parameter does not match the file=
_context entry<br>=0A(requires a leading '/').<br>=0A<br>=0ASigned-off-by: =
Richard Haines &lt;<a rel=3D"nofollow" ymailto=3D"mailto:richard_c_haines@b=
tinternet.com" target=3D"_blank" href=3D"/mc/compose?to=3Drichard_c_haines@=
btinternet.com">richard_c_haines@btinternet.com</a>&gt;<br>=0A---<br>=0A&nb=
sp;tools/releasetools/build_image.py | &nbsp; &nbsp;6 +++---<br>=0A&nbsp;1 =
file changed, 3 insertions(+), 3 deletions(-)<br>=0A<br>=0Adiff --git a/too=
ls/releasetools/build_image.py b/tools/releasetools/build_image.py<br>=0Ain=
dex a615d1a..2b42d7d 100755<br>=0A--- a/tools/releasetools/build_image.py<b=
r>=0A+++ b/tools/releasetools/build_image.py<br>=0A@@ -126,11 +126,11 @@ de=
f main(argv):<br>=0A&nbsp; &nbsp;image_filename =3D os.path.basename(out_fi=
le)<br>=0A&nbsp; &nbsp;mount_point =3D ""<br>=0A&nbsp; &nbsp;if image_filen=
ame =3D=3D "system.img":<br>=0A- &nbsp; &nbsp;mount_point =3D "system"<br>=
=0A+ &nbsp; &nbsp;mount_point =3D "/system"<br>=0A&nbsp; &nbsp;elif image_f=
ilename =3D=3D "userdata.img":<br>=0A- &nbsp; &nbsp;mount_point =3D "data"<=
br>=0A+ &nbsp; &nbsp;mount_point =3D "/data"<br>=0A&nbsp; &nbsp;elif image_=
filename =3D=3D "cache.img":<br>=0A- &nbsp; &nbsp;mount_point =3D "cache"<b=
r>=0A+ &nbsp; &nbsp;mount_point =3D "/cache"<br>=0A&nbsp; &nbsp;else:<br>=
=0A&nbsp; &nbsp; &nbsp;print &gt;&gt; sys.stderr, "error: unknown image fil=
e name ", image_filename<br>=0A&nbsp; &nbsp; &nbsp;exit(1)<br>=0A<span clas=
s=3D"yiv128809231HOEnZb"><font color=3D"#888888">--<br>=0A1.7.10.4<br>=0A<b=
r>=0A<br>=0A<br>=0A--<br>=0AThis message was distributed to subscribers of =
the selinux mailing list.<br>=0AIf you no longer wish to subscribe, send ma=
il to <a rel=3D"nofollow" ymailto=3D"mailto:majordomo@tycho.nsa.gov" target=
=3D"_blank" href=3D"/mc/compose?to=3Dmajordomo@tycho.nsa.gov">majordomo@tyc=
ho.nsa.gov</a> with<br>=0Athe words "unsubscribe selinux" without quotes as=
 the message.<br>=0A</font></span></blockquote></div><br></div></div></div>=
=0A</div></blockquote></td></tr></table>
--1877209985-1201460284-1342437857=:12451--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
