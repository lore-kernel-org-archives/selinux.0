Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96FcirT005595
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 11:38:46 -0400 (EDT)
Received: from wgimx02.wgint.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i96FcgKB018071
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 15:38:43 GMT
From: "Richard Simpson" <richard.simpson@wgint.com>
To: "Alex Ackerman" <alex@darkhonor.com>, <selinux@tycho.nsa.gov>
Subject: RE: LVM/PostgreSQL/Sendmail AVC Messages
Date: Wed, 6 Oct 2004 09:41:07 -0600
Message-ID: <BJENLMGHDPAAAGKKPOFOIEFGCFAA.richard.simpson@wgint.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0040_01C4AB88.9B03B570"
In-Reply-To: <A52BEA1D8EE8634B9196A136333637B130E8@maat.darkhonor.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0040_01C4AB88.9B03B570
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Alex-

As a general troubleshooting rule, pipe the denials through audit2allow
which will produce a condensed list of proposed allow rules. Compare these
against the existing policy to help understand if the problem is a
deficiency in the policy, a mislabeled file, etc. Also get the latest policy
file for the app from the SF cvs to see if your problem has already been
addressed.

A good policy tutorial is here:
https://sourceforge.net/docman/display_doc.php?docid=21959&group_id=21266

good luck,
Richard.
  -----Original Message-----
  From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
Behalf Of Alex Ackerman
  Sent: Tuesday, October 05, 2004 4:05 PM
  To: selinux@tycho.nsa.gov
  Subject: LVM/PostgreSQL/Sendmail AVC Messages


  Thank you to everyone who assisted me. I managed to get my FC2 system up
and running.  Now I'm into the fine-tuning part.  I received the following
avc messages in my syslog and I was wondering if there are patches out to
correct, or is this an area where I can contribute my own policy patch?



  LVM AVC Errors:




------=_NextPart_000_0040_01C4AB88.9B03B570
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word"><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR>
<STYLE>
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
</STYLE>
</HEAD>
<BODY lang=3DEN-US vLink=3Dpurple link=3Dblue>
<DIV><SPAN class=3D989382215-06102004><FONT face=3DArial color=3D#0000ff =

size=3D2>Alex-</FONT></SPAN></DIV>
<DIV><SPAN class=3D989382215-06102004><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D989382215-06102004><FONT face=3DArial color=3D#0000ff =
size=3D2>As a=20
general troubleshooting rule, pipe the denials through audit2allow which =
will=20
produce a condensed list of proposed allow rules. Compare these against =
the=20
existing policy to help understand if the problem is a deficiency in the =
policy,=20
a mislabeled file, etc. Also get the latest policy file for the app from =
the SF=20
cvs&nbsp;to see if your problem has already been =
addressed.</FONT></SPAN></DIV>
<DIV><SPAN class=3D989382215-06102004><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D989382215-06102004><FONT face=3DArial color=3D#0000ff =
size=3D2>A good=20
policy tutorial is here: <A=20
href=3D"https://sourceforge.net/docman/display_doc.php?docid=3D21959&amp;=
group_id=3D21266">https://sourceforge.net/docman/display_doc.php?docid=3D=
21959&amp;group_id=3D21266</A></FONT></SPAN></DIV>
<DIV><SPAN class=3D989382215-06102004><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D989382215-06102004><FONT face=3DArial color=3D#0000ff =
size=3D2>good=20
luck,</FONT></SPAN></DIV>
<DIV><SPAN class=3D989382215-06102004><FONT face=3DArial color=3D#0000ff =

size=3D2>Richard.</FONT></SPAN></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
  size=3D2>-----Original Message-----<BR><B>From:</B> =
owner-selinux@tycho.nsa.gov=20
  [mailto:owner-selinux@tycho.nsa.gov]<B>On Behalf Of </B>Alex=20
  Ackerman<BR><B>Sent:</B> Tuesday, October 05, 2004 4:05 =
PM<BR><B>To:</B>=20
  selinux@tycho.nsa.gov<BR><B>Subject:</B> LVM/PostgreSQL/Sendmail AVC=20
  Messages<BR><BR></FONT></DIV>
  <DIV class=3DSection1>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Thank you to everyone =
who assisted=20
  me. I managed to get my FC2 system up and running.&nbsp; Now I&#8217;m =
into the=20
  fine-tuning part.&nbsp; I received the following avc messages in my =
syslog and=20
  I was wondering if there are patches out to correct, or is this an =
area where=20
  I can contribute my own policy patch?<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">LVM AVC=20
  Errors:<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p></o:p></SPAN></FONT>&nbsp;</P></DIV></BLOCKQUOTE></BODY></HTM=
L>

------=_NextPart_000_0040_01C4AB88.9B03B570--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
