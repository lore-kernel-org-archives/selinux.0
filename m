Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8M2tn8A032579
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 22:55:49 -0400
Received: by mail-yw1-f67.google.com with SMTP id x67-v6so5991717ywg.0
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 19:55:45 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com.
 [209.85.219.177])
 by smtp.gmail.com with ESMTPSA id u124-v6sm10212867ywd.37.2018.09.21.19.55.42
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Sep 2018 19:55:42 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id d14-v6so1173062ybs.8
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 19:55:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f24ab6a2-aa1d-1c36-9e51-22c924ad37e5@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <f24ab6a2-aa1d-1c36-9e51-22c924ad37e5@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 21 Sep 2018 19:55:41 -0700
Message-ID: <CAGXu5jL1Ek85Hky+PZ2pGQF09_cd_odn-LanYU=vVKgw24b8vg@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
 Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v4 14/19] LSM: Infrastructure management of the
 inode security
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 21, 2018 at 5:19 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Move management of the inode->i_security blob out
> of the individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h         |  3 ++
>  security/security.c               | 83 ++++++++++++++++++++++++++++++-
>  security/selinux/hooks.c          | 32 +-----------
>  security/selinux/include/objsec.h |  5 +-
>  security/smack/smack_lsm.c        | 70 ++++----------------------
>  5 files changed, 98 insertions(+), 95 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 167ffbd4d0c0..416b20c3795b 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2030,6 +2030,7 @@ struct security_hook_list {
>  struct lsm_blob_sizes {
>         int     lbs_cred;
>         int     lbs_file;
> +       int     lbs_inode;
>  };
>
>  /*
> @@ -2092,9 +2093,11 @@ static inline void loadpin_add_hooks(void) { };
>  #endif
>
>  extern int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
> +extern int lsm_inode_alloc(struct inode *inode);
>
>  #ifdef CONFIG_SECURITY
>  void lsm_early_cred(struct cred *cred);
> +void lsm_early_inode(struct inode *inode);
>  #endif
>
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/security.c b/security/security.c
> index 5430cae73cf6..a8f00fdff4d8 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -41,6 +41,7 @@ struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
>
>  static struct kmem_cache *lsm_file_cache;
> +static struct kmem_cache *lsm_inode_cache;
>
>  char *lsm_names;
>  static struct lsm_blob_sizes blob_sizes;
> @@ -101,6 +102,10 @@ int __init security_init(void)
>                 lsm_file_cache = kmem_cache_create("lsm_file_cache",
>                                                    blob_sizes.lbs_file, 0,
>                                                    SLAB_PANIC, NULL);
> +       if (blob_sizes.lbs_inode)
> +               lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
> +                                                   blob_sizes.lbs_inode, 0,
> +                                                   SLAB_PANIC, NULL);
>         /*
>          * The second call to a module specific init function
>          * adds hooks to the hook lists and does any other early
> @@ -111,6 +116,7 @@ int __init security_init(void)
>  #ifdef CONFIG_SECURITY_LSM_DEBUG
>         pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
>         pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
> +       pr_info("LSM: inode blob size      = %d\n", blob_sizes.lbs_inode);
>  #endif
>
>         return 0;
> @@ -288,6 +294,13 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
>  {
>         lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
>         lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
> +       /*
> +        * The inode blob gets an rcu_head in addition to
> +        * what the modules might need.
> +        */
> +       if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
> +               blob_sizes.lbs_inode = sizeof(struct rcu_head);
> +       lsm_set_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
>  }
>
>  /**
> @@ -311,6 +324,46 @@ int lsm_file_alloc(struct file *file)
>         return 0;
>  }
>
> +/**
> + * lsm_inode_alloc - allocate a composite inode blob
> + * @inode: the inode that needs a blob
> + *
> + * Allocate the inode blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +int lsm_inode_alloc(struct inode *inode)
> +{
> +       if (!lsm_inode_cache) {
> +               inode->i_security = NULL;
> +               return 0;
> +       }
> +
> +       inode->i_security = kmem_cache_zalloc(lsm_inode_cache, GFP_NOFS);
> +       if (inode->i_security == NULL)
> +               return -ENOMEM;
> +       return 0;
> +}
> +
> +/**
> + * lsm_early_inode - during initialization allocate a composite inode blob
> + * @inode: the inode that needs a blob
> + *
> + * Allocate the inode blob for all the modules if it's not already there
> + */
> +void lsm_early_inode(struct inode *inode)
> +{
> +       int rc;
> +
> +       if (inode == NULL)
> +               panic("%s: NULL inode.\n", __func__);
> +       if (inode->i_security != NULL)
> +               return;
> +       rc = lsm_inode_alloc(inode);
> +       if (rc)
> +               panic("%s: Early inode alloc failed.\n", __func__);
> +}

I'm still advising against using panic(), but I'll leave it up to James.

For everything else here:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
