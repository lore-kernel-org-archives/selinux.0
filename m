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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019D0C433DB
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFBAE64F0F
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhCOVD7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbhCOVDh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Mar 2021 17:03:37 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D0DC06174A
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:03:37 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id n23so7661665otq.1
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nW7CM/bBf6Gfs6wwwtEFw7VzyiNM9yzRDs00KVN/WF4=;
        b=HlS/g9qUvTdBTToIHiBTHOWHkdIW4ptwCCQZEHa+v0dUEdZ7IEH5LA8fJGiEYqG3Fm
         bwfROjjw1ExQJBaIuYgJp58euytw1gDoqGo2RRAN6SJlNBt/QGqn1COzlK899a4vovo2
         oyen8xy07I1yJVNZBuEu2dSbGKkGXq1M09KFlNi8p6CNUNF442VjyokBmOEWWU1yvMrL
         1aPfJwKXyRFDmLhcl0UQ86iFq94D9cFpFc9wIuLkqKyVYtRexxW/P1/r9hnh3u8lkv26
         YlIGHlkUaSFOq0WT2CpeLFNPTKnKbgQTTDFkHfJd4mT86S8unFZIm7H8odEJ19hfhf3N
         v1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nW7CM/bBf6Gfs6wwwtEFw7VzyiNM9yzRDs00KVN/WF4=;
        b=rVs6dJBeM9bc0KghQUN7Jcd3EgcY79w5YHgFKGptL/XaPM+TZP98qg+xTJKSXYKiZQ
         0j4kqKQpKnxxhBgQinkIdRJ8lwM8GHzbX6L3V7bWIveKdEob2c8V74ILjm+q3vDRWOCt
         cXwM4nBXrzDfd8MeauLTQYizfKFJO4G9X25K39WtiFc8Xr18rdeYz70HLNeX9JaXhWgh
         tufiYRx+XOr9gbO0hiOsDVg8dHMp1mHo5xpDljRagdi8MucxFzkdXDHKEjxodOvNuGU7
         wq9YyEoWlMD26dxKG0NOtekXMC5w1Hmr8iPQapx6k/B7XIccAk70BtZbHGVkanLkg8Gh
         5Y2g==
X-Gm-Message-State: AOAM532MxyYKe9dFMVrRYmWfKZ83wPcmgethw+dw9iiRMhA/H060XtkQ
        Qy56h4Z9uyZppbHNd0nB4a7SKgE0Xe6ush6cTgJ3IgDSjvo=
X-Google-Smtp-Source: ABdhPJyLgmrJnMH0ASsL2uVNUCNPaKdT9wEftb6A388A4mMDO51ShqUcJFSHqxuHd/XtmfeV/SqgSS6FJz9nttzNg5I=
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr778933otr.59.1615842216854;
 Mon, 15 Mar 2021 14:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210314201651.474432-1-nicolas.iooss@m4x.org> <20210314201651.474432-2-nicolas.iooss@m4x.org>
In-Reply-To: <20210314201651.474432-2-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 15 Mar 2021 17:03:26 -0400
Message-ID: <CAP+JOzTEmNNqx_ajLh7SO3F9D1rz+h00KgtzdgrqGAAPz17xjA@mail.gmail.com>
Subject: Re: [PATCH 2/6] libsepol/cil: make cil_post_fc_fill_data static
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 14, 2021 at 4:22 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> cil_post_fc_fill_data() is not used outside of cil_post.c, and is not
> exported in libsepol.so. Make it static, in order to ease the analysis
> of static analyzers.
>
> While at it, make its path argument "const char*" and the fields of
> "struct fc_data" "unsigned int" or "size_t", in order to make the types
> better match the values.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_post.c | 11 +++++++++--
>  libsepol/cil/src/cil_post.h |  7 -------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 5f9cf4efd242..783929e50df8 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -27,6 +27,7 @@
>   * either expressed or implied, of Tresys Technology, LLC.
>   */
>
> +#include <stddef.h>
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <string.h>
> @@ -50,6 +51,12 @@
>  #define GEN_REQUIRE_ATTR "cil_gen_require" /* Also in libsepol/src/module_to_cil.c */
>  #define TYPEATTR_INFIX "_typeattr_"        /* Also in libsepol/src/module_to_cil.c */
>
> +struct fc_data {
> +       unsigned int meta;
> +       size_t stem_len;
> +       size_t str_len;
> +};
> +
>  static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t *out, int max, struct cil_db *db);
>  static int __cil_expr_list_to_bitmap(struct cil_list *expr_list, ebitmap_t *out, int max, struct cil_db *db);
>
> @@ -156,9 +163,9 @@ static int cil_verify_is_list(struct cil_list *list, enum cil_flavor flavor)
>         return CIL_TRUE;
>  }
>
> -void cil_post_fc_fill_data(struct fc_data *fc, char *path)
> +static void cil_post_fc_fill_data(struct fc_data *fc, const char *path)
>  {
> -       int c = 0;
> +       size_t c = 0;
>         fc->meta = 0;
>         fc->stem_len = 0;
>         fc->str_len = 0;
> diff --git a/libsepol/cil/src/cil_post.h b/libsepol/cil/src/cil_post.h
> index 3d5415486b77..b1d2206f9ef6 100644
> --- a/libsepol/cil/src/cil_post.h
> +++ b/libsepol/cil/src/cil_post.h
> @@ -30,13 +30,6 @@
>  #ifndef CIL_POST_H_
>  #define CIL_POST_H_
>
> -struct fc_data {
> -       int meta;
> -       int stem_len;
> -       int str_len;
> -};
> -
> -void cil_post_fc_fill_data(struct fc_data *fc, char *path);
>  int cil_post_filecon_compare(const void *a, const void *b);
>  int cil_post_ibpkeycon_compare(const void *a, const void *b);
>  int cil_post_portcon_compare(const void *a, const void *b);
> --
> 2.30.2
>
