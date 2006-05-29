Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4THWaHW006960
	for <selinux@tycho.nsa.gov>; Mon, 29 May 2006 13:32:36 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4THWYOn017987
	for <selinux@tycho.nsa.gov>; Mon, 29 May 2006 17:32:35 GMT
Received: by ug-out-1314.google.com with SMTP id y2so335514uge
        for <selinux@tycho.nsa.gov>; Mon, 29 May 2006 10:32:34 -0700 (PDT)
From: "Mario Fanelli" <mario.fanelli@gmail.com>
To: "SeLinux Mailing List" <selinux@tycho.nsa.gov>
Subject: Use of type_change and type_transition declarations
Date: Mon, 29 May 2006 19:32:26 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0028_01C68356.9EEFF570"
Message-ID: <447b3031.200d0097.6f44.118c@mx.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0028_01C68356.9EEFF570
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I don't understand what means type_change declaration. 

Anyone can give me an explanation? What are the difference between
type_change and type_transition declarations? 

If I declare a type_transition like type_transition dom1_t
dom2_exec_t:process dom2_t, why I have to use an allow rule?


------=_NextPart_000_0028_01C68356.9EEFF570
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
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
span.StileMessaggioDiPostaElettronica17
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
font-family:Arial'>I don&#8217;t understand what means type_change =
declaration.
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Anyone can give me an explanation? What are the =
difference
between type_change and type_transition declarations? =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>If I declare a type_transition like type_transition =
dom1_t
dom2_exec_t:process dom2_t, why I have to use an allow =
rule?<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0028_01C68356.9EEFF570--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
