Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BDAC433E3
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 12:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C2920738
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 12:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Zq9s81ZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHRMvC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHRMux (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Aug 2020 08:50:53 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B70C061389
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 05:50:53 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m20so15149812eds.2
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ejFMs1ymx6wprUI+r6xLITbuYkgKsiTBbmg42Z9Nv8=;
        b=Zq9s81ZCdbzr6BKs/O18fQaH9XMa4d0NFuykC8s/x+stvstHC0g52RsYpzFFf/TGhz
         NyNYlU/ARKRetgzTl2CqGjmIJx97y3eHjejFrafmJb1CJ64jmf97mtzvhQN34H0SOnZR
         kVNZn8Fy6xEvxbvOLkma2S++qtAqgfapv+pl70mtkv+8PxYmmZlKixctFZRCd/pTjgtJ
         lSBKALyZlvgnf0vjY58VBQu0IBirqbqfVcW7WXBhcWY2pMGkALpddljX4yYYp04Kqigp
         L6sD8hyNzAK1n4JHvgv795u8ZoXgNrDHNHVMCP8420A0aUMNoMK10JCZQi1o/vlGepkY
         FKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ejFMs1ymx6wprUI+r6xLITbuYkgKsiTBbmg42Z9Nv8=;
        b=L5UqcRJwa2MpSyobAspWPLCEKSWqORrTbxUecsInozfP49bUhd0+IqaZr9ZOyLbt/x
         Tgt8e7jHBnXzzexqanrusdfg8bvUD/MyXb7FXohujd8k6LcO+HjlJQjPwQ0XPJBJm0Rs
         BL0daFJYeBvtu1RA9vrwI22bDE3AsaIzr4DoeiSXUBR5277JuyzRdgleyaBeH5yxNUdb
         4xWvKktjm1/yf1X+wi0ThmDH1lBOpJBMj4as+gh9XpPkjPpvdbr3ftpj/iL69nhcoGI6
         9oHC4/kI7MXzCS8ET2PSfVJH1fzUJTZ6VyHPNArsh/P69d28Cr5C6yDpSEPVhuMG5oTi
         NZCA==
X-Gm-Message-State: AOAM530cbZZitKAXynvWMpB3kfuTwz1Nfa3Tn2c3Gm0PTrN1hZgANQKX
        mHqT4eQcQCLeqshfYNOotR60km5ByiOnHcF51VlWGnoYJKp4
X-Google-Smtp-Source: ABdhPJzuO7kdqgsDVzIPTUevDkXGWaTRDXynnsfCg/jLjSmc6WcZRIMnb3Ap8xDAelqyhO3S7SrTGTRnh4HDwaXUX0M=
X-Received: by 2002:aa7:c383:: with SMTP id k3mr19175058edq.164.1597755051538;
 Tue, 18 Aug 2020 05:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6b0MM-04XwcE58N-BiOBBi2g-1AZovoBmPGgcfU_wZiQ@mail.gmail.com>
 <CAHC9VhQurFFNfjx22RxKp-QG_GJ6VDZy3yEOWwWY++wfn+2C9Q@mail.gmail.com> <CAEjxPJ693_3xX=VJTkQejfSatox9YxER9L0y=0H781noSGA-Hw@mail.gmail.com>
In-Reply-To: <CAEjxPJ693_3xX=VJTkQejfSatox9YxER9L0y=0H781noSGA-Hw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 18 Aug 2020 08:50:40 -0400
Message-ID: <CAHC9VhTBFj2eVaCk8W61dDj57A0kHPR43VqxSoJHE_6KZQmmfA@mail.gmail.com>
Subject: Re: potential memory leak in netlbl_mgmt_add_common
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 18, 2020 at 8:28 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 17, 2020 at 10:25 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Thu, Aug 13, 2020 at 12:32 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > I noticed this in /sys/kernel/debug/kmemleak while testing other
> > > patches.  This is on 5.8.0-rc1 but may be older.
> > >
> > > unreferenced object 0xffff888158b40380 (size 32):
> > >   comm "netlabelctl", pid 2982, jiffies 4295212079 (age 3234.561s)
> > >   hex dump (first 32 bytes):
> > >     80 03 b4 58 81 88 ff ff 80 03 b4 58 81 88 ff ff  ...X.......X....
> > >     90 03 b4 58 81 88 ff ff 90 03 b4 58 81 88 ff ff  ...X.......X....
> > >   backtrace:
> > >     [<000000009fe161a4>] netlbl_mgmt_add_common+0x2df/0x9b0
> > >     [<00000000816cc1d9>] netlbl_mgmt_adddef+0x133/0x190
> > >     [<00000000f060e456>] genl_rcv_msg+0x2dd/0x490
> > >     [<000000001c733400>] netlink_rcv_skb+0xd0/0x200
> > >     [<00000000c42f6f58>] genl_rcv+0x24/0x40
> > >     [<000000005421c040>] netlink_unicast+0x2b4/0x3e0
> > >     [<00000000ab107bba>] netlink_sendmsg+0x3a6/0x660
> > >     [<00000000643024bd>] sock_sendmsg+0x96/0xa0
> > >     [<00000000ba78e5a6>] ____sys_sendmsg+0x404/0x440
> > >     [<000000006f3de0f5>] ___sys_sendmsg+0xd8/0x140
> > >     [<000000009b8c70ea>] __sys_sendmsg+0xa3/0x110
> > >     [<00000000e65194c3>] do_syscall_64+0x52/0xb0
> > >     [<00000000367aebc6>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Hmmm, that's interesting, a quick look at the code doesn't reveal
> > anything obvious and it looks like I don't currently have kmemleak
> > enabled in my kernel so I'll need to rebuild ... you wouldn't happen
> > to have line numbers for the backtrace above would you?  Anything
> > special you did to reproduce this?
>
> I don't still have that kernel so I'll need to reproduce it again.

No problem.  If you remember to do it next time you've got a test
going, it would be nice to have the confirmation, but I started
building a kernel this morning (forgot to start it last night).

> It
> was reproducible however just by running the selinux-testsuite and
> then echo scan > /sys/kernel/debug/kmemleak and then cat
> /sys/kernel/debug/kmemleak.  kmemleak-related config was:
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=4096
> # CONFIG_DEBUG_KMEMLEAK_TEST is not set
> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
> CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y

Okay, good.  I was worried the reproducer might be tricky, but that's
easy enough.

-- 
paul moore
www.paul-moore.com
