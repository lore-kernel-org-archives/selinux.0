Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EECC49EA5
	for <selinux@archiver.kernel.org>; Sat, 26 Jun 2021 12:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B080A61C2C
	for <selinux@archiver.kernel.org>; Sat, 26 Jun 2021 12:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhFZMgC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 26 Jun 2021 08:36:02 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:58030 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZMgB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 26 Jun 2021 08:36:01 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id CF67E5646C4
        for <selinux@vger.kernel.org>; Sat, 26 Jun 2021 14:33:36 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so9624868pjs.2
        for <selinux@vger.kernel.org>; Sat, 26 Jun 2021 05:33:36 -0700 (PDT)
X-Gm-Message-State: AOAM532RAP0Nrfuru7q3y1N++41N2R79fwpybWOjfox4kknZ/dtlbZNM
        kEu2NTWugLIngKwQYP0XbX2Fot+M/I5YEdqJhu0=
X-Google-Smtp-Source: ABdhPJwiex6WrsYybXTZ5A7SDLzHBFp2lFwhgyxQ2SlNzTCAuryhPg/HSym2iUk2fblQMeAEnAG0FY+6xcU8YZSQA3s=
X-Received: by 2002:a17:902:c94e:b029:120:61d3:4d78 with SMTP id
 i14-20020a170902c94eb029012061d34d78mr13631465pla.61.1624710815422; Sat, 26
 Jun 2021 05:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210624195815.148698-1-jwcart2@gmail.com>
In-Reply-To: <20210624195815.148698-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 26 Jun 2021 14:33:24 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==-2aToEuU4ZyD6qpCwN+JQCVkAm=3KLf4dJUM_yNFnFA@mail.gmail.com>
Message-ID: <CAJfZ7==-2aToEuU4ZyD6qpCwN+JQCVkAm=3KLf4dJUM_yNFnFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/cil: Add function to determine if a subtree
 has a declaration
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jun 26 14:33:37 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 24, 2021 at 9:58 PM James Carter <jwcart2@gmail.com> wrote:
>
> Create the function cil_tree_subtree_has_decl() that returns CIL_TRUE
> if the subtree has a declaration in it and CIL_FALSE otherwise.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

For these 2 patches:

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!

> ---
>  libsepol/cil/src/cil_tree.c | 16 ++++++++++++++++
>  libsepol/cil/src/cil_tree.h |  2 ++
>  2 files changed, 18 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> index 067268eb..4cf8dcc8 100644
> --- a/libsepol/cil/src/cil_tree.c
> +++ b/libsepol/cil/src/cil_tree.c
> @@ -136,6 +136,22 @@ __attribute__((format (printf, 3, 4))) void cil_tree_log(struct cil_tree_node *n
>         cil_log(lvl,"\n");
>  }
>
> +int cil_tree_subtree_has_decl(struct cil_tree_node *node)
> +{
> +       while (node) {
> +               if (node->flavor >= CIL_MIN_DECLARATIVE) {
> +                       return CIL_TRUE;
> +               }
> +               if (node->cl_head != NULL) {
> +                       if (cil_tree_subtree_has_decl(node->cl_head))
> +                               return CIL_TRUE;
> +               }
> +               node = node->next;
> +       }
> +
> +       return CIL_FALSE;
> +}
> +
>  int cil_tree_init(struct cil_tree **tree)
>  {
>         struct cil_tree *new_tree = cil_malloc(sizeof(*new_tree));
> diff --git a/libsepol/cil/src/cil_tree.h b/libsepol/cil/src/cil_tree.h
> index bac9f1e4..f4d22071 100644
> --- a/libsepol/cil/src/cil_tree.h
> +++ b/libsepol/cil/src/cil_tree.h
> @@ -54,6 +54,8 @@ struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **
>  char *cil_tree_get_cil_path(struct cil_tree_node *node);
>  __attribute__((format (printf, 3, 4))) void cil_tree_log(struct cil_tree_node *node, enum cil_log_level lvl, const char* msg, ...);
>
> +int cil_tree_subtree_has_decl(struct cil_tree_node *node);
> +
>  int cil_tree_init(struct cil_tree **tree);
>  void cil_tree_destroy(struct cil_tree **tree);
>  void cil_tree_subtree_destroy(struct cil_tree_node *node);
> --
> 2.26.3
>

