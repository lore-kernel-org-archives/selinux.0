Return-Path: <SRS0=6R7b=XU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBC9C432C1
	for <selinux@archiver.kernel.org>; Wed, 25 Sep 2019 09:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFF2214DA
	for <selinux@archiver.kernel.org>; Wed, 25 Sep 2019 09:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7ci9II2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfIYJGp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:06:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33530 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728260AbfIYJGo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Sep 2019 05:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569402403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71gOzm80ptzGGoSyUCIXrrdgToMBaIYZkdBydXuz/+s=;
        b=I7ci9II2IV9JgODnh+5Bq3sAMOoWKOG2xXhOVX/HXIfFbVlbQKGvSfpAgxF3IbU2dpYY3f
        aGRm9w+txGy0EgRbUdjEsXfXCoAGS0l42dFg6GhCXJm55T0Q0ygIs7+bABouQKh+6Bzinr
        KyzDfzXeHAJ2ZcW7z4j9H4FuA35wJhA=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-tJNptcK3Nq6j6FWkQxWT5g-1; Wed, 25 Sep 2019 05:06:42 -0400
Received: by mail-oi1-f199.google.com with SMTP id m23so2716311oih.0
        for <selinux@vger.kernel.org>; Wed, 25 Sep 2019 02:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3E0oD6fSjyAW+aOwMchUhtB6r+ohJCmRvFsid83Qyc=;
        b=CK+eVg7ejH7ODC8vspPLC9b/my8WzCAepUY3JIVA4dBVcMkIGxuAL9cRdS46NgVYXU
         1mcIcyueprhv9vYWVgpvHra6TRLZTD2yVnSE2lCoOEjpwyuhS7nBWDLaCF0c1NcC+8Eg
         38POBqCdilu0dx3Iwq0SbaMvRxNzG4WbIhA78/sa8Uk/FEUsCMdbbvu8nWPZC6TVQzSL
         5Dyf9Al1wY+lNtEqycum/MoeltBTuwjI+FmKI4qH8sibcsfIo++UQ8gD2PoLQfSeEOWx
         qHRPukk/UewEiXxWzOEZWeyB2ZPUjb4ArF30x/3IHKWlx+2kSt21vNp4O5yQgnE9/p5O
         9p4Q==
X-Gm-Message-State: APjAAAU9j7A4fkgokQYsK1WrAN5cGsmS4Yn80rtuyY/TujEjgeoGHbIu
        BE0V9G2CroSussxUeAbdYaRcyJarEGfBNFcOefC53BdBlH/Mb18IZMF5UrehkhGo3/afn6u+Hcw
        2wUME/JYoakfnepZD+SfUH5BK7ya3h8Wcbg==
X-Received: by 2002:aca:e046:: with SMTP id x67mr3585448oig.156.1569402401321;
        Wed, 25 Sep 2019 02:06:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwMwfKyxJ7C1dsgnhsaftHEwyZvhH9lPo2lmlz+MVANUYcMT3ZzaH6T8toLdmskG+fPYIBr99R/0uoLw5yB0AQ=
X-Received: by 2002:aca:e046:: with SMTP id x67mr3585422oig.156.1569402400970;
 Wed, 25 Sep 2019 02:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <156936589827.661145.16998799838921887816.stgit@chester>
In-Reply-To: <156936589827.661145.16998799838921887816.stgit@chester>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 25 Sep 2019 11:06:30 +0200
Message-ID: <CAFqZXNtYOypuvkXExmo1=TiXSMU81k9=n=P8ZQjZ66dBugCFUg@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: add libelf to builds using libbpf
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: tJNptcK3Nq6j6FWkQxWT5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 25, 2019 at 12:58 AM Paul Moore <paul@paul-moore.com> wrote:
> From: Paul Moore <paul@paul-moore.com>
>
> On a modern Rawhide system builds that include libbpf require libelf
> as well to avoid the following linker errors:
>
>  # cc -g -O0 -Wall -D_GNU_SOURCE -DHAVE_BPF \
>     client.c ../bpf/bpf_common.c ../bpf/bpf_common.h  -lbpf -o client
>  /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getshdr'
>  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_rawdata'
>  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_getscn'
>  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_begin'
>  /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getrel'
>  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_memory'
>  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_end'
>  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_strptr'
>  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_nextscn'
>  /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getehdr'
>  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_version'
>  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_getdata'
>  /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getsym'

This is a bug in libbpf. I filed a bug against the Fedora package [1]
and also opened a PR [2] against the upstream repo (which is a
modified mirror of the code in the kernel repo under tools/lib/bpf,
where the bug is not present), which I think should fix this problem
also in the Fedora builds.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1755317
[2] https://github.com/libbpf/libbpf/pull/72

>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tests/binder/Makefile    |    2 +-
>  tests/bpf/Makefile       |    2 +-
>  tests/fdreceive/Makefile |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/binder/Makefile b/tests/binder/Makefile
> index e78ad16..8f3cc28 100644
> --- a/tests/binder/Makefile
> +++ b/tests/binder/Makefile
> @@ -12,7 +12,7 @@ endif
>
>  ifneq (,$(findstring -DHAVE_BPF,$(CFLAGS)))
>         DEPS +=3D ../bpf/bpf_common.c ../bpf/bpf_common.h
> -       LDLIBS +=3D -lbpf
> +       LDLIBS +=3D -lelf -lbpf
>  endif
>
>  all: $(TARGETS)
> diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
> index 6fb230d..7b00b41 100644
> --- a/tests/bpf/Makefile
> +++ b/tests/bpf/Makefile
> @@ -1,6 +1,6 @@
>  TARGETS =3D bpf_test
>  DEPS =3D bpf_common.c bpf_common.h
> -LDLIBS +=3D -lselinux -lbpf
> +LDLIBS +=3D -lselinux -lelf -lbpf
>
>  # export so that BPF_ENABLED entries get built correctly on local build
>  export CFLAGS +=3D -DHAVE_BPF
> diff --git a/tests/fdreceive/Makefile b/tests/fdreceive/Makefile
> index 895f91c..cf57327 100644
> --- a/tests/fdreceive/Makefile
> +++ b/tests/fdreceive/Makefile
> @@ -2,7 +2,7 @@ TARGETS =3D client server
>
>  ifneq (,$(findstring -DHAVE_BPF,$(CFLAGS)))
>         DEPS =3D ../bpf/bpf_common.c ../bpf/bpf_common.h
> -       LDLIBS +=3D -lbpf
> +       LDLIBS +=3D -lelf -lbpf
>  endif
>
>  all: $(TARGETS)
>

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

