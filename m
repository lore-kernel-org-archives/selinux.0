Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6028BC433E1
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 17:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD67206D8
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 17:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzEahndF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgEORSZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 13:18:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57892 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEORSY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 13:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589563102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dW67uuDjUytjjkiLusAYr57N+dkbG1PBvGQvOeW5LM=;
        b=DzEahndFyrNKAiInmkpRmFWcEDEHidapTrLtzBax4+7ShsIj/ceIxILetBPEO06d6LUAI5
        yhWsv8wHOQDRprO/n/b2/b/fDL0V+f0uSoNuxkmRYgIyFk+wQEmeYujnp08dVAmZbVewVQ
        Smni+n7/m3vWPWVeHnJR6/Mnl/C/PYU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-ouvCGobfMxqzpvJnq2Brqg-1; Fri, 15 May 2020 13:18:18 -0400
X-MC-Unique: ouvCGobfMxqzpvJnq2Brqg-1
Received: by mail-ot1-f72.google.com with SMTP id y10so1556855otk.14
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 10:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+dW67uuDjUytjjkiLusAYr57N+dkbG1PBvGQvOeW5LM=;
        b=ANiz9IMZEiygttDhdEoP3cmj9ahIwRzTMlRRFdZgzlQfp5KoHmHKkWysO7yW60Gfos
         aEnpwsy236ekjs+QCKNuhIiPwOH+O0d0SpLBsuVycBgOewTJF7WnOpRraMYwpsBQRWrd
         j/U9Bnxc6N5PSe4JuBrB1s+zLC1uDetk9WPCUeBe0ZUIBoUrchfOXe42Z9Aq+rqLU93S
         SPuRpAg0hZOIodNDE1WhHgqjme0LcCubeZLgc3L70CrC+O7bhuF1LWtaznuwpOQBy5O8
         b/66E7kynyd11f8fvX3L2Hh3kMpBHBkB3627Rypa1pclOKa6QEy2lpzymCdHnUNxwYc0
         8j1A==
X-Gm-Message-State: AOAM533J3DNDI+NYzth+zcnvFrDqEo/dkmzpZ6dHvL89SFg4MtFhlRYy
        tQZ8bVVvcQk0vAPWZ8OHL9MU7KYmqsXzfpKWjic2WhQv+KW5S/60xxWp+7jlz5JXqLiJOAdubjG
        aLivvVXf4IoNOtEX9AgrnI0FLDZJoMwCxsQ==
X-Received: by 2002:a05:6830:138b:: with SMTP id d11mr2931089otq.367.1589563096867;
        Fri, 15 May 2020 10:18:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZYsEEFusDGTLXRxy0b33AP+gHmBe9w/L/AKhdtL9opqvV96aLpn54UMc9wqRcNjex0PaJja3kuh84ToOIJfc=
X-Received: by 2002:a05:6830:138b:: with SMTP id d11mr2931060otq.367.1589563096599;
 Fri, 15 May 2020 10:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <CAFftDdrD-FJ8wBk=XOkvdnkvA5o10w5pJs31H9dEhtW1zU8EHA@mail.gmail.com>
 <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com>
 <3838641.zh4Wi6GlAV@liv> <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
 <CAEjxPJ6Uo83L5C9UELy5w_V2wuptSHiHoMMLN4oh75x70-ZzAQ@mail.gmail.com>
 <CAHC9VhSUHMrMjvG=wigsqVA-0MF0LSmCCC_zyoZYHC2wEnT06A@mail.gmail.com>
 <CAEjxPJ72G4bpd6uLy1UikPoU7+tS-Kh2cCO+R75ApoRNCt3_Wg@mail.gmail.com>
 <CAFftDdoineg_FjyPnCtxEjiFtEQ3bZt-M_ePZtfAh-CUNSDwNg@mail.gmail.com>
 <CAFqZXNtrqoRmMcnP9Pp1ddZrLH1QHmWrYx5BG-QCd62i6FxGNA@mail.gmail.com> <CAFftDdoB=uvYA_HZGM01K88A0cNtZ347mMTd07ZN47BBz8LdxQ@mail.gmail.com>
In-Reply-To: <CAFftDdoB=uvYA_HZGM01K88A0cNtZ347mMTd07ZN47BBz8LdxQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 15 May 2020 19:18:05 +0200
Message-ID: <CAFqZXNsQxxrn3=N0V+Og0dEu1EGb37g0GFhAv7bXpA04oMeo1g@mail.gmail.com>
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

On Fri, May 15, 2020 at 6:47 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Fri, May 15, 2020 at 11:41 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Fri, May 15, 2020 at 6:27 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > > I am having an issue with the test suite, perhaps the error would be obvious
> > > to you or someone else
> > >
> > > Error:
> > > make[3]: Entering directory '/root/selinux-testsuite/tests/module_load'
> > > make[3]: *** /lib/modules/5.6.6-300.fc32.x86_64/build: No such file or
> > > directory.  Stop.
> > > make[3]: Leaving directory '/root/selinux-testsuite/tests/module_load'
> > > make[2]: *** [Makefile:8: all] Error 2
> > > make[2]: Leaving directory '/root/selinux-testsuite/tests/module_load'
> > > make[1]: *** [Makefile:141: all] Error 1
> > > make[1]: Leaving directory '/root/selinux-testsuite/tests'
> > > make: *** [Makefile:8: test] Error 2
> > >
> > > The module_load path exists:
> > > [root@demo tests]# ls /lib/modules/5.6.6-300.fc32.x86_64/
> > > bls.conf    modules.builtin       modules.drm    source
> > > build    modules.builtin.alias.bin  modules.modesetting  symvers.gz
> > > config    modules.builtin.bin       modules.networking   System.map
> > > kernel    modules.builtin.modinfo    modules.order    updates
> > > modules.alias    modules.dep       modules.softdep    vdso
> > > modules.alias.bin  modules.dep.bin       modules.symbols    vmlinuz
> > > modules.block    modules.devname       modules.symbols.bin
> > >
> > > And build exists, but it's a file, is that right?
> > > [root@demo tests]# stat /lib/modules/5.6.6-300.fc32.x86_64/build
> > >   File: /lib/modules/5.6.6-300.fc32.x86_64/build ->
> > > /usr/src/kernels/5.6.6-300.fc32.x86_64
> > >   Size: 38        Blocks: 0          IO Block: 4096   symbolic link
> > > Device: 801h/2049d Inode: 154128      Links: 1
> > > Access: (0777/lrwxrwxrwx)  Uid: (    0/    root)   Gid: (    0/    root)
> > > Context: system_u:object_r:modules_object_t:s0
> > > Access: 2020-05-15 16:23:03.854826122 +0000
> > > Modify: 2020-04-21 14:01:58.000000000 +0000
> > > Change: 2020-04-22 22:30:37.051096556 +0000
> > >  Birth: -
> >
> > It is a symlink, as evident from the stat output above, which is
>
> very evident, how did I not notice that... (face palm)
>
> > normal. You probably just don't have the matching kernel-devel package
> > installed, so the target directory (/usr/src/...) doesn't exist.
>
> It seems installed:

There is a subtle catch :) You need to have the exact version that
matches your $(uname -r). In your case it seems to be
5.6.6-300.fc32.x86_64, while you probably only have the latest version
of kernel-devel (5.6.12-300.fc32.x86_64). Try:

dnf install -y kernel-devel-$(uname -r)

Note that this may fail if the corresponding version is no longer in
the repos (5.6.12 >> 5.6.6, so it will probably fail in your case). In
that case you need to reboot the VM so that you run under the latest
installed kernel, for which you have kernel-devel.

> full logs here:
> https://travis-ci.org/github/williamcroberts/selinux/builds/687514828
>
> I ran this on my local VM in same error state:
> # dnf install -y kernel-devel
> Last metadata expiration check: 0:39:22 ago on Fri 15 May 2020 04:05:19 PM UTC.
> Package kernel-devel-5.6.12-300.fc32.x86_64 is already installed.
> Dependencies resolved.
> Nothing to do.
> Complete!
>
> Should we add this to the dnf command in the README?:
> https://github.com/SELinuxProject/selinux-testsuite

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

