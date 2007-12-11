Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBBFLlKb003141
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 10:21:47 -0500
Received: from dmzmta102.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBBFLjHI017317
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 15:21:45 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id lBBFJBdV019047
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 10:19:11 -0500
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta003.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id lBBFJiW6008445
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 10:19:48 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C83C09.78ACE2AC"
Subject: newrole in the background
Date: Tue, 11 Dec 2007 07:21:15 -0800
Message-ID: <436A69503F99214D9EBC27415F66C40C0F517115@blums0008.bluelnk.net>
From: "Reed, Tim \(US SSA\)" <tim.reed@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C83C09.78ACE2AC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am currently running RHEL 5 update 1 with the MLS policy. =20

=20

The issue that I am now having is that in our code we switched over from
using runcon to newrole.  The newrole command is executed from within
our application that is running in the background, so no TTY.  Which is
the problem. =20

=20

Newrole bombs because there is no tty, the call that "fails" is
ttyname(0). =20

=20

Any suggestions on a workaround or fix?

=20

I have created a test set of scripts to duplicate the issue

=20

foo.sh

##########################

#!/bin/bash

=20

#show the current tty name

printf "caller tty: "

tty

=20

./bar.sh &

=20

##########################

=20

bar.sh

##########################

#!/bin/bash

=20

#show the current tty name

printf "newrole tty: "

tty

=20

newrole -l SystemHigh -- -c "ls /var"

=20

##########################

=20

Thanks,

Tim


------_=_NextPart_001_01C83C09.78ACE2AC
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am currently running RHEL 5 update 1 with the MLS
policy.&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The issue that I am now having is that in our code we
switched over from using runcon to newrole.&nbsp; The newrole command is
executed from within our application that is running in the background, =
so no
TTY.&nbsp; Which is the problem.&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Newrole bombs because there is no tty, the call that =
&#8220;fails&#8221;
is ttyname(0).&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any suggestions on a workaround or =
fix?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have created a test set of scripts to duplicate the =
issue<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<div =
style=3D'mso-element:para-border-div;border:none;border-bottom:solid =
windowtext 1.0pt;
padding:0in 0in 26.0pt 0in'>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>foo.sh<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>##########################<o=
:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>#!/bin/bash<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>#show the current tty =
name<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>printf &#8220;caller tty: =
&#8220;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>tty<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>./bar.sh =
&amp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>##########################<o=
:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>bar.sh<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>##########################<o=
:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>#!/bin/bash<o:p></o:p></span=
></font></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>#show the current tty =
name<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>printf &#8220;newrole tty: =
&#8220;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>tty<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>newrole &#8211;l SystemHigh =
-- -c &#8220;ls
/var&#8221;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>##########################<o=
:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Thanks,<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal style=3D'border:none;padding:0in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Tim<o:p></o:p></span></font>=
</p>

</div>

</div>

</body>

</html>

------_=_NextPart_001_01C83C09.78ACE2AC--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
