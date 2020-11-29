Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A87EC3E8C5
	for <selinux@archiver.kernel.org>; Sun, 29 Nov 2020 18:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C84320825
	for <selinux@archiver.kernel.org>; Sun, 29 Nov 2020 18:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgK2S1x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 29 Nov 2020 13:27:53 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:60404 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2S1w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 29 Nov 2020 13:27:52 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id DD1F8564C3D
        for <selinux@vger.kernel.org>; Sun, 29 Nov 2020 19:27:09 +0100 (CET)
Received: by mail-oi1-f171.google.com with SMTP id o25so11862036oie.5
        for <selinux@vger.kernel.org>; Sun, 29 Nov 2020 10:27:09 -0800 (PST)
X-Gm-Message-State: AOAM530Z+mBBBwAyLPKSpB07HyUBZt4ZSITfsF2NNUI3/YtzX53I6JsS
        xGFj9E3GDcnxTk9i1F+/G/h6md+kH7IPCoqXcM0=
X-Google-Smtp-Source: ABdhPJwcnl0jMhXuQi3ZwlC7ywN3t8RbUUCgx9ZFqqkZPaHs51EmsWxeXE2xHhuIyZGPCHBaw9cpObzZq5Aw19uFrKs=
X-Received: by 2002:aca:aa47:: with SMTP id t68mr12323630oie.40.1606674428920;
 Sun, 29 Nov 2020 10:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20201124075022.37033-1-nicolas.iooss@m4x.org> <CAFqZXNsdOg4ogvhvZ8u7VHrT4h3iHbv8cy9C3RiGQNL=LEKHhA@mail.gmail.com>
In-Reply-To: <CAFqZXNsdOg4ogvhvZ8u7VHrT4h3iHbv8cy9C3RiGQNL=LEKHhA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 29 Nov 2020 19:26:58 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==p2X8RsLYzdGLHCsAXcM9UaLTNcBGo6FyUDepXxFsxwQ@mail.gmail.com>
Message-ID: <CAJfZ7==p2X8RsLYzdGLHCsAXcM9UaLTNcBGo6FyUDepXxFsxwQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add configuration to build and run tests in GitHub Actions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Nov 29 19:27:10 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 25, 2020 at 4:43 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Tue, Nov 24, 2020 at 8:51 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > Copy the tests that are currently run on Travis CI, in order to no
> > longer depends on Travis CI.
>
> s/dependes/depend/, but that can be fixed up when applying.
>
> >
> > For more context: Travis-CI is changing its offer, as documented in
> > https://docs.travis-ci.com/user/migrate/open-source-repository-migration
> > and SELinuxProject moved to https://travis-ci.com
> > https://lore.kernel.org/selinux/CAFqZXNspH6MmB-o0wtJJwj-p0DKKrH-ZjfW2YkF_yQS_gCBwqQ@mail.gmail.com/T/#t
> >
> > Unfortunately the credits for opensource projects are quite limited, and
> > require interaction with Travis CI support (which was quite unresponsive
> > when I contacted them for other opensource projects I am maintaining).
> >
> > Create a configuration for Github Actions that duplicates most Travis CI
> > checks.
> >
> > * macOS check has not yet been converted, but GitHub Actions support
> >   this platform so this can be done in another patch (and in another
> >   configuration in .github/workflows ?).
> >
> > * KVM support is not available on GitHub Actions so running SELinux
> >   testsuite in a Fedora VM is not possible. This is a known issue
> >   (https://github.com/actions/virtual-environments/issues/183) and other
> >   projects seem to face the same issue (for example
> >   https://github.com/opencontainers/runc/issues/2670).
>
> It's not technically impossible, but when I tried to run the testsuite
> in a VM without virtualization in GH actions, it was very very slow,
> so practically it is infeasible. IIRC when I tried it, it didn't even
> install all dependencies after half an hour...
>
> >
> > This configuration has been tested on
> > https://github.com/fishilico/selinux/actions/runs/380579153
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  .github/workflows/run_tests.yml | 189 ++++++++++++++++++++++++++++++++
> >  1 file changed, 189 insertions(+)
> >  create mode 100644 .github/workflows/run_tests.yml
>
> LGTM, thank you for doing this!
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

And merged. Thanks!
Nicolas

