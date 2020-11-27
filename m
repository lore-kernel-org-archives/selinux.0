Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB1CC2D0E4
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 14:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76BDE22240
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 14:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBFBseuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbgK0O46 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Nov 2020 09:56:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729913AbgK0O45 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Nov 2020 09:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606489016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l81RANy4wWm9mTudY1S+L705YoreEuKqx8x/IxJth2I=;
        b=eBFBseuKFRVJwLWjYBMT6KHgStug4lcQaE7Z0eSl8Bj0J3h7pTsU5iz/l+tft6eFlBUZgH
        7mA6APc6NhEAJnho0zP6rAr9avdkeTybmhc2FWHcu8z8o4l3szn8CPyniKXsKlPS1gJRxR
        Fzsr303TzYTAgltPxyZSQ6Fomrsb0dg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-cg_v-GWVPPCo8XIYKxLRXQ-1; Fri, 27 Nov 2020 09:56:53 -0500
X-MC-Unique: cg_v-GWVPPCo8XIYKxLRXQ-1
Received: by mail-lf1-f69.google.com with SMTP id i73so2005478lfi.16
        for <selinux@vger.kernel.org>; Fri, 27 Nov 2020 06:56:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l81RANy4wWm9mTudY1S+L705YoreEuKqx8x/IxJth2I=;
        b=UBD2ue+G+CkV8mUXmWCUsYSU0vRVVqoXJl2gbrHw2hz2oiF0nnb4TzDx84lrAqkOYe
         9H5Nt+7DRa3nhOjlld2tgq2Q+detI7tZ6IJ5wwprL9tOHSnybJI1Bn9wCEDpaRtm+jOO
         zZSDmxQ6k1uCGkrFTVztoy4ArzTWrG/yUizBK/hwnoyun+7PTSuGgN/lt6UWajZnmTjU
         UhwtIf/rQiU3Ne5J9oh2OMawobDT1jf6uiBmi5VTMipJ8vh1+X3myV+7i5zTGm6xul0W
         lU+0aikAeU0PL2SWN5TAyxKmM5OWkZj1XIiijAMdkxYKK9trDYwmTctKjv/9jH1CzaLf
         ERWw==
X-Gm-Message-State: AOAM530dpp22ruAQjN9uzbIfD0YB/xPNaZ1DLpMMFirTZ2rK2178xHSG
        XKatRyThVLCVkCpqSkRov8GEmvTnD5Qe3Ts1csqp/SeAoUfzfW7tPCacCBRZEGM+UCUHq8fgDFM
        cmIE6XCsQRs9zetQxvlEnfcIWTiz1QIXjMw==
X-Received: by 2002:a2e:808a:: with SMTP id i10mr3459805ljg.123.1606489011637;
        Fri, 27 Nov 2020 06:56:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1Yel1wKgjJASlhPDmJU3AYAaWIU3vT6/dujhBICn8rrIu9xzQD/BhvZBfNaLRFKijZ3ItWY+cD0XLrR1Lfts=
X-Received: by 2002:a2e:808a:: with SMTP id i10mr3459799ljg.123.1606489011450;
 Fri, 27 Nov 2020 06:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20201127141745.1579498-1-omosnace@redhat.com> <CAFqZXNvK5SBo2dw6_OctuLJqcEv8=Ynd8BajOLCdgTa-PNO1xg@mail.gmail.com>
 <CAFftDdp7_dcebjje6+pX1RNQiaBRbgFZSfjxk55DD8-MXJ=MjQ@mail.gmail.com>
In-Reply-To: <CAFftDdp7_dcebjje6+pX1RNQiaBRbgFZSfjxk55DD8-MXJ=MjQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 27 Nov 2020 15:56:40 +0100
Message-ID: <CAFqZXNv2jv6WGiW5T6Xb-31Gp90ZJPpVEJVzJwi-iC3ZfPzV9g@mail.gmail.com>
Subject: Re: [PATCH userspace] travis: run only selinux-testsuite
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 27, 2020 at 3:25 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Fri, Nov 27, 2020 at 8:22 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Fri, Nov 27, 2020 at 3:17 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > Now that the standard testing is run on GitHub Actions, we can remove it
> > > from .travis.yml, leaving only the selinux-testsuite sanity check, which
> > > can't be migrated. Hopefully this will save some precious minutesfrom
> > > the limited "plan" Travis gave us...
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  .travis.yml                    | 161 +--------------------------------
> > >  scripts/ci/travis-kvm-setup.sh |   1 +
> > >  2 files changed, 2 insertions(+), 160 deletions(-)
> >
>
> Oh awesome you got them migrated. I am in the middle of this for my
> other projects and was going to check
> back on SE Linux, glad you took care of it.
>
> > My intent is to apply this patch along with Nicholas's GH actions
> > patch. In case some issues pop up with GH actions, we can simply
> > revert it.
> >
> > Thoughts?
>
> I'm going to assume actions are working, I didn't check that patch.
> But it all LGTM.
> Ack from me.

Thanks! I staged both patches in a PR:
https://github.com/SELinuxProject/selinux/pull/272

It seems that GH actions didn't trigger on the PR. I've seen it in
another project as well, but that PR is not merged yet, so I don't
know if it just happens on the first PR or if there is some problem...

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

