From: "Ed Street" <edstreet@street-tek.com>
To: "SELinux" <SELinux@tycho.nsa.gov>
Subject: uw-imapd policy
Date: Thu, 20 May 2004 21:10:34 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01D0_01C43EAE.E41C0650"
Message-Id: <20040521011034.637103A4054@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_01D0_01C43EAE.E41C0650
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_01D1_01C43EAE.E41C0650"


------=_NextPart_001_01D1_01C43EAE.E41C0650
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

This is the uw-imapd policy files that I created under debian SID.  The =
only
snag I ran into was some mislabeled files in net_contexts. Namely when
labeling ports 143 tcp, 220 tcp, and 993 tcp.  Some of these are =
currently
labeled as pop_* shouldn=92t=92 these be labeled as imapd_* ?

=20

Ed


---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.687 / Virus Database: 448 - Release Date: 5/16/2004
=20
 =20

------=_NextPart_001_01D1_01C43EAE.E41C0650
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DWindows-1252">


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
font-family:Arial'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>This is the uw-imapd policy files that I created =
under
debian SID.&nbsp; The only snag I ran into was some mislabeled files in =
net_contexts.
Namely when labeling ports 143 tcp, 220 tcp, and 993 tcp.&nbsp; Some of =
these are
currently labeled as pop_* shouldn&#8217;t&#8217; these be labeled as =
imapd_* ?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Ed<o:p></o:p></span></font></p>

</div>

</body>

</html>
<BR>

<P><FONT SIZE=3D2>---<BR>
<BR>
Checked by AVG anti-virus system (http://www.grisoft.com).<BR>
Version: 6.0.687 / Virus Database: 448 - Release Date: 5/16/2004<BR>
</FONT> </P>

<P><FONT SIZE=3D2 FACE=3D"Arial"> </FONT> </P>

------=_NextPart_001_01D1_01C43EAE.E41C0650--

------=_NextPart_000_01D0_01C43EAE.E41C0650
Content-Type: application/octet-stream;
	name="uw-imapd.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="uw-imapd.patch"

diff -urN current-orig/domains/program/uwimapd.te =
current/domains/program/uwimapd.te
--- current-orig/domains/program/uwimapd.te	1969-12-31 =
19:00:00.000000000 -0500
+++ current/domains/program/uwimapd.te	2004-05-20 20:14:53.000000000 =
-0400
@@ -0,0 +1,62 @@
+#DESC uw-imapd-ssl server
+#
+# Author:  Ed Street <edstreet@street-tek.com>
+# X-Debian-Packages: uw-imapd (was uw-imapd-ssl)
+#
+
+#we are using ports
+type imapd_port_t, port_type;
+
+daemon_domain(imapd, `, auth_chkpwd')
+tmp_domain(imapd)
+
+can_network(imapd_t)
+can_ypbind(imapd_t)
+
+#declare our own services
+allow imapd_t self:capability { dac_override net_bind_service setgid =
setuid sys_resource };
+allow imapd_t imapd_port_t:tcp_socket name_bind;
+
+#allow inetd to bind to us
+allow inetd_t imapd_port_t:tcp_socket { name_bind };
+
+#declare this a socket from inetd
+allow imapd_t self:unix_dgram_socket { sendto create_socket_perms };
+allow imapd_t self:unix_stream_socket create_socket_perms;
+domain_auto_trans(inetd_t, imapd_exec_t, imapd_t)
+ifdef(`tcpd.te', `domain_auto_trans(tcpd_t, imapd_exec_t, imapd_t)')
+
+#friendly stuff we dont want to see :)
+dontaudit imapd_t etc_t:file { getattr };
+dontaudit imapd_t net_conf_t:file { getattr };
+dontaudit system_chkpwd_t system_chkpwd_t:file { getattr };
+dontaudit imapd_t mail_spool_t:dir { getattr };
+dontaudit imapd_t bin_t:dir { search };
+
+#read /etc/ for hostname nsswitch.conf
+allow imapd_t etc_t:file { read };
+
+#socket i/o stuff
+allow imapd_t inetd_t:tcp_socket { read write ioctl getattr };
+
+#read resolv.conf
+allow imapd_t net_conf_t:file { read };
+
+#urandom, for ssl
+allow system_chkpwd_t urandom_device_t:chr_file { read };
+allow imapd_t random_device_t:chr_file { read };
+allow imapd_t urandom_device_t:chr_file { read getattr };
+
+#verify password
+allow system_chkpwd_t inetd_t:fd { use };
+allow system_chkpwd_t inetd_t:tcp_socket { read write };
+
+allow imapd_t imapd_t:fifo_file { write read };
+
+#mail directory
+create_dir_file(imapd_t mail_spool_t)
+
+#home directory
+allow imapd_t home_root_t:dir { search };
+create_dir_file(imapd_t, user_home_type)
+allow imapd_t imapd_t:file { read getattr };
diff -urN current-orig/file_contexts/program/uwimapd.fc =
current/file_contexts/program/uwimapd.fc
--- current-orig/file_contexts/program/uwimapd.fc	1969-12-31 =
19:00:00.000000000 -0500
+++ current/file_contexts/program/uwimapd.fc	2004-04-21 =
19:31:56.000000000 -0400
@@ -0,0 +1,2 @@
+# uw-imapd and uw-imapd-ssl
+/usr/sbin/imapd		-- system_u:object_r:imapd_exec_t
diff -urN current-orig/net_contexts current/net_contexts
--- current-orig/net_contexts	2004-05-20 20:07:14.000000000 -0400
+++ current/net_contexts	2004-05-20 20:54:21.000000000 -0400
@@ -37,6 +37,12 @@
 portcon udp 892 system_u:object_r:inetd_port_t
 portcon tcp 901 system_u:object_r:biff_port_t
 ')
+ifdef(`uwimapd.te', `
+portcon tcp 993 system_u:object_r:imapd_port_t
+portcon tcp 143 system_u:object_r:imapd_port_t
+portcon tcp 220 system_u:object_r:imapd_port_t
+')
+
 ifdef(`courier.te', `define(`use_pop')')
 ifdef(`perdition.te', `define(`use_pop')')
 ifdef(`cyrus.te', `define(`use_pop')')

------=_NextPart_000_01D0_01C43EAE.E41C0650--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
