Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i08EZXRb021679
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 09:35:33 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i08EZViV009936
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 14:35:31 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i08EZT06009930 for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 14:35:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: post_create:  setxattr failed, rc=122 (dev=09:03 ino=992086)
Date: Fri, 9 Jan 2004 01:35:25 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Tweedie <sct@redhat.com>
References: <200401080958.42958.russell@coker.com.au> <200401090115.41415.russell@coker.com.au> <1073572011.28727.50.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1073572011.28727.50.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401090135.25576.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 9 Jan 2004 01:26, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > What would happen to the file in question?  "find" does not report any
> > file with that Inode in the file system, do I assume that the creating
> > process detected the error about being unable to write any data to the
> > file and then unlinked the zero byte file while the Inode was still
> > in-core?
>
> Probably.  Given that the contexts are small, the program likely failed
> upon attempts to write data to the file due to the same quota
> restriction and unlinked the file as part of its own cleanup.  If the

I've tracked this down.  The file in question was created by a user who has no 
disk space quota but lots of Inode quota.  So the file gets created but they 
aren't allowed to allocate any more space.

A work-around for 99% of occurances of this would be to refuse to create a 
file when there is no disk space.  In a more general sense we could perhaps 
have a sysctl entry for the number of free blocks in the quota necessary to 
create a file.  We could specify that there must be two blocks left in the 
quota to create a file, one for the XATTR and one for data.  Allowing 
creation of a zero byte file does little good.

> program did not unlink it, then the file would stay around, continuing
> to be treated as if it has the right SID as long as the inode remained
> incore, but reverting to the 'file' SID, i.e. file_t type, if the inode
> were evicted and then re-read subsequently or upon a reboot.

Under the current policy this means a file that the user would never be able 
to unlink, and therefore a call for administrator intervention.  This of 
course won't work for a university.

I have been discussing file_t with Dan, he suggests making the default policy 
(which isn't so restrictive) allow full access to file_t for almost everyone.  
It would solve this as well as some other corner cases.  What do you think?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
