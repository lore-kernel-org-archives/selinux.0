Return-Path: <SRS0=9nrh=RX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41384C43381
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 22:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045CB2184E
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 22:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hbMZiXce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfCTWZ3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:25:29 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:41449 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfCTWZ3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Mar 2019 18:25:29 -0400
Received: by mail-lj1-f177.google.com with SMTP id k8so3677281lja.8
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2019 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3D/gxCylL0D/pMWub4a16BHPTDgam0bl7ss2Yn5bu8=;
        b=hbMZiXce0QWUM12YBQ+gyog3+KQbNPWCGedzjIdZ3zkAVBzC15sBQzKKHYXsqn5HyD
         vaiBCipMgv7SVWUp4PWiP2zpdJ2emNpflE7JMuMQTuW3Y+spepmVhU+eLD5paMDkA2c5
         kpbRcFxx04vEYd9iYOBEbH0189JNXhtX5MBY7hw0qoW6znDdbTMqfJwfIHGp8Cx2UTyA
         9x8MoXJvRi54WHCVHLw68fQuY0r++J7VoZ3RsWu8OvDMbDfTISxi5ZKLSfhehgy39mOz
         vZ2ztwWwRM53uYetos5xpOEvDv0j7DPYfCgWRGRutbQeoktkj4lClfmPrWei5keQPsOp
         kwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3D/gxCylL0D/pMWub4a16BHPTDgam0bl7ss2Yn5bu8=;
        b=Sw5CANShCQ2VlJ1wQbUnYPXuBnY2hCzqO8InvlmUvvJbtNMDQBrLWxDs6I9IUQwDhD
         VsPHLHfxKhuB3/FkmWr93od5EcC1I+XlHH7uQO8JB/4XS/bdkCbMNZSihb6GQTmkZm4W
         ylWPD5+h+iIOhGwY3JNN5CoFRuDGP7e+PHUJEd+DbjuHjjjr77QA4lo5Ycl9CWNbYinA
         Qmlx/6NkP5yyXXTuK1U1emzpKfsAVdUPiHpELaMxHjy38J6uKuIYhswiNK4ihcKCNRNY
         Y0aKuWg1wZVWrJGtADrz65brLXiteugzSTTLniezHg6Et3iNAq6cXO/V1bGg26FQVscL
         O9cA==
X-Gm-Message-State: APjAAAVym5ssXqEjP4l4bdMhcMzb5Z68fOHyqgV0ULpXAibMosITP5Hq
        Ao4qr9JnRGRdg47dSOHL661quqN88SYaBs2eszLL7xA=
X-Google-Smtp-Source: APXvYqy3xB5BW6NK9bJYhBX8r9qeW8A4tjZ45BrTRsIAcMgS6s50pce3K/pbbEQHhtUcNbeJf1RgzrXO7/ocGIjcLcA=
X-Received: by 2002:a2e:42cf:: with SMTP id h76mr225748ljf.95.1553120727212;
 Wed, 20 Mar 2019 15:25:27 -0700 (PDT)
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
 <CAHC9VhTDNspsA7ht=hkTbQZVmGKJWLoDEF-46kxFKvdMwA4hKw@mail.gmail.com> <CAHRSSEwm8F1tKbsG6Tyjbwidg0Nwk-oFHt8hYox9gB0TARNgcg@mail.gmail.com>
In-Reply-To: <CAHRSSEwm8F1tKbsG6Tyjbwidg0Nwk-oFHt8hYox9gB0TARNgcg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 18:25:15 -0400
Message-ID: <CAHC9VhToThRNL1rVLABgwfixXSeL-mss_nUZBNxZn0EuHLDRsQ@mail.gmail.com>
Subject: Re: v5.1-rc1 binder_alloc_do_buffer_copy() BUG_ON triggered by selinux-testsuite
To:     Todd Kjos <tkjos@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        selinux@vger.kernel.org,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 20, 2019 at 11:54 AM Todd Kjos <tkjos@google.com> wrote:
> So, then it sounds like the test is not running properly ...

Yes, the test is almost surely broken to some extent, although the
kernel hitting the BUG_ON() was clearly a bug too :)

> Can I add a "Tested-by: Paul Moore <paul@paul-moore.com>" on my patch
> submission to fix the BUG_ON (the exact patch you tested) ?

Yep.  Thanks for your help on fixing that.

-- 
paul moore
www.paul-moore.com
