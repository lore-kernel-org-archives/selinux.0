Return-Path: <SRS0=9nrh=RX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BFBC43381
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 22:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02457218B0
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 22:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEXmDxbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfCTW32 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:29:28 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:38350 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfCTW32 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Mar 2019 18:29:28 -0400
Received: by mail-qk1-f177.google.com with SMTP id g1so10974798qki.5
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2019 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXVJ0tZ+bqgauq6kl9q3URbd7rmreIre5sCp9kgpZ9w=;
        b=DEXmDxbVsIp1+mJWCIlGVqVmNeTh1I0jS/0SDlLrHlG9BwRjM/ujQgZ9CWsnfvt7Db
         PVpMdHYESBT5aUnJBrMi0Fb2F5TgdHTWAB+wD5hNY6JnS+thj8c7RwvaszCAUShnn+0t
         vBXw+e+iSQhoQ0iYwL3UzI9Wq5/8VGOoFgLTxiuPykAg0ewEhUqHB70ll2pwOzwf6Rml
         Su0oitB3m3MaBmWn11JLqF5r7wQaTYHSIEBZg6teKogLaF1A5okSJVqeg9LZ8aZJas13
         SE++z0QJRK/8T/sXYQkr2utVCLxS6fDseQWF0+qsorIw8YBgmktxN8RY4n0BeaxyY54S
         iClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXVJ0tZ+bqgauq6kl9q3URbd7rmreIre5sCp9kgpZ9w=;
        b=UJYlcD6+ZUyHuHdQxU7E3ihqHGX3BkBrBJVCwI+/Ah2oI7YWzmFeUwQxddM/RSZJgj
         OQ5YYy5SvvwvJUTbynO88SAJ6hmsQRVMUczLHzyzoq3KRfEFLkiF4ZdawueOTL53DWAa
         m8l+KfU2WXZv7q7n/OHxXPouMLlgNmtFF+Bg/rlsfGh6IJAdAFDmKAu5NuskoLqIkxxb
         Wxjt7pt+OBI5ekSLx3kVwiaOZKYdwJ+HMS4KG6EezOth6OYZc3POqCdy3/e5cju1cHna
         ErXxNDkZPji6AFpt2a8923ZIP56Ya5MblxqhLK5pax4RpN1NTAzYHuFfgyFXUsQUvYmt
         QeeA==
X-Gm-Message-State: APjAAAUPle7YuBXub7zwptMoe29cMOe3KpMsKf33gfmdg9bxemPUA4y5
        UO9JeuMZNJ710Yompajp/ilrTWw8Lc0ahunO7IOp0Q==
X-Google-Smtp-Source: APXvYqwydn1WmqgIiy2f1Ty5NPHodg1+Hq+lOkd026QcNAjwxHsMsHTJ4U3n8Mgj6r3AfJNALTyHT7EMJipaW+xfShk=
X-Received: by 2002:a37:5dc7:: with SMTP id r190mr99414qkb.170.1553120967171;
 Wed, 20 Mar 2019 15:29:27 -0700 (PDT)
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
 <CAHRSSEwm8F1tKbsG6Tyjbwidg0Nwk-oFHt8hYox9gB0TARNgcg@mail.gmail.com> <CAHC9VhToThRNL1rVLABgwfixXSeL-mss_nUZBNxZn0EuHLDRsQ@mail.gmail.com>
In-Reply-To: <CAHC9VhToThRNL1rVLABgwfixXSeL-mss_nUZBNxZn0EuHLDRsQ@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 20 Mar 2019 15:29:15 -0700
Message-ID: <CAHRSSEwEBA9JJCLGO+CnLrwgxMbe+2ZhUVzfGKyf8DxbcLtdWQ@mail.gmail.com>
Subject: Re: v5.1-rc1 binder_alloc_do_buffer_copy() BUG_ON triggered by selinux-testsuite
To:     Paul Moore <paul@paul-moore.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        selinux@vger.kernel.org,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 20, 2019 at 3:25 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Mar 20, 2019 at 11:54 AM Todd Kjos <tkjos@google.com> wrote:
> > So, then it sounds like the test is not running properly ...
>
> Yes, the test is almost surely broken to some extent, although the
> kernel hitting the BUG_ON() was clearly a bug too :)

Absolutely -- I'm glad the test had this bug that caused the kernel
bug to be found :).

> > Can I add a "Tested-by: Paul Moore <paul@paul-moore.com>" on my patch
> > submission to fix the BUG_ON (the exact patch you tested) ?
>
> Yep.  Thanks for your help on fixing that.

Thanks.

>
> --
> paul moore
> www.paul-moore.com
