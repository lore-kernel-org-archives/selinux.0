Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAD2C04A6A
	for <selinux@archiver.kernel.org>; Wed, 16 Aug 2023 18:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbjHPSJC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Aug 2023 14:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345457AbjHPSIv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Aug 2023 14:08:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B18C2D5B
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 11:08:41 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso103574191fa.1
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 11:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692209319; x=1692814119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50shj5P0+rW5K3A9I8TajP12tUyiilGfM6a53p3bU6A=;
        b=QACnij5MqTLpQRKXJXcDhqy8HX04yh++hnrPqN25pZEWPoHvWptEC2Vrk5Bvc99kYS
         na2MH5tTStTu4jYSa2+6qLJJ/46JD986im6vFpIbzJLZ+NIZF2gdS3b0csXvzlawvL10
         REGjbjUwyxXsHqicQ+GhMTIAVogplRCJp7T+9weCPm8WRZ61NuTORUGd0qj5SNaJR8MQ
         ellNrkZFXZoJNrjnTFer0mk8qfM5TCnms685YohHkwHxKPLKVj1Ti2vVc13Hh7zjAFd+
         DanOAJ60/XwYS+JCz1Zv0l5B+9glKibEEGZZPXNPdArjeQgEvZbC3/+1RQMvEPqyl3lO
         bL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692209319; x=1692814119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50shj5P0+rW5K3A9I8TajP12tUyiilGfM6a53p3bU6A=;
        b=Zwg6MAu9l6OIyKmlJEauATNgBadsenPYGLOd7sfO9WRmJSgBrhRufKddc7ztXpyRDs
         EwBuh1dP9+/RT1cEKUdHjjK0VPk4osvnBKCh6ekjbcC9Jr52ANio3qSkU/b8316mXTtm
         W1lr3F6x2phUzVMOpniVuk/TAQtjz1vvVzVAf9Ju+451Nzav6ydZ9YiLEHOH4ZAM3RYj
         FZdc3LhCteEE4ufO4jrmgQDPR3NkXr8V93u2KDYLZgofKE8bFn6oOZw2i+xwjdLw41Wa
         CXCtIDYYfyAWFG2HUScW9WKAHVbvPpJcNWFYE2qjfP+4m93/PBi1b0pEFzZCE5a95zRu
         7P9w==
X-Gm-Message-State: AOJu0YwAitLzFEJlTkAUkvIhRhHy2K+5zygD+u0kXwLRYAWmjeWBS/Wl
        MKt6kBtf8/nbW0hplUVSbtsZHDc9nAMgRYt6LkY=
X-Google-Smtp-Source: AGHT+IHVGx1hplJjVGhIMdAfQ/1UHU6YSh88HltPvbiL/ydu1lag4nqlymatEosJtFPo5tZG7+2YHyDSGq8v5miMJFc=
X-Received: by 2002:a05:651c:1034:b0:2a7:adf7:1781 with SMTP id
 w20-20020a05651c103400b002a7adf71781mr1960387ljm.2.1692209319541; Wed, 16 Aug
 2023 11:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230809210157.112275-1-jwcart2@gmail.com> <87zg2se40o.fsf@redhat.com>
 <CAP+JOzT1RVtcTXxC1DJDP=3sktv5wL0ikz-BAUpNSpV61cENqg@mail.gmail.com>
 <CAJ2a_DePv0gU0Obs04pxH4VJv7-DYbHTkd3nMgqLFCWrTBoXcg@mail.gmail.com> <CAP+JOzSYh_4MdnOZcMDp1QnjBFUGMObiRR6t+fqbxmWV8UkzJQ@mail.gmail.com>
In-Reply-To: <CAP+JOzSYh_4MdnOZcMDp1QnjBFUGMObiRR6t+fqbxmWV8UkzJQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 16 Aug 2023 14:08:28 -0400
Message-ID: <CAP+JOzTzs16bd+AfJJzJOd4c-StfVaB=UN_P3DZ1-11MGksAqA@mail.gmail.com>
Subject: Re: [PATCH 0/9 v4] Add CIL Deny Rule
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org,
        dburgener@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 16, 2023 at 2:05=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Aug 16, 2023 at 1:53=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > On Wed, 16 Aug 2023 at 19:45, James Carter <jwcart2@gmail.com> wrote:
> > >
> > > On Tue, Aug 15, 2023 at 11:09=E2=80=AFAM Petr Lautrbach <lautrbach@re=
dhat.com> wrote:
> > > >
> > > > James Carter <jwcart2@gmail.com> writes:
> > > >
> > > > > This patch series depends on the "Add support for notself and oth=
er to
> > > > > CIL" patch series from August 9th
> > > > >
> > > > > These patches add a deny rule to CIL. Deny rules will be processe=
d after
> > > > > everything except for neverallow rules. Unlike neverallow rules, =
they
> > > > > remove the permissions in the deny rule rather than reporting an =
error.
> > > > >
> > > > > See the individual patches for an explanation of what they do.
> > > > >
> > > > > Patches 1-8 are unchanged from v3, see:
> > > > > https://lore.kernel.org/selinux/20230413193445.588395-1-jwcart2@g=
mail.com/
> > > > >
> > > > > Previously, patch 9, as Daniel Burgener noted, did not do what it=
 said it
> > > > > was going to do. Now it does.
> > > >
> > > > I've pushed all 16 into
> > > > https://github.com/bachradsusi/SELinuxProject-selinux/commits/notse=
lf-other-deny
> > > > and I'm building it in my COPR repo -
> > > > https://copr.fedorainfracloud.org/coprs/plautrba/selinux-patchwork/=
builds/
> > > >
> > > > I've already run some tests and it looks good.
> > > >
> > > > For all 16 patches - together with notself and other serie:
> > > >
> > > > Acked-by: Petr Lautrbach <lautrbach@redhat.com>
> > > >
> > >
> > > All 16 of the notself and deny patches have been merged.
> > > I did find a problem with an uninitialized return value at the last
> > > minute which I fixed before merging.
> > > Thanks to everyone who looked at or tested these patches.
> > > Jim
> >
> > I think the version in libsepol/src/libsepol.map.in in commit
> > "libsepol: Export the cil_write_post_ast function" should have been
> > updated to 3.6.
> >
>
> You are right. I was thinking that version 3.5 was the next release,
> not the previous one.

Or is everything supposed to be version 3.5 until the next release?
This has always confused me. I don't think that we have been
consistent.
Jim


> Thanks,
> Jim
>
>
> > >
> > > > Thanks!
> > > >
> > > >
> > > >
> > > > > James Carter (9):
> > > > >   libsepol/cil: Parse and add deny rule to AST, but do not proces=
s
> > > > >   libsepol/cil: Add cil_list_is_empty macro
> > > > >   libsepol/cil: Add cil_tree_node_remove function
> > > > >   libsepol/cil: Process deny rules
> > > > >   libsepol/cil: Add cil_write_post_ast function
> > > > >   libsepol: Export the cil_write_post_ast function
> > > > >   secilc/secil2tree: Add option to write CIL AST after post proce=
ssing
> > > > >   secilc/test: Add deny rule tests
> > > > >   secilc/docs: Add deny rule to CIL documentation
> > > > >
> > > > >  libsepol/cil/include/cil/cil.h         |    1 +
> > > > >  libsepol/cil/src/cil.c                 |   68 ++
> > > > >  libsepol/cil/src/cil_build_ast.c       |   56 +
> > > > >  libsepol/cil/src/cil_build_ast.h       |    2 +
> > > > >  libsepol/cil/src/cil_copy_ast.c        |   19 +
> > > > >  libsepol/cil/src/cil_copy_ast.h        |    1 +
> > > > >  libsepol/cil/src/cil_deny.c            | 1413 ++++++++++++++++++=
++++++
> > > > >  libsepol/cil/src/cil_deny.h            |   36 +
> > > > >  libsepol/cil/src/cil_flavor.h          |    1 +
> > > > >  libsepol/cil/src/cil_internal.h        |   10 +
> > > > >  libsepol/cil/src/cil_list.h            |    3 +
> > > > >  libsepol/cil/src/cil_post.c            |    7 +
> > > > >  libsepol/cil/src/cil_reset_ast.c       |    8 +
> > > > >  libsepol/cil/src/cil_resolve_ast.c     |   48 +
> > > > >  libsepol/cil/src/cil_resolve_ast.h     |    1 +
> > > > >  libsepol/cil/src/cil_tree.c            |   35 +
> > > > >  libsepol/cil/src/cil_tree.h            |    1 +
> > > > >  libsepol/cil/src/cil_verify.c          |    9 +
> > > > >  libsepol/cil/src/cil_write_ast.c       |   10 +
> > > > >  libsepol/cil/src/cil_write_ast.h       |    1 +
> > > > >  libsepol/src/libsepol.map.in           |    5 +
> > > > >  secilc/docs/cil_access_vector_rules.md |   41 +-
> > > > >  secilc/secil2tree.c                    |    8 +-
> > > > >  secilc/test/deny_rule_test1.cil        |  580 ++++++++++
> > > > >  secilc/test/deny_rule_test2.cil        |  418 +++++++
> > > > >  25 files changed, 2780 insertions(+), 2 deletions(-)
> > > > >  create mode 100644 libsepol/cil/src/cil_deny.c
> > > > >  create mode 100644 libsepol/cil/src/cil_deny.h
> > > > >  create mode 100644 secilc/test/deny_rule_test1.cil
> > > > >  create mode 100644 secilc/test/deny_rule_test2.cil
> > > > >
> > > > > --
> > > > > 2.41.0
> > > >
