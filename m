Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k71CTnNn021251
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 08:29:49 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k71CTivL017504
	for <selinux@tycho.nsa.gov>; Tue, 1 Aug 2006 12:29:44 GMT
Message-ID: <44CF4941.9000400@tresys.com>
Date: Tue, 01 Aug 2006 08:29:53 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/2] Introduce symtab_datum_t
References: <1154357400.26550.77.camel@localhost.localdomain>
In-Reply-To: <1154357400.26550.77.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> This patch adds a new structure - symtab_datum_t - and converts all of
> the datum types to place this struct as their first member. This unifies
> the storage of data common to all symtab datums and allows free casting
> between specific datum types (e.g., role_datum_t) and symtab_datum_t.
> This patch is large, but almost all of the changes are trivial.
>
> Karl
>
>  checkpolicy/checkpolicy.c                  |    8 +-
>  checkpolicy/module_compiler.c              |   34 ++++-----
>  checkpolicy/policy_parse.y                 |  102 ++++++++++++++---------------
>  checkpolicy/test/dismod.c                  |   10 +-
>  libsepol/include/sepol/policydb/policydb.h |   16 ++--
>  libsepol/include/sepol/policydb/symtab.h   |   11 +++
>  libsepol/src/booleans.c                    |    2 
>  libsepol/src/conditional.c                 |    8 +-
>  libsepol/src/context.c                     |    6 -
>  libsepol/src/expand.c                      |   34 ++++-----
>  libsepol/src/genusers.c                    |    2 
>  libsepol/src/hierarchy.c                   |   18 ++---
>  libsepol/src/link.c                        |   54 +++++++--------
>  libsepol/src/mls.c                         |   10 +-
>  libsepol/src/policydb.c                    |   54 +++++++--------
>  libsepol/src/services.c                    |   12 +--
>  libsepol/src/users.c                       |   12 +--
>  libsepol/src/util.c                        |    2 
>  libsepol/src/write.c                       |   16 ++--
>  19 files changed, 211 insertions(+), 200 deletions(-)
>   
Looks good to me (other than my comment in the other patch).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
