Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA10277
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 11:01:24 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA04130
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 16:00:35 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA04117 for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 16:00:33 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 69E9592749
	for <selinux@tycho.nsa.gov>; Sat, 19 Jan 2002 03:01:17 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 2498232FE08
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 17:00:58 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <selinux@tycho.nsa.gov>
Subject: devfs_contexts
Date: Fri, 18 Jan 2002 17:00:57 +0100
MIME-Version: 1.0
Message-Id: <20020118160058.2498232FE08@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

How exactly is devfs_contexts supposed to work, when is it applied?

The default settings in the file appear to be applied, here is a sample:
root@test:/etc/flask# stat /dev/null /dev/random
  File: "/dev/null"
  Size: 0               Blocks: 0          IO Block: 1024   Character Device
Device: 7h/7d   Inode: 9           Links: 1     Device type: 1,3
Access: (0666/crw-rw-rw-)  Uid: (    0/    root)   Gid: (    0/    root)
Access: Thu Jan  1 01:00:00 1970
Modify: Thu Jan  1 01:00:00 1970
Change: Thu Jan  1 01:00:00 1970

  SID: 33
  S_context: system_u:object_r:null_device_t
  File: "/dev/random"
  Size: 0               Blocks: 0          IO Block: 1024   Character Device
Device: 7h/7d   Inode: 13          Links: 1     Device type: 1,8
Access: (0666/crw-rw-rw-)  Uid: (    0/    root)   Gid: (    0/    root)
Access: Thu Jan  1 01:00:00 1970
Modify: Thu Jan  1 01:00:00 1970
Change: Fri Jan 18 03:38:15 2002

  SID: 130
  S_context: system_u:object_r:random_device_t

However I added the following line to the file:
/vc/0                   system_u:object_r:devtty_t

But then after loading the new policy it's still not there!
root@test:/etc/flask# make load
install -m 644 -o root -g root policy /ss_policy
/usr/bin/load_policy /ss_policy

Success
root@test:/etc/flask# stat /dev/vc/0
  File: "/dev/vc/0"
  Size: 0               Blocks: 0          IO Block: 1024   Character Device
Device: 7h/7d   Inode: 83          Links: 1     Device type: 4,0
Access: (0666/crw-rw-rw-)  Uid: (    0/    root)   Gid: (    5/     tty)
Access: Thu Jan  1 01:00:00 1970
Modify: Thu Jan  1 01:00:00 1970
Change: Fri Jan 18 03:38:15 2002

  SID: 34
  S_context: system_u:object_r:device_t
root@test:/etc/flask#



PS I'm running 2.4.17 with the latest patch for the utilities (thanks 
Stephen).

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
