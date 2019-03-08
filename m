Return-Path: <SRS0=fbu5=RL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF75C43381
	for <selinux@archiver.kernel.org>; Fri,  8 Mar 2019 13:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A2F21019
	for <selinux@archiver.kernel.org>; Fri,  8 Mar 2019 13:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AOyx7MgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfCHNUo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:20:44 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39002 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfCHNUo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Mar 2019 08:20:44 -0500
Received: by mail-lj1-f195.google.com with SMTP id g80so17361466ljg.6
        for <selinux@vger.kernel.org>; Fri, 08 Mar 2019 05:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcVr0ILNjn7FhY+CJM+wWJingxIUPixHn4Q+s5GjHXQ=;
        b=AOyx7MgXsevhp1sRwYiSEvL8l/sscnmAWWGEwzl5y+p2deLOLMMpFUxQvIE/t4cD5z
         pGuN9t/av9OhbgbzLW8It194pFAGcPybpNqF3u6z0LflfLS8o/C/2DDSAsoyqfZ6Yt2S
         Lyw9e941D74BmH23JL8Cr+dcdQHF4+Bi9ODWmMjop2bsQAIY708d+uNYgJlGgYXJ6avh
         e0no/oSmb1WzZckI2M81zedQTH/8IiZeq/6rRJs1YnDNhREggNZ+bziEmp/ZRjgEzGmU
         jTUswPk5Ymc2vxZX/cT8+X2itrPD7Y7vLWGU8a3wTp11GxPpXlZnxx45cm2JbDNc/SLH
         6z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcVr0ILNjn7FhY+CJM+wWJingxIUPixHn4Q+s5GjHXQ=;
        b=dBf1dLUWaJZWv2h2fi89s93y13EsMrJ20OxCSZ7PpaqG59ORZok9oW4WohWGiicYBg
         FDr963p7WGJ/GM+ClewFGM/UG55VhbShRfARyOIo0LBJKa6vzxBY1bN/aFqmjv9E68dX
         jQJW7OHXBnOGHgZHwtHVTkbxHHdwuO0NE1lpvovyDW9ae0DcydZUMtjVNna6YWVeulcw
         Rbos5j9KKGtBpkUnWlrfN+Aomsua8Y6BKNiCrsvGVdxuAzs4XzT/xfIOJnONf6jjWZ/D
         7RWfQ10oSNM7+NxlThIMcx0lxfcqpYTVchYsqnt07w/XGRGu/6OWEydicVOxtBa7+6jt
         k1Mw==
X-Gm-Message-State: APjAAAX3l6ttJKOnJxyh7zfi03OWUwp13ZImV5ZXeBbAR3RScpmdJsYx
        miEcdeXlKsQwEW7EjYAkPE8C2N6HoXgirsEKpY+Y
X-Google-Smtp-Source: APXvYqwjT2gxMzRcGyyoNKgjH2PQitq1u7aAI/U+rxwcRzQFr85Wnga9PcEBHGgOGOM6MBPnFMQt4Ppv2WHIzaxTLz0=
X-Received: by 2002:a2e:88d1:: with SMTP id a17mr9051825ljk.169.1552051241503;
 Fri, 08 Mar 2019 05:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20190307025731.49369-1-maowenan@huawei.com> <CAHC9VhRBFwTbkE1YbQkRfxia5XZaWBK_D4WG4nNgMgF=wKf_fw@mail.gmail.com>
 <a3c0277d-7314-d95a-e704-be654a162efa@huawei.com>
In-Reply-To: <a3c0277d-7314-d95a-e704-be654a162efa@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 8 Mar 2019 08:20:30 -0500
Message-ID: <CAHC9VhSVmBfsgGVoLd9b1HoZxECHu_Uj8mSi+UUE_CzgB=Y-tg@mail.gmail.com>
Subject: Re: [PATCH net] net: selinux: fix memory leak in selinux_netlbl_socket_post_create()
To:     maowenan <maowenan@huawei.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 8, 2019 at 1:31 AM maowenan <maowenan@huawei.com> wrote:
> On 2019/3/8 4:36, Paul Moore wrote:
> > On Wed, Mar 6, 2019 at 9:44 PM Mao Wenan <maowenan@huawei.com> wrote:
> >>
> >> If netlbl_sock_setattr() is failed, it directly returns rc and forgets
> >> to free secattr.
> >>
> >> BUG: memory leak
> >> unreferenced object 0xffff8883c3ea4200 (size 2664):
> >>   comm "syz-executor.2", pid 8813, jiffies 4297264419 (age 156.090s)
> >>   hex dump (first 32 bytes):
> >>     7f 00 00 01 7f 00 00 01 eb 7f ed 71 4e 24 00 00  ...........qN$..
> >>     02 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
> >>   backtrace:
> >>     [<000000004c0228da>] sk_alloc+0x3d/0xc00 net/core/sock.c:1523
> >>     [<00000000535a3da2>] inet_create+0x339/0xe10 net/ipv4/af_inet.c:321
> >>     [<000000009aec3cfe>] __sock_create+0x3fa/0x790 net/socket.c:1275
> >>     [<000000004274b384>] sock_create net/socket.c:1315 [inline]
> >>     [<000000004274b384>] __sys_socket+0xe7/0x1d0 net/socket.c:1345
> >>     [<00000000b3fdc826>] __do_sys_socket net/socket.c:1354 [inline]
> >>     [<00000000b3fdc826>] __se_sys_socket net/socket.c:1352 [inline]
> >>     [<00000000b3fdc826>] __x64_sys_socket+0x74/0xb0 net/socket.c:1352
> >>     [<000000004ae3186e>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
> >>     [<00000000bc0d2230>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>     [<00000000f737e62f>] 0xffffffffffffffff
> >>
> >> BUG: memory leak
> >> unreferenced object 0xffff8883de23d570 (size 32):
> >>   comm "syz-executor.2", pid 8813, jiffies 4297264419 (age 156.090s)
> >>   hex dump (first 32 bytes):
> >>     02 00 00 00 00 00 00 00 60 a9 40 ce 83 88 ff ff  ........`.@.....
> >>     01 00 00 00 03 00 00 00 10 00 00 00 00 00 00 00  ................
> >>   backtrace:
> >>     [<0000000035ba8b75>] security_sk_alloc+0x5e/0xb0 security/security.c:1473
> >>     [<00000000302cc426>] sk_prot_alloc+0x8e/0x290 net/core/sock.c:1472
> >>     [<000000004c0228da>] sk_alloc+0x3d/0xc00 net/core/sock.c:1523
> >>     [<00000000535a3da2>] inet_create+0x339/0xe10 net/ipv4/af_inet.c:321
> >>     [<000000009aec3cfe>] __sock_create+0x3fa/0x790 net/socket.c:1275
> >>     [<000000004274b384>] sock_create net/socket.c:1315 [inline]
> >>     [<000000004274b384>] __sys_socket+0xe7/0x1d0 net/socket.c:1345
> >>     [<00000000b3fdc826>] __do_sys_socket net/socket.c:1354 [inline]
> >>     [<00000000b3fdc826>] __se_sys_socket net/socket.c:1352 [inline]
> >>     [<00000000b3fdc826>] __x64_sys_socket+0x74/0xb0 net/socket.c:1352
> >>     [<000000004ae3186e>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
> >>     [<00000000bc0d2230>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>     [<00000000f737e62f>] 0xffffffffffffffff
> >>
> >> BUG: memory leak
> >> unreferenced object 0xffff8883ce40a960 (size 64):
> >>   comm "syz-executor.2", pid 8813, jiffies 4297264420 (age 156.089s)
> >>   hex dump (first 32 bytes):
> >>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>   backtrace:
> >>     [<0000000029add401>] selinux_netlbl_socket_post_create+0x68/0x130 security/selinux/netlabel.c:416
> >>     [<000000005368a19c>] selinux_socket_post_create+0x31a/0x7f0 security/selinux/hooks.c:4597
> >>     [<00000000bd4730e2>] security_socket_post_create+0x70/0xc0 security/security.c:1385
> >>     [<00000000671052a4>] __sock_create+0x5a6/0x790 net/socket.c:1291
> >>     [<000000004274b384>] sock_create net/socket.c:1315 [inline]
> >>     [<000000004274b384>] __sys_socket+0xe7/0x1d0 net/socket.c:1345
> >>     [<00000000b3fdc826>] __do_sys_socket net/socket.c:1354 [inline]
> >>     [<00000000b3fdc826>] __se_sys_socket net/socket.c:1352 [inline]
> >>     [<00000000b3fdc826>] __x64_sys_socket+0x74/0xb0 net/socket.c:1352
> >>     [<000000004ae3186e>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
> >>     [<00000000bc0d2230>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>     [<00000000f737e62f>] 0xffffffffffffffff
> >>
> >> Fixes: 389fb800ac8b("netlabel: Label incoming TCP connections correctly in SELinux")
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> >> ---
> >>  security/selinux/netlabel.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> >> index 186e727b737b..f3da05338580 100644
> >> --- a/security/selinux/netlabel.c
> >> +++ b/security/selinux/netlabel.c
> >> @@ -426,6 +426,9 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
> >>                 rc = 0;
> >>                 break;
> >>         }
> >> +       if (rc != 0) {
> >> +               netlbl_secattr_free(secattr);
> >> +       }
> >
> > This is likely going to cause a problem as the
> > sock->sk_security->nlbl_secattr still has a reference to the secattr
> > pointer you are releasing here.  Assuming things are working correctly
> > elsewhere, I believe freeing secattr here will result in a double free
> > when the network stacks cleans up after the failed socket creation
> > (via the sock_release() call in the error handling code).
> Do you mean here?
>         err = security_socket_post_create(sock, family, type, protocol, kern);
>         if (err)
>                 goto out_sock_release;
>         ...
>
>         out_sock_release:
>                 sock_release(sock);
>                 return err;
> yes, the call trace may like below:
>         sock_release->__sock_release->inet_release->tcp_close->sock_put->sk_free->__sk_free->sk_destruct->
>         __sk_destruct->sk_prot_free->security_sk_free->selinux_sk_free_security->selinux_netlbl_sk_security_free->
>         netlbl_secattr_free
>
> so, it is no need to free in selinux_netlbl_socket_post_create().
> Please correct me if this is incorrect.

I haven't followed the entirely call stack lately, but that looks right.

> > It looks like you may have found this via a test tool (syzbot?), do
> > you have a reproducer you can share?
>
> The issue has been found by syzkaller, but unfortunately it is no reproducer, it is
> only some backtrace.

If you are able to reproduce this please let us know, it may be a sign
that something is wrong with the LSM hooks.

Thanks.

-- 
paul moore
www.paul-moore.com
