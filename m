Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3DDN2Rb015896
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 09:23:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3DDN1mw006956
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 13:23:01 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i3DDN14w006953 for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 13:23:01 GMT
Subject: Re: Policy backward compatibility
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>, selinux-dev@tresys.com
In-Reply-To: <1081862054.21530.51.camel@moss-spartans.epoch.ncsc.mil>
References: <1081430495.6379.89.camel@moss-spartans.epoch.ncsc.mil>
	 <200404121834.03658.russell@coker.com.au>
	 <1081862054.21530.51.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1081862565.21530.56.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 13 Apr 2004 09:22:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-04-13 at 09:14, Stephen Smalley wrote:
> On Mon, 2004-04-12 at 04:34, Russell Coker wrote:
> > Having multiple checkpolicy programs will probably be painful.  We want all 
> > the checkpolicy programs to understand the newest syntax (unless we have a 
> > policy.conf for each policy version).  This means that the old checkpolicy 
> > will need to be updated any time there is a syntax change.
> 
> I don't think so.  Think of it as similar to the modutils and supporting
> both the old and new module interfaces.  You have a single frontend
> checkpolicy script that invokes the right backend checkpolicy-`uname -r`
> binary that generates the corresponding policy version.  You never have
> to update the older checkpolicy binaries; you just add new checkpolicy
> binaries for the newer kernels.

And, yes, this will require separate policy.conf files for the different
versions, but that is going to be necessary anyway for significant
changes to the policy.  Even for the netlink class partitioning, you
don't want to compile a newer policy.conf that has the fine-grained
netlink classes with an older checkpolicy, as the best it could do would
be to map them all to the old netlink class, possibly opening up
unintended access.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
