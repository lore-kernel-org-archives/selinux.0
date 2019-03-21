Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF460C10F00
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 20:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B431A218D3
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 20:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vGu32U4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfCUUYw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:24:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43606 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbfCUUYv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Mar 2019 16:24:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id f18so119327lja.10
        for <selinux@vger.kernel.org>; Thu, 21 Mar 2019 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TNzM3XWUz1naTP1okPm3zLKSwjAvV+ifsml+0S7xDQ0=;
        b=vGu32U4+vrTRVKxy7SluS68N8lMfkS41qsx3JA/LG91ffOyN7yEh25bcBbk7srLOhk
         IzM2A09SOIrjUS2JGW6Z/GHqwdlIpTSvIg5KrlEq7IcuCqlhL576movVLE9VSlsZYpXH
         +4DyqTSx/5e/+VsOGWZRchXH2jgsf/nYcrt+cdilF73kvI0YQpR6tNRTfWrnXlmZFH66
         9twaMfNUtUMzD864K6qG7Ci7TOFnPZZHa/f+MICqQlz9Aw2orrPn+EGd426bjDjYi6I5
         XQVI1iH8P471yVg7sax3Q515DvEGZcOXYjXQk2m+nCJIneYpq1eFfPAhYaLYl/ThTPnO
         oGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TNzM3XWUz1naTP1okPm3zLKSwjAvV+ifsml+0S7xDQ0=;
        b=PUbEuW9dNFHhHy4Gx7d2dGI299ZfngKDmkA57sr9VN96sTAf0ciZ51LneK3BbJ7r0J
         jQOEfbnL56xm769ofZTSdrYUiW9KIn5ERMplhqesoFR605IR5ky5n1/u7Qv2P8wxMA/s
         qbMsCGXqcA9yzTPHXyp+Kn5LdVMEh110kqM2ANXtpWt/8+EpNfCK5oacryzBYHOMu5pT
         /TAuyD5n8gXRoTeHdVgyirdXiBeLf1M4ceiwOGBpoYNTR1pqi6p601gd85mOEqVzOKxA
         SURQc8tDKKjKT6UoH/3ZbTK3TYNx/OKPq/oSPoz6znRehIfti/xHYQ41j7veretgyK6M
         eLxw==
X-Gm-Message-State: APjAAAXSRJdN4vR8s0PNdvzOtgGvflf494zBR6rdOpHQU0yWay3Qofzo
        LqZ1wbr/7H98q4G72XJ5IcFfsHS6LbzGmmxaKbLT
X-Google-Smtp-Source: APXvYqwIMCiRIKkKO+onv37MWUQtSadv4qnfez77gdclR4ZvWGSBdWeXHrOMI4jDa8ychcvkRoH5TLyQ+cAWqWtvIAo=
X-Received: by 2002:a2e:904b:: with SMTP id n11mr3108375ljg.57.1553199888827;
 Thu, 21 Mar 2019 13:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhS1vRJuxxdzVsvkBVVVzt-3g9Q3qHSeeVPB9=JH+nNXbg@mail.gmail.com>
 <CAHRSSEwoR2-=pTRw1crXTXt-uOHe52UPof3hLcbZoVPDV5N4yw@mail.gmail.com>
 <CAHC9VhSwoCEDd8BgQ6_D8TRuVXJFNTavkAjyjFEAneVxBAwJ2Q@mail.gmail.com>
 <CAHRSSEzWFQi4PO3qBLziAVcsqe3O_u4LK9hJHa0Pyq3UZLW=BQ@mail.gmail.com>
 <CAHC9VhRcrNBRxkLxd5-biRJRqhby5hEOWHkv8hrsU87QOjpXGA@mail.gmail.com>
 <CAHC9VhTzj7gNj6jJ13pquP5im+kqG--qfYn2O0=xB=n5sB7s3w@mail.gmail.com>
 <CAHRSSEzt_d=8r34PJuyu5u6DWm461XXGhEVYignfktvj8pWSgg@mail.gmail.com>
 <CAHC9VhT_OWOU97C2NeDq8TWQzsu74V7maLWSXPhBFUKwrTvtCA@mail.gmail.com>
 <CAHRSSEwM+XXxzxabmiPBEt=t80Jes16yjJhHhsOtGy4meYu2mw@mail.gmail.com>
 <CAHRSSEyKaV5a6C5fBV8NDm02Cxu2DfVsA7YbbEE8CDkn68KtzA@mail.gmail.com>
 <CAHC9VhTDNspsA7ht=hkTbQZVmGKJWLoDEF-46kxFKvdMwA4hKw@mail.gmail.com>
 <CAHRSSEwm8F1tKbsG6Tyjbwidg0Nwk-oFHt8hYox9gB0TARNgcg@mail.gmail.com>
 <CAHRSSEz7GTS3NyHDf5r9qKM6NrCcnxh=U3tEyY+6JqS9=RH1QQ@mail.gmail.com>
 <CAHC9VhT406VM76XPqcBPN9-R1h_WTDnbdvwQk=X_bHC_Gvq=qQ@mail.gmail.com>
 <CAHRSSExzUeqBsu-wpGe_Y199mXOKm_oZpdmDby5s3hq528r4dA@mail.gmail.com>
 <CAFqZXNv6N9YWOr13=+PfjUWa1QJ=GBJUbkBtxbqif1VgOUpNKA@mail.gmail.com> <CAHRSSEzktyn5uWdGobUKdkWLn8cwyQCbSo7C2vvn92EQvKciqw@mail.gmail.com>
In-Reply-To: <CAHRSSEzktyn5uWdGobUKdkWLn8cwyQCbSo7C2vvn92EQvKciqw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 21 Mar 2019 16:24:37 -0400
Message-ID: <CAHC9VhSeKg-1btsr7K3faAfXUS8hZP2BYRhTa7nRsHvyqkuRFQ@mail.gmail.com>
Subject: Re: v5.1-rc1 binder_alloc_do_buffer_copy() BUG_ON triggered by selinux-testsuite
To:     Todd Kjos <tkjos@google.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        selinux@vger.kernel.org,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 21, 2019 at 11:48 AM Todd Kjos <tkjos@google.com> wrote:
> On Thu, Mar 21, 2019 at 2:50 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Thu, Mar 21, 2019 at 12:26 AM Todd Kjos <tkjos@google.com> wrote:
> > > I can send you a patch tomorrow (I won't be able to test it though).
> >
> > So, I was a bit quicker than you and I think I managed to fix the test myself :)
> >
> > See:
> > https://github.com/SELinuxProject/selinux-testsuite/pull/50/commits/b559c3f54eae6130cb9e79c295b0f94db26e09e4
>
> Looks good. Thanks!

I'm getting clean runs on my test system now too - thanks everyone!

-- 
paul moore
www.paul-moore.com
