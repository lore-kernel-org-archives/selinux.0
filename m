Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E823C433E0
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 18:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55AFB21D1B
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 18:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhADSTa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Jan 2021 13:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbhADST3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Jan 2021 13:19:29 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E500C061574
        for <selinux@vger.kernel.org>; Mon,  4 Jan 2021 10:18:49 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id x13so33139978oic.5
        for <selinux@vger.kernel.org>; Mon, 04 Jan 2021 10:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=moujNiHvMWDLKBgul1pFPW3r+wTjA6PsrBGrSOlxHoo=;
        b=TAIAk/xxaCeciRAC647fEaCsNA8UGykPrD+KnnCAH3LaFsqTSUxJB7gxB1mF4jDWaU
         ntFw9rHuJ1zieALHHxMorIRDvCXYB/IlpQrnmV34KYcmRHHzbnLZx9IC5xUxvpLv4Gn5
         GLDYhvLG/t08NuPUnQzzHD5+ihX7wh42giTnfon8phhQG0t33T4yOzQg1CXImKb9KeWu
         2O9l/9nTkQWxGKoaGZX+FiRfrGEeALRhYaCj1ugtB3moODpQWwSUDZf7y1ORcXXN5KdQ
         y94ZNme/zO7PlXDBBnqdTq7ZY2mQqhx+9xUG+VEjuofputP+eyLfut/mURhlbttgRgrl
         dcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=moujNiHvMWDLKBgul1pFPW3r+wTjA6PsrBGrSOlxHoo=;
        b=DQfRBckl3EWSXItsqwWlbsvCyRRgg/wpVVvvmxCBvMQsODuYZSv4NsdybSrCUeusZP
         CEfQEpV3xfYtzUrWhqt25zodSNx4ZQDRENEtgmgFR+3PUTipo9kbFbcH+YasshoIpYpj
         Z2VdQJrJqdFvcZxadQk3APBXnyqyh4c+xY7pTmx1D1jiv0c8oguRFqHvg3Qwfcle4rcf
         BLFfWcu86qeNkq4krEwiQWSyQgbxaFcu4lARZjx9jGGh21I3MUcr9Rfaz3v4zty5Df+m
         ZBex7tjoIiz+3UFEuo2QBROHgoShjbdbCuOfOScKM/z/V5jjzN7BIQNVAN+2WF0Kaf9K
         NiWw==
X-Gm-Message-State: AOAM53000i54Z6mEDIuErKLIH8fRhpJES4xYU2rZNZkawOesjD72kQ+S
        y6+Eex5FwwcWyJ4mTQ5/9XuNIE77nUndF1miqq8=
X-Google-Smtp-Source: ABdhPJxo4rUbPgGARcveOcPbBBNIj2brEaqW38KQ7HgIHuRtTtf5vuIKFyO206OJmmDPu3v5ILcxFpFkyc4hUVhK8yI=
X-Received: by 2002:aca:1c0b:: with SMTP id c11mr149677oic.16.1609784329051;
 Mon, 04 Jan 2021 10:18:49 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org> <20201230100746.2549568-6-nicolas.iooss@m4x.org>
In-Reply-To: <20201230100746.2549568-6-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Jan 2021 13:18:38 -0500
Message-ID: <CAP+JOzSpZcod2TF6j=XEXNw5VyQoDuaYGJ_65AQAD9G-ymUtSA@mail.gmail.com>
Subject: Re: [PATCH 6/6] libsepol/cil: destroy perm_datums when
 __cil_resolve_perms fails
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 30, 2020 at 5:10 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> When __cil_resolve_perms fails, it does not destroy perm_datums, which
> leads to a memory leak reported by OSS-Fuzz with the following CIL
> policy:
>
>     (class cl01())
>     (classorder(cl01))
>     (type at02)
>     (type tpr3)
>     (allow at02 tpr3(cl01((s))))
>
> Calling cil_list_destroy() fixes the issue.
>
> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28466
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index ecd05dfa5dab..255f17ae7e30 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -146,6 +146,7 @@ static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_symtab,
>         return SEPOL_OK;
>
>  exit:
> +       cil_list_destroy(perm_datums, CIL_FALSE);
>         return rc;
>  }
>
> --
> 2.29.2
>
