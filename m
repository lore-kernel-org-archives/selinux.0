Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68580C35242
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 21:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E0420838
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 21:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mRCFPvlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgAXVuD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:50:03 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:37014
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbgAXVuD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 16:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579902601; bh=OVi1PEOlMpxn61S7uOSyVC5bqA+UfIUzHtxxqfC3oxM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=mRCFPvlkwz1w0C9cLhwKau+SFxj02oI2UloYpByNmo6lnx2d5IAm6yd9aiqS0n0eknYJItcmTmFwWWSWPxBX+q5PeVC59GQATicJCJAiNiWfjNphISW95A4ZcZwUlvWaMv9U/OR0AOvvLVzxVjGZDzv4gURHHXqrtgHyZ+7sZ1vYk2auzLr42fq3VMEG7ZFk3pBiX+G8mPcI4RTirl9u/Sc+b9LEEl+lRre8ZYi6MoTN1W8uPRUO6dplEs81uNGQS8prP5SoCNSRA2kt9tj8VkYZJW3USMVO95wXmkpDlGSQGtaCMVDkbe8dsX1XGR0i9Ve6sld4HmXyNZUSEm6BPQ==
X-YMail-OSG: 8hlizQsVM1k9vQT7dtmM20fFWNFJrtndJyyf83MzzgVeWCFtnx7AWKvBTgEHe3M
 p4Fr1E0xEG3Qq8x2FuXc1mQ6lzDlIx.fB.P55q3g80r4WnS4SC_9jjFFRwQ7U4lzP2vsdIInOFac
 UCsI2EH159avM.IF_1r6Ff9jHcm97F7hvsxlN3y2ANWHyKsQwHixtnGLJBH0tfaGlUNX2kcq6ZYG
 TOuXhCnxzQnh82FqYT7W8e_wIklPCXxtFPaCivFJ0Juu.YqXfUCAwwMWDViWR2QFePxTzMd852lO
 5lqY3lNy8DqYcqp.ezU.V_xviJFozFBVVxE8idFM2XBQ.jr7dsEeabgRWq2BdqYKBdNZfMgXQrd4
 GLx9ZgjfR96vWaIAZH7OIfJKCfiJVjznGxBpanMYVmYuaAQVKSOFqRYDVHO625oeyUQCdw_Cjx7s
 tgFdqQ3dj3Yh8fki.hmnivl5RbOFkhpc4Fjdv3UMNgdk4SVO08TJaY3.0hsB4SwKb52iRs89eJqa
 tDzTLkoBiGVlVmvReNzjppPNKNu0j4x3i.d9xAeEQH_H0u790azock_QwI9q8B0wvj.4yhhWzdLs
 OPnMlf7pGDphbwKz7oOlgdTi71ryBiiiRqvcBV4V9ljaITaL7wpFC.B9PwCypRxTEKF7T.n3bcLE
 W4dePy2m5Kx5SvQ6pcMfyrMW0bx7ZMOWF9gCrk.uZHJVGBFGuvdebIaABKNE4.J_sBSzfj8FLKBx
 _Amt2H5lYEKLZBa8.cboGr1xNagkRvShPbHOAalhVxqqRhNRi2M_5zAEOrep9b_Q14eQPqMhTX6I
 YpnXdCrAhXbNUzoKms3JntLiu9DHUg1M_UxLT2FbbmGnpMBnTjyyeO7Iq7IJlzkVr.0JT5ab4As7
 BrpS.MnB_OBeaK.2nOYLi.6CaeubrtXMy30mPdZj1HPpA0v0lmfj5Y3jSLsSAmcSLDPohvHPJqO2
 xNO8OK2E2bUQwOwcE5CfhQbQtLxLXd5ac4CUQRpCJYa6Kh7wmmlZqkESWEw5lLLupkwgPBX9nJAR
 N8dOUZXOtvRKc4mv.P1tsJI7p3q3ijX7LdOutpOIpM205qMTdWVwSYy1pux.we95.ZlGNOPHW_T4
 VKaHZ1N5T7CMsgPASxDZDnQK3nGb_c0ObAiBbRJ1Z4zY70LnGvgDQtKFaVE1fhxzFeyYr9joKUDp
 UIKeiehkkrH5zuYvGG9vS1VTu3HNiIeejJxU7l9l7EVnmfkOonXR2BCj.vVTyvQP3uY_kV16nEpg
 vt2G_KvXsog26R4uy2CJ0wNjogBjQverSh5UUsgIxspHGW51jRlNxdE1s0LGO5zhjEvihwFQm0nj
 9a82GkVjr8vPGALxK_ZqoeRcJS_U9Lg5EJOoBpb.jzbQ_0vsjIExjs7_MN_rrm9fu6lsDCY9AsTL
 JXp9jsoqI8u5GF430A4ge4_JfIijVp8wS2NYE3IE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Jan 2020 21:50:01 +0000
Received: by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d1abfe75034c326afd9c41cd6d2b08df;
          Fri, 24 Jan 2020 21:49:56 +0000 (UTC)
Subject: Re: [PATCH v14 00/23] LSM: Module stacking for AppArmor
To:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey.ref@schaufler-ca.com>
 <20200124002306.3552-1-casey@schaufler-ca.com>
 <22585291-b7e0-5a22-6682-168611d902fa@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <6b717a13-3586-5854-0eee-617798f92d34@schaufler-ca.com>
Date:   Fri, 24 Jan 2020 13:49:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <22585291-b7e0-5a22-6682-168611d902fa@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.15116 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/24/2020 1:04 PM, Stephen Smalley wrote:
> On 1/23/20 7:22 PM, Casey Schaufler wrote:
>> This patchset provides the changes required for
>> the AppArmor security module to stack safely with any other.
>>
>> v14: Rebase to 5.5-rc5
>>       Incorporate feedback from v13
>>       - Use an array of audit rules (patch 0002)
>>       - Significant change, removed Acks (patch 0002)
>>       - Remove unneeded include (patch 0013)
>>       - Use context.len correctly (patch 0015)
>>       - Reorder code to be more sensible (patch 0016)
>>       - Drop SO_PEERCONTEXT as it's not needed yet (patch 0023)
>
> I don't know for sure if this is your bug, but it happens every time I boot with your patches applied and not at all on stock v5.5-rc5 so here it is.  Will try to bisect as time permits but not until next week. Trigger seems to be loading the tun driver.

Thanks. I will have a look as well.

>
> [   67.726834] tun: Universal TUN/TAP device driver, 1.6
> [   67.736657] ==================================================================
> [   67.741335] BUG: KASAN: slab-out-of-bounds in sock_init_data+0x14a/0x5a0
> [   67.745037] Read of size 4 at addr ffff88870afe8928 by task libvirtd/1238
>
> [   67.751861] CPU: 4 PID: 1238 Comm: libvirtd Tainted: G T 5.5.0-rc5+ #54
> [   67.756250] Call Trace:
> [   67.759510]  dump_stack+0xb8/0x110
> [   67.761604]  print_address_description.constprop.0+0x1f/0x280
> [   67.763768]  __kasan_report.cold+0x75/0x8f
> [   67.765895]  ? sock_init_data+0x14a/0x5a0
> [   67.768282]  kasan_report+0xe/0x20
> [   67.770397]  sock_init_data+0x14a/0x5a0
> [   67.772511]  tun_chr_open+0x1de/0x280 [tun]
> [   67.774644]  misc_open+0x1cb/0x210
> [   67.776820]  chrdev_open+0x15b/0x350
> [   67.778917]  ? cdev_put.part.0+0x30/0x30
> [   67.781030]  do_dentry_open+0x2cb/0x800
> [   67.783135]  ? cdev_put.part.0+0x30/0x30
> [   67.785225]  ? devcgroup_check_permission+0x11a/0x260
> [   67.787321]  ? __x64_sys_fchdir+0xf0/0xf0
> [   67.789418]  ? security_inode_permission+0x5b/0x70
> [   67.791513]  path_openat+0x858/0x14a0
> [   67.793589]  ? path_mountpoint+0x5e0/0x5e0
> [   67.795719]  ? mark_lock+0xb8/0xb00
> [   67.797786]  do_filp_open+0x11e/0x1b0
> [   67.799840]  ? may_open_dev+0x60/0x60
> [   67.801871]  ? match_held_lock+0x1b/0x240
> [   67.803968]  ? lock_downgrade+0x360/0x360
> [   67.805997]  ? do_raw_spin_lock+0x119/0x1d0
> [   67.808041]  ? rwlock_bug.part.0+0x60/0x60
> [   67.810099]  ? do_raw_spin_unlock+0xa3/0x130
> [   67.812244]  ? _raw_spin_unlock+0x1f/0x30
> [   67.814287]  ? __alloc_fd+0x143/0x2f0
> [   67.816324]  do_sys_open+0x1f0/0x2d0
> [   67.818358]  ? filp_open+0x50/0x50
> [   67.820404]  ? trace_hardirqs_on_thunk+0x1a/0x1c
> [   67.822447]  ? lockdep_hardirqs_off+0xbe/0x100
> [   67.824473]  ? mark_held_locks+0x24/0x90
> [   67.826484]  do_syscall_64+0x74/0xd0
> [   67.828480]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   67.830478] RIP: 0033:0x7f1a2cce6074
> [   67.832495] Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 86 f4 ff ff 44 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 32 44 89 c7 89 44 24 0c e8 b8 f4 ff ff 8b 44
> [   67.834760] RSP: 002b:00007f19e4af46d0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> [   67.837032] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1a2cce6074
> [   67.839318] RDX: 0000000000000002 RSI: 00007f1a2d0bfb67 RDI: 00000000ffffff9c
> [   67.841598] RBP: 00007f1a2d0bfb67 R08: 0000000000000000 R09: 00007f19e4af4914
> [   67.843941] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000002
> [   67.846283] R13: 000000000000000d R14: 00007f19e4af4920 R15: 00007f1a2d0bfb67
>
> [   67.850936] Allocated by task 1238:
> [   67.853241]  save_stack+0x1b/0x80
> [   67.855533]  __kasan_kmalloc.constprop.0+0xc2/0xd0
> [   67.857935]  sk_prot_alloc+0x115/0x170
> [   67.860235]  sk_alloc+0x2f/0xa10
> [   67.862541]  tun_chr_open+0x4d/0x280 [tun]
> [   67.864894]  misc_open+0x1cb/0x210
> [   67.867164]  chrdev_open+0x15b/0x350
> [   67.869448]  do_dentry_open+0x2cb/0x800
> [   67.871768]  path_openat+0x858/0x14a0
> [   67.874041]  do_filp_open+0x11e/0x1b0
> [   67.876328]  do_sys_open+0x1f0/0x2d0
> [   67.878592]  do_syscall_64+0x74/0xd0
> [   67.880899]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> [   67.885431] Freed by task 726:
> [   67.887689]  save_stack+0x1b/0x80
> [   67.889967]  __kasan_slab_free+0x12c/0x170
> [   67.892197]  kfree+0xff/0x430
> [   67.894444]  uevent_show+0x176/0x1b0
> [   67.896709]  dev_attr_show+0x37/0x70
> [   67.898940]  sysfs_kf_seq_show+0x119/0x210
> [   67.901159]  seq_read+0x29d/0x720
> [   67.903367]  vfs_read+0xf9/0x1f0
> [   67.905538]  ksys_read+0xc9/0x160
> [   67.907736]  do_syscall_64+0x74/0xd0
> [   67.909889]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> [   67.914100] The buggy address belongs to the object at ffff88870afe8000
>                 which belongs to the cache kmalloc-4k of size 4096
> [   67.918357] The buggy address is located 2344 bytes inside of
>                 4096-byte region [ffff88870afe8000, ffff88870afe9000)
> [   67.922562] The buggy address belongs to the page:
> [   67.924725] page:ffffea001c2bfa00 refcount:1 mapcount:0 mapping:ffff88881f00de00 index:0x0 compound_mapcount: 0
> [   67.926926] raw: 0017ffe000010200 ffffea001c167a00 0000000200000002 ffff88881f00de00
> [   67.929144] raw: 0000000000000000 0000000080040004 00000001ffffffff 0000000000000000
> [   67.931362] page dumped because: kasan: bad access detected
>
> [   67.936192] Memory state around the buggy address:
> [   67.938438]  ffff88870afe8800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   67.941078]  ffff88870afe8880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   67.943393] >ffff88870afe8900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   67.945709]                                   ^
> [   67.948000]  ffff88870afe8980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   67.950311]  ffff88870afe8a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   67.952629] ==================================================================
