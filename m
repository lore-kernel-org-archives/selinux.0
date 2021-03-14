Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58654C433DB
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 19:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21BF264E64
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 19:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhCNTyh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 14 Mar 2021 15:54:37 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:55082 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCNTyN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 14 Mar 2021 15:54:13 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 522AD564C62
        for <selinux@vger.kernel.org>; Sun, 14 Mar 2021 20:54:05 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id q2-20020a17090a2e02b02900bee668844dso13214688pjd.3
        for <selinux@vger.kernel.org>; Sun, 14 Mar 2021 12:54:05 -0700 (PDT)
X-Gm-Message-State: AOAM532PB1Lc5rWzPEJchx3aEiDGaaxr+zjM8glXEkBa/LZ+J9MEVFlb
        IPaqFFDn9GvponWdEZwezqsGmNkhNaQ03uA6x5Q=
X-Google-Smtp-Source: ABdhPJxNcmATuKZxpeb5T54G5YdOObGXeAOwzCWtO4ajaKswwn05KxZGxhGRKudGXhFPC7UTCf7GfoFyz+X8tmPT13U=
X-Received: by 2002:a17:90a:4d81:: with SMTP id m1mr1194381pjh.143.1615751644069;
 Sun, 14 Mar 2021 12:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210311154105.195494-1-jwcart2@gmail.com> <20210311154105.195494-2-jwcart2@gmail.com>
In-Reply-To: <20210311154105.195494-2-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 14 Mar 2021 20:53:53 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=k3=1rRbq2us2z+fOtQD1==7MVG9RqprovXYn=NSWuJAA@mail.gmail.com>
Message-ID: <CAJfZ7=k3=1rRbq2us2z+fOtQD1==7MVG9RqprovXYn=NSWuJAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: Check kernel to CIL and Conf functions for
 supported versions
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar 14 20:54:05 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 11, 2021 at 4:41 PM James Carter <jwcart2@gmail.com> wrote:
>
> For policy versions between 20 and 23, attributes exist in the
> policy, but only in the type_attr_map. This means that there are
> gaps in both the type_val_to_struct and p_type_val_to_name arrays
> and policy rules can refer to those gaps which can lead to NULL
> dereferences when using sepol_kernel_policydb_to_conf() and
> sepol_kernel_policydb_to_cil().
>
> This can be seen with the following policy:
>   class CLASS1
>   sid SID1
>   class CLASS1 { PERM1 }
>   attribute TYPE_ATTR1;
>   type TYPE1;
>   typeattribute TYPE1 TYPE_ATTR1;
>   allow TYPE_ATTR1 self : CLASS1 PERM1;
>   role ROLE1;
>   role ROLE1 types TYPE1;
>   user USER1 roles ROLE1;
>   sid SID1 USER1:ROLE1:TYPE1
>
> Compile the policy:
>   checkpolicy -c 23 -o policy.bin policy.conf
> Converting back to a policy.conf causes a segfault:
>   checkpolicy -F -b -o policy.bin.conf policy.bin
>
> Have both sepol_kernel_policydb_to_conf() and
> sepol_kernel_policydb_to_cil() exit with an error if the kernel
> policy version is between 20 and 23.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

For this patch: Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

(for the first one, I reported a regression in "checkpolicy -V")

Thanks,
Nicolas

> ---
>  libsepol/src/kernel_to_cil.c  | 12 ++++++++++++
>  libsepol/src/kernel_to_conf.c | 12 ++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index a146ac51..edfebeaf 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -3164,6 +3164,18 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
>                 goto exit;
>         }
>
> +       if (pdb->policyvers >= POLICYDB_VERSION_AVTAB && pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
> +               /*
> +                * For policy versions between 20 and 23, attributes exist in the policy,
> +                * but only in the type_attr_map. This means that there are gaps in both
> +                * the type_val_to_struct and p_type_val_to_name arrays and policy rules
> +                * can refer to those gaps.
> +                */
> +               sepol_log_err("Writing policy versions between 20 and 23 as CIL is not supported");
> +               rc = -1;
> +               goto exit;
> +       }
> +
>         rc = constraint_rules_to_strs(pdb, mls_constraints, non_mls_constraints);
>         if (rc != 0) {
>                 goto exit;
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
> index a22f196d..ea58a026 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -3041,6 +3041,18 @@ int sepol_kernel_policydb_to_conf(FILE *out, struct policydb *pdb)
>                 goto exit;
>         }
>
> +       if (pdb->policyvers >= POLICYDB_VERSION_AVTAB && pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
> +               /*
> +                * For policy versions between 20 and 23, attributes exist in the policy,
> +                * but only in the type_attr_map. This means that there are gaps in both
> +                * the type_val_to_struct and p_type_val_to_name arrays and policy rules
> +                * can refer to those gaps.
> +                */
> +               sepol_log_err("Writing policy versions between 20 and 23 as a policy.conf is not supported");
> +               rc = -1;
> +               goto exit;
> +       }
> +
>         rc = constraint_rules_to_strs(pdb, mls_constraints, non_mls_constraints);
>         if (rc != 0) {
>                 goto exit;
> --
> 2.26.2
>

