Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2U9cvkS002962
 for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2015 05:38:58 -0400
Received: by obbps3 with SMTP id ps3so3478198obb.3
 for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2015 02:38:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1427230458-23667-1-git-send-email-sds@tycho.nsa.gov>
References: <1427230458-23667-1-git-send-email-sds@tycho.nsa.gov>
Date: Mon, 30 Mar 2015 05:38:56 -0400
Message-ID: <CAHC9VhSLgS4pDE3488A7Xm1eqDXnX0R3wFsVSjfxB04ynQzEVA@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: convert avtab hash table to flex_array
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A nice set of patches, thank you.

All three have been merged and are currently sitting in selinux#next.

On Tue, Mar 24, 2015 at 4:54 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Previously we shrank the avtab max hash buckets to avoid
> high order memory allocations, but this causes avtab lookups to
> degenerate to very long linear searches for the Fedora policy. Convert to
> using a flex_array instead so that we can increase the buckets
> without such limitations.
>
> This change does not alter the max hash buckets; that is left to a
> separate follow-on change.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/ss/avtab.c | 31 +++++++++++++++++++------------
>  security/selinux/ss/avtab.h |  4 +++-
>  2 files changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index a3dd9fa..3ea0198 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -46,8 +46,12 @@ avtab_insert_node(struct avtab *h, int hvalue,
>                 newnode->next = prev->next;
>                 prev->next = newnode;
>         } else {
> -               newnode->next = h->htable[hvalue];
> -               h->htable[hvalue] = newnode;
> +               newnode->next = flex_array_get_ptr(h->htable, hvalue);
> +               if (flex_array_put_ptr(h->htable, hvalue, newnode,
> +                                      GFP_KERNEL|__GFP_ZERO)) {
> +                       kmem_cache_free(avtab_node_cachep, newnode);
> +                       return NULL;
> +               }
>         }
>
>         h->nel++;
> @@ -64,7 +68,7 @@ static int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_dat
>                 return -EINVAL;
>
>         hvalue = avtab_hash(key, h->mask);
> -       for (prev = NULL, cur = h->htable[hvalue];
> +       for (prev = NULL, cur = flex_array_get_ptr(h->htable, hvalue);
>              cur;
>              prev = cur, cur = cur->next) {
>                 if (key->source_type == cur->key.source_type &&
> @@ -104,7 +108,7 @@ avtab_insert_nonunique(struct avtab *h, struct avtab_key *key, struct avtab_datu
>         if (!h || !h->htable)
>                 return NULL;
>         hvalue = avtab_hash(key, h->mask);
> -       for (prev = NULL, cur = h->htable[hvalue];
> +       for (prev = NULL, cur = flex_array_get_ptr(h->htable, hvalue);
>              cur;
>              prev = cur, cur = cur->next) {
>                 if (key->source_type == cur->key.source_type &&
> @@ -135,7 +139,8 @@ struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *key)
>                 return NULL;
>
>         hvalue = avtab_hash(key, h->mask);
> -       for (cur = h->htable[hvalue]; cur; cur = cur->next) {
> +       for (cur = flex_array_get_ptr(h->htable, hvalue); cur;
> +            cur = cur->next) {
>                 if (key->source_type == cur->key.source_type &&
>                     key->target_type == cur->key.target_type &&
>                     key->target_class == cur->key.target_class &&
> @@ -170,7 +175,8 @@ avtab_search_node(struct avtab *h, struct avtab_key *key)
>                 return NULL;
>
>         hvalue = avtab_hash(key, h->mask);
> -       for (cur = h->htable[hvalue]; cur; cur = cur->next) {
> +       for (cur = flex_array_get_ptr(h->htable, hvalue); cur;
> +            cur = cur->next) {
>                 if (key->source_type == cur->key.source_type &&
>                     key->target_type == cur->key.target_type &&
>                     key->target_class == cur->key.target_class &&
> @@ -228,15 +234,14 @@ void avtab_destroy(struct avtab *h)
>                 return;
>
>         for (i = 0; i < h->nslot; i++) {
> -               cur = h->htable[i];
> +               cur = flex_array_get_ptr(h->htable, i);
>                 while (cur) {
>                         temp = cur;
>                         cur = cur->next;
>                         kmem_cache_free(avtab_node_cachep, temp);
>                 }
> -               h->htable[i] = NULL;
>         }
> -       kfree(h->htable);
> +       flex_array_free(h->htable);
>         h->htable = NULL;
>         h->nslot = 0;
>         h->mask = 0;
> @@ -270,7 +275,8 @@ int avtab_alloc(struct avtab *h, u32 nrules)
>                 nslot = MAX_AVTAB_HASH_BUCKETS;
>         mask = nslot - 1;
>
> -       h->htable = kcalloc(nslot, sizeof(*(h->htable)), GFP_KERNEL);
> +       h->htable = flex_array_alloc(sizeof(struct avtab_node *), nslot,
> +                                    GFP_KERNEL | __GFP_ZERO);
>         if (!h->htable)
>                 return -ENOMEM;
>
> @@ -293,7 +299,7 @@ void avtab_hash_eval(struct avtab *h, char *tag)
>         max_chain_len = 0;
>         chain2_len_sum = 0;
>         for (i = 0; i < h->nslot; i++) {
> -               cur = h->htable[i];
> +               cur = flex_array_get_ptr(h->htable, i);
>                 if (cur) {
>                         slots_used++;
>                         chain_len = 0;
> @@ -534,7 +540,8 @@ int avtab_write(struct policydb *p, struct avtab *a, void *fp)
>                 return rc;
>
>         for (i = 0; i < a->nslot; i++) {
> -               for (cur = a->htable[i]; cur; cur = cur->next) {
> +               for (cur = flex_array_get_ptr(a->htable, i); cur;
> +                    cur = cur->next) {
>                         rc = avtab_write_item(p, cur, fp);
>                         if (rc)
>                                 return rc;
> diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> index 63ce2f9..9318b2b 100644
> --- a/security/selinux/ss/avtab.h
> +++ b/security/selinux/ss/avtab.h
> @@ -23,6 +23,8 @@
>  #ifndef _SS_AVTAB_H_
>  #define _SS_AVTAB_H_
>
> +#include <linux/flex_array.h>
> +
>  struct avtab_key {
>         u16 source_type;        /* source type */
>         u16 target_type;        /* target type */
> @@ -51,7 +53,7 @@ struct avtab_node {
>  };
>
>  struct avtab {
> -       struct avtab_node **htable;
> +       struct flex_array *htable;
>         u32 nel;        /* number of elements */
>         u32 nslot;      /* number of hash slots */
>         u16 mask;       /* mask to compute hash func */
> --
> 1.9.3
>



-- 
paul moore
www.paul-moore.com
