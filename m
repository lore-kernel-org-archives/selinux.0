Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EBDC43387
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 16:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882BF2054F
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 16:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Q9FlzlIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfAIQ3L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:29:11 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:64727 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfAIQ3K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jan 2019 11:29:10 -0500
X-EEMSG-check-017: 674413338|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,458,1539648000"; 
   d="scan'208";a="674413338"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Jan 2019 16:11:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547050294; x=1578586294;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+Y87eDJDdDKa9JdueEOyGYgKec6crt52CbQliuMT/3s=;
  b=Q9FlzlIvWlh+IhbKNicDY9VjYWBUdwRFUhbY3cDaviOPV/4bWvCSA+ou
   ufibiF3Utxdi1zb2CcpqM1gMKxwCWUC7Tp8JoGP76CcPjnnWhyGAY2ppU
   JRB/ClMAlM+kiiMXPdrwmqJfzLFSree3YEAaoOF/iQ1j4wIb+NUr26wUG
   wAJ5Uklmlbmg/9Zi/y16fXJvisEwt+4sIw+CjRdZP783VDKja9Xal1v3C
   n9dtwRLE/cUOAIDfSoN46hqt0UkRrUh8EtphWwoeQPmKSC66Rnwxyc5Q7
   Qcvxza/otqLhW+vKOXvzmpV+b2vDAdoN5052//v4fQH4TIheIgz60qK3Y
   w==;
X-IronPort-AV: E=Sophos;i="5.56,458,1539648000"; 
   d="scan'208";a="19364106"
IronPort-PHdr: =?us-ascii?q?9a23=3AJm8x6BaMzApNPU6vXh8BiLz/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsm7bB7h7PlgxGXEQZ/co6odzbaO4+a4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahYr5+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+t6LplSALziCcfKTE27H3XhMJ3jKJeuh2hphp/yJPQbIyaMPdye6XQct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYMPONUoo/6qFUAohayGQmhCPrzxjJKn3P4w7M10/?=
 =?us-ascii?q?48Gg3C0gEsA84CvHHSod7oNqkdTPq1wbHLwzveb/1Yxznz54rGch89r/6DUr?=
 =?us-ascii?q?1+fNHNyUQtDQ7JkkmcpJbnMj6Ty+8Ds3Kb7+1lVe+3lmAntx9+oiCvxsgyjI?=
 =?us-ascii?q?nCm58bylXe+iV9xIY6O925Q1N8bN6/DZRQrDqXN5d2Q8w+Q2Fovzw2yrsduZ?=
 =?us-ascii?q?GhZiQKx5MnxwDGZvGBboOG7BXjVOOLLjd5gnJoYL2/hxG18US6xe38UtG430?=
 =?us-ascii?q?xSripdidnMrncN1wDJ5sebTft9+0Gs0iuM2QDL8uxIPE85mKXBJ5Mh37I8jI?=
 =?us-ascii?q?QfvEvdEiPshUn7irKdeF8+9eiy8evnZ63rppqbN4BplA7zKr8umsmjAeQgNQ?=
 =?us-ascii?q?gOQnSb9fy81LL9+U35R61HjuEsnanDsZDaON8bqrSlAw5Vzokj6xG/Ay2g0N?=
 =?us-ascii?q?sEhnkIMEhJeBeGj4jtI13OIfb4Aumjg1m0jTtmyP/LMqfhD5nQNHTPjrjsca?=
 =?us-ascii?q?hn50JB0AYzyMpQ55NQCrEPOvLzXUrxucTDDhAkKAy52PrnCdVh2YMeXmKDGK?=
 =?us-ascii?q?mZMLjIvlOS6eIvJPeMaJcPuDnhM/gl++LujXghlF8Gfaio3JgXZ2q8HvRiPU?=
 =?us-ascii?q?qZe2PgjcwcEWcFpQozV+PqiFqFUT5cY3a9Qa085is8CIK7FYfDXZqhj6CG3C?=
 =?us-ascii?q?e+BpdWfHxJCkiQEXf0cIWJQ+wMZzyWIs9glDwESLegRpQ/1RGhqgD60aBrLu?=
 =?us-ascii?q?nK9S0Cs5Lsytx16/fUlREo+jx+F96d3H2VT2FogmMIQCc73Lhhrkxh1FiDy7?=
 =?us-ascii?q?J0jOJeFdNO+fxJSBw1NZnGz+x1EN3yQQXBftGJSVq8XtqmBjQxRMorw9ASe0?=
 =?us-ascii?q?Z9B8mijhfb0iqyGbAViriLCYcs8q3GwnjxI99xy3PB1KkmlVkpXNFDOnGhhq?=
 =?us-ascii?q?567wLTHZLGk12Fl6a2cqQRxCrN9GaFzWqTs0BUSQ1wXrvfXXAZeETWqc/05l?=
 =?us-ascii?q?3NT7CwE7QrKAhBxtCYKqtMdNLpiU9KRPD5ONTRe2ixgXu/BQ6UxrOQa4rnY3?=
 =?us-ascii?q?sS3D3HB0gekgAT5m2LNRAkCSe7omLeFyRuFVb1bEzw7+ZysnS7TlU7zwuSdU?=
 =?us-ascii?q?1uy6K1+gIJhfybU/4TxbIFuSY6pDVzAFax2NPbBtuBqgdufKhQfc8x4Flb2W?=
 =?us-ascii?q?LXqgBwPZKgI7xgi1EEcwl4o1/i2AtsB4VbkckrrXAqwxB2KaKczlxBbSmU0o?=
 =?us-ascii?q?roOr3PMWny5Beva7LT2l7E0daW/r0D5+g/q1Xm70mVER854mdt1MUdh2CN9J?=
 =?us-ascii?q?/NEElMD8ytDx5v+UB0/uHUOnY0uoiM2FV3ILu3uzvG1shvDfM90Q6nY9JWMa?=
 =?us-ascii?q?fCHwj3RYlSCtCnMu0xs0CgdBMfJORb/6NyONmpM7OC2ai2LKNjkSiggGBv/o?=
 =?us-ascii?q?9wyASP+jB6R+qO2IwKh7mA1xaDfy/1kVPkt8fwg40CbjYXWiKnxDTpHshcYK?=
 =?us-ascii?q?F/Z4wME2iGOMqx15N1gJupE2VV8F+lGkMuxsCkY1yRYkb70AkW0l4Y5TS8iD?=
 =?us-ascii?q?m7xjhwnitspLeQxwTBxOPtcBcIIGlWXHIkhlDpcqauiNVPZ1SldwgkklOe4E?=
 =?us-ascii?q?/+w6VK7PBkI3L7XVZDfy+wKXprFKS3qOzRMIZ09Jo0vHAOA6yHaleAR+um/0?=
 =?us-ascii?q?AX?=
X-IPAS-Result: =?us-ascii?q?A2DTEQC+HDZc/wHyM5BjEwEBBgEBAQEDAQEBBwMBAQGBZ?=
 =?us-ascii?q?YFbKWaBAieEAJRQAQEBAQEBBoE1iSyPagNUMAgBhEACgh8iOBIBAwEBAQEBA?=
 =?us-ascii?q?QIBbAMZDIJGAQQBAQEBAwMDAQEMAYJjAQEBAQMjBGILEQMBAgECAiYCAk8IB?=
 =?us-ascii?q?gESgmNAgXQND6s5fDOFQoRvBYELizQXeIEHgRGDEoMeAgIYgRCDQIJXAolCC?=
 =?us-ascii?q?IYmSTdTkCkJhxmKZBiBZIUkBYpqLYk/hQqNOiE1gSErCAIYCCEPgycfgggXg?=
 =?us-ascii?q?0uBaIkJIQMwARcBAWsBAYcCgk0BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Jan 2019 16:11:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x09GBWbk004451;
        Wed, 9 Jan 2019 11:11:32 -0500
Message-ID: <d54c804a5d2dfd560108912094db9967db5a795b.camel@tycho.nsa.gov>
Subject: Re: general protection fault in ebitmap_destroy
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     syzbot <syzbot+6664500f0f18f07a5c0e@syzkaller.appspotmail.com>,
        eparis@parisplace.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, peter.enderborg@sony.com,
        selinux@vger.kernel.org, syzkaller-bugs@googlegroups.com
Date:   Wed, 09 Jan 2019 11:13:40 -0500
In-Reply-To: <0000000000001a9aa0057f084a81@google.com>
References: <0000000000001a9aa0057f084a81@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2019-01-09 at 07:41 -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    a88cc8da0279 Merge branch 'akpm' (patches from
> Andrew)
> git tree:       upstream
> console output: 
> https://syzkaller.appspot.com/x/log.txt?x=1722da4f400000
> kernel config:  
> https://syzkaller.appspot.com/x/.config?x=edf1c3031097c304
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=6664500f0f18f07a5c0e
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      
> https://syzkaller.appspot.com/x/repro.syz?x=12d43580c00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the
> commit:
> Reported-by: syzbot+6664500f0f18f07a5c0e@syzkaller.appspotmail.com
> 
> SELinux: failed to load policy
> sel_write_load: 238 callbacks suppressed
> SELinux: failed to load policy
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 9316 Comm: syz-executor2 Not tainted 5.0.0-rc1+ #16
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS  
> Google 01/01/2011
> RIP: 0010:ebitmap_destroy+0x32/0xf0 security/selinux/ss/ebitmap.c:334
> Code: 49 89 fd 41 54 53 e8 9d e6 36 fe 4d 85 ed 0f 84 99 00 00 00 e8
> 8f e6  
> 36 fe 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02
> 00 0f  
> 85 98 00 00 00 49 be 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffff88808967f5c0 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff88808967f6a8 RCX: dffffc0000000000
> RDX: 0000000000000001 RSI: ffffffff834b1081 RDI: 0000000000000008
> RBP: ffff88808967f5e0 R08: ffff8880972a8140 R09: ffffed1015cc5b90
> R10: ffffed1015cc5b8f R11: ffff8880ae62dc7b R12: ffff888099d993c0
> R13: 0000000000000008 R14: ffff888099d993c0 R15: ffff88808967f648
> FS:  00007f70cd9e5700(0000) GS:ffff8880ae600000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000015e7938 CR3: 0000000096c4a000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   sens_destroy+0x49/0xa0 security/selinux/ss/policydb.c:735
>   sens_read+0x25d/0x460 security/selinux/ss/policydb.c:1636
>   policydb_read+0xed9/0x60d0 security/selinux/ss/policydb.c:2430
>   security_load_policy+0x423/0x1830
> security/selinux/ss/services.c:2129
>   sel_write_load+0x25a/0x470 security/selinux/selinuxfs.c:565
>   __vfs_write+0x116/0xb40 fs/read_write.c:485
>   vfs_write+0x20c/0x580 fs/read_write.c:549
>   ksys_write+0x105/0x260 fs/read_write.c:598
>   __do_sys_write fs/read_write.c:610 [inline]
>   __se_sys_write fs/read_write.c:607 [inline]
>   __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457ec9
> Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
> 89 f7  
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff  
> ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f70cd9e4c78 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
> RDX: 000000000000005c RSI: 0000000020000000 RDI: 0000000000000003
> RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f70cd9e56d4
> R13: 00000000004c720f R14: 00000000004dc9a0 R15: 00000000ffffffff
> Modules linked in:
> ---[ end trace 78ea480790940b53 ]---
> RIP: 0010:ebitmap_destroy+0x32/0xf0 security/selinux/ss/ebitmap.c:334
> Code: 49 89 fd 41 54 53 e8 9d e6 36 fe 4d 85 ed 0f 84 99 00 00 00 e8
> 8f e6  
> 36 fe 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02
> 00 0f  
> 85 98 00 00 00 49 be 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffff88808967f5c0 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff88808967f6a8 RCX: dffffc0000000000
> RDX: 0000000000000001 RSI: ffffffff834b1081 RDI: 0000000000000008
> RBP: ffff88808967f5e0 R08: ffff8880972a8140 R09: ffffed1015cc5b90
> R10: ffffed1015cc5b8f R11: ffff8880ae62dc7b R12: ffff888099d993c0
> R13: 0000000000000008 R14: ffff888099d993c0 R15: ffff88808967f648
> FS:  00007f70cd9e5700(0000) GS:ffff8880ae700000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000073c000 CR3: 0000000096c4a000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Possible fix below

From cc9324299f32db326447a28a836c462fc16bc945 Mon Sep 17 00:00:00 2001
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Wed, 9 Jan 2019 10:55:10 -0500
Subject: [PATCH] selinux: fix GPF on invalid policy

levdatum->level can be NULL if we encounter an error while loading
the policy during sens_read prior to initializing it.  Make sure
sens_destroy handles that case correctly.

Reported-by: syzbot+6664500f0f18f07a5c0e@syzkaller.appspotmail.com
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/ss/policydb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index a50d625e7946..c1c31e33657a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -732,7 +732,8 @@ static int sens_destroy(void *key, void *datum, void *p)
 	kfree(key);
 	if (datum) {
 		levdatum = datum;
-		ebitmap_destroy(&levdatum->level->cat);
+		if (levdatum->level)
+			ebitmap_destroy(&levdatum->level->cat);
 		kfree(levdatum->level);
 	}
 	kfree(datum);
-- 
2.20.1

> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate
> with  
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

