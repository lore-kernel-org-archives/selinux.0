Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9GEofWt003144
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 10:50:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9GEoX0p020760
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 14:50:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h9GEoVr7020749
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 14:50:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: genfscon and /boot
Date: Fri, 17 Oct 2003 00:50:30 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200310162109.25021.russell@coker.com.au> <1066308938.24561.38.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1066308938.24561.38.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310170050.30444.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 16 Oct 2003 22:55, Stephen Smalley wrote:
> Supporting Cobalt hardware is not a priority for us, particularly not at
> a sacrifice in security (which is what you are really suggesting).

I agree that we don't want to inconvenience ourselves for the benefit of 
Cobalt hardware, I am happy to maintain my own policy patches for that.  
However supporting the wider variety of systems which may have similar 
problems is desirable.  Otherwise we may just have a discussion like this 
every time someone ports to a new server platform, this includes rack mounted 
servers running LinuxBIOS, PDAs which have a Linux boot loader, and probably 
other things I haven't heard of.

Also this does not have to involve a sacrifice of security.  If we label 
everything under /boot with boot_t then the wchan option of ps is disabled, 
which is no great loss as 99.9% of all users don't know about it and most of 
the rest don't have any need for it.  Dumping a feature that's almost never 
used in favour of some functionality that has the potential to be a 
life-saver seems like a reasonable trade-off to me.

> > Now for /boot to have appropriate labels we need genfs entries for it.
>
> genfscon cannot be used reliably for a filesystem type like ext2.
> It works ok for proc, where we can reliably generate a pathname relative
> to the root of proc from the proc_dir_entry tree, and is ok for mapping
> all entries in certain filesystem types to a single fixed context, but
> that is about it.  Pathname-based labeling doesn't work in Unix, much
> less so in Linux.

OK.  Then how about an option to label all of /boot as boot_t?  There can be 
no confusion when all of a file system has the same label, and being overly 
restrictive should not be a problem.

Giving klogd access to boot_t should not be a great problem either, but it's 
also optional, klogd just misses some functionality in the case of an Oops if 
you don't give it access to System.map.

My only hesitation about this at the moment is that it makes things a little 
bit ugly in the policy.  Doing this requires changing the fs_use and 
genfs_contexts files as well as changing the type definition for boot_t.  
Having ifdef's in all these places in the policy will be annoying to manage, 
and naturally we want to have the default option to be using xattr's for 
ext2.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
