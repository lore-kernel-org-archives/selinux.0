Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724AAC6FA83
	for <selinux@archiver.kernel.org>; Mon, 12 Sep 2022 13:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiILNln (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Sep 2022 09:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiILNlm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Sep 2022 09:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C6A3055B
        for <selinux@vger.kernel.org>; Mon, 12 Sep 2022 06:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662990099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CzZXBUeeVggMg01PsaFQ/n8nUSxEcwu883eJSMWzsEw=;
        b=D47uExlA8cmvLCkOX+QdqeeKoV0QZAMe6YkBfB6dEUZufB/GTe7+hOQI6mojDH2+ToYZoN
        0V8ZSfFARl8YO9czLaSPA0rafFZAHPjgia86DTYlQ1WbD154nANYUMqHEn6YprLY2TCGQ4
        Ua2W3ZZmUxsL/lyBZEcOaIbXb/UDTB8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-379-KU6PDnN_MvqhV2_heGJtbA-1; Mon, 12 Sep 2022 09:41:38 -0400
X-MC-Unique: KU6PDnN_MvqhV2_heGJtbA-1
Received: by mail-pg1-f197.google.com with SMTP id m188-20020a633fc5000000b00434dccacd4aso4018351pga.10
        for <selinux@vger.kernel.org>; Mon, 12 Sep 2022 06:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CzZXBUeeVggMg01PsaFQ/n8nUSxEcwu883eJSMWzsEw=;
        b=W2G7xR/PL+t7GQFKQwpWOAT/S2of6yoakAOedtO4iNExxcq8/A/nik/BMo7r6JCjc/
         EFB1NX9XLxYGel+zp2AKiDWBc7ceKu1qGhWK+eLTqw5dt61Ej5pee+Xp4sPSFQMRRrj4
         kSRPiEhQHEX+AlCVSwEY5kk4ka8ZJL+PDIOHHYxK1gD4Hi1KPf566K84qTn0fuAAGzwx
         1nc2JfG7eWEGasKM+3t8FYHTl7vGWvxwXRQ5kB2wiwcGd9iOItcCk3sTqAugJxSDdQuD
         QdIx+gxYI/Qb9DY8xenGDFFn0kn0i8zBOMyEZvkJEa5WD6sHng4wlxfYvhcwcR4qPTn0
         hzNw==
X-Gm-Message-State: ACgBeo18n1ruk9WY3hsVR+5FisKXVyMDZYcvfjju1hTh4d5RUiJoluG/
        O6IgO+MbyHF1jhNzIDzeBYcPDFoEXtRoNEPyQuM+d6mFx+FY6q8zWW5HqzDkqyzwNnyUF+t1yWd
        /HvQ9D+0L7dvO0jatQuydkF34Vg0uM2cZag==
X-Received: by 2002:a17:90b:2545:b0:1fd:92d6:62da with SMTP id nw5-20020a17090b254500b001fd92d662damr24304554pjb.239.1662990097660;
        Mon, 12 Sep 2022 06:41:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5HPD1ThJOTSdpYycgnKlhjXYVJWO1FKtI9kqmOLtNq1GJLpmPFzkHPI0O6xOMrBDTgr57YzNHS81LEOLR5ySQ=
X-Received: by 2002:a17:90b:2545:b0:1fd:92d6:62da with SMTP id
 nw5-20020a17090b254500b001fd92d662damr24304531pjb.239.1662990097365; Mon, 12
 Sep 2022 06:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220831153432.710929-1-cgzones@googlemail.com>
In-Reply-To: <20220831153432.710929-1-cgzones@googlemail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 12 Sep 2022 15:41:26 +0200
Message-ID: <CAFqZXNtPs=SWnjjbySWf+Yi88R3p0ebLBjB9-2DGsirrU+iEpg@mail.gmail.com>
Subject: Re: [PATCH v2] tests/secretmem: add test
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 31, 2022 at 5:34 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> Add test for memfd_secret(2) anonymous inodes check added in 6.0 via
> 2bfe15c52612 ("mm: create security context for memfd_secret inodes").
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>    - print mmap failures to stdout, since they are expected when
>      mapping with PROT_EXEC
> ---
>  .github/workflows/checks.yml |  4 ++
>  Vagrantfile                  | 10 +++--
>  policy/Makefile              |  4 ++
>  policy/test_secretmem.te     | 33 ++++++++++++++
>  tests/Makefile               |  5 +++
>  tests/secretmem/.gitignore   |  1 +
>  tests/secretmem/Makefile     |  5 +++
>  tests/secretmem/secretmem.c  | 83 ++++++++++++++++++++++++++++++++++++
>  tests/secretmem/test         | 39 +++++++++++++++++
>  9 files changed, 180 insertions(+), 4 deletions(-)
>  create mode 100644 policy/test_secretmem.te
>  create mode 100644 tests/secretmem/.gitignore
>  create mode 100644 tests/secretmem/Makefile
>  create mode 100644 tests/secretmem/secretmem.c
>  create mode 100755 tests/secretmem/test

This looks good to me, with some minor comments below.

> diff --git a/tests/secretmem/secretmem.c b/tests/secretmem/secretmem.c
> new file mode 100644
> index 0000000..0d541ee
> --- /dev/null
> +++ b/tests/secretmem/secretmem.c
> @@ -0,0 +1,83 @@
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +
> +#ifndef __NR_memfd_secret
> +# define __NR_memfd_secret 447
> +#endif
> +
> +#define TEXT "Hello World!\nHello World!\nHello World!\nHello World!\nHe=
llo World!\nHello World!\n"
> +
> +static int _memfd_secret(unsigned long flags)
> +{
> +       return syscall(__NR_memfd_secret, flags);
> +}
> +
> +int main(int argc, const char *argv[])
> +{
> +       long page_size;
> +       int fd, flags;
> +       char *mem;
> +       bool check =3D (argc =3D=3D 2 && strcmp(argv[1], "check") =3D=3D =
0);
> +       bool wx =3D (argc =3D=3D 2 && strcmp(argv[1], "wx") =3D=3D 0);
> +
> +       page_size =3D sysconf(_SC_PAGESIZE);
> +       if (page_size <=3D 0) {
> +               fprintf(stderr, "failed to get pagesize, got %ld:  %s\n",=
 page_size,
> +                       strerror(errno));
> +               return EXIT_FAILURE;
> +       }
> +
> +       fd =3D _memfd_secret(0);
> +       if (fd < 0) {
> +               printf("memfd_secret() failed:  %s\n", strerror(errno));
> +               if (check && errno !=3D ENOSYS)
> +                       return EXIT_SUCCESS;
> +
> +               return EXIT_FAILURE;
> +       }
> +
> +       if (check)
> +               return EXIT_SUCCESS;
> +
> +       if (ftruncate(fd, page_size) < 0) {
> +               fprintf(stderr, "ftruncate failed:  %s\n", strerror(errno=
));
> +       }
> +
> +       flags =3D PROT_READ | PROT_WRITE;
> +       if (wx)
> +               flags |=3D PROT_EXEC;
> +
> +       mem =3D mmap(NULL, page_size, flags, MAP_SHARED, fd, 0);
> +       if (mem =3D=3D MAP_FAILED || !mem) {
> +               printf("unable to mmap secret memory:  %s\n", strerror(er=
rno));
> +               close(fd);
> +               return EXIT_FAILURE;
> +       }
> +
> +       close(fd);
> +
> +       memcpy(mem, TEXT, sizeof TEXT);

Please use parentheses with sizeof. When the argument is a type name
they are mandatory so it's better to use them always for consistency.
See also:
https://lore.kernel.org/lkml/CA+55aFwey-q4716pYYSi=3D3R_ucw84zFspDXMXmzvzc7=
2XSc9Lg@mail.gmail.com/
https://lore.kernel.org/lkml/CA+55aFwcJgAFiow1sSo7mkF9n0MpTw80gjAszazyBrRcm=
bph-g@mail.gmail.com/

> +
> +       if (memcmp(mem, TEXT, sizeof TEXT) !=3D 0) {
> +               fprintf(stderr, "data not synced (1)\n");
> +               munmap(mem, page_size);
> +               return EXIT_FAILURE;
> +       }
> +
> +       if (strlen(mem) + 1 !=3D sizeof TEXT) {
> +               fprintf(stderr, "data not synced (2)\n");
> +               munmap(mem, page_size);
> +               return EXIT_FAILURE;
> +       }

What is the point of this second check? The previous check already
asserts that the contents are char-to-char equal to TEXT (including
the terminating null character), which implies string length
equivalence as well.

> +
> +       munmap(mem, page_size);
> +
> +       return EXIT_SUCCESS;
> +}

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

