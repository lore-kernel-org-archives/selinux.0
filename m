Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2E5C2BA1A
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 19:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE7520753
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 19:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8TdeDVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDFTmd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:42:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49192 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbgDFTmc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 15:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586202151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2TqpeKpaNmX6DilKdiNOY73b4PHXpHhhFitQYsVuBr0=;
        b=C8TdeDVmG7jcPtTntOaDORKuuoYqwLwm1apkREScnUKBDRkZrWdZySr+n4RmNVYY7nwB3C
        vVg4wfjjbVwHzFLk4iDgwQ54R8SnuCyc4QLHeVTw3xVKhZaDh9r2f9zjLbGOmnT/0gfNOo
        YSQmnzTo9z7Eoil+1tluVudxCEoxwro=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-QOIoDbQLOC2_vSf2Du17vQ-1; Mon, 06 Apr 2020 15:42:29 -0400
X-MC-Unique: QOIoDbQLOC2_vSf2Du17vQ-1
Received: by mail-oi1-f198.google.com with SMTP id w17so866830oih.17
        for <selinux@vger.kernel.org>; Mon, 06 Apr 2020 12:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TqpeKpaNmX6DilKdiNOY73b4PHXpHhhFitQYsVuBr0=;
        b=b0pRnEAdoJHnjxd22N4h1WzM5/QBGgT5ril8EiSER0OYPtCXYQ4a7GpYSua8UwUhbB
         kUmyI8g9li/N+y3RKn8UwQKyJwoYqP7kUVklqS2KjGE9WVeua41ZAGC2RKjEWALYjw+9
         RvZzURTjcXAWUJdsye02fpHF/Ky1Fnyh9H0UAsd0LGLsBLOlQTKMURgbHJLt0OhCTW5x
         mtLB+PyqD6NeZGJMKAjuCrXQb4wygzJFN6hAhbVlQEI3Qta4PAKq4Xqg8HyaaYMDFKiK
         6pf+SZgRpDd0TEK7qKrvgS2E5hJTlDeT6VIktaPuHtXvoTHMehdXBqYbRoVGpNR2aqvB
         L9/w==
X-Gm-Message-State: AGi0PubXWEYBLFeZeqWAiyaPaIqywaGK6V/fqA3U0dM9yEfvcuX99vi5
        ShkeBS77TdfAFtsOfS7yKCZUxqVuuj5DbRw4YenFuvxdVeXUG/vz0l18nl32ovA5W/q806rrzhU
        3WlntblS7EjhhukCw2OJ033XyZrHC83CgSQ==
X-Received: by 2002:aca:488a:: with SMTP id v132mr844188oia.166.1586202148422;
        Mon, 06 Apr 2020 12:42:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypJakJ14imw46BikJ0RsTffnJmZnQSWWI3gPZK5UsSJLXKCzKwThgeGSXWEO3v9x2+H5ri4rVd8V3ZufzyCzKnk=
X-Received: by 2002:aca:488a:: with SMTP id v132mr844167oia.166.1586202147970;
 Mon, 06 Apr 2020 12:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200406163556.997001-1-omosnace@redhat.com>
In-Reply-To: <20200406163556.997001-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 6 Apr 2020 21:42:16 +0200
Message-ID: <CAFqZXNtV93fZ88iC4tddLai-vxteZvB-whAogjd6Ak7xBpZ-eQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: store role transitions in a hash table
To:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 6, 2020 at 6:35 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Currently, they are stored in a linked list, which adds significant
> overhead to security_transition_sid(). On Fedora, with 428 role
> transitions in policy, converting this list to a hash table cuts down
> its run time by about 50%. This was measured by running 'stress-ng -t 30
> --metrics-brief --msg 0' under perf with and without this patch.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 138 ++++++++++++++++++++++-----------
>  security/selinux/ss/policydb.h |   8 +-
>  security/selinux/ss/services.c |  21 +++--
>  3 files changed, 107 insertions(+), 60 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 70ecdc78efbd..4f0cfffd008d 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -352,6 +352,13 @@ static int range_tr_destroy(void *key, void *datum, void *p)
>         return 0;
>  }
>
> +static int role_tr_destroy(void *key, void *datum, void *p)
> +{
> +       kfree(key);
> +       kfree(datum);
> +       return 0;
> +}
> +
>  static void ocontext_destroy(struct ocontext *c, int i)
>  {
>         if (!c)
> @@ -458,6 +465,30 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
>         return v;
>  }
>
> +static u32 role_trans_hash(struct hashtab *h, const void *k)
> +{
> +       const struct role_trans_key *key = k;
> +
> +       return (key->role + (key->type << 3) + (key->tclass << 5)) &
> +               (h->size - 1);
> +}
> +
> +static int role_trans_cmp(struct hashtab *h, const void *k1, const void *k2)
> +{
> +       const struct role_trans_key *key1 = k1, *key2 = k2;
> +       int v;
> +
> +       v = key1->role - key2->role;
> +       if (v)
> +               return v;
> +
> +       v = key1->type - key2->type;
> +       if (v)
> +               return v;
> +
> +       return key1->tclass - key2->tclass;
> +}
> +
>  /*
>   * Initialize a policy database structure.
>   */
> @@ -728,7 +759,6 @@ void policydb_destroy(struct policydb *p)
>         struct genfs *g, *gtmp;
>         int i;
>         struct role_allow *ra, *lra = NULL;
> -       struct role_trans *tr, *ltr = NULL;
>
>         for (i = 0; i < SYM_NUM; i++) {
>                 cond_resched();
> @@ -775,12 +805,8 @@ void policydb_destroy(struct policydb *p)
>
>         cond_policydb_destroy(p);
>
> -       for (tr = p->role_tr; tr; tr = tr->next) {
> -               cond_resched();
> -               kfree(ltr);
> -               ltr = tr;
> -       }
> -       kfree(ltr);
> +       hashtab_map(p->role_tr, role_tr_destroy, NULL);
> +       hashtab_destroy(p->role_tr);
>
>         for (ra = p->role_allow; ra; ra = ra->next) {
>                 cond_resched();
> @@ -2251,7 +2277,8 @@ out:
>  int policydb_read(struct policydb *p, void *fp)
>  {
>         struct role_allow *ra, *lra;
> -       struct role_trans *tr, *ltr;
> +       struct role_trans_key *rtk = NULL;
> +       struct role_trans_datum *rtd = NULL;
>         int i, j, rc;
>         __le32 buf[4];
>         u32 len, nprim, nel;
> @@ -2416,39 +2443,50 @@ int policydb_read(struct policydb *p, void *fp)
>         if (rc)
>                 goto bad;
>         nel = le32_to_cpu(buf[0]);
> -       ltr = NULL;
> +
> +       p->role_tr = hashtab_create(role_trans_hash, role_trans_cmp, nel);
> +       if (!p->role_tr)
> +               goto bad;
>         for (i = 0; i < nel; i++) {
>                 rc = -ENOMEM;
> -               tr = kzalloc(sizeof(*tr), GFP_KERNEL);
> -               if (!tr)
> +               rtk = kmalloc(sizeof(*rtk), GFP_KERNEL);
> +               if (!rtk)
>                         goto bad;
> -               if (ltr)
> -                       ltr->next = tr;
> -               else
> -                       p->role_tr = tr;
> +
> +               rc = -ENOMEM;
> +               rtd = kmalloc(sizeof(*rtd), GFP_KERNEL);
> +               if (!rtd)
> +                       goto bad;
> +
>                 rc = next_entry(buf, fp, sizeof(u32)*3);
>                 if (rc)
>                         goto bad;
>
>                 rc = -EINVAL;
> -               tr->role = le32_to_cpu(buf[0]);
> -               tr->type = le32_to_cpu(buf[1]);
> -               tr->new_role = le32_to_cpu(buf[2]);
> +               rtk->role = le32_to_cpu(buf[0]);
> +               rtk->type = le32_to_cpu(buf[1]);
> +               rtd->new_role = le32_to_cpu(buf[2]);
>                 if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
>                         rc = next_entry(buf, fp, sizeof(u32));
>                         if (rc)
>                                 goto bad;
> -                       tr->tclass = le32_to_cpu(buf[0]);
> +                       rtk->tclass = le32_to_cpu(buf[0]);
>                 } else
> -                       tr->tclass = p->process_class;
> +                       rtk->tclass = p->process_class;
>
>                 rc = -EINVAL;
> -               if (!policydb_role_isvalid(p, tr->role) ||
> -                   !policydb_type_isvalid(p, tr->type) ||
> -                   !policydb_class_isvalid(p, tr->tclass) ||
> -                   !policydb_role_isvalid(p, tr->new_role))
> +               if (!policydb_role_isvalid(p, rtk->role) ||
> +                   !policydb_type_isvalid(p, rtk->type) ||
> +                   !policydb_class_isvalid(p, rtk->tclass) ||
> +                   !policydb_role_isvalid(p, rtd->new_role))
> +                       goto bad;
> +
> +               rc = hashtab_insert(p->role_tr, rtk, rtd);
> +               if (rc)
>                         goto bad;
> -               ltr = tr;
> +
> +               rtk = NULL;
> +               rtd = NULL;
>         }
>
>         rc = next_entry(buf, fp, sizeof(u32));
> @@ -2536,6 +2574,8 @@ int policydb_read(struct policydb *p, void *fp)
>  out:
>         return rc;
>  bad:
> +       kfree(rtk);
> +       kfree(rtd);
>         policydb_destroy(p);
>         goto out;
>  }
> @@ -2653,39 +2693,45 @@ static int cat_write(void *vkey, void *datum, void *ptr)
>         return 0;
>  }
>
> -static int role_trans_write(struct policydb *p, void *fp)
> +static int role_trans_write_one(void *key, void *datum, void *ptr)
>  {
> -       struct role_trans *r = p->role_tr;
> -       struct role_trans *tr;
> +       struct role_trans_key *rtk = key;
> +       struct role_trans_datum *rtd = datum;
> +       struct policy_data *pd = ptr;
> +       void *fp = pd->fp;
> +       struct policydb *p = pd->p;
>         __le32 buf[3];
> -       size_t nel;
>         int rc;
>
> -       nel = 0;
> -       for (tr = r; tr; tr = tr->next)
> -               nel++;
> -       buf[0] = cpu_to_le32(nel);
> -       rc = put_entry(buf, sizeof(u32), 1, fp);
> +       buf[0] = cpu_to_le32(rtk->role);
> +       buf[1] = cpu_to_le32(rtk->type);
> +       buf[2] = cpu_to_le32(rtd->new_role);
> +       rc = put_entry(buf, sizeof(u32), 3, fp);
>         if (rc)
>                 return rc;
> -       for (tr = r; tr; tr = tr->next) {
> -               buf[0] = cpu_to_le32(tr->role);
> -               buf[1] = cpu_to_le32(tr->type);
> -               buf[2] = cpu_to_le32(tr->new_role);
> -               rc = put_entry(buf, sizeof(u32), 3, fp);
> +       if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
> +               buf[0] = cpu_to_le32(rtk->tclass);
> +               rc = put_entry(buf, sizeof(u32), 1, fp);
>                 if (rc)
>                         return rc;
> -               if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
> -                       buf[0] = cpu_to_le32(tr->tclass);
> -                       rc = put_entry(buf, sizeof(u32), 1, fp);
> -                       if (rc)
> -                               return rc;
> -               }
>         }
> -
>         return 0;
>  }
>
> +static int role_trans_write(struct policydb *p, void *fp)
> +{
> +       struct policy_data pd = { .p = p, .fp = fp };
> +       __le32 buf[1];
> +       int rc;
> +
> +       buf[0] = cpu_to_le32(p->role_tr->nel);
> +       rc = put_entry(buf, sizeof(u32), 1, fp);
> +       if (rc)
> +               return rc;
> +
> +       return hashtab_map(p->role_tr, role_trans_write_one, &pd);
> +}
> +
>  static int role_allow_write(struct role_allow *r, void *fp)
>  {
>         struct role_allow *ra;
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index 72e2932fb12d..d3adb522d3f3 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -81,12 +81,14 @@ struct role_datum {
>         struct ebitmap types;           /* set of authorized types for role */
>  };
>
> -struct role_trans {
> +struct role_trans_key {
>         u32 role;               /* current role */
>         u32 type;               /* program executable type, or new object type */
>         u32 tclass;             /* process class, or new object class */
> +};
> +
> +struct role_trans_datum {
>         u32 new_role;           /* new role */
> -       struct role_trans *next;
>  };
>
>  struct filename_trans_key {
> @@ -261,7 +263,7 @@ struct policydb {
>         struct avtab te_avtab;
>
>         /* role transitions */
> -       struct role_trans *role_tr;
> +       struct hashtab *role_tr;
>
>         /* file transitions with the last path component */
>         /* quickly exclude lookups when parent ttype has no rules */
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 8ad34fd031d1..3cb8ec7b09a3 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1731,7 +1731,6 @@ static int security_compute_sid(struct selinux_state *state,
>         struct class_datum *cladatum = NULL;
>         struct context *scontext, *tcontext, newcontext;
>         struct sidtab_entry *sentry, *tentry;
> -       struct role_trans *roletr = NULL;
>         struct avtab_key avkey;
>         struct avtab_datum *avdatum;
>         struct avtab_node *node;
> @@ -1864,16 +1863,16 @@ static int security_compute_sid(struct selinux_state *state,
>         /* Check for class-specific changes. */
>         if (specified & AVTAB_TRANSITION) {
>                 /* Look for a role transition rule. */
> -               for (roletr = policydb->role_tr; roletr;
> -                    roletr = roletr->next) {
> -                       if ((roletr->role == scontext->role) &&
> -                           (roletr->type == tcontext->type) &&
> -                           (roletr->tclass == tclass)) {
> -                               /* Use the role transition rule. */
> -                               newcontext.role = roletr->new_role;
> -                               break;
> -                       }
> -               }
> +               struct role_trans_datum *rtd;
> +               struct role_trans_key rtk = {
> +                       .role = scontext->role,
> +                       .type = scontext->type,

I just spotted a copy-paste bug here - the type should come from
tcontext, not scontext... Will send a fixed version tomorrow.

> +                       .tclass = tclass,
> +               };
> +
> +               rtd = hashtab_search(policydb->role_tr, &rtk);
> +               if (rtd)
> +                       newcontext.role = rtd->new_role;
>         }
>
>         /* Set the MLS attributes.
> --
> 2.25.1
>


-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

