Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAUD2aIi017222
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 08:02:36 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAUD2c0N003907
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 13:02:38 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@tcs-sec.com>
In-Reply-To: <41ABB3C2.2090809@trustedcs.com>
References: <4182959B.4080503@trustedcs.com>
	 <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>
	 <20041112184232.GK15243@golconda.mitre.org>
	 <1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>
	 <nhau0rm54ra.fsf@malabar.mitre.org>
	 <1100874782.15944.67.camel@moss-spartans.epoch.ncsc.mil>
	 <419E1F76.9080803@trustedcs.com>
	 <1100884644.15944.181.camel@moss-spartans.epoch.ncsc.mil>
	 <41A4A921.9060105@trustedcs.com>
	 <1101310307.22014.148.camel@moss-spartans.epoch.ncsc.mil>
	 <41AB383B.3020006@trustedcs.com>
	 <1101763456.2630.67.camel@moss-spartans.epoch.ncsc.mil>
	 <41ABB3C2.2090809@trustedcs.com>
Content-Type: text/plain
Message-Id: <1101819480.4401.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 30 Nov 2004 07:58:00 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-29 at 18:41, Darrel Goeddel wrote:
> Good call.  We could replace:
> 		if (!thread_group_empty(p))
> with:
> 		if (atomic_read(&p->mm->mm_users) != 1)
> or go with both:
> 		if ((atomic_read(&p->mm->mm_users) != 1) ||
> 		    !thread_group_empty(p))
> 			return -EPERM;
> 
> The check on mm_users also covers the case of a non-empty thread group since 
> CLONE_THREAD requires CLONE_SIGHAND which requires CLONE_VM which increments 
> mm_user.  I wouldn't think that would be changing anytime soon, so we could just 
> go with the mm check.  I am happy either way since they are currently 
> functionally equivalent.  Anybody have a preference?

The mm_users check should be sufficient by itself, but it occurs to me
that this may yield false positives due to temporary references to the
task mm, e.g. another process happens to be performing a read of the
/proc/pid/exe file of the process that is performing the setcon(),
temporarily taking a reference via get_task_mm() during the processing
of proc_exe_link().  That could cause the setcon() to fail even though
the process itself is only single threaded.  So perhaps we can only
reliably test the thread group set.

> That will work fine.  It adds a safety net that will not cause a problem when 
> the tracer has been configured properly.  Should we use "p" instead of "current" 
> for consistency?  

Yes, good catch; I'll change that.

> I would actually be in favor of converting uses of "p" past "p 
> != current" in this function to "current" since the idea of messing with another 
> process seems like it will not be implemented.

Just to be safe (in case someone later removes that restriction,
although I can't see any good reason to ever do so), I think we'll use p
consistently as that will always reflect the target process of the
operation.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
