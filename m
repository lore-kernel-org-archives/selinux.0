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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A8FC432BE
	for <selinux@archiver.kernel.org>; Fri, 27 Aug 2021 14:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F9A60F42
	for <selinux@archiver.kernel.org>; Fri, 27 Aug 2021 14:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhH0OQ2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Aug 2021 10:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhH0OQ1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Aug 2021 10:16:27 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE38C061757
        for <selinux@vger.kernel.org>; Fri, 27 Aug 2021 07:15:38 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so8059530otf.6
        for <selinux@vger.kernel.org>; Fri, 27 Aug 2021 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=6OsZEBvJyWMrqBmB6Oa0N4RQH4c0bw82607TpfDJf+0=;
        b=k6Uwn6d8buYDNTFSdxflkLmyRq5XlNrJ7yELo70y/zgr9ByTEqOAZKJ3XYPKQe/kaV
         sNYlTKrE8wAYclPuQ1J7fB+CBhmgUC/idtdMtgfSGiLtO/occfQy8XhjeADkkj3/BQ+d
         rGcGY66nNY1XNMZ6WQnrPPL1xmvAjegiNej1FkZY1sKIKnowc4VUTrRwPG7KOkU6oCgK
         5MMdlaIXYWTvOAM1fOFlVgpk/acKv52IRISeHUlpIgsgPb/CIZ9iv2HtNYhz8QJLqsp9
         +IS9t2oGh8I4YM8OCnM79NM7lGVO6Mt/5HhgIZ1mhW0LjIlBSGucRDbBXuyZM2v32fM3
         Hhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6OsZEBvJyWMrqBmB6Oa0N4RQH4c0bw82607TpfDJf+0=;
        b=Zr0ot7C9CAnvuZLr46t0fbIzcFmpYe9tDnH31SG2gpYWYMadJDkUqOVkOtlcMx9Xnx
         uegMsmxijRte5jQiTcIZpgMwg5a+Oe3Mndnlqzwe492nQaFo+GTcxqbzjDXdfoAaJfTj
         DQgRvFBdz79ZXIRFTiujBTFiKjsxyP0nkOU2xmyYHNZt9e0CKJ7eiGge5ypDO3atG+LH
         cxp6QN3N77HU31cfVHzzIBy5SPoonpWiyHWBzwe7aBct5t8HHf4tw+oG92nBOowYvo//
         IroVeJvRck/VqiecszW+q6NmFMV7M5ELRAbr3oYic+5NRBAB+oAk8UxgmmG4fKrV9se6
         x/RA==
X-Gm-Message-State: AOAM531YW2zYOBfcVHQqEeknT4T9wKdFJlFe3jG6c7NrPzkkU4zicclj
        fUa0WllQHLiC9v1vtrbLlhDoXRZBmTEN2/za7xFuMEFR
X-Google-Smtp-Source: ABdhPJy8jRVJgOAjzFR/KC8B0XqHSMHuP+W2IsvQjq9nyMUjQZ/F/BbNc/fbXDynmSsNAlL2Bnx2mxmxkmMun0Xw0Go=
X-Received: by 2002:a05:6830:1589:: with SMTP id i9mr8234665otr.196.1630073736589;
 Fri, 27 Aug 2021 07:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210823204841.175324-1-jwcart2@gmail.com>
In-Reply-To: <20210823204841.175324-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 27 Aug 2021 10:15:25 -0400
Message-ID: <CAP+JOzSgiaWqCe7HiPr6qzuGM02Ci_vsqAEcxRwtQZW9vxs8Jg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Properly check parse tree when printing
 error messages
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 23, 2021 at 4:48 PM James Carter <jwcart2@gmail.com> wrote:
>
> The function cil_tree_get_next_path() does not check whether the
> parse tree node that stores the high-level language file path of a
> src_info rule actually exists before trying to read the path. This
> can result in a NULL dereference.
>
> Check that all of the parse tree nodes of a src_info rule exist
> before reading the data from them.
>
> This bug was found by the secilc-fuzzer.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_tree.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> index 75293005..3fcf5d12 100644
> --- a/libsepol/cil/src/cil_tree.c
> +++ b/libsepol/cil/src/cil_tree.c
> @@ -62,7 +62,10 @@ struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **
>
>         while (node) {
>                 if (node->flavor == CIL_NODE && node->data == NULL) {
> -                       if (node->cl_head->data == CIL_KEY_SRC_INFO && node->cl_head->next != NULL && node->cl_head->next->next != NULL) {
> +                       if (node->cl_head->data == CIL_KEY_SRC_INFO) {

It should never be NULL, but I should still check that node->cl_head
is not NULL here.

I have a couple of more fixes for bugs found by the secilc-fuzzer, so
I will send an updated patch with those other two patches.
Jim

> +                               if (node->cl_head->next == NULL || node->cl_head->next->next == NULL || node->cl_head->next->next->next == NULL) {
> +                                       goto exit;
> +                               }
>                                 /* Parse Tree */
>                                 *info_kind = node->cl_head->next->data;
>                                 rc = cil_string_to_uint32(node->cl_head->next->next->data, hll_line, 10);
> --
> 2.31.1
>
