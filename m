Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3FDKjI4026009
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 09:20:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3FDKi7R012569
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 13:20:44 GMT
Received: from fapp01.csoconline.com (csoc-mail-smtp.csoconline.com [140.169.2.146])
        by jazzband.ncsc.mil  with SMTP id h3FDKVKP012559 for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 13:20:43 GMT
Message-ID: <CB4A800B69051C4986485EBBC070C69952B950@csoc-mail-hou.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker'" <russell@coker.com.au>,
   SE Linux
	 <selinux@tycho.nsa.gov>
Subject: RE: strange errors
Date: Tue, 15 Apr 2003 08:18:45 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have run into problems like this before. 
What fixed it for me was 
removing all ...security for all mounted partitions and
performing a make reset (not relabel)

Did you try that ? 
Tring to see if it was a similar problem

Mark

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au]
Sent: Tuesday, April 15, 2003 7:34 AM
To: SE Linux
Subject: strange errors


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
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
