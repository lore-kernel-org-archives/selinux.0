Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v87NLoME005810
 for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2017 19:21:53 -0400
Received: by mail-lf0-f67.google.com with SMTP id c8so429784lfe.2
 for <selinux@tycho.nsa.gov>; Thu, 07 Sep 2017 16:21:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504691419-26972-1-git-send-email-kyeongdon.kim@lge.com>
References: <1504691419-26972-1-git-send-email-kyeongdon.kim@lge.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Sep 2017 19:18:33 -0400
Message-ID: <CAHC9VhTfvOLw-v8ZbEhCkKn3FR9C5SzPS6kdz3w=fWxEGBAF1w@mail.gmail.com>
To: Kyeongdon Kim <kyeongdon.kim@lge.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, serge@hallyn.com,
 elfring@users.sourceforge.net, danielj@mellanox.com,
 junil0814.lee@lge.com, mka@chromium.org, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: Use kmem_cache for hashtab_node
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 6, 2017 at 5:50 AM, Kyeongdon Kim <kyeongdon.kim@lge.com> wrote:
> During random test as own device to check slub account,
> we found some slack memory from hashtab_node(kmalloc-64).
> By using kzalloc(), middle of test result like below:
> allocated size 240768
> request size 45144
> slack size 195624
> allocation count 3762
>
> So, we want to use kmem_cache_zalloc() and that
> can reduce memory size 52byte(slack size/alloc count) per each struct.
>
> Signed-off-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
> ---
>  security/selinux/ss/hashtab.c  | 17 +++++++++++++++--
>  security/selinux/ss/hashtab.h  |  4 ++++
>  security/selinux/ss/services.c |  4 ++++
>  3 files changed, 23 insertions(+), 2 deletions(-)

This seems reasonale, but I'm going to refrain from merging this until
after the merge window closes.

> diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> index 686c391..bef7577 100644
> --- a/security/selinux/ss/hashtab.c
> +++ b/security/selinux/ss/hashtab.c
> @@ -9,6 +9,8 @@
>  #include <linux/sched.h>
>  #include "hashtab.h"
>
> +static struct kmem_cache *hashtab_node_cachep;
> +
>  struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
>                                int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
>                                u32 size)
> @@ -57,7 +59,7 @@ int hashtab_insert(struct hashtab *h, void *key, void *datum)
>         if (cur && (h->keycmp(h, key, cur->key) == 0))
>                 return -EEXIST;
>
> -       newnode = kzalloc(sizeof(*newnode), GFP_KERNEL);
> +       newnode = kmem_cache_zalloc(hashtab_node_cachep, GFP_KERNEL);
>         if (!newnode)
>                 return -ENOMEM;
>         newnode->key = key;
> @@ -106,7 +108,7 @@ void hashtab_destroy(struct hashtab *h)
>                 while (cur) {
>                         temp = cur;
>                         cur = cur->next;
> -                       kfree(temp);
> +                       kmem_cache_free(hashtab_node_cachep, temp);
>                 }
>                 h->htable[i] = NULL;
>         }
> @@ -166,3 +168,14 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
>         info->slots_used = slots_used;
>         info->max_chain_len = max_chain_len;
>  }
> +void hashtab_cache_init(void)
> +{
> +               hashtab_node_cachep = kmem_cache_create("hashtab_node",
> +                       sizeof(struct hashtab_node),
> +                       0, SLAB_PANIC, NULL);
> +}
> +
> +void hashtab_cache_destroy(void)
> +{
> +               kmem_cache_destroy(hashtab_node_cachep);
> +}
> diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
> index 009fb5e..d6883d3 100644
> --- a/security/selinux/ss/hashtab.h
> +++ b/security/selinux/ss/hashtab.h
> @@ -84,4 +84,8 @@ int hashtab_map(struct hashtab *h,
>  /* Fill info with some hash table statistics */
>  void hashtab_stat(struct hashtab *h, struct hashtab_info *info);
>
> +/* Use kmem_cache for hashtab_node */
> +void hashtab_cache_init(void);
> +void hashtab_cache_destroy(void);
> +
>  #endif /* _SS_HASHTAB_H */
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index e4a1c0d..33cfe5d 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2060,10 +2060,12 @@ int security_load_policy(void *data, size_t len)
>         if (!ss_initialized) {
>                 avtab_cache_init();
>                 ebitmap_cache_init();
> +               hashtab_cache_init();
>                 rc = policydb_read(&policydb, fp);
>                 if (rc) {
>                         avtab_cache_destroy();
>                         ebitmap_cache_destroy();
> +                       hashtab_cache_destroy();
>                         goto out;
>                 }
>
> @@ -2075,6 +2077,7 @@ int security_load_policy(void *data, size_t len)
>                         policydb_destroy(&policydb);
>                         avtab_cache_destroy();
>                         ebitmap_cache_destroy();
> +                       hashtab_cache_destroy();
>                         goto out;
>                 }
>
> @@ -2083,6 +2086,7 @@ int security_load_policy(void *data, size_t len)
>                         policydb_destroy(&policydb);
>                         avtab_cache_destroy();
>                         ebitmap_cache_destroy();
> +                       hashtab_cache_destroy();
>                         goto out;
>                 }
>
> --
> 2.6.2
>



-- 
paul moore
www.paul-moore.com
