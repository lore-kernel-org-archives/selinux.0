Return-Path: <SRS0=ncaB=5Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4153BC43331
	for <selinux@archiver.kernel.org>; Tue, 31 Mar 2020 20:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF7F20757
	for <selinux@archiver.kernel.org>; Tue, 31 Mar 2020 20:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQCQlsfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgCaU3C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:29:02 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34142 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaU3C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 31 Mar 2020 16:29:02 -0400
Received: by mail-ot1-f66.google.com with SMTP id m2so8788421otr.1
        for <selinux@vger.kernel.org>; Tue, 31 Mar 2020 13:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJ0eT17Fwd3SgC4VDfOAyDGsD/s7NQaEYryhImax4RQ=;
        b=TQCQlsfpAV3OwteD6YbUpsrKE3FKD24BkJbT1pD6PI0UNW7TMI6acf6ZNvRdBhfphq
         6C2KNXA7GSxae0R7yy7KEh3iOIN3fZKRAV8GEv4mVFImGV3AhZYh4y+988juxdGx4J/2
         /a6KJuYHCu31dlMr0yJTKRb7XXHKHcSVT8b2Vp1AYroUWFQvCzCgObdCRGOBBL88X/ZH
         /yhaeMsec+0uOl5zRPADFFtQxWu4L8yKO7FE0bZp4DqkNFGP2dkXmT6z+ZLjBHbf5ls7
         Ix1UiyKmRkFs9lAv1o8xoZFhAgLua2RpG7B1uepiIzRamKI31twAE+roBb3spt7ZNMIC
         q4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJ0eT17Fwd3SgC4VDfOAyDGsD/s7NQaEYryhImax4RQ=;
        b=XgL1BOLnSdEDEsesPlzemLJctpJXaV/uuutiKHSz2etTJBxj1ANB3fc0uL4jJjp2+K
         VIjQixQSqcwhBJlAVdVfMi/KJ2k9U9MI9RYKZ2PAnntjfxewYMaGB8iR4p+Ki/476Ymv
         5P65CJ7pnVwAzFEkJLLuU61GD2LBdeDEPOs4ttW2d+crpAibyjHMMa/tZI4+miW1JtF6
         XQTKbChA6q2m6Q+hw2tGyUU9CEdJcDGgdgFP9yEnHzinTRAgyN62IKWGwpq+hhMJCHML
         ivkz8D7v+h9va450OmGtSqa+Xub68CvFLFEsDVn3j7PK7ReRRwh8bONNL0pQuPslhPJH
         h9ZQ==
X-Gm-Message-State: ANhLgQ0p02fKY/g7gkVl+t50GnvrqzVbs9/6RT2FkX2krLEtSfaCX9gG
        y6XWf/4/08T3qrAk0hN3Liuah8OE2WhSLAVGxsWw4i3M
X-Google-Smtp-Source: ADFU+vtv82JK1Yd8RuBc77NRuCj7ha4+RTOhLKTTbvawXNXDjmCCQqAzqjD8/dzWa59EvnQ7g1FNEbJoqaKRNE6bUhw=
X-Received: by 2002:a05:6830:2147:: with SMTP id r7mr14088497otd.59.1585686539820;
 Tue, 31 Mar 2020 13:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200328124550.199568-1-omosnace@redhat.com> <20200328124550.199568-3-omosnace@redhat.com>
In-Reply-To: <20200328124550.199568-3-omosnace@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 31 Mar 2020 16:30:44 -0400
Message-ID: <CAP+JOzTu=ziLHGgFfu6Do_yXV3eWQDA2hUEenYHP3StT64R=Bg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libsepol: implement POLICYDB_VERSION_COMP_FTRANS
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Chris PeBenito <pebenito@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Mar 28, 2020 at 8:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Implement a new, more space-efficient form of storing filename
> transitions in the binary policy. The internal structures have already
> been converted to this new representation; this patch just implements
> reading/writing an equivalent representation from/to the binary policy.
>
> This new format reduces the size of Fedora policy from 7.6 MB to only
> 3.3 MB (with policy optimization enabled in both cases). With the
> unconfined module disabled, the size is reduced from 3.3 MB to 2.4 MB.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/include/sepol/policydb/policydb.h |   3 +-
>  libsepol/src/policydb.c                    | 218 +++++++++++++++++----
>  libsepol/src/write.c                       |  72 ++++++-
>  3 files changed, 242 insertions(+), 51 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
> index c3180c61..9ef43abc 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -755,10 +755,11 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
>  #define POLICYDB_VERSION_XPERMS_IOCTL  30 /* Linux-specific */
>  #define POLICYDB_VERSION_INFINIBAND            31 /* Linux-specific */
>  #define POLICYDB_VERSION_GLBLUB                32
> +#define POLICYDB_VERSION_COMP_FTRANS   33 /* compressed filename transitions */
>
>  /* Range of policy versions we understand*/
>  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> -#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_GLBLUB
> +#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_COMP_FTRANS
>
>  /* Module versions and specific changes*/
>  #define MOD_POLICYDB_VERSION_BASE              4
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 6b121d66..18ce1912 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -200,6 +200,13 @@ static struct policydb_compat_info policydb_compat[] = {
>          .ocon_num = OCON_IBENDPORT + 1,
>          .target_platform = SEPOL_TARGET_SELINUX,
>         },
> +       {
> +        .type = POLICY_KERN,
> +        .version = POLICYDB_VERSION_COMP_FTRANS,
> +        .sym_num = SYM_NUM,
> +        .ocon_num = OCON_IBENDPORT + 1,
> +        .target_platform = SEPOL_TARGET_SELINUX,
> +       },
>         {
>          .type = POLICY_BASE,
>          .version = MOD_POLICYDB_VERSION_BASE,
> @@ -2661,73 +2668,202 @@ int policydb_filetrans_insert(policydb_t *p, uint32_t stype, uint32_t ttype,
>         return ebitmap_set_bit(&datum->stypes, stype - 1, 1);
>  }
>
> -int filename_trans_read(policydb_t *p, struct policy_file *fp)
> +static int filename_trans_read_one_old(policydb_t *p, struct policy_file *fp)
>  {
> -       unsigned int i;
> -       uint32_t buf[4], nel, len, stype, ttype, tclass, otype;
> +       uint32_t buf[4], len, stype, ttype, tclass, otype;
> +       char *name = NULL;
>         int rc;
> -       char *name;
>
>         rc = next_entry(buf, fp, sizeof(uint32_t));
>         if (rc < 0)
>                 return -1;
> -       nel = le32_to_cpu(buf[0]);
> +       len = le32_to_cpu(buf[0]);
> +       if (zero_or_saturated(len))
> +               return -1;
>
> -       for (i = 0; i < nel; i++) {
> -               name = NULL;
> +       name = calloc(len + 1, sizeof(*name));
> +       if (!name)
> +               return -1;
>
> -               rc = next_entry(buf, fp, sizeof(uint32_t));
> -               if (rc < 0)
> -                       goto err;
> -               len = le32_to_cpu(buf[0]);
> -               if (zero_or_saturated(len))
> +       rc = next_entry(name, fp, len);
> +       if (rc < 0)
> +               goto err;
> +
> +       rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
> +       if (rc < 0)
> +               goto err;
> +
> +       stype  = le32_to_cpu(buf[0]);
> +       ttype  = le32_to_cpu(buf[1]);
> +       tclass = le32_to_cpu(buf[2]);
> +       otype  = le32_to_cpu(buf[3]);
> +
> +       rc = policydb_filetrans_insert(p, stype, ttype, tclass, name, &name,
> +                                      otype, NULL);
> +       if (rc) {
> +               if (rc != SEPOL_EEXIST)
>                         goto err;
> +               /*
> +                * Some old policies were wrongly generated with
> +                * duplicate filename transition rules.  For backward
> +                * compatibility, do not reject such policies, just
> +                * issue a warning and ignore the duplicate.
> +                */
> +               WARN(fp->handle,
> +                    "Duplicate name-based type_transition %s %s:%s \"%s\":  %s, ignoring",
> +                    p->p_type_val_to_name[stype - 1],
> +                    p->p_type_val_to_name[ttype - 1],
> +                    p->p_class_val_to_name[tclass - 1],
> +                    name,
> +                    p->p_type_val_to_name[otype - 1]);
> +               /* continue, ignoring this one */
> +       }
> +       free(name);
> +       return 0;
> +err:
> +       free(name);
> +       return -1;
> +}
> +
> +static int filename_trans_check_datum(filename_trans_datum_t *datum)
> +{
> +       ebitmap_t stypes, otypes;
> +
> +       ebitmap_init(&stypes);
> +       ebitmap_init(&otypes);
> +
> +       while (datum) {
> +               if (ebitmap_get_bit(&otypes, datum->otype))
> +                       return -1;
> +
> +               if (ebitmap_set_bit(&otypes, datum->otype, 1))
> +                       return -1;
>
> -               name = calloc(len + 1, sizeof(*name));
> -               if (!name)
> +               if (ebitmap_match_any(&stypes, &datum->stypes))
> +                       return -1;
> +
> +               if (ebitmap_union(&stypes, &datum->stypes))
> +                       return -1;
> +       }
> +       return 0;
> +}
> +
> +static int filename_trans_read_one_new(policydb_t *p, struct policy_file *fp)
> +{
> +       filename_trans_key_t *ft = NULL;
> +       filename_trans_datum_t **dst, *datum, *first = NULL;
> +       unsigned int i;
> +       uint32_t buf[3], len, ttype, tclass, ndatum;
> +       char *name = NULL;
> +       int rc;
> +
> +       rc = next_entry(buf, fp, sizeof(uint32_t));
> +       if (rc < 0)
> +               return -1;
> +       len = le32_to_cpu(buf[0]);
> +       if (zero_or_saturated(len))
> +               return -1;
> +
> +       name = calloc(len + 1, sizeof(*name));
> +       if (!name)
> +               return -1;
> +
> +       rc = next_entry(name, fp, len);
> +       if (rc < 0)
> +               goto err;
> +
> +       rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
> +       if (rc < 0)
> +               goto err;
> +
> +       ttype = le32_to_cpu(buf[0]);
> +       tclass = le32_to_cpu(buf[1]);
> +       ndatum = le32_to_cpu(buf[2]);
> +       if (ndatum == 0)
> +               goto err;
> +
> +       dst = &first;
> +       for (i = 0; i < ndatum; i++) {
> +               datum = malloc(sizeof(*datum));
> +               if (!datum)
>                         goto err;
>
> -               rc = next_entry(name, fp, len);
> +               *dst = datum;
> +
> +               /* ebitmap_read() will at least init the bitmap */
> +               rc = ebitmap_read(&datum->stypes, fp);
>                 if (rc < 0)
>                         goto err;
>
> -               rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
> +               rc = next_entry(buf, fp, sizeof(uint32_t));
>                 if (rc < 0)
>                         goto err;
>
> -               stype  = le32_to_cpu(buf[0]);
> -               ttype  = le32_to_cpu(buf[1]);
> -               tclass = le32_to_cpu(buf[2]);
> -               otype  = le32_to_cpu(buf[3]);
> +               datum->otype = le32_to_cpu(buf[0]);
>
> -               rc = policydb_filetrans_insert(p, stype, ttype, tclass, name,
> -                                              &name, otype, NULL);
> -               if (rc) {
> -                       if (rc != SEPOL_EEXIST)
> -                               goto err;
> -                       /*
> -                        * Some old policies were wrongly generated with
> -                        * duplicate filename transition rules.  For backward
> -                        * compatibility, do not reject such policies, just
> -                        * issue a warning and ignore the duplicate.
> -                        */
> -                       WARN(fp->handle,
> -                            "Duplicate name-based type_transition %s %s:%s \"%s\":  %s, ignoring",
> -                            p->p_type_val_to_name[stype - 1],
> -                            p->p_type_val_to_name[ttype - 1],
> -                            p->p_class_val_to_name[tclass - 1],
> -                            name,
> -                            p->p_type_val_to_name[otype - 1]);
> -                       /* continue, ignoring this one */
> -               }
> -               free(name);
> +               p->filename_trans_count += ebitmap_cardinality(&datum->stypes);
> +
> +               dst = &datum->next;
>         }
> +       *dst = NULL;
> +
> +       if (ndatum > 1 && filename_trans_check_datum(first))
> +               goto err;
> +
> +       ft = malloc(sizeof(*ft));
> +       if (!ft)
> +               goto err;
> +
> +       ft->ttype = ttype;
> +       ft->tclass = tclass;
> +       ft->name = name;
> +
> +       rc = hashtab_insert(p->filename_trans, (hashtab_key_t)ft,
> +                           (hashtab_datum_t)first);
> +       if (rc)
> +               goto err;
> +
>         return 0;
>  err:
> +       free(ft);
>         free(name);
> +       while (first) {
> +               datum = first;
> +               first = first->next;
> +
> +               ebitmap_destroy(&datum->stypes);
> +               free(datum);
> +       }
>         return -1;
>  }
>
> +int filename_trans_read(policydb_t *p, struct policy_file *fp)
> +{
> +       unsigned int i;
> +       uint32_t buf[1], nel;
> +       int rc;
> +
> +       rc = next_entry(buf, fp, sizeof(uint32_t));
> +       if (rc < 0)
> +               return -1;
> +       nel = le32_to_cpu(buf[0]);
> +
> +       if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
> +               for (i = 0; i < nel; i++) {
> +                       rc = filename_trans_read_one_old(p, fp);
> +                       if (rc < 0)
> +                               return -1;
> +               }
> +       } else {
> +               for (i = 0; i < nel; i++) {
> +                       rc = filename_trans_read_one_new(p, fp);
> +                       if (rc < 0)
> +                               return -1;
> +               }
> +       }
> +       return 0;
> +}
> +
>  static int ocontext_read_xen(struct policydb_compat_info *info,
>         policydb_t *p, struct policy_file *fp)
>  {
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index d3aee8d5..9c74d9f5 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -569,7 +569,7 @@ static int role_allow_write(role_allow_t * r, struct policy_file *fp)
>         return POLICYDB_SUCCESS;
>  }
>
> -static int filename_write_helper(hashtab_key_t key, void *data, void *ptr)
> +static int filename_write_one_old(hashtab_key_t key, void *data, void *ptr)
>  {
>         uint32_t bit, buf[4];
>         size_t items, len;
> @@ -605,6 +605,54 @@ static int filename_write_helper(hashtab_key_t key, void *data, void *ptr)
>         return 0;
>  }
>
> +static int filename_write_one_new(hashtab_key_t key, void *data, void *ptr)
> +{
> +       uint32_t buf[3];
> +       size_t items, len, ndatum;
> +       filename_trans_key_t *ft = (filename_trans_key_t *)key;
> +       filename_trans_datum_t *datum;
> +       void *fp = ptr;
> +
> +       len = strlen(ft->name);
> +       buf[0] = cpu_to_le32(len);
> +       items = put_entry(buf, sizeof(uint32_t), 1, fp);
> +       if (items != 1)
> +               return POLICYDB_ERROR;
> +
> +       items = put_entry(ft->name, sizeof(char), len, fp);
> +       if (items != len)
> +               return POLICYDB_ERROR;
> +
> +       ndatum = 0;
> +       datum = data;
> +       do {
> +               ndatum++;
> +               datum = datum->next;
> +       } while (datum);
> +
> +       buf[0] = cpu_to_le32(ft->ttype);
> +       buf[1] = cpu_to_le32(ft->tclass);
> +       buf[2] = cpu_to_le32(ndatum);
> +       items = put_entry(buf, sizeof(uint32_t), 3, fp);
> +       if (items != 3)
> +               return POLICYDB_ERROR;
> +
> +       datum = data;
> +       do {
> +               if (ebitmap_write(&datum->stypes, fp))
> +                       return POLICYDB_ERROR;
> +
> +               buf[0] = cpu_to_le32(datum->otype);
> +               items = put_entry(buf, sizeof(uint32_t), 1, fp);
> +               if (items != 1)
> +                       return POLICYDB_ERROR;
> +
> +               datum = datum->next;
> +       } while (datum);
> +
> +       return 0;
> +}
> +
>  static int filename_trans_write(struct policydb *p, void *fp)
>  {
>         size_t items;
> @@ -614,16 +662,22 @@ static int filename_trans_write(struct policydb *p, void *fp)
>         if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
>                 return 0;
>
> -       buf[0] = cpu_to_le32(p->filename_trans_count);
> -       items = put_entry(buf, sizeof(uint32_t), 1, fp);
> -       if (items != 1)
> -               return POLICYDB_ERROR;
> +       if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
> +               buf[0] = cpu_to_le32(p->filename_trans_count);
> +               items = put_entry(buf, sizeof(uint32_t), 1, fp);
> +               if (items != 1)
> +                       return POLICYDB_ERROR;
>
> -       rc = hashtab_map(p->filename_trans, filename_write_helper, fp);
> -       if (rc)
> -               return rc;
> +               rc = hashtab_map(p->filename_trans, filename_write_one_old, fp);
> +       } else {
> +               buf[0] = cpu_to_le32(p->filename_trans->nel);
> +               items = put_entry(buf, sizeof(uint32_t), 1, fp);
> +               if (items != 1)
> +                       return POLICYDB_ERROR;
>
> -       return 0;
> +               rc = hashtab_map(p->filename_trans, filename_write_one_new, fp);
> +       }
> +       return rc;
>  }
>
>  static int role_set_write(role_set_t * x, struct policy_file *fp)
> --
> 2.25.1
>
