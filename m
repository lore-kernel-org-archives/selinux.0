Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2O0S1x6000375
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2003 19:28:03 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2O0S0R1028141
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 00:28:00 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h2O0Rjj9028138 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 00:27:56 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 2C05DBF43
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 11:27:38 +1100 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 27817-06
 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 11:27:36 +1100 (EST)
Received: from tsv.sws.net.au (unknown [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id C58A9BF42
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 11:27:36 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 4B0FB9253C
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 11:27:36 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id CB9C825B
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 01:27:24 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: essential patches
Date: Mon, 24 Mar 2003 01:27:23 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rDlf+ECFO5ynOqA"
Message-Id: <200303240127.23991.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_rDlf+ECFO5ynOqA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch file is essential for getting a working system based on the 
current CVS policy.

initrc_t needs r_dir_perms access to /dev for some startup scripts (and there 
is no good reason to stop it).

Any program that has access to create pty devices needs search access to 
/dev/pts (without such access it can't create a pty which makes no sense).

user_t needs search access to /boot and read access to the system.map files 
for the wchan.

Many programs in user_t request read access to sysctl_kernel_t dir and file, 
and for var_lib_t.  We could probably survive without sysctl_kernel_t, but 
var_lib_t access is essential to many programs (particularly some perl 
scripts used for Debian package building).  If we deny this then we need to 
add some new types for the things that should be allowed.

For random_device_t writing by a hostile user apparently does no harm 
according to all the best sources of information available to me.  There are 
probably some people on this list who know more about cryptology than the 
people who wrote the /dev/random code for Linux.  If an expert decrees that 
we should not allow write access then I'll accept that.  As for read access, 
too many programs break when user_t can't access it, EG all SSL clients...

As for ifconfig, without udp_socket access it won't work when called from 
dhclient (dhcpc_t) and therefore denying such access breaks every DHCP 
system.  I'm not sure why ifconfig looks for access to sysctl_net_t:dir as it 
doesn't seem to do anything to files under that dir.  But based on my 
experience with that program I'm not inclined to turn things off without a 
really good reason.  ifconfig can break any part of your network setup if it 
runs amok, denying it access to sysctl_net_t doesn't make any sense to me.


I've tried the current CVS policy on a few machines with different 
configurations and they all failed to work correctly on several counts.


This patch can be applied independantly of the other patches I've posted 
recently.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_rDlf+ECFO5ynOqA
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ru /tmp/policy/domains/program/initrc.te ./domains/program/initrc.te
--- /tmp/policy/domains/program/initrc.te	2003-03-22 21:52:23.000000000 +0100
+++ ./domains/program/initrc.te	2003-03-23 15:09:25.000000000 +0100
@@ -32,6 +32,9 @@
 allow initrc_t self:unix_stream_socket create_socket_perms;
 allow initrc_t self:fifo_file rw_file_perms;
 
+# allow listing the contents of /dev
+allow initrc_t device_t:dir r_dir_perms;
+
 # Read the root directory of a usbdevfs filesystem, and
 # the devices and drivers files.  Permit stating of the
 # device nodes, but nothing else.
@@ -254,3 +259,4 @@
 # Rules for the run_init_t domain.
 #
 run_program(sysadm_t, sysadm_r, init, initrc_exec_t, initrc_t)
+allow initrc_t privfd:fd use;
diff -ru /tmp/policy/macros/global_macros.te ./macros/global_macros.te
--- /tmp/policy/macros/global_macros.te	2003-03-22 21:52:43.000000000 +0100
+++ ./macros/global_macros.te	2003-03-23 14:53:05.000000000 +0100
@@ -531,6 +546,9 @@
 # Read and write my pty files.
 allow $1_t $1_devpts_t:chr_file { setattr rw_file_perms };
 
+# allow searching /dev/pts
+allow $1_t devpts_t:dir search;
+
 ifdef(`devfsd.te', `
 allow $1_t device_t:filesystem getattr;
 ')
@@ -605,6 +623,11 @@
 allow $1 self:msgq rw_msgq_perms;
 allow $1 self:shm  rw_shm_perms;
 
+# Use descriptors created by login, sshd, or newrole.
+allow $1 privfd:fd use;
+
+# Use descriptors created by mount (e.g. NFS).
+allow $1 mount_t:fd use;
 ')
 
 #
diff -ru /tmp/policy/macros/user_macros.te ./macros/user_macros.te
--- /tmp/policy/macros/user_macros.te	2003-03-22 21:52:43.000000000 +0100
+++ ./macros/user_macros.te	2003-03-24 00:50:41.000000000 +0100
@@ -78,6 +78,10 @@
 allow $1_t sshd_t:unix_stream_socket rw_stream_socket_perms;
 ')dnl end of ssh section
 
+allow $1_t boot_t:dir { getattr search };
+dontaudit $1_t boot_t:dir read;
+allow $1_t system_map_t:file { getattr read };
+
 # Type for tmpfs/shm files.
 type $1_tmpfs_t, file_type, sysadmfile, tmpfsfile;
 # Use the type when creating files in tmpfs.
@@ -286,6 +301,12 @@
 allow $1_t var_run_t:dir r_dir_perms;
 allow $1_t var_run_t:{ file lnk_file } r_file_perms;
 
+allow $1_t var_lib_t:dir r_dir_perms;
+allow $1_t var_lib_t:file r_file_perms;
+
+allow $1_t sysctl_kernel_t:dir search;
+allow $1_t sysctl_kernel_t:file { getattr read };
+
 # Read /etc.
 allow $1_t etc_t:dir r_dir_perms;
 allow $1_t etc_t:notdevfile_class_set r_file_perms;
@@ -301,7 +322,7 @@
 
 # Read and write /dev/tty and /dev/null.
 allow $1_t devtty_t:chr_file rw_file_perms;
-allow $1_t { null_device_t zero_device_t }:chr_file rw_file_perms;
+allow $1_t { null_device_t zero_device_t random_device_t }:chr_file rw_file_perms;
 
 # Do not audit write denials to /etc/ld.so.cache.
 dontaudit $1_t ld_so_cache_t:file write;
diff -ru /tmp/policy/domains/program/ifconfig.te ./domains/program/ifconfig.te
--- /tmp/policy/domains/program/ifconfig.te	2003-03-22 21:52:23.000000000 +0100
+++ ./domains/program/ifconfig.te	2003-03-23 22:09:20.000000000 +0100
@@ -48,8 +48,10 @@
 
 allow ifconfig_t tun_tap_device_t:chr_file { read write };
 
+allow ifconfig_t fs_t:filesystem getattr;
+
 # ifconfig attempts to create a UDP socket and search some sysctl entries.
 # Don't audit those attempts; comment out these rules if it is desired to
 # see the denials.
-dontaudit ifconfig_t sysctl_t:dir search;
-dontaudit ifconfig_t self:udp_socket create;
+allow ifconfig_t { sysctl_t sysctl_net_t }:dir search;
+allow ifconfig_t self:udp_socket create_socket_perms;

--Boundary-00=_rDlf+ECFO5ynOqA--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
