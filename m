Message-ID: <36282A1733C57546BE392885C0618592E1C2F8@chaos.tcs.tcs-sec.com>
From: Jonathan Kim <jkim@TrustedCS.com>
To: dwalsh@redhat.com, SELinux@tycho.nsa.gov
Cc: Chad Hanson <chanson@TrustedCS.com>
Subject: [Patch] /dev/pts/ MLS label restore 
Date: Wed, 9 Nov 2005 11:13:21 -0500 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5E548.810D36A0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5E548.810D36A0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5E548.810D36A0"


------_=_NextPart_001_01C5E548.810D36A0
Content-Type: text/plain;
	charset="iso-8859-1"

This is mainly for MLS policy. 
However it will not affect anything for other policies.
 
Thanks.

----------------------------------- 
Jonghoon Jonathan 
Secure Systems Engineer 

Trusted Computer Solutions 
121 W Goose Alley 
Urbana, IL  61801 

http://www.TrustedCS.com <http://www.trustedcs.com/>  

V:  217.384.0028  ext.16 
F:  217.384.0288 

 

------_=_NextPart_001_01C5E548.810D36A0
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 6.00.2800.1479" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Arial size=2>This is mainly for MLS policy. </FONT></DIV>
<DIV><FONT face=Arial size=2>However it will not affect anything for other 
policies.</FONT></DIV>
<DIV><FONT face=Arial><FONT size=2><FONT face=Arial 
size=2></FONT></FONT></FONT>&nbsp;</DIV>
<DIV><SPAN class=498535715-09112005><FONT face=Arial 
size=2>Thanks.</FONT></SPAN></DIV>
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

------_=_NextPart_001_01C5E548.810D36A0--

------_=_NextPart_000_01C5E548.810D36A0
Content-Type: application/octet-stream;
	name="policy-mls-1.27.2.patch.pts"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="policy-mls-1.27.2.patch.pts"

diff -Nur policy-1.27.2.orig/domains/program/restorecon.te =
policy-1.27.2/domains/program/restorecon.te=0A=
--- policy-1.27.2.orig/domains/program/restorecon.te	2005-11-08 =
15:07:10.000000000 -0600=0A=
+++ policy-1.27.2/domains/program/restorecon.te	2005-11-08 =
16:57:45.000000000 -0600=0A=
@@ -67,3 +67,7 @@=0A=
 ifdef(`targeted_policy', `=0A=
 allow restorecon_t devpts_t:chr_file getattr;=0A=
 ')=0A=
+ifdef(`mls_policy', `=0A=
+# need to restorecon /dev/pts during boot (from =
/etc/rc.d/rc.sysinit)=0A=
+allow restorecon_t devpts_t:dir { relabelfrom relabelto };=0A=
+')=0A=
diff -Nur policy-1.27.2.orig/file_contexts/types.fc =
policy-1.27.2/file_contexts/types.fc=0A=
--- policy-1.27.2.orig/file_contexts/types.fc	2005-11-08 =
15:07:10.000000000 -0600=0A=
+++ policy-1.27.2/file_contexts/types.fc	2005-11-08 15:32:55.000000000 =
-0600=0A=
@@ -116,6 +116,7 @@=0A=
 # /dev=0A=
 #=0A=
 /dev(/.*)?			system_u:object_r:device_t:s0=0A=
+/dev/pts		-d	system_u:object_r:devpts_t:s0-s15:c0.c255=0A=
 /dev/pts(/.*)?		<<none>>=0A=
 /dev/cpu/.*		-c	system_u:object_r:cpu_device_t:s0=0A=
 /dev/microcode	-c	system_u:object_r:cpu_device_t:s0=0A=

------_=_NextPart_000_01C5E548.810D36A0
Content-Type: application/octet-stream;
	name="initscripts-8.17.patch.pts"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="initscripts-8.17.patch.pts"

diff -Nur initscripts-8.17.orig/rc.d/rc.sysinit =
initscripts-8.17/rc.d/rc.sysinit=0A=
--- initscripts-8.17.orig/rc.d/rc.sysinit	2005-11-08 16:25:53.000000000 =
-0600=0A=
+++ initscripts-8.17/rc.d/rc.sysinit	2005-11-08 17:00:17.000000000 =
-0600=0A=
@@ -40,7 +40,7 @@=0A=
 fi=0A=
 =0A=
 if [ -n "$SELINUX" -a -x /sbin/restorecon ] && LC_ALL=3DC fgrep -q " =
/dev " /proc/mounts ; then=0A=
-	/sbin/restorecon  -R /dev 2>/dev/null=0A=
+	/sbin/restorecon  -R -e /dev/pts /dev 2>/dev/null=0A=
 fi=0A=
 =0A=
 disable_selinux() {=0A=
@@ -263,6 +263,9 @@=0A=
 # may have to do this again after mounting=0A=
 RHGB_STARTED=3D0=0A=
 mount -n /dev/pts=0A=
+# Restore label of /dev/pts=0A=
+# Mainly for MLS policy. Will not affect anything for other =
policies=0A=
+[ -n "$SELINUX" ] && restorecon /dev/pts=0A=
 =0A=
 if strstr "$cmdline" rhgb && ! strstr "$cmdline" early-login && [ =
"$BOOTUP" =3D "color" -a "$GRAPHICAL" =3D "yes" -a -x /usr/bin/rhgb ]; =
then=0A=
    LC_MESSAGES=3D /usr/bin/rhgb=0A=

------_=_NextPart_000_01C5E548.810D36A0
Content-Type: application/octet-stream;
	name="policy-mls-1.27.2.patch.pts"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="policy-mls-1.27.2.patch.pts"

diff -Nur policy-1.27.2.orig/domains/program/restorecon.te =
policy-1.27.2/domains/program/restorecon.te=0A=
--- policy-1.27.2.orig/domains/program/restorecon.te	2005-11-08 =
15:07:10.000000000 -0600=0A=
+++ policy-1.27.2/domains/program/restorecon.te	2005-11-08 =
16:57:45.000000000 -0600=0A=
@@ -67,3 +67,7 @@=0A=
 ifdef(`targeted_policy', `=0A=
 allow restorecon_t devpts_t:chr_file getattr;=0A=
 ')=0A=
+ifdef(`mls_policy', `=0A=
+# need to restorecon /dev/pts during boot (from =
/etc/rc.d/rc.sysinit)=0A=
+allow restorecon_t devpts_t:dir { relabelfrom relabelto };=0A=
+')=0A=
diff -Nur policy-1.27.2.orig/file_contexts/types.fc =
policy-1.27.2/file_contexts/types.fc=0A=
--- policy-1.27.2.orig/file_contexts/types.fc	2005-11-08 =
15:07:10.000000000 -0600=0A=
+++ policy-1.27.2/file_contexts/types.fc	2005-11-08 15:32:55.000000000 =
-0600=0A=
@@ -116,6 +116,7 @@=0A=
 # /dev=0A=
 #=0A=
 /dev(/.*)?			system_u:object_r:device_t:s0=0A=
+/dev/pts		-d	system_u:object_r:devpts_t:s0-s15:c0.c255=0A=
 /dev/pts(/.*)?		<<none>>=0A=
 /dev/cpu/.*		-c	system_u:object_r:cpu_device_t:s0=0A=
 /dev/microcode	-c	system_u:object_r:cpu_device_t:s0=0A=

------_=_NextPart_000_01C5E548.810D36A0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
