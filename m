Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6D1vorT006775
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 21:57:50 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6D1vODC015702
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 01:57:26 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 82F8D61C9E
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 11:57:41 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 10237-02 for <selinux@tycho.nsa.gov>;
	Tue, 13 Jul 2004 11:57:41 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 024FE61C9D
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 11:57:40 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B456FB59A3
	for <selinux@tycho.nsa.gov>; Tue, 13 Jul 2004 11:57:38 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: udev.te
Date: Tue, 13 Jul 2004 11:57:35 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PG08Au/9DuHRTjK"
Message-Id: <200407131157.35699.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_PG08Au/9DuHRTjK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch adds a new type for /dev/udev.tbl , it uses the attribute 
dbus_client_domain instead of just adding rules (incidentally the rules added 
didn't include dbusd_t:dbus send_msg access so it's likely that using 
dbus_client_domain will make it work in situations when the current policy 
wouldn't).

allow restorecon_t udev_t:unix_dgram_socket { read write };

My policy doesn't have the above line.  I suspect that restorecon and udev are 
not communicating via unix domain sockets and that it's just there because of 
a bug in udev which lets the wrong file handles be inherited.  Could someone 
test out dontaudit and see how it goes?

allow udev_t var_lock_t:dir { search };
allow udev_t var_lock_t:file { getattr read };

What are the above two lines for?  Why not use lock_domain()?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_PG08Au/9DuHRTjK
Content-Type: text/x-diff;
  charset="us-ascii";
  name="udev.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="udev.diff"

--- /usr/src/se/policy/domains/program/unused/udev.te	2004-07-13 00:18:11.000000000 +1000
+++ domains/program/unused/udev.te	2004-07-13 11:51:52.000000000 +1000
@@ -9,7 +9,7 @@
 #
 # udev_exec_t is the type of the udev executable.
 #
-daemon_domain(udev, `, privmodule, privmem, fs_domain, privfd')
+daemon_domain(udev, `, privmodule, privmem, fs_domain, privfd, dbus_client_domain')
 
 general_domain_access(udev_t)
 
@@ -22,8 +22,9 @@
 #
 # Rules used for udev
 #
-create_dir_file(udev_t, device_t)
-allow udev_t self:capability { chown sys_admin dac_override dac_read_search mknod fsetid };
+type udev_tbl_t, file_type, sysadmfile;
+file_type_auto_trans(udev_t, device_t, udev_tbl_t, file)
+allow udev_t self:capability { chown dac_override fowner fsetid sys_admin mknod };
 allow udev_t self:file { getattr read };
 allow udev_t self:unix_stream_socket {connectto create_stream_socket_perms};
 allow udev_t self:unix_dgram_socket create_socket_perms;
@@ -58,8 +59,6 @@
 domain_auto_trans(initrc_t, udev_exec_t, udev_t)
 domain_auto_trans(kernel_t, udev_exec_t, udev_t)
 domain_auto_trans(udev_t, restorecon_exec_t, restorecon_t)
-allow restorecon_t udev_t:unix_dgram_socket { read write };
-
 allow udev_t devpts_t:dir { search };
 allow udev_t etc_runtime_t:file { getattr read };
 allow udev_t etc_t:file { ioctl };
@@ -77,12 +76,5 @@
 can_exec(udev_t, consoletype_exec_t)
 ')
 domain_auto_trans(udev_t, ifconfig_exec_t, ifconfig_t)
-allow udev_t var_lock_t:dir { search };
-allow udev_t var_lock_t:file { getattr read };
-ifdef(`dbusd.te', `
-allow udev_t dbusd_t:unix_stream_socket { connectto };
-allow udev_t dbusd_var_run_t:dir { search };
-allow udev_t dbusd_var_run_t:sock_file { write }; 
-')
 
-dontaudit udev_t file_t:dir { search };
+dontaudit udev_t file_t:dir search;
--- /usr/src/se/policy/file_contexts/program/udev.fc	2004-05-12 05:10:51.000000000 +1000
+++ file_contexts/program/udev.fc	2004-07-05 23:14:35.000000000 +1000
@@ -4,3 +4,4 @@
 /sbin/udevd	--	system_u:object_r:udev_exec_t
 /etc/dev.d(/.*)? 	system_u:object_r:udev_helper_exec_t
 /etc/hotplug.d/default/udev.* system_u:object_r:udev_helper_exec_t
+/dev/udev.tbl	--	system_u:object_r:udev_tbl_t

--Boundary-00=_PG08Au/9DuHRTjK--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
