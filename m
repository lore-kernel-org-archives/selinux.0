Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA00493
	for <selinux@tycho.nsa.gov>; Thu, 18 Jul 2002 17:02:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA24626
	for <selinux@tycho.nsa.gov>; Thu, 18 Jul 2002 21:01:22 GMT
Received: from albatross.prod.itd.earthlink.net (albatross.mail.pas.earthlink.net [207.217.120.120])
        by jazzband.ncsc.mil  with ESMTP id VAA24616 for <selinux@tycho.nsa.gov>; Thu, 18 Jul 2002 21:01:21 GMT
Received: from crtntx1-ar7-4-35-055-079.crtntx1.elnk.dsl.genuity.net ([4.35.55.79] helo=donkey)
	by albatross.prod.itd.earthlink.net with esmtp (Exim 3.33 #1)
	id 17VIQA-0001Tk-00
	for selinux@tycho.nsa.gov; Thu, 18 Jul 2002 14:02:46 -0700
From: "Ryan Bergauer" <privateryan@mindspring.com>
To: <selinux@tycho.nsa.gov>
Subject: tripwire
Date: Thu, 18 Jul 2002 16:02:46 -0500
Message-ID: <000501c22e9e$7807c200$0300a8c0@donkey>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0006_01C22E74.8F31BA00"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0006_01C22E74.8F31BA00
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

I just installed Tripwire on my SELinux play box. I have no problem
doing an integrity check when I'm logged in as root and newroled into
sysadm_r. However, the default system cron job for integrity checking
fails miserably because system_crond_t isn't granted the permissions
necessary to check and sign most files on my system (and with good
reason.) My first thought was to create a domain just for Tripwire, but
unfortunately, the fact that Tripwire needs access to just about every
file type on the disk results in a domain that not only would take quite
some time to create, but would also require a fair degree of
maintenance. Creating a cron job run by a user also appears out of the
question, since my sysadm has no root access, and root runs user_crond_t
cron jobs by default (which I feel would be wise to keep that way.)
 
Either I'm overlooking something (very likely) or I'm going to have to
suck it up and write that Tripwire domain. Any suggestions? If the
Tripwire domain is the answer, are there any good ways to give it a
large number of privileges very quickly?
 
Thanks in advance - you guys are a huge help! I appreciate you bearing
with those of us still getting used to this.
-Ryan

------=_NextPart_000_0006_01C22E74.8F31BA00
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C22E74.8E4F9760">
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
font-family:Arial'>I just installed Tripwire on my <span =
class=3DSpellE>SELinux</span>
play box. I have no problem doing an integrity check when I&#8217;m =
logged in
as root and <span class=3DSpellE>newroled</span> into <span =
class=3DSpellE>sysadm_r</span>.
However, the default system <span class=3DSpellE>cron</span> job for =
integrity
checking fails miserably because <span =
class=3DSpellE>system_crond_t</span> isn&#8217;t
granted the permissions necessary to check and sign most files on my =
system
(and with good reason.) My first thought was to create a domain just for
Tripwire, but unfortunately, the fact that Tripwire needs access to just =
about
every file type on the disk results in a domain that not only would take =
quite
some time to create, but would also require a fair degree of =
maintenance. Creating
a <span class=3DSpellE>cron</span> job run by a user also appears out of =
the
question, since my <span class=3DSpellE>sysadm</span> has no root =
access, and
root runs <span class=3DSpellE>user_crond_t</span> <span =
class=3DSpellE>cron</span>
jobs by default (which I feel would be wise to keep that =
way.)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Either I&#8217;m overlooking something (very likely) =
or I&#8217;m
going to have to suck it up and write that Tripwire domain. <span =
class=3DGramE>Any
suggestions?</span> If the Tripwire domain is the answer, are there any =
good
ways to give it a large number of privileges very =
quickly?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks in advance &#8211; you guys are a huge help! I
appreciate you bearing with those of us still getting used to =
this&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-Ryan<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0006_01C22E74.8F31BA00--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
