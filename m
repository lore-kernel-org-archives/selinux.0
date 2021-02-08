Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1297AC433DB
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 15:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE2264E7C
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 15:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhBHP5h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Feb 2021 10:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhBHP52 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Feb 2021 10:57:28 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C54C061786
        for <selinux@vger.kernel.org>; Mon,  8 Feb 2021 07:56:48 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r75so2445232oie.11
        for <selinux@vger.kernel.org>; Mon, 08 Feb 2021 07:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5PVm0EVYYe/WYwonVUJ7XSgucE1Qhqci3fq2ngK8NQ=;
        b=QEmIuv66zdoju7YJ+lqoqHmGtft4mdNS8FQ4AA5JiphLdpC0mtJYtndN6VxzqnStBo
         4tsH0gGzOioVq6RafHb3t1YxpTd+GZgPQh7OmUXnLSojV4HbVLcQw1S+U6CbUG+F7OFc
         pJ2mejZxzils0Zsah0NoQzYkjz3F1UAEUHzGxej487wKuF4nJpzxylKCmdyjr8e4/wSW
         N7nrVjP+74h0CBOaSTlJQegZWC8naDmZl5oNswK9HOQN8IGdl4LAxH+r1N++N8iUC0rg
         hrSY4tjJBlUQrp6/E/+mjweUnG5Oqp+Iq+RvjYP+0u24BCYlyRATgTjYwp7biw3WEPv2
         t9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5PVm0EVYYe/WYwonVUJ7XSgucE1Qhqci3fq2ngK8NQ=;
        b=LOAarM3WsOEDbaEz3q6R9nfzIYsyY6czRrT39kCTFBk8K4+TP9qPe7bXLWuBmb0DuM
         EVUfnKIYMD2jSvbSiAJCjJenpRwBhsRQV52BDfCGT9D5PCdSwEOXXU6rw9sDQ0157yYg
         Onv53g2ahZRZpSlC9mDXGYkIynrB/bbOZLJoS39/d9spTACNlVP04PB9wtsUnWcIkGDg
         /srgXlB+huB66ssstncIa3Kd9gASn+eAk+RV7KM+kxEAjK+hX3cqEDynb6gFMhR6ZW66
         pLHEq2LEuFUPIzxEAiTb7x/pslKYJtpDx8wF43F8S7+IHtM/nAuGjy8U6G7W12vwJvbX
         wXUg==
X-Gm-Message-State: AOAM532WKRzHAJQ4iLMZIavgpFE6oswTi2+rPbphliFu2CnB6nXBckyd
        d/LtIUcSX0a/AyGwujoDhKBYnddUfe3ViqMs6vM=
X-Google-Smtp-Source: ABdhPJzT/Ny8unBBFdlLc/Ujt8+bgM1c8+UU6c+gZJhOaTOxvQ0FLNVBJ1Z8c9YVY9a5heLEuq6jADw45R4LIyxugiI=
X-Received: by 2002:aca:59d6:: with SMTP id n205mr11645219oib.138.1612799807785;
 Mon, 08 Feb 2021 07:56:47 -0800 (PST)
MIME-Version: 1.0
References: <CAJfZ7=nfbM7xzR3OH4o73DzZNxvrMX12f5-TEkszqXW1K=yLdQ@mail.gmail.com>
In-Reply-To: <CAJfZ7=nfbM7xzR3OH4o73DzZNxvrMX12f5-TEkszqXW1K=yLdQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 8 Feb 2021 10:56:36 -0500
Message-ID: <CAP+JOzQtbrKr-140DTSD09pUpYm8TWtTH=6wcy0UUBKRO2zMTA@mail.gmail.com>
Subject: Re: libsepol/cil: use-after-free with optional+class common
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 3, 2021 at 3:49 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Hello,
>
> I am continuing to investigate OSS-Fuzz crashes and the following one
> is quite complex. Here is a CIL policy which triggers a
> heap-use-after-free error in the CIL compiler:
>
> (class CLASS (PERM2))
> (classorder (CLASS))
> (classpermission CLSPRM)
> (optional o
>     (mlsvalidatetrans x (domby l1 h1))
>     (common CLSCOMMON (PERM1))
>     (classcommon CLASS CLSCOMMON)
> )
> (classpermissionset CLSPRM (CLASS (PERM1)))
>
> The issue is that the mlsvalidatetrans fails to resolve in pass
> CIL_PASS_MISC3, which comes after the resolution of classcommon (in
> pass CIL_PASS_MISC2). So:
>
> * In pass CIL_PASS_MISC2, the optional block still exists, the
> classcommon is resolved and class CLASS is linked with common
> CLSCOMMON.
> * In pass CIL_PASS_MISC3, the optional block is destroyed, including
> the common CLSCOMMON.
> * When classpermissionset is resolved, function cil_resolve_classperms
> uses "common_symtab = &class->common->perms;", which has been freed.
> The use-after-free issue occurs in __cil_resolve_perms (in
> libsepol/cil/src/cil_resolve_ast.c):
>
>   // common_symtab was freed
>   rc = cil_symtab_get_datum(common_symtab, curr->data, &perm_datum);
>
> I have not found a simple way to fix this issue. For example there is
> no way to get all the classes which references a common, from a common
> object (which would be helpful to remove these references when
> destructing the common). Another idea would be to implement some kind
> of reference counter and only really destroy the common when this
> refcount reaches zero, but the current implementation does not do such
> a thing.
>
> How should this issue be fixed?
>

The main problem here is that it really is not safe to destroy the
optional block subtree in the middle of the pass. Everything should
work if the disabled optional blocks are put in a list and destroyed
after the pass is finished and the reset is done. I will send out a
patch.

Thanks for looking into this.

Jim

> (For those who have access, the OSS-Fuzz issue is
> https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=29002)
>
> Nicolas
>
