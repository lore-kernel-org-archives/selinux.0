Return-Path: <SRS0=e1+f=3Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D33C2D0DB
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 16:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E2C2087F
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 16:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="c4XKGE7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgA0QNu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:13:50 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:29228 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbgA0QNu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jan 2020 11:13:50 -0500
X-EEMSG-check-017: 50165825|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,370,1574121600"; 
   d="scan'208";a="50165825"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Jan 2020 16:13:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580141626; x=1611677626;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=stMCwuHu8fbCzctAYsF9viJ6oAnD9Y/nYMtrWOWODEY=;
  b=c4XKGE7/M9/pKlYow3WJr/gxucJjzSd3HFlInVZAVmUyl1m7+3bOBaUa
   mzILZ8KQXS+lVZ/1XDn9YJvzlL7+5tgbu2+NXo2NF1BllsibpXK5qd/C0
   v7WRfymhBNh1YO8kkC4cw3F3ptao/iX8sJc+q5tIvh3yy7qQwR2caYXzT
   tNRJtCijgE/7y7hDimwaDRkYEO7m6LpdX/SIzn/guZpxAJUwctVWzNUXJ
   Q1OK0sN5WmGefqwoKCU/keWoPIungIJ6mrKwmQflzKubDIhYX8vyl8gOi
   pgbG8Tr4B5RV7QvdtdowHhmjpoC/VakSoDefls86yWGHX+0G6a+u6uE4v
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,370,1574121600"; 
   d="scan'208";a="38287320"
IronPort-PHdr: =?us-ascii?q?9a23=3AqKLDfBOdHruKy1Rly0Ul6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/n7o8bcNUDSrc9gkEXOFd2Cra4d16yN6euwAyRAuc/H7ClZNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULjoZuMKg8xg?=
 =?us-ascii?q?XGrnZLZehd2GdkKU6Okxrm6cq84ZBu/z5Mt/498sJLTLn3cbk/QbFEFjotLn?=
 =?us-ascii?q?o75NfstRnNTAuP4mUTX2ALmRdWAAbL8Q/3UI7pviT1quRy1i+aPdbrTb8vQj?=
 =?us-ascii?q?St871rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4BSG?=
 =?us-ascii?q?FfQsheSTBOAoKkb4sOEeUBO/pYr5LgrFcKtBeyGBWgCP/qxjJOiHD2x6k62P?=
 =?us-ascii?q?k/Hw/A0gIrAtYCvG3UodjxMasfV/2+wqvVwjXZd/5YxCnz6IbIfB4ir/+DU7?=
 =?us-ascii?q?1/fsjNxkcgDA7FkladpJb5Mz+J2OkAsW6W5PdgW+K1jG4nrhl8rCWzxsgyko?=
 =?us-ascii?q?nJhpwaylbZ/itkxYY6P9m4SEplbt+kDZBdsDqaOJZtQs45X2FpuDo1yr0BuZ?=
 =?us-ascii?q?KheigK044oywTQa/yAbYiF+xTuX/uSLzdgnH9pZb2yihmo/UWg1+HwTNe43V?=
 =?us-ascii?q?lUoiZfj9XBsG0G2QbJ5cidUPR9+1+s2TOI1w/O9O5JOVs0la/HK545xb4wi4?=
 =?us-ascii?q?YTvVzDHiDonEX2i7ebdlk+9eiy6uTnf67mqoWdN49yhAH+Nb8uldKjDugiLg?=
 =?us-ascii?q?gPX3SU+eS71LH5+032XK5KgeEsnqncsZDaIdwXpq+/AwBLzoYu8wuzAjip3d?=
 =?us-ascii?q?gCnXQLMUhJdAyIgoT3IV3CPej0DfKljFStlDdryerGPrrkApjVNXjMjazhcK?=
 =?us-ascii?q?1h609c1AUzzddf64hSCrEaOv3/QEDxtNvGDhMhKQy73/7nCMlh1oMZQW+AHr?=
 =?us-ascii?q?WWMLjMvl6I/e8vOPWDZI8PtzbgJfgl4+DhjWUglVABZ6alx4cYaHe9Hv5+OU?=
 =?us-ascii?q?WWfWLsgssdEWcNpgcxUPbliEacXj9TfXqyRL4z5jEhB4K7A4fDQp6igKaa0S?=
 =?us-ascii?q?e6GJ1Wen5JClSWHXj0cIWEXu8GaDiOLc95jjwESb+hRpcj1RGrsw/60aBnLu?=
 =?us-ascii?q?vP+iADs5Lszt116PPSlR0o8jx0Fcud2XmXT25ohmMIWyM23KdnrEx5y1eD17?=
 =?us-ascii?q?V4gvNBGdxI+fxGTho6NYTdz+xmC9H+QwfBftCUR1a7RtWpHyo8Tsw+w9AQeU?=
 =?us-ascii?q?ZxAdaigQ7Z3yqsHbAVk6aHBJsu8qLTx3LxPdpyy27a1Kk9iFkrWtBPOnOihq?=
 =?us-ascii?q?5+8QjTGoHInl6Hl6ala6scxjTB9GSdwmqUukFXTgpwXb/CXXAFaUvctc756V?=
 =?us-ascii?q?/aT7+yFbQnNRNMyc2cJaRUcd3mkVJGRPDgONnFf22xm32wBRGNxrONcYrqfn?=
 =?us-ascii?q?8R3CLHCEgLiwoT52qJNRAiBie9pGLTFD5uFVXvY0Pq6+V+qnS7Tk8uwAGMdE?=
 =?us-ascii?q?1uyby19wUJivOGTfMT2bQEuCY9pDpuGFaxxc7ZC92FpwB5ZqVTfcs94Etb1W?=
 =?us-ascii?q?LerwF9JoKvL6Zthl4DcgR3uVri1xZpBYVal8glsncqwRFzKa6B1FNBcC2Y0o?=
 =?us-ascii?q?7qNr3MMGby/w2va7TM1V3E1taZ5L0D6PYgq1/7pgGmClIi82l709lSy3ac/o?=
 =?us-ascii?q?/FDBcWUZ/qSkY47QV6p7XDbik44IPU0mdsPreuvjDe3NIpAbht9hH1VN5EPb?=
 =?us-ascii?q?LMLwTyGtAUA8W0YLghkkOkfzofN+Bb6aAwMtnjfPLA06muaqIolzu9gHUB+4?=
 =?us-ascii?q?t921+C8ydmYu/Ow5sBhfqf20/PVTL7lk2gqejxkIVJZHcVBGX7gSzlApNBI7?=
 =?us-ascii?q?Z/dpsRCHu/Zsiwysh6irbzVHNCsl2uHVUL3ImuYxXWJ0fw2QxWyFQ/v3Oqg2?=
 =?us-ascii?q?27wiZynjVvqbCQjwLUxOG3TwYKIm5GQiFZiF7oJYWlx4QBUFOAcxkilBzj41?=
 =?us-ascii?q?3zgadcuvIsfCHoXU5Ucn2ufClZWayqu+/HOpMe5Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ANAAAVCy9e/wHyM5BmGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBZwYBAQELAYF3BYFsIRKEPogjYIZ2AQEBAQEBBoE3iW+PThSBZwkBAQEBA?=
 =?us-ascii?q?QEBAQE3AQGEQAKCSDQJDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIw8BB?=
 =?us-ascii?q?UEQCQIYAgImAgJXBgEMCAEBgmM/glclkDibd4EyhUqDP4E+gQ4qAYw3eYEHg?=
 =?us-ascii?q?TgPgig1PoQxGIMQgl4El3qXXoJDgkyTZQYbgkiMT4tljmCdBzmBWCsIAhgII?=
 =?us-ascii?q?Q+DKE8YDYYmjU8DF45BIwOOPAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Jan 2020 16:13:44 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00RGCqX3268035;
        Mon, 27 Jan 2020 11:12:53 -0500
Subject: Re: [PATCH v14 00/23] LSM: Module stacking for AppArmor
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey.ref@schaufler-ca.com>
 <20200124002306.3552-1-casey@schaufler-ca.com>
 <22585291-b7e0-5a22-6682-168611d902fa@tycho.nsa.gov>
 <6b717a13-3586-5854-0eee-617798f92d34@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <de97dc66-7f5b-21f0-cf3d-a1485acbc1c9@tycho.nsa.gov>
Date:   Mon, 27 Jan 2020 11:14:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6b717a13-3586-5854-0eee-617798f92d34@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/24/20 4:49 PM, Casey Schaufler wrote:
> On 1/24/2020 1:04 PM, Stephen Smalley wrote:
>> On 1/23/20 7:22 PM, Casey Schaufler wrote:
>>> This patchset provides the changes required for
>>> the AppArmor security module to stack safely with any other.
>>>
>>> v14: Rebase to 5.5-rc5
>>>        Incorporate feedback from v13
>>>        - Use an array of audit rules (patch 0002)
>>>        - Significant change, removed Acks (patch 0002)
>>>        - Remove unneeded include (patch 0013)
>>>        - Use context.len correctly (patch 0015)
>>>        - Reorder code to be more sensible (patch 0016)
>>>        - Drop SO_PEERCONTEXT as it's not needed yet (patch 0023)
>>
>> I don't know for sure if this is your bug, but it happens every time I boot with your patches applied and not at all on stock v5.5-rc5 so here it is.  Will try to bisect as time permits but not until next week. Trigger seems to be loading the tun driver.
> 
> Thanks. I will have a look as well.

Bisection led to the first patch in the series, "LSM: Infrastructure 
management of the sock security". Still not sure if the bug is in the 
patch itself or just being surfaced by it.

>>
>> [   67.726834] tun: Universal TUN/TAP device driver, 1.6
>> [   67.736657] ==================================================================
>> [   67.741335] BUG: KASAN: slab-out-of-bounds in sock_init_data+0x14a/0x5a0
>> [   67.745037] Read of size 4 at addr ffff88870afe8928 by task libvirtd/1238
>>
>> [   67.751861] CPU: 4 PID: 1238 Comm: libvirtd Tainted: G T 5.5.0-rc5+ #54
>> [   67.756250] Call Trace:
>> [   67.759510]  dump_stack+0xb8/0x110
>> [   67.761604]  print_address_description.constprop.0+0x1f/0x280
>> [   67.763768]  __kasan_report.cold+0x75/0x8f
>> [   67.765895]  ? sock_init_data+0x14a/0x5a0
>> [   67.768282]  kasan_report+0xe/0x20
>> [   67.770397]  sock_init_data+0x14a/0x5a0
>> [   67.772511]  tun_chr_open+0x1de/0x280 [tun]
>> [   67.774644]  misc_open+0x1cb/0x210
>> [   67.776820]  chrdev_open+0x15b/0x350
>> [   67.778917]  ? cdev_put.part.0+0x30/0x30
>> [   67.781030]  do_dentry_open+0x2cb/0x800
>> [   67.783135]  ? cdev_put.part.0+0x30/0x30
>> [   67.785225]  ? devcgroup_check_permission+0x11a/0x260
>> [   67.787321]  ? __x64_sys_fchdir+0xf0/0xf0
>> [   67.789418]  ? security_inode_permission+0x5b/0x70
>> [   67.791513]  path_openat+0x858/0x14a0
>> [   67.793589]  ? path_mountpoint+0x5e0/0x5e0
>> [   67.795719]  ? mark_lock+0xb8/0xb00
>> [   67.797786]  do_filp_open+0x11e/0x1b0
>> [   67.799840]  ? may_open_dev+0x60/0x60
>> [   67.801871]  ? match_held_lock+0x1b/0x240
>> [   67.803968]  ? lock_downgrade+0x360/0x360
>> [   67.805997]  ? do_raw_spin_lock+0x119/0x1d0
>> [   67.808041]  ? rwlock_bug.part.0+0x60/0x60
>> [   67.810099]  ? do_raw_spin_unlock+0xa3/0x130
>> [   67.812244]  ? _raw_spin_unlock+0x1f/0x30
>> [   67.814287]  ? __alloc_fd+0x143/0x2f0
>> [   67.816324]  do_sys_open+0x1f0/0x2d0
>> [   67.818358]  ? filp_open+0x50/0x50
>> [   67.820404]  ? trace_hardirqs_on_thunk+0x1a/0x1c
>> [   67.822447]  ? lockdep_hardirqs_off+0xbe/0x100
>> [   67.824473]  ? mark_held_locks+0x24/0x90
>> [   67.826484]  do_syscall_64+0x74/0xd0
>> [   67.828480]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> [   67.830478] RIP: 0033:0x7f1a2cce6074
>> [   67.832495] Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 86 f4 ff ff 44 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 32 44 89 c7 89 44 24 0c e8 b8 f4 ff ff 8b 44
>> [   67.834760] RSP: 002b:00007f19e4af46d0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
>> [   67.837032] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1a2cce6074
>> [   67.839318] RDX: 0000000000000002 RSI: 00007f1a2d0bfb67 RDI: 00000000ffffff9c
>> [   67.841598] RBP: 00007f1a2d0bfb67 R08: 0000000000000000 R09: 00007f19e4af4914
>> [   67.843941] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000002
>> [   67.846283] R13: 000000000000000d R14: 00007f19e4af4920 R15: 00007f1a2d0bfb67
>>
>> [   67.850936] Allocated by task 1238:
>> [   67.853241]  save_stack+0x1b/0x80
>> [   67.855533]  __kasan_kmalloc.constprop.0+0xc2/0xd0
>> [   67.857935]  sk_prot_alloc+0x115/0x170
>> [   67.860235]  sk_alloc+0x2f/0xa10
>> [   67.862541]  tun_chr_open+0x4d/0x280 [tun]
>> [   67.864894]  misc_open+0x1cb/0x210
>> [   67.867164]  chrdev_open+0x15b/0x350
>> [   67.869448]  do_dentry_open+0x2cb/0x800
>> [   67.871768]  path_openat+0x858/0x14a0
>> [   67.874041]  do_filp_open+0x11e/0x1b0
>> [   67.876328]  do_sys_open+0x1f0/0x2d0
>> [   67.878592]  do_syscall_64+0x74/0xd0
>> [   67.880899]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> [   67.885431] Freed by task 726:
>> [   67.887689]  save_stack+0x1b/0x80
>> [   67.889967]  __kasan_slab_free+0x12c/0x170
>> [   67.892197]  kfree+0xff/0x430
>> [   67.894444]  uevent_show+0x176/0x1b0
>> [   67.896709]  dev_attr_show+0x37/0x70
>> [   67.898940]  sysfs_kf_seq_show+0x119/0x210
>> [   67.901159]  seq_read+0x29d/0x720
>> [   67.903367]  vfs_read+0xf9/0x1f0
>> [   67.905538]  ksys_read+0xc9/0x160
>> [   67.907736]  do_syscall_64+0x74/0xd0
>> [   67.909889]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> [   67.914100] The buggy address belongs to the object at ffff88870afe8000
>>                  which belongs to the cache kmalloc-4k of size 4096
>> [   67.918357] The buggy address is located 2344 bytes inside of
>>                  4096-byte region [ffff88870afe8000, ffff88870afe9000)
>> [   67.922562] The buggy address belongs to the page:
>> [   67.924725] page:ffffea001c2bfa00 refcount:1 mapcount:0 mapping:ffff88881f00de00 index:0x0 compound_mapcount: 0
>> [   67.926926] raw: 0017ffe000010200 ffffea001c167a00 0000000200000002 ffff88881f00de00
>> [   67.929144] raw: 0000000000000000 0000000080040004 00000001ffffffff 0000000000000000
>> [   67.931362] page dumped because: kasan: bad access detected
>>
>> [   67.936192] Memory state around the buggy address:
>> [   67.938438]  ffff88870afe8800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> [   67.941078]  ffff88870afe8880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> [   67.943393] >ffff88870afe8900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> [   67.945709]                                   ^
>> [   67.948000]  ffff88870afe8980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> [   67.950311]  ffff88870afe8a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> [   67.952629] ==================================================================

