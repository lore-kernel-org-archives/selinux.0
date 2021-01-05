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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70A4C433E6
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 16:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36F422CA1
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 16:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbhAEQI4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Jan 2021 11:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbhAEQI4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Jan 2021 11:08:56 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22890C061798
        for <selinux@vger.kernel.org>; Tue,  5 Jan 2021 08:08:16 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id r9so94847otk.11
        for <selinux@vger.kernel.org>; Tue, 05 Jan 2021 08:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXxMRteqLzqUzmLt4dzTn0FKK1w74lKhnaxHtylXWl0=;
        b=IcZqLRKf60w6ThUmMOZpyH9WOB1f0Ohlk9z5wlvBYAMm4eWKzetFxANQmjm+E2djJr
         zSpBGAGDsASmmcFVRP6zRHlhEFB0S8r4mY/A/7TEJQGGdjvSI0oYvq7UNyrh0iaar3GV
         kECd/JYJxUY+25bPInGfUlGWRjOOwaZtSd8r9X8A6rQDzoI2hOnQ0WkTvzH8mdivmT5l
         v0t+9wAtXKyryGfnM973LJT8j1WTghE79S+FLUex+Y2h63byFGATSKiRKSWbdjuTpeKv
         ZlP0EiRpoRdoR8fdnKmjDLIPZ5VElTSJv8UU77OSIiZP2FmCKXAoXBLuYDtUM853D7X9
         1ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXxMRteqLzqUzmLt4dzTn0FKK1w74lKhnaxHtylXWl0=;
        b=mK97ab+D5uE+xP7qUV0lXNgsXBhxEmrfEXFsBPvdL9t7lHUagX/2St8/Dbq2+cIN6S
         ESauYXwU/2pvi/SU8RoV1p+ElHBZJzAsA9h1IRl96/WdPzdDxv1HvzFeUMH+a3u8P+yz
         uK0/k0aVkNX2IGMFbF4p7yNb9P31o/LxabfVUrOKU1j3v1YMmINGoXxi9t0YbeP4bP6o
         cu8SUsoYSMrwk+Fqz59Ny2fHn4Zbp2PKo8GBXqDOdZRkJISluvooLqoyBQNHN5M6PUPa
         mxUiq//qREzaZmvrJqmncO4sWYW+TyuonIwSJNZwC0Cr4c7NQQYLZpUE1M9DyLMlOI58
         LWPA==
X-Gm-Message-State: AOAM531WTamrbmqMnK+zzKCTjLS53+54qf6AuTZBxWdmRPF5L3LWApTz
        Q5vGqkR9JJ5nIfAwoHKnV8w3GAx7masjA4dMkCQ8LvHc
X-Google-Smtp-Source: ABdhPJym8AoOOnJpM93GHlSmZ27k2xz3H7ZyjOefjXrhflQo1xWPsV71f311843Rg3fanlWgfF+G7Zv/0PL5n4DSsc8=
X-Received: by 2002:a05:6830:1385:: with SMTP id d5mr44348otq.295.1609862895581;
 Tue, 05 Jan 2021 08:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org>
 <20201230100746.2549568-5-nicolas.iooss@m4x.org> <CAP+JOzQ0g_3vQxfhK02hbFKtqVSE89HrD__LJcxESGux-UsMKQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQ0g_3vQxfhK02hbFKtqVSE89HrD__LJcxESGux-UsMKQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 5 Jan 2021 11:08:04 -0500
Message-ID: <CAP+JOzReRjq8kL7-nCjUzNNw0Wya_cO5mSL9YQ0h88CA1umgZQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] libsepol/cil: fix out-of-bound read in cil_print_recursive_blockinherit
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Applied.

Thanks,
Jim

On Mon, Jan 4, 2021 at 1:17 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Dec 30, 2020 at 5:09 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > OSS-Fuzz found a heap buffer overflow (out-of-bound reads) when the CIL
> > compiler tries to report a recursive blockinherit with an optional
> > block:
> >
> >     $ echo '(block b (optional o (blockinherit b)))' > tmp.cil
> >     $ secilc tmp.cil
> >     Segmentation fault (core dumped)
> >
> > This is because cil_print_recursive_blockinherit() assumes that all
> > nodes are either CIL_BLOCK or CIL_BLOCKINHERIT. Add support for other
> > block kinds, using cil_node_to_string() to show them.
> >
> > Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28462
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
> > ---
> >  libsepol/cil/src/cil_resolve_ast.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> > index f6deb1002fbd..ecd05dfa5dab 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -2343,11 +2343,13 @@ void cil_print_recursive_blockinherit(struct cil_tree_node *bi_node, struct cil_
> >         for (curr = bi_node; curr != terminating_node; curr = curr->parent) {
> >                 if (curr->flavor == CIL_BLOCK) {
> >                         cil_list_prepend(trace, CIL_NODE, curr);
> > -               } else {
> > +               } else if (curr->flavor == CIL_BLOCKINHERIT) {
> >                         if (curr != bi_node) {
> >                                 cil_list_prepend(trace, CIL_NODE, NODE(((struct cil_blockinherit *)curr->data)->block));
> >                         }
> >                         cil_list_prepend(trace, CIL_NODE, curr);
> > +               } else {
> > +                       cil_list_prepend(trace, CIL_NODE, curr);
> >                 }
> >         }
> >         cil_list_prepend(trace, CIL_NODE, terminating_node);
> > @@ -2356,8 +2358,12 @@ void cil_print_recursive_blockinherit(struct cil_tree_node *bi_node, struct cil_
> >                 curr = item->data;
> >                 if (curr->flavor == CIL_BLOCK) {
> >                         cil_tree_log(curr, CIL_ERR, "block %s", DATUM(curr->data)->name);
> > -               } else {
> > +               } else if (curr->flavor == CIL_BLOCKINHERIT) {
> >                         cil_tree_log(curr, CIL_ERR, "blockinherit %s", ((struct cil_blockinherit *)curr->data)->block_str);
> > +               } else if (curr->flavor == CIL_OPTIONAL) {
> > +                       cil_tree_log(curr, CIL_ERR, "optional %s", DATUM(curr->data)->name);
> > +               } else {
> > +                       cil_tree_log(curr, CIL_ERR, "%s", cil_node_to_string(curr));
> >                 }
> >         }
> >
> > --
> > 2.29.2
> >
