Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4NGKYxW009176
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2013 12:20:36 -0400
Received: from MX1.integrity-apps.com (localhost.localdomain [127.0.0.1])
	by localhost (Email Security Appliance) with SMTP id 77E2BC33C1_19E41D1B
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2013 16:20:33 +0000 (GMT)
Received: from chunex01.integrity-apps.com (unknown [172.25.1.12])
	by MX1.integrity-apps.com (Sophos Email Appliance) with ESMTP id EE0C7C0626_19E41D0F
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2013 16:20:32 +0000 (GMT)
From: "Langland, Blake" <blangland@integrity-apps.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: high to low UDP stream
Date: Thu, 23 May 2013 16:20:32 +0000
Message-ID: <DA8D339A60101247B36E202899B1C93A8EEA1B@CHUNEX01.integrity-apps.com>
Content-Type: multipart/alternative;
	boundary="_000_DA8D339A60101247B36E202899B1C93A8EEA1BCHUNEX01integrity_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_DA8D339A60101247B36E202899B1C93A8EEA1BCHUNEX01integrity_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I am having a hard time figuring out if what I want to do is possible knowi=
ng the way that the MLS policy is designed. Basically I am wondering if it =
is possible to write a module or do some sort of network labeling to allow =
a UDP stream to be sent from a higher level process on an SELinux machine t=
o a lower classification machine (peer-labeled with netlabel). Here is what=
 I am trying to do:

s3 process -----> s2 machine (netlabel)

I am aware that this goes against the BLP model of no writes from high to l=
ow, but I just wanted to verify if it is possible to make and "exception" o=
f sorts with SELinux. I have tried labeling outgoing packets with SECMARK t=
o s2 but it is still denying the message based on the peer labeling. How do=
 cross domain guards accomplish this since I think some are run on SELinux?

Thanks,
Blake



--_000_DA8D339A60101247B36E202899B1C93A8EEA1BCHUNEX01integrity_
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
<p class=3D"MsoNormal">Hello everyone,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am having a hard time figuring out if what I want =
to do is possible knowing the way that the MLS policy is designed. Basicall=
y I am wondering if it is possible to write a module or do some sort of net=
work labeling to allow a UDP stream
 to be sent from a higher level process on an SELinux machine to a lower cl=
assification machine (peer-labeled with netlabel). Here is what I am trying=
 to do:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">s3 process -----&gt; s2 machine (netlabel)<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am aware that this goes against the BLP model of n=
o writes from high to low, but I just wanted to verify if it is possible to=
 make and &#8220;exception&#8221; of sorts with SELinux. I have tried label=
ing outgoing packets with SECMARK to s2 but it
 is still denying the message based on the peer labeling. How do cross doma=
in guards accomplish this since I think some are run on SELinux?
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Blake<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DA8D339A60101247B36E202899B1C93A8EEA1BCHUNEX01integrity_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
