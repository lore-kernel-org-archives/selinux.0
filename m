MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7E5AB.8844330C"
Subject: semanage and semodule failures...
Date: Thu, 23 Aug 2007 13:32:08 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D03EA1C75@de01exm68.ds.mot.com>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, "Steve Grubb" <sgrubb@redhat.com>,
        "Karl MacMillan" <kmacmill@redhat.com>,
        "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7E5AB.8844330C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

I am running SELinux in STRICT mode on an embedded Linux card (running
Linux 2.6.14).

Initially had the following versions of core SELinux libs :

 [ libsemanage-1.6.17-1 , checkpolicy-1.33.1-2 , libsepol-1.15.3-1 ,
libselinux-1.33.4-2 , policycoreutils-1.34.1-4 ]

With the above versions, "semanage" and "semodule" would work just fine
! However, the problem was that everytime any minor policy change was
made using semanage or semodule, a
/etc/selinux/strict/modules/previous/   directory would get created with
redundant policy info, and  waste a lot of space on my Linux Card !

In order to eliminate creation of this unnecessary "previous" directory,
Stephen Smalley suggested that I upgrade my core SELinux libs to the
following newer/stable versions:

[ libsemanage-1.10.4 , checkpolicy-1.34.3-x , libsepol-1.16.3-x ,
libselinux-1.34.10-x , policycoreutils-1.34.10-x ]...

However, with these newer lib versions, I cant successfully make any
policy changes anymore  :-(   Any ideas ?

=20

root# semodule -r myPolicy

libsemanage.semanage_make_sandbox: Could not copy files to sandbox
/etc/selinux/strict/modules/tmp.

semodule:  Failed on myPolicy!

=20

root# semanage login -a -s staff_u Admin

libsemanage.semanage_make_sandbox: Could not copy files to sandbox
/etc/selinux/strict/modules/tmp.

/usr/sbin/semanage: Could not start semanage transaction

=20

*** Note: I did run "restorecon -rF /etc/selinux/strict/modules"

             I also gave full (777) permissions to the
/etc/selinux/strict/modules  directory...   same result  :-(

Thanks,

- Rezaul.

=20

-----Original Message-----

From: Stephen Smalley [mailto:sds@tycho.nsa.gov
<mailto:sds@tycho.nsa.gov> ]

Sent: Thursday, July 12, 2007 2:58 PM

To: Hasan Rezaul-CHR010

Cc: SE Linux

Subject: RE: Libsemanage dependency on version of Linux...

On Thu, 2007-07-12 at 15:48 -0400, Hasan Rezaul-CHR010 wrote:

> Thanks Stephen,

>=20

> So given the fact that I must use Linux Kernel 2.6.14 :

>=20

> Are you saying that its okay for us to upgrade SELinux libs FROM the=20

> versions listed below TO the versions listed below while continuing to

> use Linux Kernel 2.6.14 ? In other words, the newer versions of the=20

> SELinux-related libs DON'T depend on the version of the Linux kernel ?

> I would like to upgrade the libs as described below, but I fear that

the

> new libs versions may not work correctly with Linux 2.6.14.

>=20

> Please confirm...

>=20

>=20

> libsemanage-1.6.17-1 =3D> libsemanage-1.10.4

> checkpolicy-1.33.1-2 =3D> checkpolicy-1.34.3-x

> libsepol-1.15.3-1 =3D> libsepol-1.16.3-x

> libselinux-1.33.4-2 =3D> libselinux-1.34.10-x

> policycoreutils-1.34.1-4 =3D> policycoreutils-1.34.10-x

AFAIK, there should be no problems from such an upgrade, and if there
are, that's a bug.

Naturally, trying it out on a test machine first considered a good idea.

--

Stephen Smalley

National Security Agency

=20


------_=_NextPart_001_01C7E5AB.8844330C
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3132" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<P><SPAN class=3D664070317-23082007><FONT face=3DArial size=3D2>Hi=20
All,</FONT></SPAN></P>
<P><SPAN class=3D664070317-23082007><FONT face=3DArial size=3D2>I am =
running SELinux=20
in STRICT mode on an embedded Linux card (running Linux=20
2.6.14).</FONT></SPAN></P>
<P><SPAN class=3D664070317-23082007><FONT face=3DArial =
size=3D2>Initially had the=20
following versions of core SELinux libs :</FONT></SPAN></P><SPAN=20
class=3D664070317-23082007>
<P><SPAN class=3D664070317-23082007>&nbsp;[ =
</SPAN>libsemanage-1.6.17-1<SPAN=20
class=3D664070317-23082007> </SPAN><SPAN class=3D664070317-23082007>,=20
</SPAN>checkpolicy-1.33.1-2<SPAN class=3D664070317-23082007> =
</SPAN><SPAN=20
class=3D664070317-23082007>, </SPAN>libsepol-1.15.3-1<SPAN=20
class=3D664070317-23082007> </SPAN><SPAN class=3D664070317-23082007>,=20
</SPAN>libselinux-1.33.4-2<SPAN class=3D664070317-23082007> </SPAN><SPAN =

class=3D664070317-23082007>, </SPAN>policycoreutils-1.34.1-4<SPAN=20
class=3D664070317-23082007> ]</SPAN></P>
<P><SPAN class=3D664070317-23082007>With the above versions, "semanage" =
and=20
"semodule" would work just fine ! However, the problem was that =
everytime any=20
minor policy change was made using semanage or semodule, a&nbsp;=20
/etc/selinux/strict/modules/<FONT =
color=3D#ff0000>previous/</FONT>&nbsp;&nbsp;=20
directory would get created with redundant policy info, and&nbsp; waste =
a lot of=20
space on my Linux Card !</SPAN></P>
<P><SPAN class=3D664070317-23082007>In order to eliminate creation of =
this=20
unnecessary&nbsp;"previous" directory, Stephen Smalley suggested that I =
upgrade=20
my core SELinux libs to the following newer/stable versions:</SPAN></P>
<P><SPAN class=3D664070317-23082007>[ </SPAN>libsemanage-1.10.4<SPAN=20
class=3D664070317-23082007> </SPAN><SPAN class=3D664070317-23082007>,=20
</SPAN>checkpolicy-1.34.3-x<SPAN class=3D664070317-23082007> =
</SPAN><SPAN=20
class=3D664070317-23082007>,&nbsp;</SPAN>libsepol-1.16.3-x<SPAN=20
class=3D664070317-23082007> </SPAN><SPAN=20
class=3D664070317-23082007>,&nbsp;</SPAN>libselinux-1.34.10-x<SPAN=20
class=3D664070317-23082007> </SPAN><SPAN=20
class=3D664070317-23082007>,&nbsp;</SPAN>policycoreutils-1.34.10-x<SPAN=20
class=3D664070317-23082007> ]...</SPAN></P>
<P><SPAN class=3D664070317-23082007>However, with these newer lib =
versions, I=20
<STRONG>cant </STRONG>successfully make any policy changes anymore&nbsp; =

:-(&nbsp;&nbsp; Any ideas ?</SPAN></P>
<P><SPAN class=3D664070317-23082007></SPAN>&nbsp;</P>
<P><FONT color=3D#0000ff><SPAN class=3D664070317-23082007>root# semodule =
-r=20
myPolicy</SPAN></FONT></P>
<P><FONT color=3D#0000ff><SPAN=20
class=3D664070317-23082007>libsemanage.semanage_make_sandbox: <FONT=20
color=3D#ff0000>Could not copy files to sandbox=20
/etc/selinux/strict/modules/tmp</FONT>.</SPAN></FONT></P>
<P><FONT color=3D#0000ff><SPAN =
class=3D664070317-23082007>semodule:&nbsp; Failed on=20
myPolicy!</SPAN></FONT></P>
<P><SPAN class=3D664070317-23082007></SPAN>&nbsp;</P>
<P><FONT color=3D#0000ff><SPAN class=3D664070317-23082007>root# semanage =
login -a -s=20
staff_u Admin</SPAN></FONT></P>
<P><FONT color=3D#0000ff><SPAN=20
class=3D664070317-23082007>libsemanage.semanage_make_sandbox: <FONT=20
color=3D#ff0000>Could not copy files to sandbox=20
/etc/selinux/strict/modules/tmp.</FONT></SPAN></FONT></P>
<P><FONT color=3D#0000ff><SPAN =
class=3D664070317-23082007>/usr/sbin/semanage: Could=20
not start semanage transaction</SPAN></FONT></P>
<P><FONT color=3D#0000ff><SPAN =
class=3D664070317-23082007></SPAN></FONT>&nbsp;</P>
<P><SPAN class=3D664070317-23082007><FONT face=3DArial size=3D2>*** =
Note: I did run=20
"restorecon -rF /etc/selinux/strict/modules"</FONT></SPAN></P>
<P><SPAN class=3D664070317-23082007><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;I=20
also gave full (777) permissions to the =
/etc/selinux/strict/modules&nbsp;=20
directory...&nbsp;&nbsp; same result&nbsp; :-(</FONT></SPAN></P></SPAN>
<P><SPAN class=3D664070317-23082007><FONT =
face=3DArial>Thanks,</FONT></SPAN></P>
<P><SPAN class=3D664070317-23082007><FONT face=3DArial size=3D2>-=20
Rezaul.</FONT></SPAN></P>
<P><FONT face=3DArial size=3D2></FONT>&nbsp;</P>
<P><FONT face=3DArial size=3D2>-----Original Message-----</FONT></P>
<P><FONT face=3DArial size=3D2>From: Stephen Smalley [</FONT><A=20
href=3D"mailto:sds@tycho.nsa.gov"><U><FONT color=3D#0000ff><FONT =
face=3DArial=20
size=3D2>mailto:sds@tycho.nsa.gov</FONT></U></FONT></A><FONT =
face=3DArial=20
size=3D2>]</FONT></P>
<P><FONT face=3DArial size=3D2>Sent: Thursday, July 12, 2007 2:58 =
PM</FONT></P>
<P><FONT face=3DArial size=3D2>To: Hasan Rezaul-CHR010</FONT></P>
<P><FONT face=3DArial size=3D2>Cc: SE Linux</FONT></P>
<P><FONT face=3DArial size=3D2>Subject: RE: Libsemanage dependency on =
version of=20
Linux...</FONT></P>
<P><FONT face=3DArial size=3D2>On Thu, 2007-07-12 at 15:48 -0400, Hasan=20
Rezaul-CHR010 wrote:</FONT></P>
<P><FONT face=3DArial size=3D2>&gt; Thanks Stephen,</FONT></P>
<P><FONT face=3DArial size=3D2>&gt; </FONT></P>
<P><FONT face=3DArial size=3D2>&gt; So given the fact that I must use =
Linux Kernel=20
2.6.14 :</FONT></P>
<P><FONT face=3DArial size=3D2>&gt; </FONT></P>
<P><FONT face=3DArial size=3D2>&gt; Are you saying that its okay for us =
to upgrade=20
SELinux libs FROM the </FONT></P>
<P><FONT face=3DArial size=3D2>&gt; versions listed below TO the =
versions listed=20
below while continuing to</FONT></P>
<P><FONT face=3DArial size=3D2>&gt; use Linux Kernel 2.6.14 ? In other =
words, the=20
newer versions of the </FONT></P>
<P><FONT face=3DArial size=3D2>&gt; SELinux-related libs DON'T depend on =
the version=20
of the Linux kernel ?</FONT></P>
<P><FONT face=3DArial size=3D2>&gt; I would like to upgrade the libs as =
described=20
below, but I fear that</FONT></P>
<P><FONT face=3DArial size=3D2>the</FONT></P>
<P><FONT face=3DArial size=3D2>&gt; new libs versions may not work =
correctly with=20
Linux 2.6.14.</FONT></P>
<P><FONT face=3DArial size=3D2>&gt; </FONT></P>
<P><FONT face=3DArial size=3D2>&gt; Please confirm...</FONT></P>
<P><FONT face=3DArial size=3D2>&gt; </FONT></P>
<P><FONT face=3DArial size=3D2>&gt; </FONT></P>
<P><FONT face=3DArial size=3D2>&gt; libsemanage-1.6.17-1 =3D&gt;=20
libsemanage-1.10.4</FONT></P>
<P><FONT face=3DArial size=3D2>&gt; checkpolicy-1.33.1-2 =3D&gt;=20
checkpolicy-1.34.3-x</FONT></P>
<P><FONT face=3DArial size=3D2>&gt; libsepol-1.15.3-1 =3D&gt;=20
libsepol-1.16.3-x</FONT></P>
<P><FONT face=3DArial size=3D2>&gt; libselinux-1.33.4-2 =3D&gt;=20
libselinux-1.34.10-x</FONT></P>
<P><FONT face=3DArial size=3D2>&gt; policycoreutils-1.34.1-4 =3D&gt;=20
policycoreutils-1.34.10-x</FONT></P>
<P><FONT face=3DArial size=3D2>AFAIK, there should be no problems from =
such an=20
upgrade, and if there are, that's a bug.</FONT></P>
<P><FONT face=3DArial size=3D2>Naturally, trying it out on a test =
machine first=20
considered a good idea.</FONT></P>
<P><FONT face=3DArial size=3D2>--</FONT></P>
<P><FONT face=3DArial size=3D2>Stephen Smalley</FONT></P>
<P><FONT face=3DArial size=3D2>National Security Agency</FONT></P>
<P><FONT face=3DArial size=3D2></FONT>&nbsp;</P></DIV></BODY></HTML>

------_=_NextPart_001_01C7E5AB.8844330C--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
