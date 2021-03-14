Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5935C433DB
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 19:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A79164D9C
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 19:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhCNTor (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 14 Mar 2021 15:44:47 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:40469 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbhCNTo0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 14 Mar 2021 15:44:26 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9F734564671
        for <selinux@vger.kernel.org>; Sun, 14 Mar 2021 20:44:23 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id s21so7653000pjq.1
        for <selinux@vger.kernel.org>; Sun, 14 Mar 2021 12:44:23 -0700 (PDT)
X-Gm-Message-State: AOAM532IVyjFFxCNKsoEi8yLs6gPOR9F7jEW2pwZ7Qff60H5OlH/XyYX
        sbLjJz22nkILSkh8JVxLs0mvCroBqyR9F48/khM=
X-Google-Smtp-Source: ABdhPJxYmtYlDBCfxJL/Zv2lnkWrEYhFaq9TFaB14I5OHDQGxrFu7b1GaHvvawl/iqa7MShL3FatFKcNlpwy2T7f0cg=
X-Received: by 2002:a17:90a:4d81:: with SMTP id m1mr1172273pjh.143.1615751062257;
 Sun, 14 Mar 2021 12:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210309213640.120117-1-jwcart2@gmail.com>
In-Reply-To: <20210309213640.120117-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 14 Mar 2021 20:44:11 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nXt-xmT040Am4CUTqNMVd4vZYb657L6eyYOpt2WzsQ8Q@mail.gmail.com>
Message-ID: <CAJfZ7=nXt-xmT040Am4CUTqNMVd4vZYb657L6eyYOpt2WzsQ8Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Properly handle types associated to role attributes
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar 14 20:44:24 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 9, 2021 at 10:37 PM James Carter <jwcart2@gmail.com> wrote:
>
> Types associated to role attributes in optional blocks are not
> associated with the roles that have that attribute. The problem
> is that role_fix_callback is called before the avrule_decls are
> walked.
>
> Example/
>   class CLASS1
>   sid kernel
>   class CLASS1 { PERM1 }
>   type TYPE1;
>   type TYPE1A;
>   allow TYPE1 self : CLASS1 PERM1;
>   attribute_role ROLE_ATTR1A;
>   role ROLE1;
>   role ROLE1A;
>   roleattribute ROLE1A ROLE_ATTR1A;
>   role ROLE1 types TYPE1;
>   optional {
>     require {
>       class CLASS1 PERM1;
>     }
>     role ROLE_ATTR1A types TYPE1A;
>   }
>   user USER1 roles ROLE1;
>   sid kernel USER1:ROLE1:TYPE1
>
> In this example ROLE1A will not have TYPE1A associated to it.
>
> Call role_fix_callback() after the avrule_decls are walked.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

> ---
>  libsepol/src/expand.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index eac7e450..1ee3e48f 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -3017,10 +3017,6 @@ int expand_module(sepol_handle_t * handle,
>         if (hashtab_map(state.base->p_roles.table,
>                         role_bounds_copy_callback, &state))
>                 goto cleanup;
> -       /* escalate the type_set_t in a role attribute to all regular roles
> -        * that belongs to it. */
> -       if (hashtab_map(state.base->p_roles.table, role_fix_callback, &state))
> -               goto cleanup;
>
>         /* copy MLS's sensitivity level and categories - this needs to be done
>          * before expanding users (they need to be indexed too) */
> @@ -3086,6 +3082,11 @@ int expand_module(sepol_handle_t * handle,
>                 goto cleanup;
>         }
>
> +       /* escalate the type_set_t in a role attribute to all regular roles
> +        * that belongs to it. */
> +       if (hashtab_map(state.base->p_roles.table, role_fix_callback, &state))
> +               goto cleanup;
> +
>         if (copy_and_expand_avrule_block(&state) < 0) {
>                 ERR(handle, "Error during expand");
>                 goto cleanup;
> --
> 2.26.2
>

