Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA19070
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 18:00:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA25814
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 21:58:54 GMT
Received: from hawk.mail.pas.earthlink.net (hawk.mail.pas.earthlink.net [207.217.120.22])
        by jazzband.ncsc.mil  with ESMTP id VAA25810 for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 21:58:54 GMT
Received: from crtntx1-ar7-4-35-055-009.crtntx1.elnk.dsl.genuity.net ([4.35.55.9] helo=donkey)
	by hawk.mail.pas.earthlink.net with esmtp (Exim 3.33 #1)
	id 17dHo4-00030b-00
	for selinux@tycho.nsa.gov; Fri, 09 Aug 2002 15:00:28 -0700
From: "Ryan Bergauer" <privateryan@mindspring.com>
To: <selinux@tycho.nsa.gov>
Subject: RE: problems with fd
Date: Fri, 9 Aug 2002 17:00:29 -0500
Message-ID: <001601c23ff0$2d51ed40$0300a8c0@donkey>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0017_01C23FC6.447BE540"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0017_01C23FC6.447BE540
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I take that back, I did upgrade from 1.06 to 1.07 since then. That would
appear to have triggered this. 
 
-----Original Message-----
From: Ryan Bergauer [mailto:privateryan@mindspring.com] 
Sent: Friday, August 09, 2002 4:49 PM
To: 'selinux@tycho.nsa.gov'
Subject: problems with fd
 
I'm getting a particular denied message in quite a few places.
 
The scontext is always the program's context, as in
user_name:user_r:user_gpg_t.
The tcontext is how I got my current role, as in
user_name:sysadm_r:newrole_t or system_u:system_r:local_login_t.
It's denying the use of fd.
 
This just popped up - I know I've used GPG before, but never had this
error. Any suggestions?
 
-Ryan 

------=_NextPart_000_0017_01C23FC6.447BE540
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C23FC6.43B6E790">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"time"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"date"/>
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
</xml><![endif]--><!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:553679495 -2147483648 8 0 66047 0;}
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
	{mso-style-type:personal;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:navy;}
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
font-family:Arial'>I take that back, I did upgrade from 1.06 to 1.07 =
since
then. That would appear to have triggered this. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'>-----Original =
Message-----<br>
<b><span style=3D'font-weight:bold'>From:</span></b> Ryan Bergauer
[mailto:privateryan@mindspring.com<span class=3DGramE>] <br>
<b><span style=3D'font-weight:bold'>Sent</span></b></span><b><span
style=3D'font-weight:bold'>:</span></b> </span></font><st1:date =
Month=3D"8" Day=3D"9"
Year=3D"2002"><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;font-family:
 Tahoma'>Friday, August 09, 2002</span></font></st1:date><font size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> =
</span></font><st1:time
Hour=3D"16" Minute=3D"49"><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
 font-family:Tahoma'>4:49 PM</span></font></st1:time><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'><br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
'selinux@tycho.nsa.gov'<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> problems with =
<span
class=3DGramE>fd</span></span></font><o:p></o:p></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>I&#8217;m getting a =
particular
denied message in quite a few places.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>The scontext is always the
program&#8217;s context, as in =
user_name:user_r:user_gpg_t.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>The tcontext is how I got =
my current
role, as in user_name:sysadm_r:newrole_t or =
system_u:system_r:local_login_t.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>It&#8217;s denying the use =
of <span
class=3DGramE>fd</span>.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>This just popped up &#8211; =
I know
I&#8217;ve used GPG before, but never had this error. <span =
class=3DGramE>Any
suggestions?</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>-Ryan =
<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0017_01C23FC6.447BE540--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
