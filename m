Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJHLXIi022096
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 12:21:33 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJHLalF011573
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 17:21:36 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "Joshua D. Guttman disp: slinux" <guttman@mitre.org>,
   Amy L Herzog <aherzog@mitre.org>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@tcs-sec.com>
In-Reply-To: <419E1F76.9080803@trustedcs.com>
References: <4182959B.4080503@trustedcs.com>
	 <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>
	 <20041112184232.GK15243@golconda.mitre.org>
	 <1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>
	 <nhau0rm54ra.fsf@malabar.mitre.org>
	 <1100874782.15944.67.camel@moss-spartans.epoch.ncsc.mil>
	 <419E1F76.9080803@trustedcs.com>
Content-Type: text/plain
Message-Id: <1100884644.15944.181.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 19 Nov 2004 12:17:24 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-11-19 at 11:29, Darrel Goeddel wrote:
> 
> We are wanting to maintain the same security context for all threads of a 
> process.  I was doing some investigation last night and came up with something 
> like this for the setcurrent code (idea only - not compiled, will get more 
> investigation):
> 
>      else if (!strcmp(name, "current")) {
>          if (sid == 0)
>              return -EINVAL;
> 
> +        /* Only allow the leader thread to change the context */
> +        if (!thread_group_leader(p))
> +            return -EPERM; /* what should we return ??? */
> 
>          /* Check permissions for the transition. */
>          error = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
>                               PROCESS__DYNTRANSITION, NULL);
>          if (error)
>              return error;
> 
>          tsec->sid = sid;
> +        if (!thread_group_empty(p)) {
> +            /* Update the other threads in this group */
> +            struct task_struct *thread = next_thread(p);
> +            read_lock(&tasklist_lock);
> +            while (thread != p) {
> +                tsec = thread->security;
> +                tsec->sid = sid;
> +                thread = next_thread(thread);
> +            }
> +            read_unlock(&tasklist_lock);
> +        }
> 
> Does this seem to be on the right track?  I will be looking more at this today. 
>   I am looking to still allow multi-threaded apps to use the facility, but only 
> the leader thread will have that ability.  All threads should be updated with 
> the new context.

Unless you have an actual usage scenario for this functionality, I'd
suggest a simple prohibition of any change in context even by the thread
group leader if there are any child threads.  That would still allow a
process to change its context prior to spawning any threads, e.g. to
shed privileges during startup.  Changing the security attributes of
other threads without their explicit awareness/consent is undesirable;
note that SELinux currently prevents setprocattr on another task.

While this prohibition may be appropriate for your usage, I'd also like
to check whether it is going to be a problem for use by other
applications, e.g. multi-threaded file servers.  They may presently take
advantage of the per-thread fsuid attribute; will they need similar
support for SELinux contexts?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
