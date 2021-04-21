Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A21C433B4
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 21:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C83C6142B
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 21:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbhDUVB4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Apr 2021 17:01:56 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:50625 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbhDUVB4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Apr 2021 17:01:56 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 09DD2564EEF
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 23:01:20 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id d124so30019805pfa.13
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 14:01:19 -0700 (PDT)
X-Gm-Message-State: AOAM530uGjbwICfPrBCYMUI4Y2vJzKttaov44U/Qf1EnsFu8YBfkuIb1
        UBrH3NaPLm7C5TSkF7nnJ7EQJXniCIDn9hMTZaQ=
X-Google-Smtp-Source: ABdhPJzDZ2i7yYPhD5d1N3GeGEvBa/QPFrmYhn3Dqo14IQgNj2B8AyPbi+w7HrMdCqBl5tM7nSfcw3jxYq9QT+gDN2E=
X-Received: by 2002:a17:90b:34c:: with SMTP id fh12mr33730pjb.114.1619038878619;
 Wed, 21 Apr 2021 14:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210421172112.13277-1-jwcart2@gmail.com>
In-Reply-To: <20210421172112.13277-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 21 Apr 2021 23:01:07 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kL1A3xtCLBC=LhxAtRfmkehit5f3retC6jOJuzbC958A@mail.gmail.com>
Message-ID: <CAJfZ7=kL1A3xtCLBC=LhxAtRfmkehit5f3retC6jOJuzbC958A@mail.gmail.com>
Subject: Re: [PATCH 0/3 v3] Create secil2tree to write CIL AST
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Apr 21 23:01:20 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 21, 2021 at 7:21 PM James Carter <jwcart2@gmail.com> wrote:
>
> For debugging purposes it would be useful to be able to write out
> the CIL AST at various points in the build process.
>
> This patch set creates secil2tree which can write the CIL parse tree,
> the CIL AST after the build phase, or the CIL AST after the resolve
> phase (with names fully-qualified).
>
> Within CIL the function cil_print_tree() has existed from early in
> CIL's development, but it was not exported in libsepol and there was no
> way to use it except by adding a call to it where you wanted to print
> out the CIL AST and then recompiling everything. It also used cil_log()
> as its output, so other messages could be mixed in with the output. This
> patch set moves all of this code to its own file, updates it, renames it
> as cil_write_ast(), and adds libsepol functions that can be used to call
> it after each one of the phases mentioned above.
>
> Both the parse and build CIL AST are valid CIL policies that can be
> compiled with secilc, but the resolve CIL AST is not always a valid CIL
> policy. The biggest problem is that fully-qualified names can contain
> dots and CIL does not allow dots in declaration names. There are other
> problems as well. It would be nice to get to the point where the output
> for all of the trees are valid CIL, but that is a goal for the future.
>
> v3:
> - -use "-ast-phase=<phase>" in the usage message and man pages instead
> of "-ast-phase <phase>"
>
> v2:
> - Remove whitespace errors in cil_write_ast.h
> - Use "const char*" instead of just "char*" when dealing with string
> literals to satisfy clang.
>
> James Carter (3):
>   libsepol/cil: Create functions to write the CIL AST
>   libsepol/cil: Add functions to make use of cil_write_ast()
>   secilc: Create the new program called secil2tree to write out CIL AST
>
>  libsepol/cil/include/cil/cil.h   |    3 +
>  libsepol/cil/src/cil.c           |   92 ++
>  libsepol/cil/src/cil_tree.c      | 1471 ----------------------------
>  libsepol/cil/src/cil_tree.h      |    2 -
>  libsepol/cil/src/cil_write_ast.c | 1573 ++++++++++++++++++++++++++++++
>  libsepol/cil/src/cil_write_ast.h |   46 +
>  libsepol/src/libsepol.map.in     |    3 +
>  secilc/.gitignore                |    2 +
>  secilc/Makefile                  |   20 +-
>  secilc/secil2tree.8.xml          |   81 ++
>  secilc/secil2tree.c              |  206 ++++
>  11 files changed, 2024 insertions(+), 1475 deletions(-)
>  create mode 100644 libsepol/cil/src/cil_write_ast.c
>  create mode 100644 libsepol/cil/src/cil_write_ast.h
>  create mode 100644 secilc/secil2tree.8.xml
>  create mode 100644 secilc/secil2tree.c
>
> --
> 2.26.3
>

I indeed missed the v2, sorry for this.
These patches look good to me, thanks!

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

