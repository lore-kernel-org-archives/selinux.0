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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A7AC433E6
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33EB764F26
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhCOVFg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhCOVFN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Mar 2021 17:05:13 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA85C06174A
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:05:13 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id l23-20020a05683004b7b02901b529d1a2fdso5829625otd.8
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFsW9eWOziOYJ2vusYpkc8ACKhzKqFOd6BcSRs7EnhM=;
        b=JEks8aKOug20BM7uaf+LRTSfTiFqk+KjryPtQevLu40fwXNRS0nGTk+x/hSt/Tas2O
         IF1v6vEm92evHSnRDrantGhQ9uXBSvWTyesIOSdx9G6s/5zdI22QQ+vN3NIpKnXrsEHY
         tJZ9tqyuodMw3STaQZX4vGdZV/KWW8jgDvxjyhT0D+IzOzdRrJYSWo+aEhBuN9ynJsGG
         qcSGCog4RqDr5OPNymz1nn6nKHqbaUN120OFkbBsEh5iBmXztnjDlc4lLdvHCpmqMJev
         ns0Y+uE+z0hsjAMwgpLjD38fiB6o2jvV/z6S0v4HVLQGLkHWUqqZkwPDbWbTe5BA8G7a
         8bGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFsW9eWOziOYJ2vusYpkc8ACKhzKqFOd6BcSRs7EnhM=;
        b=SE35DyrajziiQhMs2lcpMVtahZJiZ8cxyKRgCOd+mf+XB47TttBsbiP0NsNn7NnKYQ
         Tujf1f+Vyb+j/EFqYHbACztPVBdzaJA8Pdzy0c8jaEURJZGVdUDDNchDv/GVgBTUoFI9
         FyOeBhL4axQrtRuGizQqvUeIapSd1HsliD4sMytsbK3GNss2jYfNZwmULV3LmyihDm4o
         ro2cfhHoWANJyS+YZ80bhv68W8BVrSFJZRqjg1/6/JFeXxq8CzgRjby+vla8hhegYea3
         BHSFLBrvIfEcwtj7qVoveOY0MdHZH/4d0qoczZnzUYExEJhdDoS7OkebFt+cFE20nchl
         sSQg==
X-Gm-Message-State: AOAM533krvN0qXbY1YjTuxfV08yJafucR+iu3UIgIYIJiLGSTBpBjRPr
        7GnSe6uQbrNN/MdIUo7AfknCJY2TInld5aWA786NTdkPyrI=
X-Google-Smtp-Source: ABdhPJw804oja6ZfHSyolMdlSSmbTz6C768yllj8sFYMHjgX4lumWugbMegkxXTizfal/aBgnUrBJCeA0wRfJrylcMQ=
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr784064otr.59.1615842312608;
 Mon, 15 Mar 2021 14:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210314201651.474432-1-nicolas.iooss@m4x.org> <20210314201651.474432-5-nicolas.iooss@m4x.org>
In-Reply-To: <20210314201651.474432-5-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 15 Mar 2021 17:05:01 -0400
Message-ID: <CAP+JOzSu6PEhp-mjH=ww9d0TU3PpyEEODTEizfTEK_pYHqnFEg@mail.gmail.com>
Subject: Re: [PATCH 5/6] libsepol/cil: fix NULL pointer dereference in __cil_insert_name
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 14, 2021 at 4:22 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> OSS-Fuzz found a Null-dereference in __cil_insert_name when trying to
> compile the following policy:
>
>     (macro MACRO ()
>         (classmap CLASS (PERM))
>         (type TYPE)
>         (typetransition TYPE TYPE CLASS "name" TYPE)
>     )
>     (call MACRO)
>
> When using a macro with no argument, macro->params is NULL and
> cil_list_for_each(item, macro->params) dereferenced a NULL pointer.
> Fix this by checking that macro->params is not NULL before using it.
>
> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28565
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 2ea106d63505..63beed9230b9 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -82,7 +82,7 @@ static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key,
>         } else if (parent->flavor == CIL_MACRO) {
>                 macro = parent->data;
>         }
> -       if (macro != NULL) {
> +       if (macro != NULL && macro->params != NULL) {
>                 struct cil_list_item *item;
>                 cil_list_for_each(item, macro->params) {
>                         if (((struct cil_param*)item->data)->str == key) {
> --
> 2.30.2
>
