Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA03530
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 17:32:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA27558
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 21:30:49 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id VAA27554
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 21:30:49 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA28086
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 17:32:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA23508
	for <selinux@tycho.nsa.gov>; Sat, 27 Apr 2002 21:27:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA13489
	for <selinux@tycho.nsa.gov>; Sun, 28 Apr 2002 01:26:04 GMT
Received: from mailandnews.com ([209.81.157.231])
	by jazzswing.ncsc.mil  with ESMTP id BAA13485
	for <selinux@tycho.nsa.gov>; Sun, 28 Apr 2002 01:26:04 GMT
Message-ID: <001a01c1ee54$093c60e0$780aa8c0@r213>
From: "f980215" <f980215@mailandnews.com>
To: <selinux@tycho.nsa.gov>
Subject: help: about boot message
Date: Sun, 28 Apr 2002 09:28:39 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,all

I have updated selinux-2.4.18 packages on redhat 7.2

I have seen these files:

  1) /etc/selinux/policy/file_context
     ================================
     /sbin/.*getty system_u:object_r:getty_exec_t

  2) /etc/selinux/policy/domains/programs/getty.te
     =============================================  
     role system_r types getty_t;
     allow getty_t tty_device_t:chr_file rw_file_perms;
     allow getty_t ttyfile:chr_file rw_file_perms;

  3) /etc/selinux/policy/types/device.te
     =================================== 
     type tty_device_t, file_type;

  4) /etc/selinux/policy/policy.conf
     ===============================
     allow getty_t tty_device_t:chr_file { ioctl read getattr access lock poll write
setattr append };
     allow getty_t ttyfile:chr_file { ioctl read getattr access lock poll write setattr append };

but , after reboot, I found error infomation:

* display on tty? console
  ===============
  INIT: Id "3" respawning too fast: disabled for 5 minutes

* /var/log/messages
  =================
  Apr 28 16:13:57 sea2 kernel:
  Apr 28 16:13:57 sea2 /sbin/mingetty[892]: /dev/tty2: Permission denied
  Apr 28 16:13:57 sea2 kernel: avc:  denied  { setattr } for  pid=881 exe=/sbin/mingetty path=/dev/tty3 dev=03:43 ino=36350 scontext=system_u:system_r:getty_t tcontext=system_u:object_r:file_t tclass=chr_file

Thanks for any help.

f980215


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
