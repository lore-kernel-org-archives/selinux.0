Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438B1C433E0
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 09:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC15422DBF
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 09:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbhAVJlu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Jan 2021 04:41:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727123AbhAVJkx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Jan 2021 04:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611308364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oSR3M07dyFgJcEzp9DifRiG6WWRvYHAEsVWAFxu1C1w=;
        b=LgL6Xcw9v2A6HR88gq5NxiDuPMcB42pbwJ5C61owhr7pNYGTbscCkBLemrZLlpUl/B0sQQ
        Mx5h5B8cTsMK02RYqRvaHR+Ai58Snad0x9D6RBWD30G1veACOxOOuekPcEQIqHTmjgl3ZP
        DS11KKuEabX56x6bR0JF5wwJIrypfAo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-qvX62Th5Mai4ICs-lmp8xA-1; Fri, 22 Jan 2021 04:39:20 -0500
X-MC-Unique: qvX62Th5Mai4ICs-lmp8xA-1
Received: by mail-lf1-f72.google.com with SMTP id 137so1202434lfj.11
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 01:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSR3M07dyFgJcEzp9DifRiG6WWRvYHAEsVWAFxu1C1w=;
        b=k6stJaulMP4Kt+Y58E8lCItpsZK/dcYo/ZhhE7LX/E4J6p1VC64VJ5BSP7tuPIGvH2
         mk3W3wAf+PkqqMjwDI2j/8LbHHd9qO1R81w19yvkosxoyOYP/hkfwhX83HlgkDTr51og
         sAs90theHwadRnlWrnDgEUM8YnXPaQLBv4R5tYujjsvpdbFKX6xu9swcqLUTJBjBGUZc
         5oV9Um8VSns8qDFtiCkhSrEI0HZIVuDEkXaEKg+UG4vKmri1mUASa4H9RH7dmMeet/j8
         IbTi1UcaqR8PGSPf72iWqW53KXK5gnkPtNttVPI6iS1vh95CeoqULAiOA3Nz/HjUb+QA
         XZlg==
X-Gm-Message-State: AOAM533wAjgWo8aVd3d0KOGU+O8CXyXstVB1jPCDfph9mg0QOmDJv4y/
        BFIWyblnrRmzlSMD5J1RjdaQfjYrvpvdgEhX+CXRKX0YsXCETCvqYbxJfrz0cNrYScqscNEDKpF
        XJo31+vDFKa7iBe0PvsnAQVNNGL31uzOXGQ==
X-Received: by 2002:a19:7403:: with SMTP id v3mr1138091lfe.67.1611308358671;
        Fri, 22 Jan 2021 01:39:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxi3S5GsrV7sSxnS0TizLebi4uphun2AjWk4sNO9HF92gWZpST0Cr6aS87+b7y2qufvn8HAlxpSubuiCTKWGPo=
X-Received: by 2002:a19:7403:: with SMTP id v3mr1138081lfe.67.1611308358434;
 Fri, 22 Jan 2021 01:39:18 -0800 (PST)
MIME-Version: 1.0
References: <20201230200821.3454892-1-nicolas.iooss@m4x.org>
 <CAFftDdoTGNizbiX68drThF=M_QUyRdCD7zb3MGjuKtU-yi_+Vw@mail.gmail.com>
 <CAJfZ7==i=8s=AfVERNfadwdNa-OMJbGdsmCXm=waf1c6w_XrRw@mail.gmail.com>
 <CAJfZ7=kg7Ko8R7NScc+0T3S7dm__7pTE9st0d2gFpGUd7+KY9A@mail.gmail.com>
 <CAFqZXNuRMPupvO4cc3cmLz9OmDkxqz_=2a-iS_=jUR4h=pMDJQ@mail.gmail.com> <CAJfZ7=m7WdqH1Pbba5EG4fdOBsMwsy=zMHWt6T5JvByeJeR3Jw@mail.gmail.com>
In-Reply-To: <CAJfZ7=m7WdqH1Pbba5EG4fdOBsMwsy=zMHWt6T5JvByeJeR3Jw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 22 Jan 2021 10:39:08 +0100
Message-ID: <CAFqZXNt5-Uc_jF7YX25QwLAdMmuwkfsspqjaBC2JztG-QoxEVg@mail.gmail.com>
Subject: Re: [PATCH 1/1] GitHub Actions: run SELinux testsuite in Fedora
 virtual machine
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 20, 2021 at 5:07 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> On Tue, Jan 19, 2021 at 3:32 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Wed, Jan 6, 2021 at 9:19 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > >
> > > On Sat, Jan 2, 2021 at 11:35 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > > >
> > > > On Thu, Dec 31, 2020 at 3:43 PM William Roberts
> > > > <bill.c.roberts@gmail.com> wrote:
> > > > >
> > > > > On Wed, Dec 30, 2020 at 2:12 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > > > > >
> > > > > > Use the Vagrant configuration in scripts/ci in a workflow for GitHub
> > > > > > Actions.
> > > > > >
> > > > > > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > > > > > ---
> > > > > > Example of run: https://github.com/fishilico/selinux/runs/1627586446
> > > > > >
> > > > > >  .github/workflows/vm_testsuite.yml | 22 ++++++++++++++++++++++
> > > > > >  1 file changed, 22 insertions(+)
> > > > > >  create mode 100644 .github/workflows/vm_testsuite.yml
> > > > > >
> > > > > > diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_testsuite.yml
> > > > > > new file mode 100644
> > > > > > index 000000000000..af2fad1e73f5
> > > > > > --- /dev/null
> > > > > > +++ b/.github/workflows/vm_testsuite.yml
> > > > > > @@ -0,0 +1,22 @@
> > > > > > +name: Run SELinux testsuite in a virtual machine
> > > > > > +
> > > > > > +on: [push, pull_request]
> > > > > > +
> > > > > > +jobs:
> > > > > > +  vm_testsuite:
> > > > > > +
> > > > > > +    # Use VirtualBox+vagrant on macOS, as described in https://github.com/actions/virtual-environments/issues/433
> > > > > > +    runs-on: macos-latest
> > > > >
> > > > > Good find, they support nested virtualization.
> > > > >
> > > > > > +
> > > > > > +    steps:
> > > > > > +    - uses: actions/checkout@v2
> > > > > > +
> > > > > > +    - name: Create Vagrant VM
> > > > > > +      run: |
> > > > > > +        cd scripts/ci
> > > > > > +        vagrant up
> > > > > > +
> > > > > > +    - name: Run SELinux testsuite in the VM
> > > > > > +      run: |
> > > > > > +        cd scripts/ci
> > > > > > +        vagrant ssh -- ./run-selinux-test.sh
> > > > > > --
> > > > > > 2.29.2
> > > > > >
> > > > >
> > > > > LGTM ack. Do you have any fork that has a build with this just to see
> > > > > it running?
> > > >
> > > > Yes, I have been testing it on
> > > > https://github.com/fishilico/selinux/actions, with several successful
> > > > builds such as https://github.com/fishilico/selinux/runs/1627586446.
> > > >
> > > > Thanks,
> > > > Nicolas
> > >
> > > For information, I have been experiencing some failures due to timeout
> > > issues while Github Actions creates the Vagrant environment, for
> > > example in https://github.com/fishilico/selinux/runs/1652713066. I am
> > > currently trying to run test jobs with "config.vm.boot_timeout = 600"
> > > (the default value is 300 seconds) in scripts/ci/Vagrantfile and would
> > > like to wait a little bit before merging this patch, to see whether
> > > this fixes my issue. I do not want to introduce instability in our CI
> > > pipeline.
> >
> > Hi Nicholas, any update here? I have drafted a similar patch for
> > selinux-testsuite's own CI, but have been waiting on your findings
> > regarding the timeouts to avoid needless followups.
> >
> > Thanks a lot for finding a way to make this work with GH Actions!
>
> Hi,
> Sorry for the delay. I have been quite busy in the past two weeks, but
> I am catching up on the latest patches and messages.
>
> I am still experiencing occasional boot timeouts (for example in
> https://github.com/fishilico/selinux/runs/1667663667), despite using
> "config.vm.boot_timeout = 600" in Vagrantfile. But when this occurs,
> restarting the GitHub Actions job works. So this is quite annoying but
> I believe we can live with it (this means that someone will need to
> click on "Re-run all jobs" on GitHub when this happens). So I merged
> my patch, and if it becomes too annoying, this workflow can be
> disabled in the future.

Ok, thank you for the update. I'll post my testsuite CI patch then.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

