Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7UJnHBM007190
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 15:49:17 -0400
Received: by mail-oi0-f66.google.com with SMTP id b22so2722691oii.3
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 12:48:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1472574491-31233-1-git-send-email-william.c.roberts@intel.com>
References: <1472574491-31233-1-git-send-email-william.c.roberts@intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Aug 2016 15:48:42 -0400
Message-ID: <CAHC9VhTmpk-o-vHzoW_czBHy_GJmf29DBe7kposuObCsDiEzJQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix overflow and 0 length allocations
To: william.c.roberts@intel.com
Cc: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 30, 2016 at 12:28 PM,  <william.c.roberts@intel.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> Throughout the SE Linux LSM, values taken from sepolicy are
> used in places where length == 0 or length == <saturated>
> matter, find and fix these.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  security/selinux/ss/conditional.c | 2 ++
>  security/selinux/ss/policydb.c    | 3 +++
>  2 files changed, 5 insertions(+)

Merged after I fixed the "SELinux" bit in the patch description.

> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 456e1a9..34afead 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -242,6 +242,8 @@ int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
>                 goto err;
>
>         len = le32_to_cpu(buf[2]);
> +       if (((len == 0) || (len == (u32)-1)))
> +               goto err;
>
>         rc = -ENOMEM;
>         key = kmalloc(len + 1, GFP_KERNEL);
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 4b24385..8c661f0 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1094,6 +1094,9 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
>         int rc;
>         char *str;
>
> +       if ((len == 0) || (len == (u32)-1))
> +               return -EINVAL;
> +
>         str = kmalloc(len + 1, flags);
>         if (!str)
>                 return -ENOMEM;
> --
> 1.9.1

-- 
paul moore
www.paul-moore.com
