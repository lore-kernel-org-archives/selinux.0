Subject: Re: [PATCH] disallow * and ~ in rules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1119543471.8955.5.camel@localhost>
References: <1119543471.8955.5.camel@localhost>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 13:54:45 -0400
Message-Id: <1119549285.28493.173.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-23 at 12:17 -0400, Joshua Brindle wrote:
> The attached patch disallows * and ~ in certain kinds of rules, the list
> of where they are allowed and where they are not follows. I'm very
> willing to discuss any ideas or arguments as to why these should or
> shouldn't be in the list they are in.
> 
> 
> * and ~ allowed:
> range_trans (I was hoping TCS had an opinion on this)
> neverallow, dontaudit, auditallow
> 
> 
> * and ~ not allowed:
> allow rules
> type_transition, type_member, type_change
> role declarations (to add types to a role)
> role transitions

The patch only appears to alter their use in type sets, nothing else
(e.g. they can still be used for permission sets and role sets).  Is
that your intent?

For type sets, I'd favor greater consistency, e.g. not allow their use
in any type set except neverallow rules and only in them because they
are used to catch ill-formed policies.  Otherwise, type set exclusion
(e.g. domain -foo) is always preferable to set complement (e.g. ~foo),
as the latter will include unrelated types (e.g. file types) that are
not possible in that field, and a type attribute like domain or
file_type should always be used rather than a * for the same reason.
Looks like the FC4 strict and targeted policies are clean in this
respect, not sure about everything in the example policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
