Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE392C433DB
	for <selinux@archiver.kernel.org>; Sat,  2 Jan 2021 10:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9834E2151B
	for <selinux@archiver.kernel.org>; Sat,  2 Jan 2021 10:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbhABKg2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 Jan 2021 05:36:28 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:39904 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbhABKg1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 2 Jan 2021 05:36:27 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 947445654D4
        for <selinux@vger.kernel.org>; Sat,  2 Jan 2021 11:35:43 +0100 (CET)
Received: by mail-ot1-f43.google.com with SMTP id a109so21684040otc.1
        for <selinux@vger.kernel.org>; Sat, 02 Jan 2021 02:35:43 -0800 (PST)
X-Gm-Message-State: AOAM533X5hx2GgIDi7nCKMfNlYAHdY8WwIszhS3vCxyichTsrFsA2/M9
        VnKFtLn6Ymnjv/XwNi5gtprw8QyMkisDFcUWTcg=
X-Google-Smtp-Source: ABdhPJwEPrQ8ZLsPRqzfl0E0eebW/kQE0fKn4MLvM2D4pTW+kJTtn83cnwN5azYvHQ4Aj+SlQhv89lzWrJOoGYKm5Tc=
X-Received: by 2002:a05:6830:188:: with SMTP id q8mr47471794ota.96.1609583742471;
 Sat, 02 Jan 2021 02:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20201230200821.3454892-1-nicolas.iooss@m4x.org> <CAFftDdoTGNizbiX68drThF=M_QUyRdCD7zb3MGjuKtU-yi_+Vw@mail.gmail.com>
In-Reply-To: <CAFftDdoTGNizbiX68drThF=M_QUyRdCD7zb3MGjuKtU-yi_+Vw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 2 Jan 2021 11:35:31 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==i=8s=AfVERNfadwdNa-OMJbGdsmCXm=waf1c6w_XrRw@mail.gmail.com>
Message-ID: <CAJfZ7==i=8s=AfVERNfadwdNa-OMJbGdsmCXm=waf1c6w_XrRw@mail.gmail.com>
Subject: Re: [PATCH 1/1] GitHub Actions: run SELinux testsuite in Fedora
 virtual machine
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan  2 11:35:44 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 31, 2020 at 3:43 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Wed, Dec 30, 2020 at 2:12 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > Use the Vagrant configuration in scripts/ci in a workflow for GitHub
> > Actions.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> > Example of run: https://github.com/fishilico/selinux/runs/1627586446
> >
> >  .github/workflows/vm_testsuite.yml | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >  create mode 100644 .github/workflows/vm_testsuite.yml
> >
> > diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_testsuite.yml
> > new file mode 100644
> > index 000000000000..af2fad1e73f5
> > --- /dev/null
> > +++ b/.github/workflows/vm_testsuite.yml
> > @@ -0,0 +1,22 @@
> > +name: Run SELinux testsuite in a virtual machine
> > +
> > +on: [push, pull_request]
> > +
> > +jobs:
> > +  vm_testsuite:
> > +
> > +    # Use VirtualBox+vagrant on macOS, as described in https://github.com/actions/virtual-environments/issues/433
> > +    runs-on: macos-latest
>
> Good find, they support nested virtualization.
>
> > +
> > +    steps:
> > +    - uses: actions/checkout@v2
> > +
> > +    - name: Create Vagrant VM
> > +      run: |
> > +        cd scripts/ci
> > +        vagrant up
> > +
> > +    - name: Run SELinux testsuite in the VM
> > +      run: |
> > +        cd scripts/ci
> > +        vagrant ssh -- ./run-selinux-test.sh
> > --
> > 2.29.2
> >
>
> LGTM ack. Do you have any fork that has a build with this just to see
> it running?

Yes, I have been testing it on
https://github.com/fishilico/selinux/actions, with several successful
builds such as https://github.com/fishilico/selinux/runs/1627586446.

Thanks,
Nicolas

