Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAC3EEAA7A
	for <selinux@archiver.kernel.org>; Thu, 14 Sep 2023 21:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjINV5l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjINV5k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Sep 2023 17:57:40 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D19C1BFA
        for <selinux@vger.kernel.org>; Thu, 14 Sep 2023 14:57:36 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5735282d713so840645eaf.2
        for <selinux@vger.kernel.org>; Thu, 14 Sep 2023 14:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694728656; x=1695333456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EGYJ9kRSCOoiTavLwnrcLi3cSkpUju2Ncq2+4kQdN4=;
        b=OZTCYid5aJNpLVkyd6Xlx6yC/WBRItrORKb1Zx1hPDKTBtQGeGVQTbOImBiw/xiwxB
         eXe5lGIF6fVeDbr+bRpT8rYdUBxmhLz/ZKBoL0oqq8Bu56Yt0pPhKAFIUAG8Sh0lcLMN
         L05cFQWlgVJshWU+w8phNtBHHBNsI0wTpIcs+YMK+Ur1zVxCt4uHDSZeEBBaD/54BSiQ
         RQT+DcI4PJDl9U6tv6S1r2Cb2njMg/WiHhDLyY7fWTmtQfevCbwiYcbZhxc0rX34TCky
         udjwDlqfzmwEvXeVBdIlc7FIR7yJEGzw8LPO2scIsqt8W/Rv2x7JgsFI+v1lrm9TvRIL
         Qf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694728656; x=1695333456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EGYJ9kRSCOoiTavLwnrcLi3cSkpUju2Ncq2+4kQdN4=;
        b=nsurJ0/45Ht7snXoxiE3j8DCPgHBIllXOFbeY9NdHCQLPOahUDbqXLpBOqEg6clk5V
         99owbrlLdWI3C5y+8bQ9qZgC9CnVXg6M941uzY5bnxKBdBPSu8OuBQyTPnCvt77Y9DVW
         0Y2KyBi8WEOMkBCwx7G6JzaSEp9lN4av8YOYezQBx7FrboGXe8XWScWrKGuA/neOSXWc
         QHt/Sx3vKM546MMYl8ISP3plDp1SxHThU9ye2aTCJcwgv4aaQRZskWvwgRv0ejSe13DS
         G9SzrS55lK3Zk9nAZDfsTygyIrLyC5ZS0amLu3a+cUsQZl0vlE11ClTDEHP1jXQJ3LAA
         9k4g==
X-Gm-Message-State: AOJu0YxTEIP34hVvodv2bQTRSxPTzUTnt9uRE9r81ZjnJNrUhaFeK3KK
        ibwWspEt6OHmKq884Kj/HWaBWHzWQYx2NoGx+ew=
X-Google-Smtp-Source: AGHT+IEYzPKFxcEvxrUPdaGUZbMBrCoXWrgd0pOH0vpYY9l3Wlg58ePi4SYYrLZHg9ET7B59ffvp/KDbU1rX/UdaD1E=
X-Received: by 2002:a05:6808:2009:b0:3a7:7bd3:7a7d with SMTP id
 q9-20020a056808200900b003a77bd37a7dmr9003607oiw.23.1694728655615; Thu, 14 Sep
 2023 14:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230906154611.31762-2-jsatterfield.linux@gmail.com> <e55fa937809c138e4b474c8ed55d2fdc.paul@paul-moore.com>
In-Reply-To: <e55fa937809c138e4b474c8ed55d2fdc.paul@paul-moore.com>
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
Date:   Thu, 14 Sep 2023 17:57:23 -0400
Message-ID: <CALMFces6EfJLJXpi9JO-rFa-s1CZiayERgGW7ggzN1MJmF275w@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: use arrays for avtab hashtable nodes
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 12, 2023 at 11:23=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Sep  6, 2023 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> >
> > The current avtab hashtable employs a separate chaining collision
> > resolution strategy where each bucket/chain holds an ordered linked lis=
t
> > of pointers to kmem_cache allocated avtab_node elements.
> >
> > On Fedora 38 (x86_64) using the default policy, avtab_node_cachep
> > uses 573 slabs each containing 170 objects totaling 2,337,840 bytes.
> > A call to kmem_cache_zalloc() is required for every single rule, which
> > in the default policy is currently 96,730 and continually rising.
> >
> > When both sets of avtab_node (regular and cond.) are turned into arrays
> > with the hash table slot indexing into it rather than a pointer, then
> > this results in only 2 additional kvcalloc() calls and the complete
> > removal of the kmem_cache itself.
> >
> > The caching characteristics of iterating a single array are better due
> > to locality of reference. Running "perf stat -r 100 -d load_policy"
> > has shown a runtime reduction of at least 10% on a Fedora 38 x86_64 VM
> > with this single patch. Future patches focused on improving the hash
> > table's collision resolution strategy and array layout (struct-of-array=
s
> > vs. array-of-structs) may elicit even more caching and therefore runtim=
e
> > performance improvements.
> >
> > On 64-bit machines, the memory usage of the hash table slots is cut in
> > half due to the use of u32 indices instead of memory pointers. Since
> > ~65k hash slots are used between the regular and cond. tables with the
> > default Fedora 38 policy, this equates to around 256KB of memory saved.
> >
> > Notes:
> >
> > A couple helper functions avtab_get_chain() and avtab_get_node() are
> > introduced to provide more standardized interfaces for use in functions
> > that need to search through the hash table.
> >
> > NULL_NODE_IDX defines a sentinel value which helps determinine if a spo=
t
> > in the hash table or the "next" member of an avtab_node are valid.
> >
> > This patch causes the cond. rules table to waste memory as the size
> > requested for the kvcalloc() is the size of the regular rules table.
> > These tables rarely, if ever, have the same number of rules in practice=
.
> > The next patch addresses this shortcoming.
>
> Isn't the more important issue that of there being more conditional
> rules than regular rules?  Yes, I'm sure this is very unlikely, but
> given just this patch wouldn't this cause a problem?
>
> It is important to remember that even when combined in a patchset,
> any given patch should not break the system.  A patch can depend on
> prior patches in the patchset, but not upcoming patches.
>
> I've only looked very briefly at patch 2/3, but I suspect at the very
> least you may need to squash patches 1/3 and 2/3 to ensure there is
> no breakage.
>
> More comments below (all are in the context of patch 1/3, some may not
> be relevant in the context of 1/3+2/3).
>

I will squash the two in the next version.

> > Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/ss/avtab.c       | 75 +++++++++++++++----------------
> >  security/selinux/ss/avtab.h       | 28 ++++++++++--
> >  security/selinux/ss/conditional.c | 13 +++---
> >  security/selinux/ss/services.c    | 20 +++++----
> >  4 files changed, 81 insertions(+), 55 deletions(-)
> >
> > diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> > index 86d98a8e291b..620ea0a03e41 100644
> > --- a/security/selinux/ss/avtab.c
> > +++ b/security/selinux/ss/avtab.c
> > @@ -23,7 +23,6 @@
> >  #include "avtab.h"
> >  #include "policydb.h"
> >
> > -static struct kmem_cache *avtab_node_cachep __ro_after_init;
> >  static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
> >
> >  /* Based on MurmurHash3, written by Austin Appleby and placed in the
> > @@ -70,17 +69,17 @@ avtab_insert_node(struct avtab *h, u32 hvalue,
> >                 struct avtab_node *prev,
> >                 const struct avtab_key *key, const struct avtab_datum *=
datum)
> >  {
> > +     u32 newnodei;
> >       struct avtab_node *newnode;
> >       struct avtab_extended_perms *xperms;
> > -     newnode =3D kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
> > -     if (newnode =3D=3D NULL)
> > -             return NULL;
> > +     newnodei =3D ++h->nel;
>
> This makes me nervous that some future code change forgets to
> decrement h->nel in its error handler.  Let's only bump h->nel at the
> end of the function.
>

Agreed.

> We also should have a check in this function to ensure we don't
> overflow the array size.
>

When 1/3 + 2/3 are squashed, there is a check which grows the array if full=
.

> > +     newnode =3D avtab_get_node(h, newnodei);
> >       newnode->key =3D *key;
> >
> >       if (key->specified & AVTAB_XPERMS) {
> >               xperms =3D kmem_cache_zalloc(avtab_xperms_cachep, GFP_KER=
NEL);
> >               if (xperms =3D=3D NULL) {
> > -                     kmem_cache_free(avtab_node_cachep, newnode);
> > +                     --h->nel;
> >                       return NULL;
> >               }
> >               *xperms =3D *(datum->u.xperms);
> > @@ -91,15 +90,12 @@ avtab_insert_node(struct avtab *h, u32 hvalue,
> >
> >       if (prev) {
> >               newnode->next =3D prev->next;
> > -             prev->next =3D newnode;
> > +             prev->next =3D newnodei;
> >       } else {
> > -             struct avtab_node **n =3D &h->htable[hvalue];
> > -
> > -             newnode->next =3D *n;
> > -             *n =3D newnode;
> > +             newnode->next =3D h->htable[hvalue];
> > +             h->htable[hvalue] =3D newnodei;
> >       }
>
> See my comments below about the next field in the avtab_node struct.
>
> > -     h->nel++;
> >       return newnode;
> >  }
> >
> > @@ -114,9 +110,9 @@ static int avtab_insert(struct avtab *h, const stru=
ct avtab_key *key,
> >               return -EINVAL;
> >
> >       hvalue =3D avtab_hash(key, h->mask);
> > -     for (prev =3D NULL, cur =3D h->htable[hvalue];
> > +     for (prev =3D NULL, cur =3D avtab_get_chain(h, hvalue);
> >            cur;
> > -          prev =3D cur, cur =3D cur->next) {
> > +          prev =3D cur, cur =3D avtab_get_node(h, cur->next)) {
> >               if (key->source_type =3D=3D cur->key.source_type &&
> >                   key->target_type =3D=3D cur->key.target_type &&
> >                   key->target_class =3D=3D cur->key.target_class &&
> > @@ -159,9 +155,9 @@ struct avtab_node *avtab_insert_nonunique(struct av=
tab *h,
> >       if (!h || !h->nslot || h->nel =3D=3D U32_MAX)
> >               return NULL;
> >       hvalue =3D avtab_hash(key, h->mask);
> > -     for (prev =3D NULL, cur =3D h->htable[hvalue];
> > +     for (prev =3D NULL, cur =3D avtab_get_chain(h, hvalue);
> >            cur;
> > -          prev =3D cur, cur =3D cur->next) {
> > +          prev =3D cur, cur =3D avtab_get_node(h, cur->next)) {
> >               if (key->source_type =3D=3D cur->key.source_type &&
> >                   key->target_type =3D=3D cur->key.target_type &&
> >                   key->target_class =3D=3D cur->key.target_class &&
> > @@ -194,8 +190,8 @@ struct avtab_node *avtab_search_node(struct avtab *=
h,
> >               return NULL;
> >
> >       hvalue =3D avtab_hash(key, h->mask);
> > -     for (cur =3D h->htable[hvalue]; cur;
> > -          cur =3D cur->next) {
> > +     for (cur =3D avtab_get_chain(h, hvalue); cur;
> > +          cur =3D avtab_get_node(h, cur->next)) {
> >               if (key->source_type =3D=3D cur->key.source_type &&
> >                   key->target_type =3D=3D cur->key.target_type &&
> >                   key->target_class =3D=3D cur->key.target_class &&
> > @@ -216,7 +212,7 @@ struct avtab_node *avtab_search_node(struct avtab *=
h,
> >  }
> >
> >  struct avtab_node*
> > -avtab_search_node_next(struct avtab_node *node, u16 specified)
> > +avtab_search_node_next(struct avtab *h, struct avtab_node *node, u16 s=
pecified)
> >  {
> >       struct avtab_node *cur;
> >
> > @@ -224,7 +220,7 @@ avtab_search_node_next(struct avtab_node *node, u16=
 specified)
> >               return NULL;
> >
> >       specified &=3D ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
> > -     for (cur =3D node->next; cur; cur =3D cur->next) {
> > +     for (cur =3D avtab_get_node(h, node->next); cur; cur =3D avtab_ge=
t_node(h, cur->next)) {
> >               if (node->key.source_type =3D=3D cur->key.source_type &&
> >                   node->key.target_type =3D=3D cur->key.target_type &&
> >                   node->key.target_class =3D=3D cur->key.target_class &=
&
> > @@ -247,24 +243,24 @@ avtab_search_node_next(struct avtab_node *node, u=
16 specified)
> >  void avtab_destroy(struct avtab *h)
> >  {
> >       u32 i;
> > -     struct avtab_node *cur, *temp;
> > +     struct avtab_node *cur;
> >
> >       if (!h)
> >               return;
> >
> >       for (i =3D 0; i < h->nslot; i++) {
> > -             cur =3D h->htable[i];
> > +             cur =3D avtab_get_chain(h, i);
> >               while (cur) {
> > -                     temp =3D cur;
> > -                     cur =3D cur->next;
> > -                     if (temp->key.specified & AVTAB_XPERMS)
> > +                     if (cur->key.specified & AVTAB_XPERMS)
> >                               kmem_cache_free(avtab_xperms_cachep,
> > -                                             temp->datum.u.xperms);
> > -                     kmem_cache_free(avtab_node_cachep, temp);
> > +                                             cur->datum.u.xperms);
> > +                     cur =3D avtab_get_node(h, cur->next);
> >               }
> >       }
> >       kvfree(h->htable);
> > +     kvfree(h->nodes);
> >       h->htable =3D NULL;
> > +     h->nodes =3D NULL;
> >       h->nel =3D 0;
> >       h->nslot =3D 0;
> >       h->mask =3D 0;
> > @@ -273,20 +269,26 @@ void avtab_destroy(struct avtab *h)
> >  void avtab_init(struct avtab *h)
> >  {
> >       h->htable =3D NULL;
> > +     h->nodes =3D NULL;
> >       h->nel =3D 0;
> >       h->nslot =3D 0;
> >       h->mask =3D 0;
> >  }
> >
> > -static int avtab_alloc_common(struct avtab *h, u32 nslot)
> > +static int avtab_alloc_common(struct avtab *h, u32 nslot, u32 nrules)
> >  {
> >       if (!nslot)
> >               return 0;
> >
> > -     h->htable =3D kvcalloc(nslot, sizeof(void *), GFP_KERNEL);
> > +     h->htable =3D kvcalloc(nslot, sizeof(u32), GFP_KERNEL);
> >       if (!h->htable)
> >               return -ENOMEM;
> > -
> > +     h->nodes =3D kvcalloc(nrules, sizeof(struct avtab_node), GFP_KERN=
EL);
> > +     if (!h->nodes) {
> > +             kvfree(h->htable);
> > +             h->htable =3D NULL;
> > +             return -ENOMEM;
> > +     }
> >       h->nslot =3D nslot;
> >       h->mask =3D nslot - 1;
> >       return 0;
> > @@ -308,7 +310,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
> >               if (nslot > MAX_AVTAB_HASH_BUCKETS)
> >                       nslot =3D MAX_AVTAB_HASH_BUCKETS;
> >
> > -             rc =3D avtab_alloc_common(h, nslot);
> > +             rc =3D avtab_alloc_common(h, nslot, nrules);
> >               if (rc)
> >                       return rc;
> >       }
> > @@ -319,7 +321,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
> >
> >  int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
> >  {
> > -     return avtab_alloc_common(new, orig->nslot);
> > +     return avtab_alloc_common(new, orig->nslot, orig->nel);
> >  }
> >
> >  #ifdef CONFIG_SECURITY_SELINUX_DEBUG
> > @@ -333,13 +335,13 @@ void avtab_hash_eval(struct avtab *h, const char =
*tag)
> >       max_chain_len =3D 0;
> >       chain2_len_sum =3D 0;
> >       for (i =3D 0; i < h->nslot; i++) {
> > -             cur =3D h->htable[i];
> > +             cur =3D avtab_get_chain(h, i);
> >               if (cur) {
> >                       slots_used++;
> >                       chain_len =3D 0;
> >                       while (cur) {
> >                               chain_len++;
> > -                             cur =3D cur->next;
> > +                             cur =3D avtab_get_node(h, cur->next);
> >                       }
> >
> >                       if (chain_len > max_chain_len)
> > @@ -627,8 +629,8 @@ int avtab_write(struct policydb *p, struct avtab *a=
, void *fp)
> >               return rc;
> >
> >       for (i =3D 0; i < a->nslot; i++) {
> > -             for (cur =3D a->htable[i]; cur;
> > -                  cur =3D cur->next) {
> > +             for (cur =3D avtab_get_chain(a, i); cur;
> > +                  cur =3D avtab_get_node(a, cur->next)) {
> >                       rc =3D avtab_write_item(p, cur, fp);
> >                       if (rc)
> >                               return rc;
> > @@ -640,9 +642,6 @@ int avtab_write(struct policydb *p, struct avtab *a=
, void *fp)
> >
> >  void __init avtab_cache_init(void)
> >  {
> > -     avtab_node_cachep =3D kmem_cache_create("avtab_node",
> > -                                           sizeof(struct avtab_node),
> > -                                           0, SLAB_PANIC, NULL);
> >       avtab_xperms_cachep =3D kmem_cache_create("avtab_extended_perms",
> >                                               sizeof(struct avtab_exten=
ded_perms),
> >                                               0, SLAB_PANIC, NULL);
> > diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> > index 3c3904bf02b0..72708aed5fff 100644
> > --- a/security/selinux/ss/avtab.h
> > +++ b/security/selinux/ss/avtab.h
> > @@ -77,16 +77,38 @@ struct avtab_datum {
> >  struct avtab_node {
> >       struct avtab_key key;
> >       struct avtab_datum datum;
> > -     struct avtab_node *next;
> > +     u32 next;
>
> Given that one of the common avtab lookup operations is to simply walk
> the list, using the next field, why not keep the next field as a
> pointer?  Sure, you loose the 64-bit to 32-bit size reduction on 64-bit
> systems (although I wonder if alignment issues rendered that moot), but
> I would expect the walk to be quicker if you only needed to do a single
> next pointer lookup as opposed to the array indexing.
>
> I may be missing something, but I believe this would also remove the
> need for the NULL_NODE_IDX sentinel.
>

The conditional avtab is the reason an index was used instead of a
pointer. Because it doesn't have the right hint when allocating the
nodes array, we have to copy the nodes array into a smaller buffer
after reading the rules (otherwise we waste about 1.7 MB of memory).
The copy invalidates the pointers that each "next" refers to as they
would be pointing to free'd memory instead of the new nodes array.
However, I agree that the walk would be quicker with the direct
pointer reference instead of the array index and with the way the
struct alignment works, the index here doesn't save memory.

An alternative I have prototyped is to use pointer math to calculate
an offset from the original nodes array to where "next" is pointing to
and add it from the new array to calculate the new "next" value. This
changes "next" back to a pointer and gets rid of the indirection.

I agree that the NULL_NODE_IDX sentinel is not very ergonomic, however
it's at the cost of 256 KB of memory in relation to the htable slots.
Mainly due to the difficulty of telling when a slot is empty with an
index vs. a pointer. I could leave the htable slots as indexes, but it
would still require some form of sentinel value to indicate the
emptiness of a slot. What would you prefer?

> >  };
> >
> >  struct avtab {
> > -     struct avtab_node **htable;
> > +     u32 *htable;
>
> The field name "htable" is a little too confusing now, let's change
> it to "indicies", "offsets", or something like that.
>

Agreed, what about "slots" to coincide with the "nslot" variable below?

> > +     struct avtab_node *nodes;
> >       u32 nel;        /* number of elements */
> >       u32 nslot;      /* number of hash slots */
> >       u32 mask;       /* mask to compute hash func */
> >  };
> >
> > +/* sentinel value to signal an empty node */
> > +#define NULL_NODE_IDX                (0)
> > +/* compute the actual index into the nodes array */
> > +#define NODES_ARRAY_IDX(idx) ((idx) - 1)
>
> I'm pretty sure we can do away with NULL_NODE_IDX if we keep the next
> field as a pointer (NULL works as a sentinel), does that also mean we
> can get rid of the NODES_ARRAY_IDX translation?
>

See comment above. There is a tradeoff with memory if the sentinel and
translation are removed, but they are not required to use arrays
instead of a linked-list. It's up to you as to what is preferred.

> > +static inline struct avtab_node *avtab_get_chain(struct avtab *h, u32 =
slot)
> > +{
> > +     u32 chain_start =3D h->htable[slot];
> > +
> > +     if (chain_start !=3D NULL_NODE_IDX)
> > +             return &h->nodes[NODES_ARRAY_IDX(chain_start)];
> > +     return NULL;
>
> Don't duplicate avtab_get_node() here, call it instead; for example:
>
>  struct avtab_node *avtab_get_chain(h, slot)
>  {
>    return avtab_get_node(h, h->table[slot]);
>  }
>

Good call.

> > +}
> > +
> > +static inline struct avtab_node *avtab_get_node(struct avtab *h, u32 i=
dx)
> > +{
> > +     if (idx !=3D NULL_NODE_IDX)
> > +             return &h->nodes[NODES_ARRAY_IDX(idx)];
> > +     return NULL;
> > +}
> > +
> >  void avtab_init(struct avtab *h);
> >  int avtab_alloc(struct avtab *, u32);
> >  int avtab_alloc_dup(struct avtab *new, const struct avtab *orig);
> > @@ -117,7 +139,7 @@ struct avtab_node *avtab_insert_nonunique(struct av=
tab *h,
> >  struct avtab_node *avtab_search_node(struct avtab *h,
> >                                    const struct avtab_key *key);
> >
> > -struct avtab_node *avtab_search_node_next(struct avtab_node *node, u16=
 specified);
> > +struct avtab_node *avtab_search_node_next(struct avtab *h, struct avta=
b_node *node, u16 specified);
>
> Another benefit of preserving the next field as a pointer is that we
> should be able to leave the avtab_search_node_next() prototype intact.
> Probably the implementation too.
>

I agree and have changed the "next" field back to a pointer. This
reverts the prototype back.

> >  #define MAX_AVTAB_HASH_BITS 16
> >  #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
> > diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/co=
nditional.c
> > index 81ff676f209a..448bdacb1769 100644
> > --- a/security/selinux/ss/conditional.c
> > +++ b/security/selinux/ss/conditional.c
> > @@ -262,6 +262,7 @@ static int cond_insertf(struct avtab *a, const stru=
ct avtab_key *k,
> >       struct cond_insertf_data *data =3D ptr;
> >       struct policydb *p =3D data->p;
> >       struct cond_av_list *other =3D data->other;
> > +     struct avtab *cond_avtab =3D &p->te_cond_avtab;
> >       struct avtab_node *node_ptr;
> >       u32 i;
> >       bool found;
> > @@ -285,9 +286,9 @@ static int cond_insertf(struct avtab *a, const stru=
ct avtab_key *k,
> >                * be any other entries.
> >                */
> >               if (other) {
> > -                     node_ptr =3D avtab_search_node(&p->te_cond_avtab,=
 k);
> > +                     node_ptr =3D avtab_search_node(cond_avtab, k);
> >                       if (node_ptr) {
> > -                             if (avtab_search_node_next(node_ptr, k->s=
pecified)) {
> > +                             if (avtab_search_node_next(cond_avtab, no=
de_ptr, k->specified)) {
> >                                       pr_err("SELinux: too many conflic=
ting type rules.\n");
> >                                       return -EINVAL;
> >                               }
> > @@ -304,14 +305,14 @@ static int cond_insertf(struct avtab *a, const st=
ruct avtab_key *k,
> >                               }
> >                       }
> >               } else {
> > -                     if (avtab_search_node(&p->te_cond_avtab, k)) {
> > +                     if (avtab_search_node(cond_avtab, k)) {
> >                               pr_err("SELinux: conflicting type rules w=
hen adding type rule for true.\n");
> >                               return -EINVAL;
> >                       }
> >               }
> >       }
> >
> > -     node_ptr =3D avtab_insert_nonunique(&p->te_cond_avtab, k, d);
> > +     node_ptr =3D avtab_insert_nonunique(cond_avtab, k, d);
> >       if (!node_ptr) {
> >               pr_err("SELinux: could not insert rule.\n");
> >               return -ENOMEM;
> > @@ -563,7 +564,7 @@ void cond_compute_xperms(struct avtab *ctab, struct=
 avtab_key *key,
> >               return;
> >
> >       for (node =3D avtab_search_node(ctab, key); node;
> > -                     node =3D avtab_search_node_next(node, key->specif=
ied)) {
> > +                     node =3D avtab_search_node_next(ctab, node, key->=
specified)) {
> >               if (node->key.specified & AVTAB_ENABLED)
> >                       services_compute_xperms_decision(xpermd, node);
> >       }
> > @@ -580,7 +581,7 @@ void cond_compute_av(struct avtab *ctab, struct avt=
ab_key *key,
> >               return;
> >
> >       for (node =3D avtab_search_node(ctab, key); node;
> > -                             node =3D avtab_search_node_next(node, key=
->specified)) {
> > +                             node =3D avtab_search_node_next(ctab, nod=
e, key->specified)) {
> >               if ((u16)(AVTAB_ALLOWED|AVTAB_ENABLED) =3D=3D
> >                   (node->key.specified & (AVTAB_ALLOWED|AVTAB_ENABLED))=
)
> >                       avd->allowed |=3D node->datum.u.data;
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index 1eeffc66ea7d..89cb4fc2d4aa 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -617,6 +617,7 @@ static void context_struct_compute_av(struct policy=
db *policydb,
> >  {
> >       struct constraint_node *constraint;
> >       struct role_allow *ra;
> > +     struct avtab *avtab;
> >       struct avtab_key avkey;
> >       struct avtab_node *node;
> >       struct class_datum *tclass_datum;
> > @@ -644,6 +645,7 @@ static void context_struct_compute_av(struct policy=
db *policydb,
> >        * If a specific type enforcement rule was defined for
> >        * this permission check, then use it.
> >        */
> > +     avtab =3D &policydb->te_avtab;
> >       avkey.target_class =3D tclass;
> >       avkey.specified =3D AVTAB_AV | AVTAB_XPERMS;
> >       sattr =3D &policydb->type_attr_map_array[scontext->type - 1];
> > @@ -652,10 +654,9 @@ static void context_struct_compute_av(struct polic=
ydb *policydb,
> >               ebitmap_for_each_positive_bit(tattr, tnode, j) {
> >                       avkey.source_type =3D i + 1;
> >                       avkey.target_type =3D j + 1;
> > -                     for (node =3D avtab_search_node(&policydb->te_avt=
ab,
> > -                                                   &avkey);
> > +                     for (node =3D avtab_search_node(avtab, &avkey);
> >                            node;
> > -                          node =3D avtab_search_node_next(node, avkey.=
specified)) {
> > +                          node =3D avtab_search_node_next(avtab, node,=
 avkey.specified)) {
> >                               if (node->key.specified =3D=3D AVTAB_ALLO=
WED)
> >                                       avd->allowed |=3D node->datum.u.d=
ata;
> >                               else if (node->key.specified =3D=3D AVTAB=
_AUDITALLOW)
> > @@ -1008,6 +1009,7 @@ void security_compute_xperms_decision(u32 ssid,
> >       struct sidtab *sidtab;
> >       u16 tclass;
> >       struct context *scontext, *tcontext;
> > +     struct avtab *avtab;
> >       struct avtab_key avkey;
> >       struct avtab_node *node;
> >       struct ebitmap *sattr, *tattr;
> > @@ -1055,6 +1057,7 @@ void security_compute_xperms_decision(u32 ssid,
> >               goto out;
> >       }
> >
> > +     avtab =3D &policydb->te_avtab;
> >       avkey.target_class =3D tclass;
> >       avkey.specified =3D AVTAB_XPERMS;
> >       sattr =3D &policydb->type_attr_map_array[scontext->type - 1];
> > @@ -1063,10 +1066,9 @@ void security_compute_xperms_decision(u32 ssid,
> >               ebitmap_for_each_positive_bit(tattr, tnode, j) {
> >                       avkey.source_type =3D i + 1;
> >                       avkey.target_type =3D j + 1;
> > -                     for (node =3D avtab_search_node(&policydb->te_avt=
ab,
> > -                                                   &avkey);
> > +                     for (node =3D avtab_search_node(avtab, &avkey);
> >                            node;
> > -                          node =3D avtab_search_node_next(node, avkey.=
specified))
> > +                          node =3D avtab_search_node_next(avtab, node,=
 avkey.specified))
> >                               services_compute_xperms_decision(xpermd, =
node);
> >
> >                       cond_compute_xperms(&policydb->te_cond_avtab,
> > @@ -1705,6 +1707,7 @@ static int security_compute_sid(u32 ssid,
> >       struct class_datum *cladatum;
> >       struct context *scontext, *tcontext, newcontext;
> >       struct sidtab_entry *sentry, *tentry;
> > +     struct avtab *cond_avtab;
> >       struct avtab_key avkey;
> >       struct avtab_node *avnode, *node;
> >       u16 tclass;
> > @@ -1810,6 +1813,7 @@ static int security_compute_sid(u32 ssid,
> >       }
> >
> >       /* Look for a type transition/member/change rule. */
> > +     cond_avtab =3D &policydb->te_cond_avtab;
> >       avkey.source_type =3D scontext->type;
> >       avkey.target_type =3D tcontext->type;
> >       avkey.target_class =3D tclass;
> > @@ -1818,8 +1822,8 @@ static int security_compute_sid(u32 ssid,
> >
> >       /* If no permanent rule, also check for enabled conditional rules=
 */
> >       if (!avnode) {
> > -             node =3D avtab_search_node(&policydb->te_cond_avtab, &avk=
ey);
> > -             for (; node; node =3D avtab_search_node_next(node, specif=
ied)) {
> > +             node =3D avtab_search_node(cond_avtab, &avkey);
> > +             for (; node; node =3D avtab_search_node_next(cond_avtab, =
node, specified)) {
> >                       if (node->key.specified & AVTAB_ENABLED) {
> >                               avnode =3D node;
> >                               break;
> > --
> > 2.41.0
>
> --
> paul-moore.com
