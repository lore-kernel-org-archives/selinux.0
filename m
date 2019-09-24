Return-Path: <SRS0=oqeB=XT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D68C432C1
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 17:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09EA20872
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 17:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PpmqsZ+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501907AbfIXRYm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:24:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41011 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501902AbfIXRYl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Sep 2019 13:24:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id f5so2724522ljg.8
        for <selinux@vger.kernel.org>; Tue, 24 Sep 2019 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LHAcDzXof2T594HTBR0NQFEnLr1lKMHc0UGY6kJOfhs=;
        b=PpmqsZ+3iLSNxEh/M9FM+4inqRLK1QPkOiYqba62/8UQpS4dviouF+X3KXDzII2oec
         D9q/eOQ/4VdRlavOYw5Bn/1NzT3fOwY8fA48NuDSeMXN5DfcjYI40yKhIPD5dQl4h5o2
         srr4ggd8un4TWmQewa7YkFTFOIlB7BoMEbnMq+1p3aitkjR8Zke4rzeCltDHNTp7btFr
         zdMQ9zA4RtheRgZ1f3gulwPIpHe+n7eg3omcxkKMhQ5Fjy4VRIwH20g2HKeUGA1r8NMG
         RvMHups8uVkZy6xv7TTAe3YKeoQ5Kl4Cev+PgwhIlVKzrTKCP0Bh0hzEEACfeQmk9Wgu
         MAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHAcDzXof2T594HTBR0NQFEnLr1lKMHc0UGY6kJOfhs=;
        b=IWSWat9o2H8FQ1PudkGCnUQfxh2R3jGpTwAT00Mn+ANwWcC9jqJX9sInGjY7yBorG5
         wd9QSWsi0r5evWxjNkNnzqgKEATVS7ry5lD3m5JM3vuwkKgwNQMMMvdmTmI1SITaxGEc
         2To72YFnpVeHaWlELw3kYvFm7cOaiDMrx4e1+cktDVXR0imo+qziFtWhVrMolDJdX5DX
         BJ08+uePpq1Evy95LQdPEvUXdfXFfOZ+hQUMuUaPHU06+UjkCyQilsxL732oPy+nKcLN
         valxeE2CxqU0aXEaOIkFYblS9Y9OWNBT0VCb4gCy5ccQ8WzgWcMlGq1Wji2IQ6UV9NUC
         lJZg==
X-Gm-Message-State: APjAAAUwIPbYbWesvGa4cHtCxy5m07TrabFpfdskscKCNfXBB5VbBxWL
        fmo/XGlkNLSZsgknofNoXBCyXqgWNXLcRUr9nnHg
X-Google-Smtp-Source: APXvYqzmQ2p4fFGFX7kGFvgBwpauO04TBzvFiIXKZChgk2AljkxY4C9IwhFFU1zAM+UEx4ccC2pScmvip5I5B3R5m3g=
X-Received: by 2002:a2e:7c09:: with SMTP id x9mr2668189ljc.87.1569345879560;
 Tue, 24 Sep 2019 10:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190923095837.25752-1-omosnace@redhat.com> <b74cd6c5-0f63-80d8-99c0-967dc638279c@tycho.nsa.gov>
 <CAFqZXNtagT7TDgV4D88juWK7qVTEgkcjm6UL6zKsPm8gd7yyWg@mail.gmail.com> <e2bf659c-53a7-7c20-0c7b-3a102b05513a@tycho.nsa.gov>
In-Reply-To: <e2bf659c-53a7-7c20-0c7b-3a102b05513a@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Sep 2019 13:24:28 -0400
Message-ID: <CAHC9VhQM6D-TJpHGdEk8pTZyaSRQhL-z-bq1VEiB2KPe+LC-Lg@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: do not rebuild policy package if
 already built
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 24, 2019 at 9:58 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 9/24/19 6:51 AM, Ondrej Mosnacek wrote:
> > On Mon, Sep 23, 2019 at 4:11 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 9/23/19 5:58 AM, Ondrej Mosnacek wrote:
> >>> Right now, test_policy.pp is rebuilt on every make invocation. Tweak the
> >>> Makefile so that it is only build when it hasn't been built, it has been
> >>> cleaned, or the source files changed.
> >>
> >> It also needs to be rebuilt if anything under
> >> /usr/share/selinux/devel/include has changed e.g. upon an update of
> >> selinux-policy-devel.
> >
> > I am now testing a version that always executes the `$(MAKE) -C
> > test_policy -f $(POLDEV)/Makefile test_policy.pp` step, relying on the
> > system Makefile to rebuild the pp as needed (there already are proper
> > dependencies on the include files). However, the package manager on
> > Fedora preserves the timestamps of the installed files (from package
> > build time), which means that make doesn't always detect that the
> > files are newer than the already built policy package.
> >
> > So it looks like we don't have any other choice than to always rebuild
> > if we really need to auto-react to changing system files.
>
> I'd rather err on the side of rebuilding too often than using stale policy.

That would be my preference as well.  In fact, I actually recommend
doing a 'make clean' before building and running the tests simply to
make sure everything in the dependency list and toolchain is still
working properly with the bits in the test suite.

-- 
paul moore
www.paul-moore.com
