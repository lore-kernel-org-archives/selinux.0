Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA25582
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 13:29:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA21648
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 18:28:49 GMT
Received: from vorpal.mcs.drexel.edu (vorpal.mcs.drexel.edu [129.25.6.250])
	by jazzband.ncsc.mil  with ESMTP id SAA21642
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 18:28:49 GMT
Subject: lsm-selinux-200111191100.tgz
From: Justin Smith <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
In-Reply-To: <Pine.GSO.4.33.0111261601060.21971-100000@raven>
References: <Pine.GSO.4.33.0111261601060.21971-100000@raven>
Content-Type: text/plain
Date: 27 Nov 2001 13:24:02 -0500
Message-Id: <1006885442.1246.0.camel@vorpal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


When I did make install in module, it did not complete successfully
because the makefile expected a directory to be named

/usr/src/selinux/module/selinux_plug/include/asm

and it was really 

/usr/src/selinux/module/selinux_plug/include/asm-i386

When I moved asm-i386 to asm it worked and I was able to boot
selinux.

Having done so, I received the following messages:

avc:  denied  { mounton } for  pid=75 exe=/bin/mount path=/bus/usb
dev=00:03 ino=4459
   scontext=system_u:system_r:mount_t
   tcontext=system_u:object_r:proc_t
   tclass=dir

task_precondition:  assigning context system_u:system_r:init_t to pid 2
exe=none

usb-uhci.c: v1.268:USB Universal Host Controller Interface driver

avc:  denied  { search } for  pid=93 exe=/bin/cat dev=00:08 ino=1
   scontext=system_u:system_r:initrc_t
   tcontext=system_u:object_r:unlabeled_t
   tclass=dir

avc:  denied  { read } for  pid=93 exe=/bin/cat path=/devices dev=00:08
ino=2
   scontext=system_u:system_r:initrc_t
   tcontext=system_u:object_r:unlabeled_t
   tclass=file

avc:  denied  { getattr } for  pid=93 exe=/bin/cat path=/devices
dev=00:08 ino=2
   scontext=system_u:system_r:initrc_t
   tcontext=system_u:object_r:unlabeled_t
   tclass=file

avc:  denied  { write } for  pid=10 exe=/bin/bash path=/etc/mtab
dev=03:01 ino=28440
   scontext=system_u:system_r:initrc_t
   tcontext=system_u:object_r:file_t
   tclass=file


(many times)

.................

avc:  denied  { create } for  pid=296 exe=/sbin/ipchains
   scontext=system_u:system_r:initrc_t
   tcontext=system_u:system_r:initrc_t
   tclass=rawip_socket

avc:  denied  { setopt } for  pid=296 exe=/sbin/ipchains lport=255
   scontext=system_u:system_r:initrc_t
   tcontext=system_u:system_r:initrc_t
   tclass=rawip_socket


avc:  denied  { unlink } for  pid=752 exe=/bin/umount path=/etc/mtab
dev=03:01 ino=28440
   scontext=system_u:system_r:mount_t
   tcontext=system_u:object_r:file_t
   tclass=file

avc:  denied  { search } for  pid=838 exe=/usr/sbin/httpd
path=/www/tomcat dev=03:05 ino=336750
   scontext=system_u:system_r:httpd_t
   tcontext=system_u:object_r:httpd_user_script_rw_t
   tclass=dir


(plus many messages connected with running the Gnome desktop)

--



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
