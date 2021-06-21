Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA598C4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 21:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977CD6124B
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 21:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhFUVCS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFUVCS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 17:02:18 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D879C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 14:00:03 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t40so21377824oiw.8
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8ygumLkiB15m/6JDCu22gwVGnF4P4WbFIq0Pxo4mANY=;
        b=LdtE1JLTD6hEbztXav2kBsp5zOaobeNX+SqnuiTAXAEbq9z70HxmX9TbMgvwmYHQ5v
         p1ZfMaZWIWVLznmc2TDQZILG+rAdWxiOe+WzqK5BBbKKv8Zk5s9w0uKEU8yYRceFjn3u
         PzM+dXqngQ+Pes3dce8CDuMBorNiUNoNSWXk38XY/9MRjcMD6z/75e5NIfDMvHGtpxcI
         eqmobozt4/cfsfsT+tr54gegtIr92QCDQ4zuCfmt/BliLJbIPa/YB9r9hX8cjy+5lj6m
         yZc2SvuCdc0gU47UdzO6UE67J0ZsonnswagSmAs5+vpwKrqrB2cHvWVa06z+gV1fS+VD
         N0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8ygumLkiB15m/6JDCu22gwVGnF4P4WbFIq0Pxo4mANY=;
        b=s2n9+1roBQ1+3Mt18szb4bLN0C3VE9+kZu1VSAjhZdMG8rdobUE6h9b5WTMY5RBsOq
         12JMBeEF6oM21JnSqLMfOVjfegLy8m2t3fbMmfPHvUfvQsXJ0etseH3/0M9pYip3Uo9B
         gB4H3eJIvYV0IHNc7MYauUtsFVSqLEl9jFOGEcgRjol65Sz5yU6/SjEu00snvVLvHD8q
         edqCjPbj98FiFmWI2bHJTIuYw4mC/gRu7/6bUzLLEtf7rS6hJpTRxefzK6KdlCNOPRD+
         5RbsAbo4H257p1MZDpo9mHJuD2c4CwgMqHOGVw6ptc+kn/TUAtmeN7+uenM8oVj4J+wb
         xnXw==
X-Gm-Message-State: AOAM530taa4US9s5t+PvZI2mwJ4ODh9AZjt2jdOkhZ6Rd1vQrIoeLeye
        /YwLmKJ8Ks/ihNtoVQP3AFiUrJ0KNveTLupW1cBujOHrM765Mg==
X-Google-Smtp-Source: ABdhPJx/mH04MbNtShsv0u60JSPxiVMjEEhCytu43KuLkf4kv9SxJPjarb5ClVJo+f6kkQL1wQJFDiy3/9MFFtgXMWA=
X-Received: by 2002:aca:1c0d:: with SMTP id c13mr298308oic.128.1624309202747;
 Mon, 21 Jun 2021 14:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-24-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-24-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:59:52 -0400
Message-ID: <CAP+JOzSedNqMkBqXauY4DdvoCT_V_aUGBoZzdnrVcytFkXGr3Q@mail.gmail.com>
Subject: Re: [PATCH 23/23] libsepol: declare read-only arrays const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:02 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Make it more apparent that those data does not change and enforce it.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/avrule_block.c      |  2 +-
>  libsepol/src/avtab.c             |  2 +-
>  libsepol/src/link.c              |  2 +-
>  libsepol/src/polcaps.c           |  2 +-
>  libsepol/src/policydb.c          | 22 +++++++++++-----------
>  libsepol/src/policydb_internal.h |  2 +-
>  libsepol/src/private.h           |  6 +++---
>  libsepol/src/write.c             |  8 ++++----
>  8 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
> index a9832d0d..dcfce8b8 100644
> --- a/libsepol/src/avrule_block.c
> +++ b/libsepol/src/avrule_block.c
> @@ -30,7 +30,7 @@
>  /* It is anticipated that there be less declarations within an avrule
>   * block than the global policy.  Thus the symbol table sizes are
>   * smaller than those listed in policydb.c */
> -static unsigned int symtab_sizes[SYM_NUM] =3D {
> +static const unsigned int symtab_sizes[SYM_NUM] =3D {
>         2,
>         4,
>         8,
> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index c2ccb005..7b80377c 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -424,7 +424,7 @@ void avtab_hash_eval(avtab_t * h, char *tag)
>  }
>
>  /* Ordering of datums in the original avtab format in the policy file. *=
/
> -static uint16_t spec_order[] =3D {
> +static const uint16_t spec_order[] =3D {
>         AVTAB_ALLOWED,
>         AVTAB_AUDITDENY,
>         AVTAB_AUDITALLOW,
> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> index bdc1fcbf..461d2feb 100644
> --- a/libsepol/src/link.c
> +++ b/libsepol/src/link.c
> @@ -78,7 +78,7 @@ typedef struct missing_requirement {
>         uint32_t perm_value;
>  } missing_requirement_t;
>
> -static const char *symtab_names[SYM_NUM] =3D {
> +static const char * const symtab_names[SYM_NUM] =3D {
>         "common", "class", "role", "type/attribute", "user",
>         "bool", "level", "category"
>  };
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index 67ed5786..6a74ec7d 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -5,7 +5,7 @@
>  #include <string.h>
>  #include <sepol/policydb/polcaps.h>
>
> -static const char *polcap_names[] =3D {
> +static const char * const polcap_names[] =3D {
>         "network_peer_controls",        /* POLICYDB_CAPABILITY_NETPEER */
>         "open_perms",                   /* POLICYDB_CAPABILITY_OPENPERM *=
/
>         "extended_socket_class",        /* POLICYDB_CAPABILITY_EXTSOCKCLA=
SS */
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 7739b0fb..0bc0ead8 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -57,10 +57,10 @@
>  #include "policydb_validate.h"
>
>  #define POLICYDB_TARGET_SZ   ARRAY_SIZE(policydb_target_strings)
> -const char *policydb_target_strings[] =3D { POLICYDB_STRING, POLICYDB_XE=
N_STRING };
> +const char * const policydb_target_strings[] =3D { POLICYDB_STRING, POLI=
CYDB_XEN_STRING };
>
>  /* These need to be updated if SYM_NUM or OCON_NUM changes */
> -static struct policydb_compat_info policydb_compat[] =3D {
> +static const struct policydb_compat_info policydb_compat[] =3D {
>         {
>          .type =3D POLICY_KERN,
>          .version =3D POLICYDB_VERSION_BOUNDARY,
> @@ -460,7 +460,7 @@ static char *symtab_name[SYM_NUM] =3D {
>  };
>  #endif
>
> -static unsigned int symtab_sizes[SYM_NUM] =3D {
> +static const unsigned int symtab_sizes[SYM_NUM] =3D {
>         2,
>         32,
>         16,
> @@ -471,12 +471,12 @@ static unsigned int symtab_sizes[SYM_NUM] =3D {
>         16,
>  };
>
> -struct policydb_compat_info *policydb_lookup_compat(unsigned int version=
,
> -                                                   unsigned int type,
> -                                               unsigned int target_platf=
orm)
> +const struct policydb_compat_info *policydb_lookup_compat(unsigned int v=
ersion,
> +                                                         unsigned int ty=
pe,
> +                                                         unsigned int ta=
rget_platform)
>  {
>         unsigned int i;
> -       struct policydb_compat_info *info =3D NULL;
> +       const struct policydb_compat_info *info =3D NULL;
>
>         for (i =3D 0; i < sizeof(policydb_compat) / sizeof(*info); i++) {
>                 if (policydb_compat[i].version =3D=3D version &&
> @@ -2854,7 +2854,7 @@ static int filename_trans_read(policydb_t *p, struc=
t policy_file *fp)
>         return 0;
>  }
>
> -static int ocontext_read_xen(struct policydb_compat_info *info,
> +static int ocontext_read_xen(const struct policydb_compat_info *info,
>         policydb_t *p, struct policy_file *fp)
>  {
>         unsigned int i, j;
> @@ -2963,7 +2963,7 @@ static int ocontext_read_xen(struct policydb_compat=
_info *info,
>         }
>         return 0;
>  }
> -static int ocontext_read_selinux(struct policydb_compat_info *info,
> +static int ocontext_read_selinux(const struct policydb_compat_info *info=
,
>                          policydb_t * p, struct policy_file *fp)
>  {
>         unsigned int i, j;
> @@ -3141,7 +3141,7 @@ static int ocontext_read_selinux(struct policydb_co=
mpat_info *info,
>         return 0;
>  }
>
> -static int ocontext_read(struct policydb_compat_info *info,
> +static int ocontext_read(const struct policydb_compat_info *info,
>         policydb_t *p, struct policy_file *fp)
>  {
>         int rc =3D -1;
> @@ -4198,7 +4198,7 @@ int policydb_read(policydb_t * p, struct policy_fil=
e *fp, unsigned verbose)
>         uint32_t buf[5];
>         size_t len, nprim, nel;
>         char *policydb_str;
> -       struct policydb_compat_info *info;
> +       const struct policydb_compat_info *info;
>         unsigned int policy_type, bufindex;
>         ebitmap_node_t *tnode;
>         int rc;
> diff --git a/libsepol/src/policydb_internal.h b/libsepol/src/policydb_int=
ernal.h
> index 06ba5c8b..dd8f25d0 100644
> --- a/libsepol/src/policydb_internal.h
> +++ b/libsepol/src/policydb_internal.h
> @@ -3,5 +3,5 @@
>
>  #include <sepol/policydb.h>
>
> -extern const char *policydb_target_strings[];
> +extern const char * const policydb_target_strings[];
>  #endif
> diff --git a/libsepol/src/private.h b/libsepol/src/private.h
> index f5b5277f..72f21262 100644
> --- a/libsepol/src/private.h
> +++ b/libsepol/src/private.h
> @@ -56,9 +56,9 @@ struct policydb_compat_info {
>         unsigned int target_platform;
>  };
>
> -extern struct policydb_compat_info *policydb_lookup_compat(unsigned int =
version,
> -                                                          unsigned int t=
ype,
> -                                               unsigned int target_platf=
orm);
> +extern const struct policydb_compat_info *policydb_lookup_compat(unsigne=
d int version,
> +                                                                unsigned=
 int type,
> +                                                                unsigned=
 int target_platform);
>
>  /* Reading from a policy "file". */
>  extern int next_entry(void *buf, struct policy_file *fp, size_t bytes);
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index 84bcaf3f..3bd034d6 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -1345,7 +1345,7 @@ static int (*write_f[SYM_NUM]) (hashtab_key_t key, =
hashtab_datum_t datum,
>  common_write, class_write, role_write, type_write, user_write,
>             cond_write_bool, sens_write, cat_write,};
>
> -static int ocontext_write_xen(struct policydb_compat_info *info, policyd=
b_t *p,
> +static int ocontext_write_xen(const struct policydb_compat_info *info, p=
olicydb_t *p,
>                           struct policy_file *fp)
>  {
>         unsigned int i, j;
> @@ -1453,7 +1453,7 @@ static int ocontext_write_xen(struct policydb_compa=
t_info *info, policydb_t *p,
>         return POLICYDB_SUCCESS;
>  }
>
> -static int ocontext_write_selinux(struct policydb_compat_info *info,
> +static int ocontext_write_selinux(const struct policydb_compat_info *inf=
o,
>         policydb_t *p, struct policy_file *fp)
>  {
>         unsigned int i, j;
> @@ -1583,7 +1583,7 @@ static int ocontext_write_selinux(struct policydb_c=
ompat_info *info,
>         return POLICYDB_SUCCESS;
>  }
>
> -static int ocontext_write(struct policydb_compat_info *info, policydb_t =
* p,
> +static int ocontext_write(const struct policydb_compat_info *info, polic=
ydb_t * p,
>         struct policy_file *fp)
>  {
>         int rc =3D POLICYDB_ERROR;
> @@ -2179,7 +2179,7 @@ int policydb_write(policydb_t * p, struct policy_fi=
le *fp)
>         unsigned int i, num_syms;
>         uint32_t buf[32], config;
>         size_t items, items2, len;
> -       struct policydb_compat_info *info;
> +       const struct policydb_compat_info *info;
>         struct policy_data pd;
>         const char *policydb_str;
>
> --
> 2.32.0
>
