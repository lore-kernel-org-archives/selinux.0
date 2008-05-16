Subject: Re: rbacsep: RFC cron jobs execute under user domain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1210940057.11188.73.camel@gorn>
References: <1210940057.11188.73.camel@gorn>
Content-Type: text/plain
Date: Fri, 16 May 2008 08:31:23 -0400
Message-Id: <1210941083.28282.215.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-05-16 at 08:14 -0400, Christopher J. PeBenito wrote:
> I think this has been talked about a little, but I'd like some feedback
> on having cron jobs execute directly in the user domain rather than in a
> special cron job domain.  Was there a specific reason cron jobs were not
> done this way from the start?

It was to allow the policy writer to grant different permissions to user
cron jobs than to an interactive user session.  I envisioned that the
policy writer might want to limit cron jobs to a subset of the user's
permissions given that they run without being tied to an authenticated
session and there is no way to establish a trusted path for them.  But
if the distinction isn't really being used in practice, then perhaps it
doesn't need to be retained in the refpolicy as long as the mechanism
still allows for it.

It might also have an impact on entrypoint types, since crond applies an
entrypoint check between the cron job process context and the crontab
file context in order to prevent executing commands from an
untrustworthy source in a more privileged domain.  So if you collapse
them, then crontab file contexts would also become an entrypoint for the
user domains.  Which likely is harmless, but something to be aware of.

> To be more specific, right now cron jobs will execute under
> user_crond_t, staff_crond_t, etc.  My thought is to have them run under
> user_t, staff_t, etc.  It seems logical since that tends to be how users
> see cron jobs: running as the user/having the same permissions as the
> user.
> 
> The system cron jobs (system_crond_t) would be unchanged.
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
