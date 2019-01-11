Return-Path: <SRS0=yrd7=PT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A084CC43387
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 01:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D49020879
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 01:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="fRWA1Gch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfAKB1N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:27:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43735 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfAKB1N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jan 2019 20:27:13 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so9655222lff.10
        for <selinux@vger.kernel.org>; Thu, 10 Jan 2019 17:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNQYs7ALyOMWiFiNiwUSyAnayUvPH25Nlsm5tjQ2dc4=;
        b=fRWA1GchJJKSjm8TY3AvQcU+BJQ0bROBfUeUsvWPDvln/quMDlsxY33WIwUqwjYrDx
         cRdiNlVyzBsSpL0P3WKgKFVdpnJQ7h4lh56CfUFbjsB+KYzYf4A5k3m8o76ZvGSsXIbM
         trvNo/JH3yVaFSxcWfjyANVmHkm6OJH31MpNo+hg411ZUUKmo6worncJT4N9wYQfgKF5
         LtR/cFs/LsQhBPBKeHbx9JYUCX1f2FssiZ7MROuc7IlkR5M3AJ7PvAlvjrT0I/HlGCEG
         6h0UB8jIpdVq2jPHn5yitGGy8Zq/w3Z0IIwtgy1H45MBXYznd7tHR/IjWJMKpWlXiprk
         T0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNQYs7ALyOMWiFiNiwUSyAnayUvPH25Nlsm5tjQ2dc4=;
        b=eL9MFL+tGoLtbGRK8PWNsgiBH+2F6TvoGloMxMW7hIFqplHiNewOixbZwsAXMO9a8q
         kdxguQDVMdCacQPOsDrG2z2CdddOkvh6458jq7iHbePOB77Gwu6md+rYfm5LGsKtPcxw
         RPIfrSXlgcflHD36RiCugn8SdQm7R8K8GU+OSPfXqcj/BtRA5is57HRxN9YQy4maVBwC
         sor+puJGwPgwqygyFr4ETIfqGvCulddg1B6CjXbkdRwZCS2/h3ZY3BA80ixx6UL2an41
         45mfcQaNCjg/VOsFqUvVBafZ2Nu2kmMlv24H2L+r1BXUCrxVKm8XcjiYFg8pAIxQboTT
         EROg==
X-Gm-Message-State: AJcUuketIqfzlzxJokB4NYey/6tkcIi6igEWmJ/wKV9iRl9aWsGc4u/o
        r3OJJ5cuzcMacjYcF+RjKKqV2uXlwbkghw9ZU2qz
X-Google-Smtp-Source: ALg8bN54VbCuOepKE7cI6I3VadlRvwXKQa8wsaoUIWkLpH2Zp1zkM4jqB7OY/o0plMZd0YnpgzHww5CyOrh7mhDsdZ4=
X-Received: by 2002:a19:8fce:: with SMTP id s75mr6810260lfk.151.1547170030257;
 Thu, 10 Jan 2019 17:27:10 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001a9aa0057f084a81@google.com> <d54c804a5d2dfd560108912094db9967db5a795b.camel@tycho.nsa.gov>
In-Reply-To: <d54c804a5d2dfd560108912094db9967db5a795b.camel@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jan 2019 20:26:58 -0500
Message-ID: <CAHC9VhTbCFoRZ-u7Z8ymQhjGmuAnwk=1_sL9bpr=mMp1hhE4XQ@mail.gmail.com>
Subject: Re: general protection fault in ebitmap_destroy
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     syzbot <syzbot+6664500f0f18f07a5c0e@syzkaller.appspotmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, peter.enderborg@sony.com,
        selinux@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 9, 2019 at 11:11 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2019-01-09 at 07:41 -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    a88cc8da0279 Merge branch 'akpm' (patches from
> > Andrew)
> > git tree:       upstream
> > console output:
> > https://syzkaller.appspot.com/x/log.txt?x=1722da4f400000
> > kernel config:
> > https://syzkaller.appspot.com/x/.config?x=edf1c3031097c304
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=6664500f0f18f07a5c0e
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:
> > https://syzkaller.appspot.com/x/repro.syz?x=12d43580c00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the
> > commit:
> > Reported-by: syzbot+6664500f0f18f07a5c0e@syzkaller.appspotmail.com
> >
> > SELinux: failed to load policy
> > sel_write_load: 238 callbacks suppressed
> > SELinux: failed to load policy
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 9316 Comm: syz-executor2 Not tainted 5.0.0-rc1+ #16
> > Hardware name: Google Google Compute Engine/Google Compute Engine,
> > BIOS
> > Google 01/01/2011
> > RIP: 0010:ebitmap_destroy+0x32/0xf0 security/selinux/ss/ebitmap.c:334
> > Code: 49 89 fd 41 54 53 e8 9d e6 36 fe 4d 85 ed 0f 84 99 00 00 00 e8
> > 8f e6
> > 36 fe 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02
> > 00 0f
> > 85 98 00 00 00 49 be 00 00 00 00 00 fc ff df 4d 8b
> > RSP: 0018:ffff88808967f5c0 EFLAGS: 00010202
> > RAX: dffffc0000000000 RBX: ffff88808967f6a8 RCX: dffffc0000000000
> > RDX: 0000000000000001 RSI: ffffffff834b1081 RDI: 0000000000000008
> > RBP: ffff88808967f5e0 R08: ffff8880972a8140 R09: ffffed1015cc5b90
> > R10: ffffed1015cc5b8f R11: ffff8880ae62dc7b R12: ffff888099d993c0
> > R13: 0000000000000008 R14: ffff888099d993c0 R15: ffff88808967f648
> > FS:  00007f70cd9e5700(0000) GS:ffff8880ae600000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000015e7938 CR3: 0000000096c4a000 CR4: 00000000001406f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   sens_destroy+0x49/0xa0 security/selinux/ss/policydb.c:735
> >   sens_read+0x25d/0x460 security/selinux/ss/policydb.c:1636
> >   policydb_read+0xed9/0x60d0 security/selinux/ss/policydb.c:2430
> >   security_load_policy+0x423/0x1830
> > security/selinux/ss/services.c:2129
> >   sel_write_load+0x25a/0x470 security/selinux/selinuxfs.c:565
> >   __vfs_write+0x116/0xb40 fs/read_write.c:485
> >   vfs_write+0x20c/0x580 fs/read_write.c:549
> >   ksys_write+0x105/0x260 fs/read_write.c:598
> >   __do_sys_write fs/read_write.c:610 [inline]
> >   __se_sys_write fs/read_write.c:607 [inline]
> >   __x64_sys_write+0x73/0xb0 fs/read_write.c:607
> >   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x457ec9
> > Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
> > 89 f7
> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> > f0 ff
> > ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007f70cd9e4c78 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
> > RDX: 000000000000005c RSI: 0000000020000000 RDI: 0000000000000003
> > RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f70cd9e56d4
> > R13: 00000000004c720f R14: 00000000004dc9a0 R15: 00000000ffffffff
> > Modules linked in:
> > ---[ end trace 78ea480790940b53 ]---
> > RIP: 0010:ebitmap_destroy+0x32/0xf0 security/selinux/ss/ebitmap.c:334
> > Code: 49 89 fd 41 54 53 e8 9d e6 36 fe 4d 85 ed 0f 84 99 00 00 00 e8
> > 8f e6
> > 36 fe 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02
> > 00 0f
> > 85 98 00 00 00 49 be 00 00 00 00 00 fc ff df 4d 8b
> > RSP: 0018:ffff88808967f5c0 EFLAGS: 00010202
> > RAX: dffffc0000000000 RBX: ffff88808967f6a8 RCX: dffffc0000000000
> > RDX: 0000000000000001 RSI: ffffffff834b1081 RDI: 0000000000000008
> > RBP: ffff88808967f5e0 R08: ffff8880972a8140 R09: ffffed1015cc5b90
> > R10: ffffed1015cc5b8f R11: ffff8880ae62dc7b R12: ffff888099d993c0
> > R13: 0000000000000008 R14: ffff888099d993c0 R15: ffff88808967f648
> > FS:  00007f70cd9e5700(0000) GS:ffff8880ae700000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000000073c000 CR3: 0000000096c4a000 CR4: 00000000001406e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
> Possible fix below
>
> From cc9324299f32db326447a28a836c462fc16bc945 Mon Sep 17 00:00:00 2001
> From: Stephen Smalley <sds@tycho.nsa.gov>
> Date: Wed, 9 Jan 2019 10:55:10 -0500
> Subject: [PATCH] selinux: fix GPF on invalid policy
>
> levdatum->level can be NULL if we encounter an error while loading
> the policy during sens_read prior to initializing it.  Make sure
> sens_destroy handles that case correctly.
>
> Reported-by: syzbot+6664500f0f18f07a5c0e@syzkaller.appspotmail.com
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/ss/policydb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index a50d625e7946..c1c31e33657a 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -732,7 +732,8 @@ static int sens_destroy(void *key, void *datum, void *p)
>         kfree(key);
>         if (datum) {
>                 levdatum = datum;
> -               ebitmap_destroy(&levdatum->level->cat);
> +               if (levdatum->level)
> +                       ebitmap_destroy(&levdatum->level->cat);
>                 kfree(levdatum->level);
>         }
>         kfree(datum);
> --
> 2.20.1

...

> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches

I'm not sure if this particular bug is one that syzbot can reproduce
(I recall a different message when it had a reproducer), but it would
be nice to get some syzbot test verification if possible when posting
(see the link above for the magic).

Regardless, this looks like a good fix to me; I'm going to merge it
into the stable-5.0 tree and assuming all goes well I'll probably send
it up to Linus early next week.

-- 
paul moore
www.paul-moore.com
