Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3PGdeRb017289
	for <selinux@tycho.nsa.gov>; Sun, 25 Apr 2004 12:39:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3PGdcdi021881
	for <selinux@tycho.nsa.gov>; Sun, 25 Apr 2004 16:39:39 GMT
Received: from abyss.simplyaquatics.com (abyss.simplyaquatics.com [69.44.152.139])
        by jazzband.ncsc.mil  with ESMTP id i3PGdcJP021878 for <selinux@tycho.nsa.gov>; Sun, 25 Apr 2004 16:39:38 GMT
Received: from localhost (localhost [127.0.0.1])
	by abyss.simplyaquatics.com (Postfix) with ESMTP id 8CB2D3A404F
	for <selinux@tycho.nsa.gov>; Sun, 25 Apr 2004 11:39:38 -0500 (CDT)
Received: from TECRAS1 (simplyaquatics.com [209.192.116.78])
	by abyss.simplyaquatics.com (Postfix) with ESMTP id D5AE63A404F
	for <selinux@tycho.nsa.gov>; Sun, 25 Apr 2004 11:39:37 -0500 (CDT)
From: "Ed Street" <edstreet@street-tek.com>
To: <selinux@tycho.nsa.gov>
Subject: /etc/passwd labeling issues
Date: Sun, 25 Apr 2004 12:39:37 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0225_01C42AC2.5F080680"
Message-Id: <20040425163937.D5AE63A404F@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0225_01C42AC2.5F080680
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

As for the labeling issue for /etc/passwd I noticed in passwd.te this =
line

=20

file_type_auto_trans($1_t, etc_t, shadow_t, file)

=20

Wouldn=92t this cause our labeling issue?  If I remarked it out and =
added the
following lines.

=20

allow passwd_t etc_t:dir { add_name remove_name write };

allow passwd_t initrc_var_run_t:file { lock };

allow passwd_t passwd_t:process { setrlimit };

allow passwd_t shadow_t:file { write lock create getattr read rename =
setattr
unlink };

=20

then the labeling on /etc/passwd is the same domain. i.e.

-rw-r--r--  root     root     blacknet:object_r:etc_t          =
/etc/passwd

=20

Then the only issue is the username which is workable.

=20

The question I have is why we need to patch passwd when this seems to be =
a
policy issue.

=20

Ed


---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.662 / Virus Database: 425 - Release Date: 4/20/2004
=20

------=_NextPart_000_0225_01C42AC2.5F080680
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DWindows-1252">


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
font-family:Arial'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>As for the labeling issue for /etc/passwd I noticed =
in
passwd.te this line<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>file_type_auto_trans($1_t, etc_t, shadow_t, =
file)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Wouldn&#8217;t this cause our labeling issue?&nbsp; =
If I remarked
it out and added the following lines.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>allow passwd_t etc_t:dir { add_name remove_name write =
};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>allow passwd_t initrc_var_run_t:file { lock =
};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>allow passwd_t passwd_t:process { setrlimit =
};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>allow passwd_t shadow_t:file { write lock create =
getattr
read rename setattr unlink };<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>then the labeling on /etc/passwd is the same domain. =
i.e.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-rw-r--r--&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; =
root&nbsp;&nbsp;&nbsp;&nbsp;
blacknet:object_r:etc_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /etc/passwd<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Then the only issue is the username which is =
workable.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The question I have is why we need to patch passwd =
when this
seems to be a policy issue.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Ed<o:p></o:p></span></font></p>

</div>

</body>

</html>
<BR>

<P><FONT SIZE=3D2>---<BR>
<BR>
Checked by AVG anti-virus system (http://www.grisoft.com).<BR>
Version: 6.0.662 / Virus Database: 425 - Release Date: 4/20/2004<BR>
</FONT> </P>

------=_NextPart_000_0225_01C42AC2.5F080680--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
