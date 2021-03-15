Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CC1C433E0
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1025D64F26
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhCOVIs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:08:48 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:33225 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCOVIb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Mar 2021 17:08:31 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 15A1356549C
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 22:08:30 +0100 (CET)
Received: by mail-pg1-f172.google.com with SMTP id l2so21218189pgb.1
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:08:30 -0700 (PDT)
X-Gm-Message-State: AOAM533ysC7Q3H50NqJrwBLeGyunhZ3GJIfwbW7OFS6f6MzMyD1PjGKa
        TW4JwfExd4nGQ1TgRcKBQDQKND0WE+qjzIeHtRs=
X-Google-Smtp-Source: ABdhPJxz28dk13LcHOznwyPObRf23aqD68dlEfUHx6GcPTVDOA2w6hHmr3cmynHVDjPKqWjc6EhQxhlZ8VYWBwU24gY=
X-Received: by 2002:a63:905:: with SMTP id 5mr815383pgj.337.1615842508659;
 Mon, 15 Mar 2021 14:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210311165644.221142-1-jwcart2@gmail.com> <CAJfZ7=mKb43ZaSavhSydXM1sMh3J-8=pVTt8j4e68GC-JjSfkQ@mail.gmail.com>
In-Reply-To: <CAJfZ7=mKb43ZaSavhSydXM1sMh3J-8=pVTt8j4e68GC-JjSfkQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 15 Mar 2021 22:08:17 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=m4Wk9PH_41L6uL6aszO-_W3dA=p4jW=Ew6gee142o6bw@mail.gmail.com>
Message-ID: <CAJfZ7=m4Wk9PH_41L6uL6aszO-_W3dA=p4jW=Ew6gee142o6bw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Remove unnecessary copying of declarations from link.c
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Mar 15 22:08:30 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 14, 2021 at 8:54 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Mar 11, 2021 at 5:57 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > At one point link_modules() might have needed this initial copying,
> > but now it serves no purpose, so remove it.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged.

Thanks!
Nicolas

> > ---
> >  libsepol/src/link.c | 30 ------------------------------
> >  1 file changed, 30 deletions(-)
> >
> > diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> > index 83bbc8a5..bdc1fcbf 100644
> > --- a/libsepol/src/link.c
> > +++ b/libsepol/src/link.c
> > @@ -2573,36 +2573,6 @@ int link_modules(sepol_handle_t * handle,
> >                 goto cleanup;
> >         }
> >
> > -       /* copy all types, declared and required */
> > -       for (i = 0; i < len; i++) {
> > -               state.cur = modules[i];
> > -               state.cur_mod_name = modules[i]->policy->name;
> > -               ret =
> > -                   hashtab_map(modules[i]->policy->p_types.table,
> > -                               type_copy_callback, &state);
> > -               if (ret) {
> > -                       retval = ret;
> > -                       goto cleanup;
> > -               }
> > -       }
> > -
> > -       /* then copy everything else, including aliases, and fixup attributes */
> > -       for (i = 0; i < len; i++) {
> > -               state.cur = modules[i];
> > -               state.cur_mod_name = modules[i]->policy->name;
> > -               ret =
> > -                   copy_identifiers(&state, modules[i]->policy->symtab, NULL);
> > -               if (ret) {
> > -                       retval = ret;
> > -                       goto cleanup;
> > -               }
> > -       }
> > -
> > -       if (policydb_index_others(state.handle, state.base, 0)) {
> > -               ERR(state.handle, "Error while indexing others");
> > -               goto cleanup;
> > -       }
> > -
> >         /* copy and remap the module's data over to base */
> >         for (i = 0; i < len; i++) {
> >                 state.cur = modules[i];
> > --
> > 2.26.2
> >

