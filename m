Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3896FC433F5
	for <selinux@archiver.kernel.org>; Tue, 11 Oct 2022 16:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJKQKk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Oct 2022 12:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiJKQKj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Oct 2022 12:10:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B3B57BCF
        for <selinux@vger.kernel.org>; Tue, 11 Oct 2022 09:10:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u10so22379598wrq.2
        for <selinux@vger.kernel.org>; Tue, 11 Oct 2022 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWH4D1J45OWSpMz62cQx+DyEPyqK5VmHP8n45iUklG0=;
        b=XPG7P9CC+ksccu++Tv21qp7jjmRMMluT7j1nDSjg91V0hKNNYafvuKv2iIKHOsu2Kb
         0ORu9KYYBsXUy74FUHe3/ZiC9K7wsiG0j2xV8vySf9m8avcyrzxyEXt2o+KhevCxgaiR
         jcSAu6Z/C5I7aan6rwAV1T6hIBBMVsodYZ9qJmQKKplPTMESyk43adFsWwAm0I0YgVbK
         1I2bnGfeEHLQGAj+rrYKEiOwK+zC/bFjSYQS9bYrkHgtl6apmEeaUBB4jrrrobBwjzJF
         JVEwSsp33SHCLgxnvu+PDtw+dg43kY1BfAyRdqlw9IXr5QOFJFdwXSZ6pa4G+PK1hNLp
         mmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWH4D1J45OWSpMz62cQx+DyEPyqK5VmHP8n45iUklG0=;
        b=z3kqf71hkfUgortUqUqmcWSaVos2nP0cHI9Ncgvdpq8N00WeRLV5QGsO2MPv/+vGph
         /cOdveh+cGd50XGIcq3bSaEBrU1k1DtYNj47Nx9YUzixFXsJOaWVEnpFRa0+WaHzbGXD
         BhiZljKTGaTRqb8mKcCOxdl1M11HQW4sCgQMfxLjbwGpREO1/1zqUHNHNgVmMcRJiquB
         Aw1nAydytIAaRVfDIMeWrNGW2smo+zr560g/QvOq7qoD/0E26H3E+CtdbI5kD8p7Atmq
         3Wz5NnzkyvkeBoWUgWDRMtXbCxn0IOnHVtlJXu6BAT095/aoiTetZCr0RbbJu/H99H8y
         bKDA==
X-Gm-Message-State: ACrzQf1CssMPNJ7zq48YoBNu1g5DhdldlcH/mBQtpHB2S/28XJyAY5i+
        kayYN2UPkgYvVJQJXBKP/fDwhcKSagBAVwgexXE=
X-Google-Smtp-Source: AMsMyM5KjS6jsNNTumiuxmbTzYZumrMbjLWKTJDZV7R3Y/EH0y3v/ESXOIIVyzgmGniZvQNNJ/gpBt5nros2yLwb9v0=
X-Received: by 2002:a5d:584a:0:b0:231:636c:de28 with SMTP id
 i10-20020a5d584a000000b00231636cde28mr2946417wrf.175.1665504635193; Tue, 11
 Oct 2022 09:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220831153432.710929-1-cgzones@googlemail.com>
 <CAFqZXNtPs=SWnjjbySWf+Yi88R3p0ebLBjB9-2DGsirrU+iEpg@mail.gmail.com> <CAFqZXNtKK60n0A7fbu-jvsGFvpec+L1QZqJwuZyiyL89pbZHjQ@mail.gmail.com>
In-Reply-To: <CAFqZXNtKK60n0A7fbu-jvsGFvpec+L1QZqJwuZyiyL89pbZHjQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 11 Oct 2022 18:10:24 +0200
Message-ID: <CAJ2a_DfkCAZ9X=AeR=Rw95K4BtQnQs4OZ4SYDyq3iRBogTVLUg@mail.gmail.com>
Subject: Re: [PATCH v2] tests/secretmem: add test
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 11 Oct 2022 at 16:02, Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Mon, Sep 12, 2022 at 3:41 PM Ondrej Mosnacek <omosnace@redhat.com> wro=
te:
> > On Wed, Aug 31, 2022 at 5:34 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > > Add test for memfd_secret(2) anonymous inodes check added in 6.0 via
> > > 2bfe15c52612 ("mm: create security context for memfd_secret inodes").
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > > v2:
> > >    - print mmap failures to stdout, since they are expected when
> > >      mapping with PROT_EXEC
> > > ---
> > >  .github/workflows/checks.yml |  4 ++
> > >  Vagrantfile                  | 10 +++--
> > >  policy/Makefile              |  4 ++
> > >  policy/test_secretmem.te     | 33 ++++++++++++++
> > >  tests/Makefile               |  5 +++
> > >  tests/secretmem/.gitignore   |  1 +
> > >  tests/secretmem/Makefile     |  5 +++
> > >  tests/secretmem/secretmem.c  | 83 ++++++++++++++++++++++++++++++++++=
++
> > >  tests/secretmem/test         | 39 +++++++++++++++++
> > >  9 files changed, 180 insertions(+), 4 deletions(-)
> > >  create mode 100644 policy/test_secretmem.te
> > >  create mode 100644 tests/secretmem/.gitignore
> > >  create mode 100644 tests/secretmem/Makefile
> > >  create mode 100644 tests/secretmem/secretmem.c
> > >  create mode 100755 tests/secretmem/test
> >
> > This looks good to me, with some minor comments below.
> >
> > > diff --git a/tests/secretmem/secretmem.c b/tests/secretmem/secretmem.=
c
> > > new file mode 100644
> > > index 0000000..0d541ee
> > > --- /dev/null
> > > +++ b/tests/secretmem/secretmem.c
> > > @@ -0,0 +1,83 @@
> > > +#include <errno.h>
> > > +#include <stdbool.h>
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +#include <unistd.h>
> > > +
> > > +#include <sys/mman.h>
> > > +#include <sys/syscall.h>
> > > +
> > > +#ifndef __NR_memfd_secret
> > > +# define __NR_memfd_secret 447
> > > +#endif
> > > +
> > > +#define TEXT "Hello World!\nHello World!\nHello World!\nHello World!=
\nHello World!\nHello World!\n"
> > > +
> > > +static int _memfd_secret(unsigned long flags)
> > > +{
> > > +       return syscall(__NR_memfd_secret, flags);
> > > +}
> > > +
> > > +int main(int argc, const char *argv[])
> > > +{
> > > +       long page_size;
> > > +       int fd, flags;
> > > +       char *mem;
> > > +       bool check =3D (argc =3D=3D 2 && strcmp(argv[1], "check") =3D=
=3D 0);
> > > +       bool wx =3D (argc =3D=3D 2 && strcmp(argv[1], "wx") =3D=3D 0)=
;
> > > +
> > > +       page_size =3D sysconf(_SC_PAGESIZE);
> > > +       if (page_size <=3D 0) {
> > > +               fprintf(stderr, "failed to get pagesize, got %ld:  %s=
\n", page_size,
> > > +                       strerror(errno));
> > > +               return EXIT_FAILURE;
> > > +       }
> > > +
> > > +       fd =3D _memfd_secret(0);
> > > +       if (fd < 0) {
> > > +               printf("memfd_secret() failed:  %s\n", strerror(errno=
));
> > > +               if (check && errno !=3D ENOSYS)
> > > +                       return EXIT_SUCCESS;
> > > +
> > > +               return EXIT_FAILURE;
> > > +       }
> > > +
> > > +       if (check)
> > > +               return EXIT_SUCCESS;
> > > +
> > > +       if (ftruncate(fd, page_size) < 0) {
> > > +               fprintf(stderr, "ftruncate failed:  %s\n", strerror(e=
rrno));
> > > +       }
> > > +
> > > +       flags =3D PROT_READ | PROT_WRITE;
> > > +       if (wx)
> > > +               flags |=3D PROT_EXEC;
> > > +
> > > +       mem =3D mmap(NULL, page_size, flags, MAP_SHARED, fd, 0);
> > > +       if (mem =3D=3D MAP_FAILED || !mem) {
> > > +               printf("unable to mmap secret memory:  %s\n", strerro=
r(errno));
> > > +               close(fd);
> > > +               return EXIT_FAILURE;
> > > +       }
> > > +
> > > +       close(fd);
> > > +
> > > +       memcpy(mem, TEXT, sizeof TEXT);
> >
> > Please use parentheses with sizeof. When the argument is a type name
> > they are mandatory so it's better to use them always for consistency.
> > See also:
> > https://lore.kernel.org/lkml/CA+55aFwey-q4716pYYSi=3D3R_ucw84zFspDXMXmz=
vzc72XSc9Lg@mail.gmail.com/
> > https://lore.kernel.org/lkml/CA+55aFwcJgAFiow1sSo7mkF9n0MpTw80gjAszazyB=
rRcmbph-g@mail.gmail.com/
> >
> > > +
> > > +       if (memcmp(mem, TEXT, sizeof TEXT) !=3D 0) {
> > > +               fprintf(stderr, "data not synced (1)\n");
> > > +               munmap(mem, page_size);
> > > +               return EXIT_FAILURE;
> > > +       }
> > > +
> > > +       if (strlen(mem) + 1 !=3D sizeof TEXT) {
> > > +               fprintf(stderr, "data not synced (2)\n");
> > > +               munmap(mem, page_size);
> > > +               return EXIT_FAILURE;
> > > +       }
> >
> > What is the point of this second check? The previous check already
> > asserts that the contents are char-to-char equal to TEXT (including
> > the terminating null character), which implies string length
> > equivalence as well.
> >
> > > +
> > > +       munmap(mem, page_size);
> > > +
> > > +       return EXIT_SUCCESS;
> > > +}
>
> You only pushed the updated version to the GitHub PR
> (https://github.com/SELinuxProject/selinux-testsuite/pull/80), but
> anyway I took that version and applied it (just removed the changelog
> from the commit message and added my SOB):
> https://github.com/SELinuxProject/selinux-testsuite/commit/77352e748f006c=
343d602e4be03ae0d2cfcca831
>

Thanks,
I thought I had sent the new revision, but it seems I have missed that.




>
> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
