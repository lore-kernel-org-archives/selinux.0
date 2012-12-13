Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBDGMM0p002398
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2012 11:22:22 -0500
Received: from MX1.integrity-apps.com (localhost.localdomain [127.0.0.1])
	by localhost (Email Security Appliance) with SMTP id A140FC3530_CA00A3B
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2012 16:21:55 +0000 (GMT)
Received: from chunex01.integrity-apps.com (unknown [172.25.1.12])
	by MX1.integrity-apps.com (Sophos Email Appliance) with ESMTP id 2C6B6C0654_CA0090F
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2012 16:21:29 +0000 (GMT)
From: "Langland, Blake" <blangland@integrity-apps.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: SELinux networking question
Date: Thu, 13 Dec 2012 16:21:24 +0000
Message-ID: <DA8D339A60101247B36E202899B1C93A2D5684@CHUNEX01.integrity-apps.com>
Content-Type: multipart/alternative;
	boundary="_000_DA8D339A60101247B36E202899B1C93A2D5684CHUNEX01integrity_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_DA8D339A60101247B36E202899B1C93A2D5684CHUNEX01integrity_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I am attempting to set up a server using SELinux and the MLS policy. I am h=
aving trouble restricting network access of this server. There will be a wi=
ndows machine acting as a client, receiving UDP messages from the server. W=
hat I would like to do is restrict what data can be sent to the windows mac=
hine based upon the context of the sending process.

I have tried to set the sensitivity level of the client node using semanage=
 node command, but traffic is still able to be sent from a process with a h=
igher sensitivity level. Am I missing a step?

Thanks for any suggestions you can give me.

Blake Langland

--_000_DA8D339A60101247B36E202899B1C93A2D5684CHUNEX01integrity_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
<p class=3D"MsoNormal">Hello,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am attempting to set up a server using SELinux and=
 the MLS policy. I am having trouble restricting network access of this ser=
ver. There will be a windows machine acting as a client, receiving UDP mess=
ages from the server. What I would
 like to do is restrict what data can be sent to the windows machine based =
upon the context of the sending process.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have tried to set the sensitivity level of the cli=
ent node using semanage node command, but traffic is still able to be sent =
from a process with a higher sensitivity level. Am I missing a step?
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks for any suggestions you can give me.<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Blake Langland<o:p></o:p></p>
</div>
</body>
</html>

--_000_DA8D339A60101247B36E202899B1C93A2D5684CHUNEX01integrity_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
