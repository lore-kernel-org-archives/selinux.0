Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA28334
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 15:47:53 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA06929
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 20:45:56 GMT
Received: from marshal.global.com (host-65-123-3-10.comglobal.com [65.123.3.10] (may be forged))
        by jazzband.ncsc.mil  with ESMTP id UAA06925 for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 20:45:55 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C2869E.EF7594E5"
Subject: Kernet panic VFS: Unable to mount root fs 
Date: Thu, 7 Nov 2002 12:47:50 -0800
Message-ID: <DB4BA538D0DA21479C610B2466EEF646162727@sjmail.global.com>
From: "Paul Loo" <PaulL@comglobal.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C2869E.EF7594E5
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

I installed Mandrake 9.0 with an ext3 file system. I ran the "make
quickinstall"  for selinux and I

Got these messages during boot:

=20

   Loading 2419-selinux ....

   BIOS data check successful

   Uncompressing Linux ... OK, booting the kernel

   Error: only one processor found

   Unknown bridge resource 0: assuming transparent

   Unknown bridge resource 1: assuming transparent

   Unknown bridge resource 2: assuming transparent

   kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno =3D =
2

   kmod: failed to exec /sbin/modprobe -s -k block_major_8, errno =3D 2

   Kernet panic VFS: Unable to mount root fs on 08:01

  =20

=20

Sometimes I would get these messages:

=20

   VFS: Cannot open root device "801" or 08:01

   Please append a correct "root=3D" boot option

   Kernet panic VFS: Unable to mount root fs on 08:01

=20

Please help.

Thanks.

=20


------_=_NextPart_001_01C2869E.EF7594E5
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I installed Mandrake 9.0 with an ext3 file system. I =
ran the
&#8220;make quickinstall&#8221; &nbsp;for selinux and =
I</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Got these messages during boot:</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Loading 2419-selinux =
....</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; BIOS data check =
successful</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Uncompressing Linux ... OK, booting the =
kernel</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Error: only one processor =
found</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Unknown bridge resource 0: assuming =
transparent</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Unknown bridge resource 1: assuming =
transparent</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Unknown bridge resource 2: assuming =
transparent</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; kmod: failed to exec /sbin/modprobe -s =
-k scsi_hostadapter,
errno =3D 2</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; kmod: failed to exec /sbin/modprobe -s =
-k
block_major_8, errno =3D 2</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Kernet panic VFS: Unable to mount root =
fs on </span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>08:01</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Sometimes I would get these =
messages:</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; VFS: Cannot open root device =
&quot;801&quot; or
</span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:
 Arial'>08:01</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Please append a correct =
&quot;root=3D&quot; boot option</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Kernet panic VFS: Unable to mount root =
fs on </span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>08:01</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Please help.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

</div>

</body>

</html>
=00
------_=_NextPart_001_01C2869E.EF7594E5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
