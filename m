Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3FEcjI4026511
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 10:38:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3FEYxOv025761
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 14:34:59 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h3FEYxY1025758
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 14:34:59 GMT
Subject: Re: strange errors
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200304152210.42968.russell@coker.com.au>
References: <200304152210.42968.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1050417549.1051.23.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Apr 2003 10:39:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-04-15 at 08:33, Russell Coker wrote:
> avc:  denied  { } for  pid=1003 exe=/bin/bash path=/bin dev=09:03 ino=73319 
> scontext=system_u:system_r:logrotate_t tcontext=system_u:object_r:bin_t 
> tclass=blk_file
> 
> avc:  denied  { } for  pid=1375 exe=/usr/sbin/sshd path=/bin dev=09:03 
> ino=73319 scontext=system_u:system_r:sshd_t tcontext=system_u:object_r:bin_t 
> tclass=blk_file
> 
> I am just trying to fix a broken SE machine that needed quite a bit of work 
> done while running a non-SE kernel as part of the recovery process.  I saw 
> the above messages in the logs.  73319 is the inode number of the /bin 
> directory.
> 
> It's compiled with the latest kernel patch and running on the ReiserFS file 
> system.
> 
> Eventually I had to do the following to solve the problem:
> mkdir /new ; mv /bin/* /new ; /new/mv /bin /bin.old ; /new/mv /new /bin
> 
> Then everything worked fine.  It seemed that SE Linux was determined to 
> believe that /bin was not a dir but a blk_file!
> 
> The machine is now running fine in enforcing mode.

The security class for all inodes is initialized to 'file' when the
inode is allocated, and then set to a class based on the inode mode when
the inode security structure is initialized when the hook in
d_instantiate is called.  The only reason for SELinux to set it to
blk_file is if the inode mode format value was S_IFBLK when
d_instantiate is called.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
