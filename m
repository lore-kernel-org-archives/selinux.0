Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l78C9tuj024011
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 08:09:55 -0400
Received: from fw5540.nrl.navy.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l78C9qEu019582
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 12:09:52 GMT
Received: from chacs.nrl.navy.mil (sun1.fw5540.net [10.0.0.11])
	by fw5540.nrl.navy.mil (8.13.6/8.13.6) with ESMTP id l78C85B0028860
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 08:08:06 -0400 (EDT)
Received: from chacs.nrl.navy.mil (sun1 [10.0.0.11])
	by chacs.nrl.navy.mil (8.13.6/8.13.6) with SMTP id l78C85Ua000222
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 08:08:05 -0400 (EDT)
Received: (from PC05 [10.0.1.195])
 by chacs.nrl.navy.mil (SMSSMTP 4.1.16.48) with SMTP id M2007080808080507967
 for <selinux@tycho.nsa.gov>; Wed, 08 Aug 2007 08:08:05 -0400
From: "Kim Lawson-Jenkins" <lawson@itd.nrl.navy.mil>
To: <selinux@tycho.nsa.gov>
Subject: Migrating older SELinux policies to new Linux releases
Date: Wed, 8 Aug 2007 08:04:11 -0500
Message-ID: <001b01c7d9bc$9d227a70$c301000a@PC05>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001C_01C7D992.B44C7270"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_001C_01C7D992.B44C7270
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

 

I'm migrating application software from Fedora Core 3 to RHEL5.  The SELinux
strict policy was used for Fedora Core 3 and as a first step I only want to
migrate the existing policy to RHEL5.  (Later I plan to make changes to the
policy using the newer SELinux development tools.)  I've seen several books
and whitepapers that discuss generating new policies using the current
SELinux tools but I have seen no whitepapers, examples, or guidelines on how
to, say, migrate older strict policies to the new reference policy.  Are
there any such guidelines or suggestions documented somewhere?


------=_NextPart_000_001C_01C7D992.B44C7270
Content-Type: text/html;
	charset="US-ASCII"
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
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m migrating application software from Fedora =
Core 3
to RHEL5. &nbsp;The SELinux strict policy was used for Fedora Core 3 and =
as a
first step I only want to migrate the existing policy to RHEL5.&nbsp; =
(Later I plan
to make changes to the policy using the newer SELinux development =
tools.) &nbsp;I&#8217;ve
seen several books and whitepapers that discuss generating new policies =
using
the current SELinux tools but I have seen no whitepapers, examples, or
guidelines on how to, say, migrate older strict policies to the new =
reference
policy.&nbsp; Are there any such guidelines or suggestions documented
somewhere?</span></font><o:p></o:p></p>

</div>

</body>

</html>

------=_NextPart_000_001C_01C7D992.B44C7270--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
