Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA19124
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2001 09:10:55 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA20273
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2001 14:10:43 GMT
Received: from csoc-mail-msfc.csoconline.com (csoc-mail-msfc.csoconline.com [140.169.36.3])
	by jazzswing.ncsc.mil  with ESMTP id OAA20269
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2001 14:10:43 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524083@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Redhat 7
Date: Wed, 14 Feb 2001 08:10:47 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Hello All,

I cleaned up the boot up to where are only a few error messages. 
I have included the error message any sujestions would be a huge help.

Mark
Feb 13 23:48:41 CDEV2-186 kernel: avc:  denied  { read } for  pid=69
exe=/bin/mount path=/dev/hda1 dev=03:01 ino=176886
Feb 13 23:48:41 CDEV2-186 kernel:    scontext=system_u:system_r:initrc_t
Feb 13 23:48:41 CDEV2-186 kernel:
tcontext=system_u:object_r:fixed_disk_device_t
Feb 13 23:48:41 CDEV2-186 kernel:    tclass=blk_file
Feb 13 23:48:41 CDEV2-186 kernel: 
Feb 13 23:48:41 CDEV2-186 kernel: avc:  denied  { read } for  pid=179
exe=/sbin/hdparm path=/dev/hda dev=03:01 ino=176885
Feb 13 23:48:41 CDEV2-186 kernel:    scontext=system_u:system_r:initrc_t
Feb 13 23:48:41 CDEV2-186 kernel:
tcontext=system_u:object_r:fixed_disk_device_t
Feb 13 23:48:41 CDEV2-186 kernel:    tclass=blk_file
Feb 13 23:48:41 CDEV2-186 kernel: 
Feb 13 23:48:41 CDEV2-186 kernel: avc:  denied  { ioctl } for  pid=179
exe=/sbin/hdparm path=/dev/hda dev=03:01 ino=176885
Feb 13 23:48:41 CDEV2-186 kernel:    scontext=system_u:system_r:initrc_t
Feb 13 23:48:41 CDEV2-186 kernel:
tcontext=system_u:object_r:fixed_disk_device_t
Feb 13 23:48:41 CDEV2-186 kernel:    tclass=blk_file
Feb 13 23:50:00 CDEV2-186 kernel: avc:  denied  { sys_module } for  pid=529
exe=/sbin/insmod capability=16
Feb 13 23:50:00 CDEV2-186 kernel:
scontext=system_u:system_r:system_crond_t
Feb 13 23:50:00 CDEV2-186 kernel:
tcontext=system_u:system_r:system_crond_t
Feb 13 23:50:00 CDEV2-186 kernel:    tclass=capability

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
