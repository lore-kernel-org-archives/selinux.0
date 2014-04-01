Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s31Dqo5w011197
 for <selinux@tycho.nsa.gov>; Tue, 1 Apr 2014 09:52:50 -0400
Received: from ferret (fw5540.nrl.navy.mil [132.250.196.100])
 by ccs.nrl.navy.mil (8.14.4/8.14.4) with ESMTP id s31DqkfS005745
 for <selinux@tycho.nsa.gov>; Tue, 1 Apr 2014 09:52:49 -0400
From: "Kim Lawson-Jenkins" <kim.lawson-jenkins@nrl.navy.mil>
To: <selinux@tycho.nsa.gov>
Subject: Labelling problems with a user directly running an application in a
 confined domain
Date: Tue, 1 Apr 2014 09:59:18 -0400
Message-ID: <026a01cf4db2$9524fb60$bf6ef220$@nrl.navy.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_026B_01CF4D91.0E135B60"
Reply-To: kim.lawson-jenkins@nrl.navy.mil
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multipart message in MIME format.

------=_NextPart_000_026B_01CF4D91.0E135B60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

I'm pretty sure my questions are basic SELinux 101 but I'm having a problem
confining an application when a user runs the application directly.  On our
system I have removed the unconfined domain and unconfined user.  When the
system initializes the confined applications run in the correct confined
domains.  However, if I use ssh to access the server, stop an application,
and then start the application again, the application will run with the
label sshd_t.  I haven't tried starting a confined application from a local
console but I'll probably encounter a similar problem.  How should I modify
the policy to allow a confined user to execute an application but  also have
the application run in the application's confined domain?

 

Kim

 


------=_NextPart_000_026B_01CF4D91.0E135B60
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 14 (filtered =
medium)"><style><!--
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoNormal>Hi,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I&#8217;m =
pretty sure my questions are basic SELinux 101 but I&#8217;m having a =
problem confining an application when a user runs the application =
directly.&nbsp; On our system I have removed the unconfined domain and =
unconfined user.&nbsp; When the system initializes the confined =
applications run in the correct confined domains.&nbsp; However, if I =
use ssh to access the server, stop an application, and then start the =
application again, the application will run with the label sshd_t.&nbsp; =
I haven&#8217;t tried starting a confined application from a local =
console but I&#8217;ll probably encounter a similar problem.&nbsp; How =
should I modify the policy to allow a confined user to execute an =
application but&nbsp; also have the application run in the =
application&#8217;s confined domain?<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Kim<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_000_026B_01CF4D91.0E135B60--
