Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9HEJRNs028254
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 10:19:27 -0400 (EDT)
Received: from deep.phpwebhosting.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j9HEH3up029501
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 14:17:03 GMT
Message-ID: <43537A09.5080005@cobalt-financial.com>
Date: Mon, 17 Oct 2005 10:16:41 +0000
From: Unix Admin <unix@cobalt-financial.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Kernel woes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Greetings all. After a recent reboot to one of my servers, the kernel 
began showing the following errors:

[root@odin logs]# uname -a
Linux odin 2.6.9-11.ELsmp #1 SMP Wed Jun 8 17:54:20 CDT 2005 i686 i686 
i386 GNU/Linux

Oct 17 09:01:05 odin kernel: post_create:  setxattr failed, rc=28 
(dev=sda1 ino=8339458)
Oct 17 09:05:33 odin kernel: post_create:  setxattr failed, rc=28 
(dev=sda1 ino=8339457)
Oct 17 09:05:33 odin kernel: post_create:  setxattr failed, rc=28 
(dev=sda1 ino=8339458)
Oct 17 09:06:57 odin kernel: post_create:  setxattr failed, rc=28 
(dev=sda1 ino=8339457)
Oct 17 09:06:57 odin kernel: post_create:  setxattr failed, rc=28 
(dev=sda1 ino=8339458)

Oct 17 09:01:05 odin kernel: audit(1129554065.524:0): avc:  denied  { 
write } for  pid=527 comm=httpd name=log dev=tmpfs ino=271982 
scontext=root:system_r:httpd_t tcontext=root:object_r:device_t 
tclass=sock_file
Oct 17 09:05:33 odin kernel: audit(1129554333.429:0): avc:  denied  { 
write } for  pid=522 comm=httpd name=log dev=tmpfs ino=271982 
scontext=root:system_r:httpd_t tcontext=root:object_r:device_t 
tclass=sock_file
Oct 17 09:06:21 odin kernel: audit(1129554381.723:0): avc:  denied  { 
write } for  pid=524 comm=httpd name=log dev=tmpfs ino=271982 
scontext=root:system_r:httpd_t tcontext=root:object_r:device_t 
tclass=sock_file
Oct 17 09:06:57 odin kernel: audit(1129554417.668:0): avc:  denied  { 
write } for  pid=527 comm=httpd name=log dev=tmpfs ino=271982 
scontext=root:system_r:httpd_t tcontext=root:object_r:device_t 
tclass=sock_file
Oct 17 09:17:10 odin kernel: audit(1129555030.530:0): avc:  denied  { 
write } for  pid=522 comm=httpd name=log dev=tmpfs ino=271982 
scontext=root:system_r:httpd_t tcontext=root:object_r:device_t 
tclass=sock_file
Oct 17 09:17:32 odin kernel: audit(1129555052.254:0): avc:  denied  { 
write } for  pid=525 comm=httpd name=log dev=tmpfs ino=271982 
scontext=root:system_r:httpd_t tcontext=root:object_r:device_t 
tclass=sock_file

No changes were made to anything but we had to recently reboot due to an 
IP collision. Any ideas on why this is happening, any pointers on where 
to check for perhaps permission errors?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
