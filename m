Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3063C433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 16:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E87820826
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 16:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7kxd6Io"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgEOQq6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 12:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726023AbgEOQq5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 12:46:57 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C680BC061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 09:46:57 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j3so3170759ilk.11
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SnRIRxM/IxS062bhWUsvvawv0AHyncBaDDrFQ9uXl0Q=;
        b=A7kxd6IoLJNOoeHjoMyXBHMkbOj5n5GW1fH+SRKoMIbpDeWOwsLBQkBMXKmWOGP96E
         vGGGLrTXI62KBHWrTLeudpjb1S7Z6W+4lyHbIXbCfNhf4D7EhRm+uf7qc4rD7CUrSv8g
         xEL4izJIrZ90WHx49AtpxokOF4UJy9c5kDKIYgucXC42Q0L2oN2yhHmBL4CdL8kSBYy2
         k/6OiOcprf2qnn7G+XbK2x/iWkZMkarRwHKFimq+3eF5RhjqbE2eRTo2XW3bDca6leV0
         PXJdhARUGwaiYU+RGjAQpbeZrZUrLKzTNhZRVkHTXFsuqWYYUs1F9WxAHtPwIVnnsXbm
         FiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SnRIRxM/IxS062bhWUsvvawv0AHyncBaDDrFQ9uXl0Q=;
        b=MIseaJh7ObSJecDsf1Zc57aqiJs6iJPMFGzbv4dDLoPSJw2viSwfP3TWnzccQcUT45
         GvvBd2vBvqHnpmylDoSGSSWkdr7Zlq/VKhNg33BLlxJdYebqMnPxEnZvvbiFwv4Tn7Wj
         fR0zQ8KochQzNcLr6qKB0a/qxjQEtSAVmK4qEv/l/lmZoKEqjG2nHa+jzjDWD1Qvo+7b
         HNEvxDe8hl8baDY7ItYqQqOCbsxbr9srWzKEE6w3DlPRS7BFYKZn3iDsEAoVbnj8GnYw
         Ocq91xe54SrSlLCDE++374rXC7PdrQ/C2tNJZiM1i1n6PeqrHiOxVZ2PIS2s1NpqnVh/
         y+aQ==
X-Gm-Message-State: AOAM531riaWlfZnHBV8S8yeEQzZ3drF36u2hOwadjhW/KWWAMV87bcKK
        L5qwZhUAvRbM1/iJpuATtjstcsY1a8KvsFJ5mI0=
X-Google-Smtp-Source: ABdhPJy5FikngSXLF3iazf0RXvi7zFjyfAEbAt8tA3Ia2U2vAj7x6zDk2/AH1apNY/PjtRp0ET085LinFqfPiNHkKBA=
X-Received: by 2002:a92:c906:: with SMTP id t6mr4380366ilp.22.1589561217085;
 Fri, 15 May 2020 09:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <CAFftDdrD-FJ8wBk=XOkvdnkvA5o10w5pJs31H9dEhtW1zU8EHA@mail.gmail.com>
 <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com>
 <3838641.zh4Wi6GlAV@liv> <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
 <CAEjxPJ6Uo83L5C9UELy5w_V2wuptSHiHoMMLN4oh75x70-ZzAQ@mail.gmail.com>
 <CAHC9VhSUHMrMjvG=wigsqVA-0MF0LSmCCC_zyoZYHC2wEnT06A@mail.gmail.com>
 <CAEjxPJ72G4bpd6uLy1UikPoU7+tS-Kh2cCO+R75ApoRNCt3_Wg@mail.gmail.com>
 <CAFftDdoineg_FjyPnCtxEjiFtEQ3bZt-M_ePZtfAh-CUNSDwNg@mail.gmail.com> <CAFqZXNtrqoRmMcnP9Pp1ddZrLH1QHmWrYx5BG-QCd62i6FxGNA@mail.gmail.com>
In-Reply-To: <CAFqZXNtrqoRmMcnP9Pp1ddZrLH1QHmWrYx5BG-QCd62i6FxGNA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 15 May 2020 11:46:46 -0500
Message-ID: <CAFftDdoB=uvYA_HZGM01K88A0cNtZ347mMTd07ZN47BBz8LdxQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Ondrej Mosnacek <omosnace@redhat.com>
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

On Fri, May 15, 2020 at 11:41 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, May 15, 2020 at 6:27 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> > I am having an issue with the test suite, perhaps the error would be obvious
> > to you or someone else
> >
> > Error:
> > make[3]: Entering directory '/root/selinux-testsuite/tests/module_load'
> > make[3]: *** /lib/modules/5.6.6-300.fc32.x86_64/build: No such file or
> > directory.  Stop.
> > make[3]: Leaving directory '/root/selinux-testsuite/tests/module_load'
> > make[2]: *** [Makefile:8: all] Error 2
> > make[2]: Leaving directory '/root/selinux-testsuite/tests/module_load'
> > make[1]: *** [Makefile:141: all] Error 1
> > make[1]: Leaving directory '/root/selinux-testsuite/tests'
> > make: *** [Makefile:8: test] Error 2
> >
> > The module_load path exists:
> > [root@demo tests]# ls /lib/modules/5.6.6-300.fc32.x86_64/
> > bls.conf    modules.builtin       modules.drm    source
> > build    modules.builtin.alias.bin  modules.modesetting  symvers.gz
> > config    modules.builtin.bin       modules.networking   System.map
> > kernel    modules.builtin.modinfo    modules.order    updates
> > modules.alias    modules.dep       modules.softdep    vdso
> > modules.alias.bin  modules.dep.bin       modules.symbols    vmlinuz
> > modules.block    modules.devname       modules.symbols.bin
> >
> > And build exists, but it's a file, is that right?
> > [root@demo tests]# stat /lib/modules/5.6.6-300.fc32.x86_64/build
> >   File: /lib/modules/5.6.6-300.fc32.x86_64/build ->
> > /usr/src/kernels/5.6.6-300.fc32.x86_64
> >   Size: 38        Blocks: 0          IO Block: 4096   symbolic link
> > Device: 801h/2049d Inode: 154128      Links: 1
> > Access: (0777/lrwxrwxrwx)  Uid: (    0/    root)   Gid: (    0/    root)
> > Context: system_u:object_r:modules_object_t:s0
> > Access: 2020-05-15 16:23:03.854826122 +0000
> > Modify: 2020-04-21 14:01:58.000000000 +0000
> > Change: 2020-04-22 22:30:37.051096556 +0000
> >  Birth: -
>
> It is a symlink, as evident from the stat output above, which is

very evident, how did I not notice that... (face palm)

> normal. You probably just don't have the matching kernel-devel package
> installed, so the target directory (/usr/src/...) doesn't exist.

It seems installed:
full logs here:
https://travis-ci.org/github/williamcroberts/selinux/builds/687514828

I ran this on my local VM in same error state:
# dnf install -y kernel-devel
Last metadata expiration check: 0:39:22 ago on Fri 15 May 2020 04:05:19 PM UTC.
Package kernel-devel-5.6.12-300.fc32.x86_64 is already installed.
Dependencies resolved.
Nothing to do.
Complete!

Should we add this to the dnf command in the README?:
https://github.com/SELinuxProject/selinux-testsuite

>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
>
