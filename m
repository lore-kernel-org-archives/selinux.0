Subject: Re: Busted by constraints.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050513151013.18860.qmail@web31605.mail.mud.yahoo.com>
References: <20050513151013.18860.qmail@web31605.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 13 May 2005 11:20:55 -0400
Message-Id: <1115997655.3576.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-05-13 at 08:10 -0700, Casey Schaufler wrote:
> So where is the policy-in-effect stored?
> Certainly you're not going to suggest using
> the policy source file that happens to be there
> at the time of analysis. That policy file
> (actually, that set of policy files soon)
> may bear little resemblence to the policy
> that was in force at the time the event
> occured. Even if you're talking about the
> policy file at the time of collection
> there is real risk that the content of the
> policy file does not match what the kernel
> is enforcing.

audit2why/libsepol actually acts on the binary policy file, and libsepol
has the same policy engine code as the kernel, but I understand your
concern about matching up with the policy that was in effect at the time
of the denial.  However, keep in mind that:
a) keeping a versioned repository of your policies is a good idea
independent of this issue,
b) we are only trying to identify what component of the policy caused a
denial (e.g. Type Enforcement, RBAC, or constraint), and this is not
likely to be highly variable across policy changes/upgrades for a given
denial.

It might be useful if the kernel audit messages included some kind of
policy identifier / hash that could be used in correlating against a
versioned repository of policies.   That wouldn't be difficult.

> Enjoy. It's pretty pointless.

To the contrary, it specifically addresses Dan's problem (i.e. being
able to quickly determine which part of the policy caused a given denial
for application and policy debugging), where he knows what policy he is
using at the time of the denial.  And it should provide a basis for
future work on audit analysis tools, even if we have to make further
enhancements to support that functionality fully.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
