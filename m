Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h82CYPLa015254
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 08:34:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h82CWrpQ015537
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 12:32:54 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h82CWrQX015534
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 12:32:53 GMT
Subject: Re: new SE Linux and avc messages
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>, James Morris <jmorris@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200309021720.04027.russell@coker.com.au>
References: <200309021720.04027.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1062506053.18568.21.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 Sep 2003 08:34:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-09-02 at 03:20, Russell Coker wrote:
> It seems that the new SE Linux on 2.4.21 has less informative AVC messages 
> from the kernel than old-style SE Linux.  It seems that the name of the file 
> that is related to the AVC message is almost never included in the message.
> 
> Steve, is there any chance of getting this changed?  Doing a "find / -inum" to 
> track down the file in question is rather time consuming with ~200,000 files 
> in the file system (this is something I do all the time when writing policy).
> 
> Also for production environments, having several million files in a file 
> system is quite common, in some cases running find on such a system is 
> operationally impossible as it drags performance down so much that the server 
> is effectively off-line for the duration (which may be a really long time).
> 
> Also with the kernel watchdog (which should be installed on all servers IMHO) 
> and software RAID things get even more difficult as high disk latency can 
> trigger a reboot.
> 
> My point is that even if there are reasons for not wanting to do this (such as 
> performance) the issues with not doing it are considerable and will likely 
> out-weigh them.

The auditing code will generate and include pathname information when it
can be done reliably, i.e. when a (vfsmount, dentry) pair is available. 
Unfortunately, it is often the case that a pair is not available, and
trying to generate a pathname from just a dentry or just an inode was
considered a hack that had to be dropped as part of the code cleanup for
mainline integration.  If a dentry is available, we could include the
d_name.name in the audit message (i.e. the last component of the
pathname), but generating a full path isn't possible in any reliable
manner.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
