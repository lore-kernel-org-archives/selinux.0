Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1JLGhRb001458
	for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2004 16:16:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1JLGec3022277
	for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2004 21:16:41 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i1JLGeR0022274 for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2004 21:16:40 GMT
Subject: Re: Backing out SeLinux on 2.4
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Shane Wegner <shane-keyword-selinux.9d5a25@cm.nu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040219205445.GA22106@cm.nu>
References: <20040219205445.GA22106@cm.nu>
Content-Type: text/plain
Message-Id: <1077225392.3526.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 19 Feb 2004 16:16:32 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-02-19 at 15:54, Shane Wegner wrote:
> I have decided to backout an installation of SeLinux and
> using a regular 2.4 kernel, the system cannot mount the
> root device, presumably due to the presence of ACLs. 
> Applying the acl patch at acl.bestbits.at does fix the
> problem.  Is there a way to remove the SeLinux ACLs such
> that the system can once again be booted on a vanilla
> kernel?  Maybe a dump/restore would work.  Anything that
> could be done without taking the system offline?

I think that the fast symlink detection fix went into vanilla 2.4.25, so
you should be able to boot a vanilla 2.4.25 kernel.  You should also be
able to boot your SELinux kernel with selinux disabled (selinux=0) and
then use something like:
	find / -exec setfattr -x security.selinux {} \;
to remove the SELinux attributes.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
