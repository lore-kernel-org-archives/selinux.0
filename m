Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iATNf0Ii014872
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 18:41:00 -0500 (EST)
Message-ID: <41ABB3C2.2090809@trustedcs.com>
Date: Mon, 29 Nov 2004 17:41:54 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@tcs-sec.com>
Subject: Re: dynamic context transitions
References: <4182959B.4080503@trustedcs.com>	 <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>	 <20041112184232.GK15243@golconda.mitre.org>	 <1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>	 <nhau0rm54ra.fsf@malabar.mitre.org>	 <1100874782.15944.67.camel@moss-spartans.epoch.ncsc.mil>	 <419E1F76.9080803@trustedcs.com>	 <1100884644.15944.181.camel@moss-spartans.epoch.ncsc.mil>	 <41A4A921.9060105@trustedcs.com>	 <1101310307.22014.148.camel@moss-spartans.epoch.ncsc.mil>	 <41AB383B.3020006@trustedcs.com> <1101763456.2630.67.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1101763456.2630.67.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Thanks.  What about the case of a CLONE_VM w/o CLONE_THREAD (native
> Linux threads rather than POSIX threads)?  Possibly a check on
> atomic_read(&current->mm->mm_users)?
> 

Good call.  We could replace:
		if (!thread_group_empty(p))
with:
		if (atomic_read(&p->mm->mm_users) != 1)
or go with both:
		if ((atomic_read(&p->mm->mm_users) != 1) ||
		    !thread_group_empty(p))
			return -EPERM;

The check on mm_users also covers the case of a non-empty thread group since 
CLONE_THREAD requires CLONE_SIGHAND which requires CLONE_VM which increments 
mm_user.  I wouldn't think that would be changing anytime soon, so we could just 
go with the mm check.  I am happy either way since they are currently 
functionally equivalent.  Anybody have a preference?

> Also, I know that we talked earlier about this issue, but even though
> ptracing should typically be covered by the ptrace check upon the exec
> that entered the domain that was allowed to perform the dynamic
> transition in the first place, I think we likely want to recheck ptrace
> status upon the dynamic transition as well for greater safety.  The diff
> below relative to your patch should do it.  See any problems with it for
> your intended usage?
> 
> Index: linux-2.6/security/selinux/hooks.c
> ===================================================================
> RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
> retrieving revision 1.136
> diff -u -p -r1.136 hooks.c
> --- linux-2.6/security/selinux/hooks.c	29 Nov 2004 19:45:59 -0000	1.136
> +++ linux-2.6/security/selinux/hooks.c	29 Nov 2004 20:22:00 -0000
> @@ -4149,6 +4149,8 @@ static int selinux_setprocattr(struct ta
>  	else if (!strcmp(name, "fscreate"))
>  		tsec->create_sid = sid;
>  	else if (!strcmp(name, "current")) {
> +		struct av_decision avd;
> +
>  		if (sid == 0)
>  			return -EINVAL;
>  
> @@ -4162,7 +4164,24 @@ static int selinux_setprocattr(struct ta
>  		if (error)
>  			return error;
>  
> -		tsec->sid = sid;
> +		/* Check for ptracing, and update the task SID if ok.
> +		   Otherwise, leave SID unchanged and fail. */
> +		task_lock(current);
> +		if (current->ptrace & PT_PTRACED) {
> +			error = avc_has_perm_noaudit(tsec->ptrace_sid, sid,
> +						     SECCLASS_PROCESS,
> +						     PROCESS__PTRACE, &avd);
> +			if (!error)
> +				tsec->sid = sid;
> +			task_unlock(current);
> +			avc_audit(tsec->ptrace_sid, sid, SECCLASS_PROCESS,
> +				  PROCESS__PTRACE, &avd, error, NULL);
> +			if (error)
> +				return error;
> +		} else {
> +			tsec->sid = sid;
> +			task_unlock(current);
> +		}
>  	}
>  	else
>  		return -EINVAL;
> 

That will work fine.  It adds a safety net that will not cause a problem when 
the tracer has been configured properly.  Should we use "p" instead of "current" 
for consistency?  I would actually be in favor of converting uses of "p" past "p 
!= current" in this function to "current" since the idea of messing with another 
process seems like it will not be implemented.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
