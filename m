Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FEAC4332D
	for <selinux@archiver.kernel.org>; Wed, 20 Jan 2021 16:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E462F233E2
	for <selinux@archiver.kernel.org>; Wed, 20 Jan 2021 16:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbhATQC1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:02:27 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:44105 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391250AbhATQBi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Jan 2021 11:01:38 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7905A564C48
        for <selinux@vger.kernel.org>; Wed, 20 Jan 2021 17:00:54 +0100 (CET)
Received: by mail-oo1-f51.google.com with SMTP id j8so5907187oon.3
        for <selinux@vger.kernel.org>; Wed, 20 Jan 2021 08:00:54 -0800 (PST)
X-Gm-Message-State: AOAM533aL+vPx0SrvrbM6T8DaZnjMolNYbQ0yfEzM8yP621LCvt4TLx2
        J8GDcUuk0+KU0FQ4H/nhGktRuwZDfBX/zVKDOMA=
X-Google-Smtp-Source: ABdhPJxUyFIpfxVXI44FbBr9O2+fSsvUunbWtYWmde71fE1djPaADY+1iI91erfUkGwvpL4GHsM0LiqgT4TIWxnNbyk=
X-Received: by 2002:a4a:81:: with SMTP id 123mr6674031ooh.46.1611158453316;
 Wed, 20 Jan 2021 08:00:53 -0800 (PST)
MIME-Version: 1.0
References: <20201230200821.3454892-1-nicolas.iooss@m4x.org>
 <CAFftDdoTGNizbiX68drThF=M_QUyRdCD7zb3MGjuKtU-yi_+Vw@mail.gmail.com>
 <CAJfZ7==i=8s=AfVERNfadwdNa-OMJbGdsmCXm=waf1c6w_XrRw@mail.gmail.com>
 <CAJfZ7=kg7Ko8R7NScc+0T3S7dm__7pTE9st0d2gFpGUd7+KY9A@mail.gmail.com> <CAFqZXNuRMPupvO4cc3cmLz9OmDkxqz_=2a-iS_=jUR4h=pMDJQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuRMPupvO4cc3cmLz9OmDkxqz_=2a-iS_=jUR4h=pMDJQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 20 Jan 2021 17:00:42 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=m7WdqH1Pbba5EG4fdOBsMwsy=zMHWt6T5JvByeJeR3Jw@mail.gmail.com>
Message-ID: <CAJfZ7=m7WdqH1Pbba5EG4fdOBsMwsy=zMHWt6T5JvByeJeR3Jw@mail.gmail.com>
Subject: Re: [PATCH 1/1] GitHub Actions: run SELinux testsuite in Fedora
 virtual machine
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jan 20 17:00:55 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 19, 2021 at 3:32 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, Jan 6, 2021 at 9:19 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > On Sat, Jan 2, 2021 at 11:35 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > >
> > > On Thu, Dec 31, 2020 at 3:43 PM William Roberts
> > > <bill.c.roberts@gmail.com> wrote:
> > > >
> > > > On Wed, Dec 30, 2020 at 2:12 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > > > >
> > > > > Use the Vagrant configuration in scripts/ci in a workflow for GitHub
> > > > > Actions.
> > > > >
> > > > > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > > > > ---
> > > > > Example of run: https://github.com/fishilico/selinux/runs/1627586446
> > > > >
> > > > >  .github/workflows/vm_testsuite.yml | 22 ++++++++++++++++++++++
> > > > >  1 file changed, 22 insertions(+)
> > > > >  create mode 100644 .github/workflows/vm_testsuite.yml
> > > > >
> > > > > diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_testsuite.yml
> > > > > new file mode 100644
> > > > > index 000000000000..af2fad1e73f5
> > > > > --- /dev/null
> > > > > +++ b/.github/workflows/vm_testsuite.yml
> > > > > @@ -0,0 +1,22 @@
> > > > > +name: Run SELinux testsuite in a virtual machine
> > > > > +
> > > > > +on: [push, pull_request]
> > > > > +
> > > > > +jobs:
> > > > > +  vm_testsuite:
> > > > > +
> > > > > +    # Use VirtualBox+vagrant on macOS, as described in https://github.com/actions/virtual-environments/issues/433
> > > > > +    runs-on: macos-latest
> > > >
> > > > Good find, they support nested virtualization.
> > > >
> > > > > +
> > > > > +    steps:
> > > > > +    - uses: actions/checkout@v2
> > > > > +
> > > > > +    - name: Create Vagrant VM
> > > > > +      run: |
> > > > > +        cd scripts/ci
> > > > > +        vagrant up
> > > > > +
> > > > > +    - name: Run SELinux testsuite in the VM
> > > > > +      run: |
> > > > > +        cd scripts/ci
> > > > > +        vagrant ssh -- ./run-selinux-test.sh
> > > > > --
> > > > > 2.29.2
> > > > >
> > > >
> > > > LGTM ack. Do you have any fork that has a build with this just to see
> > > > it running?
> > >
> > > Yes, I have been testing it on
> > > https://github.com/fishilico/selinux/actions, with several successful
> > > builds such as https://github.com/fishilico/selinux/runs/1627586446.
> > >
> > > Thanks,
> > > Nicolas
> >
> > For information, I have been experiencing some failures due to timeout
> > issues while Github Actions creates the Vagrant environment, for
> > example in https://github.com/fishilico/selinux/runs/1652713066. I am
> > currently trying to run test jobs with "config.vm.boot_timeout = 600"
> > (the default value is 300 seconds) in scripts/ci/Vagrantfile and would
> > like to wait a little bit before merging this patch, to see whether
> > this fixes my issue. I do not want to introduce instability in our CI
> > pipeline.
>
> Hi Nicholas, any update here? I have drafted a similar patch for
> selinux-testsuite's own CI, but have been waiting on your findings
> regarding the timeouts to avoid needless followups.
>
> Thanks a lot for finding a way to make this work with GH Actions!

Hi,
Sorry for the delay. I have been quite busy in the past two weeks, but
I am catching up on the latest patches and messages.

I am still experiencing occasional boot timeouts (for example in
https://github.com/fishilico/selinux/runs/1667663667), despite using
"config.vm.boot_timeout = 600" in Vagrantfile. But when this occurs,
restarting the GitHub Actions job works. So this is quite annoying but
I believe we can live with it (this means that someone will need to
click on "Re-run all jobs" on GitHub when this happens). So I merged
my patch, and if it becomes too annoying, this workflow can be
disabled in the future.

Nicolas

