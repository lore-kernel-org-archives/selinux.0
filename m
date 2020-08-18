Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24F7C433DF
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 13:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D7620706
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 13:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5AxyIKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHRNAB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgHRM77 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Aug 2020 08:59:59 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF39C061389
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 05:59:59 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id v6so16125446ota.13
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+01MyvCEjgrX7XMCdRkS1rJ7oKZhZE0uBxp9zh5vQBY=;
        b=b5AxyIKgJ49FZdizdkXyaMZjwLFTmNFMzMan4qTVHIqB2yN/RGnGevgof/Hs0vp9Cv
         KeAW6bZ0NHviFYwW53FP/u5vYO0HLgWcxJbMALhWtO8M1Qno6MvohxEJcrl0dVTq9Up3
         ngPcxuz+KAgR1EyDMPHGuihjvv++EGqcOJjmQXlFmMP2VAljG1yIzT1YMjuL+8cqdq+m
         lA99+II8i+RiTEXD56ujhzFS2cWMPYMsL8Q6jaPzLgoQtDVIBVpBThESNMQ6Kg6y16Ix
         THIjEFTxCmko+lqLI+hBMLFyx7tGv0SiY0O6PRK+gA+ec+7yjNXE+BUGxMGK8ufQQfeE
         bRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+01MyvCEjgrX7XMCdRkS1rJ7oKZhZE0uBxp9zh5vQBY=;
        b=mF4ooWnqqyPk43ajMIbtDoPze0IUQv6AvDN/u83EyGJc+Y/s6kmRKfqXDObEOGsnqx
         XgpPm9yemnW81La0VCmnzoUKGooirmuShCzUV9Y9ZMg5HDJ9r9x5iechJKGxBy9Dbt/U
         s0JL2XU7NpK0p6JNTFR5FW2j/RgUpDgY3V/Vvox3RpnwLGMbk45HCkrip4gnBaejuMeE
         b5yXkRJKqHFUPWEtR5Sqsx5mnMQjx2zi9B+XEzOOh/V4+Y6c1BK8g2MrWLzk/lAf8y96
         hmMvFpdRp1/8rdqBnA+JranNN/osGJLDk/6QdnOfZRw7sCgun3vCy/k/4gB3sCjmNkXx
         Y0cQ==
X-Gm-Message-State: AOAM531IaT9Bl5PYz31aBnShXnbHD90okH42A/CGz3js9TcaMCwJysnw
        zMReX/zW15TO3JCoT98h4QnhxvRU+HKH/PyLIdg=
X-Google-Smtp-Source: ABdhPJzW0tVOk03qZnnIexD+a20+q9Azc87CUcTSNB13mptsus+MTT5vXjm7D68NKLPNNadkL3Yl/yIOrUnriq0qric=
X-Received: by 2002:a05:6830:1305:: with SMTP id p5mr15324058otq.135.1597755597017;
 Tue, 18 Aug 2020 05:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6b0MM-04XwcE58N-BiOBBi2g-1AZovoBmPGgcfU_wZiQ@mail.gmail.com>
 <CAHC9VhQurFFNfjx22RxKp-QG_GJ6VDZy3yEOWwWY++wfn+2C9Q@mail.gmail.com>
 <CAEjxPJ693_3xX=VJTkQejfSatox9YxER9L0y=0H781noSGA-Hw@mail.gmail.com> <CAEjxPJ6TEk=iXHkB0=6EytMeJo1R+ZSgS8O0-32NPHpR43PhsQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6TEk=iXHkB0=6EytMeJo1R+ZSgS8O0-32NPHpR43PhsQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 18 Aug 2020 08:59:46 -0400
Message-ID: <CAEjxPJ5T5Dht0G1XZYVKgL5Zz1gTqcDVzJZaStHnyHQmOy_PbA@mail.gmail.com>
Subject: Re: potential memory leak in netlbl_mgmt_add_common
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 18, 2020 at 8:52 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 18, 2020 at 8:28 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Aug 17, 2020 at 10:25 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Thu, Aug 13, 2020 at 12:32 PM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > I noticed this in /sys/kernel/debug/kmemleak while testing other
> > > > patches.  This is on 5.8.0-rc1 but may be older.
> > > >
> > > > unreferenced object 0xffff888158b40380 (size 32):
> > > >   comm "netlabelctl", pid 2982, jiffies 4295212079 (age 3234.561s)
> > > >   hex dump (first 32 bytes):
> > > >     80 03 b4 58 81 88 ff ff 80 03 b4 58 81 88 ff ff  ...X.......X....
> > > >     90 03 b4 58 81 88 ff ff 90 03 b4 58 81 88 ff ff  ...X.......X....
> > > >   backtrace:
> > > >     [<000000009fe161a4>] netlbl_mgmt_add_common+0x2df/0x9b0
> > > >     [<00000000816cc1d9>] netlbl_mgmt_adddef+0x133/0x190
> > > >     [<00000000f060e456>] genl_rcv_msg+0x2dd/0x490
> > > >     [<000000001c733400>] netlink_rcv_skb+0xd0/0x200
> > > >     [<00000000c42f6f58>] genl_rcv+0x24/0x40
> > > >     [<000000005421c040>] netlink_unicast+0x2b4/0x3e0
> > > >     [<00000000ab107bba>] netlink_sendmsg+0x3a6/0x660
> > > >     [<00000000643024bd>] sock_sendmsg+0x96/0xa0
> > > >     [<00000000ba78e5a6>] ____sys_sendmsg+0x404/0x440
> > > >     [<000000006f3de0f5>] ___sys_sendmsg+0xd8/0x140
> > > >     [<000000009b8c70ea>] __sys_sendmsg+0xa3/0x110
> > > >     [<00000000e65194c3>] do_syscall_64+0x52/0xb0
> > > >     [<00000000367aebc6>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > Hmmm, that's interesting, a quick look at the code doesn't reveal
> > > anything obvious and it looks like I don't currently have kmemleak
> > > enabled in my kernel so I'll need to rebuild ... you wouldn't happen
> > > to have line numbers for the backtrace above would you?  Anything
> > > special you did to reproduce this?
> >
> > I don't still have that kernel so I'll need to reproduce it again.  It
> > was reproducible however just by running the selinux-testsuite and
> > then echo scan > /sys/kernel/debug/kmemleak and then cat
> > /sys/kernel/debug/kmemleak.  kmemleak-related config was:
> > CONFIG_HAVE_DEBUG_KMEMLEAK=y
> > CONFIG_DEBUG_KMEMLEAK=y
> > CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=4096
> > # CONFIG_DEBUG_KMEMLEAK_TEST is not set
> > # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
> > CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
>
> If I am decoding this correctly, it looks like the leaking allocation
> is at net/netlabel/netlabel_mgmt.c:152:
>    147         if (info->attrs[NLBL_MGMT_A_IPV4ADDR]) {
>     148                 struct in_addr *addr;
>     149                 struct in_addr *mask;
>     150                 struct netlbl_domaddr4_map *map;
>     151
>     152                 addrmap = kzalloc(sizeof(*addrmap), GFP_KERNEL);
>     153                 if (addrmap == NULL) {
>     154                         ret_val = -ENOMEM;
>     155                         goto add_doi_put_def;
>     156                 }

And the full stacktrace fed through decode_stacktrace.sh (which I
didn't realize existed until just now, was doing it by hand) is:
netlbl_mgmt_add_common (net/netlabel/netlabel_mgmt.c:153)
netlbl_mgmt_adddef (net/netlabel/netlabel_mgmt.c:546)
genl_rcv_msg (net/netlink/genetlink.c:693 net/netlink/genetlink.c:736
net/netlink/genetlink.c:753)
netlink_rcv_skb (net/netlink/af_netlink.c:2470)
genl_rcv (net/netlink/genetlink.c:765)
netlink_unicast (net/netlink/af_netlink.c:1304 net/netlink/af_netlink.c:1329)
netlink_sendmsg (net/netlink/af_netlink.c:1918)
sock_sendmsg (net/socket.c:652 net/socket.c:672)
____sys_sendmsg (net/socket.c:2352)
___sys_sendmsg (net/socket.c:2408)
__sys_sendmsg (./include/linux/file.h:31 net/socket.c:2441)
do_syscall_64 (arch/x86/entry/common.c:359)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:124)
