Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A313C433E1
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 12:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39DA6207D3
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 12:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE8iaWDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHRM2Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgHRM2Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Aug 2020 08:28:24 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB93C061389
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 05:28:24 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id c4so16051556otf.12
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fiafv+BIVe+MNwHpMFWhIPAY1zgdTl9Acsp1wrxGwH4=;
        b=bE8iaWDp9sR4++IYZLP4/CJie4YgQHPuAOTgrMgE4mdz0QH4GA7yyp8dzO9hVyNs8y
         Yr4GCI88r9OgnjXHE99gUUAfpCQvrS7QduVaSkLhA44jQKksB1U+AgiXuCSdTh8y7ziD
         /0f34LpQCC+PfALn/7DFnJmuoWhfVHOWTvlb2LVHmeTdGBR8ghU7nWtjkooLrKLdxeME
         XJxkpYPjorphjPzgiQh+7eFtlRp2CYgJwlGoGOHKl7wPNLNPzjHoGegcEvsOT5gGfQQF
         ooxFVKb5lpyjX2imw5xpNm9JsoDSUa/r9bSGP4/UlywLzFbCdEi2/OJRfn2spYkCSHLD
         OUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fiafv+BIVe+MNwHpMFWhIPAY1zgdTl9Acsp1wrxGwH4=;
        b=NkzONxA3ouhdlfNKH8rsF87sXpSmPQtflewUiFWevt8yTBvOlSAN95UiQ93WaISVGJ
         kofFLjPgRK3ThcrJA74TVXQi4vJLRiA1jGh9fj1nnB1E0yVFAazOqzpF/FEzBDHdpBZq
         rVhhAw59kQQ+gzT1XYLZEOm/ugmRAWK/nRKdrq7+uhapojwACg6vc418y5t42S6NmJ6D
         TTrqp/g8OnHx/xhHQqwPBuw5Xtzbwl2spZZ0Bd4XTH0J+ZOBbzkbz6+O8t1CXp6GD0Jb
         6ytDrpW6/CfPD8czQVkWR1pkV2rm7nJ+GsQwr7ewUJDfjT2jb0UcrtiSbM9tdb3RAQl7
         gSqw==
X-Gm-Message-State: AOAM532+JhF8qIjvjpiW0Enx3cSDhgUxQgF0JYgzKtkQXreTTaJ6ehA4
        zDzRfKoKvhrQ54AqRZ/Gdm56uUSbRlnaDWFW3to=
X-Google-Smtp-Source: ABdhPJwaL3mZiIV8vtOdy2SJDvhno+tgRSn+7UB/5p/cDF9TEVwLXHm55sba04qFwRLgK0Hd5H/eJR8wRItQXTnnxhI=
X-Received: by 2002:a05:6830:1305:: with SMTP id p5mr15240348otq.135.1597753703860;
 Tue, 18 Aug 2020 05:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6b0MM-04XwcE58N-BiOBBi2g-1AZovoBmPGgcfU_wZiQ@mail.gmail.com>
 <CAHC9VhQurFFNfjx22RxKp-QG_GJ6VDZy3yEOWwWY++wfn+2C9Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQurFFNfjx22RxKp-QG_GJ6VDZy3yEOWwWY++wfn+2C9Q@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 18 Aug 2020 08:28:13 -0400
Message-ID: <CAEjxPJ693_3xX=VJTkQejfSatox9YxER9L0y=0H781noSGA-Hw@mail.gmail.com>
Subject: Re: potential memory leak in netlbl_mgmt_add_common
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 17, 2020 at 10:25 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Aug 13, 2020 at 12:32 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > I noticed this in /sys/kernel/debug/kmemleak while testing other
> > patches.  This is on 5.8.0-rc1 but may be older.
> >
> > unreferenced object 0xffff888158b40380 (size 32):
> >   comm "netlabelctl", pid 2982, jiffies 4295212079 (age 3234.561s)
> >   hex dump (first 32 bytes):
> >     80 03 b4 58 81 88 ff ff 80 03 b4 58 81 88 ff ff  ...X.......X....
> >     90 03 b4 58 81 88 ff ff 90 03 b4 58 81 88 ff ff  ...X.......X....
> >   backtrace:
> >     [<000000009fe161a4>] netlbl_mgmt_add_common+0x2df/0x9b0
> >     [<00000000816cc1d9>] netlbl_mgmt_adddef+0x133/0x190
> >     [<00000000f060e456>] genl_rcv_msg+0x2dd/0x490
> >     [<000000001c733400>] netlink_rcv_skb+0xd0/0x200
> >     [<00000000c42f6f58>] genl_rcv+0x24/0x40
> >     [<000000005421c040>] netlink_unicast+0x2b4/0x3e0
> >     [<00000000ab107bba>] netlink_sendmsg+0x3a6/0x660
> >     [<00000000643024bd>] sock_sendmsg+0x96/0xa0
> >     [<00000000ba78e5a6>] ____sys_sendmsg+0x404/0x440
> >     [<000000006f3de0f5>] ___sys_sendmsg+0xd8/0x140
> >     [<000000009b8c70ea>] __sys_sendmsg+0xa3/0x110
> >     [<00000000e65194c3>] do_syscall_64+0x52/0xb0
> >     [<00000000367aebc6>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Hmmm, that's interesting, a quick look at the code doesn't reveal
> anything obvious and it looks like I don't currently have kmemleak
> enabled in my kernel so I'll need to rebuild ... you wouldn't happen
> to have line numbers for the backtrace above would you?  Anything
> special you did to reproduce this?

I don't still have that kernel so I'll need to reproduce it again.  It
was reproducible however just by running the selinux-testsuite and
then echo scan > /sys/kernel/debug/kmemleak and then cat
/sys/kernel/debug/kmemleak.  kmemleak-related config was:
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=4096
# CONFIG_DEBUG_KMEMLEAK_TEST is not set
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
