Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o06MYsi0026705
	for <selinux@tycho.nsa.gov>; Wed, 6 Jan 2010 17:34:54 -0500
Received: from xmrt0101.northgrum.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o06MbU59007708
	for <selinux@tycho.nsa.gov>; Wed, 6 Jan 2010 22:37:31 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA8F20.75B80002"
Subject: Security Context Type Changes
Date: Wed, 6 Jan 2010 16:34:49 -0600
Message-ID: <822A6B57FFD31647BB62F4676394C675033C6473@XMBTX131.northgrum.com>
From: "Tomas, Gregg A (IS)" <Gregg.Tomas@ngc.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA8F20.75B80002
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi

=20

We are currently integrating our SELinux Policy on a RHEL5 machine.
However, we are having difficulty in restricting our application within
a specific directory because "something" changes our security context
type of our users to init_t instead of unconfined_t. Root gets changed
to (i.e. <user>:<role>:init_t). We are running with init level 4. We
must have tried everything in the book to determine what changes the
security context type of our users. Would anyone have any tips?

=20

We did change inittab to run init level 5, touch /.autorelabel,
rebooted, checked id -Z  and it is unconfined_t. However, ultimately we
would like to run with init 4.

=20

Thanks in advance.


------_=_NextPart_001_01CA8F20.75B80002
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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

<p class=3DMsoNormal>Hi<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>We are currently integrating our SELinux Policy on =
a RHEL5
machine. However, we are having difficulty in restricting our =
application within
a specific directory because &#8220;something&#8221; changes our =
security
context type of our users to init_t instead of unconfined_t. Root gets =
changed
to (i.e. &lt;user&gt;:&lt;role&gt;:init_t). We are running with init =
level 4.
We must have tried everything in the book to determine what changes the
security context type of our users. Would anyone have any =
tips?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>We did change inittab to run init level 5, touch
/.autorelabel, rebooted, checked id &#8211;Z &nbsp;and it is =
unconfined_t.
However, ultimately we would like to run with init 4.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks in advance.<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01CA8F20.75B80002--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
