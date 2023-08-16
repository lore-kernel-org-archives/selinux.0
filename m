Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4052C001B0
	for <selinux@archiver.kernel.org>; Wed, 16 Aug 2023 17:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbjHPRx1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Aug 2023 13:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345092AbjHPRxV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Aug 2023 13:53:21 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434EE1FFF
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 10:53:19 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-44bf46b6f97so66448137.0
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 10:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692208398; x=1692813198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92J1u6MokABjNJ4sdLxDbHGayhNw4HGQASiDK4G3HbI=;
        b=Rdgq0uds02Lux32elBsNllh3E0MQHFypkGfY1A8Tld2PK/SAfI3nHck59MvUz80wIa
         OYp5BdvYC3hDpZj7djL3CxdSav4y7O1GcFBDl9yEN5KTG9JoUjwx7n61vLZKyWM3umcM
         nr22EH0P45NP0trHSjOaeEQ9TVBN8jhRylmWjxnPPlgWJAYkYiAjX27s0CHL0pg+9Hql
         LKV07er7sM0w70yfyB9kgR0rr13AWumo7ATDQg5Yr7BF3n5x1SGcEvFo09ZGsxcQAgEl
         ufb6wQHgKSIn9zHv5EiLxBS81Zu3Vq1JUxEgx4q7atzlCeFh5yVNti8dUVKPyUKw2XnU
         jQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692208398; x=1692813198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92J1u6MokABjNJ4sdLxDbHGayhNw4HGQASiDK4G3HbI=;
        b=Cgx1hyasXuLDsNRpjPAsUAXqFd70+yKWmMRiItwFwgE3sCqtTDRxSZBJPsk6fA9cF/
         udx9vm6rvstlnvIEo/wuMW2slth1c9iE5IU8vUDOpKq0rHlft6w92mTvqdLJy+guwf6h
         ktz9e7+xmxJpccLbVstdrxtfeEjsnjbMeRpWC1PgbZbmi0FxGIihstHN77arJHqnOphb
         LHF6R5YAmHiN/4MDPUce4eEeAU/Bk++CvfafmxfpazXlMlhzo1hlYhwzfQQY/+2MMubK
         fMZiwdP+8bEVGGcDyJBKOr9gcDSzkyhi1kxaMK2tXnCKObctRfrFwu/ygFdmKXC1/ThW
         D9KA==
X-Gm-Message-State: AOJu0YxH+iIZ7MTLlLyfxhEyrh6f9O/qDtNo7vpi0vpF/UB//rzwFBMp
        TpPkwNY3MoEU8L7ePZetfU/LGJEO2qTdSIhMdvM3V2kk6j9CdpCk
X-Google-Smtp-Source: AGHT+IG/DemIte94wniukv3tDdnUJRmF1dAcR/63aV4iK4K5PL8EvlsaZKhnqYi9wPrACWN1c8+ye7twx2cL6U8Bwok=
X-Received: by 2002:a05:6102:511e:b0:44b:f485:2727 with SMTP id
 bm30-20020a056102511e00b0044bf4852727mr450627vsb.4.1692208398267; Wed, 16 Aug
 2023 10:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230809210157.112275-1-jwcart2@gmail.com> <87zg2se40o.fsf@redhat.com>
 <CAP+JOzT1RVtcTXxC1DJDP=3sktv5wL0ikz-BAUpNSpV61cENqg@mail.gmail.com>
In-Reply-To: <CAP+JOzT1RVtcTXxC1DJDP=3sktv5wL0ikz-BAUpNSpV61cENqg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 16 Aug 2023 19:53:07 +0200
Message-ID: <CAJ2a_DePv0gU0Obs04pxH4VJv7-DYbHTkd3nMgqLFCWrTBoXcg@mail.gmail.com>
Subject: Re: [PATCH 0/9 v4] Add CIL Deny Rule
To:     James Carter <jwcart2@gmail.com>
Cc:     Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org,
        dburgener@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 16 Aug 2023 at 19:45, James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Aug 15, 2023 at 11:09=E2=80=AFAM Petr Lautrbach <lautrbach@redhat=
.com> wrote:
> >
> > James Carter <jwcart2@gmail.com> writes:
> >
> > > This patch series depends on the "Add support for notself and other t=
o
> > > CIL" patch series from August 9th
> > >
> > > These patches add a deny rule to CIL. Deny rules will be processed af=
ter
> > > everything except for neverallow rules. Unlike neverallow rules, they
> > > remove the permissions in the deny rule rather than reporting an erro=
r.
> > >
> > > See the individual patches for an explanation of what they do.
> > >
> > > Patches 1-8 are unchanged from v3, see:
> > > https://lore.kernel.org/selinux/20230413193445.588395-1-jwcart2@gmail=
.com/
> > >
> > > Previously, patch 9, as Daniel Burgener noted, did not do what it sai=
d it
> > > was going to do. Now it does.
> >
> > I've pushed all 16 into
> > https://github.com/bachradsusi/SELinuxProject-selinux/commits/notself-o=
ther-deny
> > and I'm building it in my COPR repo -
> > https://copr.fedorainfracloud.org/coprs/plautrba/selinux-patchwork/buil=
ds/
> >
> > I've already run some tests and it looks good.
> >
> > For all 16 patches - together with notself and other serie:
> >
> > Acked-by: Petr Lautrbach <lautrbach@redhat.com>
> >
>
> All 16 of the notself and deny patches have been merged.
> I did find a problem with an uninitialized return value at the last
> minute which I fixed before merging.
> Thanks to everyone who looked at or tested these patches.
> Jim

I think the version in libsepol/src/libsepol.map.in in commit
"libsepol: Export the cil_write_post_ast function" should have been
updated to 3.6.

>
> > Thanks!
> >
> >
> >
> > > James Carter (9):
> > >   libsepol/cil: Parse and add deny rule to AST, but do not process
> > >   libsepol/cil: Add cil_list_is_empty macro
> > >   libsepol/cil: Add cil_tree_node_remove function
> > >   libsepol/cil: Process deny rules
> > >   libsepol/cil: Add cil_write_post_ast function
> > >   libsepol: Export the cil_write_post_ast function
> > >   secilc/secil2tree: Add option to write CIL AST after post processin=
g
> > >   secilc/test: Add deny rule tests
> > >   secilc/docs: Add deny rule to CIL documentation
> > >
> > >  libsepol/cil/include/cil/cil.h         |    1 +
> > >  libsepol/cil/src/cil.c                 |   68 ++
> > >  libsepol/cil/src/cil_build_ast.c       |   56 +
> > >  libsepol/cil/src/cil_build_ast.h       |    2 +
> > >  libsepol/cil/src/cil_copy_ast.c        |   19 +
> > >  libsepol/cil/src/cil_copy_ast.h        |    1 +
> > >  libsepol/cil/src/cil_deny.c            | 1413 ++++++++++++++++++++++=
++
> > >  libsepol/cil/src/cil_deny.h            |   36 +
> > >  libsepol/cil/src/cil_flavor.h          |    1 +
> > >  libsepol/cil/src/cil_internal.h        |   10 +
> > >  libsepol/cil/src/cil_list.h            |    3 +
> > >  libsepol/cil/src/cil_post.c            |    7 +
> > >  libsepol/cil/src/cil_reset_ast.c       |    8 +
> > >  libsepol/cil/src/cil_resolve_ast.c     |   48 +
> > >  libsepol/cil/src/cil_resolve_ast.h     |    1 +
> > >  libsepol/cil/src/cil_tree.c            |   35 +
> > >  libsepol/cil/src/cil_tree.h            |    1 +
> > >  libsepol/cil/src/cil_verify.c          |    9 +
> > >  libsepol/cil/src/cil_write_ast.c       |   10 +
> > >  libsepol/cil/src/cil_write_ast.h       |    1 +
> > >  libsepol/src/libsepol.map.in           |    5 +
> > >  secilc/docs/cil_access_vector_rules.md |   41 +-
> > >  secilc/secil2tree.c                    |    8 +-
> > >  secilc/test/deny_rule_test1.cil        |  580 ++++++++++
> > >  secilc/test/deny_rule_test2.cil        |  418 +++++++
> > >  25 files changed, 2780 insertions(+), 2 deletions(-)
> > >  create mode 100644 libsepol/cil/src/cil_deny.c
> > >  create mode 100644 libsepol/cil/src/cil_deny.h
> > >  create mode 100644 secilc/test/deny_rule_test1.cil
> > >  create mode 100644 secilc/test/deny_rule_test2.cil
> > >
> > > --
> > > 2.41.0
> >
