Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7P5cJrT003247
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 01:38:19 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7P5bWLV020052
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 05:37:32 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 0638B61AFB
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 15:38:17 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 29351-10 for <selinux@tycho.nsa.gov>;
	Wed, 25 Aug 2004 15:38:16 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 934D061AFA
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 15:38:16 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 6A9A4B5877
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 15:38:12 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: hald
Date: Wed, 25 Aug 2004 15:38:11 +1000
References: <200408251418.56556.russell@coker.com.au>
In-Reply-To: <200408251418.56556.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DXCLBglZnWNlQ4Z"
Message-Id: <200408251538.11898.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_DXCLBglZnWNlQ4Z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 25 Aug 2004 14:18, Russell Coker <russell@coker.com.au> wrote:
> Attached is a patch to make the hald from rawhide work, it's against the
> latest CVS policy.

I've attached a new version, the only difference is that ioctl access is now 
granted to fixed_disk_device_t.  Yesterday a new version of hal appeared 
which now requires ioctl access...

hal seems to be still changing rapidly, so I expect that I'll be sending many 
more patches in.  However I think it's important to get these changes into 
the CVS so more people can test it while the changes are being made.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_DXCLBglZnWNlQ4Z
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="hald.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hald.diff"

--- /usr/src/se/policy/domains/program/unused/hald.te	2004-08-25 13:21:22.000000000 +1000
+++ domains/program/unused/hald.te	2004-08-23 20:35:07.000000000 +1000
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
 
+allow hald_t fixed_disk_device_t:blk_file { getattr read ioctl };
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

--Boundary-00=_DXCLBglZnWNlQ4Z--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
