Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B140C433B4
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 16:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D66F61449
	for <selinux@archiver.kernel.org>; Wed, 21 Apr 2021 16:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbhDUQ4J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Apr 2021 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241421AbhDUQ4J (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Apr 2021 12:56:09 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14FAC06174A
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 09:55:34 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 5-20020a9d09050000b029029432d8d8c5so13585398otp.11
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QeI692biWD6cT+rJtvi5co6T0TasrK/WR+jEi+dcMFk=;
        b=an4zmzG8FWGJIJLpIU+FUnhk8rSiyCndFrGkJDDjQhRIqfrF7/9WGlVknyYXBEd08c
         ikbCCacTj4jZ2qxpVZQrKGSjzTDvuhkkjHVi93noXOZsgVGY0dIxJwVNMW/ynDEhKndF
         g9TU04NqikgN0c+rCOhBTE2MMXetBjn9y2OlzbJz9d9duJR+VyV+Qq9Z66dnVRusdOoI
         a2GMul/W5ZC7jD5ZEBPF0L12RXjSPNccVYYg9g5180IXHQyrAJ0CpyO4w3fsC7XNlMJf
         e6ZrRi13sB4uY3fcn4JsTl4uhTZu/klMO824D5zthH2TRaMswqFC1hPtxiOmuVn61Box
         /ZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QeI692biWD6cT+rJtvi5co6T0TasrK/WR+jEi+dcMFk=;
        b=l9UN2nTjYVtLAiUi128qGY3SBqCQLWi6kjB+Ji+2RcYC3PqaJzp5X/FYvVwt3P7+tX
         JOeYYKoiYwIg7/ua/80zmz5k01G8/3b8h0tiU2+N9+DDGcTG8rwOwVplmtjgTSZWqMIG
         cNJTLm7wWcr03IyRl/fumGhJiw/whVh7sOsXkC8w9yKxKqC6Zh9d4Vf/MLLS9rQLeUdy
         9kzmnnfTvyELg0s66Dt6HbYWYctxSp0Pgfs2ofI3aKVK0Q0DUOGbPRDvDYwCGCjsmvmM
         l3VEIZpScDbrBViKNir9yG3ysLwYqzfOxOcevbh+iUBajkEcVJVnKQhJs6+2CqO8SVrM
         sXpw==
X-Gm-Message-State: AOAM531BD/Hxa2Rb07XvuMiYnpHj7l45HmovwFys1a/xON3Vhv/lMfp4
        Xs4aKvAnXnuJnTwisJ+byCt1gu/LnW6eqLPLJ0h2IBxFVHo=
X-Google-Smtp-Source: ABdhPJzDtzKTfXauAym2Wbxb9kD4IBs5uU/t6zPyunR8mJ+pvk4PSr4W2pLCy9+I/UJw93Y3HaU1sVI2AJq3JesPEPQ=
X-Received: by 2002:a05:6830:1beb:: with SMTP id k11mr9447691otb.59.1619024133818;
 Wed, 21 Apr 2021 09:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210419152749.88086-1-jwcart2@gmail.com> <20210419152749.88086-4-jwcart2@gmail.com>
 <CAJfZ7==05kJ75EAS+WYvnPRcDGB8PJvfp4OBH8eAPVWR7dscrQ@mail.gmail.com>
In-Reply-To: <CAJfZ7==05kJ75EAS+WYvnPRcDGB8PJvfp4OBH8eAPVWR7dscrQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 21 Apr 2021 12:55:22 -0400
Message-ID: <CAP+JOzQWEJxbwR+28jiFrNR=36AZ9pk5XudX2yJkZDKhZKMVmw@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] secilc: Create the new program called secil2tree
 to write out CIL AST
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 21, 2021 at 4:52 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Mon, Apr 19, 2021 at 5:28 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > secil2tree is the SELinux CIL AST writer. It calls the cil functions
> > cil_write_parse_ast(), cil_write_build_ast(), or cil_write_resolve_ast()
> > to write out the parse tree, the CIL AST after the build phase, or the
> > CIL AST after the resolve phase.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  secilc/.gitignore       |   2 +
> >  secilc/Makefile         |  20 +++-
> >  secilc/secil2tree.8.xml |  81 ++++++++++++++++
> >  secilc/secil2tree.c     | 206 ++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 307 insertions(+), 2 deletions(-)
> >  create mode 100644 secilc/secil2tree.8.xml
> >  create mode 100644 secilc/secil2tree.c
> >
> > [...]
> > diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
> > new file mode 100644
> > index 00000000..1f55d08a
> > --- /dev/null
> > +++ b/secilc/secil2tree.c
> > @@ -0,0 +1,206 @@
> > +/*
> > + * Copyright 2011 Tresys Technology, LLC. All rights reserved.
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following conditions are met:
> > + *
> > + *    1. Redistributions of source code must retain the above copyright notice,
> > + *       this list of conditions and the following disclaimer.
> > + *
> > + *    2. Redistributions in binary form must reproduce the above copyright notice,
> > + *       this list of conditions and the following disclaimer in the documentation
> > + *       and/or other materials provided with the distribution.
> > + *
> > + * THIS SOFTWARE IS PROVIDED BY TRESYS TECHNOLOGY, LLC ``AS IS'' AND ANY EXPRESS
> > + * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> > + * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
> > + * EVENT SHALL TRESYS TECHNOLOGY, LLC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
> > + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
> > + * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> > + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> > + * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
> > + * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
> > + * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > + *
> > + * The views and conclusions contained in the software and documentation are those
> > + * of the authors and should not be interpreted as representing official policies,
> > + * either expressed or implied, of Tresys Technology, LLC.
> > + */
> > +
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <stdint.h>
> > +#include <string.h>
> > +#include <getopt.h>
> > +#include <sys/stat.h>
> > +
> > +#ifdef ANDROID
> > +#include <cil/cil.h>
> > +#else
> > +#include <sepol/cil/cil.h>
> > +#endif
> > +#include <sepol/policydb.h>
> > +
> > +enum write_ast_phase {
> > +       WRITE_AST_PHASE_PARSE = 0,
> > +       WRITE_AST_PHASE_BUILD,
> > +       WRITE_AST_PHASE_RESOLVE,
> > +};
> > +
> > +static __attribute__((__noreturn__)) void usage(const char *prog)
> > +{
> > +       printf("Usage: %s [OPTION]... FILE...\n", prog);
> > +       printf("\n");
> > +       printf("Options:\n");
> > +       printf("  -o, --output=<file>      write AST to <file>. (default: stdout)\n");
> > +       printf("  -P, --preserve-tunables  treat tunables as booleans\n");
> > +       printf("  -A, --ast-phase <phase>  write AST of phase <phase>. Phase must be parse, \n");
> > +       printf("                           build, or resolve. (default: resolve)\n");
> > +       printf("  -v, --verbose            increment verbosity level\n");
> > +       printf("  -h, --help               display usage information\n");
> > +       exit(1);
>
> Small thing: --output is documented with an equal sign
> ("--output=<file>") while --ast-phase is with a space ("--ast-phase
> <phase>"), both in the usage function and in the man page. Is this
> inconsistency intentional?
>

No, I think for consistency the "=" should be used.

Thanks,
Jim

> The rest of this patch looks good to me. I have other comments on the
> series, that I will send.
> Thanks,
> Nicolas
>
