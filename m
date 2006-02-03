Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k13Eh2Xf002521
	for <selinux@tycho.nsa.gov>; Fri, 3 Feb 2006 09:43:02 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k13Effnm029298
	for <selinux@tycho.nsa.gov>; Fri, 3 Feb 2006 14:41:42 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id EC84461B03
	for <selinux@tycho.nsa.gov>; Sat,  4 Feb 2006 01:42:56 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 10525-10 for <selinux@tycho.nsa.gov>;
	Sat, 4 Feb 2006 01:42:56 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 4CA6561B02
	for <selinux@tycho.nsa.gov>; Sat,  4 Feb 2006 01:42:56 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux List <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>
Subject: MCS policy patch
Date: Sat, 4 Feb 2006 01:18:02 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iY24D8693AZrbSz"
Message-Id: <200602040118.10784.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_iY24D8693AZrbSz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch makes MCS a discretionary policy instead of being an 
advisory policy as it is at the moment.  This denies a process the ability to 
launch, kill, or ptrace a process unless it's level dominates that of the 
target process.  Also the same restriction is placed on creation and 
relabelto for files, directories etc.

It still doesn't place any MCS restrictions on read/write for file system 
objects other than files, but allowing for example a process to create a 
directory in a context that it could not relabel a directory to or from is 
bogus.

Also my patch denies the ability to create file system objects with ranges.  
We have no way of using such ranges so I believe that we don't want them 
created.  They are at best a waste of space and at worst allow programs to 
perform in ways that will be unexpected when used by people who don't 
understand them (better to give an error message than have the system give a 
result that the user doesn't expect when they do the wrong thing).

Dan, is it too late for this to be in FC5T3?  I've intentionally removed all 
the bits that are complex or likely to cause breakage from this patch to 
allow it to be included...


Also this patch adds a new type usb_device_t, bluetooth.te needs policy to 
access it, but I don't have time to write it before sending this patch.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_iY24D8693AZrbSz
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pol3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pol3.diff"

diff -ru serefpolicy-2.2.9.orig/policy/mcs serefpolicy-2.2.9/policy/mcs
--- serefpolicy-2.2.9.orig/policy/mcs	2006-01-31 10:41:22.000000000 +1100
+++ serefpolicy-2.2.9/policy/mcs	2006-02-04 00:47:25.000000000 +1100
@@ -137,15 +137,28 @@
 # Only files are constrained by MCS at this stage.
 #
 mlsconstrain file { write setattr append unlink link rename
-		    create ioctl lock execute } (h1 dom h2);
+		    ioctl lock execute relabelfrom } (h1 dom h2);
+
+mlsconstrain file { create relabelto } ((h1 dom h2) and (l2 eq h2));
 
 mlsconstrain file { read } ((h1 dom h2) or 
 			    ( t1 == mlsfileread ));
 
 
 # new file labels must be dominated by the relabeling subject clearance
-mlsconstrain { dir file lnk_file chr_file blk_file sock_file fifo_file } { relabelfrom relabelto }
+mlsconstrain { dir lnk_file chr_file blk_file sock_file fifo_file } { relabelfrom }
 	( h1 dom h2 );
+mlsconstrain { dir lnk_file chr_file blk_file sock_file fifo_file } { create relabelto }
+	(( h1 dom h2 ) and ( l2 eq h2 ));
+
+mlsconstrain process { ptrace } ( h1 dom h2 );
+
+mlsconstrain process { transition dyntransition } (( h1 dom h2 ) or
+		( t1 == getty_t ) or ( t1 == init_t ) or ( t1 == initrc_t ) or
+		( t1 == kernel_t ));
+
+mlsconstrain process { sigkill sigstop signal } ( h1 dom h2 ) or
+		( t1 == init_t ) or ( t1 == initrc_t );
 
 define(`nogetattr_file_perms', `{ create ioctl read lock write setattr append 
 link unlink rename relabelfrom relabelto }')
diff -ru serefpolicy-2.2.9.orig/policy/modules/admin/kudzu.te serefpolicy-2.2.9/policy/modules/admin/kudzu.te
--- serefpolicy-2.2.9.orig/policy/modules/admin/kudzu.te	2006-01-31 10:41:23.000000000 +1100
+++ serefpolicy-2.2.9/policy/modules/admin/kudzu.te	2006-02-04 00:21:13.000000000 +1100
@@ -24,7 +24,6 @@
 allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config mknod };
 dontaudit kudzu_t self:capability sys_tty_config;
 allow kudzu_t self:process { signal_perms execmem };
-auditallow kudzu_t self:process execmem; 
 allow kudzu_t self:fifo_file rw_file_perms;
 allow kudzu_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow kudzu_t self:unix_dgram_socket create_socket_perms;
diff -ru serefpolicy-2.2.9.orig/policy/modules/kernel/devices.fc serefpolicy-2.2.9/policy/modules/kernel/devices.fc
--- serefpolicy-2.2.9.orig/policy/modules/kernel/devices.fc	2006-01-31 10:41:23.000000000 +1100
+++ serefpolicy-2.2.9/policy/modules/kernel/devices.fc	2006-02-04 00:59:07.000000000 +1100
@@ -78,6 +78,7 @@
 /dev/usb/lp.*		-c	gen_context(system_u:object_r:printer_device_t,s0)
 /dev/usb/mdc800.*	-c	gen_context(system_u:object_r:scanner_device_t,s0)
 /dev/usb/scanner.*	-c	gen_context(system_u:object_r:scanner_device_t,s0)
+/dev/bus/usb/.*/[0-9]+	-c	gen_context(system_u:object_r:usb_device_t,s0)
 
 ifdef(`distro_redhat',`
 # originally from named.fc
diff -ru serefpolicy-2.2.9.orig/policy/modules/kernel/devices.te serefpolicy-2.2.9/policy/modules/kernel/devices.te
--- serefpolicy-2.2.9.orig/policy/modules/kernel/devices.te	2006-01-31 10:41:23.000000000 +1100
+++ serefpolicy-2.2.9/policy/modules/kernel/devices.te	2006-02-04 01:00:44.000000000 +1100
@@ -159,6 +159,11 @@
 genfscon usbfs / gen_context(system_u:object_r:usbfs_t,s0)
 genfscon usbdevfs / gen_context(system_u:object_r:usbfs_t,s0)
 
+#
+# usb_device_t is the type for /dev/bus/usb/[0-9]+/[0-9]+
+type usb_device_t;
+dev_node(usb_device_t)
+
 type v4l_device_t;
 dev_node(v4l_device_t)
 

--Boundary-00=_iY24D8693AZrbSz--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
