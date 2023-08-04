Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6B0C001DB
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 18:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjHDSgJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHDSfP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Aug 2023 14:35:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A7F49F4
        for <selinux@vger.kernel.org>; Fri,  4 Aug 2023 11:34:23 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so38379221fa.2
        for <selinux@vger.kernel.org>; Fri, 04 Aug 2023 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691174062; x=1691778862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3x3iTeQwuzcVzlgIHkzh+xDBlvUpR3X2PF6Tx1FmY4o=;
        b=GNgaUQHrmhGEbaDR7uKXzyts7E+BQ4r4Kn1SHYxKxZDc/3uYhDJy+Gpetsj2mBrcC3
         hEenOae5JuFasygJMdhy2WbffCd5ubyt5pFqOPRUOh7aZstLaahISqL1BCg8GhDWg405
         jTK0lDqWgR9gY2MsB0cKy2N1V3tTUgR/KlLA11xLF+VaNJAJQBuILxSd+6q0FkaZR60h
         w0XmQUHszp4RzD6D/qbxT96C2pJ5tnWeeQm8OcJ/QCKMnLr1lbMGmLN7DJBBwr6P9JQ7
         GUqoO52DX3s3PR8RvIajiH2/6kkjvn4BO3n1yZnS0K6/vX77gEuqzzm/9spi72OoraSu
         cihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691174062; x=1691778862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3x3iTeQwuzcVzlgIHkzh+xDBlvUpR3X2PF6Tx1FmY4o=;
        b=anr05ImqaASlpu0xAdSTguLp59zsYdrDYLoFTaYqgBBUZmqn8gqZILU2urUan6Rfcs
         kNuJSJHWdBHt8iq+LTpjhAHzqDFDYV2wT6gUUG37uejSkkOpimQYIz7/JJb1M1mRy0Vt
         JCHCtqDSwd6HzRQO/Xyg/W1dOBy8HFAq/Ehi83T7AxaqspBWGNxTEFMP4e5+VZP1E6P4
         5BFWRE0HbliLMoJqYIVjw9vBHrNCqQSiYhYlcpA8X1hH29yS/bpwZ64UKfhkCE/QRC29
         5roB0XoUjPPkxZTKEWq42OsuibWmr+ysSxcbwnqjG1++33CgFUdga8mBNJ+0u38YU2Go
         EU+w==
X-Gm-Message-State: AOJu0Yyd7R+hD7HvYyPHLVNPdSHrnOP+G125GwD1N4XjIrthWjUI4f68
        +49HJGCMItQmirBnyTTx39+CzQ10Ok0gHh9GlO1HHkxp
X-Google-Smtp-Source: AGHT+IGkLdt4zj8V5aALXp2QIHUHtowck7298nxgeknzgVg/NUtSBafcTRADCpdrJEfwGWbT3MTh1jUmKV46iFLdCio=
X-Received: by 2002:a05:651c:110:b0:2b9:a28d:6495 with SMTP id
 a16-20020a05651c011000b002b9a28d6495mr2167927ljb.9.1691174061531; Fri, 04 Aug
 2023 11:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230726142549.94685-1-jwcart2@gmail.com> <87o7jyy6qo.fsf@redhat.com>
In-Reply-To: <87o7jyy6qo.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Aug 2023 14:34:10 -0400
Message-ID: <CAP+JOzRtx1hPfbzvu73kf-wAwxroU-zW6ArjXwrQxtRGOVrLYQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Revert the prefix/suffix filename transition patches
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org, juraj@jurajmarcin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 26, 2023 at 12:31=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.c=
om> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > Since the kernel patches have not been accepted yet, it seems better to
> > revert these patches while they can still be cleanly reverted just in
> > case the kernel patches are not accepted.
> >
> > If the kernel patches get accepted, then I will re-apply these patches.
> >
> > I should have waited for the kernel patches to be accepted before commi=
tting
> > these in the first place.
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>

This series has been merged. I am eagerly awaiting the new and improved ver=
sion.
Jim

>
> > James Carter (8):
> >   Revert "libsepol/cil: add support for prefix/suffix filename
> >     transtions to CIL"
> >   Revert "checkpolicy,libsepol: add prefix/suffix support to module
> >     policy"
> >   Revert "checkpolicy,libsepol: add prefix/suffix support to kernel
> >     policy"
> >   Revert "libsepol: implement new module binary format of avrule"
> >   Revert "libsepol: implement new kernel binary format for avtab"
> >   Revert "checkpolicy,libsepol: move filename transition rules to
> >     avrule"
> >   Revert "checkpolicy,libsepol: move filename transitions to avtab"
> >   Revert "checkpolicy,libsepol: move transition to separate structure i=
n
> >     avtab"
> >
> >  checkpolicy/checkmodule.c                  |   9 -
> >  checkpolicy/module_compiler.c              |  12 +
> >  checkpolicy/module_compiler.h              |   1 +
> >  checkpolicy/policy_define.c                | 211 +++++-
> >  checkpolicy/policy_define.h                |   3 +-
> >  checkpolicy/policy_parse.y                 |  13 +-
> >  checkpolicy/policy_scan.l                  |   4 -
> >  checkpolicy/test/dismod.c                  |  39 +-
> >  checkpolicy/test/dispol.c                  | 106 ++-
> >  libsepol/cil/src/cil.c                     |   6 -
> >  libsepol/cil/src/cil_binary.c              |  63 +-
> >  libsepol/cil/src/cil_build_ast.c           |  26 +-
> >  libsepol/cil/src/cil_copy_ast.c            |   1 -
> >  libsepol/cil/src/cil_internal.h            |   4 -
> >  libsepol/cil/src/cil_policy.c              |  17 +-
> >  libsepol/cil/src/cil_resolve_ast.c         |  10 -
> >  libsepol/cil/src/cil_write_ast.c           |   2 -
> >  libsepol/include/sepol/policydb/avtab.h    |  19 +-
> >  libsepol/include/sepol/policydb/hashtab.h  |   8 -
> >  libsepol/include/sepol/policydb/policydb.h |  50 +-
> >  libsepol/src/avrule_block.c                |   1 +
> >  libsepol/src/avtab.c                       | 338 +---------
> >  libsepol/src/conditional.c                 |   6 +-
> >  libsepol/src/expand.c                      | 153 +++--
> >  libsepol/src/kernel_to_cil.c               | 182 +++--
> >  libsepol/src/kernel_to_common.h            |  10 -
> >  libsepol/src/kernel_to_conf.c              | 178 +++--
> >  libsepol/src/link.c                        |  57 +-
> >  libsepol/src/module_to_cil.c               |  86 ++-
> >  libsepol/src/optimize.c                    |   8 -
> >  libsepol/src/policydb.c                    | 479 +++++++++++---
> >  libsepol/src/policydb_validate.c           | 101 ++-
> >  libsepol/src/services.c                    |   5 +-
> >  libsepol/src/write.c                       | 735 +++++----------------
> >  34 files changed, 1390 insertions(+), 1553 deletions(-)
> >
> > --
> > 2.41.0
>
