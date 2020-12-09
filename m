Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05291C19425
	for <selinux@archiver.kernel.org>; Wed,  9 Dec 2020 21:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A7D23D20
	for <selinux@archiver.kernel.org>; Wed,  9 Dec 2020 21:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbgLIVoh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Dec 2020 16:44:37 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:60817 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388286AbgLIVoe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Dec 2020 16:44:34 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5491F561215
        for <selinux@vger.kernel.org>; Wed,  9 Dec 2020 22:43:49 +0100 (CET)
Received: by mail-oi1-f170.google.com with SMTP id l200so3359770oig.9
        for <selinux@vger.kernel.org>; Wed, 09 Dec 2020 13:43:49 -0800 (PST)
X-Gm-Message-State: AOAM5303qXTpSdyWrwx5XlGb4w9LolWkgkpGfa29XUeCgJyHER8hg9+p
        fIeG8pZ0ldVyQiu9lZeotQ87qUk9ozeVjbZZW5I=
X-Google-Smtp-Source: ABdhPJwpjxV+w54ByZji9NirusmKost/Z+0vZSMBvRc/Xqqla12xOi7JVdtrAe1Yis43aP5Wcd4cnJ/iNAUyRmjQr/c=
X-Received: by 2002:aca:ec09:: with SMTP id k9mr3287954oih.153.1607550228223;
 Wed, 09 Dec 2020 13:43:48 -0800 (PST)
MIME-Version: 1.0
References: <20201206225625.3077530-1-nicolas.iooss@m4x.org> <CAFftDdpY9BCrr2DQEOS7yQQJ8SuN158ZkYCz_jDCLpw5=1nNzg@mail.gmail.com>
In-Reply-To: <CAFftDdpY9BCrr2DQEOS7yQQJ8SuN158ZkYCz_jDCLpw5=1nNzg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 9 Dec 2020 22:43:37 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mCdgjV-a9iJePtYzPhTTy3m6T=aEkfoRSeiCfqva=MrA@mail.gmail.com>
Message-ID: <CAJfZ7=mCdgjV-a9iJePtYzPhTTy3m6T=aEkfoRSeiCfqva=MrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] GitHub Actions: upgrade to Python 3.9
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Dec  9 22:43:49 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 7, 2020 at 5:43 PM William Roberts <bill.c.roberts@gmail.com> wrote:
>
> On Sun, Dec 6, 2020 at 4:58 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  .github/workflows/run_tests.yml | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
> > index 6f280de8ff4d..d889b5d55604 100644
> > --- a/.github/workflows/run_tests.yml
> > +++ b/.github/workflows/run_tests.yml
> > @@ -10,25 +10,26 @@ jobs:
> >        matrix:
> >          compiler: [gcc, clang]
> >          python-ruby-version:
> > -          - {python: 3.8, ruby: 2.7}
> > -          - {python: 3.8, ruby: 2.7, other: test-flags-override}
> > -          - {python: 3.8, ruby: 2.7, other: test-debug}
> > -          - {python: 3.8, ruby: 2.7, other: linker-bfd}
> > -          - {python: 3.8, ruby: 2.7, other: linker-gold}
> > +          - {python: 3.9, ruby: 2.7}
> > +          - {python: 3.9, ruby: 2.7, other: test-flags-override}
> > +          - {python: 3.9, ruby: 2.7, other: test-debug}
> > +          - {python: 3.9, ruby: 2.7, other: linker-bfd}
> > +          - {python: 3.9, ruby: 2.7, other: linker-gold}
> >            # Test several Python versions with the latest Ruby version
> > +          - {python: 3.8, ruby: 2.7}
> >            - {python: 3.7, ruby: 2.7}
> >            - {python: 3.6, ruby: 2.7}
> >            - {python: 3.5, ruby: 2.7}
> >            - {python: pypy3, ruby: 2.7}
> >            # Test several Ruby versions with the latest Python version
> > -          - {python: 3.8, ruby: 2.6}
> > -          - {python: 3.8, ruby: 2.5}
> > -          - {python: 3.8, ruby: 2.4}
> > +          - {python: 3.9, ruby: 2.6}
> > +          - {python: 3.9, ruby: 2.5}
> > +          - {python: 3.9, ruby: 2.4}
> >          exclude:
> >            - compiler: clang
> > -            python-ruby-version: {python: 3.8, ruby: 2.7, other: linker-bfd}
> > +            python-ruby-version: {python: 3.9, ruby: 2.7, other: linker-bfd}
> >            - compiler: clang
> > -            python-ruby-version: {python: 3.8, ruby: 2.7, other: linker-gold}
> > +            python-ruby-version: {python: 3.9, ruby: 2.7, other: linker-gold}
> >
> >      steps:
> >      - uses: actions/checkout@v2
> > --
> > 2.29.2
> >
>
> ack

Thanks, I applied these two patches.

Nicolas

