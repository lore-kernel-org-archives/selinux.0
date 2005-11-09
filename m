Message-ID: <36282A1733C57546BE392885C0618592E1C2F6@chaos.tcs.tcs-sec.com>
From: Jonathan Kim <jkim@TrustedCS.com>
To: dwalsh@redhat.com, SELinux@tycho.nsa.gov
Cc: Chad Hanson <chanson@TrustedCS.com>
Subject: [Patch] policy - passwd error
Date: Wed, 9 Nov 2005 11:08:29 -0500 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5E547.D2EE79D0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5E547.D2EE79D0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5E547.D2EE79D0"


------_=_NextPart_001_01C5E547.D2EE79D0
Content-Type: text/plain;
	charset="iso-8859-1"

The attached patch allows the passwd command to generate audit records.
I diffed with MLS policy, but this also fix Strict policy as well.
 
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

 

------_=_NextPart_001_01C5E547.D2EE79D0
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 6.00.2800.1479" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Arial size=2>The attached patch allows the passwd command to 
generate audit<SPAN class=030535415-09112005> </SPAN>records.</FONT></DIV>
<DIV><FONT face=Arial size=2>I diffed with MLS policy, but this also 
fix&nbsp;<SPAN class=030535415-09112005>S</SPAN>trict policy as 
well.</FONT></DIV>
<DIV><FONT face=Arial><FONT size=2></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial><FONT size=2>Thanks<SPAN 
class=030535415-09112005>.</SPAN></FONT></FONT></DIV>
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

------_=_NextPart_001_01C5E547.D2EE79D0--

------_=_NextPart_000_01C5E547.D2EE79D0
Content-Type: application/octet-stream;
	name="policy-1.27.2.patch.passwd"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="policy-1.27.2.patch.passwd"

diff -Nur policy-1.27.2.orig/domains/program/passwd.te =
policy-1.27.2/domains/program/passwd.te=0A=
--- policy-1.27.2.orig/domains/program/passwd.te	2005-11-08 =
15:07:10.000000000 -0600=0A=
+++ policy-1.27.2/domains/program/passwd.te	2005-11-08 =
15:30:16.000000000 -0600=0A=
@@ -42,7 +42,7 @@=0A=
 allow $1_t etc_t:lnk_file read;=0A=
 =0A=
 # Use capabilities.=0A=
-allow $1_t self:capability { chown dac_override fsetid setuid setgid =
sys_resource };=0A=
+allow $1_t self:capability { chown dac_override fsetid setuid setgid =
sys_resource audit_control audit_write };=0A=
 =0A=
 # Access terminals.=0A=
 allow $1_t { ttyfile ptyfile }:chr_file rw_file_perms;=0A=

------_=_NextPart_000_01C5E547.D2EE79D0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
