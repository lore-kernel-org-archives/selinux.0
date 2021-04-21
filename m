Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AA3C433B4
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 08:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E576143B
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 08:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhDUIxE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Apr 2021 04:53:04 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:57143 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbhDUIxD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Apr 2021 04:53:03 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 0FEA0564C61
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 10:52:29 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id u15so12706010plf.10
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 01:52:28 -0700 (PDT)
X-Gm-Message-State: AOAM531rhiUQrYLmjle6qn4PRgXidWJ3NlifCy0d0SLLwtiXEBHKTrNl
        WUlyANqkRp3siy67h+0leTwjrHPGaQt+Qxq5/Tk=
X-Google-Smtp-Source: ABdhPJyJjxLx9CmdYe2ZEC7Us7aM/FinLrBJ1mnjKJBTaMggMRTt53Y+FaGJiAft7ub2TL4F4aPsWsZoNakOO6gcN2Y=
X-Received: by 2002:a17:902:ed83:b029:ec:7aa8:439d with SMTP id
 e3-20020a170902ed83b02900ec7aa8439dmr26777346plj.28.1618995147798; Wed, 21
 Apr 2021 01:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210419152749.88086-1-jwcart2@gmail.com> <20210419152749.88086-4-jwcart2@gmail.com>
In-Reply-To: <20210419152749.88086-4-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 21 Apr 2021 10:52:16 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==05kJ75EAS+WYvnPRcDGB8PJvfp4OBH8eAPVWR7dscrQ@mail.gmail.com>
Message-ID: <CAJfZ7==05kJ75EAS+WYvnPRcDGB8PJvfp4OBH8eAPVWR7dscrQ@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] secilc: Create the new program called secil2tree
 to write out CIL AST
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Apr 21 10:52:29 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 19, 2021 at 5:28 PM James Carter <jwcart2@gmail.com> wrote:
>
> secil2tree is the SELinux CIL AST writer. It calls the cil functions
> cil_write_parse_ast(), cil_write_build_ast(), or cil_write_resolve_ast()
> to write out the parse tree, the CIL AST after the build phase, or the
> CIL AST after the resolve phase.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  secilc/.gitignore       |   2 +
>  secilc/Makefile         |  20 +++-
>  secilc/secil2tree.8.xml |  81 ++++++++++++++++
>  secilc/secil2tree.c     | 206 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 307 insertions(+), 2 deletions(-)
>  create mode 100644 secilc/secil2tree.8.xml
>  create mode 100644 secilc/secil2tree.c
>
> [...]
> diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
> new file mode 100644
> index 00000000..1f55d08a
> --- /dev/null
> +++ b/secilc/secil2tree.c
> @@ -0,0 +1,206 @@
> +/*
> + * Copyright 2011 Tresys Technology, LLC. All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *
> + *    1. Redistributions of source code must retain the above copyright notice,
> + *       this list of conditions and the following disclaimer.
> + *
> + *    2. Redistributions in binary form must reproduce the above copyright notice,
> + *       this list of conditions and the following disclaimer in the documentation
> + *       and/or other materials provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY TRESYS TECHNOLOGY, LLC ``AS IS'' AND ANY EXPRESS
> + * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> + * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
> + * EVENT SHALL TRESYS TECHNOLOGY, LLC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
> + * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> + * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
> + * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
> + * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + * The views and conclusions contained in the software and documentation are those
> + * of the authors and should not be interpreted as representing official policies,
> + * either expressed or implied, of Tresys Technology, LLC.
> + */
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <sys/stat.h>
> +
> +#ifdef ANDROID
> +#include <cil/cil.h>
> +#else
> +#include <sepol/cil/cil.h>
> +#endif
> +#include <sepol/policydb.h>
> +
> +enum write_ast_phase {
> +       WRITE_AST_PHASE_PARSE = 0,
> +       WRITE_AST_PHASE_BUILD,
> +       WRITE_AST_PHASE_RESOLVE,
> +};
> +
> +static __attribute__((__noreturn__)) void usage(const char *prog)
> +{
> +       printf("Usage: %s [OPTION]... FILE...\n", prog);
> +       printf("\n");
> +       printf("Options:\n");
> +       printf("  -o, --output=<file>      write AST to <file>. (default: stdout)\n");
> +       printf("  -P, --preserve-tunables  treat tunables as booleans\n");
> +       printf("  -A, --ast-phase <phase>  write AST of phase <phase>. Phase must be parse, \n");
> +       printf("                           build, or resolve. (default: resolve)\n");
> +       printf("  -v, --verbose            increment verbosity level\n");
> +       printf("  -h, --help               display usage information\n");
> +       exit(1);

Small thing: --output is documented with an equal sign
("--output=<file>") while --ast-phase is with a space ("--ast-phase
<phase>"), both in the usage function and in the man page. Is this
inconsistency intentional?

The rest of this patch looks good to me. I have other comments on the
series, that I will send.
Thanks,
Nicolas

