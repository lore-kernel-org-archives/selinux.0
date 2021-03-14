Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B980BC433DB
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 11:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6D664E58
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 11:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhCNL2D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 14 Mar 2021 07:28:03 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:58315 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhCNL2C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 14 Mar 2021 07:28:02 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C22C7564DC5
        for <selinux@vger.kernel.org>; Sun, 14 Mar 2021 12:27:53 +0100 (CET)
Received: by mail-pg1-f169.google.com with SMTP id n9so17817576pgi.7
        for <selinux@vger.kernel.org>; Sun, 14 Mar 2021 04:27:53 -0700 (PDT)
X-Gm-Message-State: AOAM531bhrKyRbCmuK1qRJrtaulIalslOivZqo087VNvODMOv1ahQUDD
        +p59Z4H8WFej85Vicyk+dIZeV73MwndEAcrbL6s=
X-Google-Smtp-Source: ABdhPJzr7TsfK373oC7M4KBTE50A1HwoFqVHX8ZiVFwxZ8i5j56vfh/fDvzgRUkt0urVsEGh6XYzi5EiTJr7sP5nWBc=
X-Received: by 2002:a63:494b:: with SMTP id y11mr18777852pgk.99.1615721272453;
 Sun, 14 Mar 2021 04:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210311154105.195494-1-jwcart2@gmail.com>
In-Reply-To: <20210311154105.195494-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 14 Mar 2021 12:27:41 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==b4MYBKtAHL-M-YdU5Pk+SbgVad-YN6UZBxi6cvV=Mcg@mail.gmail.com>
Message-ID: <CAJfZ7==b4MYBKtAHL-M-YdU5Pk+SbgVad-YN6UZBxi6cvV=Mcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkpolicy: Do not automatically upgrade when using
 "-b" flag
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar 14 12:27:54 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 11, 2021 at 4:41 PM James Carter <jwcart2@gmail.com> wrote:
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
>  checkpolicy/checkpolicy.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index 5841c5c4..e7b225b8 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -106,7 +106,7 @@ static int handle_unknown = SEPOL_DENY_UNKNOWN;
>  static const char *txtfile = "policy.conf";
>  static const char *binfile = "policy";
>
> -unsigned int policyvers = POLICYDB_VERSION_MAX;
> +unsigned int policyvers = 0;

Hi,
This change breaks "make test" when testing secilc. This is because
secilc/Makefile uses "checkpolicy -V" to compute a policy version:

POL_VERS = $(shell $(CHECKPOLICY) -V | cut -f 1 -d ' ')

Before your patch:

$ checkpolicy -V
33 (compatibility range 33-15)

After:

$ checkpolicy -V
0 (compatibility range 33-15)

.. which makes secilc/Makefile try using "secilc -c 0 ...", which does not work.

Should "policyvers ? policyvers : POLICYDB_VERSION_MAX" also be used
when "checkpolicy -V" displays version information?

Thanks,
Nicolas

>
>  static __attribute__((__noreturn__)) void usage(const char *progname)
>  {
> @@ -588,6 +588,16 @@ int main(int argc, char **argv)
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
> @@ -629,6 +639,8 @@ int main(int argc, char **argv)
>                         policydb_destroy(policydbp);
>                         policydbp = &policydb;
>                 }
> +
> +               policydbp->policyvers = policyvers ? policyvers : POLICYDB_VERSION_MAX;
>         }
>
>         if (policydb_load_isids(&policydb, &sidtab))
> @@ -654,8 +666,6 @@ int main(int argc, char **argv)
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

