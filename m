Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551A6C04FDF
	for <selinux@archiver.kernel.org>; Wed, 16 Aug 2023 18:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345364AbjHPSFu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Aug 2023 14:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345385AbjHPSFh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Aug 2023 14:05:37 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946CB1BF8
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 11:05:35 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so104243241fa.3
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 11:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692209134; x=1692813934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGmVIF8g5uYAbe28EqkYRwwyRrjXc3hJExftOiAo8X4=;
        b=RMuh0Lm1gJu3rUjAHJPif4YAedETzKabnARvFHcwNALLE009xgQv+lXS7tyPB/5DG/
         3M+4WRzRsurZVAoU32T7forLr0dXD3OcaKNItX1+ymmyFfkCvdeUa9rE1ToEig5d03tP
         79YFAnp06oex6yU42ggACQXSCIXmrw2gTthG4K/4AbNqoqXXRvida1vS+gdeBQ6CQ6PV
         IoyXPPKhdqyVL343t3cywDSF928j19qZ22iZJn6HBVnyhJbL6APEaAMXLusoD3slNuoO
         uyktNnxshoToqLEFbP2bvx10Cg3wOzsl4DYBcGbBHTJYU3U2ihVskCqxQYZ/lWeKFpcS
         8llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692209134; x=1692813934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGmVIF8g5uYAbe28EqkYRwwyRrjXc3hJExftOiAo8X4=;
        b=kh3Z5naOb+5Jw9fL3IbNN9rhtDt3JFEFykqwSfA7PR2THcxG2+ztX8OfQVNIf9X/Mr
         BOC/5c/8Op9Vi1a010zoONznIGNJdnspq+sZkULuSqgvgSOJr7KsX+tGpeLhVuV/Vt5e
         JsyK4J71JDC18898Ye2Cn7qe/dVv50df4N+pR9XFkRM4dxLgiEHdiWkieVO7teMD9HXg
         J0RBFCkhILK+a1oHG4V0xEj4IiLgcF1ZHRLQcvxeVk8QSg9eUowGaWfYzeQfs3bg3bHF
         9IIeAlaJpGXeQKtYZG2cXiW0Z5JwBtShl5DUItq9UXsS6/V4F/WvUebSIZIkTsh4/D/t
         78vw==
X-Gm-Message-State: AOJu0YzWVM29zpZrStYuSellTcEQrmmuMCltHwa8YTpnGtSl6K6E1HJi
        Zn9M5lwtr5+7jwrxp6xH3ounqoF8hKefMqIs9/lKro+N
X-Google-Smtp-Source: AGHT+IEoSNMVW3QKioBlWPK3QJnhtfNdRKqVKSKR5AXrvj5t2Px+yjH1SrQqBS8qD5ev5wiuUz3HtAexdu4AlGT+UPg=
X-Received: by 2002:a2e:9c93:0:b0:2b4:47ad:8c70 with SMTP id
 x19-20020a2e9c93000000b002b447ad8c70mr2074372lji.11.1692209133684; Wed, 16
 Aug 2023 11:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230809210157.112275-1-jwcart2@gmail.com> <87zg2se40o.fsf@redhat.com>
 <CAP+JOzT1RVtcTXxC1DJDP=3sktv5wL0ikz-BAUpNSpV61cENqg@mail.gmail.com> <CAJ2a_DePv0gU0Obs04pxH4VJv7-DYbHTkd3nMgqLFCWrTBoXcg@mail.gmail.com>
In-Reply-To: <CAJ2a_DePv0gU0Obs04pxH4VJv7-DYbHTkd3nMgqLFCWrTBoXcg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 16 Aug 2023 14:05:22 -0400
Message-ID: <CAP+JOzSYh_4MdnOZcMDp1QnjBFUGMObiRR6t+fqbxmWV8UkzJQ@mail.gmail.com>
Subject: Re: [PATCH 0/9 v4] Add CIL Deny Rule
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org,
        dburgener@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 16, 2023 at 1:53=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Wed, 16 Aug 2023 at 19:45, James Carter <jwcart2@gmail.com> wrote:
> >
> > On Tue, Aug 15, 2023 at 11:09=E2=80=AFAM Petr Lautrbach <lautrbach@redh=
at.com> wrote:
> > >
> > > James Carter <jwcart2@gmail.com> writes:
> > >
> > > > This patch series depends on the "Add support for notself and other=
 to
> > > > CIL" patch series from August 9th
> > > >
> > > > These patches add a deny rule to CIL. Deny rules will be processed =
after
> > > > everything except for neverallow rules. Unlike neverallow rules, th=
ey
> > > > remove the permissions in the deny rule rather than reporting an er=
ror.
> > > >
> > > > See the individual patches for an explanation of what they do.
> > > >
> > > > Patches 1-8 are unchanged from v3, see:
> > > > https://lore.kernel.org/selinux/20230413193445.588395-1-jwcart2@gma=
il.com/
> > > >
> > > > Previously, patch 9, as Daniel Burgener noted, did not do what it s=
aid it
> > > > was going to do. Now it does.
> > >
> > > I've pushed all 16 into
> > > https://github.com/bachradsusi/SELinuxProject-selinux/commits/notself=
-other-deny
> > > and I'm building it in my COPR repo -
> > > https://copr.fedorainfracloud.org/coprs/plautrba/selinux-patchwork/bu=
ilds/
> > >
> > > I've already run some tests and it looks good.
> > >
> > > For all 16 patches - together with notself and other serie:
> > >
> > > Acked-by: Petr Lautrbach <lautrbach@redhat.com>
> > >
> >
> > All 16 of the notself and deny patches have been merged.
> > I did find a problem with an uninitialized return value at the last
> > minute which I fixed before merging.
> > Thanks to everyone who looked at or tested these patches.
> > Jim
>
> I think the version in libsepol/src/libsepol.map.in in commit
> "libsepol: Export the cil_write_post_ast function" should have been
> updated to 3.6.
>

You are right. I was thinking that version 3.5 was the next release,
not the previous one.
Thanks,
Jim


> >
> > > Thanks!
> > >
> > >
> > >
> > > > James Carter (9):
> > > >   libsepol/cil: Parse and add deny rule to AST, but do not process
> > > >   libsepol/cil: Add cil_list_is_empty macro
> > > >   libsepol/cil: Add cil_tree_node_remove function
> > > >   libsepol/cil: Process deny rules
> > > >   libsepol/cil: Add cil_write_post_ast function
> > > >   libsepol: Export the cil_write_post_ast function
> > > >   secilc/secil2tree: Add option to write CIL AST after post process=
ing
> > > >   secilc/test: Add deny rule tests
> > > >   secilc/docs: Add deny rule to CIL documentation
> > > >
> > > >  libsepol/cil/include/cil/cil.h         |    1 +
> > > >  libsepol/cil/src/cil.c                 |   68 ++
> > > >  libsepol/cil/src/cil_build_ast.c       |   56 +
> > > >  libsepol/cil/src/cil_build_ast.h       |    2 +
> > > >  libsepol/cil/src/cil_copy_ast.c        |   19 +
> > > >  libsepol/cil/src/cil_copy_ast.h        |    1 +
> > > >  libsepol/cil/src/cil_deny.c            | 1413 ++++++++++++++++++++=
++++
> > > >  libsepol/cil/src/cil_deny.h            |   36 +
> > > >  libsepol/cil/src/cil_flavor.h          |    1 +
> > > >  libsepol/cil/src/cil_internal.h        |   10 +
> > > >  libsepol/cil/src/cil_list.h            |    3 +
> > > >  libsepol/cil/src/cil_post.c            |    7 +
> > > >  libsepol/cil/src/cil_reset_ast.c       |    8 +
> > > >  libsepol/cil/src/cil_resolve_ast.c     |   48 +
> > > >  libsepol/cil/src/cil_resolve_ast.h     |    1 +
> > > >  libsepol/cil/src/cil_tree.c            |   35 +
> > > >  libsepol/cil/src/cil_tree.h            |    1 +
> > > >  libsepol/cil/src/cil_verify.c          |    9 +
> > > >  libsepol/cil/src/cil_write_ast.c       |   10 +
> > > >  libsepol/cil/src/cil_write_ast.h       |    1 +
> > > >  libsepol/src/libsepol.map.in           |    5 +
> > > >  secilc/docs/cil_access_vector_rules.md |   41 +-
> > > >  secilc/secil2tree.c                    |    8 +-
> > > >  secilc/test/deny_rule_test1.cil        |  580 ++++++++++
> > > >  secilc/test/deny_rule_test2.cil        |  418 +++++++
> > > >  25 files changed, 2780 insertions(+), 2 deletions(-)
> > > >  create mode 100644 libsepol/cil/src/cil_deny.c
> > > >  create mode 100644 libsepol/cil/src/cil_deny.h
> > > >  create mode 100644 secilc/test/deny_rule_test1.cil
> > > >  create mode 100644 secilc/test/deny_rule_test2.cil
> > > >
> > > > --
> > > > 2.41.0
> > >
