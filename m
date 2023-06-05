Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F22C7EE23
	for <selinux@archiver.kernel.org>; Mon,  5 Jun 2023 20:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjFEUHU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Jun 2023 16:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjFEUHU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Jun 2023 16:07:20 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15486E9
        for <selinux@vger.kernel.org>; Mon,  5 Jun 2023 13:07:18 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1adf27823so48972331fa.2
        for <selinux@vger.kernel.org>; Mon, 05 Jun 2023 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685995636; x=1688587636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VL3j/VWa+jtzCukWGGdAuojxm1BW6NBP/8aIT+xNHZU=;
        b=oTRr8NaLF3ZXxeO89+Ze2GVXFCOmA6inzO7PhpLAR+Hf+VFdczqCl35CydcQ8K5DiI
         pdSrrvIiHouIf9mlQANqvqK+BAUxBciogkxCA8Ga/LXLVmTZuTaf2xH3dCYcGJkk90/W
         9ar8nEsaDMJbfFIHGAmEd5MMKjicKHKg6i0h9gaauSwufN63VdWv63n+TI3ActbRM2mb
         ia+Oah8ur386tPfgatyLnN3DIfYETxbhbKpNALDc4IKgoI+v7jMPFlVBZ6Vfx/OeSRPG
         mq5OwxlBjmJUdAoCb2E/hDcufwBJ5v6PlQdbUono3vI6xu7nvr8F9kv3jmu0iwzFWNxY
         YeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685995636; x=1688587636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VL3j/VWa+jtzCukWGGdAuojxm1BW6NBP/8aIT+xNHZU=;
        b=VC1rm/XlLu/7s7R5WvOZawJduPKEJVaQxXrxGAZ7sW0hA95Jb2VCkE39OBfDKJynBo
         u4phrJMtLZRQI1UGA58Zbk5goZ2AnOpAUZ2mIxjtWzAqa547fQ5CXNWCgUcBpLeGy7X2
         FZk0jM8fmhTED2yv2+Hc6FJR/oZnlVsyzlIpkJyvgExkgeXIMofrgbHgUvGCD9mv0YWH
         G6iaB9uhaY0UEpKiQVqxxTL3dciR4WbOinXhBazyCdhP9aZCWZd0XfPHoYQP981oOLlC
         G7yVhKzB/x5657H04SJSyT+Fewx3IcQTDlV3Ql8cbtdiPgWht8GfnuptDXhi1yIjDCx4
         k0UQ==
X-Gm-Message-State: AC+VfDxFdkMbvHsAqQiHzH9tHETkOtwB8F3koJUmWeqXfw6uiG5Q3mXs
        lOZuqlji8ayvi5e+C5A4PNISUIrrUSWeetif7do=
X-Google-Smtp-Source: ACHHUZ5C23g5iElvSEYCxG2RjUbTc3/whLJrcmM5dAFMIX4PE2LF8l8+81UiqjTQV9ozgolNVcRLVQRpWuAoIaZmhkw=
X-Received: by 2002:a2e:9202:0:b0:2b1:d9eb:34b9 with SMTP id
 k2-20020a2e9202000000b002b1d9eb34b9mr141623ljg.40.1685995636003; Mon, 05 Jun
 2023 13:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230308095308.60661-1-wanghuizhao1@huawei.com>
 <20230308095308.60661-2-wanghuizhao1@huawei.com> <CAP+JOzSSfyq1Dxgfg-Spvxvro7AHVNjTEVsp+aSDyteFc3Yd9g@mail.gmail.com>
In-Reply-To: <CAP+JOzSSfyq1Dxgfg-Spvxvro7AHVNjTEVsp+aSDyteFc3Yd9g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 5 Jun 2023 16:07:04 -0400
Message-ID: <CAP+JOzSoogekWHTKsWaWXj0OmxJb8kVT0gF3wL7bc654=30A3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] libselinux: migrating hashtab from policycoreutils
To:     wanghuizhao <wanghuizhao1@huawei.com>
Cc:     selinux@vger.kernel.org, cgzones@googlemail.com,
        lautrbach@redhat.com, jason@perfinion.com, weiyuchen3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 24, 2023 at 9:51=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Mar 8, 2023 at 4:53=E2=80=AFAM wanghuizhao <wanghuizhao1@huawei.c=
om> wrote:
> >
> > To use hashtab in libselinux, migrate the existing hashtab template
> > from policycoreutils/newrole to libselinux.
> >
> > Signed-off-by: wanghuizhao <wanghuizhao1@huawei.com>
>
> For these three patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These three patches have been merged.
Thanks,
Jim

> > ---
> >  libselinux/src/hashtab.c | 208 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  libselinux/src/hashtab.h | 115 ++++++++++++++++++++++++++
> >  2 files changed, 323 insertions(+)
> >  create mode 100644 libselinux/src/hashtab.c
> >  create mode 100644 libselinux/src/hashtab.h
> >
> > diff --git a/libselinux/src/hashtab.c b/libselinux/src/hashtab.c
> > new file mode 100644
> > index 00000000..26d4f4c7
> > --- /dev/null
> > +++ b/libselinux/src/hashtab.c
> > @@ -0,0 +1,208 @@
> > +
> > +/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +
> > +/* FLASK */
> > +
> > +/*
> > + * Implementation of the hash table type.
> > + */
> > +
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include "hashtab.h"
> > +
> > +hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
> > +                                                    const_hashtab_key_=
t key),
> > +                        int (*keycmp) (hashtab_t h,
> > +                                       const_hashtab_key_t key1,
> > +                                       const_hashtab_key_t key2),
> > +                        unsigned int size)
> > +{
> > +
> > +       hashtab_t p;
> > +       unsigned int i;
> > +
> > +       p =3D (hashtab_t) malloc(sizeof(hashtab_val_t));
> > +       if (p =3D=3D NULL)
> > +               return p;
> > +
> > +       memset(p, 0, sizeof(hashtab_val_t));
> > +       p->size =3D size;
> > +       p->nel =3D 0;
> > +       p->hash_value =3D hash_value;
> > +       p->keycmp =3D keycmp;
> > +       p->htable =3D (hashtab_ptr_t *) malloc(sizeof(hashtab_ptr_t) * =
size);
> > +       if (p->htable =3D=3D NULL) {
> > +               free(p);
> > +               return NULL;
> > +       }
> > +       for (i =3D 0; i < size; i++)
> > +               p->htable[i] =3D (hashtab_ptr_t) NULL;
> > +
> > +       return p;
> > +}
> > +
> > +int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t dat=
um)
> > +{
> > +       unsigned int hvalue;
> > +       hashtab_ptr_t prev, cur, newnode;
> > +
> > +       if (!h)
> > +               return HASHTAB_OVERFLOW;
> > +
> > +       hvalue =3D h->hash_value(h, key);
> > +       prev =3D NULL;
> > +       cur =3D h->htable[hvalue];
> > +       while (cur && h->keycmp(h, key, cur->key) > 0) {
> > +               prev =3D cur;
> > +               cur =3D cur->next;
> > +       }
> > +
> > +       if (cur && (h->keycmp(h, key, cur->key) =3D=3D 0))
> > +               return HASHTAB_PRESENT;
> > +
> > +       newnode =3D (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
> > +       if (newnode =3D=3D NULL)
> > +               return HASHTAB_OVERFLOW;
> > +       memset(newnode, 0, sizeof(struct hashtab_node));
> > +       newnode->key =3D key;
> > +       newnode->datum =3D datum;
> > +       if (prev) {
> > +               newnode->next =3D prev->next;
> > +               prev->next =3D newnode;
> > +       } else {
> > +               newnode->next =3D h->htable[hvalue];
> > +               h->htable[hvalue] =3D newnode;
> > +       }
> > +
> > +       h->nel++;
> > +       return HASHTAB_SUCCESS;
> > +}
> > +
> > +int hashtab_remove(hashtab_t h, hashtab_key_t key,
> > +                  void (*destroy) (hashtab_key_t k,
> > +                                   hashtab_datum_t d, void *args), voi=
d *args)
> > +{
> > +       unsigned int hvalue;
> > +       hashtab_ptr_t cur, last;
> > +
> > +       if (!h)
> > +               return HASHTAB_MISSING;
> > +
> > +       hvalue =3D h->hash_value(h, key);
> > +       last =3D NULL;
> > +       cur =3D h->htable[hvalue];
> > +       while (cur !=3D NULL && h->keycmp(h, key, cur->key) > 0) {
> > +               last =3D cur;
> > +               cur =3D cur->next;
> > +       }
> > +
> > +       if (cur =3D=3D NULL || (h->keycmp(h, key, cur->key) !=3D 0))
> > +               return HASHTAB_MISSING;
> > +
> > +       if (last =3D=3D NULL)
> > +               h->htable[hvalue] =3D cur->next;
> > +       else
> > +               last->next =3D cur->next;
> > +
> > +       if (destroy)
> > +               destroy(cur->key, cur->datum, args);
> > +       free(cur);
> > +       h->nel--;
> > +       return HASHTAB_SUCCESS;
> > +}
> > +
> > +hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
> > +{
> > +
> > +       unsigned int hvalue;
> > +       hashtab_ptr_t cur;
> > +
> > +       if (!h)
> > +               return NULL;
> > +
> > +       hvalue =3D h->hash_value(h, key);
> > +       cur =3D h->htable[hvalue];
> > +       while (cur !=3D NULL && h->keycmp(h, key, cur->key) > 0)
> > +               cur =3D cur->next;
> > +
> > +       if (cur =3D=3D NULL || (h->keycmp(h, key, cur->key) !=3D 0))
> > +               return NULL;
> > +
> > +       return cur->datum;
> > +}
> > +
> > +void hashtab_destroy(hashtab_t h)
> > +{
> > +       unsigned int i;
> > +       hashtab_ptr_t cur, temp;
> > +
> > +       if (!h)
> > +               return;
> > +
> > +       for (i =3D 0; i < h->size; i++) {
> > +               cur =3D h->htable[i];
> > +               while (cur !=3D NULL) {
> > +                       temp =3D cur;
> > +                       cur =3D cur->next;
> > +                       free(temp);
> > +               }
> > +               h->htable[i] =3D NULL;
> > +       }
> > +
> > +       free(h->htable);
> > +       h->htable =3D NULL;
> > +
> > +       free(h);
> > +}
> > +
> > +int hashtab_map(hashtab_t h,
> > +               int (*apply) (hashtab_key_t k,
> > +                             hashtab_datum_t d, void *args), void *arg=
s)
> > +{
> > +       unsigned int i;
> > +       hashtab_ptr_t cur;
> > +       int ret;
> > +
> > +       if (!h)
> > +               return HASHTAB_SUCCESS;
> > +
> > +       for (i =3D 0; i < h->size; i++) {
> > +               cur =3D h->htable[i];
> > +               while (cur !=3D NULL) {
> > +                       ret =3D apply(cur->key, cur->datum, args);
> > +                       if (ret)
> > +                               return ret;
> > +                       cur =3D cur->next;
> > +               }
> > +       }
> > +       return HASHTAB_SUCCESS;
> > +}
> > +
> > +void hashtab_hash_eval(hashtab_t h, char *tag)
> > +{
> > +       unsigned int i;
> > +       int chain_len, slots_used, max_chain_len;
> > +       hashtab_ptr_t cur;
> > +
> > +       slots_used =3D 0;
> > +       max_chain_len =3D 0;
> > +       for (i =3D 0; i < h->size; i++) {
> > +               cur =3D h->htable[i];
> > +               if (cur) {
> > +                       slots_used++;
> > +                       chain_len =3D 0;
> > +                       while (cur) {
> > +                               chain_len++;
> > +                               cur =3D cur->next;
> > +                       }
> > +
> > +                       if (chain_len > max_chain_len)
> > +                               max_chain_len =3D chain_len;
> > +               }
> > +       }
> > +
> > +       printf
> > +           ("%s:  %d entries and %d/%d buckets used, longest chain len=
gth %d\n",
> > +            tag, h->nel, slots_used, h->size, max_chain_len);
> > +}
> > diff --git a/libselinux/src/hashtab.h b/libselinux/src/hashtab.h
> > new file mode 100644
> > index 00000000..78471269
> > --- /dev/null
> > +++ b/libselinux/src/hashtab.h
> > @@ -0,0 +1,115 @@
> > +
> > +/* Author : Stephen Smalley, <sds@tycho.nsa.gov> */
> > +
> > +/* FLASK */
> > +
> > +/*
> > + * A hash table (hashtab) maintains associations between
> > + * key values and datum values.  The type of the key values
> > + * and the type of the datum values is arbitrary.  The
> > + * functions for hash computation and key comparison are
> > + * provided by the creator of the table.
> > + */
> > +
> > +#ifndef _NEWROLE_HASHTAB_H_
> > +#define _NEWROLE_HASHTAB_H_
> > +
> > +#include <stdint.h>
> > +#include <errno.h>
> > +#include <stdio.h>
> > +
> > +typedef char *hashtab_key_t;   /* generic key type */
> > +typedef const char *const_hashtab_key_t;       /* constant generic key=
 type */
> > +typedef void *hashtab_datum_t; /* generic datum type */
> > +
> > +typedef struct hashtab_node *hashtab_ptr_t;
> > +
> > +typedef struct hashtab_node {
> > +       hashtab_key_t key;
> > +       hashtab_datum_t datum;
> > +       hashtab_ptr_t next;
> > +} hashtab_node_t;
> > +
> > +typedef struct hashtab_val {
> > +       hashtab_ptr_t *htable;  /* hash table */
> > +       unsigned int size;      /* number of slots in hash table */
> > +       uint32_t nel;           /* number of elements in hash table */
> > +       unsigned int (*hash_value) (struct hashtab_val * h, const_hasht=
ab_key_t key);   /* hash function */
> > +       int (*keycmp) (struct hashtab_val * h, const_hashtab_key_t key1=
, const_hashtab_key_t key2);     /* key comparison function */
> > +} hashtab_val_t;
> > +
> > +typedef hashtab_val_t *hashtab_t;
> > +
> > +/* Define status codes for hash table functions */
> > +#define HASHTAB_SUCCESS     0
> > +#define HASHTAB_OVERFLOW    -ENOMEM
> > +#define HASHTAB_PRESENT     -EEXIST
> > +#define HASHTAB_MISSING     -ENOENT
> > +
> > +/*
> > +   Creates a new hash table with the specified characteristics.
> > +
> > +   Returns NULL if insufficient space is available or
> > +   the new hash table otherwise.
> > + */
> > +extern hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t =
h,
> > +                                                           const_hasht=
ab_key_t
> > +                                                           key),
> > +                               int (*keycmp) (hashtab_t h,
> > +                                              const_hashtab_key_t key1=
,
> > +                                              const_hashtab_key_t key2=
),
> > +                               unsigned int size);
> > +/*
> > +   Inserts the specified (key, datum) pair into the specified hash tab=
le.
> > +
> > +   Returns HASHTAB_OVERFLOW if insufficient space is available or
> > +   HASHTAB_PRESENT  if there is already an entry with the same key or
> > +   HASHTAB_SUCCESS otherwise.
> > + */
> > +extern int hashtab_insert(hashtab_t h, hashtab_key_t k, hashtab_datum_=
t d);
> > +
> > +/*
> > +   Removes the entry with the specified key from the hash table.
> > +   Applies the specified destroy function to (key,datum,args) for
> > +   the entry.
> > +
> > +   Returns HASHTAB_MISSING if no entry has the specified key or
> > +   HASHTAB_SUCCESS otherwise.
> > + */
> > +extern int hashtab_remove(hashtab_t h, hashtab_key_t k,
> > +                         void (*destroy) (hashtab_key_t k,
> > +                                          hashtab_datum_t d,
> > +                                          void *args), void *args);
> > +
> > +/*
> > +   Searches for the entry with the specified key in the hash table.
> > +
> > +   Returns NULL if no entry has the specified key or
> > +   the datum of the entry otherwise.
> > + */
> > +extern hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t=
 k);
> > +
> > +/*
> > +   Destroys the specified hash table.
> > + */
> > +extern void hashtab_destroy(hashtab_t h);
> > +
> > +/*
> > +   Applies the specified apply function to (key,datum,args)
> > +   for each entry in the specified hash table.
> > +
> > +   The order in which the function is applied to the entries
> > +   is dependent upon the internal structure of the hash table.
> > +
> > +   If apply returns a non-zero status, then hashtab_map will cease
> > +   iterating through the hash table and will propagate the error
> > +   return to its caller.
> > + */
> > +extern int hashtab_map(hashtab_t h,
> > +                      int (*apply) (hashtab_key_t k,
> > +                                    hashtab_datum_t d,
> > +                                    void *args), void *args);
> > +
> > +extern void hashtab_hash_eval(hashtab_t h, char *tag);
> > +
> > +#endif
> > --
> > 2.12.3
> >
