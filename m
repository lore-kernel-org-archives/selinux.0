Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7898DC433E1
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 22:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52167205CB
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 22:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="RD7h8apC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgESWAb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 18:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgESWA3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 May 2020 18:00:29 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B2BC08C5C0
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 15:00:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so765888ejb.10
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 15:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvF4yYzkXWd0MVV+Uc1So/tiNee1XsFnVCchjUnZd44=;
        b=RD7h8apCIoXejTbZeYRGjsTruspfphJ7+If1uHtlDuuc9DXtJusnqAeYk+EY6BU1ta
         QF0LOe4eNATBezKeB8e+sK6nydI/BYUxy4dDucw45qa91gsfOrgVEGnIEaJ+9EsZQQT7
         qrka+oICI+JFO0yMoLPLx4L1ukJnjzVp5+SWY6aX5dnC8+GYOj1VgrKnU4Km7GxYqwca
         sfx8u/eqb1pFdM8wrhLFE4o14lWNFv+eIl4U1B8+KGak7FyRYvDH8nPTBtm68fFcnf3b
         qJ5SmDuWpux25oFd3cUgll2XVEo6LvZ7nHphplq/IkMwW7npEXh+jlLBzAnnzZqzDhoI
         rMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvF4yYzkXWd0MVV+Uc1So/tiNee1XsFnVCchjUnZd44=;
        b=WIX2hw4FCYiFfxvhFmxA8WTiyk8tv+VEfDKW5ge3yVjVBvcnoH3HTMEwWyDtARWJtJ
         QGjOKbu5vbV9ay2RZni76AxEVNKv0zkYB3JE2LavjCaYU8uGYdGGEzq/Zt0ay3mfOEN0
         1qO7jce57M8IdGMuMboeepjk1wVzQ4qQXCiSSTDeOgQNKXi6a7p7tP+4IIna80f9oTtx
         W4QuTI6nBCLsLNjpz4y9LQ1Fm7zMG/IF2NylFg7ZH3wbwBpWixNHu4lOULV9U8upBuIA
         DA/LpavA06HcFcZPpq5icLrvIZHyL4xR+QMo4OCqhkH9jEJ1bY/qLb46rzHvpbl0c0Ls
         wUFA==
X-Gm-Message-State: AOAM532RKc/SWVDPn460ow5wBFX01NPEcOvk83D8dZEl1bGdSG9F5YM4
        tdYLJ9UPrJFcSMTSbBrQkSq0sjGhRDuYUU4PdPtV
X-Google-Smtp-Source: ABdhPJy4T9GRYhgrSCjkYiDuickfCFQyjzaPJk/DU3EdDnpkkzFDDYOYNjbfkO3NuMPq0G2wPHjJQGCITFWXGrQM/fo=
X-Received: by 2002:a17:906:7e15:: with SMTP id e21mr1197098ejr.106.1589925627386;
 Tue, 19 May 2020 15:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200519151457.31618-1-william.c.roberts@intel.com> <20200519151457.31618-2-william.c.roberts@intel.com>
In-Reply-To: <20200519151457.31618-2-william.c.roberts@intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 May 2020 18:00:16 -0400
Message-ID: <CAHC9VhRfWHPkz+rCSAa8kvwVu3dds9q47VfnBFSCJbV3GdMjwQ@mail.gmail.com>
Subject: Re: [PATCH] ci: run SE Linux kernel test suite
To:     bill.c.roberts@gmail.com
Cc:     selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 19, 2020 at 11:15 AM <bill.c.roberts@gmail.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> The current CI runs the userspace tooling and librariers against
> policy files, but cannot test against an SE Linux enabled kernel. Thus,
> some tests are not being done in the CI. Travis, unfortunately only
> provides Ubuntu images, so in order to run against a modern distro with
> SE Linux in enforcing mode, we need to launch a KVM with something like
> Fedora.
>
> This patch enables this support by launching a Fedora32 Cloud Image with
> the selinux userspace library passed on from the travis clone, it then
> builds and replaces the current selinux bits on the Fedora image and
> runs the SE Linux testsuite.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  .travis.yml                      |   8 +++
>  scripts/ci/README.md             |   8 +++
>  scripts/ci/fedora-test-runner.sh |  79 +++++++++++++++++++++
>  scripts/ci/travis-kvm-setup.sh   | 113 +++++++++++++++++++++++++++++++
>  4 files changed, 208 insertions(+)
>  create mode 100644 scripts/ci/README.md
>  create mode 100755 scripts/ci/fedora-test-runner.sh
>  create mode 100755 scripts/ci/travis-kvm-setup.sh

...

> diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
> new file mode 100755
> index 000000000000..8d4b1bf7b8f5
> --- /dev/null
> +++ b/scripts/ci/fedora-test-runner.sh
> @@ -0,0 +1,79 @@
> +#!/usr/bin/env bash
> +
> +set -ev
> +
> +# CI Debug output if things go squirrely.
> +getenforce
> +id -Z
> +nproc
> +pwd

Granted my automated testing experience has been with Fedora Rawhide
and not the stable Fedora releases, but there have been occasions
where the system is broken in some way which prevents the necessary
test setup.  My current approach is to put the system in permissive
mode and leave it there until just before I run my tests.

> +dnf install -y \

Another speaking from experience comment: you probably want to add
"--allowerasing" and "--skip-broken" to the dnf command line.  If you
can cope with the extra overhead, I would even suggest a "dnf clean
all -y" at the start.

> +    git \
> +    audit-libs-devel \
> +    bison \
> +    bzip2-devel \
> +    CUnit-devel \
> +    diffutils \
> +    flex \
> +    gcc \
> +    gettext \
> +    glib2-devel \
> +    make \
> +    libcap-devel \
> +    libcap-ng-devel \
> +    pam-devel \
> +    pcre-devel \
> +    xmlto \
> +    python3-devel \
> +    ruby-devel \
> +    swig \
> +    perl-Test \
> +    perl-Test-Harness \
> +    perl-Test-Simple \
> +    selinux-policy-devel \
> +    gcc \
> +    libselinux-devel \
> +    net-tools \
> +    netlabel_tools \
> +    iptables \
> +    lksctp-tools-devel \
> +    attr \
> +    libbpf-devel \
> +    keyutils-libs-devel \
> +    kernel-devel \
> +    quota \
> +    xfsprogs-devel \
> +    libuuid-devel \
> +    kernel-devel-$(uname -r) \
> +    kernel-modules-$(uname -r)
> +
> +#
> +# Move to selinux code and build
> +#
> +cd ~/selinux
> +
> +# Show HEAD commit for sanity checking
> +git log -1
> +
> +#
> +# Build and replace userspace components
> +#
> +# Note: You can't use parallel builds here (make -jX), you'll end up
> +# with race conditions that manifest like:
> +# semanage_store.lo: file not recognized: file format not recognized
> +#
> +make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel
> +
> +#
> +# Get the selinux testsuite, but don't clone it in ~/selinux, move to ~
> +# first.
> +#
> +cd ~
> +git clone --depth=1 https://github.com/SELinuxProject/selinux-testsuite.git
> +cd selinux-testsuite
> +
> +#
> +# Run the test suite
> +#
> +make test
> diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
> new file mode 100755
> index 000000000000..19287fd21642
> --- /dev/null
> +++ b/scripts/ci/travis-kvm-setup.sh
> @@ -0,0 +1,113 @@
> +#!/usr/bin/env bash

...

> +#
> +# Great we have a host running, ssh into it. We specify -o so
> +# we don't get blocked on asking to add the servers key to
> +# our known_hosts.
> +#
> +ssh -o StrictHostKeyChecking=no "root@$ipaddy" "/root/selinux/$TEST_RUNNER"

Depending on the tests, you'll get better output in the logs if you
add "-tt" to the SSH command line.  You may also want to add "-o
LogLevel=QUIET" too.

> +
> +exit 0

Did you want to return the return value from SSH/$TEST_RUNNER?

-- 
paul moore
www.paul-moore.com
