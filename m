Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h35NhuI4011224
	for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2003 18:43:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h35NhtxH027021
	for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2003 23:43:55 GMT
Received: from tartarus.telenet-ops.be (tartarus.telenet-ops.be [195.130.132.46])
        by jazzband.ncsc.mil  with ESMTP id h35NhtDl027018 for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2003 23:43:55 GMT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by tartarus.telenet-ops.be (Postfix) with SMTP id 14F26DBB81
	for <selinux@tycho.nsa.gov>; Sun,  6 Apr 2003 01:43:55 +0200 (CEST)
Received: from kabel.telenet.be (D5775F15.kabel.telenet.be [213.119.95.21])
	by tartarus.telenet-ops.be (Postfix) with ESMTP id 0109BDBACE
	for <selinux@tycho.nsa.gov>; Sun,  6 Apr 2003 01:43:54 +0200 (CEST)
Date: Sun, 6 Apr 2003 01:43:54 +0200
From: Kurt Roeckx <Q@ping.be>
To: selinux@tycho.nsa.gov
Subject: screen problem.
Message-ID: <20030405234354.GA14856@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

screen doesn't seem to work for me.

I'm using Brian May's policy on debian woody.

This are the messages that I get:

avc:  denied  { use } for  pid=3909 exe=/usr/bin/screen path=/1
dev=00:07 ino=3
scontext=kurt:user_r:user_screen_t
tcontext=system_u:system_r:sshd_t tclass=fd

avc:  denied  { search } for  pid=3909 exe=/usr/bin/screen
path=/home dev=03:02
ino=1015809 scontext=kurt:user_r:user_screen_t
tcontext=system_u:object_r:home_root_t tclass=dir

avc:  denied  { search } for  pid=3909 exe=/usr/bin/screen
path=/home/kurt dev=03:02 ino=131074
scontext=kurt:user_r:user_screen_t
tcontext=system_u:object_r:user_home_dir_t tclass=dir

avc:  denied  { search } for  pid=3909 exe=/usr/bin/screen
path=/dev dev=03:02 ino=966657 scontext=kurt:user_r:user_screen_t
tcontext=system_u:object_r:device_t tclass=dir

avc:  denied  { search } for  pid=3910 exe=/usr/bin/screen
path=/bin dev=03:02 ino=950273 scontext=kurt:user_r:user_screen_t
tcontext=system_u:object_r:bin_t tclass=dir

avc:  denied  { getattr } for  pid=3910 exe=/usr/bin/screen
scontext=kurt:user_r:user_screen_t
tcontext=system_u:object_r:devpts_t tclass=filesystem

avc:  denied  { read write } for  pid=3911 exe=/bin/bash path=/2
dev=00:07 ino=4 scontext=kurt:user_r:user_t
tcontext=kurt:object_r:user_screen_devpts_t tclass=chr_file

avc:  denied  { ioctl } for  pid=3911 exe=/bin/bash path=/2
dev=00:07 ino=4 scontext=kurt:user_r:user_t
tcontext=kurt:object_r:user_screen_devpts_t tclass=chr_file

avc:  denied  { signull } for  pid=3909 exe=/usr/bin/screen
scontext=kurt:user_r:user_screen_t
tcontext=kurt:user_r:user_screen_t tclass=process



Kurt


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
