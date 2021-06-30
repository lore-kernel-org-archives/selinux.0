Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9CDC11F65
	for <selinux@archiver.kernel.org>; Wed, 30 Jun 2021 19:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F93B61461
	for <selinux@archiver.kernel.org>; Wed, 30 Jun 2021 19:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhF3TsA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Jun 2021 15:48:00 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:41728 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhF3TsA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Jun 2021 15:48:00 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3FC5E56128D
        for <selinux@vger.kernel.org>; Wed, 30 Jun 2021 21:45:29 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id m17so2099201plx.7
        for <selinux@vger.kernel.org>; Wed, 30 Jun 2021 12:45:29 -0700 (PDT)
X-Gm-Message-State: AOAM530Bc84OBjrC0NmDalJDVo/JmrN3bUlBNH1Ux0TOEtaLFt47vsN5
        +J/WvbAHRRsgARm1Wkko9DQob051YR8f2G/cZrA=
X-Google-Smtp-Source: ABdhPJzSPhZVswdqCzkRk8oEmum9wE+8BJCG/a2JvByRD8BC8+wHhB0F90EDjyqb2zYCBXDaWU4Zlzi51OXeLeXY2DY=
X-Received: by 2002:a17:90a:102:: with SMTP id b2mr41176495pjb.156.1625082327958;
 Wed, 30 Jun 2021 12:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210624195815.148698-1-jwcart2@gmail.com> <CAJfZ7==-2aToEuU4ZyD6qpCwN+JQCVkAm=3KLf4dJUM_yNFnFA@mail.gmail.com>
In-Reply-To: <CAJfZ7==-2aToEuU4ZyD6qpCwN+JQCVkAm=3KLf4dJUM_yNFnFA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 30 Jun 2021 21:45:17 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==bjNsRTqgGwWeXWi1v7QCoBPkOpPiyW4-agJMVsdxY3w@mail.gmail.com>
Message-ID: <CAJfZ7==bjNsRTqgGwWeXWi1v7QCoBPkOpPiyW4-agJMVsdxY3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/cil: Add function to determine if a subtree
 has a declaration
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jun 30 21:45:29 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jun 26, 2021 at 2:33 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Jun 24, 2021 at 9:58 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Create the function cil_tree_subtree_has_decl() that returns CIL_TRUE
> > if the subtree has a declaration in it and CIL_FALSE otherwise.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> For these 2 patches:
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

I applied them.

Thanks!
Nicolas

> > ---
> >  libsepol/cil/src/cil_tree.c | 16 ++++++++++++++++
> >  libsepol/cil/src/cil_tree.h |  2 ++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> > index 067268eb..4cf8dcc8 100644
> > --- a/libsepol/cil/src/cil_tree.c
> > +++ b/libsepol/cil/src/cil_tree.c
> > @@ -136,6 +136,22 @@ __attribute__((format (printf, 3, 4))) void cil_tree_log(struct cil_tree_node *n
> >         cil_log(lvl,"\n");
> >  }
> >
> > +int cil_tree_subtree_has_decl(struct cil_tree_node *node)
> > +{
> > +       while (node) {
> > +               if (node->flavor >= CIL_MIN_DECLARATIVE) {
> > +                       return CIL_TRUE;
> > +               }
> > +               if (node->cl_head != NULL) {
> > +                       if (cil_tree_subtree_has_decl(node->cl_head))
> > +                               return CIL_TRUE;
> > +               }
> > +               node = node->next;
> > +       }
> > +
> > +       return CIL_FALSE;
> > +}
> > +
> >  int cil_tree_init(struct cil_tree **tree)
> >  {
> >         struct cil_tree *new_tree = cil_malloc(sizeof(*new_tree));
> > diff --git a/libsepol/cil/src/cil_tree.h b/libsepol/cil/src/cil_tree.h
> > index bac9f1e4..f4d22071 100644
> > --- a/libsepol/cil/src/cil_tree.h
> > +++ b/libsepol/cil/src/cil_tree.h
> > @@ -54,6 +54,8 @@ struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **
> >  char *cil_tree_get_cil_path(struct cil_tree_node *node);
> >  __attribute__((format (printf, 3, 4))) void cil_tree_log(struct cil_tree_node *node, enum cil_log_level lvl, const char* msg, ...);
> >
> > +int cil_tree_subtree_has_decl(struct cil_tree_node *node);
> > +
> >  int cil_tree_init(struct cil_tree **tree);
> >  void cil_tree_destroy(struct cil_tree **tree);
> >  void cil_tree_subtree_destroy(struct cil_tree_node *node);
> > --
> > 2.26.3
> >

