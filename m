From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux List <SELinux@tycho.nsa.gov>
Subject: fix for typo in setfiles.te
Date: Fri, 9 Sep 2005 21:20:29 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DAXIDHWz8xvU9Hr"
Message-Id: <200509092120.35063.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_DAXIDHWz8xvU9Hr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_DAXIDHWz8xvU9Hr
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/setfiles.te.orig	2005-09-09 21:18:38.000000000 +1000
+++ domains/program/setfiles.te	2005-09-09 21:18:47.000000000 +1000
@@ -22,7 +22,7 @@
 ifdef(`distro_redhat', `
 domain_auto_trans(initrc_t, setfiles_exec_t, setfiles_t)
 ')
-can_access_pty(hostname_t, initrc)
+can_access_pty(setfiles_t, initrc)
 allow setfiles_t { ttyfile ptyfile tty_device_t admin_tty_type devtty_t }:chr_file { read write ioctl };
 
 allow setfiles_t self:unix_dgram_socket create_socket_perms;

--Boundary-00=_DAXIDHWz8xvU9Hr--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
