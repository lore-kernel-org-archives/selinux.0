Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lASKN3FD017117
	for <selinux@tycho.nsa.gov>; Wed, 28 Nov 2007 15:23:06 -0500
Received: from dmzmta103.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lASKN2DW025918
	for <selinux@tycho.nsa.gov>; Wed, 28 Nov 2007 20:23:02 GMT
Received: from BLUMS0034.bluelnk.net (blums0034.bluelnk.net [10.40.96.55])
	by dmzmta103.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id lASKKQWf013918
	for <selinux@tycho.nsa.gov>; Wed, 28 Nov 2007 15:20:26 -0500
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta001.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id lASKJsEr012107
	for <selinux@tycho.nsa.gov>; Wed, 28 Nov 2007 15:19:55 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C831FC.72B2312F"
Subject: RE: newrole polyinstantiation
Date: Wed, 28 Nov 2007 12:22:50 -0800
Message-ID: <436A69503F99214D9EBC27415F66C40C0F37C565@blums0008.bluelnk.net>
References: <436A69503F99214D9EBC27415F66C40C0F37C51A@blums0008.bluelnk.net>
From: "Reed, Tim \(US SSA\)" <tim.reed@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C831FC.72B2312F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

NEVERMIND

=20

It was pam_ldap that is causing the Broken Pipe.   Sorry to bother
everyone.

=20

  _____ =20

From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Reed, Tim (US SSA)
Sent: Wednesday, November 28, 2007 2:46 PM
To: selinux@tycho.nsa.gov
Subject: newrole polyinstantiation

=20

I have the new newrole (policycoreutils-1.34.11) working with
polyinstantiation using pam_namespace.  The problem that I am seeing is
that when I log out of the newrole I get a "Broken pipe".   Now my
assumption is that this is coming from newrole but I am not sure. =20

=20

My config is as follows:

OS - CentOS5

Policy - refpolicy-targeted-mls

Enforce - permissive

newrole - 1.34.11 with namespace patch
(http://www.nsa.gov/selinux/list-archive/0705/20613.cfm#options2)

=20

namespace.conf

/tmp                  /tmp-inst/                      level
root,adm

=20

namespace.init

exit 0

=20

newrole (pam)

auth....

account....

password....

session   required  pam_namespace.so unmnt_remnt no_unmount_on_close
debug

session ...

session ...

=20

TIA,

Tim


------_=_NextPart_001_01C831FC.72B2312F
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>NEVERMIND<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>It was pam_ldap that is causing the Broken Pipe.&nbsp;&nbsp; =
Sorry to bother
everyone.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> =
owner-selinux@tycho.nsa.gov
[mailto:owner-selinux@tycho.nsa.gov] <b><span =
style=3D'font-weight:bold'>On
Behalf Of </span></b>Reed, Tim (US SSA)<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Wednesday, November =
28, 2007
2:46 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
selinux@tycho.nsa.gov<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> newrole =
polyinstantiation</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have the new newrole (policycoreutils-1.34.11) =
working
with polyinstantiation using pam_namespace.&nbsp; The problem that I am =
seeing
is that when I log out of the newrole I get a &#8220;Broken
pipe&#8221;.&nbsp;&nbsp; Now my assumption is that this is coming from =
newrole
but I am not sure.&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>My config is as follows:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>OS - CentOS5<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Policy &#8211; =
refpolicy-targeted-mls<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Enforce - permissive<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>newrole &#8211; 1.34.11 with namespace patch
(http://www.nsa.gov/selinux/list-archive/0705/20613.cfm#options2)<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>namespace.conf<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/tmp
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
/tmp-inst/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
level &nbsp;&nbsp;&nbsp;&nbsp; root,adm<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>namespace.init<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>exit 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>newrole (pam)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>auth&#8230;.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>account&#8230;.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>password&#8230;.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>session &nbsp;&nbsp;required&nbsp; pam_namespace.so
unmnt_remnt no_unmount_on_close debug<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>session &#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>session &#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>TIA,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Tim<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C831FC.72B2312F--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
