Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9GCtjWt002278
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 08:55:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9GCtb0p010087
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 12:55:37 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9GCtar7010084
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 12:55:36 GMT
Subject: Re: genfscon and /boot
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200310162109.25021.russell@coker.com.au>
References: <200310162109.25021.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1066308938.24561.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 16 Oct 2003 08:55:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-10-16 at 07:09, Russell Coker wrote:
> Currently the Red Hat kernels are compiled with Ext2 having no support for 
> XATTR or ACLs.  This is convenient when dealing with boot loaders that don't 
> support XATTR (such as the old Cobalt boot ROMs) as you can make /boot an 
> ext2 file system and not risk making the machine unbootable.
>
> The Sun/Cobalt people are aware of this issue and it will hopefully be 
> resolved soon, but we still want a solution to this as probably not all 
> hardware will get the bugs fixed soon enough.  Also some people who own 
> Cobalt hardware may not desire a ROM upgrade.

Supporting Cobalt hardware is not a priority for us, particularly not at
a sacrifice in security (which is what you are really suggesting).

> Now for /boot to have appropriate labels we need genfs entries for it.

genfscon cannot be used reliably for a filesystem type like ext2.
It works ok for proc, where we can reliably generate a pathname relative
to the root of proc from the proc_dir_entry tree, and is ok for mapping
all entries in certain filesystem types to a single fixed context, but
that is about it.  Pathname-based labeling doesn't work in Unix, much
less so in Linux.

> Currently the genfs does not seem to support giving a different label to 
> System.map* files (needed for ps to display the wchan and for kogd) and the 
> other files (which need restricted access).

The limitations of genfs_contexts are documented, both in the comments
at the beginning of genfs_contexts and in the PORTING file.  

> To get this working as desired we need to either change genfs to support 
> appropriate labeling, or to change distributions to have System.map in 
> another file system.  Having the System.map in a different file system may 
> make sense anyway as we would probably prefer not to have /boot mounted in 
> normal operation, but we do want to have System.map available all the time.

No, you just need to accept the fact that you need xattr support in the
kernel.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
