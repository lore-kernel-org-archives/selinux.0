Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71173CDB474
	for <selinux@archiver.kernel.org>; Fri, 20 Oct 2023 14:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377482AbjJTOAS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Oct 2023 10:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377511AbjJTOAR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Oct 2023 10:00:17 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BD3D57
        for <selinux@vger.kernel.org>; Fri, 20 Oct 2023 07:00:13 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6ce2bcb131fso530944a34.1
        for <selinux@vger.kernel.org>; Fri, 20 Oct 2023 07:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697810413; x=1698415213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46rud9rA5AT/mrQo6XGGMf3kUqDGhuX9Mfnv+QprAOA=;
        b=g8aJY1TiZKWRJORsznJEF9tmbqmS/ogmRzlF4KDl9875G0hyKoVwxJrRrfJzTXfW8N
         tWpkMTQy3+njuPO0FbYymL6pFrJPCf81QzyR6iDaKYHBeZkq23lLtOUAX07Nz31bndhN
         nswbyAHja7PthpLG13J6cO1JtDw3p8xDhIWcp+Ms9Bdyrmy99bYUBebdGjKW0q1EBQoE
         zkC4DA4id4t2EniD7Mr2DWdQZOQhhYGXIGRpnp6Wjy9J7kzyt56O0Tn8luVtNOC7jhSG
         CDXUkGKokrrZqtkEntMZZUo5O9IXi0u8nERjiZ3bXJo3TXlI0jHDxNbDxH9gSCxW9rgO
         bwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697810413; x=1698415213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46rud9rA5AT/mrQo6XGGMf3kUqDGhuX9Mfnv+QprAOA=;
        b=BqXIy2+mt8/33QqwwiQN2ZVWYy8scDxZb9MSBcnzQ6KSiox11SdcRdOLAFNwqq6FWu
         mRhT86g+c8lSq1qE7llbY7+W0KNrQ+/7yvEq6zqaUrnOECaQumQDBucJz0BaObpH9aQ3
         ufY/vHCRDnQJE4a2l+j5gtBOU0fUZTeDilY8f03FFabOtF5GPE7X65VWZRrR4/eOuwqU
         YpiOhnURyk14oZydgLYjRMqhtVzonXS+f7Zv3L0t/8eXVpG9ob12ZmEfW3beNMWmzI1k
         7P+GzfqJlkAGqGy97I4OrcKdt1cK3GybBvOOJwTpQIsf4Lhgzu7YZ5vMrA3uT959aQ9b
         Pjyg==
X-Gm-Message-State: AOJu0Yz8EmSRt+0vlMutQ3Fc0Uo5HPGHIrDcS0ZUSmBt89lC24sEQ3vG
        ii7FyigtlRb4Q0864PjqvFB2kAMiFZWO0bkk/XQ=
X-Google-Smtp-Source: AGHT+IGZQ2iDDa1qKPxDryDpYlC1dyX1icJFZp+bT+7wHvowRYa/oD/o0YtDiwmi/hzIFpzBFr/miwTlfKdlZcCBirM=
X-Received: by 2002:a9d:74ca:0:b0:6c4:d7e4:94d2 with SMTP id
 a10-20020a9d74ca000000b006c4d7e494d2mr1834217otl.33.1697810413013; Fri, 20
 Oct 2023 07:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231018175744.39667-1-jsatterfield.linux@gmail.com> <20231018175744.39667-4-jsatterfield.linux@gmail.com>
In-Reply-To: <20231018175744.39667-4-jsatterfield.linux@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 20 Oct 2023 10:00:01 -0400
Message-ID: <CAEjxPJ4zcGGm=BumDyzi2GXb2fBGL563fgkTs5C2+U0r16ik8w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selinux: use arrays for avtab hashtable nodes
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 18, 2023 at 1:58=E2=80=AFPM Jacob Satterfield
<jsatterfield.linux@gmail.com> wrote:
>
> The current avtab hashtable employs a separate chaining collision
> resolution strategy where each bucket/chain holds an ordered linked list
> of pointers to kmem_cache allocated avtab_node elements.
>
> On Fedora 38 (x86_64) using the default policy, avtab_node_cachep
> uses 573 slabs each containing 170 objects totaling 2,337,840 bytes.
> A call to kmem_cache_zalloc() is required for every single rule, which
> in the default policy is currently 96,730 and continually rising.
>
> When both sets of avtab_node (regular and cond.) are turned into arrays
> with the hash table slot indexing into it rather than a pointer, then
> this results in only 2 additional kvcalloc() calls and the complete
> removal of the kmem_cache itself.
>
> Due to how conditional rules are written in the binary policy, the
> code responsible for loading does not know how many conditional rules
> there are before creating the avtab structure. Instead, it was using the
> number of elements in the non-conditional avtab as a hint and allocates
> the hash table based on it. Therefore, a two-pass algorithm is now used
> to calculate the rule count before allocating the avtab nodes array.
> With the current refpolicy and default Fedora policy, this causes the
> number of hash slots for the conditional array to become 4096 instead of
> 32768. This results in a savings of 224KB of heap memory.
>
> The caching characteristics of iterating a single array are better due
> to locality of reference. Running "perf stat -r 100 -d load_policy"
> has shown a runtime reduction of around 10% on a Fedora 38 x86_64 VM
> with this single patch. Future patches focused on improving the hash
> table's collision resolution strategy and array layout (struct-of-arrays
> vs. array-of-structs) may elicit even more caching and therefore runtime
> performance improvements.
>
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>

Assuming you fix the previous patch,
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/ss/avtab.c       | 47 ++++++++++++++++++++-----------
>  security/selinux/ss/avtab.h       |  4 ++-
>  security/selinux/ss/conditional.c | 37 ++++++++++++++++--------
>  security/selinux/ss/conditional.h |  2 +-
>  4 files changed, 59 insertions(+), 31 deletions(-)
>
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index f0d448e7807a..aabe04fc4d04 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -24,7 +24,6 @@
>  #include "avtab.h"
>  #include "policydb.h"
>
> -static struct kmem_cache *avtab_node_cachep __ro_after_init;
>  static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
>
>  #define avtab_chain_for_each(pos, tab, slot) \
> @@ -79,17 +78,15 @@ avtab_insert_node(struct avtab *h, struct avtab_node =
**dst,
>  {
>         struct avtab_node *newnode;
>         struct avtab_extended_perms *xperms;
> -       newnode =3D kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
> -       if (newnode =3D=3D NULL)
> +       if (h->nel =3D=3D h->nnodes)
>                 return NULL;
> +       newnode =3D &h->nodes[h->nel];
>         newnode->key =3D *key;
>
>         if (key->specified & AVTAB_XPERMS) {
>                 xperms =3D kmem_cache_zalloc(avtab_xperms_cachep, GFP_KER=
NEL);
> -               if (xperms =3D=3D NULL) {
> -                       kmem_cache_free(avtab_node_cachep, newnode);
> +               if (xperms =3D=3D NULL)
>                         return NULL;
> -               }
>                 *xperms =3D *(datum->u.xperms);
>                 newnode->datum.u.xperms =3D xperms;
>         } else {
> @@ -235,11 +232,13 @@ void avtab_destroy(struct avtab *h)
>                         if (temp->key.specified & AVTAB_XPERMS)
>                                 kmem_cache_free(avtab_xperms_cachep,
>                                                 temp->datum.u.xperms);
> -                       kmem_cache_free(avtab_node_cachep, temp);
>                 }
>         }
>         kvfree(h->htable);
> +       kvfree(h->nodes);
>         h->htable =3D NULL;
> +       h->nodes =3D NULL;
> +       h->nnodes =3D 0;
>         h->nel =3D 0;
>         h->nslot =3D 0;
>         h->mask =3D 0;
> @@ -248,20 +247,28 @@ void avtab_destroy(struct avtab *h)
>  void avtab_init(struct avtab *h)
>  {
>         h->htable =3D NULL;
> +       h->nodes =3D NULL;
> +       h->nnodes =3D 0;
>         h->nel =3D 0;
>         h->nslot =3D 0;
>         h->mask =3D 0;
>  }
>
> -static int avtab_alloc_common(struct avtab *h, u32 nslot)
> +static int avtab_alloc_common(struct avtab *h, u32 nslot, u32 nrules)
>  {
>         if (!nslot)
>                 return 0;
>
> -       h->htable =3D kvcalloc(nslot, sizeof(void *), GFP_KERNEL);
> +       h->htable =3D kvcalloc(nslot, sizeof(*h->htable), GFP_KERNEL);
>         if (!h->htable)
>                 return -ENOMEM;
> -
> +       h->nodes =3D kvcalloc(nrules, sizeof(*h->nodes), GFP_KERNEL);
> +       if (!h->nodes) {
> +               kvfree(h->htable);
> +               h->htable =3D NULL;
> +               return -ENOMEM;
> +       }
> +       h->nnodes =3D nrules;
>         h->nslot =3D nslot;
>         h->mask =3D nslot - 1;
>         return 0;
> @@ -277,7 +284,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
>                 if (nslot > MAX_AVTAB_HASH_BUCKETS)
>                         nslot =3D MAX_AVTAB_HASH_BUCKETS;
>
> -               rc =3D avtab_alloc_common(h, nslot);
> +               rc =3D avtab_alloc_common(h, nslot, nrules);
>                 if (rc)
>                         return rc;
>         }
> @@ -288,7 +295,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
>
>  int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
>  {
> -       return avtab_alloc_common(new, orig->nslot);
> +       return avtab_alloc_common(new, orig->nslot, orig->nel);
>  }
>
>  #ifdef CONFIG_SECURITY_SELINUX_DEBUG
> @@ -337,7 +344,7 @@ static const uint16_t spec_order[] =3D {
>  int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>                     int (*insertf)(struct avtab *a, const struct avtab_ke=
y *k,
>                                    const struct avtab_datum *d, void *p),
> -                   void *p)
> +                   void *p, u32 *nrules)
>  {
>         __le16 buf16[4];
>         u16 enabled;
> @@ -411,6 +418,10 @@ int avtab_read_item(struct avtab *a, void *fp, struc=
t policydb *pol,
>                         if (val & spec_order[i]) {
>                                 key.specified =3D spec_order[i] | enabled=
;
>                                 datum.u.data =3D le32_to_cpu(buf32[items+=
+]);
> +                               if (nrules) {
> +                                       (*nrules)++;
> +                                       continue;
> +                               }
>                                 rc =3D insertf(a, &key, &datum, p);
>                                 if (rc)
>                                         return rc;
> @@ -489,6 +500,11 @@ int avtab_read_item(struct avtab *a, void *fp, struc=
t policydb *pol,
>                 pr_err("SELinux: avtab: invalid type\n");
>                 return -EINVAL;
>         }
> +
> +       if (nrules) {
> +               (*nrules)++;
> +               return 0;
> +       }
>         return insertf(a, &key, &datum, p);
>  }
>
> @@ -522,7 +538,7 @@ int avtab_read(struct avtab *a, void *fp, struct poli=
cydb *pol)
>                 goto bad;
>
>         for (i =3D 0; i < nel; i++) {
> -               rc =3D avtab_read_item(a, fp, pol, avtab_insertf, NULL);
> +               rc =3D avtab_read_item(a, fp, pol, avtab_insertf, NULL, N=
ULL);
>                 if (rc) {
>                         if (rc =3D=3D -ENOMEM)
>                                 pr_err("SELinux: avtab: out of memory\n")=
;
> @@ -602,9 +618,6 @@ int avtab_write(struct policydb *p, struct avtab *a, =
void *fp)
>
>  void __init avtab_cache_init(void)
>  {
> -       avtab_node_cachep =3D kmem_cache_create("avtab_node",
> -                                             sizeof(struct avtab_node),
> -                                             0, SLAB_PANIC, NULL);
>         avtab_xperms_cachep =3D kmem_cache_create("avtab_extended_perms",
>                                                 sizeof(struct avtab_exten=
ded_perms),
>                                                 0, SLAB_PANIC, NULL);
> diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> index 3c3904bf02b0..5e465be6f057 100644
> --- a/security/selinux/ss/avtab.h
> +++ b/security/selinux/ss/avtab.h
> @@ -82,6 +82,8 @@ struct avtab_node {
>
>  struct avtab {
>         struct avtab_node **htable;
> +       struct avtab_node *nodes;
> +       u32 nnodes;     /* number of nodes */
>         u32 nel;        /* number of elements */
>         u32 nslot;      /* number of hash slots */
>         u32 mask;       /* mask to compute hash func */
> @@ -104,7 +106,7 @@ struct policydb;
>  int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>                     int (*insert)(struct avtab *a, const struct avtab_key=
 *k,
>                                   const struct avtab_datum *d, void *p),
> -                   void *p);
> +                   void *p, u32 *nrules);
>
>  int avtab_read(struct avtab *a, void *fp, struct policydb *pol);
>  int avtab_write_item(struct policydb *p, const struct avtab_node *cur, v=
oid *fp);
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/cond=
itional.c
> index 81ff676f209a..bbd35b35b79d 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -140,7 +140,7 @@ void cond_policydb_init(struct policydb *p)
>  static void cond_node_destroy(struct cond_node *node)
>  {
>         kfree(node->expr.nodes);
> -       /* the avtab_ptr_t nodes are destroyed by the avtab */
> +       /* the actual nodes were destroyed by avtab_destroy() */
>         kfree(node->true_list.nodes);
>         kfree(node->false_list.nodes);
>  }
> @@ -323,7 +323,8 @@ static int cond_insertf(struct avtab *a, const struct=
 avtab_key *k,
>
>  static int cond_read_av_list(struct policydb *p, void *fp,
>                              struct cond_av_list *list,
> -                            struct cond_av_list *other)
> +                            struct cond_av_list *other,
> +                            u32 *nrules)
>  {
>         int rc;
>         __le32 buf[1];
> @@ -347,7 +348,7 @@ static int cond_read_av_list(struct policydb *p, void=
 *fp,
>         for (i =3D 0; i < len; i++) {
>                 data.dst =3D &list->nodes[i];
>                 rc =3D avtab_read_item(&p->te_cond_avtab, fp, p, cond_ins=
ertf,
> -                                    &data);
> +                                    &data, nrules);
>                 if (rc) {
>                         kfree(list->nodes);
>                         list->nodes =3D NULL;
> @@ -373,7 +374,8 @@ static int expr_node_isvalid(struct policydb *p, stru=
ct cond_expr_node *expr)
>         return 1;
>  }
>
> -static int cond_read_node(struct policydb *p, struct cond_node *node, vo=
id *fp)
> +static int cond_read_node(struct policydb *p, struct cond_node *node,
> +                         void *fp, u32 *nrules)
>  {
>         __le32 buf[2];
>         u32 i, len;
> @@ -407,16 +409,17 @@ static int cond_read_node(struct policydb *p, struc=
t cond_node *node, void *fp)
>                         return -EINVAL;
>         }
>
> -       rc =3D cond_read_av_list(p, fp, &node->true_list, NULL);
> +       rc =3D cond_read_av_list(p, fp, &node->true_list, NULL, nrules);
>         if (rc)
>                 return rc;
> -       return cond_read_av_list(p, fp, &node->false_list, &node->true_li=
st);
> +       return cond_read_av_list(p, fp, &node->false_list, &node->true_li=
st, nrules);
>  }
>
> -int cond_read_list(struct policydb *p, void *fp)
> +int cond_read_list(struct policydb *p, struct policy_file *fp)
>  {
>         __le32 buf[1];
> -       u32 i, len;
> +       struct policy_file tmp_fp;
> +       u32 i, len, nrules;
>         int rc;
>
>         rc =3D next_entry(buf, fp, sizeof(buf));
> @@ -428,15 +431,25 @@ int cond_read_list(struct policydb *p, void *fp)
>         p->cond_list =3D kcalloc(len, sizeof(*p->cond_list), GFP_KERNEL);
>         if (!p->cond_list)
>                 return -ENOMEM;
> +       p->cond_list_len =3D len;
> +
> +       /* first pass to only calculate the avrule count */
> +       tmp_fp =3D *fp;
> +       nrules =3D 0;
> +       for (i =3D 0; i < len; i++) {
> +               rc =3D cond_read_node(p, &p->cond_list[i], &tmp_fp, &nrul=
es);
> +               if (rc)
> +                       goto err;
> +               cond_node_destroy(&p->cond_list[i]);
> +       }
>
> -       rc =3D avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
> +       rc =3D avtab_alloc(&(p->te_cond_avtab), nrules);
>         if (rc)
>                 goto err;
>
> -       p->cond_list_len =3D len;
> -
> +       /* second pass to read in the conditional nodes */
>         for (i =3D 0; i < len; i++) {
> -               rc =3D cond_read_node(p, &p->cond_list[i], fp);
> +               rc =3D cond_read_node(p, &p->cond_list[i], fp, NULL);
>                 if (rc)
>                         goto err;
>         }
> diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/cond=
itional.h
> index 5a7b51278dc6..62a12d00cac9 100644
> --- a/security/selinux/ss/conditional.h
> +++ b/security/selinux/ss/conditional.h
> @@ -70,7 +70,7 @@ int cond_destroy_bool(void *key, void *datum, void *p);
>  int cond_index_bool(void *key, void *datum, void *datap);
>
>  int cond_read_bool(struct policydb *p, struct symtab *s, void *fp);
> -int cond_read_list(struct policydb *p, void *fp);
> +int cond_read_list(struct policydb *p, struct policy_file *fp);
>  int cond_write_bool(void *key, void *datum, void *ptr);
>  int cond_write_list(struct policydb *p, void *fp);
>
> --
> 2.41.0
>
