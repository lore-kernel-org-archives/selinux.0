Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i08EG4Rb021533
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 09:16:05 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i08EExxr029661
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 14:14:59 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i08EEvYc029626
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 14:14:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: post_create:  setxattr failed, rc=122 (dev=09:03 ino=992086)
Date: Fri, 9 Jan 2004 01:15:41 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Tweedie <sct@redhat.com>
References: <200401080958.42958.russell@coker.com.au> <1073570910.28727.34.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1073570910.28727.34.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401090115.41415.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 9 Jan 2004 01:08, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Wed, 2004-01-07 at 17:58, Russell Coker wrote:
> > What is the meaning of the above error?
>
> errno 122 == EDQUOT, quota exceeded.  So SELinux was unable to set the
> attribute value on a newly created file because of a quota restriction
> on the creating process.  So the inode on disk is left unlabeled,
> although the SID on the incore inode will be set correctly.  Not clear
> that MAC labels should count against quotas, although a failure at the
> same point would still be possible due to other reasons, e.g. no free
> space on the filesystem or an I/O error when trying to write the
> attribute value.

Can this be changed?  I think that ideally the quota would not be counted for 
file creation.  But it may be an easier solution for the creation corner 
cases to have the creat() fail if the label can not be applied.

What would happen to the file in question?  "find" does not report any file 
with that Inode in the file system, do I assume that the creating process 
detected the error about being unable to write any data to the file and then 
unlinked the zero byte file while the Inode was still in-core?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
