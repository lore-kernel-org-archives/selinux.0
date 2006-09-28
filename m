Subject: Re: [PATCH] -v2 newrole auditing of failures due to user actions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: Linux Audit <linux-audit@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <451C38C0.5090904@us.ibm.com>
References: <451C38C0.5090904@us.ibm.com>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 17:31:06 -0400
Message-Id: <1159479066.15365.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-28 at 16:04 -0500, Michael C Thompson wrote:
> This patch introduces two new point in the code where audit records are 
> generated for newrole. Both points are when the attempt to newrole fails.
> 
> The first point is when the default type could not be determine for the 
> specified role - this is audited because, as sgrubb pointed out, it is 
> currently non-tracked path to probe the policy.
> 
> The second point is when the desired context to change to is invalid.
> 
> There record format remains unchanged. Failing to validate the desired 
> context will result in the old and new contexts being recorded intact to 
> the log. For the default type, the old and new contexts have not yet 
> been obtained, so they are recorded in the log as XXX_context=?
> 
> Changes since version 1 of the patch:
>   * removed wrapping #ifdefs around send_audit_message()
>   * provided a "no-op" style function
>   * removed -D_GNU_SOURCE from the Makefile (as its defined in the code)
>   * fixed the error path of the send_audit_message function
> 
> The solution that I have for the "no-op" function is not that pretty, 
> but the Makefile is configured with -Werror and a function which doesn't 
> use its parameters causes warnings. Is there a better solution to this 
> problem?

Yes, mark the arguments with __attribute__((unused)).  You'll see
examples in other policycoreutils code.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
