Subject: Re: policy hierarchy patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1112631282.19526.18.camel@localhost>
References: <1112631282.19526.18.camel@localhost>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 13:24:00 -0400
Message-Id: <1112635440.7629.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-04-04 at 12:14 -0400, Joshua Brindle wrote:
> This patch implements hierarchical types and roles in the current CVS
> compiler. More information is available in selinux-doc/README.HIERARCHY,
> which is included below.

The patch appears to break a MLS-enabled policy compile.  To test, run
make mlsconvert in a policy directory and then set MLS=y in the policy
Makefile.

Before:
/usr/bin/checkpolicy -M -o /etc/selinux/mls/policy/policy.19 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
security:  7 users, 6 roles, 1632 types, 57 bools, 10 sens, 128 cats
security:  54 classes, 393434 rules
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 19) to /etc/selinux/mls/policy/policy.19

After:
/usr/bin/checkpolicy -M -o /etc/selinux/mls/policy/policy.19 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
users:24:ERROR 'syntax error' at token 's0' on line 380486:
user system_u roles system_r level s0 range s0 - s9 : c0 . c127;
#
/usr/bin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [/etc/selinux/mls/policy/policy.19] Error 1


-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
