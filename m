Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D252C433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 16:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9FF206D8
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 16:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X57b8bmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgEOQ1S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 12:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbgEOQ1S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 12:27:18 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DE6C061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 09:27:18 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b15so3100388ilq.12
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RHXyksmREM4UL67tRE8/YC3y3s5O1mTtIrx1cxTnuFE=;
        b=X57b8bmwe3NzWbm7V8GkE1CLoFPC5M4rInxLqrNQUJq4AzZHUnEuYjYWirE3Wjeds9
         WMgUDkCkyzerUNoA+rEPVrdMCjRYTTdFyvZDmD659ok7gD0OPOy++DXuILvdgyxRk6RR
         g4kq+Z/HYPrCQPDXpi7MQO1KytAMAMctyaSciy3M48JTaXWtAj11iPz3l2zPGAV8CUDP
         m8O1Kn7pxNDcG18tBSA0jt36gh1cqXH0OWii1Kp1XN+6KoNtKyObEL4cu6DjcKqv/SYD
         XdLHfc0M/icyzfWfcLsK09vwfnMXjCU1N/0NQSPof6n4o59w2azUpOxc0d6b5T6DPsYI
         K2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHXyksmREM4UL67tRE8/YC3y3s5O1mTtIrx1cxTnuFE=;
        b=c7EujyhEYelZNszT8ZdeL9CzHXYgtfFc44iM2Bc6S+aoi2HPWBlYeP1wZUbXQFZqNv
         ERH7D52TNi29P7VcxGTVPVmhWRk8/Y1jD13TTzssmV0z+apPiXzQB+sdxqLzstF/5T+f
         kY7GAfraxxv5OwdozxRDK/Ia3Ao6pPWxZaSOQtNGdnRGaxKIivc3jX8BtaJn4lsyfF9s
         XVNlXLrSrbHu+NW4Py+OyULvKXyQoYqBU0fnf29K21BYtjX8EjJKjULZTxZf3cNkhXtU
         7ldPqsnTRu8Y0/F6CiJ5wJwi6F9BKUBcG5hoGLcFnZ0jaEIFgHCScF7ZTdKZPdQ9Lsp3
         5ypw==
X-Gm-Message-State: AOAM531gmI78RqCGXEv3g2Tuy0ukBlIFon7zOUfraHLVsu5b92eqd4L6
        MnG2xURvtdlf0ORmRMCphKSfA/HPSdu8CFpnKVE=
X-Google-Smtp-Source: ABdhPJwUTlmeajwIsbZkpQJ5eWzOMJM300OShOGMHH4tG42Wci+aR01492v072T25ZzegT8gkrAx+qm4ffnaLd73k5c=
X-Received: by 2002:a92:c906:: with SMTP id t6mr4287839ilp.22.1589560037064;
 Fri, 15 May 2020 09:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <CAFftDdrD-FJ8wBk=XOkvdnkvA5o10w5pJs31H9dEhtW1zU8EHA@mail.gmail.com>
 <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com>
 <3838641.zh4Wi6GlAV@liv> <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
 <CAEjxPJ6Uo83L5C9UELy5w_V2wuptSHiHoMMLN4oh75x70-ZzAQ@mail.gmail.com>
 <CAHC9VhSUHMrMjvG=wigsqVA-0MF0LSmCCC_zyoZYHC2wEnT06A@mail.gmail.com> <CAEjxPJ72G4bpd6uLy1UikPoU7+tS-Kh2cCO+R75ApoRNCt3_Wg@mail.gmail.com>
In-Reply-To: <CAEjxPJ72G4bpd6uLy1UikPoU7+tS-Kh2cCO+R75ApoRNCt3_Wg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 15 May 2020 11:27:05 -0500
Message-ID: <CAFftDdoineg_FjyPnCtxEjiFtEQ3bZt-M_ePZtfAh-CUNSDwNg@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Laurent Bigonville <bigon@debian.org>,
        Russell Coker <russell@coker.com.au>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 13, 2020 at 10:51 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, May 7, 2020 at 11:03 PM Paul Moore <paul@paul-moore.com> wrote:
> > For a long time now I've wanted to expand my selinux/next kernel
> > testing to platforms beyond Fedora.  I believe that it not only helps
> > catch problems before the kernel is released, but it also helps ensure
> > that the underlying distro has all of the necessary pieces (userspace,
> > policy, etc.) in place to support the latest and upcoming kernels.
> >
> > Unfortunately every time I've looked at the state of SELinux in Debian
> > I've run out of time before I got it working well.  I'm not even going
> > to get into the Debian package format :/
> >
> > I would be very happy to see some work go into lowering the bar on
> > getting SELinux working on Debian.  My Debian experience is pretty
> > limited, but you can sign me up as a very enthusiastic beta-tester,
> > just point me at some docs and an ISO :)
>
> FWIW, with the just-merged series, if you follow the new instructions
> in the README.md for Debian, you should be able to successfully build
> and run the testsuite on Debian stable and unstable (also worked for
> me on Ubuntu 20.04 aside from needing to obtain libbpf from upstream
> since it isn't packaged for Ubuntu).  The default policy still has
> some issues (e.g. don't try to use GNOME in enforcing mode) but if you
> can login as an unconfined user and setenforce 1 via text console or
> ssh login, you should be able to run the testsuite.

I am having an issue with the test suite, perhaps the error would be obvious
to you or someone else

Error:
make[3]: Entering directory '/root/selinux-testsuite/tests/module_load'
make[3]: *** /lib/modules/5.6.6-300.fc32.x86_64/build: No such file or
directory.  Stop.
make[3]: Leaving directory '/root/selinux-testsuite/tests/module_load'
make[2]: *** [Makefile:8: all] Error 2
make[2]: Leaving directory '/root/selinux-testsuite/tests/module_load'
make[1]: *** [Makefile:141: all] Error 1
make[1]: Leaving directory '/root/selinux-testsuite/tests'
make: *** [Makefile:8: test] Error 2

The module_load path exists:
[root@demo tests]# ls /lib/modules/5.6.6-300.fc32.x86_64/
bls.conf    modules.builtin       modules.drm    source
build    modules.builtin.alias.bin  modules.modesetting  symvers.gz
config    modules.builtin.bin       modules.networking   System.map
kernel    modules.builtin.modinfo    modules.order    updates
modules.alias    modules.dep       modules.softdep    vdso
modules.alias.bin  modules.dep.bin       modules.symbols    vmlinuz
modules.block    modules.devname       modules.symbols.bin

And build exists, but it's a file, is that right?
[root@demo tests]# stat /lib/modules/5.6.6-300.fc32.x86_64/build
  File: /lib/modules/5.6.6-300.fc32.x86_64/build ->
/usr/src/kernels/5.6.6-300.fc32.x86_64
  Size: 38        Blocks: 0          IO Block: 4096   symbolic link
Device: 801h/2049d Inode: 154128      Links: 1
Access: (0777/lrwxrwxrwx)  Uid: (    0/    root)   Gid: (    0/    root)
Context: system_u:object_r:modules_object_t:s0
Access: 2020-05-15 16:23:03.854826122 +0000
Modify: 2020-04-21 14:01:58.000000000 +0000
Change: 2020-04-22 22:30:37.051096556 +0000
 Birth: -

Thanks,
Bill
