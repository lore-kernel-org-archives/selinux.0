Subject: Re: [PATCH] cron changes needed for MLS range checking (requires
	at least the libselinux patches)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1163017959.29854.12.camel@code.and.org>
References: <1162936978.26574.20.camel@code.and.org>
	 <1162994668.3009.82.camel@moss-spartans.epoch.ncsc.mil>
	 <1163017959.29854.12.camel@code.and.org>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 15:53:47 -0500
Message-Id: <1163019227.12241.178.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-08 at 15:32 -0500, James Antill wrote:
> > As in the pam case, you should be checking between a context for the
> > user with the seusers-specified range and a context for the user with
> > the user-specified level.  Your patch doesn't seem to match that
> > description - it refers to a file context as the target.
> 
>  One context comes from the cron file, and one from that plus the level
> change as requested by the user. See cron_get_job_range().
>  Changing that to be the result of getseuserbyname(), matching PAM,
> instead of the file context would be possible ... although I'm not sure
> if using "root" when u->name is "*system*" is the right thing to do.

The scontext is supposed to be a process context in which to run the
cron job, not a file context.  You are presently replacing the default
scontext (extracted from u->scontext that was previously computed) with
a strange mixture of the crontab file context and the user-specified
range.  What you want to do is to take the default scontext value,
create a new context that is identical except for its range (from the
environment), and apply a check between those two contexts (and the
check is only needed when using a user-supplied range).  BTW, you cannot
continue to refer to the string returned by context_str() after
performing a context_free() on the structure; you'd have to dup it
first.

> > Also, the function that performs the setexeccon (which you call
> > cron_change_selinux_range) is more general - it is supposed to set the
> > entire user context appropriately for the user on whose behalf cron is
> > running a job.  
> 
>  Right. Are you saying I need to call, cron_authorize_context() as well
> as cron_authorize_range()?
>  I decided this wasn't required because that function is called from
> within get_security_context(), and instead of being able to change
> everything now ... they can only change the level. So we don't need to
> re-auth the entire security context, just the level.
>  I'm certainly open to just checking it anyway, if you see any holes in
> my reasoning or if everyone would just prefer to check it twice.
> 
>  If that isn't what you meant, could you explain further what the
> problem is?

That is what I meant, but if it is being checked earlier and the crontab
file cannot be replaced in the interim without going through the check
again, it may be ok to not recheck in your patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
