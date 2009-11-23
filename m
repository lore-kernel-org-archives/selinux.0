Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nANDbUik032475
	for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2009 08:37:30 -0500
Received: from xmrm0101.northgrum.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nANDaQCP019551
	for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2009 13:36:26 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA6C42.182DDB4E"
Subject: RE: MLS support for RHEL5?
Date: Mon, 23 Nov 2009 07:37:26 -0600
Message-ID: <834B41F71BFB1D4385FC5E62CF526DCE01C59D45@XMBIL123.northgrum.com>
In-Reply-To: <170D6ABBBA770349AA49582A86FCED1536F664@HAVOC.tcs-sec.com>
References: <834B41F71BFB1D4385FC5E62CF526DCE01C59D43@XMBIL123.northgrum.com> <170D6ABBBA770349AA49582A86FCED1536F663@HAVOC.tcs-sec.com> <834B41F71BFB1D4385FC5E62CF526DCE01C59D44@XMBIL123.northgrum.com> <170D6ABBBA770349AA49582A86FCED1536F664@HAVOC.tcs-sec.com>
From: "Dyson, Mark L (IS)" <Mark.Dyson@ngc.com>
To: <chanson@TrustedCS.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA6C42.182DDB4E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Chad,

=20

Again, many thanks!  I'll start there.

=20

Mark

=20

From: chanson@TrustedCS.com [mailto:chanson@TrustedCS.com]=20
Sent: Monday, November 23, 2009 8:30 AM
To: Dyson, Mark L (IS); selinux@tycho.nsa.gov
Subject: RE: MLS support for RHEL5?

=20

=20

One of the key components in the lspp rpm is the Configuration Guide.
This describes the manner in which you should install RHEL 5 and mostly
isn't hardware specific. The SGI document is for RHEL 5.1. I would
probably start with that. The Dell version should be for 5.3, but I
cannot say for sure.

-Chad

-----Original Message-----
From: Dyson, Mark L (IS) [mailto:Mark.Dyson@ngc.com]
Sent: Mon 11/23/2009 8:17 AM
To: Chad Hanson; selinux@tycho.nsa.gov
Subject: RE: MLS support for RHEL5?

Chad,



Many thanks!  The download link seems to be divided into Dell, HP, IBM
and SGI.  The machine I'm using is a SunFire X2200 (AMD processors).
I'm not sure which of the four available would be the closest match.



Mark



From: chanson@TrustedCS.com [mailto:chanson@TrustedCS.com]
Sent: Monday, November 23, 2009 8:11 AM
To: Dyson, Mark L (IS); selinux@tycho.nsa.gov
Subject: RE: MLS support for RHEL5?



Hi Mark,

MLS is supported in RHEL 5 and been validated against the Common
Criteria in this configuration as well. See the links below.

http://www.niap-ccevs.org/st/vid10125/
http://www.niap-ccevs.org/st/vid10165/
http://www.niap-ccevs.org/st/vid10286/

The supporting software is available for the configuration is available
from Red Hat.
http://ftp.redhat.com/pub/redhat/linux/eal/EAL4_RHEL5/

Cheers,
-Chad


-----Original Message-----
From: owner-selinux@tycho.nsa.gov on behalf of Dyson, Mark L (IS)
Sent: Mon 11/23/2009 7:54 AM
To: selinux@tycho.nsa.gov
Subject: MLS support for RHEL5?

For the project I'm working on the goal is to run a MLS application in a
classified environment and the target architecture is Red Hat Enterprise
Linux 5.  According to the Mayer/MacMillan/Caplan book MLS isn't
supported as of RHEL4.  Can anyone tell me whether that has been
resolved somewhat in RHEL5?  Is there a path to implementing MLS in that
distribution?

Thanks in advance for your help, the information I'm able to turn up
seems dated at best.

Mark






------_=_NextPart_001_01CA6C42.182DDB4E
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
<title>RE: MLS support for RHEL5?</title>
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
color:#1F497D'>Chad,<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'>Again, many thanks!&nbsp; I&#8217;ll start =
there.<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

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
chanson@TrustedCS.com [mailto:chanson@TrustedCS.com] <br>
<b>Sent:</b> Monday, November 23, 2009 8:30 AM<br>
<b>To:</b> Dyson, Mark L (IS); selinux@tycho.nsa.gov<br>
<b>Subject:</b> RE: MLS support for RHEL5?<o:p></o:p></span></p>

</div>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p style=3D'margin-bottom:12.0pt'><span style=3D'font-size:10.0pt'>One =
of the key
components in the lspp rpm is the Configuration Guide. This describes =
the
manner in which you should install RHEL 5 and mostly isn't hardware =
specific.
The SGI document is for RHEL 5.1. I would probably start with that. The =
Dell
version should be for 5.3, but I cannot say for sure.<br>
<br>
-Chad<br>
<br>
-----Original Message-----<br>
From: Dyson, Mark L (IS) [<a =
href=3D"mailto:Mark.Dyson@ngc.com">mailto:Mark.Dyson@ngc.com</a>]<br>
Sent: Mon 11/23/2009 8:17 AM<br>
To: Chad Hanson; selinux@tycho.nsa.gov<br>
Subject: RE: MLS support for RHEL5?<br>
<br>
Chad,<br>
<br>
<br>
<br>
Many thanks!&nbsp; The download link seems to be divided into Dell, HP, =
IBM<br>
and SGI.&nbsp; The machine I'm using is a SunFire X2200 (AMD =
processors).<br>
I'm not sure which of the four available would be the closest match.<br>
<br>
<br>
<br>
Mark<br>
<br>
<br>
<br>
From: chanson@TrustedCS.com [<a =
href=3D"mailto:chanson@TrustedCS.com">mailto:chanson@TrustedCS.com</a>]<b=
r>
Sent: Monday, November 23, 2009 8:11 AM<br>
To: Dyson, Mark L (IS); selinux@tycho.nsa.gov<br>
Subject: RE: MLS support for RHEL5?<br>
<br>
<br>
<br>
Hi Mark,<br>
<br>
MLS is supported in RHEL 5 and been validated against the Common<br>
Criteria in this configuration as well. See the links below.<br>
<br>
<a =
href=3D"http://www.niap-ccevs.org/st/vid10125/">http://www.niap-ccevs.org=
/st/vid10125/</a><br>
<a =
href=3D"http://www.niap-ccevs.org/st/vid10165/">http://www.niap-ccevs.org=
/st/vid10165/</a><br>
<a =
href=3D"http://www.niap-ccevs.org/st/vid10286/">http://www.niap-ccevs.org=
/st/vid10286/</a><br>
<br>
The supporting software is available for the configuration is =
available<br>
from Red Hat.<br>
<a =
href=3D"http://ftp.redhat.com/pub/redhat/linux/eal/EAL4_RHEL5/">http://ft=
p.redhat.com/pub/redhat/linux/eal/EAL4_RHEL5/</a><br>
<br>
Cheers,<br>
-Chad<br>
<br>
<br>
-----Original Message-----<br>
From: owner-selinux@tycho.nsa.gov on behalf of Dyson, Mark L (IS)<br>
Sent: Mon 11/23/2009 7:54 AM<br>
To: selinux@tycho.nsa.gov<br>
Subject: MLS support for RHEL5?<br>
<br>
For the project I'm working on the goal is to run a MLS application in =
a<br>
classified environment and the target architecture is Red Hat =
Enterprise<br>
Linux 5.&nbsp; According to the Mayer/MacMillan/Caplan book MLS =
isn't<br>
supported as of RHEL4.&nbsp; Can anyone tell me whether that has =
been<br>
resolved somewhat in RHEL5?&nbsp; Is there a path to implementing MLS in =
that<br>
distribution?<br>
<br>
Thanks in advance for your help, the information I'm able to turn up<br>
seems dated at best.<br>
<br>
Mark<br>
<br>
<br>
<br>
</span><o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01CA6C42.182DDB4E--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
