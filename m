Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rB3HBhLO021020
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2013 12:11:43 -0500
Received: from MX1.integrity-apps.com (localhost.localdomain [127.0.0.1])
	by localhost (Email Security Appliance) with SMTP id 7095CC33C8_29E10CDB
	for <selinux@tycho.nsa.gov>; Tue,  3 Dec 2013 17:11:41 +0000 (GMT)
Received: from chunex01.integrity-apps.com (unknown [172.25.1.12])
	by MX1.integrity-apps.com (Sophos Email Appliance) with ESMTP id 261D1C05F3_29E10CDF
	for <selinux@tycho.nsa.gov>; Tue,  3 Dec 2013 17:11:41 +0000 (GMT)
From: "Marino, Claudio" <cmarino@integrity-apps.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: RE: subscribe selinux
Date: Tue, 3 Dec 2013 17:11:40 +0000
Message-ID: <D06E30E1B8C24A4DAB7535F0E91D6275F3FA97@CHUNEX01.integrity-apps.com>
Content-Type: multipart/alternative;
	boundary="_000_D06E30E1B8C24A4DAB7535F0E91D6275F3FA97CHUNEX01integrity_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_D06E30E1B8C24A4DAB7535F0E91D6275F3FA97CHUNEX01integrity_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I am looking at using SELinux for a GUI based MLS workstation.

For my example I have created a user (user_s1) with a classification of s2 =
and a second user (user_s2) with classification s3.  When in the enforcing =
mode I am not able to log in (from the GUI)  to either users.  It just brin=
g be back to the login screen.

After going into permissive mode I try and see what is being blocked by sea=
rching the /var/log/audit/audit.log file and looking for "AVC" but I can't =
find anything about the login denial.  I have used setroubleshoot but still=
 can't understand what needs to be modified to make it work.

Has anyone gotten a GUI to work with SELinux?  If so what polices need to b=
e modified?

Thanks for our help,

Claudio



--_000_D06E30E1B8C24A4DAB7535F0E91D6275F3FA97CHUNEX01integrity_
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
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<p class=3D"MsoNormal">I am looking at using SELinux for a GUI based MLS wo=
rkstation.&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For my example I have created a user (user_s1) with =
a classification of s2 and a second user (user_s2) with classification s3.&=
nbsp; When in the enforcing mode I am not able to log in (from the GUI) &nb=
sp;to either users.&nbsp; It just bring be back to
 the login screen.&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After going into permissive mode I try and see what =
is being blocked by searching the /var/log/audit/audit.log file and looking=
 for &#8220;AVC&#8221; but I can&#8217;t find anything about the login deni=
al.&nbsp; I have used setroubleshoot but still can&#8217;t understand
 what needs to be modified to make it work.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Has anyone gotten a GUI to work with SELinux?<span s=
tyle=3D"color:#1F497D">&nbsp;
</span>If so what polices need to be modified?<span style=3D"color:#1F497D"=
><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks for our help,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Claudio<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_D06E30E1B8C24A4DAB7535F0E91D6275F3FA97CHUNEX01integrity_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
