Return-Path: <SRS0=6R7b=XU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98034C432C2
	for <selinux@archiver.kernel.org>; Wed, 25 Sep 2019 15:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681F02054F
	for <selinux@archiver.kernel.org>; Wed, 25 Sep 2019 15:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ehaaOVA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfIYPW1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:22:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36829 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfIYPW0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Sep 2019 11:22:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so6107194ljj.3
        for <selinux@vger.kernel.org>; Wed, 25 Sep 2019 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1yTkSrdfHaFfhOpL4Hw5kWScug1KgVenquTrGwMYUU=;
        b=ehaaOVA0jzmqUqpxpYR7S9ee0i2VCyu0qoIgWN5iejT1ZJty/6JdyvOvWNkkMHb7DW
         9a8Cw6xBQmXVI0G/jUHC33WJoqx/nidT4J/IKUQdxzXbFfoG91NdV/r6m87k3CuzT98+
         xzWnTizIBKQNL3v1iLa9+IMi8AmrIJaKLchavafHYmeMfzoB3QKJSx4vK9TXAFMSRHyA
         9+/bjqDA34cuig3BpVsgriqqxGLnnf+KaWEicfHcTE2NGJqQdaUdz7FCKFrYOJtKz3a0
         1mGWwNiEho/m8VOUQA5hGuxWeiOYfQHnS51NUZmjCY0/4c74yU/FXsPwhAYWq/DKVFiV
         Qrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1yTkSrdfHaFfhOpL4Hw5kWScug1KgVenquTrGwMYUU=;
        b=A60iT6wf6nUfz37o9ouHKCr3UwRhX7Z5yAl/opr0t8DZQJfD7hJevsKIWgd0DZGGJp
         JjKwq3YaLZNuFTLgTtBxFUKonxsO2o28iMWkbiO1RGfCM6n2J2i0n0OLve3gacWQrEEH
         0gcD8FzGdxD7/bpIGso0+HVdDEBobjUTwnyKGauiCwhoeQq/W78gy3y3kBvlWjfhcsyc
         zaIXaWcrFCGlqrR8bFhhyPw9o0PXYzBoPQ74RiQEhU0ya5lWczDThb7joXDL+87TFLzu
         EU65b0XTfrz1mCYoneflCimygflgbstJWIslykue8GGuCh+hN62rrVwgxSf0TI4A0VYe
         qcgg==
X-Gm-Message-State: APjAAAUD9zi39YT/50XqYCNrz5/S9kJn85KHU5V6hpqd4xTNPiNKzqrx
        9Mb3in6M7o/I4yntnHIrddBzRDd1iTthbfvMO06dW7Q=
X-Google-Smtp-Source: APXvYqzcJAVvBEtK19Sp8JbqVJwN4VyVfZ4qk/04I1bJe2gnAcwPS7AUVuDcGtYYwo8XG8RTP0u0ipxYGNY4EFSWjqE=
X-Received: by 2002:a2e:98c8:: with SMTP id s8mr7276255ljj.129.1569424944601;
 Wed, 25 Sep 2019 08:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <156936589827.661145.16998799838921887816.stgit@chester> <CAFqZXNtYOypuvkXExmo1=TiXSMU81k9=n=P8ZQjZ66dBugCFUg@mail.gmail.com>
In-Reply-To: <CAFqZXNtYOypuvkXExmo1=TiXSMU81k9=n=P8ZQjZ66dBugCFUg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 25 Sep 2019 11:22:13 -0400
Message-ID: <CAHC9VhQkwySJJecbZLh1bSNV-oMEy8Ch_ZmuujOHiu7UgeYYiA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: add libelf to builds using libbpf
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 25, 2019 at 5:06 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Sep 25, 2019 at 12:58 AM Paul Moore <paul@paul-moore.com> wrote:
> > From: Paul Moore <paul@paul-moore.com>
> >
> > On a modern Rawhide system builds that include libbpf require libelf
> > as well to avoid the following linker errors:
> >
> >  # cc -g -O0 -Wall -D_GNU_SOURCE -DHAVE_BPF \
> >     client.c ../bpf/bpf_common.c ../bpf/bpf_common.h  -lbpf -o client
> >  /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getshdr'
> >  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_rawdata'
> >  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_getscn'
> >  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_begin'
> >  /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getrel'
> >  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_memory'
> >  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_end'
> >  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_strptr'
> >  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_nextscn'
> >  /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getehdr'
> >  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_version'
> >  /usr/bin/ld: ... libbpf.so: undefined reference to `elf_getdata'
> >  /usr/bin/ld: ... libbpf.so: undefined reference to `gelf_getsym'
>
> This is a bug in libbpf. I filed a bug against the Fedora package [1]
> and also opened a PR [2] against the upstream repo (which is a
> modified mirror of the code in the kernel repo under tools/lib/bpf,
> where the bug is not present), which I think should fix this problem
> also in the Fedora builds.
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1755317
> [2] https://github.com/libbpf/libbpf/pull/72

Thanks for tracking down the root cause and filing a report upstream;
I didn't have time to sort out the "why", I just wanted to get the
test working again :)

It looks like the best course of action is to hold off on this fix in
hopes that it gets fixed upstream, or at least in Fedora.  If this
issue persists for a week or two we can always go ahead and merge this
fix, it shouldn't break anything if/when this gets fixed upstream.

Tests that fail to run made me sad :(

-- 
paul moore
www.paul-moore.com
