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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12BAC433E0
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 20:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB6D64E3F
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 20:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhBBUhB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Feb 2021 15:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhBBUhA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Feb 2021 15:37:00 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5747BC061573
        for <selinux@vger.kernel.org>; Tue,  2 Feb 2021 12:36:20 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id g69so24211936oib.12
        for <selinux@vger.kernel.org>; Tue, 02 Feb 2021 12:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fmmF/eiX3Hpb91gqpbkjo8b9HEFH3AQeoMY7Wwp2epg=;
        b=KLeI8zJyQc41GYMDvtWt+/eBSNFKi+c6nwswRd+G65X5eu+wnH5HjLDy+M21OWTuz5
         UOSE7I+zPeoqJJ/RFeawpv+4tDsces2ddwKqpn5R1s1T9YFYU0rZZ/Qia7RoipkhcBGo
         fv1nEnzK9JgzAm0vTkeVv9HIdtq+NAcPIQTwlE7sOzT1nFSJFcyVZdbnXoiTE5MtJIwN
         8ZHjlYLWBN7vhC6t4k1rmbjbLdxjl/g2xVbYPW7wSZeYewZgYl7A7TaLjnRpg+ezcbgK
         eTZSm9CmlYFbUOyH0I8EMRfuruyVfpOVkCGO93LEC+pYiN0PR1drjYM54pxaAqDyV15C
         bevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmmF/eiX3Hpb91gqpbkjo8b9HEFH3AQeoMY7Wwp2epg=;
        b=BU9eRdl3SHWogLNA0VrcB359n+rNuP2AP1iyko10dVxPHZox+knbR7OGKAxjhKFclE
         fPiXPryfCzxUQCenQI6WuXGAzzL7R8QO3+s9BqlRjsemy93buhPtUu7EoQmsqKRiy5e+
         ZbQU91pJGoJ9neUq/YNtgmO0A+lUrgd4AxM8G+zrz2cAVjU5bL6t/76IDmEFF+kDuDc3
         g54R5HgCFvjvXFbhNRkdigMLJbDxdHTfp29FUDviiAqnbXExBcec0w4q+Ky/mbJNzpB/
         gb5805lfc8A3w+UzsFWl6RHSxMMCxguO80yoIojqAXl/rPftbdMObgrsFK/jOHMAY5qk
         xEcA==
X-Gm-Message-State: AOAM533u0Hd/mw4Em3x6WTENprnlO0MXPjz0HRgtpFzVMHWFrIHl11Em
        IwxtxrOI+tTBXobRLdTG8x8r37P5gjx/cJfkLgX+gTqsOuY=
X-Google-Smtp-Source: ABdhPJyEHkewUxKPF0LuZhhyJ31fAn0gR/8UDiLWLy3L1nfyuJbW8IUIqpfIZ3WIB1BoxpfhFeRszEYUgNGedQbHmS0=
X-Received: by 2002:aca:f00a:: with SMTP id o10mr4115303oih.128.1612298179852;
 Tue, 02 Feb 2021 12:36:19 -0800 (PST)
MIME-Version: 1.0
References: <20210201221758.13349-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210201221758.13349-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 2 Feb 2021 15:36:08 -0500
Message-ID: <CAP+JOzROBnb0fRSFM3NVHbqxSk5n7tmvx6pqc7FgzPj0qadFFQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol/cil: unlink blockinherit->block link when
 destroying a block
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 1, 2021 at 5:20 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> The following CIL policy triggers a heap use-after-free in secilc
> because when the blockinherit node is destroyed, the block node was
> already destroyed:
>
>     (block b2a)
>     (blockinherit b2a)
>
> Fix this by setting blockinherit->block to NULL when destroying block.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_build_ast.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 02481558ad11..c6edcde6bc5d 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -231,13 +231,30 @@ exit:
>
>  void cil_destroy_block(struct cil_block *block)
>  {
> +       struct cil_list_item *item;
> +       struct cil_tree_node *bi_node;
> +       struct cil_blockinherit *inherit;
> +
>         if (block == NULL) {
>                 return;
>         }
>
>         cil_symtab_datum_destroy(&block->datum);
>         cil_symtab_array_destroy(block->symtab);
> -       cil_list_destroy(&block->bi_nodes, CIL_FALSE);
> +       if (block->bi_nodes != NULL) {
> +               /* unlink blockinherit->block */
> +               cil_list_for_each(item, block->bi_nodes) {
> +                       bi_node = item->data;
> +                       /* the conditions should always be true, but better be sure */
> +                       if (bi_node->flavor == CIL_BLOCKINHERIT) {
> +                               inherit = bi_node->data;
> +                               if (inherit->block == block) {
> +                                       inherit->block = NULL;
> +                               }
> +                       }
> +               }
> +               cil_list_destroy(&block->bi_nodes, CIL_FALSE);
> +       }
>
>         free(block);
>  }
> --
> 2.30.0
>
