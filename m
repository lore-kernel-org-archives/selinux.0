Message-ID: <36282A1733C57546BE392885C0618592D39D3D@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>,
   "Daniel J Walsh (E-mail)"
	 <dwalsh@redhat.com>
Cc: Darrel Goeddel <DGoeddel@TrustedCS.com>
Subject: [PATCH] MLS booleans
Date: Thu, 20 Oct 2005 17:40:56 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5D5BE.F4534E90"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5D5BE.F4534E90
Content-Type: text/plain;
	charset="iso-8859-1"


I have attached a new MLS booleans which reflects the current strict
booleans file minus any policy not present in mls (i.e mozilla, mail). I
have also attached a diff for reference. This is applicable to Dan Walsh MLS
policy version 21

-Chad

 <<booleans>>  <<booleans.diff>> 

------_=_NextPart_000_01C5D5BE.F4534E90
Content-Type: application/octet-stream;
	name="booleans"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="booleans"

# This file should not not be modified.  =0A=
# If you want to customize your booleans, make changes to =
booleans.local =0A=
# or use "setsebool -P"=0A=
# This file will be replaced with the next rpm upgrade.=0A=
#=0A=
ftpd_is_daemon=3D1=0A=
ftp_home_dir=3D1=0A=
httpd_enable_cgi=3D1=0A=
httpd_enable_homedirs=3D1=0A=
httpd_ssi_exec=3D1=0A=
httpd_tty_comm=3D0=0A=
httpd_builtin_scripting=3D1=0A=
read_default_t=3D1=0A=
ssh_sysadm_login=3D1=0A=
staff_read_sysadm_file=3D1=0A=
user_ping=3D1=0A=
user_rw_noexattrfile=3D1=0A=
user_rw_usb=3D1=0A=
use_nfs_home_dirs=3D0=0A=
allow_ypbind=3D0=0A=
allow_kerberos=3D1=0A=
allow_write_xshm=3D1=0A=
read_untrusted_content=3D1=0A=
write_untrusted_content=3D1=0A=

------_=_NextPart_000_01C5D5BE.F4534E90
Content-Type: application/octet-stream;
	name="booleans.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="booleans.diff"

--- booleans.mls	2005-10-20 12:50:09.000000000 -0500=0A=
+++ booleans.mls.new	2005-10-20 14:26:48.683413187 -0500=0A=
@@ -10,8 +10,6 @@=0A=
 httpd_ssi_exec=3D1=0A=
 httpd_tty_comm=3D0=0A=
 httpd_builtin_scripting=3D1=0A=
-mozilla_readhome=3D1=0A=
-mozilla_writehome=3D1=0A=
 read_default_t=3D1=0A=
 ssh_sysadm_login=3D1=0A=
 staff_read_sysadm_file=3D1=0A=
@@ -22,3 +20,5 @@=0A=
 allow_ypbind=3D0=0A=
 allow_kerberos=3D1=0A=
 allow_write_xshm=3D1=0A=
+read_untrusted_content=3D1=0A=
+write_untrusted_content=3D1=0A=

------_=_NextPart_000_01C5D5BE.F4534E90--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
