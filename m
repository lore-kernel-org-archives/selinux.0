Return-Path: <SRS0=9nrh=RX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49571C43381
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 23:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113602183E
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 23:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MbqbwkX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfCTXX2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:23:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33118 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfCTXX2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Mar 2019 19:23:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id f23so3815130ljc.0
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2019 16:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4eRiZ2QM/NhfuKeUk8aQo1rKwB2Jqrb6RP7G3ekarU=;
        b=MbqbwkX3WnvTIJe/7VgIqNJgtaaFHBjYdUGyTsO9mI72VbpjSQYazRMQW15CxtlMvf
         DhE212E8XYJbtTaMtOgqxVbiIwdytH0KkVAwWROVoMmdalJRkm5MKnF2Qo9M4mjqZ1Y1
         i5mmmAKj73LZOMAQyIag3ru+HlMfV0kA7P7sKSCV1ruKUg6fT4BfGo0+srdoZuoOiyuY
         mbA7PwlCfSKys5medIiHHsz8V5HV22DqQLwtFqedHZrBDe9zqAJqBKQ6y+cWG1RkEShl
         FE+EjUkO7KybqAb78wVeudgZ/wFxEdwaSbYb3atDa/24xAsbjpW4FqPZTjMqjyEndcb8
         jLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4eRiZ2QM/NhfuKeUk8aQo1rKwB2Jqrb6RP7G3ekarU=;
        b=HJ5J5hAXypXi86FwBMbB+vMy00dqqt/iezdziNk60FEMs3PohdbsqD/tbG5k6/r61g
         +ntOS6me+f+fzCLw78DwG6cTgSvpyyqj19FAzCjyiLbYkPHuMgaL9d+/ITn/7YgdI/YP
         JRxziH3mJ/eSjUbWaRBGdo4NLLHVCWoET9WD87suGxonrfyOxY6IXJUD4gY28evZGte+
         LtFFK5dYy9KejoUsxwkQm/3WikrJzicQAEJnru/F/c/NHw3MLShjuAbrZhWgr8cAWjX9
         RcbFGgP+Znfc9M3b1A4BWJkdmfURSd17nXYwi57oyAJngRbigKUcxGCmgN4ZRZhRBKtY
         Ly5Q==
X-Gm-Message-State: APjAAAUqPqatEbJB4+Avo3IS51bMwdfixp8bw8SB0wvRp4qVtFw7nwb+
        oVovotWqJ3INSiOQXGU++idZc0QK5TG+KEsJGrJs
X-Google-Smtp-Source: APXvYqxGYmKvLeoN2FxRkQpsivnKntSeDYhGYEd2RVM4QmmIuHZRoqwiFuK729jm/szHXC7fCcOLCPb3uywZjFaevnE=
X-Received: by 2002:a2e:413:: with SMTP id 19mr313580lje.196.1553124206561;
 Wed, 20 Mar 2019 16:23:26 -0700 (PDT)
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
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 19:23:15 -0400
Message-ID: <CAHC9VhT406VM76XPqcBPN9-R1h_WTDnbdvwQk=X_bHC_Gvq=qQ@mail.gmail.com>
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

On Wed, Mar 20, 2019 at 3:50 PM Todd Kjos <tkjos@google.com> wrote:
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

That might explain why the test used to work, but now fails - a
different compiler (I rebuild the test before each test run).

Keeping in mind I'm really quite ignorant when it comes to binder, how
would you suggest fixing the test?

-- 
paul moore
www.paul-moore.com
