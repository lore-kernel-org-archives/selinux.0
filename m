Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD95BC282D8
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 20:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBA920863
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 20:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfBAUZL convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Fri, 1 Feb 2019 15:25:11 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:45664 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfBAUZL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Feb 2019 15:25:11 -0500
Received: by mail-oi1-f176.google.com with SMTP id y1so6834383oie.12
        for <selinux@vger.kernel.org>; Fri, 01 Feb 2019 12:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TNKLTQdSK6kXDL5j6jx84vR+4SwVVInI/FR9p7j1ykU=;
        b=XIr0URtlHgUAEPUVNsQbLTHxw0d0vz4506QP730t3lgq96crdcAKrgYkGu7b/gKWkf
         M5d7dB+rOrSIsY3VXApSAl2trn0g55ADIe+9bemL1P8tuc7M44EVrBPhTMdzCQK3VS8v
         Q9kFFIpMHEJfcNmqgXqbRJQohN5sdQZjfPwDhn6WpHk0+IgJJlWGpLKF1gOEDXWBWxlf
         Gt8A6TddXmk5+hGM9lv15jxUb1y4f8d3UYl2G21Q5OwnhU3uOhqxLA6AyDm01DXdKqXy
         NAsH7nV8yinUYMaUegHm9AZkf1rF8d7EZQfWMMaD4NU8iPJcDXIefp1reTB2W8TAfUsF
         tNSg==
X-Gm-Message-State: AJcUukcgkerl2uOBKfJfQqO0E0vRYsB9d5jA+Itq+5mv+qDsOvNEC6TA
        KFVhs3qq3afOluG4r9BEOnGSlyqrAMXwwhbTVwyAyQ==
X-Google-Smtp-Source: ALg8bN5Ww4u28w6tedjX0CvbzMbubHeYh3VQaIdTvpBFjRTv6mZD/xz5nrzQvaafFvVBne6pAUgxwHr0kV4xdMbzhHw=
X-Received: by 2002:aca:3b43:: with SMTP id i64mr19883419oia.156.1549052710028;
 Fri, 01 Feb 2019 12:25:10 -0800 (PST)
MIME-Version: 1.0
References: <pjdtvhns3pq.fsf@redhat.com>
In-Reply-To: <pjdtvhns3pq.fsf@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 1 Feb 2019 21:24:59 +0100
Message-ID: <CAFqZXNt8Df0KX9qVmsGtxZroy6s1SFBt1Qmi5Psuv6z0+kTB7Q@mail.gmail.com>
Subject: Re: gcc 9.0.0 build issues
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 1, 2019 at 8:36 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> gcc-9.0.0-0.3.fc30.x86_64 from Fedora Rawhide:
>
> gcc version 9.0.0 20190119 (Red Hat 9.0.0-0.3) (GCC)
>
> $ make DESTDIR=~/obj install install-pywrap
> ...
>
> make[2]: Entering directory
> '/home/build/SELinuxProject-selinux/libsepol/src'
> cc -O2 -Werror -Wall -Wextra -Wmissing-format-attribute
> -Wmissing-noreturn -Wpointer-arith -Wshadow -Wstrict-prototypes
> -Wundef -Wunused -Wwrite-strings -I. -I../include -D_GNU_SOURCE
> -I../cil/include -fPIC -c -o genbools.o genbools.c
> In function ‘strtrim’,
>     inlined from ‘process_boolean.constprop’ at genbools.c:52:2:
> genbools.c:24:2: error: ‘strncpy’ output may be truncated copying
> 8191 bytes from a string of length 8191
> [-Werror=stringop-truncation]
>    24 |  strncpy(dest, ptr, size);
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~
>

This is a typical strncpy() abuse. See 'man strncpy' -> /NOTES for how
to handle the corner case correctly (same for similar issues below).

> ...
>
> make[2]: Entering directory
> '/home/build/SELinuxProject-selinux/libsepol/src'
> cc -O2 -Werror -Wall -Wextra -Wmissing-format-attribute
> -Wmissing-noreturn -Wpointer-arith -Wshadow -Wstrict-prototypes
> -Wundef -Wunused -Wwrite-strings -I. -I../include -D_GNU_SOURCE
> -I../cil/include -fPIC -DSHARED -c -o genbools.lo genbools.c
> In function ‘strtrim’,
>     inlined from ‘process_boolean.constprop’ at genbools.c:52:2:
> genbools.c:24:2: error: ‘strncpy’ output may be truncated copying
> 8191 bytes from a string of length 8191
> [-Werror=stringop-truncation]
>    24 |  strncpy(dest, ptr, size);
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~
>
> ...
>
> make[2]: Entering directory
> '/home/build/SELinuxProject-selinux/libselinux/src'
> cc -O2 -Werror -Wall -Wextra -Wmissing-format-attribute
> -Wmissing-noreturn -Wpointer-arith -Wshadow -Wstrict-prototypes
> -Wundef -Wunused -Wwrite-strings -I../include -D_GNU_SOURCE
> -DNO_ANDROID_BACKEND   -c -o booleans.o booleans.c
> In function ‘strtrim’,
>     inlined from ‘process_boolean’ at booleans.c:362:2:
> booleans.c:335:2: error: ‘strncpy’ output may be truncated copying
> between 8188 and 8191 bytes from a string of length 8191
> [-Werror=stringop-truncation]
>   335 |  strncpy(dest, ptr, size);
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~
>
> ...
>
>
>
> When libselinux is built separately, other CFLAGS is used:
>
> $ cd libselinux
>
> $ make DESTDIR=~/obj install install-pywrap
> ...
>
> make[1]: Entering directory
> '/home/build/SELinuxProject-selinux/libselinux/src'
>
> cc -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self
> -Wmissing-include-dirs -Wunused -Wunknown-pragmas
> -Wstrict-aliasing -Wshadow -Wpointer-arith -Wbad-function-cast
> -Wcast-align -Wwrite-strings -Waggregate-return
> -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes
> -Wmissing-declarations -Wmissing-noreturn
> -Wmissing-format-attribute -Wredundant-decls -Wnested-externs
> -Winline -Winvalid-pch -Wvolatile-register-var
> -Wdisabled-optimization -Wbuiltin-macro-redefined -Wattributes
> -Wmultichar -Wdeprecated-declarations -Wdiv-by-zero
> -Wdouble-promotion -Wendif-labels -Wextra -Wformat-extra-args
> -Wformat-zero-length -Wformat=2 -Wmultichar -Woverflow
> -Wpointer-to-int-cast -Wpragmas -Wno-missing-field-initializers
> -Wno-sign-compare -Wno-format-nonliteral -Wframe-larger-than=32768
> -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions
> -fasynchronous-unwind-tables -fdiagnostics-show-option
> -funit-at-a-time -Werror -Wno-aggregate-return
> -Wno-redundant-decls -fipa-pure-const -Wlogical-op
> -Wpacked-bitfield-compat -Wsync-nand -Wcoverage-mismatch -Wcpp
> -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const
> -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
> -Wtrampolines -Wjump-misses-init -Wno-suggest-attribute=pure
> -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2
> -Wstrict-overflow=5 -I../include -D_GNU_SOURCE
> -DNO_ANDROID_BACKEND   -c -o booleans.o booleans.c
> booleans.c: In function ‘security_get_boolean_names’:
> booleans.c:39:5: error: assuming signed overflow does not occur
> when changing X +- C1 cmp C2 to X cmp C2 -+ C1
> [-Werror=strict-overflow]
>    39 | int security_get_boolean_names(char ***names, int *len)
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

This one is really weird... Perhaps a bug in GCC? At the very least
the warning message and source code location are super confusing,
which is a bug on its own...

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
