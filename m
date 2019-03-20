Return-Path: <SRS0=9nrh=RX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC6FC43381
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 20:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294D521841
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 20:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E7KmbmgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfCTUGj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:06:39 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:33397 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCTUGj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Mar 2019 16:06:39 -0400
Received: by mail-qt1-f172.google.com with SMTP id k14so4148137qtb.0
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2019 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IrIchpgziU4ph6HQdxTpvlay9bbG4HnIVEF0CiiSHn8=;
        b=E7KmbmgZizcVXe/yten7tvdH8R+nk5Mx3CJeyOdMRHxCQThI3b+zHNX6l7H76n0+KY
         SvfxOqt8XTCGqFRnfVbf5/8azL4syq5BcuxWYOl8LWsKl9PfaS64Ivc6YHdJbetsacFD
         jG7oMHSMIkLZl5sNNoM5roZhzFxt4mv8w4Q8pCKBctc+7XFw+bHssqMxfljcCnePWeyq
         2ICPW9kM+qi/NrJsYUfOCKVKWahfvg1FUtikTefCj6m8IlJQpbNbF4jRQHZLKFL0HafT
         wZf1wK1U50ns+t0OsXUh8RMX8x2WwHgoez0DtFYXZYrsRbeJBkivB0hcvtujgzfAuK6c
         7TIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IrIchpgziU4ph6HQdxTpvlay9bbG4HnIVEF0CiiSHn8=;
        b=jy8f14M6Fd+z2z5t56XXPLLTs+AtWujx/y2ImC/pmEcb/iPeQoCZ0eVmePW5yxrCic
         gz2neUGcC5BQIA424+cCP9oArzx0alcvDlubpgf/3ojt+Dq2dChzrzZh3ucnYk6Tgdd8
         g8Cwu2d4MJKtaOz7iToPmW0XLwI8y6idLFbZaO9NnZWt7/ynCTa12A9GsIYNymGNMxOY
         vsDBFWsZMIepyQn7Qp/JOM287/9ZbSy/qMIxByv18y2Eqo1R+mvcMdKRRh7dF1cEqHi3
         vIRx1b/0R+6p1djKjtzANZqAJvhKccWQsovrdr1Pwo/vCrr3Bnc59Ovsjuw4L5AHgjsw
         WWpg==
X-Gm-Message-State: APjAAAVnvrh3MTriC6G07CkoRAoyjZyDbori/2gzO7Ug2gekQSCdBS7V
        PUjASzIrYfzenCB0XIeC9L8ICTMiWdGRv9+AzQ2PhA==
X-Google-Smtp-Source: APXvYqyOts7ebTZe8WhgOabgugqMVu9+yd7f33ZXVsLST77MN2XnOzYTVI+3qMQJuo80VvFRomtJqk4cdAQb7MQj/lg=
X-Received: by 2002:a0c:c691:: with SMTP id d17mr8139347qvj.124.1553112398324;
 Wed, 20 Mar 2019 13:06:38 -0700 (PDT)
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
 <CAHRSSEwm8F1tKbsG6Tyjbwidg0Nwk-oFHt8hYox9gB0TARNgcg@mail.gmail.com> <CAHRSSEz7GTS3NyHDf5r9qKM6NrCcnxh=U3tEyY+6JqS9=RH1QQ@mail.gmail.com>
In-Reply-To: <CAHRSSEz7GTS3NyHDf5r9qKM6NrCcnxh=U3tEyY+6JqS9=RH1QQ@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 20 Mar 2019 13:06:27 -0700
Message-ID: <CAHRSSEwP-g9nzgVds3ND-wmUwvpYmyPBsHpCb-aSLVZfuW25cw@mail.gmail.com>
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

On Wed, Mar 20, 2019 at 12:50 PM Todd Kjos <tkjos@google.com> wrote:
>
> Paul,
>
> Looking at main() in test_binder.c...
>
> int main(int argc, char **argv)
> {
>
> [...]
>
>   // Line 493
>   struct binder_write_read bwr;
>   struct flat_binder_object obj;
>   struct {
>     uint32_t cmd;
>     struct binder_transaction_data txn;
>   } __attribute__((packed)) writebuf;
>   unsigned int readbuf[32];
>
> [...]
>   // Line 630
>   writebuf.txn.data.ptr.buffer = (uintptr_t)&obj;
>   writebuf.txn.data.ptr.offsets = (uintptr_t)&obj +   // [A]
>                                                  sizeof(struct
> flat_binder_object);
>
>   bwr.write_buffer = (uintptr_t)&writebuf;
>   bwr.write_size = sizeof(writebuf);
>
> It looks like bwr.txn.data.ptr.offsets points off the end of obj (see
> [A] above), which means the binder driver will read compiler-dependent
> stack data as the offset for the object. If it happens to be 0, then
> the test will work (read the object from offset 0). If it's not 0,
> then most likely offset > data_size (which is what found that BUG_ON
> case). With my patch applied, this will just cause an error to be
> returned (what you are seeing now).
>
> Same thing when you test with v5.0 -- if the offset happens to be 0,
> then the test will succeed. If not, then the test will fail because
> the transaction fails in an unexpected way.

Same issue at line 296 of test_binder.c when setting up the
transaction in request_manager_fd().

>
> -Todd
>
>
[...]
