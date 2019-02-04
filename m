Return-Path: <SRS0=wOFf=QL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6542DC282D8
	for <selinux@archiver.kernel.org>; Mon,  4 Feb 2019 08:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B8D217D6
	for <selinux@archiver.kernel.org>; Mon,  4 Feb 2019 08:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GoXaM5PG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfBDIEY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:04:24 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55180 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbfBDIEX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Feb 2019 03:04:23 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so19067020ita.4
        for <selinux@vger.kernel.org>; Mon, 04 Feb 2019 00:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VkylmgMdehQfvynhBtYYAv/bT1W9TjUptWRKEttu4wo=;
        b=GoXaM5PGSHAjnTruS71/oGif0Wu46X5F4aBLloKuYFa/dqXbuigJtZVoiu0/TvMXl1
         F8WUYbrvYKf+gO3xhVavL/X3Be4CcxbqYQY0RD3YzzWiiz7Bm5ZeaUC10GJP2eZtdNpO
         1GFP9Pb1NSE4OmvdCX4To4ameIl83tjAS0KypgbO0b81tRlIV2LS1PiyQ9ur1sk65aWc
         jVIftKP7Iq1DBP8843sA4T2ms4mJ2QB0THJIT1lQ8K+SPArdmq3NzJwXzO5RpeCoQf7W
         6YIxgxgZSbJczH2lDlCL0N6DjIgfrqlIIuvkij/RXEHxX7ORJjnnPi1SzUtpyZKT2uPJ
         JC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VkylmgMdehQfvynhBtYYAv/bT1W9TjUptWRKEttu4wo=;
        b=L3+bGIObNzQYJgC2buHu9pEeTZqLGAdWO1YGFE2fekd0XcbjHY5CgbdE/X/diGxx8u
         rheg/M2U5U/tx8nN4xcgLWmsolY4nIefriAHH0fiVilrPxZKSUlM/1nR6LP8iIPH957j
         WDSr8isySaNlP3PVD5yYLDpUYsxHyyaaWRMTY8TZM0ZZwZ1XCjPXALR6Pl/8ec7Cc/eP
         X9oE3M3lV0AMbxNlD2URQ2ijaR4rTFHbsXXDIhExAyzk97/uHaUjLucLCHyBSUqYjUmD
         70nLZxzFaptIfSofzhUGO9T0V1ilP+2KTdulFf+ZNAjxtdEWaZl5+jjVGFzJB7a5eOWO
         EzGA==
X-Gm-Message-State: AJcUukeorbNNYaEi1ecJfLGrvh80CLdjqOYNtWTj4iKNt02Bzw8of0/y
        o9G0M7LqhPhviAagi++2YMBVEBiOXRHULb8cEz2bAg==
X-Google-Smtp-Source: ALg8bN6Jt71Qx9nigQcAjoh+XdgrHvz3u3L5Jz6lNXTFfbA/R11GkK4vCIsUcA32wVfP3EW7BZ1Xl5rouSocgPTZ2jE=
X-Received: by 2002:a02:97a2:: with SMTP id s31mr30068832jaj.82.1549267462397;
 Mon, 04 Feb 2019 00:04:22 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003d28d10580b335cd@google.com> <CAHC9VhR9wwqVcnmAVcqfwmRuX02F8oMVzNNNQym-TeceHFLqOQ@mail.gmail.com>
 <CACT4Y+Yk=bsS7Ti3PjeZm8yG_txt=orBztowHwddHRP_MzuTxw@mail.gmail.com> <CAM_iQpV42EyuUFcxR7kn7WipkTAkvSxMc+-Me_QZCCUziy_wiQ@mail.gmail.com>
In-Reply-To: <CAM_iQpV42EyuUFcxR7kn7WipkTAkvSxMc+-Me_QZCCUziy_wiQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 4 Feb 2019 09:04:11 +0100
Message-ID: <CACT4Y+bOvQNBmE6y1Q4qn0EBz_yKfMqgtMUG5FGAtMT6n7bp5w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in selinux_netlbl_socket_setsockopt
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Miller <davem@davemloft.net>,
        linux-hams <linux-hams@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzbot <syzbot+1bfc00ca3aabe5bcd4cb@syzkaller.appspotmail.com>,
        Eric Paris <eparis@parisplace.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 1, 2019 at 6:58 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Thu, Jan 31, 2019 at 10:56 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > Hi Paul,
> >
> > Searching for af_netrom across other syzbot bugs:
> > https://groups.google.com/forum/#!searchin/syzkaller-bugs/af_netrom%7Csort:date
> >
> > I see at least:
> > https://syzkaller.appspot.com/bug?extid=b0b1952f5864b4009b09
> > https://syzkaller.appspot.com/bug?extid=febf3c50d4262e578b1c
> > https://syzkaller.appspot.com/bug?extid=defa700d16f1bd1b9a05
> >
> > Which suggests there are some serious lifetime problems in netrom
> > sockets. That would probably explain this crash as well.
>
> This is supposed to be fixed by:
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=63346650c1a94a92be61a57416ac88c0a47c4327
>
> Please let me know if it isn't.

syzbot can tell if it's not fixed, but for that we need to mark these
bugs as fixed, otherwise syzbot will just consider any new crashes as
the same old bug so nothing to notify about.

#syz fix: netrom: switch to sock timer API
