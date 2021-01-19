Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB88BC433E0
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 22:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24EE230FE
	for <selinux@archiver.kernel.org>; Tue, 19 Jan 2021 22:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbhASWlr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:41:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732998AbhASOeM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jan 2021 09:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611066766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1swVY4AKm7Oah8Z7SM53rdaxnPuMF09MrcGP9gztBPI=;
        b=H2wizMU6EFPYJqr60g3l8zi1L26gZX6aEu5EcPWAUcjv3AAadwjMOl2KcdGHI6GVi7f1Yx
        oqig5VzxMzUMG0LCDXbpiTzPjY9hnRIHczqAqLjh6g4d1zWgx3JSmR9RalIULSPpe9Ob+G
        ijOShXIYxmcBMkCFKih/wS247YY9STk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-XTyipp_iMuuCNLkZj6KyoQ-1; Tue, 19 Jan 2021 09:32:43 -0500
X-MC-Unique: XTyipp_iMuuCNLkZj6KyoQ-1
Received: by mail-lj1-f200.google.com with SMTP id c8so5122624ljj.3
        for <selinux@vger.kernel.org>; Tue, 19 Jan 2021 06:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1swVY4AKm7Oah8Z7SM53rdaxnPuMF09MrcGP9gztBPI=;
        b=pgj4YFYKdkODerU4r6ZfN4vpvCe6UPDAVokqjdxqtbfnu9wlhwhzayssRigYXWBFnM
         lvOHvRfqG2lgMCSzD3Yv9ChV3XkSVDoORPsJQ0Uv2rZS+fU+Qv2jLYT2Qr+pzNiAxZVy
         5OEyqTsTue/WDIp6ll02DCu+6Lewr/W/EJ7uRr3JNrqhv29tbXqUcbRvLV+/SBXdh9IL
         BGMR6uHh3v16oULqNlNfQn8WQgGmOS0iYWZfTEMk5cejL9NsvTEHehr0+TC4a6XEyI9+
         ps9Xar2wCoix8Fe2MHzJcWOEHKsgBsURARvOUmMNU2BXGPFlDPv5GmFJHV/D10a9g6fh
         rk3w==
X-Gm-Message-State: AOAM533j/HoqGe8UK2Bv8lFggsT7FixLZH3EA7kvQ+Rfgmsk4GjAVOnJ
        0RydxhfDe2cYZPq5atZaMiRpn7WBoWp5AqToJsciEOpLrEhnh/ekNrfo4A+qwL9L8h8Y3yDwnk1
        fcw6Y5rjOByYTC5MvHtVF+8UF+ak3wfr4gA==
X-Received: by 2002:a2e:7212:: with SMTP id n18mr2026899ljc.399.1611066761362;
        Tue, 19 Jan 2021 06:32:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyV/15FaJ5vJXvWCupXqEgGI9AZoamAZ+Y4rTq7xhrss8bp981+iEDWHTvHCnZugglkxlK94IIk7yr9Ru9m0ws=
X-Received: by 2002:a2e:7212:: with SMTP id n18mr2026893ljc.399.1611066761194;
 Tue, 19 Jan 2021 06:32:41 -0800 (PST)
MIME-Version: 1.0
References: <20201230200821.3454892-1-nicolas.iooss@m4x.org>
 <CAFftDdoTGNizbiX68drThF=M_QUyRdCD7zb3MGjuKtU-yi_+Vw@mail.gmail.com>
 <CAJfZ7==i=8s=AfVERNfadwdNa-OMJbGdsmCXm=waf1c6w_XrRw@mail.gmail.com> <CAJfZ7=kg7Ko8R7NScc+0T3S7dm__7pTE9st0d2gFpGUd7+KY9A@mail.gmail.com>
In-Reply-To: <CAJfZ7=kg7Ko8R7NScc+0T3S7dm__7pTE9st0d2gFpGUd7+KY9A@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 19 Jan 2021 15:32:29 +0100
Message-ID: <CAFqZXNuRMPupvO4cc3cmLz9OmDkxqz_=2a-iS_=jUR4h=pMDJQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] GitHub Actions: run SELinux testsuite in Fedora
 virtual machine
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 6, 2021 at 9:19 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Sat, Jan 2, 2021 at 11:35 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > On Thu, Dec 31, 2020 at 3:43 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > >
> > > On Wed, Dec 30, 2020 at 2:12 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > > >
> > > > Use the Vagrant configuration in scripts/ci in a workflow for GitHub
> > > > Actions.
> > > >
> > > > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > > > ---
> > > > Example of run: https://github.com/fishilico/selinux/runs/1627586446
> > > >
> > > >  .github/workflows/vm_testsuite.yml | 22 ++++++++++++++++++++++
> > > >  1 file changed, 22 insertions(+)
> > > >  create mode 100644 .github/workflows/vm_testsuite.yml
> > > >
> > > > diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_testsuite.yml
> > > > new file mode 100644
> > > > index 000000000000..af2fad1e73f5
> > > > --- /dev/null
> > > > +++ b/.github/workflows/vm_testsuite.yml
> > > > @@ -0,0 +1,22 @@
> > > > +name: Run SELinux testsuite in a virtual machine
> > > > +
> > > > +on: [push, pull_request]
> > > > +
> > > > +jobs:
> > > > +  vm_testsuite:
> > > > +
> > > > +    # Use VirtualBox+vagrant on macOS, as described in https://github.com/actions/virtual-environments/issues/433
> > > > +    runs-on: macos-latest
> > >
> > > Good find, they support nested virtualization.
> > >
> > > > +
> > > > +    steps:
> > > > +    - uses: actions/checkout@v2
> > > > +
> > > > +    - name: Create Vagrant VM
> > > > +      run: |
> > > > +        cd scripts/ci
> > > > +        vagrant up
> > > > +
> > > > +    - name: Run SELinux testsuite in the VM
> > > > +      run: |
> > > > +        cd scripts/ci
> > > > +        vagrant ssh -- ./run-selinux-test.sh
> > > > --
> > > > 2.29.2
> > > >
> > >
> > > LGTM ack. Do you have any fork that has a build with this just to see
> > > it running?
> >
> > Yes, I have been testing it on
> > https://github.com/fishilico/selinux/actions, with several successful
> > builds such as https://github.com/fishilico/selinux/runs/1627586446.
> >
> > Thanks,
> > Nicolas
>
> For information, I have been experiencing some failures due to timeout
> issues while Github Actions creates the Vagrant environment, for
> example in https://github.com/fishilico/selinux/runs/1652713066. I am
> currently trying to run test jobs with "config.vm.boot_timeout = 600"
> (the default value is 300 seconds) in scripts/ci/Vagrantfile and would
> like to wait a little bit before merging this patch, to see whether
> this fixes my issue. I do not want to introduce instability in our CI
> pipeline.

Hi Nicholas, any update here? I have drafted a similar patch for
selinux-testsuite's own CI, but have been waiting on your findings
regarding the timeouts to avoid needless followups.

Thanks a lot for finding a way to make this work with GH Actions!

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

