Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA15444
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 14:58:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA12237
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 18:57:22 GMT
Received: from gull.mail.pas.earthlink.net (gull.mail.pas.earthlink.net [207.217.120.84])
        by jazzband.ncsc.mil  with ESMTP id SAA12233 for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 18:57:22 GMT
Received: from crtntx1-ar7-4-35-055-073.crtntx1.elnk.dsl.genuity.net ([4.35.55.73] helo=donkey)
	by gull.mail.pas.earthlink.net with esmtp (Exim 3.33 #1)
	id 17UXX2-00048u-00
	for selinux@tycho.nsa.gov; Tue, 16 Jul 2002 11:58:45 -0700
From: "Ryan Bergauer" <privateryan@mindspring.com>
To: <selinux@tycho.nsa.gov>
Subject: user mount permissions
Date: Tue, 16 Jul 2002 13:58:44 -0500
Message-ID: <000001c22cfa$cf985bb0$0300a8c0@donkey>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C22CD0.E6C253B0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C22CD0.E6C253B0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

I'm want to allow users to be able to mount an encrypted directory in
their home directory. Unfortunately, this requires allowing normal users
to transition into mount_t via a mount executable, which I think would
be wise to avoid. Is there a good way to allow users to mount only a
certain type, say user_home_t (or in my case, crypt_home_t)? Thanks!

------=_NextPart_000_0001_01C22CD0.E6C253B0
Content-Type: text/html;
	charset="US-ASCII"
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C22CD0.E5EDECB0">
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
font-family:Arial'>I&#8217;m <span class=3DGramE>want</span> to allow =
users to be
able to mount an encrypted directory in their home directory. =
Unfortunately,
this requires allowing normal users to transition into <span =
class=3DSpellE>mount_t</span>
via a mount executable, which I think would be wise to avoid. Is there a =
good
way to allow users to mount only a certain type, say <span =
class=3DSpellE>user_home_t</span>
(or in my case, <span class=3DSpellE>crypt_home_t</span>)? =
Thanks!<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01C22CD0.E6C253B0--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
