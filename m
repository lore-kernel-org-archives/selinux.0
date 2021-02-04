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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E145EC433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 19:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A780564F10
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 19:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbhBDTXB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbhBDTWr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Feb 2021 14:22:47 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1798CC061788
        for <selinux@vger.kernel.org>; Thu,  4 Feb 2021 11:22:07 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id y72so1026925ooa.5
        for <selinux@vger.kernel.org>; Thu, 04 Feb 2021 11:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+jy7KG+yUcBRrSqJV9WEUglP+pnST7dxeJiF2xhSpxQ=;
        b=NtUr+jYf0SnEOi6za8SKnjyAnOHdTaBL6aL2l3fag4xQ/9uNG5CPVyyDl5USFPQvfB
         WU/Axm1gH/NxFNyZQr2Bic5F0wzE8ayIzEZoPmPaJmD/c/PzJvebhqxUDmoVNI1fEiIw
         Dl7wraHP7LmW2QzK4YXPQbAFm5KrixvCjdN09MB1oV0HGs6b/CikjjXROv/Y8FS8490P
         ob0TF5I9ztO9DuLvcZl5C2d0FCyXie52hxBSroWrERLKDZHF1pKGi06cq/T9KcSlPe0B
         +J/V+GeWiog4g6WDiWdeyLC8olnzP28Ac6PNn+5sEp3MPTmz8oeFcVK1/2BtLc3cjpPA
         o2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+jy7KG+yUcBRrSqJV9WEUglP+pnST7dxeJiF2xhSpxQ=;
        b=Zx682n0lVCwIZNhhgr5j11bYUElr8RPaQArydDsMBB2At4izVV/8KTHrEU/WoUEEMS
         LZo2brngPAIwlOoUQ7vP1+Z2OZjGYfXzJNSCi2r3th60XSedeBuoweSPCRlPPyWUOIw/
         sLLAgCvM2At2wgbVIyljjpKNH73rC1s+LAt2FQAItZBatAK2DF4SFth7RzQIPyMsY0BO
         59fu13Kwtka4YvFd8hgwwB2fMRKu7xmkmldv5XOmjLFjYbqNX9qNxOkyCDJt3WmSmyxS
         3g/TRa/R5HSjfBJmWSUIrDV2HWOyC66ehdCZZECmXHGWR655jHwi61li5qKyQZ19X67d
         gyHw==
X-Gm-Message-State: AOAM5339XTvwBMozNu+FN5gmNeFhDs3lL7/nEpDCXBqpI9CKwZGtM+9h
        aQd0Hs4cnHnHGyK9hktO6s3wKFAS8bd04qaB40JYDQYDyCY=
X-Google-Smtp-Source: ABdhPJwR5I+PTo0a8v0/47fIIyAzpaJC6PaT3MLpsE92LctiTheubp3INZkWvJO1eJu7DKOOattZERdcrWdBj8GkGZI=
X-Received: by 2002:a4a:cb87:: with SMTP id y7mr816536ooq.1.1612466526478;
 Thu, 04 Feb 2021 11:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20210203085846.6680-1-nicolas.iooss@m4x.org> <20210203085846.6680-3-nicolas.iooss@m4x.org>
In-Reply-To: <20210203085846.6680-3-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 4 Feb 2021 14:27:08 -0500
Message-ID: <CAP+JOzSk62FAj=xP5=8S2NCzdspn23NyxaMEVE4b+LvKyms3dw@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsepol: include header files in source files when
 matching declarations
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 3, 2021 at 4:00 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> It is good practise in C to include the header file that specifies the
> prototype of functions which are defined in the source file. Otherwise,
> the function prototypes which be different, which could cause unexpected
> issues.
>
> Add the include directives to do this.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_find.c      | 1 +
>  libsepol/cil/src/cil_fqn.c       | 1 +
>  libsepol/cil/src/cil_mem.c       | 1 +
>  libsepol/cil/src/cil_parser.c    | 1 +
>  libsepol/cil/src/cil_policy.c    | 1 +
>  libsepol/cil/src/cil_reset_ast.c | 1 +
>  libsepol/src/kernel_to_cil.c     | 1 +
>  libsepol/src/kernel_to_conf.c    | 1 +
>  libsepol/src/services.c          | 1 +
>  9 files changed, 9 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_find.c b/libsepol/cil/src/cil_find.c
> index 638b675db826..3898725f18d5 100644
> --- a/libsepol/cil/src/cil_find.c
> +++ b/libsepol/cil/src/cil_find.c
> @@ -30,6 +30,7 @@
>  #include <sepol/policydb/ebitmap.h>
>
>  #include "cil_internal.h"
> +#include "cil_find.h"
>  #include "cil_flavor.h"
>  #include "cil_list.h"
>  #include "cil_log.h"
> diff --git a/libsepol/cil/src/cil_fqn.c b/libsepol/cil/src/cil_fqn.c
> index 2e76f8737754..097222a83da9 100644
> --- a/libsepol/cil/src/cil_fqn.c
> +++ b/libsepol/cil/src/cil_fqn.c
> @@ -31,6 +31,7 @@
>  #include <stdio.h>
>  #include <string.h>
>
> +#include "cil_fqn.h"
>  #include "cil_internal.h"
>  #include "cil_log.h"
>  #include "cil_strpool.h"
> diff --git a/libsepol/cil/src/cil_mem.c b/libsepol/cil/src/cil_mem.c
> index f73021b58d50..8e4a1d246f2c 100644
> --- a/libsepol/cil/src/cil_mem.c
> +++ b/libsepol/cil/src/cil_mem.c
> @@ -33,6 +33,7 @@
>  #include <string.h>
>
>  #include "cil_log.h"
> +#include "cil_mem.h"
>
>  void *cil_malloc(size_t size)
>  {
> diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
> index b62043b95806..0038eed6dd1b 100644
> --- a/libsepol/cil/src/cil_parser.c
> +++ b/libsepol/cil/src/cil_parser.c
> @@ -38,6 +38,7 @@
>  #include "cil_mem.h"
>  #include "cil_tree.h"
>  #include "cil_lexer.h"
> +#include "cil_parser.h"
>  #include "cil_strpool.h"
>  #include "cil_stack.h"
>
> diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
> index 06d7d74e54c3..74edb34575ea 100644
> --- a/libsepol/cil/src/cil_policy.c
> +++ b/libsepol/cil/src/cil_policy.c
> @@ -41,6 +41,7 @@
>  #include "cil_flavor.h"
>  #include "cil_find.h"
>  #include "cil_mem.h"
> +#include "cil_policy.h"
>  #include "cil_tree.h"
>  #include "cil_list.h"
>  #include "cil_symtab.h"
> diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
> index 52e5f64011d2..3da1b9a64167 100644
> --- a/libsepol/cil/src/cil_reset_ast.c
> +++ b/libsepol/cil/src/cil_reset_ast.c
> @@ -2,6 +2,7 @@
>  #include "cil_internal.h"
>  #include "cil_log.h"
>  #include "cil_list.h"
> +#include "cil_reset_ast.h"
>  #include "cil_symtab.h"
>
>  static inline void cil_reset_classperms_list(struct cil_list *cp_list);
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index c247b32f9e75..a146ac514018 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -16,6 +16,7 @@
>  #define IPPROTO_SCTP 132
>  #endif
>
> +#include <sepol/kernel_to_cil.h>
>  #include <sepol/policydb/avtab.h>
>  #include <sepol/policydb/conditional.h>
>  #include <sepol/policydb/hashtab.h>
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
> index 62bf706c1aa0..a22f196df9e9 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -15,6 +15,7 @@
>  #define IPPROTO_SCTP 132
>  #endif
>
> +#include <sepol/kernel_to_conf.h>
>  #include <sepol/policydb/avtab.h>
>  #include <sepol/policydb/conditional.h>
>  #include <sepol/policydb/hashtab.h>
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index 72b39657cd2e..6596431c38e2 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -59,6 +59,7 @@
>  #include <sepol/policydb/services.h>
>  #include <sepol/policydb/conditional.h>
>  #include <sepol/policydb/util.h>
> +#include <sepol/sepol.h>
>
>  #include "debug.h"
>  #include "private.h"
> --
> 2.30.0
>
