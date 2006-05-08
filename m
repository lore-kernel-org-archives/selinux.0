Subject: Re: [PATCH] fix warnings in selinux-usr
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev <selinux-dev@tresys.com>
In-Reply-To: <1146845884.2208.15.camel@jackjack.columbia.tresys.com>
References: <1146845884.2208.15.camel@jackjack.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 08:49:40 -0400
Message-Id: <1147092580.23640.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-05 at 12:18 -0400, Karl MacMillan wrote:
> Steve,
> 
> Attached is a patch that fixes many warnings that have crept into the
> selinux-usr code over time, making it difficult to ascertain whether
> code changes have introduced new warnings.
> 
> Fixing some of the warnings required the introduction of unsafe casts,
> but those casts were occurring implicitly anyway (see
> libsemanage/src/booleans_policydb.c for an example).
> 
> I fixed one of the long standing lex warnings that has always been
> irritating, but I was unable to fix the warnings in the semanage
> configuration file parser. That parser should not rewritten to remove
> the lex dependency in the future anyway.

Merged, although some of the changes seemed unnecessary to me (e.g. it
is ok to name a variable 'index', and the compiler will let you know if
you then try to use it as a function in the same scope), and leaving the
libsemanage warnings was intentional by Ivan to flag the fact that we
are making an assumption about the equivalence between the libsemanage
and libsepol structs.  The patch also included some changes that
appeared to be unrelated to fixing warnings, like moving code from
util.c to policydb.c and upgrading the scope of role/user statements
from SCOPE_REQ to SCOPE_DECL automatically, and adding the -a option to
semodule_expand.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
