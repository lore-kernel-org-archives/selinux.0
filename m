Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4U8kOpe025703
	for <selinux@tycho.nsa.gov>; Sat, 30 May 2009 04:46:24 -0400
Received: from mail.seekline.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4U8kcG2017221
	for <selinux@tycho.nsa.gov>; Sat, 30 May 2009 08:46:39 GMT
Date: Sat, 30 May 2009 10:46:12 +0200
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: cpebenito@tresys.com
Cc: selinux@tycho.nsa.gov
Subject: [refpolicy] libjackserver.so file context
Message-ID: <20090530084611.GA8305@vogon.seekline.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

libjackserver.so needs text relocation. Attached file solves the
problem.

cheers
Stefan

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="libjackserver.patch"

--- policy/modules/system/libraries.fc	2008-12-03 19:33:19.000000000 +0100
+++ policy/modules/system/libraries.fc	2009-05-30 10:35:10.000000000 +0200
@@ -151,6 +151,8 @@
 /usr/lib(64)?/xorg/modules/drivers/nvidia_drv\.o -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/xorg/modules/extensions/nvidia(-[^/]*)?/libglx\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
+/usr/lib(64)?/libjackserver\.so.*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+
 ifdef(`distro_debian',`
 /usr/lib32				-l	gen_context(system_u:object_r:lib_t,s0)
 ')

--gKMricLos+KVdGMg--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
