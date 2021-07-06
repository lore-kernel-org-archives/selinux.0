Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C83C07E96
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 12:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5BD9611AB
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 12:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhGFMxp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 08:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbhGFMxf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 08:53:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0F8C061764
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 05:50:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id c17so33917760ejk.13
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4j1RX/4vxQmgSfWiJVIbkm3BekbD4J1+8zX+K8GVHA=;
        b=WU/h2d84gwLmZE0PbbvGiG50douLmYVV5vrIcXRSV0wto/x0xQ8gTyNbUDw044mqQJ
         0MiHY1UlEcdksNDY+HJ+8uCUFDy3qYyTfZLT3LV7ZHnUOfd/VW31CTHNv2E/p/lbpMfN
         BaG2JAz2sM8CCX/pzy9k/dc+yiC4Gixrd8/maBGCOMYokl1gF84qbzZLeItKIHBonmMU
         pzxuzhaa9J03k22JxwRDPnU+s8hFl8QI1b4swolMQLDd8HBjlM9HBpF0YkgSVKWgtfIA
         QECgbxSlEYaycZfGTVvY4jc9gO+NpPOsNQV6A/hggJ4JOc4KYd18vDQzL+uPEp79WOgz
         Q8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4j1RX/4vxQmgSfWiJVIbkm3BekbD4J1+8zX+K8GVHA=;
        b=Z6uWCfIIKttGRFC9ZviPmTR28AG5NF4GA7zQElcWmkZqXr+FUNhHJ/JBj5q8eBAbEX
         q2IpWL+xcYY0TmbQ7bvPOOT+f4gcOcUYUtGFEXifcu3guYHVLLqRp6+yLMdiYiYxsbai
         3XF15zbeFUm8GpBm3otn0ySkJaJkjUTktYD481B/1TSw5m8rG94yy/FcUUJEvYnbWDqZ
         tgb7c818NwI3ZJU+r9uXN7mKgntp0aNU2sY0A1h1KUA3UNVvh9PtfBroNF0rf9Dk6yTQ
         MEiUqM/hvvdeVMPNAO6qV4VjqURwX2Yy1t9mB6Bbs5LJwMtxK5pcdNsDQWVTSuPLAiNV
         pWdw==
X-Gm-Message-State: AOAM530iKO9rtjOsNUTUuxu05D6v+hjg5KOH48m8EY899jP8qc5+ANvw
        bDOa5IYRcwN8j+wF1ROczhlIJZsEX/+qqYOVV+hX
X-Google-Smtp-Source: ABdhPJxb5ymVgv/EPwejbN2/uGp8bQsc3v8V3IPMaTZlLQQ7amZy2CayzGiVgUsfD7rJOTFn6HYIr3bnLREGEKC4j3Q=
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr17992943ejb.542.1625575855534;
 Tue, 06 Jul 2021 05:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004e5ec705c6318557@google.com> <CACT4Y+YysFa1UzT6zw9GGns69WSFgqrL6P_LjUju6ujcJRTaeA@mail.gmail.com>
 <d11c276d-65a0-5273-d797-1092e1e2692a@schaufler-ca.com> <CAHC9VhSq88YjA-VGSTKkc4hkc_KOK=mnoAYiX1us6O6U0gFzAQ@mail.gmail.com>
 <CACT4Y+bj4epytaY4hhEx5GF+Z2xcMnS4AEg=JcrTEnWvXWFuGQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bj4epytaY4hhEx5GF+Z2xcMnS4AEg=JcrTEnWvXWFuGQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Jul 2021 08:50:44 -0400
Message-ID: <CAHC9VhQLi+1r3BmSeQre+EEtEyvhSmmT-ABLjvzk0J-J9v9URw@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in legacy_parse_param
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 5, 2021 at 1:52 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Sun, Jul 4, 2021 at 4:14 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Sat, Jul 3, 2021 at 6:16 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > On 7/2/2021 10:51 PM, Dmitry Vyukov wrote:
> > > > On Sat, Jul 3, 2021 at 7:41 AM syzbot
> > > > <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com> wrote:
> > > >> Hello,
> > > >>
> > > >> syzbot found the following issue on:
> > > >>
> > > >> HEAD commit:    62fb9874 Linux 5.13
> > > >> git tree:       upstream
> > > >> console output: https://syzkaller.appspot.com/x/log.txt?x=12ffa118300000
> > > >> kernel config:  https://syzkaller.appspot.com/x/.config?x=19404adbea015a58
> > > >> dashboard link: https://syzkaller.appspot.com/bug?extid=d1e3b1d92d25abf97943
> > > >> compiler:       Debian clang version 11.0.1-2
> > > >>
> > > >> Unfortunately, I don't have any reproducer for this issue yet.
> > > >>
> > > >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > >> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
> > > > +Casey for what looks like a smackfs issue
> > >
> > > This is from the new mount infrastructure introduced by
> > > David Howells in November 2018. It makes sense that there
> > > may be a problem in SELinux as well, as the code was introduced
> > > by the same developer at the same time for the same purpose.
> > >
> > > > The crash was triggered by this test case:
> > > >
> > > > 21:55:33 executing program 1:
> > > > r0 = fsopen(&(0x7f0000000040)='ext3\x00', 0x1)
> > > > fsconfig$FSCONFIG_SET_STRING(r0, 0x1, &(0x7f00000002c0)='smackfsroot',
> > > > &(0x7f0000000300)='default_permissions', 0x0)
> > > >
> > > > And I think the issue is in smack_fs_context_parse_param():
> > > > https://elixir.bootlin.com/linux/latest/source/security/smack/smack_lsm.c#L691
> > > >
> > > > But it seems that selinux_fs_context_parse_param() contains the same issue:
> > > > https://elixir.bootlin.com/linux/latest/source/security/selinux/hooks.c#L2919
> > > > +So selinux maintainers as well.
> > > >
> > > >> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> > > >> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > > >> CPU: 0 PID: 20300 Comm: syz-executor.1 Not tainted 5.13.0-syzkaller #0
> > > >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > >> RIP: 0010:memchr+0x2f/0x70 lib/string.c:1054
> > > >> Code: 41 54 53 48 89 d3 41 89 f7 45 31 f6 49 bc 00 00 00 00 00 fc ff df 0f 1f 44 00 00 48 85 db 74 3b 48 89 fd 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 75 0f 48 ff cb 48 8d 7d 01 44 38 7d 00 75 db
> > > >> RSP: 0018:ffffc90001dafd00 EFLAGS: 00010246
> > > >> RAX: 0000000000000000 RBX: 0000000000000013 RCX: dffffc0000000000
> > > >> RDX: 0000000000000013 RSI: 000000000000002c RDI: 0000000000000000
> > > >> RBP: 0000000000000000 R08: ffffffff81e171bf R09: ffffffff81e16f95
> > > >> R10: 0000000000000002 R11: ffff88807e96b880 R12: dffffc0000000000
> > > >> R13: ffff888020894000 R14: 0000000000000000 R15: 000000000000002c
> > > >> FS:  00007fe01ae27700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > > >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >> CR2: 00000000005645a8 CR3: 0000000018afc000 CR4: 00000000001506f0
> > > >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > >> Call Trace:
> > > >>  legacy_parse_param+0x461/0x7e0 fs/fs_context.c:537
> > > >>  vfs_parse_fs_param+0x1e5/0x460 fs/fs_context.c:117
> >
> > It's Sunday morning and perhaps my mind is not yet in a "hey, let's
> > look at VFS kernel code!" mindset, but I'm not convinced the problem
> > is the 'param->string = NULL' assignment in the LSM hooks.  In both
> > the case of SELinux and Smack that code ends up returning either a 0
> > (Smack) or a 1 (SELinux) - that's a little odd in it's own way, but I
> > don't believe it is relevant here - either way these return values are
> > not equal to -ENOPARAM so we should end up returning early from
> > vfs_parse_fs_param before it calls down into legacy_parse_param():
> >
> > Taken from https://elixir.bootlin.com/linux/latest/source/fs/fs_context.c#L109 :
> >
> >   ret = security_fs_context_parse_param(fc, param);
> >   if (ret != -ENOPARAM)
> >     /* Param belongs to the LSM or is disallowed by the LSM; so
> >      * don't pass to the FS.
> >      */
> >     return ret;
> >
> >   if (fc->ops->parse_param) {
> >     ret = fc->ops->parse_param(fc, param);
> >     if (ret != -ENOPARAM)
> >       return ret;
> >   }
>
> Hi Paul,
>
> You are right.
> I almost connected the dots, but not exactly.
> Now that I read more code around, setting "param->string = NULL" in
> smack_fs_context_parse_param() looks correct to me (the fs copies and
> takes ownership of the string).
>
> I don't see how the crash happened...

FWIW, I poked around a bit too and couldn't see anything obvious
either, but I can't pretend to know as much about the VFS layer as the
VFS folks.  Hopefully they might have better luck.

-- 
paul moore
www.paul-moore.com
