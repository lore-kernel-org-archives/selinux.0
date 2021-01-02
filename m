Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD91C433E0
	for <selinux@archiver.kernel.org>; Sat,  2 Jan 2021 11:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2FFC22241
	for <selinux@archiver.kernel.org>; Sat,  2 Jan 2021 11:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbhABLVO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 Jan 2021 06:21:14 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:41574 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbhABLVN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 2 Jan 2021 06:21:13 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 70362564C47
        for <selinux@vger.kernel.org>; Sat,  2 Jan 2021 12:20:29 +0100 (CET)
Received: by mail-oi1-f174.google.com with SMTP id 15so26644156oix.8
        for <selinux@vger.kernel.org>; Sat, 02 Jan 2021 03:20:29 -0800 (PST)
X-Gm-Message-State: AOAM532YxwYeQp1054QkobnfzWnTFv5xexLwHouyE+hLub8MrPHLLW1E
        lm9V0QVymL6Hl1zVASl6z4ccTSkB+diNY97xS40=
X-Google-Smtp-Source: ABdhPJyO3GgwlvaGzrgFoxnebrGnTxcZXDOxM6gdz68/UH3uJr2kaV7AzwipZi6/eUhNLp4uWPU4tRD7EcfChfWDfK0=
X-Received: by 2002:aca:51d8:: with SMTP id f207mr12960753oib.20.1609586428311;
 Sat, 02 Jan 2021 03:20:28 -0800 (PST)
MIME-Version: 1.0
References: <CAJfZ7=kiMYKgEn1YvxgVjxh=ud5Nd==bOmYnRVEqfc=hDDX1ZA@mail.gmail.com>
 <CAFftDdoT-=ndesm9bQ0DLkPoBVjK7ruVdcaOo9Z8-9b+vTEn3A@mail.gmail.com>
In-Reply-To: <CAFftDdoT-=ndesm9bQ0DLkPoBVjK7ruVdcaOo9Z8-9b+vTEn3A@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 2 Jan 2021 12:20:17 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=ndZMDUoTFxB6wD+7+3q5kToh16fu6R8orZ6bq04-N-Mg@mail.gmail.com>
Message-ID: <CAJfZ7=ndZMDUoTFxB6wD+7+3q5kToh16fu6R8orZ6bq04-N-Mg@mail.gmail.com>
Subject: Re: libsepol/cil: infinite loop using invalid block/blockabstract
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan  2 12:20:30 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 31, 2020 at 3:48 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Wed, Dec 30, 2020 at 11:46 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > Hello,
> >
> > A few weeks ago, OSS-Fuzz got configured in order to fuzz the CIL
> > policy compiler. One of the issue it reported was a "Stack-overflow in
> > __cil_resolve_name_with_parents", which seemed strange
> > (https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28491, for
> > future reference).
> >
> > By looking into it, the reduced test-case is the following CIL policy:
> >
> > (optional o
> >     (block b
> >         (block b
> >             (blockabstract b0)
> >         )
> >         (blockinherit b)
> >     )
> > )
> > (blockinherit b)
> >
> > When building this policy with secilc, the command seems to be caught
> > in a loop that never ends. Using gdb to break somewhere leads to the
> > following call stack:
> >
> > #0  0x0000555555bab646 in __cil_resolve_name_with_parents
> > (node=0x606000000fe0, name=<optimized out>, sym_index=<optimized out>,
> > datum=<optimized out>) at ../cil/src/cil_resolve_ast.c:4070
> > #1  0x0000555555baae73 in __cil_resolve_name_helper (db=<optimized
> > out>, node=<optimized out>, name=0x602000002850 "b0",
> > sym_index=CIL_SYM_BLOCKS, datum=0x7fffffffcd80) at
> > ../cil/src/cil_resolve_ast.c:4122
> > #2  0x0000555555b7865b in cil_resolve_name_keep_aliases
> > (ast_node=<optimized out>, name=<optimized out>, sym_index=<optimized
> > out>, extra_args=<optimized out>, datum=<optimized out>) at
> > ../cil/src/cil_resolve_ast.c:4173
> > #3  0x0000555555b70384 in cil_resolve_name (ast_node=0x0, name=0x0,
> > sym_index=CIL_SYM_BLOCKS, extra_args=0x7fffffffcd80,
> > datum=0x7fffffffcd80) at ../cil/src/cil_resolve_ast.c:4134
> > #4  0x0000555555b96b9f in cil_resolve_blockabstract
> > (current=0x606000001040, extra_args=<optimized out>) at
> > ../cil/src/cil_resolve_ast.c:2457
> > #5  0x0000555555ba4c2c in __cil_resolve_ast_node (node=<optimized
> > out>, extra_args=<optimized out>) at ../cil/src/cil_resolve_ast.c:3450
> > #6  0x0000555555ba6e00 in __cil_resolve_ast_node_helper
> > (node=<optimized out>, finished=<optimized out>, extra_args=<optimized
> > out>) at ../cil/src/cil_resolve_ast.c:3769
> > #7  0x0000555555bb86ed in cil_tree_walk_core (node=0x606000001040,
> > process_node=<optimized out>, first_child=<optimized out>,
> > last_child=<optimized out>, extra_args=<optimized out>) at
> > ../cil/src/cil_tree.c:272
> > #8  0x0000555555bb8bf2 in cil_tree_walk (node=0x606000000fe0,
> > process_node=<optimized out>, first_child=<optimized out>,
> > last_child=<optimized out>, extra_args=<optimized out>) at
> > ../cil/src/cil_tree.c:316
> > #9  0x0000555555bb87f0 in cil_tree_walk_core (node=0x606000000fe0,
> > process_node=<optimized out>, first_child=<optimized out>,
> > last_child=<optimized out>, extra_args=<optimized out>) at
> > ../cil/src/cil_tree.c:284
> > #10 0x0000555555bb8bf2 in cil_tree_walk (node=0x606000000bc0,
> > process_node=<optimized out>, first_child=<optimized out>,
> > last_child=<optimized out>, extra_args=<optimized out>) at
> > ../cil/src/cil_tree.c:316
> > #11 0x0000555555bb87f0 in cil_tree_walk_core (node=0x606000000bc0,
> > process_node=<optimized out>, first_child=<optimized out>,
> > last_child=<optimized out>, extra_args=<optimized out>) at
> > ../cil/src/cil_tree.c:284
> > #12 0x0000555555bb8bf2 in cil_tree_walk (node=0x606000000980,
> > process_node=<optimized out>, first_child=<optimized out>,
> > last_child=<optimized out>, extra_args=<optimized out>) at
> > ../cil/src/cil_tree.c:316
> > #13 0x0000555555bb87f0 in cil_tree_walk_core (node=0x606000000980,
> > process_node=<optimized out>, first_child=<optimized out>,
> > last_child=<optimized out>, extra_args=<optimized out>) at
> > ../cil/src/cil_tree.c:284
> > #14 0x0000555555bb8bf2 in cil_tree_walk (node=0x606000000080,
> > process_node=<optimized out>, first_child=<optimized out>,
> > last_child=<optimized out>, extra_args=<optimized out>) at
> > ../cil/src/cil_tree.c:316
> > #15 0x0000555555ba9dd1 in cil_resolve_ast (db=<optimized out>,
> > current=<optimized out>) at ../cil/src/cil_resolve_ast.c:3937
> > #16 0x0000555555a1d64a in cil_compile (db=0x6120000001c0) at
> > ../cil/src/cil.c:550
> > #17 0x00005555559e9d06 in main ()
> >
> > However, if I understand correctly the documentation
> > (https://github.com/SELinuxProject/selinux/blob/master/secilc/docs/cil_container_statements.md),
> > having two "(block b)" and a "(blockabstract b0)" that does not
> > reference "b" are not supposed to work. Maybe the CIL compiler needs
> > to detect such issues and fail instead of entering some kind of loop.
> > How should this issue be fixed?
>
> That seems reasonable to me, but I would say this CIL not my forte.
> Have you had any other
> thoughts around this?

This issue is a little bit more subtle to solve, because blockabstract
can include composed names (I'm not sure whether this is the right
word for this concept). For example in
https://github.com/SELinuxProject/selinux/blob/5b05e829da0863f3538be8d153373adec7fc07f6/secilc/test/policy.cil#L330-L333
:

(block z
  (block ba
    (roletype r t)
    (blockabstract z.ba)))

This part of the CIL compiler is quite complex and I am not sure when
I will be able to understand it enough to propose a fix.

Nicolas

