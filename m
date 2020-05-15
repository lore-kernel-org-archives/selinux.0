Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0105C433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 16:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A6DF206C0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 16:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6fmvmHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgEOQlu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 12:41:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48291 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbgEOQlu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 12:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589560908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WawKs79T6IP3o7E1qKxdI9lsUYC/UPUGwE8+4LXdP6g=;
        b=J6fmvmHx40+U41ycABCvUoZCLVOIq5xo/2xyHOMcOR3iwCNMkXPPX0TUZIQMxFyVqgmbO2
        v+YeuYzuAR/t0hvlEMr0HqD3lqQe9StB5rGWEtKOxNmDyd5KlG7Ubax/x1Q0npaHYCq07D
        B4DYGWPoX6Q3s8ZbwyNjfFXAZy/2c8k=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-KCb_ecFuOW6lm1g8ysBT8Q-1; Fri, 15 May 2020 12:41:46 -0400
X-MC-Unique: KCb_ecFuOW6lm1g8ysBT8Q-1
Received: by mail-oo1-f69.google.com with SMTP id t140so1640197oot.22
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 09:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WawKs79T6IP3o7E1qKxdI9lsUYC/UPUGwE8+4LXdP6g=;
        b=BGtpFnd62UcGg82Ga5tbWHAhZWqMBHFJ9Cup6Qv1Pi6Bh0RvMrxK49PuEUdCtJCGbq
         w4Wzv93AZlTvI1lfUs4h19T8hjNw+k651xd9MvgO/QBYsL+7wdqnckS3aDwJfd1RoDXM
         8ywxDJ9/vLUSyPDW/xLNPKwnNbdwHrDELRDhn0Z2cKJG91UdbTglVuiYvFfZsA9JRNjR
         xKaXz4yyafPvalsIJ3yRbkPDb6ymfHVKVjIMsYVk1FSZv8TZv2SoQm2JjbmZD4DNkrSi
         bdaaO+4sh4RQ4kQHYtYc/PFkiVKvPPZW4KwuVKhz/n0kWNgzQHk5RQnN/p6Qy7QIWTqB
         L5Cw==
X-Gm-Message-State: AOAM530Etqj7uvXsEagMsCEPjWxsS2h2Spf47PKBhoA3QboL74K7q7Vy
        rReN3dwnlPb5/xYdBmHSSYIoOxe5SNkjz21Wec6Pja634267H4rp5z26gh9HE9QvTp5aFYQnDNw
        pyqFoO8XmCKLfu7pR+U0FAZoXUjlVwKUNkw==
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr2976018oth.66.1589560905574;
        Fri, 15 May 2020 09:41:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjCGboET+9SSATY01Z8NSInk2Z6WjXjJ5hKAb9GzFhFyhnpMfegHVnczAx2047dkWbut1PA33k1MEAwE6mP6o=
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr2976003oth.66.1589560905283;
 Fri, 15 May 2020 09:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <CAFftDdrD-FJ8wBk=XOkvdnkvA5o10w5pJs31H9dEhtW1zU8EHA@mail.gmail.com>
 <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com>
 <3838641.zh4Wi6GlAV@liv> <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
 <CAEjxPJ6Uo83L5C9UELy5w_V2wuptSHiHoMMLN4oh75x70-ZzAQ@mail.gmail.com>
 <CAHC9VhSUHMrMjvG=wigsqVA-0MF0LSmCCC_zyoZYHC2wEnT06A@mail.gmail.com>
 <CAEjxPJ72G4bpd6uLy1UikPoU7+tS-Kh2cCO+R75ApoRNCt3_Wg@mail.gmail.com> <CAFftDdoineg_FjyPnCtxEjiFtEQ3bZt-M_ePZtfAh-CUNSDwNg@mail.gmail.com>
In-Reply-To: <CAFftDdoineg_FjyPnCtxEjiFtEQ3bZt-M_ePZtfAh-CUNSDwNg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 15 May 2020 18:41:34 +0200
Message-ID: <CAFqZXNtrqoRmMcnP9Pp1ddZrLH1QHmWrYx5BG-QCd62i6FxGNA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Laurent Bigonville <bigon@debian.org>,
        Russell Coker <russell@coker.com.au>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 6:27 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> I am having an issue with the test suite, perhaps the error would be obvious
> to you or someone else
>
> Error:
> make[3]: Entering directory '/root/selinux-testsuite/tests/module_load'
> make[3]: *** /lib/modules/5.6.6-300.fc32.x86_64/build: No such file or
> directory.  Stop.
> make[3]: Leaving directory '/root/selinux-testsuite/tests/module_load'
> make[2]: *** [Makefile:8: all] Error 2
> make[2]: Leaving directory '/root/selinux-testsuite/tests/module_load'
> make[1]: *** [Makefile:141: all] Error 1
> make[1]: Leaving directory '/root/selinux-testsuite/tests'
> make: *** [Makefile:8: test] Error 2
>
> The module_load path exists:
> [root@demo tests]# ls /lib/modules/5.6.6-300.fc32.x86_64/
> bls.conf    modules.builtin       modules.drm    source
> build    modules.builtin.alias.bin  modules.modesetting  symvers.gz
> config    modules.builtin.bin       modules.networking   System.map
> kernel    modules.builtin.modinfo    modules.order    updates
> modules.alias    modules.dep       modules.softdep    vdso
> modules.alias.bin  modules.dep.bin       modules.symbols    vmlinuz
> modules.block    modules.devname       modules.symbols.bin
>
> And build exists, but it's a file, is that right?
> [root@demo tests]# stat /lib/modules/5.6.6-300.fc32.x86_64/build
>   File: /lib/modules/5.6.6-300.fc32.x86_64/build ->
> /usr/src/kernels/5.6.6-300.fc32.x86_64
>   Size: 38        Blocks: 0          IO Block: 4096   symbolic link
> Device: 801h/2049d Inode: 154128      Links: 1
> Access: (0777/lrwxrwxrwx)  Uid: (    0/    root)   Gid: (    0/    root)
> Context: system_u:object_r:modules_object_t:s0
> Access: 2020-05-15 16:23:03.854826122 +0000
> Modify: 2020-04-21 14:01:58.000000000 +0000
> Change: 2020-04-22 22:30:37.051096556 +0000
>  Birth: -

It is a symlink, as evident from the stat output above, which is
normal. You probably just don't have the matching kernel-devel package
installed, so the target directory (/usr/src/...) doesn't exist.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

