Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E71C433ED
	for <selinux@archiver.kernel.org>; Sat,  1 May 2021 14:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67906157E
	for <selinux@archiver.kernel.org>; Sat,  1 May 2021 14:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhEAOfa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 May 2021 10:35:30 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:56820 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhEAOf3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 May 2021 10:35:29 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3020A5654C7
        for <selinux@vger.kernel.org>; Sat,  1 May 2021 16:34:38 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id y1so466642plg.11
        for <selinux@vger.kernel.org>; Sat, 01 May 2021 07:34:38 -0700 (PDT)
X-Gm-Message-State: AOAM5314wATf+CVKLwqY33f4CFfP5vs48zJ5J3DnjD8hjw42RrCybetN
        pcCPOVFP9v7MofHTkTFbwHg3XV9pQYuk5ab8/LE=
X-Google-Smtp-Source: ABdhPJxOyCiG0yJkOhx+zbqSxbcnYXnKPLNwnVOXVJO3nldWXvLXCsM/vy9YiqxAixrIXzkAoUTyC9cRlDW2iMbJXQo=
X-Received: by 2002:a17:90b:3558:: with SMTP id lt24mr1456756pjb.156.1619879676856;
 Sat, 01 May 2021 07:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210427204333.208637-1-jwcart2@gmail.com>
In-Reply-To: <20210427204333.208637-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 1 May 2021 16:34:26 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==yNja-v36=0bdq2z4u6NsjNyQ4E-Gp_RUL=RUfHEoNPg@mail.gmail.com>
Message-ID: <CAJfZ7==yNja-v36=0bdq2z4u6NsjNyQ4E-Gp_RUL=RUfHEoNPg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Properly reset an anonymous classperm set
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat May  1 16:34:38 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 27, 2021 at 10:43 PM James Carter <jwcart2@gmail.com> wrote:
>
> In struct cil_classperms_set, the "set" field is a pointer to a
> struct cil_classpermission. Normally the classpermission is created
> in a classpermissionset rule with a name declared in a
> classpermission rule and stored in a symbol table. Commit c49a8ea0
> ("libsepol/cil: cil_reset_classperms_set() should not reset
> classpermission") fixed the resetting of classperms sets by setting
> the "set" field to NULL rather than resetting the classpermission
> that it pointed to.
>
> But this fix mixed the special case where an anonymous classperm
> set is passed as an argument to a call. In this case the
> classpermission is not named and not stored in a symtab, it is
> created just for the classperms set and its classperms list needs
> to be reset.
>
> Reset the classperms list if the classperms set is anonymous (which
> is when the datum name is NULL).
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

> ---
>  libsepol/cil/src/cil_reset_ast.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
> index 76405aba..d24d4f81 100644
> --- a/libsepol/cil/src/cil_reset_ast.c
> +++ b/libsepol/cil/src/cil_reset_ast.c
> @@ -60,10 +60,14 @@ static void cil_reset_classpermission(struct cil_classpermission *cp)
>
>  static void cil_reset_classperms_set(struct cil_classperms_set *cp_set)
>  {
> -       if (cp_set == NULL) {
> +       if (cp_set == NULL || cp_set->set == NULL) {
>                 return;
>         }
>
> +       if (cp_set->set->datum.name == NULL) {
> +               cil_reset_classperms_list(cp_set->set->classperms);
> +       }
> +
>         cp_set->set = NULL;
>  }
>
> --
> 2.26.3
>

