Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m340HUo7005374
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 20:17:30 -0400
Received: from dmzmta103.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m340HP66026640
	for <selinux@tycho.nsa.gov>; Fri, 4 Apr 2008 00:17:29 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta103.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m33N57Y0001823
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 19:05:07 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta002.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m33N5AOE032143
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 19:05:10 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C895DF.4B0AA2B4"
Subject: Audit2allow + allow rule for 'granted' access
Date: Thu, 3 Apr 2008 16:06:04 -0700
Message-ID: <4AE25A7D8CBE4E4DA8E87173237DE27E8B95@blums0042.bluelnk.net>
From: "Karrels, Jeffrey J \(US SSA\)" <jeffrey.karrels@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C895DF.4B0AA2B4
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Not that this is a big deal, but is there a way to stop audit2allow from
processing and creating rules for audits that are 'granted'?=20

=20

I turned on auditing for a couple of rules so I can keep an eye on
domain transitions. That creates some entries in the audit log such as:
"avc:  granted  { transition } for  pid=3D3409 ".=20

=20

When I run audit2allow on that entry, audit2allow creates a rule for
that entry as if the entry were a 'denied' rather than a 'granted'. It
came into being an issue when I was ignoring the allow transition
entries, and there was an actual 'denied' audit (hidden amongst the
granted transitions [for mls reasons]) that I was not catching when
manually going through the logs.

=20

Thanks again

Jeff

=20

 =20


------_=_NextPart_001_01C895DF.4B0AA2B4
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
font-family:Arial'>Not that this is a big deal, but is there a way to =
stop
audit2allow from processing and creating rules for audits that are =
&#8216;granted&#8217;?
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I turned on auditing for a couple of rules so I can =
keep an
eye on domain transitions. That creates some entries in the audit log =
such as: &#8220;avc:&nbsp;
granted&nbsp; { transition } for&nbsp; pid=3D3409 &#8221;. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>When I run audit2allow on that entry, audit2allow =
creates a
rule for that entry as if the entry were a &#8216;denied&#8217; rather =
than a &#8216;granted&#8217;.
It came into being an issue when I was ignoring the allow transition =
entries,
and there was an actual &#8216;denied&#8217; audit (hidden amongst the =
granted
transitions [for mls reasons]) that I was not catching when manually =
going
through the logs.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks again<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jeff<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; <o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C895DF.4B0AA2B4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
