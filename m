Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7RBcArT019160
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 07:38:10 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7RBbLpX016570
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 11:37:22 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1706461AFE
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 21:38:08 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 19742-03 for <selinux@tycho.nsa.gov>;
	Fri, 27 Aug 2004 21:38:07 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9EA9261AFD
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 21:38:07 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 9F491B58C3
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 21:38:05 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: latest hald policy patch
Date: Fri, 27 Aug 2004 21:38:05 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_d0xLBu5FBZhixLU"
Message-Id: <200408272138.05091.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_d0xLBu5FBZhixLU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This one differs from the last in one line.

A recent patch we discussed (and I believe came to agreement on) was to change 
the file_contexts to label /dev/hdX as removable_device_t if it refers to a 
CD-ROM or DVD.  This means of course that hald needs to be able to read 
removable_device_t.

Apart from this it's the same as the last patch I sent.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_d0xLBu5FBZhixLU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="hald.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hald.diff"

--- /usr/src/se/policy/domains/program/unused/hald.te	2004-08-25 13:21:22.000000000 +1000
+++ domains/program/unused/hald.te	2004-08-27 21:14:31.000000000 +1000
@@ -10,14 +10,15 @@
 #
 # hald_exec_t is the type of the hald executable.
 #
-daemon_domain(hald, `, dbus_client_domain')
+daemon_domain(hald, `, dbus_client_domain, fs_domain')
 
-allow hald_t etc_t:file { getattr read };
-allow hald_t self:{ unix_dgram_socket unix_stream_socket } create_stream_socket_perms;
+allow hald_t { etc_t etc_runtime_t }:file { getattr read };
+allow hald_t self:unix_stream_socket create_stream_socket_perms;
+allow hald_t self:unix_dgram_socket create_socket_perms;
 
 allow hald_t dbusd_t:dbus { acquire_svc };
 
-allow hald_t self:file { getattr read };
+allow hald_t { self proc_t }:file { getattr read };
 
 allow hald_t { bin_t sbin_t }:dir search;
 allow hald_t hald_t:fifo_file rw_file_perms;
@@ -28,8 +29,14 @@
 allow hald_t self:capability { net_admin sys_admin };
 can_network(hald_t)
 
+allow hald_t { fixed_disk_device_t removable_device_t }:blk_file { getattr read ioctl };
+allow hald_t event_device_t:chr_file { getattr read };
+
 ifdef(`updfstab.te', `domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)')
-ifdef(`udev.te', `domain_auto_trans(hald_t, udev_exec_t, udev_t)')
+ifdef(`udev.te', `
+domain_auto_trans(hald_t, udev_exec_t, udev_t)
+allow udev_t hald_t:unix_dgram_socket sendto;
+')
 
 allow hald_t usbdevfs_t:dir search;
 allow hald_t usbdevfs_t:file { getattr read };

--Boundary-00=_d0xLBu5FBZhixLU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
