Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA19049
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2001 08:18:05 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA02299
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2001 13:17:24 GMT
Received: from jsmith.org (pool-141-158-40-242.phil.east.verizon.net [141.158.40.242])
	by jazzband.ncsc.mil  with ESMTP id NAA02295
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2001 13:17:23 GMT
Subject: boot messages
From: Justin Smith <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 01 Dec 2001 08:15:36 -0500
Message-Id: <1007212536.2059.0.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Part of my dmesg:

....................
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

avc:  denied  { mounton } for  pid=149 exe=/bin/mount path=/local
dev=03:0a ino=
32705
   scontext=system_u:system_r:mount_t
   tcontext=system_u:object_r:usr_t
   tclass=dir

avc:  denied  { write } for  pid=224 exe=/bin/mv path=/log dev=03:05
ino=96193
   scontext=system_u:system_r:initrc_t
   tcontext=system_u:object_r:var_log_t
   tclass=dir

avc:  denied  { remove_name } for  pid=224 exe=/bin/mv path=/log/ksyms.5
dev=03:
05 ino=96389
   scontext=system_u:system_r:initrc_t
   tcontext=system_u:object_r:var_log_t
   tclass=dir

avc:  denied  { rename } for  pid=224 exe=/bin/mv path=/log/ksyms.5
dev=03:05 in
o=96389
   scontext=system_u:system_r:initrc_t
   tcontext=system_u:object_r:var_log_t
   tclass=file

avc:  denied  { add_name } for  pid=224 exe=/bin/mv path=/log/ksyms.6
dev=03:05 
ino=96370
   scontext=system_u:system_r:initrc_t
   tcontext=system_u:object_r:var_log_t
   tclass=dir


It looks as though the system doesn't allow basic maintenance of the
logs...

I'll try changing the policy slightly (in initrc.te)

# allow initrc_t var_log_t:file rw_file_perms;
allow initrc_t var_log_t:file 
       { write read rename remove_name add_name unlink create search };

-- 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
