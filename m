Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o39C2TFW012008
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2010 08:02:29 -0400
Received: from mailgw1a.lmco.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o39C3H7B002622
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2010 12:03:17 GMT
Received: from emss07g01.ems.lmco.com (relay5.ems.lmco.com [166.29.2.16])by mailgw1a.lmco.com  (LM-6) with ESMTP id o39C2RF4009918for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2010 06:02:27 -0600 (MDT)
Received: from CONVERSION2-DAEMON.lmco.com by lmco.com (PMDF V6.4 #31705)
 id <0L0L00801YS3DT@lmco.com> for selinux@tycho.nsa.gov; Fri, 09 Apr 2010 12:02:27 +0000 (GMT)
Received: from hvxhtpn5.us.lmco.com ([158.186.148.34]) by lmco.com (PMDF V6.4 #31705)
 with ESMTP id <0L0L009QXYRYRF@lmco.com> for selinux@tycho.nsa.gov; Fri, 09 Apr 2010 12:02:22 +0000 (GMT)
Date: Fri, 09 Apr 2010 08:02:18 -0400
From: "Benedict, Phillip M" <phillip.m.benedict@lmco.com>
Subject: MLS telnet question
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-id: <6235CF4DC66FD5478F0E350E17C202FF251F2BB146@HVXMSP3.us.lmco.com>
MIME-version: 1.0
Content-type: multipart/alternative; boundary="Boundary_(ID_2jjdvYU3p4sTbBTP/WGRWw)"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary_(ID_2jjdvYU3p4sTbBTP/WGRWw)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT


Hello,

I am trying to come to a solution regarding the use of telnet on our MLS system. ( I know, ... the decision to use it was made above me ) . :(

What we have is a RHEL 5.3 system with the RedHat MLS policy installed.
The system has multiple physical NICs attached to different networks.
Each network is designated for it's own sensitivity level. ( so we might have one network for s1:c20, one for s2:c40 etc...)
User accounts are created with sensitivity labeling via semange. ( so we might have: user1 with s1:c20, and user2 with s2:c40 etc... )
The network does not carry any cipso data for evaluation by my server, so I don't think I can use netlabel.

Questions:
If I use IPTables/SECMARK to apply sensitivity labels to the packets as they come into the system, will xinetd spawn the telnet session with a matching sensitivity?  ( currently the telnet sessions are spawned at SystemLow-SystemHigh )
If telnet is spawned with the appropriate sensitivity, will SELinux disallow a users login who do not have  a matching sensitivity?


Thanks,
Mike Benedict


--Boundary_(ID_2jjdvYU3p4sTbBTP/WGRWw)
Content-type: text/html; charset=us-ascii
Content-transfer-encoding: 7BIT

<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns:m="http://schemas.microsoft.com/office/2004/12/omml" xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=us-ascii">
<meta name=Generator content="Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=EN-US link=blue vlink=purple>

<div class=Section1>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal>Hello,<o:p></o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal>I am trying to come to a solution regarding the use of
telnet on our MLS system. ( I know, &#8230; the decision to use it was made
above me ) . <span style='font-family:Wingdings'>L</span><o:p></o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal>What we have is a RHEL 5.3 system with the RedHat MLS policy
installed. <o:p></o:p></p>

<p class=MsoNormal>The system has multiple physical NICs attached to different
networks.<o:p></o:p></p>

<p class=MsoNormal>Each network is designated for it&#8217;s own sensitivity
level. ( so we might have one network for s1:c20, one for s2:c40 etc&#8230;)<o:p></o:p></p>

<p class=MsoNormal>User accounts are created with sensitivity labeling via
semange. ( so we might have: user1 with s1:c20, and user2 with s2:c40
etc&#8230; )<o:p></o:p></p>

<p class=MsoNormal>The network does not carry any cipso data for evaluation by
my server, so I don&#8217;t think I can use netlabel. <o:p></o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal>Questions:<o:p></o:p></p>

<p class=MsoNormal>If I use IPTables/SECMARK to apply sensitivity labels to the
packets as they come into the system, will xinetd spawn the telnet session with
a matching sensitivity? &nbsp;( currently the telnet sessions are spawned at
SystemLow-SystemHigh )<o:p></o:p></p>

<p class=MsoNormal>If telnet is spawned with the appropriate sensitivity, will
SELinux disallow a users login who do not have &nbsp;a matching sensitivity?<o:p></o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal>Thanks,<o:p></o:p></p>

<p class=MsoNormal>Mike Benedict<o:p></o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

--Boundary_(ID_2jjdvYU3p4sTbBTP/WGRWw)--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
