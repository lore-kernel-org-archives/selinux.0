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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE499C433B4
	for <selinux@archiver.kernel.org>; Tue,  4 May 2021 20:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71409613CF
	for <selinux@archiver.kernel.org>; Tue,  4 May 2021 20:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhEDUHe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 May 2021 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhEDUHb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 May 2021 16:07:31 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5012EC061761
        for <selinux@vger.kernel.org>; Tue,  4 May 2021 13:06:33 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso2648944otg.9
        for <selinux@vger.kernel.org>; Tue, 04 May 2021 13:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJlnqiFijnV6MGWFkXCqIygBlu3DhLFVPjRYwUWJbpw=;
        b=UugloqK/OwXmdArFu8cscGQwPvUUsmzWA4MIixQrSyREHWUjvTQm1AAcR9dLvOcmN6
         Fu8v68MaB6Se3r2WFBJEIvAZo8Fxaf8+v5gPZ78GTGil94Pm9sBrik8wvgOBthhbXQ2F
         SeCdyZn31j7MR11EIZiZyoKAojy76xOW8H8Qn3KnTTqhQF6hgCRAI2QS/n4JUr2UEW0C
         e5DsuV8ydrScCkYQBEDPHDUHv2cj5UvwYHiYm3DAqNpYZRpO2Fp6AzUvTLOsNdNJRKrV
         S71NploWrb/KILwKw3bEWRY7UYF8Cxt1k281/8DeRiVOmMQggDDh/MdwjsCoCgGG+dwE
         ox8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJlnqiFijnV6MGWFkXCqIygBlu3DhLFVPjRYwUWJbpw=;
        b=dy+4c+/AUAjvE8jG6Gen4uTzTD0rdEcY9VujAn5uBpsr80A2KubJRlJEzZDjO5KK+c
         N+9KvH3nAlfEolzB+cyTXvz6IwU6gBXYMnICz6Znpj0s65pCPl26+5bk4P6Ogy2bpvsD
         qWpMYBYCJ2o+v3lNZnu6qdpF0LIFQSn1m0h9hLhRCFvjb+LRH+j8sj21LrOAMEiC4/1E
         hG0T126lpXU+NF59b54FjTSW+Mb64llh/bkXyLQj6k2xMaoq5nH8okR0bPGMl/VkbMtz
         maEu0REpwqqlaB9+KFwlbZy69F5DN+6QA7mTdjUJypR4XnsOcaFuqtiCtfrHYdqhTEG0
         m8xg==
X-Gm-Message-State: AOAM532asG+P0CRSjaju8lGHQ/CjsZw7yQ5cSmj/quAlpE4C1vK4XLJM
        FVt1kzluG/xfFJyHhrzfjmadUwLid3yB/A6uKUH7ps5af6s=
X-Google-Smtp-Source: ABdhPJyoq3wi93HMjXjOK9DkFPLoyGbfQt8DwcLllNCtPE/jy7zzW+Ke50rbHWaktGj5JyF6H1s8J+bvGjuvVuqZbBY=
X-Received: by 2002:a9d:614b:: with SMTP id c11mr9820939otk.59.1620158792750;
 Tue, 04 May 2021 13:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210427204333.208637-1-jwcart2@gmail.com> <CAJfZ7==yNja-v36=0bdq2z4u6NsjNyQ4E-Gp_RUL=RUfHEoNPg@mail.gmail.com>
In-Reply-To: <CAJfZ7==yNja-v36=0bdq2z4u6NsjNyQ4E-Gp_RUL=RUfHEoNPg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 4 May 2021 16:06:21 -0400
Message-ID: <CAP+JOzSaAxF2387msoUvkiosR=GQm-0ifYgsaS56ufKxqeMZPw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Properly reset an anonymous classperm set
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 1, 2021 at 10:34 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Apr 27, 2021 at 10:43 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > In struct cil_classperms_set, the "set" field is a pointer to a
> > struct cil_classpermission. Normally the classpermission is created
> > in a classpermissionset rule with a name declared in a
> > classpermission rule and stored in a symbol table. Commit c49a8ea0
> > ("libsepol/cil: cil_reset_classperms_set() should not reset
> > classpermission") fixed the resetting of classperms sets by setting
> > the "set" field to NULL rather than resetting the classpermission
> > that it pointed to.
> >
> > But this fix mixed the special case where an anonymous classperm
> > set is passed as an argument to a call. In this case the
> > classpermission is not named and not stored in a symtab, it is
> > created just for the classperms set and its classperms list needs
> > to be reset.
> >
> > Reset the classperms list if the classperms set is anonymous (which
> > is when the datum name is NULL).
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

This has been applied.
Jim

> Thanks!
> Nicolas
>
> > ---
> >  libsepol/cil/src/cil_reset_ast.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
> > index 76405aba..d24d4f81 100644
> > --- a/libsepol/cil/src/cil_reset_ast.c
> > +++ b/libsepol/cil/src/cil_reset_ast.c
> > @@ -60,10 +60,14 @@ static void cil_reset_classpermission(struct cil_classpermission *cp)
> >
> >  static void cil_reset_classperms_set(struct cil_classperms_set *cp_set)
> >  {
> > -       if (cp_set == NULL) {
> > +       if (cp_set == NULL || cp_set->set == NULL) {
> >                 return;
> >         }
> >
> > +       if (cp_set->set->datum.name == NULL) {
> > +               cil_reset_classperms_list(cp_set->set->classperms);
> > +       }
> > +
> >         cp_set->set = NULL;
> >  }
> >
> > --
> > 2.26.3
> >
>
