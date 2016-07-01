Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u61IqHmq014810
 for <selinux@tycho.nsa.gov>; Fri, 1 Jul 2016 14:52:20 -0400
Received: by mail-oi0-f46.google.com with SMTP id f189so122668654oig.3
 for <selinux@tycho.nsa.gov>; Fri, 01 Jul 2016 11:51:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1466711578-64398-8-git-send-email-danielj@mellanox.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-8-git-send-email-danielj@mellanox.com>
From: Paul Moore <pmoore@redhat.com>
Date: Fri, 1 Jul 2016 14:51:54 -0400
Message-ID: <CAGH-Kgv=4UVru-yxiQx9a_pY-aZn=D9GRONtYB3vLM1ojvd_Og@mail.gmail.com>
Subject: Re: [PATCH 07/12] selinux: Add a cache for quicker retreival of PKey
 SIDs
To: Dan Jurgens <danielj@mellanox.com>
Cc: chrisw@sous-sol.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 eparis@parisplace.org, dledford@redhat.com, sean.hefty@intel.com,
 hal.rosenstock@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org,
 yevgenyp@mellanox.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jun 23, 2016 at 3:52 PM, Dan Jurgens <danielj@mellanox.com> wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>
> It is likely that the SID for the same PKey will be requested many
> times.  To reduce the time to modify QPs and process MADs use a cache to
> store PKey SIDs.
>
> This code is heavily based on the "netif" and "netport" concept
> originally developed by James Morris <jmorris@redhat.com> and Paul Moore
> <paul@paul-moore.com> (see security/selinux/netif.c and
> security/selinux/netport.c for more information)
>
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> Reviewed-by: Eli Cohen <eli@mellanox.com>
> ---
>  security/selinux/Makefile         |   2 +-
>  security/selinux/hooks.c          |   5 +-
>  security/selinux/include/objsec.h |   6 +
>  security/selinux/include/pkey.h   |  31 +++++
>  security/selinux/pkey.c           | 243 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 285 insertions(+), 2 deletions(-)
>  create mode 100644 security/selinux/include/pkey.h
>  create mode 100644 security/selinux/pkey.c
>
> diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> index 3411c33..a698df4 100644
> --- a/security/selinux/Makefile
> +++ b/security/selinux/Makefile
> @@ -5,7 +5,7 @@
>  obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
>
>  selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
> -            netnode.o netport.o exports.o \
> +            netnode.o netport.o pkey.o exports.o \

I wonder if we should call this ibpkey.{c,o} instead of pkey.{c,o}?

>              ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
>              ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/status.o
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index fc44542..5c8cebb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -92,6 +92,7 @@
>  #include "netif.h"
>  #include "netnode.h"
>  #include "netport.h"
> +#include "pkey.h"
>  #include "xfrm.h"
>  #include "netlabel.h"
>  #include "audit.h"
> @@ -172,6 +173,8 @@ static int selinux_cache_avc_callback(u32 event)
>                 sel_netnode_flush();
>                 sel_netport_flush();
>                 synchronize_net();
> +
> +               sel_pkey_flush();
>                 mutex_lock(&ib_flush_mutex);
>                 if (ib_flush_callback)
>                         ib_flush_callback();
> @@ -6026,7 +6029,7 @@ static int selinux_pkey_access(u64 subnet_prefix, u16 pkey_val, void *security)
>         struct ib_security_struct *sec = security;
>         struct lsm_pkey_audit pkey;
>
> -       err = security_pkey_sid(subnet_prefix, pkey_val, &sid);
> +       err = sel_pkey_sid(subnet_prefix, pkey_val, &sid);
>
>         if (err)
>                 goto out;
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 8e7db43..4139f28 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -133,6 +133,12 @@ struct ib_security_struct {
>         u32 sid;        /* SID of the queue pair or MAD agent */
>  };
>
> +struct pkey_security_struct {
> +       u64     subnet_prefix; /* Port subnet prefix */
> +       u16     pkey;   /* PKey number */
> +       u32     sid;    /* SID of pkey */
> +};

See my earlier questions about partition keys and subnets.

-- 
paul moore
security @ redhat
