Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6AE0w9v004476
 for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2018 10:00:59 -0400
From: "Mclain, Warren" <warren_mclain@optum.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Tue, 10 Jul 2018 14:00:22 +0000
Message-ID: <8DB55F909F852648AD052B95F8C1001E4943C416@APSWP0835.ms.ds.uhc.com>
Content-Type: multipart/alternative;
 boundary="_000_8DB55F909F852648AD052B95F8C1001E4943C416APSWP0835msdsuh_"
MIME-Version: 1.0
Subject: blocking / mount using containers
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_8DB55F909F852648AD052B95F8C1001E4943C416APSWP0835msdsuh_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I am trying to find a solution for blocking the mounting of / from containe=
rs. This is a major security hole for Docker and all of those types of appl=
ications.

I found the mount_anyfile  Boolean but nothing that digs into that to show =
how to disable specific mountings.

Looking for any information that would help the container community in gene=
ral.

thanks

___________________________________
Warren McLain
Enterprise Engineering Services
IEI Foundation Engineering - Compute, Optum Technology
 warren_mclain@optum.com Office: 763-744-3107


This e-mail, including attachments, may include confidential and/or
proprietary information, and may be used only by the person or entity
to which it is addressed. If the reader of this e-mail is not the intended
recipient or his or her authorized agent, the reader is hereby notified
that any dissemination, distribution or copying of this e-mail is
prohibited. If you have received this e-mail in error, please notify the
sender by replying to this message and delete this e-mail immediately.

--_000_8DB55F909F852648AD052B95F8C1001E4943C416APSWP0835msdsuh_
Content-Type: text/html; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">I am trying to find a solution for blocking the moun=
ting of / from containers. This is a major security hole for Docker and all=
 of those types of applications.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I found the mount_anyfile &nbsp;Boolean but nothing =
that digs into that to show how to disable specific mountings.<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Looking for any information that would help the cont=
ainer community in general.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">thanks<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">___________________________________<o:p></o:p></p>
<p class=3D"MsoNormal">Warren McLain<o:p></o:p></p>
<p class=3D"MsoNormal">Enterprise Engineering Services<o:p></o:p></p>
<p class=3D"MsoNormal">IEI Foundation Engineering - Compute, Optum Technolo=
gy <o:p>
</o:p></p>
<p class=3D"MsoNormal">&nbsp;warren_mclain@optum.com Office: 763-744-3107<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p><br>
This e-mail, including attachments, may include confidential and/or<br>
proprietary information, and may be used only by the person or entity<br>
to which it is addressed. If the reader of this e-mail is not the intended<=
br>
recipient or his or her authorized agent, the reader is hereby notified<br>
that any dissemination, distribution or copying of this e-mail is<br>
prohibited. If you have received this e-mail in error, please notify the<br>
sender by replying to this message and delete this e-mail immediately.</p><=
/body>
</html>

--_000_8DB55F909F852648AD052B95F8C1001E4943C416APSWP0835msdsuh_--
