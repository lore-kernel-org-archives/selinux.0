Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAUFDhIi017995
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 10:13:43 -0500 (EST)
Message-ID: <41AC8E57.9000103@trustedcs.com>
Date: Tue, 30 Nov 2004 09:14:31 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@tcs-sec.com>
Subject: Re: dynamic context transitions
References: <4182959B.4080503@trustedcs.com>	 <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>	 <20041112184232.GK15243@golconda.mitre.org>	 <1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>	 <nhau0rm54ra.fsf@malabar.mitre.org>	 <1100874782.15944.67.camel@moss-spartans.epoch.ncsc.mil>	 <419E1F76.9080803@trustedcs.com>	 <1100884644.15944.181.camel@moss-spartans.epoch.ncsc.mil>	 <41A4A921.9060105@trustedcs.com>	 <1101310307.22014.148.camel@moss-spartans.epoch.ncsc.mil>	 <41AB383B.3020006@trustedcs.com>	 <1101763456.2630.67.camel@moss-spartans.epoch.ncsc.mil>	 <41ABB3C2.2090809@trustedcs.com> <1101819480.4401.9.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1101819480.4401.9.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2004-11-29 at 18:41, Darrel Goeddel wrote:
> 
>>Good call.  We could replace:
>>		if (!thread_group_empty(p))
>>with:
>>		if (atomic_read(&p->mm->mm_users) != 1)
>>or go with both:
>>		if ((atomic_read(&p->mm->mm_users) != 1) ||
>>		    !thread_group_empty(p))
>>			return -EPERM;
>>
>>The check on mm_users also covers the case of a non-empty thread group since 
>>CLONE_THREAD requires CLONE_SIGHAND which requires CLONE_VM which increments 
>>mm_user.  I wouldn't think that would be changing anytime soon, so we could just 
>>go with the mm check.  I am happy either way since they are currently 
>>functionally equivalent.  Anybody have a preference?
> 
> 
> The mm_users check should be sufficient by itself, but it occurs to me
> that this may yield false positives due to temporary references to the
> task mm, e.g. another process happens to be performing a read of the
> /proc/pid/exe file of the process that is performing the setcon(),
> temporarily taking a reference via get_task_mm() during the processing
> of proc_exe_link().  That could cause the setcon() to fail even though
> the process itself is only single threaded.  So perhaps we can only
> reliably test the thread group set.
> 

I actually considered this, but foolishly dismissed it as a concern.  Would 
somehting like the following be a good idea?  It steps through each thread to 
check mm references, but only in the event that a multi-threaded process is 
trying to do a setcurrent, which should be a rare event.  I have not complied 
and tested this - it is just a thought right now...

		if (atomic_read(&p->mm->mm_users) != 1) {
			struct task_struct *g, *t;
			struct mm_struct mm = p->mm;
			read_lock(&tasklist_lock);
			do_each_thread(g, t)
				if (t->mm == mm) {
					read_unlock(&tasklist_lock);
					return -EPERM;
				}
			while_each_thread(g, t);
			read_unlock(&tasklist_lock);
		}
-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
