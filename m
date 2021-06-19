Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7FEC2B9F4
	for <selinux@archiver.kernel.org>; Sat, 19 Jun 2021 14:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D784461004
	for <selinux@archiver.kernel.org>; Sat, 19 Jun 2021 14:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhFSOWB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 19 Jun 2021 10:22:01 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:60804 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhFSOWA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 19 Jun 2021 10:22:00 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 22CDD560696
        for <selinux@vger.kernel.org>; Sat, 19 Jun 2021 16:19:48 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id c15so6070923pls.13
        for <selinux@vger.kernel.org>; Sat, 19 Jun 2021 07:19:48 -0700 (PDT)
X-Gm-Message-State: AOAM530Cj37tkIYJWCp98OjaSHE+71nQivWP2QDNAZSG1cARUbQZYhT1
        o0gUiQm4bTrQhDnJ4BXH+yUGiMvtlxwXCGGdDkE=
X-Google-Smtp-Source: ABdhPJwgxNpj/i3OcXN3nfQ+AcMLU5IzXZipQ9QO2hbQvA/1RGl3gRnsZ4kTHac3LLj248gYwYEy5apzJCrE/yo1smg=
X-Received: by 2002:a17:90b:3e89:: with SMTP id rj9mr16420786pjb.114.1624112386784;
 Sat, 19 Jun 2021 07:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210615185655.34064-1-jwcart2@gmail.com>
In-Reply-To: <20210615185655.34064-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 19 Jun 2021 16:19:35 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=n476qTnveGzqXCFzbD1P_OWE=CXZ0mSrnyoFOu2kUp9g@mail.gmail.com>
Message-ID: <CAJfZ7=n476qTnveGzqXCFzbD1P_OWE=CXZ0mSrnyoFOu2kUp9g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix problems with CIL's handling of anonymous call arguments
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jun 19 16:19:48 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 15, 2021 at 8:57 PM James Carter <jwcart2@gmail.com> wrote:
>
> For more information on anonymous call arguments, see the third patch.
>
> The first two patches fix a couple of bugs in the handling of anonymous
> call arguments.
>
> The last patch adds a test policy that can be used to test the handling
> of anonymouse call arguments.
>
> James Carter (3):
>   libsepol/cil: Fix anonymous IP address call arguments
>   libsepol/cil: Account for anonymous category sets in an expression
>   secilc/test: Add test for anonymous args
>
>  libsepol/cil/src/cil_build_ast.c   |   4 --
>  libsepol/cil/src/cil_resolve_ast.c |  47 +++++++------
>  secilc/test/anonymous_arg_test.cil | 106 +++++++++++++++++++++++++++++
>  3 files changed, 133 insertions(+), 24 deletions(-)
>  create mode 100644 secilc/test/anonymous_arg_test.cil
>
> --
> 2.26.3

For these 3 patches:

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

