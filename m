Message-ID: <36282A1733C57546BE392885C0618592E1C561@chaos.tcs.tcs-sec.com>
From: Jonathan Kim <jkim@TrustedCS.com>
To: dwalsh@redhat.com
Cc: SELinux@tycho.nsa.gov
Subject: [PATCH] policy secadmin consistency
Date: Thu, 10 Nov 2005 18:29:14 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5E64E.8FC64360"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5E64E.8FC64360
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5E64E.8FC64360"


------_=_NextPart_001_01C5E64E.8FC64360
Content-Type: text/plain;
	charset="iso-8859-1"

This patch makes use of secadmin attribute consistent with other uses (ex:
setfiles, load_policy and checkpolicy), which are affected by
separate_secadm tunable.

----------------------------------- 
Jonghoon Jonathan 
Secure Systems Engineer 

Trusted Computer Solutions 
121 W Goose Alley 
Urbana, IL  61801 

http://www.TrustedCS.com <http://www.trustedcs.com/>  

V:  217.384.0028  ext.16 
F:  217.384.0288 

 

------_=_NextPart_001_01C5E64E.8FC64360
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 6.00.2800.1479" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Arial><FONT size=2>This patch makes use of secadmin attribute 
consistent with other uses (ex: setfiles, load_policy and checkpolicy)<SPAN 
class=897032623-10112005>, which&nbsp;are affected by separate_secadm 
tunable.</SPAN></FONT></FONT></DIV>
<P><FONT face="Courier New" size=2>-----------------------------------</FONT> 
<BR><B><FONT face=Arial size=2>Jonghoon Jonathan</FONT></B> <BR><FONT face=Arial 
size=2>Secure Systems Engineer</FONT> </P>
<P><B><FONT face=Arial size=2>Trusted Computer Solutions</FONT></B> <BR><FONT 
face=Arial size=2>121 W Goose Alley</FONT> <BR><FONT face=Arial size=2>Urbana, 
IL&nbsp; 61801</FONT> </P>
<P><FONT face=Arial size=2><A href="http://www.trustedcs.com/" 
target=_blank>http://www.TrustedCS.com</A></FONT> </P>
<P><B><FONT face=Arial size=2>V:</FONT></B><FONT face=Arial size=2>&nbsp; 
217.384.0028&nbsp; ext.16</FONT> <BR><B><FONT face=Arial 
size=2>F:&nbsp;</FONT></B> <FONT face=Arial size=2>217.384.0288</FONT> </P>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C5E64E.8FC64360--

------_=_NextPart_000_01C5E64E.8FC64360
Content-Type: application/octet-stream;
	name="policy_secadmin.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="policy_secadmin.patch"

diff -Nur policy-1.27.2.orig/domains/program/restorecon.te =
policy-1.27.2/domains/program/restorecon.te=0A=
--- policy-1.27.2.orig/domains/program/restorecon.te	2005-11-10 =
15:35:39.328258469 -0600=0A=
+++ policy-1.27.2/domains/program/restorecon.te	2005-11-10 =
15:34:09.292564039 -0600=0A=
@@ -22,7 +22,7 @@=0A=
 can_access_pty(restorecon_t, initrc)=0A=
 allow restorecon_t { tty_device_t admin_tty_type user_tty_type =
devtty_t }:chr_file { read write ioctl };=0A=
 =0A=
-domain_auto_trans({ initrc_t sysadm_t secadm_t }, restorecon_exec_t, =
restorecon_t)=0A=
+domain_auto_trans({ initrc_t secadmin }, restorecon_exec_t, =
restorecon_t)=0A=
 allow restorecon_t { userdomain init_t privfd }:fd use;=0A=
 =0A=
 uses_shlib(restorecon_t)=0A=

------_=_NextPart_000_01C5E64E.8FC64360--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
