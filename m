Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA20409
	for <selinux@tycho.nsa.gov>; Mon, 1 Jul 2002 17:10:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA26755
	for <selinux@tycho.nsa.gov>; Mon, 1 Jul 2002 21:09:54 GMT
Received: from scaup.mail.pas.earthlink.net (scaup.mail.pas.earthlink.net [207.217.120.49])
	by jazzswing.ncsc.mil  with ESMTP id VAA26746
	for <selinux@tycho.nsa.gov>; Mon, 1 Jul 2002 21:09:53 GMT
Received: from crtntx1-ar7-4-35-055-006.crtntx1.elnk.dsl.genuity.net ([4.35.55.6] helo=donkey)
	by scaup.mail.pas.earthlink.net with esmtp (Exim 3.33 #1)
	id 17P8Qx-00012h-00
	for selinux@tycho.nsa.gov; Mon, 01 Jul 2002 17:10:07 -0400
From: "Ryan Bergauer" <privateryan@mindspring.com>
To: <selinux@tycho.nsa.gov>
Subject: problems with mount
Date: Mon, 1 Jul 2002 16:10:07 -0500
Message-ID: <000501c22143$ad74beb0$6501a8c0@donkey>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0006_01C22119.C49EB6B0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0006_01C22119.C49EB6B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I'm having problems with mount. Before I issue a mount command,
/mnt/cdrom is of type file_t. Immediately after running mount,
/mnt/cdrom is labeled as unlabeled_t. Is that supposed to happen? That
causes no end to problems in getting data from a CD in enforcing mode,
if I'm correct.
 
-Ryan
 
 

------=_NextPart_000_0006_01C22119.C49EB6B0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C22119.C3ED6810">
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m having problems with mount. Before I issue =
a mount
command, /<span class=3DSpellE>mnt/cdrom</span> is of type <span =
class=3DSpellE>file_t</span>.
<span class=3DGramE>Immediately</span> after running mount, /<span =
class=3DSpellE>mnt/cdrom</span>
is labeled as <span class=3DSpellE>unlabeled_t</span>. Is that supposed =
to
happen? That causes no end to problems in getting data from a CD in =
enforcing
mode, if I&#8217;m correct&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-Ryan<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span =
style=3D'mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0006_01C22119.C49EB6B0--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
