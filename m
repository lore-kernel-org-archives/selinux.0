Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA13207
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 17:35:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA15984
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 21:34:47 GMT
Received: from pintail.mail.pas.earthlink.net (pintail.mail.pas.earthlink.net [207.217.120.122])
	by jazzswing.ncsc.mil  with ESMTP id VAA15980
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 21:34:46 GMT
Received: from crtntx1-ar7-4-35-055-009.crtntx1.elnk.dsl.genuity.net ([4.35.55.9] helo=donkey)
	by pintail.mail.pas.earthlink.net with esmtp (Exim 3.33 #1)
	id 17bpVr-0004Bn-00
	for selinux@tycho.nsa.gov; Mon, 05 Aug 2002 14:35:39 -0700
From: "Ryan Bergauer" <privateryan@mindspring.com>
To: <selinux@tycho.nsa.gov>
Subject: CVS tree make error
Date: Mon, 5 Aug 2002 16:35:43 -0500
Message-ID: <001701c23cc8$0dcc6520$0300a8c0@donkey>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0018_01C23C9E.24F65D20"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0018_01C23C9E.24F65D20
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Just as a heads up, when I make selinux/utils from the current CVS tree
I get:
 
Making all in po
make[3]: Entering directory `/usr/src/selinux/utils/tar-1.13.19/po'
file=./`echo ko | sed 's,.*/,,'`.gmo \
  && rm -f $file && PATH=../src:$PATH /usr/bin/msgfmt -o $file ko.po
ko.po:1431:17: invalid multibyte sequence
ko.po:1434:6: invalid multibyte sequence
/usr/bin/msgfmt: found 2 fatal errors
make[3]: *** [ko.gmo] Error 1
 
This is on a barebones Red Hat 7.3 install. The July 3 release doesn't
give this error.
 
-Ryan 
 

------=_NextPart_000_0018_01C23C9E.24F65D20
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C23C9E.24299740">
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
font-family:Arial'>Just as a heads up, when I make <span =
class=3DSpellE>selinux/utils</span>
from the current CVS tree I get:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Making all in <span =
class=3DSpellE>po</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>make[</span></font></span><f=
ont
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>3]: Entering
directory =
`/usr/src/selinux/utils/tar-1.13.19/po&#8217;<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>file</span></font></span><fo=
nt
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>=3D./`echo <span
class=3DSpellE>ko</span> | <span class=3DSpellE>sed</span> =
&#8216;s,.*/,,&#8217;`.<span
class=3DSpellE>gmo</span> \<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><span style=3D'mso-spacerun:yes'>&nbsp; =
</span>&amp;&amp; <span
class=3DSpellE>rm</span> &#8211;f $file &amp;&amp; PATH=3D<span =
class=3DGramE>..</span>/<span
class=3DSpellE>src<span class=3DGramE>:$</span>PATH</span> /<span =
class=3DSpellE>usr/bin/msgfmt</span>
&#8211;o $file <span =
class=3DSpellE>ko.po</span><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ko.po:1431:17: invalid <span =
class=3DSpellE>multibyte</span>
sequence<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ko.po:1434:6: invalid <span =
class=3DSpellE>multibyte</span>
sequence<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/<span class=3DSpellE>usr/bin/msgfmt</span>: found 2 =
fatal
errors<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>make[</span></font></span><f=
ont
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>3]: *** [<span
class=3DSpellE>ko.gmo</span>] Error 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>This is on a barebones Red Hat 7.3 install. The July =
3
release doesn&#8217;t give this error.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-Ryan <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0018_01C23C9E.24F65D20--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
