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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F4BC433EF
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 15:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E348260F14
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 15:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344935AbhIGPeI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Sep 2021 11:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhIGPeI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Sep 2021 11:34:08 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FA6C061575
        for <selinux@vger.kernel.org>; Tue,  7 Sep 2021 08:33:02 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso13282149otu.0
        for <selinux@vger.kernel.org>; Tue, 07 Sep 2021 08:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WMuNnscFDv5Us0ma2/HSXKm4MPaNmRjzMxn9n7XRv30=;
        b=V3Al3cfqAxr6SBy1duelBkWLykMpiETYaHYjomIX3X3vflggM7stoSnsPScNR42hUm
         8w4fz1z6TeDXJzaibBQhjJouOGZ62SVQeOHFvr7Db0H6voRh1MK/KG13WehO0M2WWDRE
         HVSmJ+guBPs7ulUmf1XQHHcrzjdRSqC0cwgXOhg9SM0YdE45JdzAFJPApczCKKDTNiDL
         MhHC8ZfsCSgXVuKx0nnBXoC+9p3LmkKNNlfE+85LQuLLi41vXmS3eOa2UgysXvG46j66
         MzYKfbI4dK7gVWE2b2AXKsXShF4x1OZahjR2e6oTiYKRga5ro/LsBPuGR5ITp1Npn2XS
         Io3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMuNnscFDv5Us0ma2/HSXKm4MPaNmRjzMxn9n7XRv30=;
        b=Ub1YhwjD/HtZD5TEqONgZyRuYiJP17J7dx37FUGjXN7/PIcCqDXl3e5s36V6NNOdrx
         4Xx2wFLLxUNbRCHD547NGBufcLO2mdMnKe2SqSDHA2dI7BrpZU13j5Kzt47rcYKD8joh
         9sYTT/VykAhRibXeWagkXIjZkJDWoLWu68gg+d7nao/0LqDY3mnWP2lQZg4FFff0cTYi
         z+BwLjpmNxASb+h1o9Ds6Y1qD1GZ+1joeTpKnlVXKAoYgInF1fHrL/smuuddeAtExCyM
         U9RTSVptrMfrOOP4JfHHsoTIjfaQC6XJe192v19XDIHQNpGHRQ8WxMHKuUpjQZsmOSPR
         uNtQ==
X-Gm-Message-State: AOAM5323kDfOzbd+RLn5sxxOoReaet4/I1uiPUGBFkwJdFGkGzkbZFfb
        HymeakGdOHuUWzF5moSXFihpkM+4doWte1Iv/EX/vYSo
X-Google-Smtp-Source: ABdhPJxxOh6NfTRmcD4gh2XHsV3Nr8uIDY7FX9AN2lK31d3F1gf103n7oiJ3RBDSWNXTB1AZS9hsC/7Rk+PBZOeRWc4=
X-Received: by 2002:a9d:5f85:: with SMTP id g5mr15817894oti.139.1631028781384;
 Tue, 07 Sep 2021 08:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210901204252.635570-1-jwcart2@gmail.com> <CAJfZ7=kr1AxWqEV66kiAA0zkBpQ5mJ+woGL-my8_Szs7T_-LpA@mail.gmail.com>
In-Reply-To: <CAJfZ7=kr1AxWqEV66kiAA0zkBpQ5mJ+woGL-my8_Szs7T_-LpA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 7 Sep 2021 11:32:50 -0400
Message-ID: <CAP+JOzQQ+QpaP9Hag=c45jr-GuyfDXEE30cZxtjHnzDAbuZ1Aw@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] libsepol/cil: Remove redundant syntax checking
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 6, 2021 at 1:54 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Wed, Sep 1, 2021 at 10:42 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > For every call to cil_fill_classperms_list(), the syntax of the
> > whole rule, including the class permissions, has already been
> > checked. There is no reason to check it again. Also, because the
> > class permissions appear in the middle of some rules, like
> > constraints, the syntax array does not end with CIL_SYN_END. This
> > is the only case where the syntax array does not end with CIL_SYN_END.
> > This prevents __cil_verify_syntax() from requiring that the syntax
> > array ends with CIL_SYN_END.
> >
> > Remove the redundant syntax checking in cil_fill_classperms_list().
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> > v2: Same as v1
>
> For these 3 patches:
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

These three patches have been merged.
Jim

> Thanks,
> Nicolas
>
> >
> >  libsepol/cil/src/cil_build_ast.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > index a5afc267..f0bb8c0c 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -736,20 +736,11 @@ int cil_fill_classperms_list(struct cil_tree_node *parse_current, struct cil_lis
> >  {
> >         int rc = SEPOL_ERR;
> >         struct cil_tree_node *curr;
> > -       enum cil_syntax syntax[] = {
> > -               CIL_SYN_STRING | CIL_SYN_LIST,
> > -       };
> > -       int syntax_len = sizeof(syntax)/sizeof(*syntax);
> >
> >         if (parse_current == NULL || cp_list == NULL) {
> >                 goto exit;
> >         }
> >
> > -       rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
> > -       if (rc != SEPOL_OK) {
> > -               goto exit;
> > -       }
> > -
> >         cil_list_init(cp_list, CIL_CLASSPERMS);
> >
> >         curr = parse_current->cl_head;
> > --
> > 2.31.1
> >
>
