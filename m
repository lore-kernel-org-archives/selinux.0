Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1EgSRb007240
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 09:42:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB1EgRqY007007
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:42:27 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hB1EgQ0o007003 for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:42:26 GMT
Subject: Re: setfiles and non-SE systems
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200312012102.00554.russell@coker.com.au>
References: <200312012102.00554.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1070289743.12270.91.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Dec 2003 09:42:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-01 at 05:02, Russell Coker wrote:
> Above is part of the strace output from trying to run setfiles on a non-SE 
> system (kernel 2.4.22 with the ACL patch but no SE patch).
> 
> It appears that if we had a kernel patch to provide the security.selinux name 
> space as a regular xattr on non-SE systems then we could label the file 
> system before installing a SE Linux kernel.

Right, if the xattr handlers for the security namespace were added to
the EA/ACL patches, then you could assign the security.selinux
attributes on a kernel with only those patches.  However:
- that still requires a patched kernel (unless those patches
get upstreamed to mainline 2.4)
- If you are going to build a patched kernel, then you might as
well build a SELinux kernel and just boot with selinux=0 to perform the
initial labeling.  Same end result, a kernel that has the xattr handler
but isn't running SELinux.

I think that Jim Carter tried posting patches to the acl-devel list to
get the security xattr handler added a while back, but the list seems to
be down.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
