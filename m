Message-ID: <36282A1733C57546BE392885C0618592D9770C@chaos.tcs.tcs-sec.com>
From: Jonathan Kim <jkim@TrustedCS.com>
To: dwalsh@redhat.com
Cc: SELinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>,
   Daniel Thayer <dthayer@TrustedCS.com>
Subject: [PATCH] MLS policy
Date: Fri, 4 Nov 2005 12:00:21 -0500 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5E161.3DF30060"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5E161.3DF30060
Content-Type: text/plain;
	charset="iso-8859-1"

This patch sets the file context for the seusers file to be
SystemHigh (because the seusers file contains MLS labels and
these must be protected).  It also fixes some login-related
issues on MLS (allow login on a tty which is not at SystemLow,
and also allow reading of the seusers file).


 <<mls-login.patch>> 

-----------------------------------
Jonghoon Jonathan
Secure Systems Engineer

Trusted Computer Solutions
121 W Goose Alley
Urbana, IL  61801

http://www.TrustedCS.com

V:  217.384.0028  ext.16
F:  217.384.0288


------_=_NextPart_000_01C5E161.3DF30060
Content-Type: application/octet-stream;
	name="mls-login.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mls-login.patch"

diff -Nur policy-1.27.2.orig/domains/program/getty.te =
policy-1.27.2/domains/program/getty.te=0A=
--- policy-1.27.2.orig/domains/program/getty.te	2005-10-21 =
15:56:50.000000000 +0000=0A=
+++ policy-1.27.2/domains/program/getty.te	2005-11-04 =
00:12:30.498842863 +0000=0A=
@@ -8,7 +8,7 @@=0A=
 #=0A=
 # Rules for the getty_t domain.=0A=
 #=0A=
-init_service_domain(getty, `, privfd')=0A=
+init_service_domain(getty, `, privfd, mlsfileread, mlsfilewrite')=0A=
 =0A=
 etcdir_domain(getty)=0A=
 =0A=
diff -Nur policy-1.27.2.orig/domains/program/login.te =
policy-1.27.2/domains/program/login.te=0A=
--- policy-1.27.2.orig/domains/program/login.te	2005-10-21 =
15:56:50.000000000 +0000=0A=
+++ policy-1.27.2/domains/program/login.te	2005-11-04 =
00:11:29.743583172 +0000=0A=
@@ -13,7 +13,7 @@=0A=
 =0A=
 # $1 is the name of the domain (local or remote)=0A=
 define(`login_domain', `=0A=
-type $1_login_t, domain, privuser, privrole, privlog, auth_chkpwd, =
privowner, privfd, nscd_client_domain, mlsfilewrite, mlsprocsetsl, =
mlsfileupgrade, mlsfiledowngrade;=0A=
+type $1_login_t, domain, privuser, privrole, privlog, auth_chkpwd, =
privowner, privfd, nscd_client_domain, mlsfileread, mlsfilewrite, =
mlsprocsetsl, mlsfileupgrade, mlsfiledowngrade;=0A=
 role system_r types $1_login_t;=0A=
 =0A=
 dontaudit $1_login_t shadow_t:file { getattr read };=0A=
diff -Nur policy-1.27.2.orig/file_contexts/types.fc =
policy-1.27.2/file_contexts/types.fc=0A=
--- policy-1.27.2.orig/file_contexts/types.fc	2005-11-04 =
00:07:02.691790026 +0000=0A=
+++ policy-1.27.2/file_contexts/types.fc	2005-11-04 00:10:55.206530855 =
+0000=0A=
@@ -306,6 +306,7 @@=0A=
 /etc/resolv\.conf.*	--	system_u:object_r:net_conf_t:s0=0A=
 =0A=
 /etc/selinux(/.*)?		system_u:object_r:selinux_config_t:s0=0A=
+/etc/selinux/([^/]*/)?seusers	--	=
system_u:object_r:selinux_config_t:s15:c0.c255=0A=
 /etc/selinux/([^/]*/)?users(/.*)?	=
system_u:object_r:selinux_config_t:s15:c0.c255=0A=
 /etc/selinux/([^/]*/)?policy(/.*)?	=
system_u:object_r:policy_config_t:s15:c0.c255=0A=
 /etc/selinux/([^/]*/)?src(/.*)?	=
system_u:object_r:policy_src_t:s15:c0.c255=0A=

------_=_NextPart_000_01C5E161.3DF30060--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
