From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>
Subject: postfix policy
Date: Sat, 9 Aug 2003 16:26:49 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_P4WC3C3L49QAXCPQH56N"
Message-Id: <200308091626.49541.carstengrohmann@gmx.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_P4WC3C3L49QAXCPQH56N
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Russel,

some systems have /usr/lib/sendmail as an link to=20
/usr/sbin/sendmail. The attached patch contains the changes.
Would you like to add it to your postfix policy?

Greetings

Carsten
--------------Boundary-00=_P4WC3C3L49QAXCPQH56N
Content-Type: text/x-diff;
  charset="us-ascii";
  name="postfix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="postfix.diff"

--- mta.orig.fc	2003-03-14 21:08:47.000000000 +0100
+++ mta.fc	2003-08-09 16:20:19.000000000 +0200
@@ -1,5 +1,6 @@
 # types for general mail servers
 /usr/sbin/sendmail(.sendmail)?  system_u:object_r:sendmail_exec_t
+/usr/lib/sendmail               system_u:object_r:sendmail_exec_t
 /etc/aliases                    system_u:object_r:etc_aliases_t
 /etc/aliases\.db                system_u:object_r:etc_aliases_t
 /var/spool/mail(/.*)?           system_u:object_r:mail_spool_t
--- postfix.orig.te	2003-07-29 21:15:09.000000000 +0200
+++ postfix.te	2003-08-09 16:22:04.000000000 +0200
@@ -75,6 +75,7 @@
 allow postfix_master_t sysctl_kernel_t:file r_file_perms;
 allow postfix_master_t self:fifo_file rw_file_perms;
 allow postfix_master_t usr_t:file r_file_perms;
+allow postfix_master_t sendmail_exec_t:lnk_file { read };
 can_exec(postfix_master_t, { shell_exec_t bin_t postfix_exec_t })
 # chown is to set the correct ownership of queue dirs
 allow postfix_master_t self:capability { chown dac_override kill setgid setuid net_bind_service };

--------------Boundary-00=_P4WC3C3L49QAXCPQH56N--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
