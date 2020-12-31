Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FF0C433E0
	for <selinux@archiver.kernel.org>; Thu, 31 Dec 2020 15:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103F3223E4
	for <selinux@archiver.kernel.org>; Thu, 31 Dec 2020 15:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgLaPGW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Dec 2020 10:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLaPGW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Dec 2020 10:06:22 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D9CC061573
        for <selinux@vger.kernel.org>; Thu, 31 Dec 2020 07:05:42 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id v3so17582569ilo.5
        for <selinux@vger.kernel.org>; Thu, 31 Dec 2020 07:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNlnyFDkawnOC8A5bWhoN5x1zHZKhRLxtU1C9ylHkV0=;
        b=BPi9VAccoXVMnZpDlFrjINwybddJwKITrVyUeCVfQcAFGNhSm9O2lLmxq+I04kh6yT
         327rcUNHLUeJ80KQ4kZPsOuUiUuldOZRlmO6lBpvUmYtOixFFIzDGvnST7cvZr163IYY
         v+uPQhCKvN4FIL6fmXwgA0di/xudJeBP2KEMo4m0S1SS0cQ7+VE204eeIEDYLzceNStl
         EN6TWyoO3OWl19If+b6xGXA4TMzPOndwN1T6lehSJyTWDTAO61zlzW5OnMLEHwzxnp2r
         qCG7recRNePCoC/ba9jpkYKoAU/8EPH0FhTG/D3BlNupZcHayTp1s6W8XtCW+tFXrTbP
         p0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNlnyFDkawnOC8A5bWhoN5x1zHZKhRLxtU1C9ylHkV0=;
        b=ZENr4+sIhrark+f0X0bqvTxDMAsYp5bk6sDFNGpWFgxDPHD0LuNWIH+aCRuXmfD+YF
         EQGiFUjduAz1lkYOUygQ1wKxLog3ZUe28f0JOxBm9FPGY8t5ShufjZ1v2Q64CDq4cKNH
         AEG+EtjsjX0Isx9oN8vVYCB1fvZLK2I4mWKRD/LfOHDKcqCQk2JNn4OzgR6fEwp9eEQH
         e17cyQwE+6+LYXSBxl8eRtXCjzgLqPWnnwhxnsSZfTcV3GyBTu8g7qfR8cf6JZykiS5C
         4S+S4gqwcHOnhtWW1Omq4Mwbs8BqTz2mWOnQzBzsUCMoTUX8U+K6Du9geQBQba7TabMD
         odBA==
X-Gm-Message-State: AOAM532Ke7C+FuMg031R+xyJbQLKQCuv015Zuu5FhiTgkx7EjwuZat1O
        AHAvyqEcZSwrzg6Z0i2+p71Y3q7Km714CFSX0SG7Erfx0LQ=
X-Google-Smtp-Source: ABdhPJwiwfveKuSTMe5pDzoIlrq7SkiqNZFi7Vc7cvDyy+br0NXjd9rvw2cJOiquIIc6oaZz5e7he8DU7QamkG+lxBk=
X-Received: by 2002:a05:6e02:1b8a:: with SMTP id h10mr57335295ili.141.1609427141348;
 Thu, 31 Dec 2020 07:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org> <20201230100746.2549568-6-nicolas.iooss@m4x.org>
In-Reply-To: <20201230100746.2549568-6-nicolas.iooss@m4x.org>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 31 Dec 2020 09:05:30 -0600
Message-ID: <CAFftDdrEaCUvRuQZ+h2TU34iG9tV1j+gWqe0HSFGeCz=zpzX=g@mail.gmail.com>
Subject: Re: [PATCH 6/6] libsepol/cil: destroy perm_datums when
 __cil_resolve_perms fails
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 30, 2020 at 4:10 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
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

ack on all but patch #4, comments sent for that patch.
