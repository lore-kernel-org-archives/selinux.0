Subject: Re: [PATCH] cron changes needed for MLS range checking (requires
	at least the libselinux patches)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1162936978.26574.20.camel@code.and.org>
References: <1162936978.26574.20.camel@code.and.org>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 09:04:28 -0500
Message-Id: <1162994668.3009.82.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-11-07 at 17:02 -0500, James Antill wrote:
>  I think this is what we want for the cron patch. It's basically doing
> the same checks as the PAM patches. It also limits what the user can
> change to just the MLS range.
>  At the moment I've just copied the original functions that need to be
> replaced, so you can see the old vs. the new. As the final commit the
> old ones should probably just die.
>  I've also kept the name SELINUX_ROLE_TYPE, I'm not sure if it should be
> changed to SELINUX_ROLE_RANGE or something else?

As I understood it, you were only going to allow level specification,
not user/role/domain, so it would just be SELINUX_LEVEL or MLS_LEVEL or
similar.

As in the pam case, you should be checking between a context for the
user with the seusers-specified range and a context for the user with
the user-specified level.  Your patch doesn't seem to match that
description - it refers to a file context as the target.

Also, the function that performs the setexeccon (which you call
cron_change_selinux_range) is more general - it is supposed to set the
entire user context appropriately for the user on whose behalf cron is
running a job.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
