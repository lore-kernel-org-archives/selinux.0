Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B4DC282C2
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 15:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A932073F
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 15:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfBGPcw convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Thu, 7 Feb 2019 10:32:52 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34656 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBGPcw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Feb 2019 10:32:52 -0500
Received: by mail-ot1-f41.google.com with SMTP id t5so474056otk.1
        for <selinux@vger.kernel.org>; Thu, 07 Feb 2019 07:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S6P8YXxSC5APjNAoEvfzUZ4jiKX2mUJbqZV/BV1UKuw=;
        b=MOtPYoplJLU0pW/Yg8CmQdyEJVctH1uT1W9rI9m/eGjlwUzP+Cj8m/3BMVdW2SdN3/
         O2452OeWpqK/gKOd4SYwcKjFhVIP6RbmhOXzyjOOJaYEZIisSGnh0zl1TwEyflW5TI6Z
         lTSX59twV3j/n4FU/4Zcd2VQWvrJq9DvkfZ2+xbezsLMnf6ylcYAD56F2atfqw4iWUId
         pJJk5vOwfoUMwN74uwWV1Q6K4d/Kpai2OPR9QxH05aF2n8hnzQXSQSzXt9KruiZHOpiL
         9E9udpFgIfZbqq19CA9U6hSNkfv/kbTGcNRa8sV4LD5yypZ4Y8W+i8Dip9lb9TFnxQOe
         +CAQ==
X-Gm-Message-State: AHQUAuaX3CeJAxAEhyiQ6srgwHxvBuMaWWgocr58NY0NUlp9opPbj5py
        YYtlgLB39slwzJRf9vzj1vmvKj6kMkylfqIbwcfCpg==
X-Google-Smtp-Source: AHgI3IZg8OFWk2L7LkfMVpjnBjJI3yx+kGvYFCYQO9U8R5zz/wJuXcs1jIE1kTCI15vN2DiqTzEGYEhPDmi2ohL/ZyM=
X-Received: by 2002:aca:6206:: with SMTP id w6mr622203oib.132.1549553570662;
 Thu, 07 Feb 2019 07:32:50 -0800 (PST)
MIME-Version: 1.0
References: <pjdtvhns3pq.fsf@redhat.com> <CAFqZXNt8Df0KX9qVmsGtxZroy6s1SFBt1Qmi5Psuv6z0+kTB7Q@mail.gmail.com>
In-Reply-To: <CAFqZXNt8Df0KX9qVmsGtxZroy6s1SFBt1Qmi5Psuv6z0+kTB7Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 7 Feb 2019 16:32:39 +0100
Message-ID: <CAFqZXNvBWzqs-kV5ES_He92kDvXUm0Re_3WzGiKoLBE_0dJVUg@mail.gmail.com>
Subject: Re: gcc 9.0.0 build issues
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 1, 2019 at 9:24 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Feb 1, 2019 at 8:36 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> > gcc-9.0.0-0.3.fc30.x86_64 from Fedora Rawhide:
> >
> > gcc version 9.0.0 20190119 (Red Hat 9.0.0-0.3) (GCC)
> >
> > $ make DESTDIR=~/obj install install-pywrap
> > ...
> >
> > make[2]: Entering directory
> > '/home/build/SELinuxProject-selinux/libsepol/src'
> > cc -O2 -Werror -Wall -Wextra -Wmissing-format-attribute
> > -Wmissing-noreturn -Wpointer-arith -Wshadow -Wstrict-prototypes
> > -Wundef -Wunused -Wwrite-strings -I. -I../include -D_GNU_SOURCE
> > -I../cil/include -fPIC -c -o genbools.o genbools.c
> > In function ‘strtrim’,
> >     inlined from ‘process_boolean.constprop’ at genbools.c:52:2:
> > genbools.c:24:2: error: ‘strncpy’ output may be truncated copying
> > 8191 bytes from a string of length 8191
> > [-Werror=stringop-truncation]
> >    24 |  strncpy(dest, ptr, size);
> >       |  ^~~~~~~~~~~~~~~~~~~~~~~~
> >
>
> This is a typical strncpy() abuse. See 'man strncpy' -> /NOTES for how
> to handle the corner case correctly (same for similar issues below).

Actually, upon closer look it looks like there is no abuse and the
warning simply warns that only a part of the string might be copied
into the destination. I suppose we don't care about that possibility
here, so the best way to resolve the warning might be to just disable
the warning for this part of the code.

>
> > ...
> >
> > make[2]: Entering directory
> > '/home/build/SELinuxProject-selinux/libsepol/src'
> > cc -O2 -Werror -Wall -Wextra -Wmissing-format-attribute
> > -Wmissing-noreturn -Wpointer-arith -Wshadow -Wstrict-prototypes
> > -Wundef -Wunused -Wwrite-strings -I. -I../include -D_GNU_SOURCE
> > -I../cil/include -fPIC -DSHARED -c -o genbools.lo genbools.c
> > In function ‘strtrim’,
> >     inlined from ‘process_boolean.constprop’ at genbools.c:52:2:
> > genbools.c:24:2: error: ‘strncpy’ output may be truncated copying
> > 8191 bytes from a string of length 8191
> > [-Werror=stringop-truncation]
> >    24 |  strncpy(dest, ptr, size);
> >       |  ^~~~~~~~~~~~~~~~~~~~~~~~
> >
> > ...
> >
> > make[2]: Entering directory
> > '/home/build/SELinuxProject-selinux/libselinux/src'
> > cc -O2 -Werror -Wall -Wextra -Wmissing-format-attribute
> > -Wmissing-noreturn -Wpointer-arith -Wshadow -Wstrict-prototypes
> > -Wundef -Wunused -Wwrite-strings -I../include -D_GNU_SOURCE
> > -DNO_ANDROID_BACKEND   -c -o booleans.o booleans.c
> > In function ‘strtrim’,
> >     inlined from ‘process_boolean’ at booleans.c:362:2:
> > booleans.c:335:2: error: ‘strncpy’ output may be truncated copying
> > between 8188 and 8191 bytes from a string of length 8191
> > [-Werror=stringop-truncation]
> >   335 |  strncpy(dest, ptr, size);
> >       |  ^~~~~~~~~~~~~~~~~~~~~~~~
> >
> > ...
> >
> >
> >
> > When libselinux is built separately, other CFLAGS is used:
> >
> > $ cd libselinux
> >
> > $ make DESTDIR=~/obj install install-pywrap
> > ...
> >
> > make[1]: Entering directory
> > '/home/build/SELinuxProject-selinux/libselinux/src'
> >
> > cc -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self
> > -Wmissing-include-dirs -Wunused -Wunknown-pragmas
> > -Wstrict-aliasing -Wshadow -Wpointer-arith -Wbad-function-cast
> > -Wcast-align -Wwrite-strings -Waggregate-return
> > -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes
> > -Wmissing-declarations -Wmissing-noreturn
> > -Wmissing-format-attribute -Wredundant-decls -Wnested-externs
> > -Winline -Winvalid-pch -Wvolatile-register-var
> > -Wdisabled-optimization -Wbuiltin-macro-redefined -Wattributes
> > -Wmultichar -Wdeprecated-declarations -Wdiv-by-zero
> > -Wdouble-promotion -Wendif-labels -Wextra -Wformat-extra-args
> > -Wformat-zero-length -Wformat=2 -Wmultichar -Woverflow
> > -Wpointer-to-int-cast -Wpragmas -Wno-missing-field-initializers
> > -Wno-sign-compare -Wno-format-nonliteral -Wframe-larger-than=32768
> > -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions
> > -fasynchronous-unwind-tables -fdiagnostics-show-option
> > -funit-at-a-time -Werror -Wno-aggregate-return
> > -Wno-redundant-decls -fipa-pure-const -Wlogical-op
> > -Wpacked-bitfield-compat -Wsync-nand -Wcoverage-mismatch -Wcpp
> > -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const
> > -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
> > -Wtrampolines -Wjump-misses-init -Wno-suggest-attribute=pure
> > -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2
> > -Wstrict-overflow=5 -I../include -D_GNU_SOURCE
> > -DNO_ANDROID_BACKEND   -c -o booleans.o booleans.c
> > booleans.c: In function ‘security_get_boolean_names’:
> > booleans.c:39:5: error: assuming signed overflow does not occur
> > when changing X +- C1 cmp C2 to X cmp C2 -+ C1
> > [-Werror=strict-overflow]
> >    39 | int security_get_boolean_names(char ***names, int *len)
> >       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
>
> This one is really weird... Perhaps a bug in GCC? At the very least
> the warning message and source code location are super confusing,
> which is a bug on its own...
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Associate Software Engineer, Security Technologies
> Red Hat, Inc.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
