Return-Path: <SRS0=Plie=RK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561B4C43381
	for <selinux@archiver.kernel.org>; Thu,  7 Mar 2019 20:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40B220675
	for <selinux@archiver.kernel.org>; Thu,  7 Mar 2019 20:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="V+TPEwDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfCGUgz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:36:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40218 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCGUgz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Mar 2019 15:36:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id w6so15460767ljd.7
        for <selinux@vger.kernel.org>; Thu, 07 Mar 2019 12:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DMJb0dtqeDnGMlVFDbZN2oWca3L/fm7IdS3oe58tQFU=;
        b=V+TPEwDN3VcW0OP1XBDMDslzIQzPO7Cs2EUaPQ/qpexNQ72qpjwpcxV/pdahXrnDdO
         ZnIHQ4tfBeg0DZg4Tv2wme963Albemy05bASiW7wKBB82jMJfj6e3mfzCsBQnfHgDX/g
         Q70YRjXfghO8jB8dDfVsaGHqZlgMHNNl97+elA0OTuNXkptZTdOez55L3WCJU75Y3Vb5
         fAgGp2kfNO7CuOqje1PpNsG6QIRSWWmbgVT6/0/5iaD4J2jC0BH7mDhxAWAB+Y42jbwW
         bnpbV1vDnN4ZoHhTBNbdNEMZwbvgvbPWh0jQes7vGXEl4iI3r9PflNJ4foTY//u5Kgze
         g1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DMJb0dtqeDnGMlVFDbZN2oWca3L/fm7IdS3oe58tQFU=;
        b=ZICL6gHytONbitICzytB0cUeYfopL2U0Q8MCpgb8ap+ebKeXFfxv53bQClm07tfMb3
         VOOc/eQTlzrakQMQySKyxEWNWdrt99RLYyxJM+MeQJgas9nAwZgnWe07nQj8ozT3lpmV
         4GTACtOBTCKY1lI5yUPni/IsS0XWRGbhC7x6uDeWZuf5zGnRZPbcmzApzX3h50pncj9R
         8hhE7U5cZmr8ahdwR1iC8lzo3f36wj9zeQt/OAejf6HG2KKYDXTTOlmEFPqMwoP0E8le
         oOQ28oEn7flnOHeHZEfB/Tc/xTbheFUNanYX5OEMzzFKnwROVqUrmnakyLwoAcJ+1GQG
         Zgdw==
X-Gm-Message-State: APjAAAVxN5qWuX5A94HXbWnBlFP0VMgHGIYPHiYFOvr+5uokKMFQY0zj
        fSwfUNbvByExBSyrIdJnnKbIzMDzvpKlJK3xzpFn
X-Google-Smtp-Source: APXvYqzvFi3FdQVcwjeUxmlpGVb4Dk2w+W7KK/f3Fqgmwmr3aua5fb0A1NHP9eGwB631/JW4urNjXoDSdMYm7wyDT7I=
X-Received: by 2002:a2e:88d1:: with SMTP id a17mr6924632ljk.169.1551991011806;
 Thu, 07 Mar 2019 12:36:51 -0800 (PST)
MIME-Version: 1.0
References: <20190307025731.49369-1-maowenan@huawei.com>
In-Reply-To: <20190307025731.49369-1-maowenan@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 Mar 2019 15:36:40 -0500
Message-ID: <CAHC9VhRBFwTbkE1YbQkRfxia5XZaWBK_D4WG4nNgMgF=wKf_fw@mail.gmail.com>
Subject: Re: [PATCH net] net: selinux: fix memory leak in selinux_netlbl_socket_post_create()
To:     Mao Wenan <maowenan@huawei.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 6, 2019 at 9:44 PM Mao Wenan <maowenan@huawei.com> wrote:
>
> If netlbl_sock_setattr() is failed, it directly returns rc and forgets
> to free secattr.
>
> BUG: memory leak
> unreferenced object 0xffff8883c3ea4200 (size 2664):
>   comm "syz-executor.2", pid 8813, jiffies 4297264419 (age 156.090s)
>   hex dump (first 32 bytes):
>     7f 00 00 01 7f 00 00 01 eb 7f ed 71 4e 24 00 00  ...........qN$..
>     02 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>   backtrace:
>     [<000000004c0228da>] sk_alloc+0x3d/0xc00 net/core/sock.c:1523
>     [<00000000535a3da2>] inet_create+0x339/0xe10 net/ipv4/af_inet.c:321
>     [<000000009aec3cfe>] __sock_create+0x3fa/0x790 net/socket.c:1275
>     [<000000004274b384>] sock_create net/socket.c:1315 [inline]
>     [<000000004274b384>] __sys_socket+0xe7/0x1d0 net/socket.c:1345
>     [<00000000b3fdc826>] __do_sys_socket net/socket.c:1354 [inline]
>     [<00000000b3fdc826>] __se_sys_socket net/socket.c:1352 [inline]
>     [<00000000b3fdc826>] __x64_sys_socket+0x74/0xb0 net/socket.c:1352
>     [<000000004ae3186e>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
>     [<00000000bc0d2230>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>     [<00000000f737e62f>] 0xffffffffffffffff
>
> BUG: memory leak
> unreferenced object 0xffff8883de23d570 (size 32):
>   comm "syz-executor.2", pid 8813, jiffies 4297264419 (age 156.090s)
>   hex dump (first 32 bytes):
>     02 00 00 00 00 00 00 00 60 a9 40 ce 83 88 ff ff  ........`.@.....
>     01 00 00 00 03 00 00 00 10 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000035ba8b75>] security_sk_alloc+0x5e/0xb0 security/security.c:1473
>     [<00000000302cc426>] sk_prot_alloc+0x8e/0x290 net/core/sock.c:1472
>     [<000000004c0228da>] sk_alloc+0x3d/0xc00 net/core/sock.c:1523
>     [<00000000535a3da2>] inet_create+0x339/0xe10 net/ipv4/af_inet.c:321
>     [<000000009aec3cfe>] __sock_create+0x3fa/0x790 net/socket.c:1275
>     [<000000004274b384>] sock_create net/socket.c:1315 [inline]
>     [<000000004274b384>] __sys_socket+0xe7/0x1d0 net/socket.c:1345
>     [<00000000b3fdc826>] __do_sys_socket net/socket.c:1354 [inline]
>     [<00000000b3fdc826>] __se_sys_socket net/socket.c:1352 [inline]
>     [<00000000b3fdc826>] __x64_sys_socket+0x74/0xb0 net/socket.c:1352
>     [<000000004ae3186e>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
>     [<00000000bc0d2230>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>     [<00000000f737e62f>] 0xffffffffffffffff
>
> BUG: memory leak
> unreferenced object 0xffff8883ce40a960 (size 64):
>   comm "syz-executor.2", pid 8813, jiffies 4297264420 (age 156.089s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000029add401>] selinux_netlbl_socket_post_create+0x68/0x130 security/selinux/netlabel.c:416
>     [<000000005368a19c>] selinux_socket_post_create+0x31a/0x7f0 security/selinux/hooks.c:4597
>     [<00000000bd4730e2>] security_socket_post_create+0x70/0xc0 security/security.c:1385
>     [<00000000671052a4>] __sock_create+0x5a6/0x790 net/socket.c:1291
>     [<000000004274b384>] sock_create net/socket.c:1315 [inline]
>     [<000000004274b384>] __sys_socket+0xe7/0x1d0 net/socket.c:1345
>     [<00000000b3fdc826>] __do_sys_socket net/socket.c:1354 [inline]
>     [<00000000b3fdc826>] __se_sys_socket net/socket.c:1352 [inline]
>     [<00000000b3fdc826>] __x64_sys_socket+0x74/0xb0 net/socket.c:1352
>     [<000000004ae3186e>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
>     [<00000000bc0d2230>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>     [<00000000f737e62f>] 0xffffffffffffffff
>
> Fixes: 389fb800ac8b("netlabel: Label incoming TCP connections correctly in SELinux")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  security/selinux/netlabel.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 186e727b737b..f3da05338580 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -426,6 +426,9 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
>                 rc = 0;
>                 break;
>         }
> +       if (rc != 0) {
> +               netlbl_secattr_free(secattr);
> +       }

This is likely going to cause a problem as the
sock->sk_security->nlbl_secattr still has a reference to the secattr
pointer you are releasing here.  Assuming things are working correctly
elsewhere, I believe freeing secattr here will result in a double free
when the network stacks cleans up after the failed socket creation
(via the sock_release() call in the error handling code).

It looks like you may have found this via a test tool (syzbot?), do
you have a reproducer you can share?

-- 
paul moore
www.paul-moore.com
