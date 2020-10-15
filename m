Return-Path: <SRS0=0RAF=DW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D81FC433E7
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E3120723
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAMT8ZxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389893AbgJORAn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389479AbgJORAn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Oct 2020 13:00:43 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0121DC061755
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:00:43 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w141so3864195oia.2
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQXKsZPFs+GdEvjAVNbpu/oYOe3qKIx1FQ+fpCUlsu0=;
        b=jAMT8ZxIWLuBbs0QKnm/FdtHbU1BZUus42r16wW74AGfv/GzU6RSWPecm0scraLpI8
         1Hyzvd1PNKVbPVwLLEJaX0ynMlxDVHzYKtaNghsOxqZvGmLRPWHn2BY80/EZBEFdIFzs
         Hhv9m+iDv4cDYo6J8TMvqkNpP7X6NrNmc4n98emjZweG+GWankP6RrxFk2aKgA3Im8Rk
         k20vR9bWZmRLxwuLhR9VkXg+ouf4HKe6BSgmZr0X0a2ZOuoeLzjdYABjMpwskPM/kT9q
         jwUMoTc4PA/rm8CxfK1aw9FJhOl1m6yfsxOqtBJ+/TduMJ/UIpomYQJkf5eJVImviGe4
         xnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQXKsZPFs+GdEvjAVNbpu/oYOe3qKIx1FQ+fpCUlsu0=;
        b=fkhiFXFH4gY7/FavjV+b7J06Ys//chf/FDdmD46RPcgtHTz+HiyMZ9MaEkksl0VeXH
         sbg+6P4+lGtnCPzESL6XPuTjxiE1IOE2d98zATvu3SCjHqTxU9wC0vk905QO9CBKchJ/
         XiCyae5OkR6nj6DiqL+puohs6oBvcBzBxqHL85RK0WbNh/pnyirddwQeGyQ2XFEJhRxB
         MyJsdaa0RJzJdiHa2CkneKHB4OMv3tbo/URhHcF/LZemKkgG4o2aGR8+KrNwlWMPR8s+
         qG0C7wLUUw+POZ3xquCXwb/ctgDjaY69ijTYCe2GvhGeNV1SsbmTlBWsVyA9xLLczrxC
         u09Q==
X-Gm-Message-State: AOAM532W33gkBPieWPyDhctVQdubeAkIBaeEpYKVd+PDniHl77dvVSR0
        LfdoD0yelicMnsxcLB61uDazKk/piFLH8J0S2x6P+F4HL0o=
X-Google-Smtp-Source: ABdhPJyfBUFWsE5rdwukvc0OrIiti+alhn+TJ3RGEMFZ5TcgEBMm21hxuCiHGc3jONdoZrBU9V2Jy1Jth8faylqxsIQ=
X-Received: by 2002:aca:ac8c:: with SMTP id v134mr2794838oie.128.1602781242374;
 Thu, 15 Oct 2020 10:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201003193957.1876526-1-nicolas.iooss@m4x.org> <20201003193957.1876526-2-nicolas.iooss@m4x.org>
In-Reply-To: <20201003193957.1876526-2-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 15 Oct 2020 13:00:31 -0400
Message-ID: <CAP+JOzTfHeF7DTEsubhC3Lhyvrj2S_TX-3rOUD7dtHa=zsoQdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: silence potential NULL pointer dereference warning
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Oct 3, 2020 at 3:41 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> When find_avtab_node() is called with key->specified & AVTAB_XPERMS and
> xperms=NULL, xperms is being dereferenced. This is detected as a
> "NULL pointer dereference issue" by static analyzers.
>
> Even though it does not make much sense to call find_avtab_node() in a
> way which triggers the NULL pointer dereference issue, static analyzers
> have a hard time with calls such as:
>
>     node = find_avtab_node(handle, avtab, &avkey, cond, NULL);
>
> ... where xperms=NULL.
>
> So, make the function report an error instead of crashing.
>
> Here is an example of report from clang's static analyzer:
> https://558-118970575-gh.circle-artifacts.com/0/output-scan-build/2020-10-02-065849-6375-1/report-d86a57.html#EndPath
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/expand.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 19e48c507236..eac7e4507d02 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1570,17 +1570,22 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
>
>         /* AVTAB_XPERMS entries are not necessarily unique */
>         if (key->specified & AVTAB_XPERMS) {
> -               node = avtab_search_node(avtab, key);
> -               while (node) {
> -                       if ((node->datum.xperms->specified == xperms->specified) &&
> -                               (node->datum.xperms->driver == xperms->driver)) {
> -                               match = 1;
> -                               break;
> +               if (xperms == NULL) {
> +                       ERR(handle, "searching xperms NULL");
> +                       node = NULL;
> +               } else {
> +                       node = avtab_search_node(avtab, key);
> +                       while (node) {
> +                               if ((node->datum.xperms->specified == xperms->specified) &&
> +                                       (node->datum.xperms->driver == xperms->driver)) {
> +                                       match = 1;
> +                                       break;
> +                               }
> +                               node = avtab_search_node_next(node, key->specified);
>                         }
> -                       node = avtab_search_node_next(node, key->specified);
> +                       if (!match)
> +                               node = NULL;
>                 }
> -               if (!match)
> -                       node = NULL;
>         } else {
>                 node = avtab_search_node(avtab, key);
>         }
> --
> 2.28.0
>
