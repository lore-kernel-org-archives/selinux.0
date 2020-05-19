Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC18C433E0
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 22:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1632075F
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 22:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3X/tLC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgESWQQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 18:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESWQP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 May 2020 18:16:15 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA39C061A0F
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 15:16:15 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j2so1078269ilr.5
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 15:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kjid684QBKfyMfFWwVV1LI2HIPYsXHuo4wLttEP991w=;
        b=Z3X/tLC2Y57yvzCng2XVjG7eiPdxUKthgmg6NtsKzUQBJer0BXwKnZFWOUsrqwDfG2
         vWkmIsLyVfHimUPibzr4P4X9DQhcu89aKG+1+1QCyBje7DxY/DGlxvGM8vVSC+KlI08z
         DEKVPb30Ala+a75Bkl55ZzleuMnLmvBPJ0FuTJoKT6sLvaOZK6NX06Hzpq1BYv+cmoIC
         KEOfiGWJI0pB8aQMere5MDcVA9WV5KDTBSOoA8aDDaJr4mcfHkLzVEJX9Z1kFh9bdXfC
         T+pZZGyQyxcgLahzu1oYupq8kgtCb298+ISLi5ciglxL/+FeHSWhmCCl34fXsrISgzkl
         Lnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kjid684QBKfyMfFWwVV1LI2HIPYsXHuo4wLttEP991w=;
        b=EQQSQTwSzZQvIz3ylIzO/IHHBSsR/MtHm1+1pmOYxzo6xK2tGAl+JPI9p/6Y8PaDD3
         BK+O+oz+S22uMz9NI8RNaQ9lubQFHUFtQMA8LZ/DlknGWq8dcKCnpbEU73EbUxGel7s/
         w7GGFqP/PSBrGCHzbyKPW93+BZRLYY4armkJ+dsCR2UQhwA4ZqjD09oVdAj52PptvITU
         +ZoebZ//Suh2irvIvxWgewnUb6M+eT+wTB9qxKVLCZjb37cG4Qqx3+lYsLid+DOKk4wa
         tdJqeXlBgAydK0OmRxIFyjglDJl6mXVc/4cjh7u4BeUItNd10LA2OrHtbhqfKxGZPjxh
         +X6w==
X-Gm-Message-State: AOAM530vqV50IpaibbwtvqoywCpMOg55dcJhJO6/DSbh/LhnGHZ+GNQ5
        kCtT/BmcBtblGxsy6nIOjDLcQTBO/J79d0C899Vg1SMZ
X-Google-Smtp-Source: ABdhPJyqYJNPTXffzdS7u2EqFEKbiQWstN7uP39NxzSAVf5EW8gIjyER9ve7ghmLVjdEY+xc3efBRnrY46DjXt0NOqg=
X-Received: by 2002:a92:d2ca:: with SMTP id w10mr1263789ilg.141.1589926574403;
 Tue, 19 May 2020 15:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200519151457.31618-1-william.c.roberts@intel.com>
 <20200519151457.31618-2-william.c.roberts@intel.com> <CAHC9VhRfWHPkz+rCSAa8kvwVu3dds9q47VfnBFSCJbV3GdMjwQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRfWHPkz+rCSAa8kvwVu3dds9q47VfnBFSCJbV3GdMjwQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 19 May 2020 17:16:03 -0500
Message-ID: <CAFftDdpPS0wt3VHiMS6sMKTqAgviNB-TBRT1YqbrzgJftPFj_w@mail.gmail.com>
Subject: Re: [PATCH] ci: run SE Linux kernel test suite
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 19, 2020 at 5:00 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, May 19, 2020 at 11:15 AM <bill.c.roberts@gmail.com> wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > The current CI runs the userspace tooling and librariers against
> > policy files, but cannot test against an SE Linux enabled kernel. Thus,
> > some tests are not being done in the CI. Travis, unfortunately only
> > provides Ubuntu images, so in order to run against a modern distro with
> > SE Linux in enforcing mode, we need to launch a KVM with something like
> > Fedora.
> >
> > This patch enables this support by launching a Fedora32 Cloud Image with
> > the selinux userspace library passed on from the travis clone, it then
> > builds and replaces the current selinux bits on the Fedora image and
> > runs the SE Linux testsuite.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  .travis.yml                      |   8 +++
> >  scripts/ci/README.md             |   8 +++
> >  scripts/ci/fedora-test-runner.sh |  79 +++++++++++++++++++++
> >  scripts/ci/travis-kvm-setup.sh   | 113 +++++++++++++++++++++++++++++++
> >  4 files changed, 208 insertions(+)
> >  create mode 100644 scripts/ci/README.md
> >  create mode 100755 scripts/ci/fedora-test-runner.sh
> >  create mode 100755 scripts/ci/travis-kvm-setup.sh
>
> ...
>
> > diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
> > new file mode 100755
> > index 000000000000..8d4b1bf7b8f5
> > --- /dev/null
> > +++ b/scripts/ci/fedora-test-runner.sh
> > @@ -0,0 +1,79 @@
> > +#!/usr/bin/env bash
> > +
> > +set -ev
> > +
> > +# CI Debug output if things go squirrely.
> > +getenforce
> > +id -Z
> > +nproc
> > +pwd
>
> Granted my automated testing experience has been with Fedora Rawhide
> and not the stable Fedora releases, but there have been occasions
> where the system is broken in some way which prevents the necessary
> test setup.  My current approach is to put the system in permissive
> mode and leave it there until just before I run my tests.

We can do that.

>
> > +dnf install -y \
>
> Another speaking from experience comment: you probably want to add
> "--allowerasing" and "--skip-broken" to the dnf command line.  If you
> can cope with the extra overhead, I would even suggest a "dnf clean
> all -y" at the start.

I don't see why we couldn't.

Not really sure if it matters for those first two things, considering
that were starting
in the same state each time. Its not like we need to work on a system
that's already
been played with.

I can add them and see what kind of increase it adds to the CI time. I'm sure
it's tolerable (obviously set permissive is fast, I'm talking about
the dnf stuff adding time).

>
> > +    git \
> > +    audit-libs-devel \
> > +    bison \
> > +    bzip2-devel \
> > +    CUnit-devel \
> > +    diffutils \
> > +    flex \
> > +    gcc \
> > +    gettext \
> > +    glib2-devel \
> > +    make \
> > +    libcap-devel \
> > +    libcap-ng-devel \
> > +    pam-devel \
> > +    pcre-devel \
> > +    xmlto \
> > +    python3-devel \
> > +    ruby-devel \
> > +    swig \
> > +    perl-Test \
> > +    perl-Test-Harness \
> > +    perl-Test-Simple \
> > +    selinux-policy-devel \
> > +    gcc \
> > +    libselinux-devel \
> > +    net-tools \
> > +    netlabel_tools \
> > +    iptables \
> > +    lksctp-tools-devel \
> > +    attr \
> > +    libbpf-devel \
> > +    keyutils-libs-devel \
> > +    kernel-devel \
> > +    quota \
> > +    xfsprogs-devel \
> > +    libuuid-devel \
> > +    kernel-devel-$(uname -r) \
> > +    kernel-modules-$(uname -r)
> > +
> > +#
> > +# Move to selinux code and build
> > +#
> > +cd ~/selinux
> > +
> > +# Show HEAD commit for sanity checking
> > +git log -1
> > +
> > +#
> > +# Build and replace userspace components
> > +#
> > +# Note: You can't use parallel builds here (make -jX), you'll end up
> > +# with race conditions that manifest like:
> > +# semanage_store.lo: file not recognized: file format not recognized
> > +#
> > +make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel
> > +
> > +#
> > +# Get the selinux testsuite, but don't clone it in ~/selinux, move to ~
> > +# first.
> > +#
> > +cd ~
> > +git clone --depth=1 https://github.com/SELinuxProject/selinux-testsuite.git
> > +cd selinux-testsuite
> > +
> > +#
> > +# Run the test suite
> > +#
> > +make test
> > diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
> > new file mode 100755
> > index 000000000000..19287fd21642
> > --- /dev/null
> > +++ b/scripts/ci/travis-kvm-setup.sh
> > @@ -0,0 +1,113 @@
> > +#!/usr/bin/env bash
>
> ...
>
> > +#
> > +# Great we have a host running, ssh into it. We specify -o so
> > +# we don't get blocked on asking to add the servers key to
> > +# our known_hosts.
> > +#
> > +ssh -o StrictHostKeyChecking=no "root@$ipaddy" "/root/selinux/$TEST_RUNNER"
>
> Depending on the tests, you'll get better output in the logs if you
> add "-tt" to the SSH command line.  You may also want to add "-o
> LogLevel=QUIET" too.

+1

>
> > +
> > +exit 0
>
> Did you want to return the return value from SSH/$TEST_RUNNER?

set -e, ssh will cause the shell to exit with whatever code it returns
that's not 0.

>
> --
> paul moore
> www.paul-moore.com
