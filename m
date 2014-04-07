Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s37GhBSU020818
 for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2014 12:43:11 -0400
Received: from ferret (fw5540.nrl.navy.mil [132.250.196.100])
 by ccs.nrl.navy.mil (8.14.4/8.14.4) with ESMTP id s37GhAOO012443
 for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2014 12:43:10 -0400
From: "Kim Lawson-Jenkins" <kim.lawson-jenkins@nrl.navy.mil>
To: <selinux@tycho.nsa.gov>
Subject: files in /root labeled admin_home_t
Date: Mon, 7 Apr 2014 12:43:40 -0400
Message-ID: <001a01cf5280$87b76b70$97264250$@nrl.navy.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_001B_01CF525F.00A61990"
Reply-To: kim.lawson-jenkins@nrl.navy.mil
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multipart message in MIME format.

------=_NextPart_000_001B_01CF525F.00A61990
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

Initially I could not access the root home directory after setting SELinux
in enforcing mode.  I found information in the SELinux archive that the root
home directory should be labeled sysadm_home_t, not admin_home_t as the
files in my system's root home directory are labeled.    The output of
"semanage user -l" on my system shows root with a Labeling Prefix of sysadm
and the SELinux Roles of system_r, sysadm_r, staff_r.  

 

However, if I use "seinfo -tsysadm_home_t"  I can't find the type
sysadm_home_t, and I get an error when I attempt to use semanage fcontext to
change the file context type  of files in /root to sysadm_home_t.  Can
anyone suggest what I should do to fix the labels for files in /root and the
problems that I'm having with the sysadm_t domain?

 

Thanks in advance for a response.

 

Kim


------=_NextPart_000_001B_01CF525F.00A61990
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 14 (filtered =
medium)"><style><!--
/* Font Definitions */
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
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoNormal>Hi,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Initially I =
could not access the root home directory after setting SELinux in =
enforcing mode.&nbsp; I found information in the SELinux archive that =
the root home directory should be labeled sysadm_home_t, not =
admin_home_t as the files in my system&#8217;s root home directory are =
labeled.&nbsp; &nbsp;&nbsp;The output of &#8220;semanage user =
&#8211;l&#8221; on my system shows root with a Labeling Prefix of sysadm =
and the SELinux Roles of system_r, sysadm_r, staff_r.&nbsp; =
<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>However, if I use &#8220;seinfo =
&#8211;tsysadm_home_t&#8221; &nbsp;I can&#8217;t find the type =
sysadm_home_t, and I get an error when I attempt to use semanage =
fcontext to change the file context type &nbsp;of files in /root to =
sysadm_home_t.&nbsp; Can anyone suggest what I should do to fix the =
labels for files in /root and the problems that I&#8217;m having with =
the sysadm_t domain?<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Thanks in =
advance for a response.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Kim<o:p></o:p></p></div></body></html>
------=_NextPart_000_001B_01CF525F.00A61990--
