Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NLwJrT021788
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 17:58:19 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NLvWAS003182
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 21:57:33 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 296AABF8A
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 22:58:17 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 30801-01-3 for <selinux@tycho.nsa.gov>;
	Mon, 23 Aug 2004 22:58:14 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 1A538BF88
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 22:58:14 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BzN0P-0003cl-To
	for selinux@tycho.nsa.gov; Mon, 23 Aug 2004 23:09:33 +0100
Date: Mon, 23 Aug 2004 23:09:33 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: patch to automount
Message-ID: <20040823220933.GF13677@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jkO+KyKz7TfD21mV"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

okay.

this one requires some explanation.

i modified the usb-mount script i found [google search] to,
instead of manually mounting and unmounting the drive, to
update autofs files, do an /etc/init.d/autofs reload, that
sort of thing.

by adding an entry into /etc/autofs.master with a timeout of 2
seconds, the age-old problem under linux of "oo, you muuust
force the user to unmount the driiive" which is just such total
bullshit _no_ sane ordinary computer user gives a monkeys about
umount, well this problem just ... goes away [and becomes autofs's
problem :)]

in order to avoid having to give [my new] usbmount.te permission
to write to /etc, which i didn't want to do, i instead have
made a separate filetype for /etc/auto.usb, /etc/auto.misc and
/etc/auto.net.

now i feel sure that someone else will think of better ways to do
this however here is at least a step in the right direction.

if anyone actually _wants_ the usbmount.te policy i wrote, let me know.
it's not very good, it involves hacks to hotplug.te as well,
but hey, ItWorks(tm).

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=automount

diff -Naur 
--- default.1.14/domains/program/automount.te	2004-08-02 08:28:37.000000000 +0100
+++ current/domains/program/automount.te	2004-08-22 18:08:27.000000000 +0100
@@ -15,6 +15,7 @@
 allow automount_t urandom_device_t:chr_file read;
 
 type autofs_t, fs_type, root_dir_type, sysadmfile;
+type automount_etc_t, fs_type, sysadmfile;
 
 # for if the mount point is not labelled
 allow automount_t file_t:dir getattr;
@@ -24,7 +25,7 @@
 allow automount_t fs_type:dir getattr;
 allow autofs_t self:filesystem associate;
 
-allow automount_t { etc_t etc_runtime_t }:file { getattr read };
+allow automount_t { automount_etc_t etc_t etc_runtime_t }:file { getattr read };
 allow automount_t proc_t:file { getattr read };
 allow automount_t self:process { setpgid setsched };
 allow automount_t self:capability { sys_nice };
@@ -32,7 +33,7 @@
 allow automount_t self:unix_dgram_socket create_socket_perms;
 
 # because config files can be shell scripts
-can_exec(automount_t, etc_t)
+can_exec(automount_t, automount_etc_t)
 
 can_network(automount_t)
 can_ypbind(automount_t)
@@ -65,5 +66,5 @@
 allow kernel_t autofs_t:dir { getattr ioctl read search };
 
 allow automount_t home_root_t:dir { getattr };
-allow automount_t mnt_t:dir { getattr };
+allow automount_t mnt_t:dir { getattr search };
 
diff -Naur 
--- default.1.14/domains/program/initrc.te	2004-08-02 08:28:37.000000000 +0100
+++ current/domains/program/initrc.te	2004-08-22 18:09:23.000000000 +0100
@@ -312,3 +312,27 @@
 #
 allow initrc_t security_t:dir { getattr search };
 allow initrc_t security_t:file { getattr read };
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+allow initrc_t automount_etc_t:file { getattr };
+	#EXE=/bin/bash  PATH=/etc/auto.misc   :  getattr
+	#EXE=/bin/bash  PATH=/etc/auto.misc   :  getattr
+	#EXE=/bin/bash  PATH=/etc/auto.usb   :  getattr
+	#EXE=/bin/bash  PATH=/etc/auto.usb   :  getattr
+
diff -Naur 
--- default.1.14/file_contexts/program/automount.fc	2004-08-02 08:28:37.000000000 +0100
+++ current/file_contexts/program/automount.fc	2004-08-06 17:23:45.000000000 +0100
@@ -2,3 +2,6 @@
 /usr/sbin/automount	--	system_u:object_r:automount_exec_t
 /etc/apm/event\.d/autofs --	system_u:object_r:automount_exec_t
 /var/run/autofs(/.*)?		system_u:object_r:automount_var_run_t
+/etc/auto.misc		--	system_u:object_r:automount_etc_t
+/etc/auto.net		--	system_u:object_r:automount_etc_t
+/etc/auto.usb		--	system_u:object_r:automount_etc_t

--jkO+KyKz7TfD21mV--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
