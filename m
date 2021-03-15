Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606C2C433DB
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F7C64E99
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhCOVEc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbhCOVEM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Mar 2021 17:04:12 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3856C06174A
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:04:12 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id d20so35889354oiw.10
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpz+JqBl+GeOBa/+eDHnDGvnlc5M1RC5HVHENyIUeTw=;
        b=g4WAYpI0jUQb591OIhpWrlwdd0sqlwl9Oc+83rJc2aX+VFDiQFt/+reD9Zyc0wsiSc
         b3unY38B4KtC3HXGm3jzz6gWOnPuYsS3Ve/TlP6Sjqv/VuAynfOTAHigyBipVcR/mIa9
         yFw4AzN2pdTF3tOdf35v68sbEovpFQENQUdhbdJmDAY+BQ2M1Tj/Aam58CJ8olTtfjS2
         kSfW64o4vrobvJi/tpO8iQHO8MUqcnSSaV73eLi827r6PYSVHfYb2ap+mHlolQnrMErD
         fpY8h7ORF9DmvB0sWaE0hC75mLlCKOWexFlzhtD5V9YGzSq47ylyxc/YNnedZomi/ihT
         HM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpz+JqBl+GeOBa/+eDHnDGvnlc5M1RC5HVHENyIUeTw=;
        b=adfdkElJPdo0oM/uRpin5rhmZj++4PTVy67+EtI6MAYAYchLoVlGB3RYIUJyShfloj
         T8NzkSe8kBNbi+1SCYieSMGi6Ocau36rouNyGp6F3oJaEMOem8yoLYvUJch3pMusT1Ci
         doTPHB6IgL2Fx3dcXPfS2Z57Hb67QIDNIm9bdDpkcEAXyb1gNgG9/V2UUnTIQou0Mgrd
         GbexDfcO7w4R8npCaXoMitYDvVsYkqLH0D9HeeMADC+gApYpFI+A3I4iCN8YQAIp61Au
         907nWQz99IpLY7B9xG/3b3hs9AooWumtMvYZev/XJ4SXlYJ8RZR3YBerrIG5kLFCm1TF
         AsuA==
X-Gm-Message-State: AOAM530I+4wwTNBrNbY41PWViGCPdFntbnuIKpkBTruvN3CSLpgLNaTY
        5uvy3bXd1sDy8vj6scYeWcQ0vkuJNXOoWgk9Jo8=
X-Google-Smtp-Source: ABdhPJwqAtrfgUEhliUs+/xJf0/E2ow8r4qqCh1n0dizwHNgu1g7ZDsnLlb9u1jUXuy1I5HGJzPiEQziwhhBhQs0MMs=
X-Received: by 2002:a05:6808:1482:: with SMTP id e2mr778959oiw.138.1615842252214;
 Mon, 15 Mar 2021 14:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210314201651.474432-1-nicolas.iooss@m4x.org> <20210314201651.474432-4-nicolas.iooss@m4x.org>
In-Reply-To: <20210314201651.474432-4-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 15 Mar 2021 17:04:01 -0400
Message-ID: <CAP+JOzRXD-Hf0ew12wgW-5RT5Q7t0taWQRacHKUZ1YdQcj-c5A@mail.gmail.com>
Subject: Re: [PATCH 4/6] libsepol/cil: replace printf with proper cil_tree_log
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 14, 2021 at 4:22 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> All functions of the CIL compiler use cil_log or cil_tree_log to report
> errors, but in two places which still uses printf. Replace these printf
> invocation with cil_tree_log.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 47cdf0e7c0b9..2ea106d63505 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -2497,7 +2497,7 @@ int cil_resolve_in(struct cil_tree_node *current, void *extra_args)
>
>         rc = cil_copy_ast(db, current, block_node);
>         if (rc != SEPOL_OK) {
> -               printf("Failed to copy in, rc: %d\n", rc);
> +               cil_tree_log(current, CIL_ERR, "Failed to copy in-statement");
>                 goto exit;
>         }
>
> @@ -2788,7 +2788,7 @@ int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
>         macro_node = NODE(macro_datum);
>
>         if (macro_node->flavor != CIL_MACRO) {
> -               printf("Failed to resolve %s to a macro\n", new_call->macro_str);
> +               cil_tree_log(current, CIL_ERR, "Failed to resolve %s to a macro", new_call->macro_str);
>                 rc = SEPOL_ERR;
>                 goto exit;
>         }
> --
> 2.30.2
>
