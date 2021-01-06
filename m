Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C42C433E0
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 08:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C41923105
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 08:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbhAFISl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 03:18:41 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:51653 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbhAFISl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 03:18:41 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 21F325612A1
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 09:17:59 +0100 (CET)
Received: by mail-oi1-f172.google.com with SMTP id f132so2608450oib.12
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 00:17:59 -0800 (PST)
X-Gm-Message-State: AOAM532tXbK+NUgb45Y6b2VdW24qqVBYPqAc+IL6z9ri9lnKX6W1tpc5
        /rAUtmx6TxQwkF/gGU5D54UAPJcmjBfw04yYZ8E=
X-Google-Smtp-Source: ABdhPJz4sd4VVBv911RFLfW8bDqqIa8NIBJG3pCWRtrz72mx618J+DjRFrSFP7Qe/5dMRi2G7eG954A+RrqSHe73eKw=
X-Received: by 2002:aca:51d8:: with SMTP id f207mr2484489oib.20.1609921077902;
 Wed, 06 Jan 2021 00:17:57 -0800 (PST)
MIME-Version: 1.0
References: <20201230200821.3454892-1-nicolas.iooss@m4x.org>
 <CAFftDdoTGNizbiX68drThF=M_QUyRdCD7zb3MGjuKtU-yi_+Vw@mail.gmail.com> <CAJfZ7==i=8s=AfVERNfadwdNa-OMJbGdsmCXm=waf1c6w_XrRw@mail.gmail.com>
In-Reply-To: <CAJfZ7==i=8s=AfVERNfadwdNa-OMJbGdsmCXm=waf1c6w_XrRw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 6 Jan 2021 09:17:47 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kg7Ko8R7NScc+0T3S7dm__7pTE9st0d2gFpGUd7+KY9A@mail.gmail.com>
Message-ID: <CAJfZ7=kg7Ko8R7NScc+0T3S7dm__7pTE9st0d2gFpGUd7+KY9A@mail.gmail.com>
Subject: Re: [PATCH 1/1] GitHub Actions: run SELinux testsuite in Fedora
 virtual machine
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jan  6 09:17:59 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jan 2, 2021 at 11:35 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Dec 31, 2020 at 3:43 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Wed, Dec 30, 2020 at 2:12 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > >
> > > Use the Vagrant configuration in scripts/ci in a workflow for GitHub
> > > Actions.
> > >
> > > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > > ---
> > > Example of run: https://github.com/fishilico/selinux/runs/1627586446
> > >
> > >  .github/workflows/vm_testsuite.yml | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >  create mode 100644 .github/workflows/vm_testsuite.yml
> > >
> > > diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_testsuite.yml
> > > new file mode 100644
> > > index 000000000000..af2fad1e73f5
> > > --- /dev/null
> > > +++ b/.github/workflows/vm_testsuite.yml
> > > @@ -0,0 +1,22 @@
> > > +name: Run SELinux testsuite in a virtual machine
> > > +
> > > +on: [push, pull_request]
> > > +
> > > +jobs:
> > > +  vm_testsuite:
> > > +
> > > +    # Use VirtualBox+vagrant on macOS, as described in https://github.com/actions/virtual-environments/issues/433
> > > +    runs-on: macos-latest
> >
> > Good find, they support nested virtualization.
> >
> > > +
> > > +    steps:
> > > +    - uses: actions/checkout@v2
> > > +
> > > +    - name: Create Vagrant VM
> > > +      run: |
> > > +        cd scripts/ci
> > > +        vagrant up
> > > +
> > > +    - name: Run SELinux testsuite in the VM
> > > +      run: |
> > > +        cd scripts/ci
> > > +        vagrant ssh -- ./run-selinux-test.sh
> > > --
> > > 2.29.2
> > >
> >
> > LGTM ack. Do you have any fork that has a build with this just to see
> > it running?
>
> Yes, I have been testing it on
> https://github.com/fishilico/selinux/actions, with several successful
> builds such as https://github.com/fishilico/selinux/runs/1627586446.
>
> Thanks,
> Nicolas

For information, I have been experiencing some failures due to timeout
issues while Github Actions creates the Vagrant environment, for
example in https://github.com/fishilico/selinux/runs/1652713066. I am
currently trying to run test jobs with "config.vm.boot_timeout = 600"
(the default value is 300 seconds) in scripts/ci/Vagrantfile and would
like to wait a little bit before merging this patch, to see whether
this fixes my issue. I do not want to introduce instability in our CI
pipeline.

Nicolas

