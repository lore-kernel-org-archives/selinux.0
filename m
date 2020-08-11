Return-Path: <SRS0=GpsN=BV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CE7C433E0
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 15:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D281020782
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 15:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UiIA1LTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgHKPLB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgHKPLA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Aug 2020 11:11:00 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E7AC06174A
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 08:11:00 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i26so9352240edv.4
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfNA9mqRQlBdBk2TrEoX0EK6Rg6pvmbnftsvcBqKZwc=;
        b=UiIA1LTWBrAtLx5t9OZgP70FhaeU886O0ziaTOQyZ/xS8yc/989icHhwspxrIWQ2Ee
         a/Tz22JcxrsKOrKB6e81oo9I8wxQrJtxzje/jNaOo6TaKnv5fNxyu5b0EtZQ/SvxlBS+
         tJardncKDXCe4a2mpNtQfy9Z+/hP1nGPOoR0AJoOjs4YoF4hiFl9H3oIOGOdpOj+DFLR
         uRTwiZcMruz0ta0BNnC3unwMHTLgpHdZSbm3plcRa8gAoRl3IDTC0gcrA//20wScWr19
         kFA/V8z4RNBpUDt3rNHD1yjq+J/shqOyQlDzLpYgxQUzVAvS22WhMSvzF8MmS440HiAV
         1nhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfNA9mqRQlBdBk2TrEoX0EK6Rg6pvmbnftsvcBqKZwc=;
        b=LJ8+0+k2RPbi4M2i9/+xottGAS3l48gCnCZPpTRKWSfc2qinn6C/D18n5ajSqsqmvd
         6UawetKpF57Tca1DXdE/EE+d4BgGsEIRBu2/O33J2Tgcrj6Tn9BwEXxqhKCORs4aPLrl
         fF5xTi1GcBBWrbzlgIqvKyXUMn4ZPnNqeoIhTbT38EGFd6EqS9zb9bz9kdnUoK8f9/nS
         AqbojjZQNyLcCIvbIEIvztQ9DudqDE0bT92tmvqYZuVYwdL4vVA18PZfVqQbirrM0SdU
         xtr86Pm2IgSG6UA+ZejAVH6f5+BxztvPDZ3qakacFmrEVCi7JNZwOGfCSBCS1hGwD1Nt
         g4Zw==
X-Gm-Message-State: AOAM533zur6STxo6WsysWhsEmxpcpExVzTC0oOmPEWyLSSRdvAwP8MPb
        4xGUdh7uhMM//ra3/oEqN/ZEBfm3gvCLdrYeOjZL
X-Google-Smtp-Source: ABdhPJxgFHdCTvMu25T8nEOM7TdQSDuibeEnpaK/F5/f27i17Cjik7k18AdlbaM/75pNDWtlDIBfXJEyv2JmGk1hICQ=
X-Received: by 2002:a05:6402:403:: with SMTP id q3mr25549944edv.12.1597158658893;
 Tue, 11 Aug 2020 08:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200811084555.105374-1-omosnace@redhat.com> <20200811084555.105374-2-omosnace@redhat.com>
 <CAFqZXNsZU+uwnF2zu+cQSV5jzvDsx_u_FFcWWOx6YW0we583MA@mail.gmail.com>
In-Reply-To: <CAFqZXNsZU+uwnF2zu+cQSV5jzvDsx_u_FFcWWOx6YW0we583MA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Aug 2020 11:10:47 -0400
Message-ID: <CAHC9VhTGHgZu4pcAVVOUGX4yegyD8uNg85UrjG8Jtzc4=AsDVQ@mail.gmail.com>
Subject: Re: [PATCH testsuite v2 1/2] README: add perl-lib as a dependency
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 11, 2020 at 5:05 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Aug 11, 2020 at 10:45 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > The `lib` perl module has been split out of the `perl-interpreter`
> > package in Fedora 33 into `perl-lib`. It is needed for the filesystem
> > tests. Add it to the dependencies.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  README.md | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/README.md b/README.md
> > index ff0a0dc..bfd5b17 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -45,6 +45,7 @@ similar dependencies):
> >  * perl-Test  _(test harness used by the testsuite)_
> >  * perl-Test-Harness _(test harness used by the testsuite)_
> >  * perl-Test-Simple _(for `Test::More`)_
> > +* perl-lib _(for `lib`; split out from `perl-interpreter` since Fedora 33)_
> >  * selinux-policy-devel _(to build the test policy)_
> >  * gcc _(to build the test programs)_
> >  * libselinux-devel _(to build some of the test programs)_
> > @@ -65,6 +66,7 @@ following command:
> >         # dnf install perl-Test \
> >                 perl-Test-Harness \
> >                 perl-Test-Simple \
> > +               perl-lib \
>
> Note that this package doesn't exist on the earlier versions, so the
> command will now work verbatim only on F33+... I'm not sure if we want
> to add --skip-broken (might silently skip necessary packages in case
> of dependency problems in the repos) or just leave it be.

I agree that '--skip-broken' is probably not the best choice for the
reasons you already mentioned.  I might suggest that if the package is
not present in all of the supported versions of Fedora we should add a
note to the README.md explaining that.  Once the older versions become
unsupported the note can be removed.

-- 
paul moore
www.paul-moore.com
