Message-ID: <5204E5C5.1050802@tycho.nsa.gov>
Date: Fri, 09 Aug 2013 08:51:17 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dan Pou <danielp@sgi.com>
CC: SELinux-NSA <SELinux@tycho.nsa.gov>
Subject: Re: Programmatic domain change to unprivileged role
References: <20130805190732.GT18909@localhost> <52015950.9010906@tycho.nsa.gov> <20130806203751.GA14875@localhost> <52023D7D.7040409@tycho.nsa.gov> <52024071.4000206@tycho.nsa.gov> <20130808195857.GB23152@localhost>
In-Reply-To: <20130808195857.GB23152@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/08/2013 03:58 PM, Dan Pou wrote:
> Thanks for the suggestion about strace, that is pointing to the problem.
> I need to check the policy rules I have been adding to see how I got
> here:
> 
> write(3, "user_u:sysadm_r:sysadm_t:s0\0", 28) = -1 EINVAL (Invalid
> argument)
> 
> This is the second write.  When I test the same code with sshd_t to
> <username> transition, I get one write, with a successful return of
> default_context_with_level.
> 
> Thanks, this gives me something to go off of.

Could be that security_compute_user() (which writes to
/sys/fs/selinux/user) is getting an error or no results and thus the
code is trying to fall back to the failsafe context (as specified in
/etc/selinux/$SELINUXTYPE/contexts/failsafe_context), which isn't legal
for user_u.
The failsafe is to permit root / admin logins under such a situation.

I'd look to see what the result of writing to /sys/fs/selinux/user was
and what was written to it in the strace output.  You can also directly
call security_compute_user via the compute_user tool under
libselinux/utils if you obtain and build the sources yourself.  That
utility doesn't appear to get included in the libselinux-utils rpm though.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
