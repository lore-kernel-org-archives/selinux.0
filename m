Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EBDC282D8
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 16:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F196621726
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 16:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oCL3zgqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfBAQsf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:48:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33967 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfBAQse (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Feb 2019 11:48:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id u89-v6so6415802lje.1
        for <selinux@vger.kernel.org>; Fri, 01 Feb 2019 08:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IubtPrPJEji2UXzIB3QJ5rB/j9k5X35j3mG98zoFdkQ=;
        b=oCL3zgqSXYMZ4XEa7eGkl0V0jiMkoSJJXTKXsYApovlqnLZ9pq9ep+8E0KZL7PZpxN
         1IYfUvXQkcRyGs8zOCPA857FxrE5zzNe7CGOuuQ66UjYEs4SwO32JBhmrBIctTelc7O0
         ehbraI5vEP4vjJJGmRI3Y175GRMZDodze7V21HMLNFgHbmzeZ4tmk9fxfu4DqQiqiRo9
         8syMgYhtXrx13LibrDW6kh15UGsOKqCVlsqNnIXg+MwQvE2RFKkjTTCmKAntQwfrO3rh
         PBjvARmJq5dPAXnRr9jjdRQyXcR0BLOHgFP1qgcAcWxZDcCchlxMv8fldQJolBXBL3li
         Glmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IubtPrPJEji2UXzIB3QJ5rB/j9k5X35j3mG98zoFdkQ=;
        b=hSYFx9hxwrmf1lFw/mbrgXzxqMviAmOT7QHQ/n9tUQRZPxlLtAV6AKiAj3UPXQYjVW
         SudROyU5iB/MorVzz2q93JPvWIR6XW2mRPkRIJWPTo7f+gtpnhLmuZ+aKuuJUkiJllEg
         tFxjxHIqXUCa6V7cRi3IAD/qSCDtGdrkEQGRB98M2R/aO/TAqyNOo3CxyUzIGH1CRCm1
         yipsY4/sv2Q/ayF4hQVHXjDP3I5rD+HL58THKsb+U0k6Jmc64NtD9V4pYzz3gETaBCdr
         I4x4Qi0qNchWIgLvxU5d/LB5ZIjN1+E9ZIxSN2gOlUgfVmlqPpd/2KoaazugHDPHcOVw
         b1bQ==
X-Gm-Message-State: AHQUAubG39KOWFcWqsSaZzIvuKOlZL3GaFfK4AaUgIARbTPjpuMvqxsm
        68swHkiZNmD551M6cr/1BfV91V5sY5K1ViYoGk9p
X-Google-Smtp-Source: AHgI3Ia8vyOfimMMOTloMkRYFWisYhG2VoREFWDxEqgQACWJh6/Gd6PpklZnV8zyJQayjUEWRMY6kTzGYL4oNWAWoF8=
X-Received: by 2002:a2e:3308:: with SMTP id d8-v6mr16087763ljc.38.1549039712666;
 Fri, 01 Feb 2019 08:48:32 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003d28d10580b335cd@google.com> <CAHC9VhR9wwqVcnmAVcqfwmRuX02F8oMVzNNNQym-TeceHFLqOQ@mail.gmail.com>
 <CACT4Y+Yk=bsS7Ti3PjeZm8yG_txt=orBztowHwddHRP_MzuTxw@mail.gmail.com>
In-Reply-To: <CACT4Y+Yk=bsS7Ti3PjeZm8yG_txt=orBztowHwddHRP_MzuTxw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 Feb 2019 11:48:21 -0500
Message-ID: <CAHC9VhRkDLsQUAHUHYYKO=6vAZxDdw2Dwf+O1QKKQjckMNa1Rg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in selinux_netlbl_socket_setsockopt
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
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

On Fri, Feb 1, 2019 at 1:26 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Jan 30, 2019 at 10:30 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Wed, Jan 30, 2019 at 4:01 PM syzbot
> > <syzbot+1bfc00ca3aabe5bcd4cb@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    62967898789d Merge git://git.kernel.org/pub/scm/linux/kern..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=167fdef8c00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=4fceea9e2d99ac20
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=1bfc00ca3aabe5bcd4cb
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+1bfc00ca3aabe5bcd4cb@syzkaller.appspotmail.com
> > >
> > > 8021q: adding VLAN 0 to HW filter on device team0
> > > ==================================================================
> > > BUG: KASAN: use-after-free in selinux_netlbl_socket_setsockopt+0x49b/0x510
> > > security/selinux/netlabel.c:525
> > > Read of size 8 at addr ffff8880a63cf078 by task syz-executor3/18477
> > >
> > > CPU: 1 PID: 18477 Comm: syz-executor3 Not tainted 5.0.0-rc4+ #51
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > Google 01/01/2011
> > > Call Trace:
> > >   __dump_stack lib/dump_stack.c:77 [inline]
> > >   dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
> > >   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
> > >   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
> > >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
> > >   selinux_netlbl_socket_setsockopt+0x49b/0x510
> > > security/selinux/netlabel.c:525
> >
> > At first glance this seems odd.  The line above is simply
> > dereferencing sock->sk_security (getting the "sksec"), which we also
> > do higher up selinux_socket_setsockopt() via sock_has_perm().  Unless
> > somehow the socket is being released/freed in the middle of a
> > setsockopt() syscall this looks like maybe it's something else?
>
> Hi Paul,
>
> Searching for af_netrom across other syzbot bugs:
> https://groups.google.com/forum/#!searchin/syzkaller-bugs/af_netrom%7Csort:date
>
> I see at least:
> https://syzkaller.appspot.com/bug?extid=b0b1952f5864b4009b09
> https://syzkaller.appspot.com/bug?extid=febf3c50d4262e578b1c
> https://syzkaller.appspot.com/bug?extid=defa700d16f1bd1b9a05
>
> Which suggests there are some serious lifetime problems in netrom
> sockets. That would probably explain this crash as well.

That definitely looks plausible.  While I'm not one to say it could
*never* be the SELinux/NetLabel code, I can say that the SELinux code
path in question hasn't changed in some time so I would be a little
surprised if it was suddenly broken.

> +netrom maintainers, does this explanation look plausible to you?
> should we dup this crash onto one of the other netrom bugs? and
> perhaps these netrom bugs across themselves too?

-- 
paul moore
www.paul-moore.com
