Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9RK0sXZ024232
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 16:00:54 -0400 (EDT)
Received: from wgimx02.wgint.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9RJxarP029368
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 19:59:36 GMT
From: "Richard Simpson" <richard.simpson@wgint.com>
To: "Alex Ackerman" <alex@darkhonor.com>, <selinux@tycho.nsa.gov>
Subject: RE: sysadm_r for Staff Users
Date: Wed, 27 Oct 2004 14:03:32 -0600
Message-ID: <BJENLMGHDPAAAGKKPOFOKEGKCFAA.richard.simpson@wgint.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0020_01C4BC2D.BE50C0D0"
In-Reply-To: <A52BEA1D8EE8634B9196A136333637B130F8@maat.darkhonor.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0020_01C4BC2D.BE50C0D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Alex-

Normal DAC restrictions are still in effect. You have to su to root (which
may also be restricted by your selinux policy).

Richard.

  -----Original Message-----
  From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
Behalf Of Alex Ackerman
  Sent: Wednesday, October 27, 2004 10:57 AM
  To: selinux@tycho.nsa.gov
  Subject: sysadm_r for Staff Users


  Ok, this is probably mentioned somewhere already, but I have been unable
to have my standard user account effectively use the sysadm_r role.  A
simple example to illustrate.  My "ackerman" account is setup with a default
role of staff_r and a supplementary role of sysadm_r similar to the jadmin
user example in /src/policy/users. After reloading the updated policy,
relabeling the filesystem, and logging in as "ackerman", I switch to the
sysadm_r role using newrole. To test out my new found powers, I try to
update the system via yum. (yum update).  I get the following error:



  You need to be root to perform this command.



  Any ideas? I'm also restricted from actually writing to a system config
file while in the sysadm_r role.  I was under the understanding that a
benefit of SELinux was the ability to move system administration to a group
of individuals rather than just have the root user as the sole owner of the
kingdom (and hence allow many folks access to the root password).  Any ideas
of further changes needed to the system to enable this that I'm missing?


  Thanks!

  Alex



  The /etc/selinux/strict/src/policy/users file entry is:



  user ackerman roles { staff_r sysadm_r ifdef(`direct_sysadm_daemon',
`system_r') };






------=_NextPart_000_0020_01C4BC2D.BE50C0D0
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
<DIV>
<P><SPAN class=3D846315919-27102004><FONT =
size=3D2>Alex-</FONT></SPAN></P>
<P><FONT size=3D2>Normal DAC restrictions are still in effect. You have =
to su to=20
root&nbsp;<SPAN class=3D846315919-27102004>(</SPAN>which may also be =
restricted by=20
your selinux policy<SPAN class=3D846315919-27102004>).</SPAN></FONT></P>
<P><FONT size=3D2><SPAN =
class=3D846315919-27102004>Richard.</SPAN></FONT></P></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
  size=3D2>-----Original Message-----<BR><B>From:</B> =
owner-selinux@tycho.nsa.gov=20
  [mailto:owner-selinux@tycho.nsa.gov]<B>On Behalf Of </B>Alex=20
  Ackerman<BR><B>Sent:</B> Wednesday, October 27, 2004 10:57 =
AM<BR><B>To:</B>=20
  selinux@tycho.nsa.gov<BR><B>Subject:</B> sysadm_r for Staff=20
  Users<BR><BR></FONT></DIV>
  <DIV class=3DSection1>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Ok, this is probably =
mentioned=20
  somewhere already, but I have been unable to have my standard user =
account=20
  effectively use the sysadm_r role.&nbsp; A simple example to =
illustrate.&nbsp;=20
  My &#8220;ackerman&#8221; account is setup with a default role of =
staff_r and a=20
  supplementary role of sysadm_r similar to the jadmin user example in=20
  /src/policy/users. After reloading the updated policy, relabeling the=20
  filesystem, and logging in as &#8220;ackerman&#8221;, I switch to the =
sysadm_r role using=20
  newrole. To test out my new found powers, I try to update the system =
via yum.=20
  (yum update).&nbsp; I get the following =
error:<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">You need to be root to =
perform=20
  this command.<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Any ideas? I&#8217;m =
also restricted=20
  from actually writing to a system config file while in the sysadm_r=20
  role.&nbsp; I was under the understanding that a benefit of SELinux =
was the=20
  ability to move system administration to a group of individuals rather =
than=20
  just have the root user as the sole owner of the kingdom (and hence =
allow many=20
  folks access to the root password).&nbsp; Any ideas of further changes =
needed=20
  to the system to enable this that I&#8217;m missing?&nbsp;=20
  <o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><BR>Thanks!<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">Alex<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">The=20
  /etc/selinux/strict/src/policy/users file entry=20
  is:<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">user ackerman roles { =
staff_r=20
  sysadm_r ifdef(`direct_sysadm_daemon&#8217;, `system_r&#8217;)=20
  };<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P></DIV></BLOCKQUOTE></BODY></HTM=
L>

------=_NextPart_000_0020_01C4BC2D.BE50C0D0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
