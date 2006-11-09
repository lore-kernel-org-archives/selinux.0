Subject: Re: [PATCH] cron changes needed for MLS range checking (requires
	at least the libselinux patches)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1163086850.29854.26.camel@code.and.org>
References: <1162936978.26574.20.camel@code.and.org>
	 <1162994668.3009.82.camel@moss-spartans.epoch.ncsc.mil>
	 <1163017959.29854.12.camel@code.and.org>
	 <1163019227.12241.178.camel@moss-spartans.epoch.ncsc.mil>
	 <1163023021.29854.15.camel@code.and.org>
	 <1163023990.12241.231.camel@moss-spartans.epoch.ncsc.mil>
	 <1163029645.29854.20.camel@code.and.org>
	 <1163084834.12241.293.camel@moss-spartans.epoch.ncsc.mil>
	 <1163086850.29854.26.camel@code.and.org>
Content-Type: text/plain
Date: Thu, 09 Nov 2006 10:57:48 -0500
Message-Id: <1163087868.12241.327.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-09 at 10:40 -0500, James Antill wrote:
>  Because without enforcing mode we just ignore the problem and continue,
> with it we error out. I think this is more of a theoretical assert type
> problem anyway, but still.

That's my point - it seems like it is a bug regardless of whether we are
permissive or enforcing, and should thus always return -1.  I'd only
expect security_getenforce() to make a difference for error handling on
permission checks.

Anyway, the patch looks sane at this point, although I'm not completely
clear how it integrates into the existing pile of selinux-related
patches in vixie-cron (it would help to consolidate them).

What is your plan on the client (crontab program) side?  The old patch
instrumented it to automatically insert a SELINUX_ROLE_TYPE= definition
with the caller's context if a certain option was used to crontab; will
you replace that with your new MLS_LEVEL= definition and the caller's
current range or just drop it altogether and require the user to
manually specify it in the crontab file?  Am I correct in understanding
that there can only be one MLS_LEVEL= definition per crontab file (for
all cron jobs in that crontab)?  Can it go anywhere in the crontab file?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
