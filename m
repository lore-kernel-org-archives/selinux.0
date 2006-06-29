Subject: Re: [PATCH] remove te rule conflict checking from parser
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1151527238.9361.9.camel@twoface>
References: <1151527238.9361.9.camel@twoface>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 12:22:15 -0400
Message-Id: <1151598135.6999.113.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-06-28 at 16:40 -0400, Joshua Brindle wrote:
> This patch removes the te rule conflict checking from the parser.
> Duplicate te rules in different scopes (eg., conditional and
> unconditional) are now fatal and the parser doesn't have enough
> information to know if the te rules have the same conditional expression
> if they are in different optional blocks. The expander correctly checks
> for te rule duplicates and conflicts; unfortunately this means the
> errors can't be caught until link/expand time (the base gets linked and
> expanded during compilation for validation) and can't be caught at all
> in modules until they are linked in.

Manually adding a duplicate TE rule to my policy.conf and rebuilding
with this patch applied to checkpolicy:

$ grep 'type_transition initrc_t acct_exec_t' policy.conf
        type_transition initrc_t acct_exec_t:process acct_t;
        type_transition initrc_t acct_exec_t:process acct_t;
$ make 
Compiling refpolicy policy.20
/usr/bin/checkpolicy -M policy.conf -o policy.20
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 20) to policy.20

Appears to have silently dropped the duplicate from the output.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
