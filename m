Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6880FrT011495
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 04:00:15 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6880CEg023226
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 08:00:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: cifs_t
Date: Thu, 8 Jul 2004 18:00:09 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200407052352.53439.russell@coker.com.au> <1089224292.1774.160.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1089224292.1774.160.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407081800.09919.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 8 Jul 2004 04:18, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> Looking at the CVS tree, it appears that it was changed from cifs_t to
> sambafs_t on 5/4/2004, as part of a merge of a policy diff from Fedora.
> cifs_t was retained as an alias for compatibility, IIRC.

It seems that this was a mistake.

In 2.6.7 the kernel module is cifs.ko, the /proc/filesystems entry is cifs, 
and there is no mention of sambafs.  The correct thing to do is to make 
cifs_t the type name and sambafs_t the alias.

The next thing we should do is think about when we will remove the old 
aliases.  I suggest that every typealias that is in the Fedora Core 2 policy 
can be removed before FC3 without hurting anyone.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
