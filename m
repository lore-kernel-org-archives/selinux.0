Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEDFC07E95
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 19:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FFC561178
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 19:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGMUBC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jul 2021 16:01:02 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:38031 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhGMUBC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jul 2021 16:01:02 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 789DA5646D0
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 21:58:10 +0200 (CEST)
Received: by mail-il1-f169.google.com with SMTP id a7so5133274iln.6
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 12:58:10 -0700 (PDT)
X-Gm-Message-State: AOAM5303D9hxqWr7eS5LhTbJBBtB9/5+1MOgq964lSJsRqPDrbddqdFK
        ZCFE26Uo8yMkSz2zKWsB2VrGOga97G2dkH0f8j0=
X-Google-Smtp-Source: ABdhPJzcyg+vsVMkQBmU5UqYTljZVmwLjyqZqz+xDzUMghxQr7qGPCw0weATTHouslvmEfISzZ6+AFi7Jski5NQV9YE=
X-Received: by 2002:a92:c10d:: with SMTP id p13mr3947446ile.83.1626206289494;
 Tue, 13 Jul 2021 12:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210710120302.74862-1-evvers@ya.ru> <CAJfZ7=m=8t9MQ1gSHE9_9D8aki-mUrWtnYTBVreeuGDwaRK_hA@mail.gmail.com>
In-Reply-To: <CAJfZ7=m=8t9MQ1gSHE9_9D8aki-mUrWtnYTBVreeuGDwaRK_hA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 13 Jul 2021 21:57:57 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mxOsGMvHotZYSwYAW6pQLkwZ2-CyeuAEUzBaAAUztbPQ@mail.gmail.com>
Message-ID: <CAJfZ7=mxOsGMvHotZYSwYAW6pQLkwZ2-CyeuAEUzBaAAUztbPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ci: turn on CIFuzz
To:     Evgeny Vereshchagin <evvers@ya.ru>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jul 13 21:58:10 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 12, 2021 at 9:31 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Sat, Jul 10, 2021 at 2:11 PM Evgeny Vereshchagin <evvers@ya.ru> wrote:
> >
> > Now that almost all the bugs reported by OSS-Fuzz have been
> > fixed libsepol/cil should be stable enough to get CIFuzz working
> > more or less reliably. It should help to catch regressions/new bugs
> > faster.
> >
> > https://google.github.io/oss-fuzz/getting-started/continuous-integration/
> >
> > The patch was tested on GitHub in https://github.com/SELinuxProject/selinux/pull/285
> > The CIFuzz job can be found at https://github.com/SELinuxProject/selinux/actions/runs/1017865690
> >
> > Signed-off-by: Evgeny Vereshchagin <evvers@ya.ru>
>
> For both patches:
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> If nobody else has comments, I will apply them tomorrow.
> Thanks!
> Nicolas

Merged.
Thanks!
Nicolas

> > ---
> >  .github/workflows/cifuzz.yml | 39 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644 .github/workflows/cifuzz.yml
> >
> > diff --git a/.github/workflows/cifuzz.yml b/.github/workflows/cifuzz.yml
> > new file mode 100644
> > index 00000000..5c2233a2
> > --- /dev/null
> > +++ b/.github/workflows/cifuzz.yml
> > @@ -0,0 +1,39 @@
> > +---
> > +name: CIFuzz
> > +on:
> > +  push:
> > +    branches:
> > +      - master
> > +  pull_request:
> > +    branches:
> > +      - master
> > +jobs:
> > +  Fuzzing:
> > +    runs-on: ubuntu-latest
> > +    if: github.repository == 'SELinuxProject/selinux'
> > +    strategy:
> > +      fail-fast: false
> > +      matrix:
> > +        sanitizer: [address, undefined, memory]
> > +    steps:
> > +      - name: Build Fuzzers (${{ matrix.sanitizer }})
> > +        id: build
> > +        uses: google/oss-fuzz/infra/cifuzz/actions/build_fuzzers@master
> > +        with:
> > +          oss-fuzz-project-name: 'selinux'
> > +          dry-run: false
> > +          allowed-broken-targets-percentage: 0
> > +          sanitizer: ${{ matrix.sanitizer }}
> > +      - name: Run Fuzzers (${{ matrix.sanitizer }})
> > +        uses: google/oss-fuzz/infra/cifuzz/actions/run_fuzzers@master
> > +        with:
> > +          oss-fuzz-project-name: 'selinux'
> > +          fuzz-seconds: 180
> > +          dry-run: false
> > +          sanitizer: ${{ matrix.sanitizer }}
> > +      - name: Upload Crash
> > +        uses: actions/upload-artifact@v1
> > +        if: failure() && steps.build.outcome == 'success'
> > +        with:
> > +          name: ${{ matrix.sanitizer }}-artifacts
> > +          path: ./out/artifacts
> > --
> > 2.31.1
> >

