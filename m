Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA24916
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 20:37:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA00854
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 00:36:04 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
        by jazzband.ncsc.mil  with ESMTP id AAA00850 for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 00:36:03 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Ryan Bergauer'" <privateryan@mindspring.com>, <selinux@tycho.nsa.gov>
Subject: RE: quota and ampd
Date: Mon, 8 Jul 2002 20:37:24 -0400
Message-ID: <004501c226e0$cb949f80$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0046_01C226BF.4482FF80"
In-Reply-To: <000401c226ca$7a507e20$6501a8c0@donkey>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0046_01C226BF.4482FF80
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,
 
Quota is one of the packages I was working on over the weekend.  I did
get some messages as well but I had more probs w/ version 2 of quota and
have not finished playing with it yet.
 
You can run newrule -d -v to get the syntax that's needed.
 
Ed
 
-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Ryan Bergauer
Sent: Monday, July 08, 2002 5:58 PM
To: selinux@tycho.nsa.gov
Subject: quota and ampd
 
I just installed the new release of SELinux, and I get about 7 messages
at boot-time requesting different permissions for quotaon, per the
following:
 
avc:   denied   { read } for  pid=141 exe=/sbin/quotaon
path=/usr/lib/locale/en_US.iso885915/LC_IDENTIFICATION dev=03:02
ino=1289283 scontext=system_u:system_r:quota_t
tcontext=system_u:object_r:writeable_t tclass=file
 
That wasn't there before the new release, and my kernel configuration
should've been the same. Anyone else getting this?
 
In addition, I'm getting quite a few denied messages at boot and
shutdown regarding killall5 when I enable Advanced Power Management Bios
in the kernel (with apmd_t wanting read-type permissions for items in
init_t and kernel_t.) This sound familiar to anyone else? Please note
that this was occurring before the new release, I just never got around
to confronting it until now.
 
Thanks!
-Ryan

------=_NextPart_000_0046_01C226BF.4482FF80
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
<link rel=3DFile-List href=3D"cid:filelist.xml@01C226BF.442A5830">
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
	{mso-style-type:personal;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:navy;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:navy;}
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

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Quota is one of the packages I was =
working
on over the weekend.<span style=3D'mso-spacerun:yes'>&nbsp; </span>I did =
get some
messages as well but I had more probs w/ version 2 of quota and have not
finished playing with it yet.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>You can run newrule &#8211;d =
&#8211;v to
get the syntax that&#8217;s needed.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Ed<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'>-----Original =
Message-----<br>
<b><span style=3D'font-weight:bold'>From:</span></b> =
owner-selinux@tycho.nsa.gov
[mailto:owner-selinux@tycho.nsa.gov] <b><span =
style=3D'font-weight:bold'>On
Behalf Of </span></b>Ryan Bergauer<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> =
</span></font><st1:date
Month=3D"7" Day=3D"8" Year=3D"2002"><font size=3D2 face=3DTahoma><span =
style=3D'font-size:
 10.0pt;font-family:Tahoma'>Monday, July 08, =
2002</span></font></st1:date><font
size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;font-family:Tahoma'> </span></font><st1:time
Hour=3D"17" Minute=3D"58"><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
 font-family:Tahoma'>5:58 PM</span></font></st1:time><font size=3D2 =
face=3DTahoma><span
style=3D'font-size:10.0pt;font-family:Tahoma'><br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
selinux@tycho.nsa.gov<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> quota and =
ampd</span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D3 =
face=3D"Times New Roman"><span
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>I just installed the new =
release of
SELinux, and I get about 7 messages at boot-time requesting different
permissions for quotaon, per the following:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>avc:<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>denied<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>{ read } for<span
style=3D'mso-spacerun:yes'>&nbsp; </span>pid=3D141 exe=3D/sbin/quotaon
path=3D/usr/lib/locale/en_US.iso885915/LC_IDENTIFICATION =
dev=3D</span></font><st1:time
Hour=3D"15" Minute=3D"2"><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
 font-family:Arial'>03:02</span></font></st1:time><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'> ino=3D1289283
scontext=3Dsystem_u:system_r:quota_t =
tcontext=3Dsystem_u:object_r:writeable_t
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>That wasn&#8217;t there =
before the
new release, and my kernel configuration should&#8217;ve been the same. =
Anyone
else getting this?<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>In addition, I&#8217;m =
getting quite
a few denied messages at boot and shutdown regarding killall5 when I =
enable
Advanced Power Management Bios in the kernel (with apmd_t wanting =
read-type
permissions for items in init_t and kernel_t.) This sound familiar to =
anyone
else? Please note that this was occurring before the new release, I just =
never
got around to confronting it until now.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Thanks!<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>-Ryan<o:p></o:p></span></fon=
t></p>

</div>

</body>

</html>

------=_NextPart_000_0046_01C226BF.4482FF80--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
