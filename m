Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2SFkdRb000906
	for <selinux@tycho.nsa.gov>; Sun, 28 Mar 2004 10:46:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2SFkdFV000206
	for <selinux@tycho.nsa.gov>; Sun, 28 Mar 2004 15:46:39 GMT
Received: from abyss.simplyaquatics.com (abyss.simplyaquatics.com [69.44.152.139])
        by jazzband.ncsc.mil  with ESMTP id i2SFkc36000053 for <selinux@tycho.nsa.gov>; Sun, 28 Mar 2004 15:46:38 GMT
From: "Ed Street" <edstreet@street-tek.com>
To: "'Park Lee'" <parklee_sel@yahoo.com>, <selinux@tycho.nsa.gov>
Subject: RE: how to write and understand a patch file?
Date: Sun, 28 Mar 2004 10:46:02 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_018D_01C414B1.DDDDE410"
In-Reply-To: <20040328100448.19776.qmail@web41308.mail.yahoo.com>
Message-Id: <20040328154616.BABC43A404E@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_018D_01C414B1.DDDDE410
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit

HYPERLINK
"http://laughingmeme.org/archives/001753.html?rss"http://laughingmeme.org/ar
chives/001753.html?rss

 

 

 

   _____  

From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of Park Lee
Sent: Sunday, March 28, 2004 5:05 AM
To: selinux@tycho.nsa.gov
Subject: how to write and understand a patch file?

 

Hi,

Would you please tell me how to write and understand a patch file?

I just want to learn more about it.

 

Thank you.

 

Yours,

Park Lee

2004-03-28


---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.631 / Virus Database: 404 - Release Date: 3/17/2004
 

------=_NextPart_000_018D_01C414B1.DDDDE410
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DWindows-1252">


<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
	{color:blue;
	text-decoration:underline;}
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><a
href=3D"http://laughingmeme.org/archives/001753.html?rss">http://laughing=
meme.org/archives/001753.html?rss</a><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] =
<b><span
style=3D'font-weight:bold'>On Behalf Of </span></b>Park Lee<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Sunday, March 28, =
2004 5:05
AM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
selinux@tycho.nsa.gov<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> how to write and
understand a patch file?</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Hi,<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Would you please tell me how to write and understand a patch =
file?<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>I just want to learn more about it.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Thank you.<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Yours,<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Park Lee<o:p></o:p></span></font></p>

</div>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>2004-03-28</span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p></o:p></span></font></p>

</div>

</div>

</body>

</html>
<BR>

<P><FONT SIZE=3D2>---<BR>
Outgoing mail is certified Virus Free.<BR>
Checked by AVG anti-virus system (http://www.grisoft.com).<BR>
Version: 6.0.631 / Virus Database: 404 - Release Date: 3/17/2004<BR>
</FONT> </P>

------=_NextPart_000_018D_01C414B1.DDDDE410--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
