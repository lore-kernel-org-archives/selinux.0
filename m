Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4RLxhHP013274
 for <selinux@tycho.nsa.gov>; Tue, 27 May 2014 17:59:44 -0400
Received: from ferret (fw5540.nrl.navy.mil [132.250.196.100])
 by ccs.nrl.navy.mil (8.14.4/8.14.4) with ESMTP id s4RLxjAQ020596
 for <selinux@tycho.nsa.gov>; Tue, 27 May 2014 17:59:45 -0400
From: "Kim Lawson-Jenkins" <kim.lawson-jenkins@nrl.navy.mil>
To: <selinux@tycho.nsa.gov>
Subject: attempting to run a sftpserver in a confined domain
Date: Tue, 27 May 2014 18:02:16 -0400
Message-ID: <006b01cf79f7$52566370$f7032a50$@nrl.navy.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_006C_01CF79D5.CB44C370"
Reply-To: kim.lawson-jenkins@nrl.navy.mil
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multipart message in MIME format.

------=_NextPart_000_006C_01CF79D5.CB44C370
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

We are writing SELinux policy for a sftp server to run in a confined domain
when an openssh sftp connection is made to it.    

 

Using ls -Z we can see the running process labeled as

 

system_u:system_r:sshd_t: s0-s15:c0.c1023      root                  sshd:
guard [priv]

system_u:system_r:sshd_t :s0-s15:c0.c1023      guard               sshd:
guard@notty

system_u:system_r:unconfined_t:s0-s15:c0.c1023      guard
/usr/lib/openssh/sftpserver  

 

with the sftpserver running in the unconfined domain rather than the
confined domain sftpserver.  The sftp-server executable file is labeled as

 

system_u:system_r:sftpserver_exec_t:s0-s15:c0.c1023

 

in the directory /usr/lib/openssh.

 

The policy module contains the following statements - 

 

attribute sftpserver;

ssh_server_template(sftpserver)

iptables_domtrans(sftpserver_t)

type sftpserver_exec_t;

init_daemon_domain(sftpserver_t, sftpserver_exec_t)

allow sshd_t sftpserver_exec_t:file { getattr execute ioctl };

 

corenet_tcp_connect_ssh_port(sftpserver_t)

corenet_tcp_bind_ssh_port(sftpserver_t)

corenet_tcp_sendrecv_ssh_port(sftpserver_t)

 

 

Is there a boolean that will block the sftpserver from running in the
unconfined domain, and are there missing policy statements that will allow
the sftpserver to run in the confined domain?

 

Thanks in advance for any feedback.

 

Kim


------=_NextPart_000_006C_01CF79D5.CB44C370
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
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>We are =
writing SELinux policy for a sftp server to run in a confined domain =
when an openssh sftp connection is made to it.&nbsp; =
&nbsp;&nbsp;<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Using ls -Z we can see the running process labeled =
as<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>system_u:system_r:sshd_t: =
s0-s15:c0.c1023&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sshd: guard [priv]<o:p></o:p></p><p =
class=3DMsoNormal>system_u:system_r:sshd_t =
:s0-s15:c0.c1023&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; guard&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sshd: =
guard@notty<o:p></o:p></p><p =
class=3DMsoNormal>system_u:system_r:unconfined_t:s0-s15:c0.c1023&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; guard&nbsp;&nbsp;&nbsp; =
/usr/lib/openssh/sftpserver&nbsp; <o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>with the =
sftpserver running in the unconfined domain rather than the confined =
domain sftpserver.&nbsp; The sftp-server executable file is labeled =
as<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>system_u:system_r:sftpserver_exec_t:s0-s15:c0.c1023<o:p=
></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>in the directory /usr/lib/openssh.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>The policy =
module contains the following statements &#8211; <o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>attribute =
sftpserver;<o:p></o:p></p><p =
class=3DMsoNormal>ssh_server_template(sftpserver)<o:p></o:p></p><p =
class=3DMsoNormal>iptables_domtrans(sftpserver_t)<o:p></o:p></p><p =
class=3DMsoNormal>type sftpserver_exec_t;<o:p></o:p></p><p =
class=3DMsoNormal>init_daemon_domain(sftpserver_t, =
sftpserver_exec_t)<o:p></o:p></p><p class=3DMsoNormal>allow sshd_t =
sftpserver_exec_t:file { getattr execute ioctl };<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>corenet_tcp_connect_ssh_port(sftpserver_t)<o:p></o:p></=
p><p =
class=3DMsoNormal>corenet_tcp_bind_ssh_port(sftpserver_t)<o:p></o:p></p><=
p =
class=3DMsoNormal>corenet_tcp_sendrecv_ssh_port(sftpserver_t)<o:p></o:p><=
/p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Is there a =
boolean that will block the sftpserver from running in the unconfined =
domain, and are there missing policy statements that will allow the =
sftpserver to run in the confined domain?<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Thanks in =
advance for any feedback.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Kim<o:p></o:p></p></div></body></html>
------=_NextPart_000_006C_01CF79D5.CB44C370--
