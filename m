Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7RBg7rT019190
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 07:42:07 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7RBg4oM013705
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 11:42:05 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 7AAA561AFE
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 21:42:04 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 19766-03 for <selinux@tycho.nsa.gov>;
	Fri, 27 Aug 2004 21:42:04 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 17F9661AFD
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 21:42:04 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 1491CB58C3
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 21:41:37 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: file_contexts/types.fc
Date: Fri, 27 Aug 2004 21:41:36 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_w3xLBHMyfFhvfFN"
Message-Id: <200408272141.36561.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_w3xLBHMyfFhvfFN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch changes file_contexts/types.fc, it removes a bogus entry 
for /dev/mdsp (it's a DSP board whatever that means, not a hard disk).

It fixes an error in the tape device labelling which missed some entries, and 
it adds a Debian specific entry for fonts.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_w3xLBHMyfFhvfFN
Content-Type: text/x-diff;
  charset="us-ascii";
  name="types.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="types.diff"

--- /usr/src/se/policy/file_contexts/types.fc	2004-08-24 16:01:25.000000000 +1000
+++ file_contexts/types.fc	2004-08-27 21:40:43.000000000 +1000
@@ -150,7 +150,6 @@
 /u?dev/ida/[^/]*	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/dasd[^/]*	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/flash[^/]*	-b	system_u:object_r:fixed_disk_device_t
-/u?dev/mdsp.*		-c	system_u:object_r:fixed_disk_device_t
 /u?dev/nb[^/]+		-b	system_u:object_r:fixed_disk_device_t
 /u?dev/ataraid/.*	-b	system_u:object_r:fixed_disk_device_t
 /u?dev/loop.*		-b	system_u:object_r:fixed_disk_device_t
@@ -218,7 +217,7 @@
 /u?dev/amixer.*		-c	system_u:object_r:sound_device_t
 /u?dev/snd/.*		-c	system_u:object_r:sound_device_t
 /u?dev/n?[hs]t[0-9].*	-c	system_u:object_r:tape_device_t
-/u?dev/(n?raw)?[qr]ft[0-3] -c	system_u:object_r:tape_device_t
+/u?dev/n?(raw)?[qr]ft[0-3] -c	system_u:object_r:tape_device_t
 /u?dev/n?z?qft[0-3]	-c	system_u:object_r:tape_device_t
 /u?dev/n?tpqic[12].*	-c	system_u:object_r:tape_device_t
 /u?dev/ht[0-1]		-b	system_u:object_r:tape_device_t
@@ -415,6 +414,9 @@
 # Fonts dir
 #
 /usr/X11R6/lib/X11/fonts(/.*)?		system_u:object_r:fonts_t
+ifdef(`distro_debian', `
+/var/lib/msttcorefonts(/.*)?		system_u:object_r:fonts_t
+')
 /usr/share/fonts(/.*)?			system_u:object_r:fonts_t
 /usr/local/share/fonts(/.*)?		system_u:object_r:fonts_t
 

--Boundary-00=_w3xLBHMyfFhvfFN--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
