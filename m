Return-Path: <SRS0=nnTv=Y4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D791CA9EB5
	for <selinux@archiver.kernel.org>; Mon,  4 Nov 2019 20:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69871206BA
	for <selinux@archiver.kernel.org>; Mon,  4 Nov 2019 20:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="HluMoO93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfKDUoR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Nov 2019 15:44:17 -0500
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:35584 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfKDUoQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Nov 2019 15:44:16 -0500
X-EEMSG-check-017: 47056910|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,268,1569283200"; 
   d="scan'208";a="47056910"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Nov 2019 20:44:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572900250; x=1604436250;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pJG8ZfFHf/AE+09c5G8zp38Yh/Nx5XaDYB2sGlxx5JY=;
  b=HluMoO93Se3LXrwNVZB5eGvpd68vBg/+e84Se563FgJSV9LpNnwKOdp4
   Fj4G8iueJiDGiAlvXFDmHH+0JPrXiklzXStEsmDOCvnjUffjMbowEjd7N
   9SKFRO3Hq0b0cnS+xnvNZy16kQocLeiVGNGlYaVdHtAnxpYBtwtrBsr09
   uFQVYTZau1n6pfq7eIg2n1IwkRxV110Tz9D+bwNQx/2NfojtE3QUAmkR1
   70B0QXAoyan4a0+MJksmeYRc5W6T+Crroxt2B+e7W9sTCsYmF3VTo5gDw
   BgWRNVONIBvrL9btzRCuSgQ+BkLpALXZSblYER4fiugfpGooFxhLyPkfP
   g==;
X-IronPort-AV: E=Sophos;i="5.68,268,1569283200"; 
   d="scan'208";a="35092254"
IronPort-PHdr: =?us-ascii?q?9a23=3Ap5l71RD8t4PdqdOeB8R9UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP37r8+wAkXT6L1XgUPTWs2DsrQY0rGQ6vm7EjVbsN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txjdutQYjIdtN6o8xB?=
 =?us-ascii?q?/EqWZUdupLwm9lOUidlAvm6Meq+55j/SVQu/Y/+MNFTK73Yac2Q6FGATo/K2?=
 =?us-ascii?q?w669HluhfFTQuU+3sTSX4WnQZSAwjE9x71QJH8uTbnu+Vn2SmaOcr2Ta0oWT?=
 =?us-ascii?q?mn8qxmRgPkhDsBOjUk62zclNB+g7xHrxKgvxx/wpDbYIeJNPplY6jRecoWSX?=
 =?us-ascii?q?ddUspNUiBMBI2zb5ELD+EcI+hWqYfzrEYKoRenCwShAObjxzlVjXH0wKI6yf?=
 =?us-ascii?q?wsHxzY0gwuH9wAs3rao9v6O6gQTe+7w7LFzSnBYv5MxTvx9IbFfxInrPqRXb?=
 =?us-ascii?q?xwa83RyUw3Gg3YklWft5TlPzOL2eQLrmOV8u9gWviri24jtQ5woiWky8A3io?=
 =?us-ascii?q?bUnYIY0UzE9CVlz4Y1It20Ukh7YcW+H5dKuCGaMJV2T9okTmp1tig6zbgGto?=
 =?us-ascii?q?S6fCgM0JknyB/fa+CHc4iV+R3vTvqeITB9hH9jZbmxhA6y/FC9xuDzWcS4yl?=
 =?us-ascii?q?ZHojdfntXSuX0ByQbf5tWBR/Bg5EmuwyyP2BrW6uxcJEA0krfUJIA5z74rk5?=
 =?us-ascii?q?oTrVzDHijrmEXqlKOWdlsr+uyv6+n/frXpvIWcN45pigHlKKguhsy+Dvg4Mg?=
 =?us-ascii?q?gJRWSb//iz1Kb/8kHjRbVKj/k2nrHYsJDcO8sbura0DxJa34ss8RqyDyqq3M?=
 =?us-ascii?q?4GkXQIMl5JYg+Lg5DsO17UIfD4Cfm/g06rkDdu3/3GJaDuAo7WI3jfkLbuYb?=
 =?us-ascii?q?Z960lGxAo11tBQ/YhYCr4GIPLtQkPxrsDXDgclMwyoxObqENd92Z0QWWKBHK?=
 =?us-ascii?q?+UK6zSsViP5uIgJ+mDepUZtyr6K/gg//Tul2M2mUcBfam12psacGu4EepiI0?=
 =?us-ascii?q?WYZ3rsn9gAHHwUvgoxUuPqkkeOUT1NaHaoWaIz+DU7BJihDYfZSYCnmKaB0z?=
 =?us-ascii?q?ujHp1KemBGDUiBEXXvd4WaQfgMbjidIsx6nzwLUrihTIAh1RWwuwPg17VnKe?=
 =?us-ascii?q?/U8DUCtZ3/zNh1+/HTlRYq+DxzCsSd1HqNT2dukWwUWTA7x7p/rlJgxVeDy6?=
 =?us-ascii?q?d4n+ZUGsBU5/NMSg06L4LTz/RmC9DuXQLMZs+JR0y7QtWiGjwxVsg+w8IKY0?=
 =?us-ascii?q?pkHtWiiRfD3zC0DLMPi7OLA5k0oerg2C3TKshzg0jP0qUslREdXsxCLSXyhK?=
 =?us-ascii?q?Nx+Rb7CInOnEGU0a2tcPJYlDXA8GaF0Hqmok5VSkhzXL/DUHRZYVHZ/vrj4U?=
 =?us-ascii?q?aXdKOjEbQqNEN6zMeGLqZbIonygU5uWOboONOYZXm43Wi3G0Dblfu3cIP2dj?=
 =?us-ascii?q?BFj23mA08enlVWpC3XOA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AkAADQjMBd/wHyM5BeCBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBbAIBAQEBCwGBbgUsbFUyKoQpj2IGgTaJZI9bgRADVAkBAQEBA?=
 =?us-ascii?q?QEBAQErCQECAQGEQAKEDiQ3Bg4CDgEBAQQBAQEBAQUDAQFshTcMgjspAYJtA?=
 =?us-ascii?q?QUjBBFBEAsYAgImAgJXBgEMBgIBAYJfPwGCUiUPsgJ/M4VOgzuBQgaBDigBj?=
 =?us-ascii?q?BIYeIEHgTiCNjU+gmICgTwNGIMQgl4EjRSIRWFEh3CPBIIugjOEXo4fBhuZZ?=
 =?us-ascii?q?Y5CiC6TOSM3gSErCAIYCCEPgydQERSDEQEXg1CKcSMDMIEFAQGNZgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Nov 2019 20:44:09 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xA4Ki6MD007202;
        Mon, 4 Nov 2019 15:44:07 -0500
Subject: Re: [PATCH v2] selinux: sidtab: reverse lookup hash table
To:     Jeff Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org
Cc:     Jovana Knezevic <jovanak@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
References: <20191104191535.23642-1-jeffv@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f824ce20-99f7-9df5-541e-8d239c6f31b4@tycho.nsa.gov>
Date:   Mon, 4 Nov 2019 15:44:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104191535.23642-1-jeffv@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/4/19 2:15 PM, Jeff Vander Stoep wrote:
> This replaces the reverse table lookup and reverse cache with a
> hashtable which improves cache-miss reverese-lookup times from
> O(n) to O(1)* and maintains the same performance as a reverse
> cache hit.
> 
> This reduces the time needed to add a new sidtab entry from ~500us
> to 5us on a Pixel 3 when there are ~10,000 sidtab entries.
> 
> The implementation uses the kernel's generic hashtable API,
> It uses the context's string represtation as the hash source,
> and the kernels generic string hashing algorithm full_name_hash()
> to reduce the string to a 32 bit value.
> 
> This change also maintains the improvement introduced in commit
> ee1a84fd which removed the need to keep the current sidtab locked
> during policy reload. It does however introduce periodic locking of
> the target sidtab while converting the hashtable. Sidtab entries
> are never modified or removed, so the context struct stored in the
> sid_to_context tree can also be used for the context_to_sid
> hashtable to reduce memory usage.
> 
> This bug was reported by:
> - Stephen Smally on the selinux bug tracker.
>    BUG: kernel softlockup due to too many SIDs/contexts #37
>    https://github.com/SELinuxProject/selinux-kernel/issues/37
> - Jovana Knezevic on Android's bugtracker.
>    Bug: 140252993
>    "During multi-user performance testing, we create and remove users
>    many times. selinux_android_restorecon_pkgdir goes from 1ms to over
>    20ms after about 200 user creations and removals. Accumulated over
>    ~280 packages, that adds a significant time to user creation,
>    making perf benchmarks unreliable."
> 
> * Hashtable lookup is only O(1) when n < the number of buckets.
> 
> Changes in V2:
> -The hashtable uses sidtab_entry_leaf objects directly so these
> objects are shared between the sid_to_context lookup tree and the
> context_to_sid hashtable.
> -Move the hash_add() statement to after the smp_store_release()
> to ensure that the contents have been written before the object
> becomes available in the hashtable.

Don't forget to cc Paul and anyone who commented previously (e.g. Ondrej).

I could be wrong, but I think that only helps if we also do a 
smp_load_acquire() prior to reading/walking the hash table and if there 
is an actual data dependency between the target of the store/load and 
what we are trying to protect here.   I don't think that's the case 
here.  So I don't think you can or should piggyback on the existing 
load_acquire/store_release pair.  Ondrej can correct me if I am wrong 
(entirely possible).

I also get this splat upon running Ondrej's reproducer for the bug fixed 
by his sidtab rewrite.

Reproducer:

       while true; do load_policy; echo -n .; sleep 0.1; done &
         for (( i = 0; i < 1024; i++ )); do
             runcon -l s0:c$i echo -n x || break
             # or:
             # chcon -l s0:c$i <some_file> || break
         done

Splat:

6>[ 1070.843961] SELinux:  Converting 3927 SID table entries...
<4>[ 1070.858060]
<4>[ 1070.858064] ============================================
<4>[ 1070.858066] WARNING: possible recursive locking detected
<4>[ 1070.858068] 5.4.0-rc1+ #50 Not tainted
<4>[ 1070.858070] --------------------------------------------
<4>[ 1070.858072] runcon/13122 is trying to acquire lock:
<4>[ 1070.858074] ffff88869467c248 (&(&s->lock)->rlock){..-.}, at: 
sidtab_context_to_sid+0x379/0x700
<4>[ 1070.858080]
<4>[ 1070.858080] but task is already holding lock:
<4>[ 1070.858082] ffff8886e608c248 (&(&s->lock)->rlock){..-.}, at: 
sidtab_context_to_sid+0x64/0x700
<4>[ 1070.858086]
<4>[ 1070.858086] other info that might help us debug this:
<4>[ 1070.858088]  Possible unsafe locking scenario:
<4>[ 1070.858088]
<4>[ 1070.858089]        CPU0
<4>[ 1070.858090]        ----
<4>[ 1070.858091]   lock(&(&s->lock)->rlock);
<4>[ 1070.858093]   lock(&(&s->lock)->rlock);
<4>[ 1070.858095]
<4>[ 1070.858095]  *** DEADLOCK ***
<4>[ 1070.858095]
<4>[ 1070.858097]  May be due to missing lock nesting notation
<4>[ 1070.858097]
<4>[ 1070.858099] 3 locks held by runcon/13122:
<4>[ 1070.858100]  #0: ffff8887fa97c820 (sb_writers#9){.+.+}, at: 
vfs_write+0x215/0x280
<4>[ 1070.858105]  #1: ffffffffae0230e8 
(&selinux_ss.policy_rwlock){.+.?}, at: 
security_context_to_sid_core+0x2c0/0x340
<4>[ 1070.858109]  #2: ffff8886e608c248 (&(&s->lock)->rlock){..-.}, at: 
sidtab_context_to_sid+0x64/0x700
<4>[ 1070.858113]
<4>[ 1070.858113] stack backtrace:
<4>[ 1070.858116] CPU: 1 PID: 13122 Comm: runcon Not tainted 5.4.0-rc1+ #50
<4>[ 1070.858118] Hardware name: Dell Inc. OptiPlex 7050/0NW6H5, BIOS 
1.8.3 03/23/2018
<4>[ 1070.858120] Call Trace:
<4>[ 1070.858124]  dump_stack+0x9a/0xf0
<4>[ 1070.858128]  __lock_acquire.cold+0x12e/0x212
<4>[ 1070.858136]  ? lockdep_hardirqs_on+0x260/0x260
<4>[ 1070.858142]  lock_acquire+0xe5/0x210
<4>[ 1070.858160]  ? sidtab_context_to_sid+0x379/0x700
<4>[ 1070.858164]  _raw_spin_lock_irqsave+0x44/0x60
<4>[ 1070.858166]  ? sidtab_context_to_sid+0x379/0x700
<4>[ 1070.858169]  sidtab_context_to_sid+0x379/0x700
<4>[ 1070.858173]  ? security_compute_sid.part.0+0x960/0x960
<4>[ 1070.858177]  security_context_to_sid_core+0x177/0x340
<4>[ 1070.858180]  ? context_to_sid.isra.0+0x60/0x60
<4>[ 1070.858182]  ? match_held_lock+0x1b/0x240
<4>[ 1070.858200]  ? __might_fault+0x6f/0xd0
<4>[ 1070.858203]  security_context_to_sid+0x12/0x20
<4>[ 1070.858206]  sel_write_context+0x19b/0x200
<4>[ 1070.858209]  ? selinux_transaction_write+0xa0/0xa0
<4>[ 1070.858213]  ? _copy_from_user+0xa1/0xd0
<4>[ 1070.858216]  ? selinux_transaction_write+0xa0/0xa0
<4>[ 1070.858218]  selinux_transaction_write+0x72/0xa0
<4>[ 1070.858221]  vfs_write+0x12f/0x280
<4>[ 1070.858224]  ksys_write+0xc3/0x160
<4>[ 1070.858227]  ? __ia32_sys_read+0x50/0x50
<4>[ 1070.858230]  ? lockdep_hardirqs_off+0xbe/0x100
<4>[ 1070.858232]  ? mark_held_locks+0x24/0x90
<4>[ 1070.858236]  do_syscall_64+0x74/0xd0
<4>[ 1070.858239]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
<4>[ 1070.858242] RIP: 0033:0x7f7e94d3a467
<4>[ 1070.858245] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 
00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 
0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
<4>[ 1070.858247] RSP: 002b:00007ffd48dbae78 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
<4>[ 1070.858250] RAX: ffffffffffffffda RBX: 00007ffd48dbc038 RCX: 
00007f7e94d3a467
<4>[ 1070.858252] RDX: 000000000000002f RSI: 000055e32f081600 RDI: 
0000000000000003
<4>[ 1070.858254] RBP: 000055e32f081600 R08: 00000000ffffffff R09: 
00007ffd48dbad10
<4>[ 1070.858255] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000000003
<4>[ 1070.858257] R13: 00007ffd48dbbefc R14: 0000000000000000 R15: 
0000000000000000

> -The new sidtab hash stats file in selinuxfs has been moved out of
> the avc dir and into a new "ss" dir.
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
> Reported-by: Jovana Knezevic <jovanak@google.com>
> ---
>   security/selinux/Kconfig            |  12 ++
>   security/selinux/include/security.h |   1 +
>   security/selinux/selinuxfs.c        |  64 +++++++
>   security/selinux/ss/context.h       |  11 +-
>   security/selinux/ss/policydb.c      |   5 +
>   security/selinux/ss/services.c      |  87 +++++++---
>   security/selinux/ss/services.h      |   4 +-
>   security/selinux/ss/sidtab.c        | 249 +++++++++++++---------------
>   security/selinux/ss/sidtab.h        |  16 +-
>   9 files changed, 287 insertions(+), 162 deletions(-)
> 
<snip>
