Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA07450
	for <selinux@tycho.nsa.gov>; Sun, 2 Sep 2001 12:27:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA29131
	for <selinux@tycho.nsa.gov>; Sun, 2 Sep 2001 16:26:10 GMT
Received: from donald.oleane.net (APuteaux-102-1-5-74.abo.wanadoo.fr [193.253.243.74])
	by jazzswing.ncsc.mil  with ESMTP id QAA29127
	for <selinux@tycho.nsa.gov>; Sun, 2 Sep 2001 16:26:09 GMT
Message-Id: <200109021627.SAA09636@donald.oleane.net>
Content-Type: text/plain;
  charset="us-ascii"
From: Paul Rolland <rol@as2917.net>
Reply-To: rol@as2917.net
To: selinux@tycho.nsa.gov
Subject: Question regarding security policy configuration
Date: Sun, 2 Sep 2001 18:27:28 +0200
Cc: rol@as2917.net
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I've just installed for the first time SElinux on a running 2.4.9 Linux box.
As this is my first contact with SELinux, I've been doing exactly what's
described in the README file, and I now have done all the steps described,
and restarted successfully my box.

The good news is : the box is running.
The bad news is : I've a bunch of :


Aug 29 17:58:46 www-dev kernel: avc:  denied  { read write } for  pid=58 
exe=/bi
n/mount path=/etc/mtab dev=08:02 ino=166389
Aug 29 17:58:46 www-dev kernel:    scontext=system_u:system_r:mount_t
Aug 29 17:58:46 www-dev kernel:    tcontext=system_u:object_r:file_t
Aug 29 17:58:46 www-dev kernel:    tclass=file
Aug 29 17:58:46 www-dev kernel:
Aug 29 17:58:46 www-dev kernel: avc:  denied  { read append } for  pid=58 
exe=/b
in/mount path=/etc/mtab dev=08:02 ino=166389
Aug 29 17:58:46 www-dev kernel:    scontext=system_u:system_r:mount_t
Aug 29 17:58:46 www-dev kernel:    tcontext=system_u:object_r:file_t
Aug 29 17:58:46 www-dev kernel:    tclass=file
Aug 29 17:58:46 www-dev kernel:
Aug 29 17:58:46 www-dev kernel: avc:  denied  { write } for  pid=10 
exe=/bin/bas
h path=/etc/mtab dev=08:02 ino=166389
Aug 29 17:58:46 www-dev kernel:    scontext=system_u:system_r:initrc_t
Aug 29 17:58:46 www-dev kernel:    tcontext=system_u:object_r:file_t
Aug 29 17:58:46 www-dev kernel:    tclass=file
Aug 29 17:58:46 www-dev kernel:
Aug 29 17:58:46 www-dev kernel: avc:  denied  { setattr } for  pid=10 
exe=/bin/b
ash path=/etc/mtab dev=08:02 ino=166389
Aug 29 17:58:46 www-dev kernel:    scontext=system_u:system_r:initrc_t
Aug 29 17:58:46 www-dev kernel:    tcontext=system_u:object_r:file_t
Aug 29 17:58:46 www-dev kernel:    tclass=file
Aug 29 17:58:46 www-dev kernel:
Aug 29 17:58:46 www-dev kernel: avc:  denied  { getattr } for  pid=73 
exe=/sbin/
insmod path=/lib/modules/2.4.9-lsm/build dev=08:02 ino=133209
Aug 29 17:58:46 www-dev kernel:    scontext=system_u:system_r:insmod_t
Aug 29 17:58:46 www-dev kernel:    tcontext=system_u:object_r:modules_object_t
Aug 29 17:58:46 www-dev kernel:    tclass=lnk_file
Aug 29 17:58:46 www-dev kernel:
Aug 29 17:58:46 www-dev kernel: avc:  denied  { unlink } for  pid=91 
exe=/bin/rm
 path=/var/run/identd.pid dev=08:02 ino=101648
Aug 29 17:58:46 www-dev kernel:    scontext=system_u:system_r:initrc_t
Aug 29 17:58:46 www-dev kernel:    tcontext=system_u:object_r:file_t
Aug 29 17:58:46 www-dev kernel:    tclass=file

but I can't find anywhere where and what to change to prevent what is 
mentionned denied to be really denied when I'll switch to a "live" 
SELinux config...

For example, looking at the first one :
Aug 29 17:58:46 www-dev kernel: avc:  denied  { read write } for  pid=58 
exe=/bin/mount path=/etc/mtab dev=08:02 ino=166389
Aug 29 17:58:46 www-dev kernel:    scontext=system_u:system_r:mount_t
Aug 29 17:58:46 www-dev kernel:    tcontext=system_u:object_r:file_t
Aug 29 17:58:46 www-dev kernel:    tclass=file
Aug 29 17:58:46 www-dev kernel:

I've found in the source tree :
/bin/mount: system_u:object_t:mount_exec_t
/etc/mtab: system_u:object_r:etc_runtime_t

This is different from scontext (Security (?) context) and tcontext
(Task (?) context)....

It seems I deeply missed some configs, but I can't find them. Could someone
help me ?

Regards,
Paul

-- 

                                                       .--.  The penguin
Paul Rolland, rol@as2917.net                          |o_o | will survive,
                                                      |(_/ |  unlike
                                                     //   \ \  dinosaurs !
                                                    (|     | )
                                                   /'\_   _/`\
                                                   \___)=(___/
Please no MIME, I don't read it - Pas de MIME, je ne le lis pas
Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dreams of success... while others wake up and work hard at it"


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
