Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h74DVrHa015986
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2003 09:31:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h74DUdFB007648
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2003 13:30:39 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h74DUdGD007645
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2003 13:30:39 GMT
Subject: Re: SELinux-2.6-PPC
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1059955240.2997.75.camel@chris.pebenito.net>
References: <1059955240.2997.75.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1060003910.4298.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 04 Aug 2003 09:31:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-08-03 at 20:00, Chris PeBenito wrote:
> First of all, congrats to the NSA guys for getting SELinux merged into
> the linus tree.  Thanks for all your hard work.

Thanks also to James Morris for his help.

> I've got a SELinux
> kernel running on my PPC now, so we'll see how it goes on a new arch.

I would expect it to work fine on PPC, as there isn't anything
architecture-specific in the SELinux module anymore (no sys_security),
and the architecture-specific elements of LSM (particularly the patch to
the linker script for the security initcall) should be integrated for
most architectures.

> I've got a quick question about the new userland, are all of the future
> releases planned to have the split up libselinux, checkpolicy,
> policycoreutils, etc packages?  I just want to be sure; I don't want to
> create packages for these, and then find that future releases get
> remerged into a new selinux-small :)

Yes, we plan on continuing to provide these as individual packages.
I expect that you can use Colin Walter's Debian packages as a starting
point for Gentoo packages.  Caveat:  Due to the migration to xattr and
the reduction in support for genfs_contexts, you'll need to implement
file labeling support if you want to use certain filesystem types (e.g.
reiser, devfs).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
