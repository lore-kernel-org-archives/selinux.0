Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4U8bIet016287
	for <selinux@tycho.nsa.gov>; Tue, 30 May 2006 04:37:18 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4U8bHJA006356
	for <selinux@tycho.nsa.gov>; Tue, 30 May 2006 08:37:17 GMT
Received: by ug-out-1314.google.com with SMTP id y2so587265uge
        for <selinux@tycho.nsa.gov>; Tue, 30 May 2006 01:37:16 -0700 (PDT)
From: "Mario Fanelli" <mario.fanelli@gmail.com>
To: "SeLinux Mailing List" <selinux@tycho.nsa.gov>
Subject: trouble with execmod permission in file class 
Date: Tue, 30 May 2006 10:37:13 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000F_01C683D5.04EA8970"
Message-ID: <447c043c.0e9fa353.26b4.ffffa66e@mx.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_000F_01C683D5.04EA8970
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I'm trying to write a policy for apache and audit2allow suggest me a rule
like

 

allow apache_t lib_t:file execmod

 

but I don't understand..

I read on tresys.com that permission execmod -> "Make executable a file
mapping that has been modified by copy-on-write".

Anyone can give me an explanation? Why, without this rule, apache doesn't
load module?


------=_NextPart_000_000F_01C683D5.04EA8970
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
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
span.StileMessaggioDiPostaElettronica17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
span.10ptCarattere
	{font-family:"Courier New";}
p.10pt, li.10pt, div.10pt
	{margin:0in;
	margin-bottom:.0001pt;
	line-height:130%;
	font-size:10.0pt;
	font-family:"Courier New";}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m trying to write a policy for apache and =
audit2allow
suggest me a rule like<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>allow apache_t lib_t:file =
execmod<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>but I don&#8217;t =
understand..<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I read on tresys.com that permission execmod -&gt; =
&#8220;</span></font>Make
executable a file mapping that has been modified by =
copy-on-write&#8221;.<o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Anyone can give me an explanation? Why, without this rule, =
apache doesn&#8217;t
load module?</span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_000F_01C683D5.04EA8970--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
