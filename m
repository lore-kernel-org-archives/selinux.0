Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AFBC433B4
	for <selinux@archiver.kernel.org>; Sat,  1 May 2021 14:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2F86157E
	for <selinux@archiver.kernel.org>; Sat,  1 May 2021 14:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhEAOeu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 May 2021 10:34:50 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47904 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhEAOeu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 May 2021 10:34:50 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7BA3B5654B5
        for <selinux@vger.kernel.org>; Sat,  1 May 2021 16:33:57 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id i190so1042350pfc.12
        for <selinux@vger.kernel.org>; Sat, 01 May 2021 07:33:57 -0700 (PDT)
X-Gm-Message-State: AOAM532VZmXxg+ahph4ZY+rQ1OUTuNK1iEHVHSExbkp3AILmvHsNh6cq
        qsBsbamtqsMGVy+rhPG4MIuqQPA7xMIY3byCGn8=
X-Google-Smtp-Source: ABdhPJypeKCRBoxxXQAQxV8oXrx6sQdQrZN2rb53faQG/AMoMXk2I2f4cthFe83+e2xJ8/fNpiINEHaxIeX4xyF9baY=
X-Received: by 2002:a63:1c54:: with SMTP id c20mr9723499pgm.210.1619879636124;
 Sat, 01 May 2021 07:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210428201753.282831-1-jwcart2@gmail.com> <20210428201753.282831-5-jwcart2@gmail.com>
In-Reply-To: <20210428201753.282831-5-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 1 May 2021 16:33:45 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==fJx3RFAgkkip+3+e1WbpkkJtDryvsxrO9oZ0smHLDgA@mail.gmail.com>
Message-ID: <CAJfZ7==fJx3RFAgkkip+3+e1WbpkkJtDryvsxrO9oZ0smHLDgA@mail.gmail.com>
Subject: Re: [PATCH 4/5] libsepol/cil: Check for self-referential loops in sets
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat May  1 16:33:58 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 28, 2021 at 10:18 PM James Carter <jwcart2@gmail.com> wrote:
>
> The secilc-fuzzer found a self-referential loop using category sets.
> Any set declaration in CIL that allows sets in it is susceptible to
> the creation of a self-referential loop. There is a check, but only
> for the name of the set being declared being used in the set
> declaration.
>
> Check for self-refential loops in user, role, and type attributes
> and in category sets. Since all of the sets need to be declared,
> this check has to be done when verifying the CIL db before doing
> the post phase.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_resolve_ast.c | 31 +---------
>  libsepol/cil/src/cil_verify.c      | 97 +++++++++++++++++++++---------
>  libsepol/cil/src/cil_verify.h      |  1 -
>  3 files changed, 71 insertions(+), 58 deletions(-)
>
[...]
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index 5a37dd2f..4c860a21 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -430,28 +430,71 @@ int cil_verify_decl_does_not_shadow_macro_parameter(struct cil_macro *macro, str
>         return SEPOL_OK;
>  }
>
> -int cil_verify_no_self_reference(struct cil_symtab_datum *datum, struct cil_list *datum_list)
> +int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_symtab_datum *orig);

Hello,
Your patches look fine. Nevertheless it would be cleaner if this
function was declared "static", as it is not used outside of
cil_verify.c. This is a suggestion which is not blocking any merge, so
if you prefer to merge the patches directly, feel free to do so.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

And thanks for working on fixing issues identified by OSS-Fuzz!
Nicolas

