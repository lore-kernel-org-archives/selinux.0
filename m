Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7TNtD88013174
 for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2016 19:55:13 -0400
Received: by mail-oi0-f65.google.com with SMTP id s207so322035oie.0
 for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2016 16:55:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1471985365-1197-3-git-send-email-william.c.roberts@intel.com>
References: <1471985365-1197-1-git-send-email-william.c.roberts@intel.com>
 <1471985365-1197-3-git-send-email-william.c.roberts@intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Aug 2016 19:55:11 -0400
Message-ID: <CAHC9VhTWAauc8bpDin=+MRiFwV4Tdz_Dzrn3SKo5UWGu66EByA@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: fix overflow and 0 length allocations
To: william.c.roberts@intel.com
Cc: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 23, 2016 at 4:49 PM,  <william.c.roberts@intel.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> Throughout the SE Linux LSM, values taken from sepolicy are
> used in places where length == 0 or length == <saturated>
> matter, find and fix these.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  security/selinux/ss/conditional.c | 3 +++
>  security/selinux/ss/policydb.c    | 4 ++++
>  security/selinux/ss/private.h     | 7 +++++++
>  3 files changed, 14 insertions(+)
>  create mode 100644 security/selinux/ss/private.h
>
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 456e1a9..ecc0fb6 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -16,6 +16,7 @@
>  #include "security.h"
>  #include "conditional.h"
>  #include "services.h"
> +#include "private.h"
>
>  /*
>   * cond_evaluate_expr evaluates a conditional expr
> @@ -242,6 +243,8 @@ int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
>                 goto err;
>
>         len = le32_to_cpu(buf[2]);
> +       if (zero_or_saturated(len))
> +               goto err;
>
>         rc = -ENOMEM;
>         key = kmalloc(len + 1, GFP_KERNEL);
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 4b24385..0e881f3 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -38,6 +38,7 @@
>  #include "conditional.h"
>  #include "mls.h"
>  #include "services.h"
> +#include "private.h"
>
>  #define _DEBUG_HASHES
>
> @@ -1094,6 +1095,9 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
>         int rc;
>         char *str;
>
> +       if (zero_or_saturated(len))
> +               return -EINVAL;
> +
>         str = kmalloc(len + 1, flags);
>         if (!str)
>                 return -ENOMEM;
> diff --git a/security/selinux/ss/private.h b/security/selinux/ss/private.h
> new file mode 100644
> index 0000000..0e81a78
> --- /dev/null
> +++ b/security/selinux/ss/private.h
> @@ -0,0 +1,7 @@
> +#ifndef PRIVATE_H_
> +#define PRIVATE_H_
> +
> +#define is_saturated(x) (x == (typeof(x))-1)
> +#define zero_or_saturated(x) ((x == 0) || is_saturated(x))
> +
> +#endif

While I'm not opposed to the idea of using a macro for this purpose,
e.g. is_saturated() and zero_or_saturated(), I don't see much value in
creating this macro buried in the SELinux directory.  Especially if we
end up creating a new header file just for these macros.  Something as
generic as this should be something we inherit from the generic kernel
code so we can leverage existing conventions.

If you can find a macro like these in the core kernel code, go ahead
and use it, otherwise please respin this with the bound checks open
coded.

Oh, and use "SELinux" ;)

-- 
paul moore
www.paul-moore.com
