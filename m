Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9AHCdjc023322
	for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2013 13:12:39 -0400
Received: from MX1.integrity-apps.com (localhost.localdomain [127.0.0.1])
	by localhost (Email Security Appliance) with SMTP id AC884C34EA_256E005B
	for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2013 17:12:37 +0000 (GMT)
Received: from chunex01.integrity-apps.com (unknown [172.25.1.12])
	by MX1.integrity-apps.com (Sophos Email Appliance) with ESMTP id E1EDAC064F_256E004F
	for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2013 17:12:36 +0000 (GMT)
From: "Langland, Blake" <blangland@integrity-apps.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: MLS over loopback interface
Date: Thu, 10 Oct 2013 17:12:35 +0000
Message-ID: <DA8D339A60101247B36E202899B1C93AA91986@CHUNEX01.integrity-apps.com>
Content-Type: multipart/alternative;
	boundary="_000_DA8D339A60101247B36E202899B1C93AA91986CHUNEX01integrity_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_DA8D339A60101247B36E202899B1C93AA91986CHUNEX01integrity_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

All,

I have two web servers running on an SELinux machine, one running at s2 and=
 one at s3. Both webservers have two webapps each that are attempting to co=
mmunicate over the loopback interface. The communication is strictly s2 <->=
 s2 and s3 <-> s3. The problem I am having is setting the MLS level of the =
loopback interface. If I have it set below s3, the s3 webapps cannot send o=
ver the interface; If I have it set higher than s2, the s2 webapps cannot r=
eceive over the interface. Any suggestions?

Thanks,
Blake


--_000_DA8D339A60101247B36E202899B1C93AA91986CHUNEX01integrity_
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
<p class=3D"MsoNormal">All,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have two web servers running on an SELinux machine=
, one running at s2 and one at s3. Both webservers have two webapps each th=
at are attempting to communicate over the loopback interface. The communica=
tion is strictly s2 &lt;-&gt; s2 and s3
 &lt;-&gt; s3. The problem I am having is setting the MLS level of the loop=
back interface. If I have it set below s3, the s3 webapps cannot send over =
the interface; If I have it set higher than s2, the s2 webapps cannot recei=
ve over the interface. Any suggestions?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Blake<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DA8D339A60101247B36E202899B1C93AA91986CHUNEX01integrity_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
