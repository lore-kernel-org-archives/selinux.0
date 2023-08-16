Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D040C001B0
	for <selinux@archiver.kernel.org>; Wed, 16 Aug 2023 17:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbjHPRor (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Aug 2023 13:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345101AbjHPRoT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Aug 2023 13:44:19 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9A51980
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 10:44:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso104455771fa.0
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 10:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692207855; x=1692812655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkciobGAYXES4EumamNsweGFd6UXNW+vgJiKoW0iCWY=;
        b=ELxiptrmRtxUkuZJ4pYSrcPV60KHDTTN6W93Moplff8w3vtSC7oOXQtVd5G952IxDx
         UufYXGX8KBxxASplozDasvSfYa0TdfTQloVpODhHqiVW3SUe16okhNA4j8omDStcb14w
         Awked0A+4bESva7oiQwwEtMD/1O5kxSCfh7V6K3CELy3C7mHzgpUoFp4R7s7ShPxKnop
         zbLsSPvEOZV9K1S+jvlp5npaueQuHQWWviB5rI1gx0H9YNpKdJDav6IgFRDMUChvUNOG
         LbCXOlCPDYdBb+hlwMVScYI9dFzt0MceiuBAY/dNesd7U+SluDfsBRQbHlQt2R74meBy
         aLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692207855; x=1692812655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkciobGAYXES4EumamNsweGFd6UXNW+vgJiKoW0iCWY=;
        b=lHJu/CoJENbK7ZDUcpFSTJwMeSmLfzWZxp/M6uvFBP4SdAnEQEwf69rM1R05QigGbu
         hD9Hzcg3OjGICxkLFnBk55JfRrlAoFPS/x2sghBVlO4tFHoI2JWIGeLUC/iHQTUE0KPX
         m+pChavkssgtIEmKDZNmzFDYiIJ3/BXtZwDwVP0mIbQ+9HZmYsGcMgJ/eZC4G1dVfwfT
         ONhFLn7dIanWmErfl3m3wssUk6b+34Qv2dkInqJ2hdRhYJPwraYd0uqWVuMdXO1dyVke
         UXWI8HURnZFHhtwY/449RaGb7Z5eJwAU5FcfhuWPQjCU3WN72TrQqxrVkLlvIvx4otHz
         a7ig==
X-Gm-Message-State: AOJu0YzTsCxhwQidyYn5oqBXOQuTW+jhn+0YPtU7XZL9Id8U8vIkBR83
        +po+uen1/Oa1h2db5ZOb/Uxahq8X64FXoPTOjAHNkV/h
X-Google-Smtp-Source: AGHT+IFMuS6pBruJgfuND7L/e3ufXYuCf7vm3SsfwLvvp3ytrksPl3R+RpoWrVDGUT+JzXgFErdnWjg8V4fPBXC+MT0=
X-Received: by 2002:a05:651c:90:b0:2b9:35ae:c9ac with SMTP id
 16-20020a05651c009000b002b935aec9acmr2305221ljq.2.1692207854683; Wed, 16 Aug
 2023 10:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230809210157.112275-1-jwcart2@gmail.com> <87zg2se40o.fsf@redhat.com>
In-Reply-To: <87zg2se40o.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 16 Aug 2023 13:44:03 -0400
Message-ID: <CAP+JOzT1RVtcTXxC1DJDP=3sktv5wL0ikz-BAUpNSpV61cENqg@mail.gmail.com>
Subject: Re: [PATCH 0/9 v4] Add CIL Deny Rule
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org, dburgener@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 15, 2023 at 11:09=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > This patch series depends on the "Add support for notself and other to
> > CIL" patch series from August 9th
> >
> > These patches add a deny rule to CIL. Deny rules will be processed afte=
r
> > everything except for neverallow rules. Unlike neverallow rules, they
> > remove the permissions in the deny rule rather than reporting an error.
> >
> > See the individual patches for an explanation of what they do.
> >
> > Patches 1-8 are unchanged from v3, see:
> > https://lore.kernel.org/selinux/20230413193445.588395-1-jwcart2@gmail.c=
om/
> >
> > Previously, patch 9, as Daniel Burgener noted, did not do what it said =
it
> > was going to do. Now it does.
>
> I've pushed all 16 into
> https://github.com/bachradsusi/SELinuxProject-selinux/commits/notself-oth=
er-deny
> and I'm building it in my COPR repo -
> https://copr.fedorainfracloud.org/coprs/plautrba/selinux-patchwork/builds=
/
>
> I've already run some tests and it looks good.
>
> For all 16 patches - together with notself and other serie:
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>

All 16 of the notself and deny patches have been merged.
I did find a problem with an uninitialized return value at the last
minute which I fixed before merging.
Thanks to everyone who looked at or tested these patches.
Jim

> Thanks!
>
>
>
> > James Carter (9):
> >   libsepol/cil: Parse and add deny rule to AST, but do not process
> >   libsepol/cil: Add cil_list_is_empty macro
> >   libsepol/cil: Add cil_tree_node_remove function
> >   libsepol/cil: Process deny rules
> >   libsepol/cil: Add cil_write_post_ast function
> >   libsepol: Export the cil_write_post_ast function
> >   secilc/secil2tree: Add option to write CIL AST after post processing
> >   secilc/test: Add deny rule tests
> >   secilc/docs: Add deny rule to CIL documentation
> >
> >  libsepol/cil/include/cil/cil.h         |    1 +
> >  libsepol/cil/src/cil.c                 |   68 ++
> >  libsepol/cil/src/cil_build_ast.c       |   56 +
> >  libsepol/cil/src/cil_build_ast.h       |    2 +
> >  libsepol/cil/src/cil_copy_ast.c        |   19 +
> >  libsepol/cil/src/cil_copy_ast.h        |    1 +
> >  libsepol/cil/src/cil_deny.c            | 1413 ++++++++++++++++++++++++
> >  libsepol/cil/src/cil_deny.h            |   36 +
> >  libsepol/cil/src/cil_flavor.h          |    1 +
> >  libsepol/cil/src/cil_internal.h        |   10 +
> >  libsepol/cil/src/cil_list.h            |    3 +
> >  libsepol/cil/src/cil_post.c            |    7 +
> >  libsepol/cil/src/cil_reset_ast.c       |    8 +
> >  libsepol/cil/src/cil_resolve_ast.c     |   48 +
> >  libsepol/cil/src/cil_resolve_ast.h     |    1 +
> >  libsepol/cil/src/cil_tree.c            |   35 +
> >  libsepol/cil/src/cil_tree.h            |    1 +
> >  libsepol/cil/src/cil_verify.c          |    9 +
> >  libsepol/cil/src/cil_write_ast.c       |   10 +
> >  libsepol/cil/src/cil_write_ast.h       |    1 +
> >  libsepol/src/libsepol.map.in           |    5 +
> >  secilc/docs/cil_access_vector_rules.md |   41 +-
> >  secilc/secil2tree.c                    |    8 +-
> >  secilc/test/deny_rule_test1.cil        |  580 ++++++++++
> >  secilc/test/deny_rule_test2.cil        |  418 +++++++
> >  25 files changed, 2780 insertions(+), 2 deletions(-)
> >  create mode 100644 libsepol/cil/src/cil_deny.c
> >  create mode 100644 libsepol/cil/src/cil_deny.h
> >  create mode 100644 secilc/test/deny_rule_test1.cil
> >  create mode 100644 secilc/test/deny_rule_test2.cil
> >
> > --
> > 2.41.0
>
