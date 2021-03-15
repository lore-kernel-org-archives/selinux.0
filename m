Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E2FC433E0
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F6A64F0F
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhCOVL2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:11:28 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:39942 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbhCOVK5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Mar 2021 17:10:57 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id AC5F8560692
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 22:10:55 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso260618pjb.3
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:10:55 -0700 (PDT)
X-Gm-Message-State: AOAM531deSqcKWcvXzfOogwHPwYJnGEsM1xfBvieBAD82ndeNTZFL3aD
        doc5e1Rc87+LaRWtc+/zpDEtC87IDIzMPr4rWDc=
X-Google-Smtp-Source: ABdhPJxEvb8/TDCrstFoOazB3TeT4Wqk/1r2xec3lj3DrIjAYakgkMh/Hfq9cb1ouUEFeXUmKMJRplMoYjudNcgb+Bg=
X-Received: by 2002:a17:90a:4d81:: with SMTP id m1mr1038311pjh.143.1615842654512;
 Mon, 15 Mar 2021 14:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210315150938.320990-1-jwcart2@gmail.com>
In-Reply-To: <20210315150938.320990-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 15 Mar 2021 22:10:43 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=miiSjhFfBV1jEBOROLm_kM+o1F+wSiUKLqahvc1bhLdA@mail.gmail.com>
Message-ID: <CAJfZ7=miiSjhFfBV1jEBOROLm_kM+o1F+wSiUKLqahvc1bhLdA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] checkpolicy: Do not automatically upgrade when
 using "-b" flag
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Mar 15 22:10:56 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 15, 2021 at 4:10 PM James Carter <jwcart2@gmail.com> wrote:
>
> When reading a binary policy, do not automatically change the version
> to the max policy version supported by libsepol or, if specified, the
> value given using the "-c" flag.
>
> If the binary policy version is less than or equal to version 23
> (POLICYDB_VERSION_PERMISSIVE) than do not automatically upgrade the
> policy and if a policy version is specified by the "-c" flag, only set
> the binary policy to the specified version if it is lower than the
> current version.
>
> If the binary policy version is greater than version 23 than it should
> be set to the maximum version supported by libsepol or, if specified,
> the value given by the "-c" flag.
>
> The reason for this change is that policy versions 20
> (POLICYDB_VERSION_AVTAB) to 23 have a more primitive support for type
> attributes where the datums are not written out, but they exist in the
> type_attr_map. This means that when the binary policy is read by
> libsepol, there will be gaps in the type_val_to_struct and
> p_type_val_to_name arrays and policy rules can refer to those gaps.
> Certain libsepol functions like sepol_kernel_policydb_to_conf() and
> sepol_kernel_policydb_to_cil() do not support this behavior and need
> to be able to identify these policies. Policies before version 20 do not
> support attributes at all and can be handled by all libsepol functions.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
> v2 - Give the proper value when printing the compatibility range

For both patches:
Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

>  checkpolicy/checkpolicy.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index 5841c5c4..acf1eac4 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -106,7 +106,7 @@ static int handle_unknown = SEPOL_DENY_UNKNOWN;
>  static const char *txtfile = "policy.conf";
>  static const char *binfile = "policy";
>
> -unsigned int policyvers = POLICYDB_VERSION_MAX;
> +unsigned int policyvers = 0;
>
>  static __attribute__((__noreturn__)) void usage(const char *progname)
>  {
> @@ -515,7 +515,8 @@ int main(int argc, char **argv)
>         }
>
>         if (show_version) {
> -               printf("%d (compatibility range %d-%d)\n", policyvers,
> +               printf("%d (compatibility range %d-%d)\n",
> +                          policyvers ? policyvers : POLICYDB_VERSION_MAX ,
>                        POLICYDB_VERSION_MAX, POLICYDB_VERSION_MIN);
>                 exit(0);
>         }
> @@ -588,6 +589,16 @@ int main(int argc, char **argv)
>                                 exit(1);
>                         }
>                 }
> +
> +               if (policydbp->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
> +                       if (policyvers > policydbp->policyvers) {
> +                               fprintf(stderr, "Binary policies with version <= %u cannot be upgraded\n", POLICYDB_VERSION_PERMISSIVE);
> +                       } else if (policyvers) {
> +                               policydbp->policyvers = policyvers;
> +                       }
> +               } else {
> +                       policydbp->policyvers = policyvers ? policyvers : POLICYDB_VERSION_MAX;
> +               }
>         } else {
>                 if (conf) {
>                         fprintf(stderr, "Can only generate policy.conf from binary policy\n");
> @@ -629,6 +640,8 @@ int main(int argc, char **argv)
>                         policydb_destroy(policydbp);
>                         policydbp = &policydb;
>                 }
> +
> +               policydbp->policyvers = policyvers ? policyvers : POLICYDB_VERSION_MAX;
>         }
>
>         if (policydb_load_isids(&policydb, &sidtab))
> @@ -654,8 +667,6 @@ int main(int argc, char **argv)
>                         }
>                 }
>
> -               policydb.policyvers = policyvers;
> -
>                 if (!cil) {
>                         if (!conf) {
>                                 policydb.policy_type = POLICY_KERN;
> --
> 2.26.2
>

