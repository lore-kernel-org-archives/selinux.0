Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA23218
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 16:06:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA04411
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 20:05:21 GMT
Received: from avocet.mail.pas.earthlink.net (avocet.mail.pas.earthlink.net [207.217.120.50])
	by jazzswing.ncsc.mil  with ESMTP id UAA04406
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 20:05:20 GMT
Received: from crtntx1-ar7-4-35-055-033.crtntx1.elnk.dsl.genuity.net ([4.35.55.33] helo=donkey)
	by avocet.mail.pas.earthlink.net with esmtp (Exim 3.33 #1)
	id 17aMD2-0005rT-00
	for selinux@tycho.nsa.gov; Thu, 01 Aug 2002 13:06:08 -0700
From: "Ryan Bergauer" <privateryan@mindspring.com>
To: <selinux@tycho.nsa.gov>
Subject: More Samba
Date: Thu, 1 Aug 2002 15:06:10 -0500
Message-ID: <000101c23996$e14d4390$0300a8c0@donkey>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0002_01C2396C.F8773B90"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0002_01C2396C.F8773B90
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0003_01C2396C.F87A48D0"


------=_NextPart_001_0003_01C2396C.F87A48D0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Ok, here is an updated version of my Samba policy. It requires that a
few lines be added to other files, namely.
 
to net_contexts:
 
ifdef(`samba.te', `portcon tcp 137 system_u:object_r:samba_port_t
portcon tcp 138 system_u:object_r:samba_port_t
portcon tcp 139 system_u:object_r:samba_port_t')
 
to logrotate.te:
 
ifdef(`samba.te', `allow logrotate_t samba_log_t: dir { read search
getattr };
allow logrotate_t samba_log_t: file { getattr };
allow logrotate_t samba_var_t: dir { read search getattr };
allow logrotate_t samba_var_t: file { read getattr };')
 
I'm also receiving the following denied message, and I'm like some
suggestions on the best way to handle it.
 
avc:   denied   { read } for  pid=3486 exe=/bin/cat
path=/var/log/samba/log.nmbd dev=03:02 ino=1753604
scontext=system_u:object_r:system_crond_t
tcontext=system_u:object_r:samba_log_t tclass=file
 
And that does it. Thanks again, everyone.

------=_NextPart_001_0003_01C2396C.F87A48D0
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DProgId content=3DWord.Document>
<meta name=3DGenerator content=3D"Microsoft Word 10">
<meta name=3DOriginator content=3D"Microsoft Word 10">
<link rel=3DFile-List href=3D"cid:filelist.xml@01C2396C.F7738730">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"time"/>
<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:DoNotRelyOnCSS/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:DocumentKind>DocumentEmail</w:DocumentKind>
  <w:EnvelopeVis/>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Arial;
	mso-ascii-font-family:Arial;
	mso-hansi-font-family:Arial;
	mso-bidi-font-family:Arial;
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */=20
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";}
</style>
<![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'tab-interval:.5in'>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Ok, here is an updated version of my Samba policy. It
requires that a few lines be added to other files, =
namely&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>to</span></font></span><font=
 size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> <span
class=3DSpellE>net_contexts</span>:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><span class=3DSpellE><span class=3DGramE><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>ifdef</span></font></span></=
span><span
class=3DGramE><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:
Arial'>(</span></font></span><font size=3D2 face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial'>`<span class=3DSpellE>samba.te</span>', `<span
class=3DSpellE>portcon</span> <span class=3DSpellE>tcp</span> 137 <span
class=3DSpellE>system_u:object_r:samba_port_t</span><o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><span class=3DSpellE><span class=3DGramE><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>portcon</span></font></span>=
</span><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> <span
class=3DSpellE>tcp</span> 138 <span =
class=3DSpellE>system_u:object_r:samba_port_t</span><o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><span class=3DSpellE><span class=3DGramE><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>portcon</span></font></span>=
</span><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> <span
class=3DSpellE>tcp</span> 139 <span =
class=3DSpellE>system_u:object_r:samba_port_t</span>')<o:p></o:p></span><=
/font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>to</span></font></span><font=
 size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> <span
class=3DSpellE>logrotate.te</span>:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><span class=3DSpellE><span class=3DGramE><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>ifdef</span></font></span></=
span><span
class=3DGramE><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:
Arial'>(</span></font></span><font size=3D2 face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial'>`<span class=3DSpellE>samba.te</span>', `allow =
<span
class=3DSpellE>logrotate_t</span> <span =
class=3DSpellE>samba_log_t</span>: dir {
read search <span class=3DSpellE>getattr</span> =
};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>allow</span></font></span><f=
ont
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> <span
class=3DSpellE>logrotate_t</span> <span =
class=3DSpellE>samba_log_t</span>: file { <span
class=3DSpellE>getattr</span> };<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>allow</span></font></span><f=
ont
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> <span
class=3DSpellE>logrotate_t</span> <span =
class=3DSpellE>samba_var_t</span>: dir {
read search <span class=3DSpellE>getattr</span> =
};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DGramE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>allow</span></font></span><f=
ont
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> <span
class=3DSpellE>logrotate_t</span> <span =
class=3DSpellE>samba_var_t</span>: file {
read <span class=3DSpellE>getattr</span> =
};')<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m also receiving the following denied =
message, and I&#8217;m
like some suggestions on the best way to handle =
it&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><span class=3DSpellE><span class=3DGramE><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>avc</span></font></span></sp=
an><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>:<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>denied<span
style=3D'mso-spacerun:yes'>&nbsp;&nbsp; </span>{ read } for<span
style=3D'mso-spacerun:yes'>&nbsp; </span><span =
class=3DSpellE>pid</span>=3D3486
exe=3D/bin/cat path=3D/<span =
class=3DSpellE>var/log/samba/log.nmbd</span> =
dev=3D</span></font><st1:time
Hour=3D"15" Minute=3D"2"><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
 font-family:Arial'>03:02</span></font></st1:time><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'> <span =
class=3DSpellE>ino</span>=3D1753604<o:p></o:p></span></font></p>

<p class=3DMsoNormal><span class=3DSpellE><span class=3DGramE><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>scontext</span></font></span=
></span><span
class=3DGramE><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:
Arial'>=3D</span></font></span><span class=3DSpellE><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>system_u:object_r:system_cro=
nd_t</span></font></span><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> <span
class=3DSpellE>tcontext</span>=3D<span =
class=3DSpellE>system_u:object_r:samba_log_t</span>
<span class=3DSpellE>tclass</span>=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>And that does it. Thanks again, =
everyone.<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_001_0003_01C2396C.F87A48D0--

------=_NextPart_000_0002_01C2396C.F8773B90
Content-Type: application/octet-stream;
	name="samba.fc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="samba.fc"

# samba scripts=0A=
/usr/sbin/smbd			system_u:object_r:smbd_exec_t=0A=
/usr/sbin/nmbd			system_u:object_r:nmbd_exec_t=0A=
/etc/samba(|/.*)		system_u:object_r:samba_etc_t=0A=
/etc/samba/secrets.tdb		system_u:object_r:samba_weak_etc_t=0A=
/etc/samba/MACHINE.SID		system_u:object_r:samba_weak_etc_t=0A=
/var/log/samba(|/.*)		system_u:object_r:samba_log_t=0A=
/var/cache/samba(|/.*)		system_u:object_r:samba_var_t=0A=
#/net/music(|/.*)		system_u:object_r:samba_share_t=0A=
#/net/pub(|/.*)			system_u:object_r:samba_share_t=0A=

------=_NextPart_000_0002_01C2396C.F8773B90
Content-Type: application/octet-stream;
	name="samba.te"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="samba.te"

#=0A=
# Authors: Ryan Bergauer (bergauer@rice.edu)=0A=
#=0A=
=0A=
#################################=0A=
#=0A=
# Declarations for Samba=0A=
# samba_etc_t is type of files in /etc/samba=0A=
# samba_weak_etc_t is type of files requiring write=0A=
#   privileges in /etc/samba=0A=
# samba_log_t is type of files in /var/log/samba=0A=
# samba_var_t is type of files in /var/cahce/samba=0A=
# samba_share_t is type of files in Samba shares=0A=
#=0A=
=0A=
daemon_domain(smbd)=0A=
daemon_domain(nmbd)=0A=
type samba_etc_t, file_type, sysadmfile;=0A=
type samba_weak_etc_t, file_type, sysadmfile;=0A=
type samba_log_t, file_type, sysadmfile;=0A=
type samba_var_t, file_type, sysadmfile;=0A=
type samba_share_t, file_type, sysadmfile;=0A=
type samba_port_t, port_type;=0A=
=0A=
#################################=0A=
#=0A=
# Rules for the smbd_t domain.=0A=
#=0A=
=0A=
# Permissions normally found in every_domain.=0A=
general_domain_access(smbd_t)=0A=
general_file_read_access(smbd_t)=0A=
general_proc_read_access(smbd_t)=0A=
=0A=
# Use capabilities.=0A=
allow smbd_t smbd_t:capability { setgid setuid sys_resource =
net_bind_service lease };=0A=
=0A=
# Use the network.=0A=
can_network(smbd_t)=0A=
allow smbd_t samba_port_t: tcp_socket name_bind;=0A=
=0A=
# Read/Write user home directories.=0A=
allow smbd_t user_home_t:dir create_dir_perms;=0A=
allow smbd_t user_home_t:file create_file_perms;=0A=
=0A=
# Permissions for Samba files in /etc/samba=0A=
allow smbd_t samba_etc_t:file { getattr read lock };=0A=
allow smbd_t samba_etc_t:dir { search getattr };=0A=
allow smbd_t samba_weak_etc_t:file { write setattr getattr read lock };=0A=
# smbd_t wants to setattr on smbpasswd. This isn't allowed, but we don't=0A=
# need it audited. =0A=
auditdeny smbd_t samba_etc_t:file ~{ setattr };=0A=
=0A=
# Permissions for Samba cache files in /var/cache/samba=0A=
allow smbd_t samba_var_t:dir { write remove_name add_name lock getattr =
search };=0A=
allow smbd_t samba_var_t:file { lock unlink create write setattr read =
getattr rename };=0A=
=0A=
# Allow to use /dev/console.=0A=
allow smbd_t init_t:fd { use };=0A=
=0A=
# Permissions to write log files.=0A=
allow smbd_t samba_log_t:file { append getattr create };=0A=
allow smbd_t samba_log_t:dir { search };=0A=
=0A=
# Access Samba shares.=0A=
allow smbd_t samba_share_t:dir create_dir_perms;=0A=
allow smbd_t samba_share_t:file create_file_perms;=0A=
=0A=
#################################=0A=
#=0A=
# Rules for the nmbd_t domain.=0A=
#=0A=
=0A=
# Permissions normally found in every_domain.=0A=
general_domain_access(nmbd_t)=0A=
general_file_read_access(nmbd_t)=0A=
general_proc_read_access(nmbd_t)=0A=
allow nmbd_t console_device_t:chr_file { read write };=0A=
allow nmbd_t null_device_t:chr_file { read write ioctl };=0A=
=0A=
# Use capabilities.=0A=
allow nmbd_t nmbd_t:capability { net_bind_service };=0A=
=0A=
# Use the network.=0A=
can_network(nmbd_t)=0A=
=0A=
# Permissions for Samba files in /etc/samba=0A=
allow nmbd_t samba_etc_t:file { getattr read };=0A=
allow nmbd_t samba_etc_t:dir { search getattr };=0A=
=0A=
# Permissions for Samba cache files in /var/cache/samba=0A=
allow nmbd_t samba_var_t:dir { write remove_name add_name lock getattr =
search };=0A=
allow nmbd_t samba_var_t:file { lock unlink create write setattr read =
getattr rename };=0A=
=0A=
# Permissions to write log files.=0A=
allow nmbd_t samba_log_t:file { append getattr create };=0A=
allow nmbd_t samba_log_t:dir { search };=0A=
=0A=
allow nmbd_t nmbd_t: udp_socket recvfrom;=0A=
allow nmbd_t smbd_t: udp_socket recvfrom;=0A=

------=_NextPart_000_0002_01C2396C.F8773B90--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
