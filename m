Subject: Re: policy hierarchy patch
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <1112635440.7629.125.camel@moss-spartans.epoch.ncsc.mil>
References: <1112631282.19526.18.camel@localhost>
	 <1112635440.7629.125.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 15:37:27 -0400
Message-Id: <1112643447.19527.30.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yes you appear to be right. It turns out that this is a hard problem,
currently '.' is treated as a terminal some of the time and part of an
identifier other times. We tried to fix this problem by using lex start
states to disambiguate mls identifiers and normal ones but this became
problematic in contexts. Namely the following is currently valid:

user:role:type:s0-s9:cat1. cat2

note the space, now currently parts of the language require 2 contexts
in 1 rule, specifically netifcon:

netifcon user:role:type:s0:cat1 user:role:type:s1:cat1

If the context were always the last thing on the line we could end the
lex start state but since that isn't the case the yacc lookahead causes
the next identifier to be treated as an mls_identifier.

I said all that to ask if it is feasible to combine identifier and
mls_identifier in the patch and remove the terminal '.'. This would
cause category ranges to be 1 identifier and they'd have to be split
manually but otherwise it should work. The only visible change would be
that spaces would no longer be allowed between the category and the '.'.

Joshua Brindle

On Mon, 2005-04-04 at 13:24 -0400, Stephen Smalley wrote:
> On Mon, 2005-04-04 at 12:14 -0400, Joshua Brindle wrote:
> > This patch implements hierarchical types and roles in the current CVS
> > compiler. More information is available in selinux-doc/README.HIERARCHY,
> > which is included below.
> 
> The patch appears to break a MLS-enabled policy compile.  To test, run
> make mlsconvert in a policy directory and then set MLS=y in the policy
> Makefile.
> 
> Before:
> /usr/bin/checkpolicy -M -o /etc/selinux/mls/policy/policy.19 policy.conf
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> security:  7 users, 6 roles, 1632 types, 57 bools, 10 sens, 128 cats
> security:  54 classes, 393434 rules
> /usr/bin/checkpolicy:  policy configuration loaded
> /usr/bin/checkpolicy:  writing binary representation (version 19) to /etc/selinux/mls/policy/policy.19
> 
> After:
> /usr/bin/checkpolicy -M -o /etc/selinux/mls/policy/policy.19 policy.conf
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> users:24:ERROR 'syntax error' at token 's0' on line 380486:
> user system_u roles system_r level s0 range s0 - s9 : c0 . c127;
> #
> /usr/bin/checkpolicy:  error(s) encountered while parsing configuration
> make: *** [/etc/selinux/mls/policy/policy.19] Error 1
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
