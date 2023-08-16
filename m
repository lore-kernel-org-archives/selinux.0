Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DE3C04FE2
	for <selinux@archiver.kernel.org>; Wed, 16 Aug 2023 18:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345199AbjHPS2G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Aug 2023 14:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345552AbjHPS1p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Aug 2023 14:27:45 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C966C2D4E
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 11:27:13 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-44bf5a8598bso196417137.3
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 11:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692210422; x=1692815222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E77E/IjqUTIFIiNZTiZEyPUQPrY27VGo7O8jBS4H0gA=;
        b=N1YW23XogzZx/FVB3Y6Fm1diMNDO3dfvU0YEdlGOpl+pPpZN49FFsUCEzNKaMcwn3F
         us/Rm7EJEsoCEAAp1PBVSIRyY1w8CYqJnu/WHV59UV3AOL1LvpcgWyLt6R/iLg/ZFXon
         LUcQzLurL6DUc3SdaaC03BtYuC//o1YWJ91AMG2VWZTPqeE7s/wNGAkB6V1uex/PUBqG
         yzjeqyW45x68495jDOjn5YvfS1xpx8q/PUMpg8yCFKeZTPNu9UuM2Edb5BbBFhPZbfMD
         zvXlDr019+zNwQAR5HlZn+blYkGVP4swEkkwlaiQBVAbstseZvavRn7dq0qU/BRi9JmI
         Tvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692210422; x=1692815222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E77E/IjqUTIFIiNZTiZEyPUQPrY27VGo7O8jBS4H0gA=;
        b=DUx1pLcOaFJ7MoaESXkANnCJkamXey2BLNJOeVS/qT8eGTHdOcZH66bDZe+9V+5p13
         axlDSFIVw6Ny81OMiPH+dbmZ4WorHDEe+eQ7g9+N2tnbJEVIXxhBUJ+d1u/9C01nxhmK
         be5fW2jKaFS70gLRIQOUsJHkXtYEKJXuGmjll9FHUpClyJh9qbjKzfzdeQ/uiD969rKE
         vpbQmVYulpiOchJMITMMTMA0hbGNwqZjnFjCvl5ECpl/m3KpVS9+RodTlN/RplkG/KLT
         ksoCcBvtALdmc3VCyr8aRh7/nD6bdHYWonnOSvLy//cDoPh/53YfHaRC1y0tUXK220QS
         GbRw==
X-Gm-Message-State: AOJu0YyJPcdsGQtw6LqL9JLtZWw5RxlVhxR8iAXUktpjjI+5xmNSG/LB
        GAf2cVsG3byrDL/hdk4XHELRMEnMX66ZVsbgmOI=
X-Google-Smtp-Source: AGHT+IERoF1AARaAO4IzgYJXKkCkZOZLfQnaj7cSnNHJYx/4sMSQNfgkAAnVxyLw05pV4Fb+8MMKce434ws2wq1sI+0=
X-Received: by 2002:a67:bb12:0:b0:444:c236:547 with SMTP id
 m18-20020a67bb12000000b00444c2360547mr2590392vsn.12.1692210421904; Wed, 16
 Aug 2023 11:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230809210157.112275-1-jwcart2@gmail.com> <87zg2se40o.fsf@redhat.com>
 <CAP+JOzT1RVtcTXxC1DJDP=3sktv5wL0ikz-BAUpNSpV61cENqg@mail.gmail.com>
 <CAJ2a_DePv0gU0Obs04pxH4VJv7-DYbHTkd3nMgqLFCWrTBoXcg@mail.gmail.com>
 <CAP+JOzSYh_4MdnOZcMDp1QnjBFUGMObiRR6t+fqbxmWV8UkzJQ@mail.gmail.com> <CAP+JOzTzs16bd+AfJJzJOd4c-StfVaB=UN_P3DZ1-11MGksAqA@mail.gmail.com>
In-Reply-To: <CAP+JOzTzs16bd+AfJJzJOd4c-StfVaB=UN_P3DZ1-11MGksAqA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 16 Aug 2023 20:26:51 +0200
Message-ID: <CAJ2a_DfH6-wxL1QwBkORHv98hBLuNuAE=pR-_uXpFZYdGcv8zg@mail.gmail.com>
Subject: Re: [PATCH 0/9 v4] Add CIL Deny Rule
To:     James Carter <jwcart2@gmail.com>
Cc:     Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org,
        dburgener@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 16 Aug 2023 at 20:08, James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Aug 16, 2023 at 2:05=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > On Wed, Aug 16, 2023 at 1:53=E2=80=AFPM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > On Wed, 16 Aug 2023 at 19:45, James Carter <jwcart2@gmail.com> wrote:
> > > >
> > > > On Tue, Aug 15, 2023 at 11:09=E2=80=AFAM Petr Lautrbach <lautrbach@=
redhat.com> wrote:
> > > > >
> > > > > James Carter <jwcart2@gmail.com> writes:
> > > > >
> > > > > > This patch series depends on the "Add support for notself and o=
ther to
> > > > > > CIL" patch series from August 9th
> > > > > >
> > > > > > These patches add a deny rule to CIL. Deny rules will be proces=
sed after
> > > > > > everything except for neverallow rules. Unlike neverallow rules=
, they
> > > > > > remove the permissions in the deny rule rather than reporting a=
n error.
> > > > > >
> > > > > > See the individual patches for an explanation of what they do.
> > > > > >
> > > > > > Patches 1-8 are unchanged from v3, see:
> > > > > > https://lore.kernel.org/selinux/20230413193445.588395-1-jwcart2=
@gmail.com/
> > > > > >
> > > > > > Previously, patch 9, as Daniel Burgener noted, did not do what =
it said it
> > > > > > was going to do. Now it does.
> > > > >
> > > > > I've pushed all 16 into
> > > > > https://github.com/bachradsusi/SELinuxProject-selinux/commits/not=
self-other-deny
> > > > > and I'm building it in my COPR repo -
> > > > > https://copr.fedorainfracloud.org/coprs/plautrba/selinux-patchwor=
k/builds/
> > > > >
> > > > > I've already run some tests and it looks good.
> > > > >
> > > > > For all 16 patches - together with notself and other serie:
> > > > >
> > > > > Acked-by: Petr Lautrbach <lautrbach@redhat.com>
> > > > >
> > > >
> > > > All 16 of the notself and deny patches have been merged.
> > > > I did find a problem with an uninitialized return value at the last
> > > > minute which I fixed before merging.
> > > > Thanks to everyone who looked at or tested these patches.
> > > > Jim
> > >
> > > I think the version in libsepol/src/libsepol.map.in in commit
> > > "libsepol: Export the cil_write_post_ast function" should have been
> > > updated to 3.6.
> > >
> >
> > You are right. I was thinking that version 3.5 was the next release,
> > not the previous one.
>
> Or is everything supposed to be version 3.5 until the next release?
> This has always confused me. I don't think that we have been
> consistent.
> Jim

If I read the documentation[1] correctly the version number tells in
which version a symbol is available.
For example dpkg should declare any package with an application using
cil_write_post_ast() to depend on libsepol 3.6 (and not 3.5 where the
symbol is not available).

[1]: https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_node/ld_25.html

>
>
> > Thanks,
> > Jim
> >
> >
> > > >
> > > > > Thanks!
> > > > >
> > > > >
> > > > >
> > > > > > James Carter (9):
> > > > > >   libsepol/cil: Parse and add deny rule to AST, but do not proc=
ess
> > > > > >   libsepol/cil: Add cil_list_is_empty macro
> > > > > >   libsepol/cil: Add cil_tree_node_remove function
> > > > > >   libsepol/cil: Process deny rules
> > > > > >   libsepol/cil: Add cil_write_post_ast function
> > > > > >   libsepol: Export the cil_write_post_ast function
> > > > > >   secilc/secil2tree: Add option to write CIL AST after post pro=
cessing
> > > > > >   secilc/test: Add deny rule tests
> > > > > >   secilc/docs: Add deny rule to CIL documentation
> > > > > >
> > > > > >  libsepol/cil/include/cil/cil.h         |    1 +
> > > > > >  libsepol/cil/src/cil.c                 |   68 ++
> > > > > >  libsepol/cil/src/cil_build_ast.c       |   56 +
> > > > > >  libsepol/cil/src/cil_build_ast.h       |    2 +
> > > > > >  libsepol/cil/src/cil_copy_ast.c        |   19 +
> > > > > >  libsepol/cil/src/cil_copy_ast.h        |    1 +
> > > > > >  libsepol/cil/src/cil_deny.c            | 1413 ++++++++++++++++=
++++++++
> > > > > >  libsepol/cil/src/cil_deny.h            |   36 +
> > > > > >  libsepol/cil/src/cil_flavor.h          |    1 +
> > > > > >  libsepol/cil/src/cil_internal.h        |   10 +
> > > > > >  libsepol/cil/src/cil_list.h            |    3 +
> > > > > >  libsepol/cil/src/cil_post.c            |    7 +
> > > > > >  libsepol/cil/src/cil_reset_ast.c       |    8 +
> > > > > >  libsepol/cil/src/cil_resolve_ast.c     |   48 +
> > > > > >  libsepol/cil/src/cil_resolve_ast.h     |    1 +
> > > > > >  libsepol/cil/src/cil_tree.c            |   35 +
> > > > > >  libsepol/cil/src/cil_tree.h            |    1 +
> > > > > >  libsepol/cil/src/cil_verify.c          |    9 +
> > > > > >  libsepol/cil/src/cil_write_ast.c       |   10 +
> > > > > >  libsepol/cil/src/cil_write_ast.h       |    1 +
> > > > > >  libsepol/src/libsepol.map.in           |    5 +
> > > > > >  secilc/docs/cil_access_vector_rules.md |   41 +-
> > > > > >  secilc/secil2tree.c                    |    8 +-
> > > > > >  secilc/test/deny_rule_test1.cil        |  580 ++++++++++
> > > > > >  secilc/test/deny_rule_test2.cil        |  418 +++++++
> > > > > >  25 files changed, 2780 insertions(+), 2 deletions(-)
> > > > > >  create mode 100644 libsepol/cil/src/cil_deny.c
> > > > > >  create mode 100644 libsepol/cil/src/cil_deny.h
> > > > > >  create mode 100644 secilc/test/deny_rule_test1.cil
> > > > > >  create mode 100644 secilc/test/deny_rule_test2.cil
> > > > > >
> > > > > > --
> > > > > > 2.41.0
> > > > >
