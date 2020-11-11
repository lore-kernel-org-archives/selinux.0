Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAD9C55ABD
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 15:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5A52074B
	for <selinux@archiver.kernel.org>; Wed, 11 Nov 2020 15:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hpK54jNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgKKP4y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Nov 2020 10:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgKKP4x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Nov 2020 10:56:53 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBFEC0613D6
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 07:56:52 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id e18so2815753edy.6
        for <selinux@vger.kernel.org>; Wed, 11 Nov 2020 07:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fz51KnTIDgLSCdxAMNRU+5+a0jtwfxsxVOpSIhz7Mwg=;
        b=hpK54jNyK8Kf6FQCcwjl8Ia2N/1XmRDZjnMwNh0sf5ilwaRdCuJ6uxspf6X6ByiyvP
         vOEqOKJM3dIhHMpmeqE2H4pLDSfCOVGVhw12oFpwjJA3TDKTwZP68w9oigZrLxFr1X7K
         7Dka5wCsLgQVSlZGOkSPWoVf4cdbxB+TYC1MdaNYNq2kcvV8tu+lex7pWYEhv928jlCq
         Eg/TX90rkd4J20Px1pgQis9+6J1CsK4aAg/YkPNWVmDJK3Lo97W8G/hLx/9oZkDE9OeC
         71zhFYSTTMQrzSggChVACeCDMEjhaJIGggl6+cUsbn1QeRmvk+SskQNTiwoXnJHrF5Z/
         vrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fz51KnTIDgLSCdxAMNRU+5+a0jtwfxsxVOpSIhz7Mwg=;
        b=DoRONNhKj6SsiIKrE7s+wHNE4Ghcue8wvXZuQjFLeY3+MYzGONggCDMf3PMHpBs8c9
         V9CwWPJe8GHq0rsoDD/s2yj2ZG8qf5xvsqN9bVfArOETcocd0aWX+nbLh1BRAhkrs4db
         666Amtu5J04+ONceXInsnaRm5bDgTTUVQs6EJHGxskIXPy8bGaLqDlHVlmqnZXL5rhoO
         TMigfN2CkknAp2Viy1vTlSsWAVVLuLe9Sm3wp8AuJn3VHtlltWgIPCPE6jJMgHaGCkO6
         F6fsGukLBTjhvS6CaWQ2qugU75lUFlx/TxaYtINNKTo2PiFN3rLVRkKAJ3p3osiWoqcZ
         BYqA==
X-Gm-Message-State: AOAM533PVzCUBRqSO32vKy698nDoSidR4r1MTetj6oew9HAu2bL/iFWZ
        PVnoUjVGWbVjaGsTEqpmTDzknqVUWJqPRwdiXceG
X-Google-Smtp-Source: ABdhPJyoXvqPPAxXvXC3nEJRXcmP5X1/7kHCbKMNZDT1GBEWI3aC31s+aZguYWimyml0Hk+ccvBbKX0xVpFGusztuwo=
X-Received: by 2002:a05:6402:559:: with SMTP id i25mr80033edx.128.1605110210699;
 Wed, 11 Nov 2020 07:56:50 -0800 (PST)
MIME-Version: 1.0
References: <20201111095134.481658-1-omosnace@redhat.com> <20201111100735.GA213493@localhost.localdomain>
 <CAFqZXNteFTp2o9-MOSwJSS601MjmjQEL-S9x7g5exyvy+oLhUA@mail.gmail.com>
In-Reply-To: <CAFqZXNteFTp2o9-MOSwJSS601MjmjQEL-S9x7g5exyvy+oLhUA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 11 Nov 2020 10:56:39 -0500
Message-ID: <CAHC9VhQNSdQRF5LxHx0E-+p0p64AzBBUs3C-Z2EmD=NaZwSybw@mail.gmail.com>
Subject: Re: [PATCH userspace] selinux(8): explain that runtime disable is deprecated
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 11, 2020 at 5:19 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Nov 11, 2020 at 11:07 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > On Wed, Nov 11, 2020 at 10:51:34AM +0100, Ondrej Mosnacek wrote:
> > > Update the main SELinux manpage to explain that runtime disable (i.e.
> > > disabling SELinux using SELINUX=Disabled) is deprecated and recommend
> > > disabling SELinux only via the kernel boot parameter.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  libselinux/man/man8/selinux.8 | 26 ++++++++++++++++++++++----
> > >  1 file changed, 22 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
> > > index 31364271..721a65f4 100644
> > > --- a/libselinux/man/man8/selinux.8
> > > +++ b/libselinux/man/man8/selinux.8
> > > @@ -19,12 +19,12 @@ enabled or disabled, and if enabled, whether SELinux operates in
> > >  permissive mode or enforcing mode.  The
> > >  .B SELINUX
> > >  variable may be set to
> > > -any one of disabled, permissive, or enforcing to select one of these
> > > -options.  The disabled option completely disables the SELinux kernel
> > > +any one of Disabled, Permissive, or Enforcing to select one of these
> >
> > Is there a reson for these changes?
>
> Just for better readability. Although I should probably just mark them
> up, as in selinux_config(5)...
>
> > policycoreutils/man/man5/selinux_config.5 aka selinux_config(5) doesn't use
> > capitals:
> >
> >     SELINUX = enforcing | permissive | disabled
>
> Good point, it should be consistent. And also that page will need a
> similar update. v2 coming soon...

Thanks!

-- 
paul moore
www.paul-moore.com
