Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBCEjIRb009000
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 09:45:18 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBCEjHRV007151
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 14:45:17 GMT
Received: from mail.simplyaquatics.com ([209.192.59.11])
        by jazzband.ncsc.mil  with ESMTP id hBCEjHta007148 for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 14:45:17 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.simplyaquatics.com (Postfix) with ESMTP id 9BA0E45009B
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 09:45:20 -0500 (EST)
Received: from TECRA (unknown [192.168.1.154])
	by mail.simplyaquatics.com (Postfix) with ESMTP id 9D8AB45009B
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 09:45:18 -0500 (EST)
From: "Ed Street" <edstreet@street-tek.com>
To: "Selinux" <selinux@tycho.nsa.gov>
Subject: syslog()
Date: Fri, 12 Dec 2003 09:42:57 -0500
Message-ID: <00ae01c3c0be$3bbda770$9a01a8c0@TECRA>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00AF_01C3C094.52E79F70"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_00AF_01C3C094.52E79F70
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

I have a =91mod=92 that makes a syslog() call, in permissive mode it =
works fine.
In enforcing mode it does not log nor does it display an avc message.  =
I=92m
not clear on where I need to look for the policy change that=92s needed. =
 Also
do I need to make any extra calls for this?

=20

Ed

=20


---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.548 / Virus Database: 341 - Release Date: 12/05/2003
=20

------=_NextPart_000_00AF_01C3C094.52E79F70
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DWindows-1252">


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
	{color:#606420;
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

<body lang=3DEN-US link=3Dblue vlink=3D"#606420">

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have a =91mod=92 that makes a syslog() call, in
permissive mode it works fine.&nbsp; In enforcing mode it does not log =
nor does
it display an avc message.&nbsp; I=92m not clear on where I =
ne</span></font><font
 size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>ed</span></font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> to look for
the policy change that=92s ne</span></font><font size=3D2 =
face=3DArial><span
 style=3D'font-size:10.0pt;font-family:Arial'>ed</span></font><font =
size=3D2
 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>ed</span></font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>.=A0 Also do I
ne</span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
 font-family:Arial'>ed</span></font><font size=3D2 face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'> to make any extra calls =
for this?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Ed</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

</div>

</body>

</html>
<BR>

<P><FONT SIZE=3D2>---<BR>
Outgoing mail is certified Virus Free.<BR>
Checked by AVG anti-virus system (http://www.grisoft.com).<BR>
Version: 6.0.548 / Virus Database: 341 - Release Date: 12/05/2003<BR>
</FONT> </P>

------=_NextPart_000_00AF_01C3C094.52E79F70--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
