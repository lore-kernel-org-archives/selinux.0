Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F76C07E95
	for <selinux@archiver.kernel.org>; Wed,  7 Jul 2021 16:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726C761CC9
	for <selinux@archiver.kernel.org>; Wed,  7 Jul 2021 16:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhGGQio (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Jul 2021 12:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhGGQio (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Jul 2021 12:38:44 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579DFC061574
        for <selinux@vger.kernel.org>; Wed,  7 Jul 2021 09:36:03 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so2829014oti.2
        for <selinux@vger.kernel.org>; Wed, 07 Jul 2021 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyJ4nc4MuZI4fH4lnK51lM5qWE/7ASmU5xJpSBlw088=;
        b=bcPbY0/xZ8TBdHJFi6XkGkeZchUX09e9PjC5i07XH13n7uikzGVWpNz7xvldfZDfpn
         P8D6d12US4dctvnMxvbhjDbZ7wzQSQTDav1GrMA2Xby/q4kdE9rXhxyHs72ldiyTik/g
         5T38SE5kt/CnVsLx5TawdBl7APkKbyxzVOqwso/fct1OvtKSon1utHqxLgcOcCql0H6d
         kMvPHPccUUxD5eGtSvM0YCjos3PTBzJCfLCOl1x4wPwvcnJ7s2DmO4nGGHWi/+c5Pt7H
         AUWbaDgBBFehPw5vfSLXmBZdngS/NTF1pWWEyNOq6LbLB+wIWxLWxlzxMKzcHFLZVmri
         BGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyJ4nc4MuZI4fH4lnK51lM5qWE/7ASmU5xJpSBlw088=;
        b=eyeAoiKFF99r5RhCGASQA+NY9Esgxg8mLPdIJb7BCw40pujHdi0v4z12goeHeOW1kX
         sqFMdD0nG2I7l1BoKCNvWb9nN0JV8ymxLUJm81BZApcMBhUdYRLc/9zBD9o2RFmMShdZ
         9GEkG6I1QXsUSpUzUfteB0hBxJuZIvHYVYBNnB0gr5I4V8J72gfqphMeSqMcgBxbUYhm
         0i+bux0Xrru7XybhwfCAb3e50JVwPk+mj2AVOxDZ4Q7KVgiAj4iieuqlDmV0gHH25UPM
         23TSdUSFdBp7IHocH76SDGcWWvUofg+biWe6vKG8bTkTedCQapM/hLcJVO6gOi6bVJqt
         WyiA==
X-Gm-Message-State: AOAM53255pAKWIebqV6uwsH7ewWMET+N/0XyrIkLznY4Bdbw+BqI5LDA
        xubN1MCcfrFAIdKv4mcSy7M8C1BhyQXwzhjSxAQ=
X-Google-Smtp-Source: ABdhPJxctGxG/xK0UoyQ2kdb7Yll7+fIj1lVh4dibZsgUHwQRI/dNkQ9r96QcENLe3wCuPmNy+hubYquNewr2nHDRvU=
X-Received: by 2002:a05:6830:1058:: with SMTP id b24mr19891802otp.295.1625675762765;
 Wed, 07 Jul 2021 09:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210703143122.1441578-1-nicolas.iooss@m4x.org> <CAP+JOzQN3gcViy-3JRyVmLT6G6LvigerT8Fm=3Ukxn=BHzaTUw@mail.gmail.com>
In-Reply-To: <CAP+JOzQN3gcViy-3JRyVmLT6G6LvigerT8Fm=3Ukxn=BHzaTUw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 7 Jul 2021 12:35:51 -0400
Message-ID: <CAP+JOzScxNSWrAwXfO+_dRCWN2yhvF5n3GxvdeBq2o_Ofpdftw@mail.gmail.com>
Subject: Re: [PATCH 1/6] libsepol: silence -Wextra-semi-stmt warning
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 6, 2021 at 11:40 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Sat, Jul 3, 2021 at 10:32 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > On Ubuntu 20.04, when building with clang -Werror -Wextra-semi-stmt
> > (which is not the default build configuration), the compiler reports:
> >
> >   ../cil/src/cil_binary.c:4293:22: error: empty expression statement
> >   has no effect; remove unnecessary ';' to silence this warning
> >   [-Werror,-Wextra-semi-stmt]
> >           mix(k->target_class);
> >                               ^
> >   ../cil/src/cil_binary.c:4294:21: error: empty expression statement
> >   has no effect; remove unnecessary ';' to silence this warning
> >   [-Werror,-Wextra-semi-stmt]
> >           mix(k->target_type);
> >                              ^
> >   ../cil/src/cil_binary.c:4295:21: error: empty expression statement
> >   has no effect; remove unnecessary ';' to silence this warning
> >   [-Werror,-Wextra-semi-stmt]
> >           mix(k->source_type);
> >                              ^
> >   ../cil/src/cil_binary.c:4296:19: error: empty expression statement
> >   has no effect; remove unnecessary ';' to silence this warning
> >   [-Werror,-Wextra-semi-stmt]
> >           mix(k->specified);
> >                            ^
> >
> > Use a do { ... } while (0) construction to silence this warning.
> >
> > Moreover the same warning appears when using two semicolons to end a
> > statement. Remove such occurrences, like what was already done in commit
> > 811185648af2 ("libsepol: drop repeated semicolons").
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> For all six patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

All six patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_binary.c      |  4 ++--
> >  libsepol/cil/src/cil_resolve_ast.c |  2 +-
> >  libsepol/src/avtab.c               |  4 ++--
> >  libsepol/tests/libsepol-tests.c    | 18 +++++++++++-------
> >  4 files changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> > index 54d13f2f3945..41105c122bc3 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -4277,7 +4277,7 @@ static unsigned int avrulex_hash(__attribute__((unused)) hashtab_t h, const_hash
> >
> >         uint32_t hash = 0;
> >
> > -#define mix(input) { \
> > +#define mix(input) do { \
> >         uint32_t v = input; \
> >         v *= c1; \
> >         v = (v << r1) | (v >> (32 - r1)); \
> > @@ -4285,7 +4285,7 @@ static unsigned int avrulex_hash(__attribute__((unused)) hashtab_t h, const_hash
> >         hash ^= v; \
> >         hash = (hash << r2) | (hash >> (32 - r2)); \
> >         hash = hash * m + n; \
> > -}
> > +} while (0)
> >
> >         mix(k->target_class);
> >         mix(k->target_type);
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> > index 32ea64e39b21..9a02e3867659 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -2825,7 +2825,7 @@ static int cil_build_call_args(struct cil_tree_node *call_node, struct cil_call
> >                         return SEPOL_OK;
> >                 } else {
> >                         cil_tree_log(call_node, CIL_ERR, "Unexpected arguments");
> > -                       return SEPOL_ERR;;
> > +                       return SEPOL_ERR;
> >                 }
> >         }
> >         if (call->args_tree == NULL) {
> > diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> > index 88e9d510f981..5e16a0e9899e 100644
> > --- a/libsepol/src/avtab.c
> > +++ b/libsepol/src/avtab.c
> > @@ -63,7 +63,7 @@ static inline int avtab_hash(struct avtab_key *keyp, uint32_t mask)
> >
> >         uint32_t hash = 0;
> >
> > -#define mix(input) { \
> > +#define mix(input) do { \
> >         uint32_t v = input; \
> >         v *= c1; \
> >         v = (v << r1) | (v >> (32 - r1)); \
> > @@ -71,7 +71,7 @@ static inline int avtab_hash(struct avtab_key *keyp, uint32_t mask)
> >         hash ^= v; \
> >         hash = (hash << r2) | (hash >> (32 - r2)); \
> >         hash = hash * m + n; \
> > -}
> > +} while (0)
> >
> >         mix(keyp->target_class);
> >         mix(keyp->target_type);
> > diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
> > index 544c792d2ab5..dc8fd5ce5f6c 100644
> > --- a/libsepol/tests/libsepol-tests.c
> > +++ b/libsepol/tests/libsepol-tests.c
> > @@ -36,13 +36,17 @@
> >  int mls;
> >
> >  #define DECLARE_SUITE(name) \
> > -       suite = CU_add_suite(#name, name##_test_init, name##_test_cleanup); \
> > -       if (NULL == suite) { \
> > -               CU_cleanup_registry(); \
> > -               return CU_get_error(); } \
> > -       if (name##_add_tests(suite)) { \
> > -               CU_cleanup_registry(); \
> > -               return CU_get_error(); }
> > +       do { \
> > +               suite = CU_add_suite(#name, name##_test_init, name##_test_cleanup); \
> > +               if (NULL == suite) { \
> > +                       CU_cleanup_registry(); \
> > +                       return CU_get_error(); \
> > +               } \
> > +               if (name##_add_tests(suite)) { \
> > +                       CU_cleanup_registry(); \
> > +                       return CU_get_error(); \
> > +               } \
> > +       } while (0)
> >
> >  static void usage(char *progname)
> >  {
> > --
> > 2.32.0
> >
