Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2798ECAAD2
	for <selinux@archiver.kernel.org>; Thu,  1 Sep 2022 19:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiIAT6a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Sep 2022 15:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiIAT6X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Sep 2022 15:58:23 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DB79BB6C
        for <selinux@vger.kernel.org>; Thu,  1 Sep 2022 12:57:57 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h14so27639ilh.10
        for <selinux@vger.kernel.org>; Thu, 01 Sep 2022 12:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=z+IUfu4izzWk+XqHsYZYE9KDHXfnEtCSLsGw1JOeM1w=;
        b=juSn2GhqyIOmRjLs44fzZMNrjOQVMtJ976cawo7DimBdiifKNKLu5dXJOXTF1BZAh5
         ukWx8FthalDMOgOO6+HQU76KFDMCU6mHFIzrcGVLtNTH7F5YR9KsDX6J7qZDWfx6UCYB
         5d1hBuXX9XRBm466XQd9hkPgxjttopd8r5kHlovfDEStqcLUZIvCO+WzzvsJqej3jMIV
         ROLJHb2wqCqllR/8Gve59D0KsxwJqyGY5Alv2KIjsuWwbjGK/MLVDCBTV1kByZu3aUOp
         d58cqaT71EPz3y0CCReQSVrSAw6wkOZBsjTsIIWi9Bp5dBesl3T66ydwnv2dn4Sumb9R
         Y0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=z+IUfu4izzWk+XqHsYZYE9KDHXfnEtCSLsGw1JOeM1w=;
        b=Arvm+ydsEWbKdodzZLol8FfhgZLEc5oZOwE8sqO3j1EgYGJD9fqQXVyFDng+mLbALW
         +6Xo7GhWUD2/xPJ6Q+xAmUZw/fzAx0xtaQ7lLfl/nBvRChzVDOUOornx1vpTVCkltaRK
         HsCNrxXLs48qAKkPXWk8deiCp3kg9PzmtFwYM56+l54k5kuJEejAeEBH4iN5mU5oYWAg
         Vrl1GYxtbHw8rVs8VgoTV1dXr/xPAIFZ4tHgK6jL2d89m907fcyImquZLlKY60hXhV33
         e13sDHhYO0CBUdKTAiqwRm04YiDsA5+Yebc519xhYVT52ATAmiOqdjbzjpXaF6bBLTNi
         Q1Pg==
X-Gm-Message-State: ACgBeo3QFdKt0Cml/3CTXeoMEFwN3xUr/PnvRc5jZcqo0n8gre9vkDQJ
        wxH2I/n7AggnfXpJmuBO6J0VtSxftcFwLCPP2fk=
X-Google-Smtp-Source: AA6agR7VC/FF9GCaibRuQtZbRurR2E+2g90cOJKHa15o/gF4FHR21U3pBGB7mcf75kpTZaIcc893N4ZBE5wcrpN2kmo=
X-Received: by 2002:a05:6e02:1789:b0:2ec:ab4f:4b0f with SMTP id
 y9-20020a056e02178900b002ecab4f4b0fmr3096981ilu.34.1662062275918; Thu, 01 Sep
 2022 12:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220829122840.qbxef3urreybaqxm@jmarcin-t14s-01> <CAP+JOzRV0++Dnut+HMSgrOYU0OJ81_qPunTsXdL0aKmMsRVNMw@mail.gmail.com>
In-Reply-To: <CAP+JOzRV0++Dnut+HMSgrOYU0OJ81_qPunTsXdL0aKmMsRVNMw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 1 Sep 2022 15:57:45 -0400
Message-ID: <CAP+JOzTcU4ZVg-+AYvTp_NQd-7zR1EY6xhH_pxbDpL-epPfQmQ@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: avoid passing NULL pointer to memset()
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 29, 2022 at 2:50 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Aug 29, 2022 at 8:49 AM Juraj Marcin <juraj@jurajmarcin.com> wrote:
> >
> > Function `class_perm_node_init()` is called with `dest_perms` before it
> > is checked that its allocation succeeded. If the allocation fails, then
> > a NULL pointer is passed to `memset()` inside the
> > `class_perm_node_init()` function.
> >
> > Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim


> > ---
> >  checkpolicy/policy_define.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index f3b48870..54bb304b 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -2371,11 +2371,12 @@ static int avrule_cpy(avrule_t *dest, const avrule_t *src)
> >         src_perms = src->perms;
> >         while (src_perms) {
> >                 dest_perms = (class_perm_node_t *) calloc(1, sizeof(class_perm_node_t));
> > -               class_perm_node_init(dest_perms);
> >                 if (!dest_perms) {
> >                         yyerror("out of memory");
> >                         return -1;
> >                 }
> > +               class_perm_node_init(dest_perms);
> > +
> >                 if (!dest->perms)
> >                         dest->perms = dest_perms;
> >                 else
> > --
> > 2.37.1
> >
