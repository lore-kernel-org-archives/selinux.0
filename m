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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266F8C433DB
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 14:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA3864E00
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 14:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhBPOkx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhBPOj4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Feb 2021 09:39:56 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FABC061574
        for <selinux@vger.kernel.org>; Tue, 16 Feb 2021 06:39:15 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id l3so11448374oii.2
        for <selinux@vger.kernel.org>; Tue, 16 Feb 2021 06:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8ibBjUsyl77xZfmmMMSd7gsx25NFum7NdB5U7u5Pbo=;
        b=CjUd9bqK6BQov8AVGI0iuoPHEJTHbJsbpCyzvEfSeWYwoNa/7BU3oKGNmP8Ms8eJIk
         PVppZAbVvNuJGFo1opQMXRMVi1DF+MjVN7dgNaLOKs3vXL5ZA5J778Tt2c+2thY2ATAU
         2QC1nIUcKcGQsmcuySG8OwsCqSGGxpa5aFDUlGkZFuakPw8NDqMlrDvP9/1dgLJiG/hz
         zqKpabk6KwJ0Xh+jTEfv/ZbvsBYdxr8Bo1Ln9NZIG2NDfoN2Fx7vtPmVX7CPAGBs+wUE
         /y2Q9+d3z6RmF1FrDVIrALKEthWEA9FzTFMgqZ58TJiLjLULsq/NIbmDrSnQEZA86VhK
         lWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8ibBjUsyl77xZfmmMMSd7gsx25NFum7NdB5U7u5Pbo=;
        b=krv1IzFt+qhjcIf8JxZx+TI2Q7vszb3qCc+PbhFp62kmGlSuJfEeSGsms0E0b4Yv4F
         7RdHBaT8qXTwmd88JcYDxEC0/gFZCdjd2ghzSjw6k35riKRBl78/p+VKmtsN1+80QQ8R
         Kzcvw8wEx0X7MRnbdDjUPzDKaiufuw3RtTcSGfPHqODlsM/y93LbovJpJmRompZVUvj2
         4V+I6XP5SQUN0fVmVnWabdd/EeH+X+62ZUeFA7g7nerQpSvoVw6kLxdVN7rftsl5RH+i
         G4cFxF7/oLdQxU1wiPBchBiPPtuftoG7FjNK1FOOMpKnaDpO3ffPGlQFklr55Rw5wtaY
         Cf6A==
X-Gm-Message-State: AOAM531Y59irr6/iJfPEas9lSdRCuhUM54ZKe9gz1h45fqltp6UYLqee
        PGF/Rr769+OYA8s49s2Bc9GG/wPBb706ZiPp7UDwA8HDosAQJw==
X-Google-Smtp-Source: ABdhPJxtO23BtWm45zLvjNMeAYSz8GYSjMnrzdSCpQfN43a5KlioJpiARMW4IvnVMXPY8kEeyNAvCnSInrlfCrHLxNk=
X-Received: by 2002:aca:ecc8:: with SMTP id k191mr2666420oih.16.1613486355324;
 Tue, 16 Feb 2021 06:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20210205094539.388854-1-nicolas.iooss@m4x.org>
 <20210205094539.388854-2-nicolas.iooss@m4x.org> <CAP+JOzQv0QzwL_OYBsaOPgFUGP+Bo1WQJGnJkaG2rN8T-O+s=Q@mail.gmail.com>
In-Reply-To: <CAP+JOzQv0QzwL_OYBsaOPgFUGP+Bo1WQJGnJkaG2rN8T-O+s=Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 16 Feb 2021 09:39:04 -0500
Message-ID: <CAP+JOzQ1tJ+wOjKNSEVfZSqXNZ7DRp-UBJ2z5oZL5=7WF18Y4w@mail.gmail.com>
Subject: Re: [PATCH 2/3] libsepol/cil: be more robust when encountering <src_info>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 5, 2021 at 5:02 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 4:54 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > OSS-Fuzz found a Null-dereference READ in the CIL compiler when trying
> > to compile the following policy:
> >
> >     (<src_info>)
> >
> > In cil_gen_src_info(), parse_current->next is NULL even though the code
> > expects that both parse_current->next and parse_current->next->next
> > exists.
> >
> > Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28457
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> This is an interesting case. All of the <SOMETHING> are generated
> internally. I never even thought about what would happen if they
> actually appeared in the policy. I'll have to think about what the
> best way to handle this is. Your patch works fine, but it might be
> better to check for and reject these in the parser.
>
> Jim
>

Eventually, I would like to reject these in the parser, but this patch is fine.

Acked-by: James Carter <jwcart2@gmail.com>

Applied.
Thanks,
Jim


> > ---
> >  libsepol/cil/src/cil_build_ast.c | 5 +++++
> >  libsepol/cil/src/cil_tree.c      | 2 +-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > index 5094d62e2238..726f46cd478d 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -6070,6 +6070,11 @@ int cil_gen_src_info(struct cil_tree_node *parse_current, struct cil_tree_node *
> >         /* No need to check syntax, because this is auto generated */
> >         struct cil_src_info *info = NULL;
> >
> > +       if (parse_current->next == NULL || parse_current->next->next == NULL) {
> > +               cil_tree_log(parse_current, CIL_ERR, "Bad <src_info>");
> > +               return SEPOL_ERR;
> > +       }
> > +
> >         cil_src_info_init(&info);
> >
> >         info->is_cil = (parse_current->next->data == CIL_KEY_SRC_CIL) ? CIL_TRUE : CIL_FALSE;
> > diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> > index 886412d1b974..3da972e9cf4e 100644
> > --- a/libsepol/cil/src/cil_tree.c
> > +++ b/libsepol/cil/src/cil_tree.c
> > @@ -69,7 +69,7 @@ struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **
> >
> >         while (node) {
> >                 if (node->flavor == CIL_NODE && node->data == NULL) {
> > -                       if (node->cl_head->data == CIL_KEY_SRC_INFO) {
> > +                       if (node->cl_head->data == CIL_KEY_SRC_INFO && node->cl_head->next != NULL && node->cl_head->next->next != NULL) {
> >                                 /* Parse Tree */
> >                                 *path = node->cl_head->next->next->data;
> >                                 *is_cil = (node->cl_head->next->data == CIL_KEY_SRC_CIL);
> > --
> > 2.30.0
> >
