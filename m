Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9RGrYXZ022439
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 12:53:34 -0400 (EDT)
Received: from maat.darkhonor.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9RGqArP012264
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 16:52:16 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4BC45.F2B4A6D0"
Subject: sysadm_r for Staff Users
Date: Wed, 27 Oct 2004 12:56:47 -0400
Message-ID: <A52BEA1D8EE8634B9196A136333637B130F8@maat.darkhonor.net>
From: "Alex Ackerman" <alex@darkhonor.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4BC45.F2B4A6D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ok, this is probably mentioned somewhere already, but I have been unable
to have my standard user account effectively use the sysadm_r role.  A
simple example to illustrate.  My "ackerman" account is setup with a
default role of staff_r and a supplementary role of sysadm_r similar to
the jadmin user example in /src/policy/users. After reloading the
updated policy, relabeling the filesystem, and logging in as "ackerman",
I switch to the sysadm_r role using newrole. To test out my new found
powers, I try to update the system via yum. (yum update).  I get the
following error:

=20

You need to be root to perform this command.

=20

Any ideas? I'm also restricted from actually writing to a system config
file while in the sysadm_r role.  I was under the understanding that a
benefit of SELinux was the ability to move system administration to a
group of individuals rather than just have the root user as the sole
owner of the kingdom (and hence allow many folks access to the root
password).  Any ideas of further changes needed to the system to enable
this that I'm missing? =20


Thanks!

Alex

=20

The /etc/selinux/strict/src/policy/users file entry is:

=20

user ackerman roles { staff_r sysadm_r ifdef(`direct_sysadm_daemon',
`system_r') };

=20

=20


------_=_NextPart_001_01C4BC45.F2B4A6D0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
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

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Ok, this is probably mentioned somewhere already, but =
I have
been unable to have my standard user account effectively use the =
sysadm_r
role.&nbsp; A simple example to illustrate.&nbsp; My =
&#8220;ackerman&#8221;
account is setup with a default role of staff_r and a supplementary role =
of
sysadm_r similar to the jadmin user example in /src/policy/users. After
reloading the updated policy, relabeling the filesystem, and logging in =
as &#8220;ackerman&#8221;,
I switch to the sysadm_r role using newrole. To test out my new found =
powers, I
try to update the system via yum. (yum update).&nbsp; I get the =
following
error:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>You need to be root to perform this =
command.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any ideas? I&#8217;m also restricted from actually =
writing
to a system config file while in the sysadm_r role.&nbsp; I was under =
the
understanding that a benefit of SELinux was the ability to move system
administration to a group of individuals rather than just have the root =
user as
the sole owner of the kingdom (and hence allow many folks access to the =
root
password).&nbsp; Any ideas of further changes needed to the system to =
enable
this that I&#8217;m missing?&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><br>
Thanks!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Alex<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The /etc/selinux/strict/src/policy/users file entry =
is:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user ackerman roles { staff_r sysadm_r
ifdef(`direct_sysadm_daemon&#8217;, `system_r&#8217;) =
};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C4BC45.F2B4A6D0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
