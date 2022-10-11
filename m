Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323EAC433FE
	for <selinux@archiver.kernel.org>; Tue, 11 Oct 2022 14:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJKOCb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Oct 2022 10:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJKOCa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Oct 2022 10:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C2D915CB
        for <selinux@vger.kernel.org>; Tue, 11 Oct 2022 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665496946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WH6l1WJOqWvdtD2lwh+GOf0WBOVnC2pkSl4cDVIUyTc=;
        b=hUQR7PZXAzT8wGOGPK6O1Nq3TJFipOEbrRVSNddbGAm7zki2rvIXV96YzRsmEF+rWajhf7
        9sNQr8TZbCgSyh7gha9ggC2QJKjTMy+VokW/Wm8p5htMkPzZKQA0Ia1AoPsFTN/Da0W1IV
        AqYRA3xZoNWBdNF8f93Z+Y00BExcdr8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-U3pxgKV1NtyF5zGER_gbQg-1; Tue, 11 Oct 2022 10:02:25 -0400
X-MC-Unique: U3pxgKV1NtyF5zGER_gbQg-1
Received: by mail-pj1-f71.google.com with SMTP id pc10-20020a17090b3b8a00b00202be8d81d2so11035980pjb.1
        for <selinux@vger.kernel.org>; Tue, 11 Oct 2022 07:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WH6l1WJOqWvdtD2lwh+GOf0WBOVnC2pkSl4cDVIUyTc=;
        b=62jn16U80m0GMDXlNXpJLHvG4wxAs6c2guWt7C6jyBIfLaXm2UnQD0f03L7JKmQOBg
         4AGXI/8p2fwM9c2FcC2Eszno9/WplqqRNecz3NBksYj35eNQkvxrJMVJr9A3VpsppsDp
         +6wPlntrocuxmDizcELBbfbH273XDC0DBuEKI8wq1d1keWsbdU+fDFg7HV7sjPW2H2g2
         b+v3WtPtQ37aoCLiBtQc/neuoIphHl5tw+aB2dNOm8R0PHil5QVbtm8pgGyJvENEbqIC
         Z4gy/Y/QtZ+xwuzuq/cGmgPYRbvQVi3kPuu87rhjr8INNbrkaLYBpvP7ZIBnm/MOy489
         dTJA==
X-Gm-Message-State: ACrzQf0ZbfDfAyjQwwpE93Yw682XtJwOh0oPcRrnyK7qSJoUS9DKbiOY
        G6RvzyGuxwS5HqP9GDTD56rPbYUGANj2fqjulWl/cgcxFwd9W5yLEoXBI6AdNGpsI7zocOtC2hb
        hPT2L1sB6YIrD73oI7dzXw78LtMPoQctzaw==
X-Received: by 2002:a17:902:d484:b0:17f:7437:565d with SMTP id c4-20020a170902d48400b0017f7437565dmr24272039plg.154.1665496943519;
        Tue, 11 Oct 2022 07:02:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5E0cVHGLsLptq3Yk8rKt+M0VrOm3SxQH61TM0+bmWFVaH+pUzJFqDrg2gq/Qp5JvfjWHo73HyfdDhS+x/ydzQ=
X-Received: by 2002:a17:902:d484:b0:17f:7437:565d with SMTP id
 c4-20020a170902d48400b0017f7437565dmr24272008plg.154.1665496943179; Tue, 11
 Oct 2022 07:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220831153432.710929-1-cgzones@googlemail.com> <CAFqZXNtPs=SWnjjbySWf+Yi88R3p0ebLBjB9-2DGsirrU+iEpg@mail.gmail.com>
In-Reply-To: <CAFqZXNtPs=SWnjjbySWf+Yi88R3p0ebLBjB9-2DGsirrU+iEpg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 11 Oct 2022 16:02:11 +0200
Message-ID: <CAFqZXNtKK60n0A7fbu-jvsGFvpec+L1QZqJwuZyiyL89pbZHjQ@mail.gmail.com>
Subject: Re: [PATCH v2] tests/secretmem: add test
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 12, 2022 at 3:41 PM Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> On Wed, Aug 31, 2022 at 5:34 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> > Add test for memfd_secret(2) anonymous inodes check added in 6.0 via
> > 2bfe15c52612 ("mm: create security context for memfd_secret inodes").
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > v2:
> >    - print mmap failures to stdout, since they are expected when
> >      mapping with PROT_EXEC
> > ---
> >  .github/workflows/checks.yml |  4 ++
> >  Vagrantfile                  | 10 +++--
> >  policy/Makefile              |  4 ++
> >  policy/test_secretmem.te     | 33 ++++++++++++++
> >  tests/Makefile               |  5 +++
> >  tests/secretmem/.gitignore   |  1 +
> >  tests/secretmem/Makefile     |  5 +++
> >  tests/secretmem/secretmem.c  | 83 ++++++++++++++++++++++++++++++++++++
> >  tests/secretmem/test         | 39 +++++++++++++++++
> >  9 files changed, 180 insertions(+), 4 deletions(-)
> >  create mode 100644 policy/test_secretmem.te
> >  create mode 100644 tests/secretmem/.gitignore
> >  create mode 100644 tests/secretmem/Makefile
> >  create mode 100644 tests/secretmem/secretmem.c
> >  create mode 100755 tests/secretmem/test
>
> This looks good to me, with some minor comments below.
>
> > diff --git a/tests/secretmem/secretmem.c b/tests/secretmem/secretmem.c
> > new file mode 100644
> > index 0000000..0d541ee
> > --- /dev/null
> > +++ b/tests/secretmem/secretmem.c
> > @@ -0,0 +1,83 @@
> > +#include <errno.h>
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +
> > +#include <sys/mman.h>
> > +#include <sys/syscall.h>
> > +
> > +#ifndef __NR_memfd_secret
> > +# define __NR_memfd_secret 447
> > +#endif
> > +
> > +#define TEXT "Hello World!\nHello World!\nHello World!\nHello World!\n=
Hello World!\nHello World!\n"
> > +
> > +static int _memfd_secret(unsigned long flags)
> > +{
> > +       return syscall(__NR_memfd_secret, flags);
> > +}
> > +
> > +int main(int argc, const char *argv[])
> > +{
> > +       long page_size;
> > +       int fd, flags;
> > +       char *mem;
> > +       bool check =3D (argc =3D=3D 2 && strcmp(argv[1], "check") =3D=
=3D 0);
> > +       bool wx =3D (argc =3D=3D 2 && strcmp(argv[1], "wx") =3D=3D 0);
> > +
> > +       page_size =3D sysconf(_SC_PAGESIZE);
> > +       if (page_size <=3D 0) {
> > +               fprintf(stderr, "failed to get pagesize, got %ld:  %s\n=
", page_size,
> > +                       strerror(errno));
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       fd =3D _memfd_secret(0);
> > +       if (fd < 0) {
> > +               printf("memfd_secret() failed:  %s\n", strerror(errno))=
;
> > +               if (check && errno !=3D ENOSYS)
> > +                       return EXIT_SUCCESS;
> > +
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       if (check)
> > +               return EXIT_SUCCESS;
> > +
> > +       if (ftruncate(fd, page_size) < 0) {
> > +               fprintf(stderr, "ftruncate failed:  %s\n", strerror(err=
no));
> > +       }
> > +
> > +       flags =3D PROT_READ | PROT_WRITE;
> > +       if (wx)
> > +               flags |=3D PROT_EXEC;
> > +
> > +       mem =3D mmap(NULL, page_size, flags, MAP_SHARED, fd, 0);
> > +       if (mem =3D=3D MAP_FAILED || !mem) {
> > +               printf("unable to mmap secret memory:  %s\n", strerror(=
errno));
> > +               close(fd);
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       close(fd);
> > +
> > +       memcpy(mem, TEXT, sizeof TEXT);
>
> Please use parentheses with sizeof. When the argument is a type name
> they are mandatory so it's better to use them always for consistency.
> See also:
> https://lore.kernel.org/lkml/CA+55aFwey-q4716pYYSi=3D3R_ucw84zFspDXMXmzvz=
c72XSc9Lg@mail.gmail.com/
> https://lore.kernel.org/lkml/CA+55aFwcJgAFiow1sSo7mkF9n0MpTw80gjAszazyBrR=
cmbph-g@mail.gmail.com/
>
> > +
> > +       if (memcmp(mem, TEXT, sizeof TEXT) !=3D 0) {
> > +               fprintf(stderr, "data not synced (1)\n");
> > +               munmap(mem, page_size);
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       if (strlen(mem) + 1 !=3D sizeof TEXT) {
> > +               fprintf(stderr, "data not synced (2)\n");
> > +               munmap(mem, page_size);
> > +               return EXIT_FAILURE;
> > +       }
>
> What is the point of this second check? The previous check already
> asserts that the contents are char-to-char equal to TEXT (including
> the terminating null character), which implies string length
> equivalence as well.
>
> > +
> > +       munmap(mem, page_size);
> > +
> > +       return EXIT_SUCCESS;
> > +}

You only pushed the updated version to the GitHub PR
(https://github.com/SELinuxProject/selinux-testsuite/pull/80), but
anyway I took that version and applied it (just removed the changelog
from the commit message and added my SOB):
https://github.com/SELinuxProject/selinux-testsuite/commit/77352e748f006c34=
3d602e4be03ae0d2cfcca831


--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

