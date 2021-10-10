Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9157C433EF
	for <selinux@archiver.kernel.org>; Sun, 10 Oct 2021 20:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E1F60ED7
	for <selinux@archiver.kernel.org>; Sun, 10 Oct 2021 20:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhJJUmp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 10 Oct 2021 16:42:45 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:57384 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhJJUmp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 10 Oct 2021 16:42:45 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 0DDA95605B3
        for <selinux@vger.kernel.org>; Sun, 10 Oct 2021 22:40:44 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so13177683pjb.1
        for <selinux@vger.kernel.org>; Sun, 10 Oct 2021 13:40:43 -0700 (PDT)
X-Gm-Message-State: AOAM530ki2x8ZJrzfZNeylcDhca/DAajabFWO7HsruJ/mbCH2CdD8ZaU
        PKwXPvzR2Ufm8WdB4rIfl8ViCsjZh5Zl+HjxSN0=
X-Google-Smtp-Source: ABdhPJwomiHul3vS9qQjutetzyDoa3kM4m/N/pltzY6sfgzMbwuKAmm+sxkQv3iDj5/lJzXSK44VpYtFsX8RWi8TdGM=
X-Received: by 2002:a17:90a:ba09:: with SMTP id s9mr26243260pjr.42.1633898442568;
 Sun, 10 Oct 2021 13:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211008211031.393884-1-jwcart2@gmail.com> <20211008211031.393884-2-jwcart2@gmail.com>
In-Reply-To: <20211008211031.393884-2-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 10 Oct 2021 22:40:31 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==x_JoFDf+XYz8jjMESzS609L0XomuaXM=3i3e_iEcuNw@mail.gmail.com>
Message-ID: <CAJfZ7==x_JoFDf+XYz8jjMESzS609L0XomuaXM=3i3e_iEcuNw@mail.gmail.com>
Subject: Re: [PATCH 2/4] libsepol/cil: Fix potential undefined shifts
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Oct 10 22:40:44 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 8, 2021 at 11:10 PM James Carter <jwcart2@gmail.com> wrote:
>
> An expression of the form "1 << x" is undefined if x == 31 because
> the "1" is an int and cannot be left shifted by 31.
>
> Instead, use "UINT32_C(1) << x" which will be an unsigned int of
> at least 32 bits.
>
> This bug was found by the secilc-fuzzer.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_binary.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index ec5f01e5..34dc63c7 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -1225,7 +1225,7 @@ int __perm_str_to_datum(char *perm_str, class_datum_t *sepol_class, uint32_t *da
>                         goto exit;
>                 }
>         }
> -       *datum |= 1 << (sepol_perm->s.value - 1);
> +       *datum |= UINT32_C(1) << (sepol_perm->s.value - 1);
>
>         return SEPOL_OK;
>
> @@ -1523,7 +1523,7 @@ int cil_avrule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_
>  /* index of the u32 containing the permission */
>  #define XPERM_IDX(x) (x >> 5)
>  /* set bits 0 through x-1 within the u32 */
> -#define XPERM_SETBITS(x) ((1U << (x & 0x1f)) - 1)
> +#define XPERM_SETBITS(x) (UINT32_C(1) << (x & 0x1f)) - 1)

There is a missing parenthesis here: "UINT32_C(1)" -> "(UINT32_C(1)"

Other than this, the 4 patches look good to me:

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

>  /* low value for this u32 */
>  #define XPERM_LOW(x) (x << 5)
>  /* high value for this u32 */
> @@ -4760,7 +4760,7 @@ static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint16_t clas
>         cil_list_init(&cp->perms, CIL_PERM);
>         for (i = 0; i < sepol_class->permissions.nprim; i++) {
>                 struct cil_perm *perm;
> -               if ((data & (1 << i)) == 0) continue;
> +               if ((data & (UINT32_C(1) << i)) == 0) continue;
>                 perm = perm_value_to_cil[class][i+1];
>                 if (!perm) goto exit;
>                 cil_list_append(cp->perms, CIL_PERM, perm);
> --
> 2.31.1
>

