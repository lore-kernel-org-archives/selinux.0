Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAHELbt8013983
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 09:21:37 -0500
Received: from xmrc0101.northgrum.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nAHENfSO018377
	for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2009 14:23:41 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA6791.3E7A4FFE"
Subject: RE: Windows-level enforcement in SELinux?
Date: Tue, 17 Nov 2009 08:21:24 -0600
Message-ID: <834B41F71BFB1D4385FC5E62CF526DCE01C59D23@XMBIL123.northgrum.com>
In-Reply-To: <834B41F71BFB1D4385FC5E62CF526DCE01C59D17@XMBIL123.northgrum.com>
References: <834B41F71BFB1D4385FC5E62CF526DCE01C59D17@XMBIL123.northgrum.com>
From: "Dyson, Mark L (IS)" <Mark.Dyson@ngc.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA6791.3E7A4FFE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'll narrow the scope of my initial question a bit, here:  can SELinux
support this sort of operation?  Some online literature seems to suggest
otherwise but it's admittedly a few years old.

=20

Thanks again,

Mark

=20

From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Dyson, Mark L (IS)
Sent: Monday, November 16, 2009 10:09 AM
To: selinux@tycho.nsa.gov
Subject: Windows-level enforcement in SELinux?

=20

Hello,

I've been tasked to map out a path for migrating a MLS application from
Trusted Solaris to SELinux.  I'm sure I'll have many questions to come,
but after some initial readings one of my first is:

How does SELinux label individual X-windows in a user session, so that
(for example) data contained in a high-level security window cannot be
copied and then pasted into a lower-level security window?

Thanks in advance!
Mark


------_=_NextPart_001_01CA6791.3E7A4FFE
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<title>Windows-level enforcement in SELinux?</title>
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'>I&#8217;ll narrow the scope of my initial question a bit, =
here:&nbsp; can
SELinux support this sort of operation?&nbsp; Some online literature =
seems to
suggest otherwise but it&#8217;s admittedly a few years =
old.<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'>Thanks again,<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'>Mark<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt =
0in 0in 0in'>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span>=
</b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>
owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] <b>On =
Behalf
Of </b>Dyson, Mark L (IS)<br>
<b>Sent:</b> Monday, November 16, 2009 10:09 AM<br>
<b>To:</b> selinux@tycho.nsa.gov<br>
<b>Subject:</b> Windows-level enforcement in =
SELinux?<o:p></o:p></span></p>

</div>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p><span =
style=3D'font-family:"Calibri","sans-serif"'>Hello,</span><o:p></o:p></p>=


<p><span style=3D'font-family:"Calibri","sans-serif"'>I&#8217;ve been =
tasked to map out
a path for migrating a MLS application from Trusted Solaris to =
SELinux.&nbsp;
I&#8217;m sure I&#8217;ll have many questions to come, but after some =
initial readings one
of my first is:</span><o:p></o:p></p>

<p><span style=3D'font-family:"Calibri","sans-serif"'>How does SELinux =
label
individual</span> <span =
style=3D'font-family:"Calibri","sans-serif"'>X-windows</span>
<span style=3D'font-family:"Calibri","sans-serif"'>in a user session, so =
that
(for example) data contained in a high-level security window cannot be =
copied
and then pasted into a lower-level security =
window?</span><o:p></o:p></p>

<p><span style=3D'font-family:"Calibri","sans-serif"'>Thanks in =
advance!<br>
Mark</span><o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01CA6791.3E7A4FFE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
