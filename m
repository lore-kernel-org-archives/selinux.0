Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF16AC47082
	for <selinux@archiver.kernel.org>; Thu,  3 Jun 2021 17:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7816610C9
	for <selinux@archiver.kernel.org>; Thu,  3 Jun 2021 17:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhFCRIU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Jun 2021 13:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFCRIU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Jun 2021 13:08:20 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3E4C06174A
        for <selinux@vger.kernel.org>; Thu,  3 Jun 2021 10:06:35 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso6408160otu.7
        for <selinux@vger.kernel.org>; Thu, 03 Jun 2021 10:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=k+Vwf0CM84VaN4WTzirfXivxVbYqVjlAnMSdLEDl5t4=;
        b=k24GsG0bZmYbe16z9NUNUQcfHFYFLTUwYgT+lOSbjGD/EiMmkZfYZ/2fNAVTPn88ka
         nVAYN2UlGj8n9fQqMFb+EbTQ5eAA5IiN7qA5gxbVOEPu3jaXUfhqdfOslyF3rKXu7+/P
         X8x1LMa22pNaSr0xASPzFX5iH7zEWLKMaHWuOB94m3E/62NxTNTle5gyqz4IwxXBwUmR
         /T5b9HbyYmNsumAXjQk3lQ0rjtI503v7SCtg2ymef+Wqs9Xk+Kkt8Delfhwa+5AzDaLi
         F/yJTz9SFm5myB/PkITGR8wAVZH7HbSclAc4awOU0miGl7ysg/UhAA0OnXO+6lR+iGy7
         pZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=k+Vwf0CM84VaN4WTzirfXivxVbYqVjlAnMSdLEDl5t4=;
        b=kKZ3Gr88ziZ1kzs051WmZV223cqDRC61nXRS9ZXtsunv1sCq1B+e3uO4pnWnWfutuO
         IAMb4t6/NL2AEQF5qDRt0GVpX2TdsZKOl1/1/2HaKOQLqHtJQ+qhudCn2+E1dEiXFt4w
         wtIZgpliZdNj0RoHg5GqvWMZYDAnvdGD3E1/MY/1aKE3bvXmc7UHy7EzqOz4iZ65K75m
         MRTKo4uPU8qFc2+5Yy3b0n8+A1dmNSkWVPow0fuag0xGFgwSiajRt0sEBcQJQ01bAN0n
         ufiSpt9WhBIbiDzZYwTyksRxN0odc9izF5whQYPPVdxGcleRldqaukwU6Ba8l1F/ULkL
         lelg==
X-Gm-Message-State: AOAM532JzsVFGiGMe3aCJNCKykNZAzk9O3cZPwkgkwXqolRJUDY/amgF
        N8NjyA41DWrTeDSQ8x677ulXO3flDglIFDwSIhJ2KA74LOc=
X-Google-Smtp-Source: ABdhPJw+BB3YL4tRfQcedl8xd66ir5Ix10X3GFGFoPab4l/2brk5m7NuzX05JaIrS4Ubh8WVAN7hCNS4sUBZUAh6Qlg=
X-Received: by 2002:a9d:614b:: with SMTP id c11mr243873otk.59.1622739995197;
 Thu, 03 Jun 2021 10:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210511200301.407855-1-jwcart2@gmail.com>
In-Reply-To: <20210511200301.407855-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 3 Jun 2021 13:06:24 -0400
Message-ID: <CAP+JOzS83Foo1eeXYcaLs2TxgoJRzh_ednHrn2+B-PrM97CU2Q@mail.gmail.com>
Subject: Re: [PATCH 0/5 v2] secilc/cil: Fix name resolution for macro calls
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 11, 2021 at 4:03 PM James Carter <jwcart2@gmail.com> wrote:
>
> This patch series fixes name resolution within expanded macro calls and
> with call arguments.
>
> The first patch is same as in v1.
> Patches 2-4 replace patch 2 in v1. The original way of fixing name
> resolution of call arguments did not work if a disabled optional
> forced a reset.
> Patch 5 is the same as patch 3 in v1.
>
> James Carter (5):
>   libsepol/cil: Make name resolution in macros work as documented
>   libsepol/cil: Do not add NULL node when inserting key into symtab
>   libsepo/cil: Refactor macro call resolution
>   libsepol/cil: Do not resolve arguments to declarations in the call
>   secilc/docs: Relocate and reword macro call name resolution order
>
>  libsepol/cil/src/cil_internal.h          |   1 -
>  libsepol/cil/src/cil_resolve_ast.c       | 635 ++++++++++++-----------
>  libsepol/cil/src/cil_symtab.c            |   8 +-
>  secilc/docs/cil_call_macro_statements.md |  24 +-
>  4 files changed, 354 insertions(+), 314 deletions(-)
>
> --
> 2.26.3
>

There hasn't been any comments on this series, and it has been more
than three weeks since I sent it, so I plan on merging it tomorrow.
Jim
