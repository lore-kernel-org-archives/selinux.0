Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m33KUgxX022017
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 16:30:46 -0400
Received: from dmzmta102.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m33KUelF021383
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 20:30:40 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m33Je3fK027459
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 15:40:03 -0400
Received: from blums0041.bluelnk.net ([134.120.81.53])
	by usdmta001.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id m33Jdc3i021278
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 15:39:40 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C895C2.9DD82876"
Subject: Removing 2 modules that depend on eachother
Date: Thu, 3 Apr 2008 12:40:48 -0700
Message-ID: <4AE25A7D8CBE4E4DA8E87173237DE27E8B94@blums0042.bluelnk.net>
From: "Karrels, Jeffrey J \(US SSA\)" <jeffrey.karrels@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C895C2.9DD82876
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hello all.

=20

I have a question. I have two modules that I created that I wanted to
remove (both). Each module depends on the other. What is the best way to
go about this? (for now, I have removed one of my dependencies and then
was able to remove the modules one at a time).  Is there a better way to
go about this though? I tried calling semodule -r in various forms to
try and remove two packages at the same time, but did not have any luck.
Any suggestions?

=20

Thanks

Jeff=20


------_=_NextPart_001_01C895C2.9DD82876
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
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
	{mso-style-type:personal-compose;
	font-family:Arial;
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
font-family:Arial'>Hello all.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have a question. I have two modules that I created =
that I
wanted to remove (both). Each module depends on the other. What is the =
best way
to go about this? (for now, I have removed one of my dependencies and =
then was
able to remove the modules one at a time).&nbsp; Is there a better way =
to go
about this though? I tried calling semodule &#8211;r in various forms to =
try
and remove two packages at the same time, but did not have any luck. Any
suggestions?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jeff <o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C895C2.9DD82876--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
