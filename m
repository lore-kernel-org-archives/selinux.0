Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3DDEpRb015809
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 09:14:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3DDClUZ004963
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 13:12:48 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i3DDClmT004958
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 13:12:47 GMT
Subject: Re: Policy backward compatibility
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>, selinux-dev@tresys.com
In-Reply-To: <200404121834.03658.russell@coker.com.au>
References: <1081430495.6379.89.camel@moss-spartans.epoch.ncsc.mil>
	 <200404121834.03658.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1081862054.21530.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 13 Apr 2004 09:14:14 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-04-12 at 04:34, Russell Coker wrote:
> I recall that James originally suggested encoding policy version in the value 
> that is used for uname -r not the other way around.  Apart from the issue of 
> changing the version numbering scheme used for kernels this should be OK.

I don't think this is what James suggested, but he can clarify.  It
makes more sense to me to encode the kernel release in the policy
pathname, not the policy version in the kernel release.  The analogy is
kernel modules and /lib/modules/`uname -r`.

> Having multiple checkpolicy programs will probably be painful.  We want all 
> the checkpolicy programs to understand the newest syntax (unless we have a 
> policy.conf for each policy version).  This means that the old checkpolicy 
> will need to be updated any time there is a syntax change.

I don't think so.  Think of it as similar to the modutils and supporting
both the old and new module interfaces.  You have a single frontend
checkpolicy script that invokes the right backend checkpolicy-`uname -r`
binary that generates the corresponding policy version.  You never have
to update the older checkpolicy binaries; you just add new checkpolicy
binaries for the newer kernels.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
