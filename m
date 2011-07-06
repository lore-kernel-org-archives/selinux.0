Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p66CgmNO021747
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 08:42:48 -0400
Received: from relay1.gtri.gatech.edu (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p66Cglxw014036
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 12:42:47 GMT
Received: from apatlisdht02.core.gtri.org (apatlisdht02.core.gtri.org [130.207.199.73])
	by relay1.gtri.gatech.edu (Spam & Virus Firewall) with ESMTP id C68C1DF0874
	for <selinux@tycho.nsa.gov>; Wed,  6 Jul 2011 08:42:46 -0400 (EDT)
Received: from apatlisdht02.core.gtri.org (apatlisdht02.core.gtri.org [130.207.199.73]) by relay1.gtri.gatech.edu with ESMTP id aom4zd7W8Qyfcuf3 for <selinux@tycho.nsa.gov>; Wed, 06 Jul 2011 08:42:44 -0400 (EDT)
From: <Kurt.Nelson@gtri.gatech.edu>
To: <selinux@tycho.nsa.gov>
Subject: MLS Not enforcing secadm and auditadm
Date: Wed, 6 Jul 2011 12:42:45 +0000
Message-ID: <BC2F7132E56EEE4E864092975C1447BA730123@apatlisdmbx02>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_00F9_01CC3BB8.AD1A3960"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_NextPart_000_00F9_01CC3BB8.AD1A3960
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_00FA_01CC3BB8.AD1A3960"


------=_NextPart_001_00FA_01CC3BB8.AD1A3960
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I'm setting up a RHEL6 box with MLS and am having issues with it enforcing
the use of roles. Secadm_r and auditadm_r are not required to run setenforce
or semanage and no role is able to write in /etc/audit/ at all. The IRC
channel seems to believe there is an issue with the ifndef('enable_mls'. not
triggering.

 

[root@hatch ~]$ id -Z

staff_u:sysadm_r:sysadm_t:s0

 

[knelson6@hatch ~]$ ls -Z /usr/sbin/semanage 

-rwxr-xr-x. root root system_u:object_r:semanage_exec_t:s0
/usr/sbin/semanage

 

[knelson6@hatch ~]$ sestatus

SELinux status:                 enabled

SELinuxfs mount:                /selinux

Current mode:                   enforcing

Mode from config file:          enforcing

Policy version:                 24

Policy from config file:        mls

 

[root@hatch ~]# sesearch --allow -s sysadm_t -t semanage_exec_t -c file -p
execute

Found 3 semantic av rules:

   allow sysadm_t application_exec_type : file { ioctl read getattr lock
execute execute_no_trans open } ; 

   allow sysadm_usertype application_exec_type : file { ioctl read getattr
lock execute execute_no_trans open } ; 

   allow sysadm_t semanage_exec_t : file { ioctl read write create getattr
setattr lock relabelfrom relabelto append unlink link rename execute open }
;

 

[root@hatch ~]# sesearch -SCT --allow -s sysadm_t -t semanage_exec_t

Found 11 semantic av rules:

   allow sysadm_t application_exec_type : file { ioctl read getattr lock
execute execute_no_trans open } ; 

   allow sysadm_t file_type : filesystem getattr ; 

   allow sysadm_usertype application_exec_type : file { ioctl read getattr
lock execute execute_no_trans open } ; 

   allow sysadm_usertype file_type : filesystem getattr ; 

   allow sysadm_t semanage_exec_t : file { ioctl read write create getattr
setattr lock relabelfrom relabelto append unlink link rename execute open }
; 

   allow sysadm_t semanage_exec_t : dir { ioctl read write create getattr
setattr lock relabelfrom relabelto unlink link rename add_name remove_name
reparent search rmdir open } ; 

   allow sysadm_t semanage_exec_t : lnk_file { ioctl read write create
getattr setattr lock relabelfrom relabelto append unlink link rename } ; 

   allow sysadm_t semanage_exec_t : chr_file { getattr relabelfrom relabelto
} ; 

   allow sysadm_t semanage_exec_t : blk_file { getattr relabelfrom relabelto
} ; 

   allow sysadm_t semanage_exec_t : sock_file { ioctl read write create
getattr setattr lock relabelfrom relabelto append unlink link rename open }
; 

   allow sysadm_t semanage_exec_t : fifo_file { ioctl read write create
getattr setattr lock relabelfrom relabelto append unlink link rename open }
; 

 

Found 1 semantic te rules:

   type_transition sysadm_t semanage_exec_t : process semanage_t;

--

Kurt Nelson

GTRI-STL IT Coop

 


------=_NextPart_001_00FA_01CC3BB8.AD1A3960
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
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
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>I&#8217;m =
setting up a RHEL6 box with MLS and am having issues with it enforcing =
the use of roles. Secadm_r and auditadm_r are not required to run =
setenforce or semanage and no role is able to write in /etc/audit/ at =
all. The IRC channel seems to believe there is an issue with the =
ifndef(&#8216;enable_mls&#8217;&#8230; not triggering.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>[root@hatch =
~]$ id -Z<o:p></o:p></p><p =
class=3DMsoNormal>staff_u:sysadm_r:sysadm_t:s0<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>[knelson6@hatch ~]$ ls -Z /usr/sbin/semanage =
<o:p></o:p></p><p class=3DMsoNormal>-rwxr-xr-x. root root =
system_u:object_r:semanage_exec_t:s0 /usr/sbin/semanage<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>[knelson6@hatch ~]$ sestatus<o:p></o:p></p><p =
class=3DMsoNormal>SELinux status:&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;enabled<o:p></o:p></p><p class=3DMsoNormal>SELinuxfs =
mount:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /selinux<o:p></o:p></p><p =
class=3DMsoNormal>Current =
mode:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enforcing<o:p></o:p></p><p =
class=3DMsoNormal>Mode from config =
file:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
enforcing<o:p></o:p></p><p class=3DMsoNormal>Policy =
version:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24<o:p></o:p></p><p =
class=3DMsoNormal>Policy from config =
file:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mls<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>[root@hatch =
~]# sesearch --allow -s sysadm_t -t semanage_exec_t -c file -p =
execute<o:p></o:p></p><p class=3DMsoNormal>Found 3 semantic av =
rules:<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp; allow sysadm_t =
application_exec_type : file { ioctl read getattr lock execute =
execute_no_trans open } ; <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;allow sysadm_usertype =
application_exec_type : file { ioctl read getattr lock execute =
execute_no_trans open } ; <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;allow sysadm_t semanage_exec_t : =
file { ioctl read write create getattr setattr lock relabelfrom =
relabelto append unlink link rename execute open } ;<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>[root@hatch =
~]# sesearch -SCT --allow -s sysadm_t -t =
semanage_exec_t<o:p></o:p></p><p class=3DMsoNormal>Found 11 semantic av =
rules:<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp; allow sysadm_t =
application_exec_type : file { ioctl read getattr lock execute =
execute_no_trans open } ; <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;allow sysadm_t file_type : =
filesystem getattr ; <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;allow sysadm_usertype =
application_exec_type : file { ioctl read getattr lock execute =
execute_no_trans open } ; <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;allow sysadm_usertype file_type : =
filesystem getattr ; <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;allow sysadm_t semanage_exec_t : =
file { ioctl read write create getattr setattr lock relabelfrom =
relabelto append unlink link rename execute open } ; <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;allow sysadm_t semanage_exec_t : dir =
{ ioctl read write create getattr setattr lock relabelfrom relabelto =
unlink link rename add_name remove_name reparent search rmdir open } ; =
<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;allow sysadm_t =
semanage_exec_t : lnk_file { ioctl read write create getattr setattr =
lock relabelfrom relabelto append unlink link rename } ; =
<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;allow sysadm_t =
semanage_exec_t : chr_file { getattr relabelfrom relabelto } ; =
<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;allow sysadm_t =
semanage_exec_t : blk_file { getattr relabelfrom relabelto } ; =
<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;allow sysadm_t =
semanage_exec_t : sock_file { ioctl read write create getattr setattr =
lock relabelfrom relabelto append unlink link rename open } ; =
<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;allow sysadm_t =
semanage_exec_t : fifo_file { ioctl read write create getattr setattr =
lock relabelfrom relabelto append unlink link rename open } ; =
<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Found 1 semantic te rules:<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp; type_transition sysadm_t semanage_exec_t =
: process semanage_t;<o:p></o:p></p><p =
class=3DMsoNormal>--<o:p></o:p></p><p class=3DMsoNormal>Kurt =
Nelson<o:p></o:p></p><p class=3DMsoNormal>GTRI-STL IT =
Coop<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_001_00FA_01CC3BB8.AD1A3960--

------=_NextPart_000_00F9_01CC3BB8.AD1A3960
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
xH8NdAAAAAAAAA==

------=_NextPart_000_00F9_01CC3BB8.AD1A3960--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
