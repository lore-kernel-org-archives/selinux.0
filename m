Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3FCXgI4025722
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 08:33:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3FCXf7R009937
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 12:33:41 GMT
Received: from lyta.coker.com.au (c16702.sunsh1.vic.optusnet.com.au [210.49.228.68])
        by jazzband.ncsc.mil  with ESMTP id h3FCXeKP009934 for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 12:33:41 GMT
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 207A392B6
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 22:33:46 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: strange errors
Date: Tue, 15 Apr 2003 22:33:45 +1000
MIME-Version: 1.0
Message-Id: <200304152210.42968.russell@coker.com.au>
Content-Type: text/plain;
  charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

avc:  denied  { } for  pid=1003 exe=/bin/bash path=/bin dev=09:03 ino=73319 
scontext=system_u:system_r:logrotate_t tcontext=system_u:object_r:bin_t 
tclass=blk_file

avc:  denied  { } for  pid=1375 exe=/usr/sbin/sshd path=/bin dev=09:03 
ino=73319 scontext=system_u:system_r:sshd_t tcontext=system_u:object_r:bin_t 
tclass=blk_file

I am just trying to fix a broken SE machine that needed quite a bit of work 
done while running a non-SE kernel as part of the recovery process.  I saw 
the above messages in the logs.  73319 is the inode number of the /bin 
directory.

It's compiled with the latest kernel patch and running on the ReiserFS file 
system.

Eventually I had to do the following to solve the problem:
mkdir /new ; mv /bin/* /new ; /new/mv /bin /bin.old ; /new/mv /new /bin

Then everything worked fine.  It seemed that SE Linux was determined to 
believe that /bin was not a dir but a blk_file!

The machine is now running fine in enforcing mode.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
