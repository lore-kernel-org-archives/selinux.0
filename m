Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF89C2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 21:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25B92071E
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 21:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="bqhQja2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbgAXVEM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:04:12 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:9261 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387394AbgAXVEM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 16:04:12 -0500
X-EEMSG-check-017: 49550230|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="49550230"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2020 21:04:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579899841; x=1611435841;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1PZVI6hDojCjpKHvSvY09nmUBqP/et6mD+e+ZXdeYwE=;
  b=bqhQja2znt18thjbXQjKChTGIW9C/3ye2otWbKOheC82ZOYJG8CIVbze
   YE0jg65VSyk2k3FuwpxzO1PhUGZP4vud/N7FmbSeoA5AgKuCazhQjJwED
   nsw3IKOZ4TtBEY3oRRmlw2fH3ObEsmFTRBI0SeTP3mINDDoX1Gea8IfNy
   Pv5kHz8eDFkAlPOBSXbUqTdJB5SVSa/fQSvyngspgBqwSehmPPQvLH2KU
   KD4mU7xtSw4Mxv9Dw/znp73jMfTIgcsRO4lc5I/UpVNY3t1vfbGEyLYt8
   gLri8dkl8f7msBvDdCos/QATomJVF063Tqq4h/bs6+rW2xeIb6ymBMI3q
   w==;
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="32319189"
IronPort-PHdr: =?us-ascii?q?9a23=3A4MEskR/cL+KTLP9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1uoSIJqq85mqBkHD//Il1AaPAdyHragZwLKH++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMn4dvKqk9xg?=
 =?us-ascii?q?fNr3BVf+ha2X5kKUickhrh6Mq85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y7jQds0GS2?=
 =?us-ascii?q?VfQslRVjRBAoKiYIsJE+oBJvtTo43kq1cTsReyGQygCeXhxT9Sgn/9wLM03e?=
 =?us-ascii?q?IvHwrb2AAsBtIDvXDRoNjzKawcU/26zLPQwDvecf1W1zfz5ovGfB8vrv6DX6?=
 =?us-ascii?q?5/f8XKxEkzFQ7IlEmcpZDrMj6X0OkGrmiV7/BnVeKqk2Mpth1xrSa3xscslI?=
 =?us-ascii?q?bJgJ8exE3B9SpjxIY1IcO3SU5matOjC5tfqjqaOpBqQsIiX25ouCE6xqcAuZ?=
 =?us-ascii?q?6gZicG0psnxxnBa/GedYWD/xHtVP6JLDtli39od6izihav/US61OHxWde43E?=
 =?us-ascii?q?xXoidDj9LCrGoC1wbJ5ciCUvZ9+0Ch1iuR2A3L8eFEJFw0lbLcK5483r48jp?=
 =?us-ascii?q?oTvlrHHi/xgEj2kLWZdl8l+ui18OTreLTmppmSN49zkQHxLLghltajAeU4Lg?=
 =?us-ascii?q?cOX2+b9f661LL/5k32XK9Gjvg3kqndqJzaJMIbqbClAwJNz4ou5BmyAy2m3d?=
 =?us-ascii?q?gFh3ULMl1IdAydg4T0I13OJer3Dfa7g1SiijdrwPXGM6X6AprQNXjOi6vhfL?=
 =?us-ascii?q?Zh5E5czwo/19Zf54lOBb0bL/LzXVHxuMTCDhAlKwy03/rnCNJl24wCQ22PGb?=
 =?us-ascii?q?GWMaPJvF+T+u0vI/ODZJIbuDb5Nfcl/efigmMjllMHYaap2p4XYmiiHvt6O0?=
 =?us-ascii?q?WZfWbsgtAZHGgWpAU+V/LliV2YXT5Ie3myX7gz5iw1CIKiE4jDXJuggL2H3C?=
 =?us-ascii?q?enAJJWYnpKBUyLEXftb4+EQesDaDqOIs99lTwJTbqhS4om1RG0rg/6yqFnI/?=
 =?us-ascii?q?HS+iICsJLsytl16/fUlREo+jx+F96d3H2VT2FogmMIQCc73KR+oUx711eC3r?=
 =?us-ascii?q?F0g+dGGtNP+vNJSAY6NYLczuBjDtDyXR/OfsqNSFm4WdimHz4xQcwrw9MUYE?=
 =?us-ascii?q?ZyBc+ijhbd0CquGbMVkKaLBJMs+KLGw3fxP9p9y2rB1KQ5lFkpXM9PNWyghq?=
 =?us-ascii?q?5i+AneHJDJk0qHmKawb6gc3zDC9H2FzWWQuEFUSglwUb/KXXoHfEvZscz55l?=
 =?us-ascii?q?/eT7+pEbknMRVOxtCZKqRWbd3pilZGSez/N9TeeWKxnGKwBReVxrOJdobqfH?=
 =?us-ascii?q?8d3CrFAkgejw8T5WqGNRQ5Biq5oWLeCzxuFVT1b0Pu9ul+qGm0Tkkvzw6UaU?=
 =?us-ascii?q?1szKa69QQThfybTfMT364Ltz0lqzluAFm92NfWAcKapwV9ZKVcfc894FBf2G?=
 =?us-ascii?q?LBqQN9OJOgL71jhl4Yagh3vF3h1w9xCopelcgnt3IqwBN2KaKfzlNOaSmU3Y?=
 =?us-ascii?q?vqNb3UN2ny5gqgZ7TQ2l7AytqW+L8P4uwiq1r/pAGpClYi83J/3tlNyXSc+5?=
 =?us-ascii?q?HKAREKUZ3rT0Y38wF2p7TdYik6/YPby2dgPrWzsj/HiJoVA74Oww2tbp9kO6?=
 =?us-ascii?q?ONCQH2HtdSU8OnM+E7s0OibhsZMuRf7us/NoWtcP7QnOagNf1tjXS9hmRO/Y?=
 =?us-ascii?q?5531ik9ixgR+qO1JEAh7ma2wydTTbnpFGot83234deanVaGmu51DihH4Nae7?=
 =?us-ascii?q?dzYZdODGCiPsm67stxioSrWHNC8lOnQVQc14vhYheWblrgzSVO2kkN53+qgy?=
 =?us-ascii?q?21y3pziT56gLCY2Xn13+n6dBcBclVOTW1mgEakdZO4lPgGTUOoaE4vjxLj6k?=
 =?us-ascii?q?HkkfsI7J9jJnXeFB8bNxP9KHtvB+7p6+uP?=
X-IPAS-Result: =?us-ascii?q?A2BIAAB8Wite/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWkFA?=
 =?us-ascii?q?QELAYF3BYFtIBKEPIkDhnkGgRIliW+PThSBZwkBAQEBAQEBAQE3AQGEQAKCR?=
 =?us-ascii?q?jYHDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIxVBEAsYAgImAgJXBgEMC?=
 =?us-ascii?q?AEBgmM/glclrXKBMoVKgzmBPoEOKgGMMHmBB4E4DAOCKDU+hDEYgxCCXgSXN?=
 =?us-ascii?q?EaXXoJDgkyTZQYCGYJIjE+LZY5gnQ4JKYFYKwgCGAghD4MoTxgNgm2FHQMXj?=
 =?us-ascii?q?kEjA44GAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 24 Jan 2020 21:04:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00OL39YR168374;
        Fri, 24 Jan 2020 16:03:14 -0500
Subject: Re: [PATCH v14 00/23] LSM: Module stacking for AppArmor
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey.ref@schaufler-ca.com>
 <20200124002306.3552-1-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <22585291-b7e0-5a22-6682-168611d902fa@tycho.nsa.gov>
Date:   Fri, 24 Jan 2020 16:04:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124002306.3552-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/23/20 7:22 PM, Casey Schaufler wrote:
> This patchset provides the changes required for
> the AppArmor security module to stack safely with any other.
> 
> v14: Rebase to 5.5-rc5
>       Incorporate feedback from v13
>       - Use an array of audit rules (patch 0002)
>       - Significant change, removed Acks (patch 0002)
>       - Remove unneeded include (patch 0013)
>       - Use context.len correctly (patch 0015)
>       - Reorder code to be more sensible (patch 0016)
>       - Drop SO_PEERCONTEXT as it's not needed yet (patch 0023)

I don't know for sure if this is your bug, but it happens every time I 
boot with your patches applied and not at all on stock v5.5-rc5 so here 
it is.  Will try to bisect as time permits but not until next week. 
Trigger seems to be loading the tun driver.

[   67.726834] tun: Universal TUN/TAP device driver, 1.6
[   67.736657] 
==================================================================
[   67.741335] BUG: KASAN: slab-out-of-bounds in sock_init_data+0x14a/0x5a0
[   67.745037] Read of size 4 at addr ffff88870afe8928 by task libvirtd/1238

[   67.751861] CPU: 4 PID: 1238 Comm: libvirtd Tainted: G 
T 5.5.0-rc5+ #54
[   67.756250] Call Trace:
[   67.759510]  dump_stack+0xb8/0x110
[   67.761604]  print_address_description.constprop.0+0x1f/0x280
[   67.763768]  __kasan_report.cold+0x75/0x8f
[   67.765895]  ? sock_init_data+0x14a/0x5a0
[   67.768282]  kasan_report+0xe/0x20
[   67.770397]  sock_init_data+0x14a/0x5a0
[   67.772511]  tun_chr_open+0x1de/0x280 [tun]
[   67.774644]  misc_open+0x1cb/0x210
[   67.776820]  chrdev_open+0x15b/0x350
[   67.778917]  ? cdev_put.part.0+0x30/0x30
[   67.781030]  do_dentry_open+0x2cb/0x800
[   67.783135]  ? cdev_put.part.0+0x30/0x30
[   67.785225]  ? devcgroup_check_permission+0x11a/0x260
[   67.787321]  ? __x64_sys_fchdir+0xf0/0xf0
[   67.789418]  ? security_inode_permission+0x5b/0x70
[   67.791513]  path_openat+0x858/0x14a0
[   67.793589]  ? path_mountpoint+0x5e0/0x5e0
[   67.795719]  ? mark_lock+0xb8/0xb00
[   67.797786]  do_filp_open+0x11e/0x1b0
[   67.799840]  ? may_open_dev+0x60/0x60
[   67.801871]  ? match_held_lock+0x1b/0x240
[   67.803968]  ? lock_downgrade+0x360/0x360
[   67.805997]  ? do_raw_spin_lock+0x119/0x1d0
[   67.808041]  ? rwlock_bug.part.0+0x60/0x60
[   67.810099]  ? do_raw_spin_unlock+0xa3/0x130
[   67.812244]  ? _raw_spin_unlock+0x1f/0x30
[   67.814287]  ? __alloc_fd+0x143/0x2f0
[   67.816324]  do_sys_open+0x1f0/0x2d0
[   67.818358]  ? filp_open+0x50/0x50
[   67.820404]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   67.822447]  ? lockdep_hardirqs_off+0xbe/0x100
[   67.824473]  ? mark_held_locks+0x24/0x90
[   67.826484]  do_syscall_64+0x74/0xd0
[   67.828480]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   67.830478] RIP: 0033:0x7f1a2cce6074
[   67.832495] Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 86 f4 ff ff 44 
8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 32 44 89 c7 89 44 24 0c e8 b8 f4 ff ff 8b 44
[   67.834760] RSP: 002b:00007f19e4af46d0 EFLAGS: 00000293 ORIG_RAX: 
0000000000000101
[   67.837032] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f1a2cce6074
[   67.839318] RDX: 0000000000000002 RSI: 00007f1a2d0bfb67 RDI: 
00000000ffffff9c
[   67.841598] RBP: 00007f1a2d0bfb67 R08: 0000000000000000 R09: 
00007f19e4af4914
[   67.843941] R10: 0000000000000000 R11: 0000000000000293 R12: 
0000000000000002
[   67.846283] R13: 000000000000000d R14: 00007f19e4af4920 R15: 
00007f1a2d0bfb67

[   67.850936] Allocated by task 1238:
[   67.853241]  save_stack+0x1b/0x80
[   67.855533]  __kasan_kmalloc.constprop.0+0xc2/0xd0
[   67.857935]  sk_prot_alloc+0x115/0x170
[   67.860235]  sk_alloc+0x2f/0xa10
[   67.862541]  tun_chr_open+0x4d/0x280 [tun]
[   67.864894]  misc_open+0x1cb/0x210
[   67.867164]  chrdev_open+0x15b/0x350
[   67.869448]  do_dentry_open+0x2cb/0x800
[   67.871768]  path_openat+0x858/0x14a0
[   67.874041]  do_filp_open+0x11e/0x1b0
[   67.876328]  do_sys_open+0x1f0/0x2d0
[   67.878592]  do_syscall_64+0x74/0xd0
[   67.880899]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[   67.885431] Freed by task 726:
[   67.887689]  save_stack+0x1b/0x80
[   67.889967]  __kasan_slab_free+0x12c/0x170
[   67.892197]  kfree+0xff/0x430
[   67.894444]  uevent_show+0x176/0x1b0
[   67.896709]  dev_attr_show+0x37/0x70
[   67.898940]  sysfs_kf_seq_show+0x119/0x210
[   67.901159]  seq_read+0x29d/0x720
[   67.903367]  vfs_read+0xf9/0x1f0
[   67.905538]  ksys_read+0xc9/0x160
[   67.907736]  do_syscall_64+0x74/0xd0
[   67.909889]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[   67.914100] The buggy address belongs to the object at ffff88870afe8000
                 which belongs to the cache kmalloc-4k of size 4096
[   67.918357] The buggy address is located 2344 bytes inside of
                 4096-byte region [ffff88870afe8000, ffff88870afe9000)
[   67.922562] The buggy address belongs to the page:
[   67.924725] page:ffffea001c2bfa00 refcount:1 mapcount:0 
mapping:ffff88881f00de00 index:0x0 compound_mapcount: 0
[   67.926926] raw: 0017ffe000010200 ffffea001c167a00 0000000200000002 
ffff88881f00de00
[   67.929144] raw: 0000000000000000 0000000080040004 00000001ffffffff 
0000000000000000
[   67.931362] page dumped because: kasan: bad access detected

[   67.936192] Memory state around the buggy address:
[   67.938438]  ffff88870afe8800: 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00
[   67.941078]  ffff88870afe8880: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   67.943393] >ffff88870afe8900: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   67.945709]                                   ^
[   67.948000]  ffff88870afe8980: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   67.950311]  ffff88870afe8a00: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   67.952629] 
==================================================================
