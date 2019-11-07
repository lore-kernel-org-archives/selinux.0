Return-Path: <SRS0=6oqa=Y7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D31C43331
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 14:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF41218AE
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 14:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="WmlziTIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388326AbfKGOyo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:54:44 -0500
Received: from UHIL19PA40.eemsg.mail.mil ([214.24.21.199]:46998 "EHLO
        UHIL19PA40.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387870AbfKGOyn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Nov 2019 09:54:43 -0500
X-EEMSG-check-017: 46605612|UHIL19PA40_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,278,1569283200"; 
   d="scan'208";a="46605612"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA40.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Nov 2019 14:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573138457; x=1604674457;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YIKMzlvY2qpng4FnvrN2OrDL5NiafKuXx2p7y++71GM=;
  b=WmlziTIyQjA2ML2Ga/hfvJVqFXIWzB40DIse/nVgGUu8R2iSwwIaK0LW
   lYtZ6qZxnFgTvnh9Bthn53hm11BIzZIa16k+glCdl26eJiVp411aCAcF6
   LvdJraO8BMM38HEU1YCxdxtmboZn3RdaX442kJjRD4n+ti72/BSU7Imwu
   1VOFzWNW8/b/h6sEnacTr1D/tvD+FKi4au5IwhwJIs5J0fxTu7K3SUWtf
   0o5Q/FERPCAf/thvPE0LUIpijdk4iLgpXxWKx6/q8VWCm8WubX29NDUhj
   EcF1OFVOxvomV9m9uCaMggxY+4sE0fxDZhA932AuB/6weqaccrTNwZTib
   w==;
X-IronPort-AV: E=Sophos;i="5.68,278,1569283200"; 
   d="scan'208";a="35244333"
IronPort-PHdr: =?us-ascii?q?9a23=3A3ETdrxChiO9ZFiUmvafDUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP36pcqwAkXT6L1XgUPTWs2DsrQY0rGQ6vmxEjJfqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmssAndq80bjYRjJ6sz1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzy/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTW9vuCY/0LIGuJ?=
 =?us-ascii?q?i7cTAFyJQm2x7fa+GHfJOS7h3/U+aRJDF1j29mdrKnnxu+7Eetx+LmWsS0zV?=
 =?us-ascii?q?pGtDRJn9bSunwXyhDe7NWMROFn8Ue7wzmP0hje6uRDIU8pi6XWM4Uhwrsslp?=
 =?us-ascii?q?oLtkTDAzP2lF32jKCIckUk/fCl6/j9bbX8p5+cKpR0hhviMqUuhsO/AeM4Ph?=
 =?us-ascii?q?IIX2eH4uSzyKfv/Uj4QLVOlvE2k6/Zv47GJckDu6K0DABY3pwj5hqiFTuqzt?=
 =?us-ascii?q?sVkWcdIF5YYB6HipLmO1DKIPD2F/e/hFGsnS9wx//bJb3sGYnNL3jfn7fher?=
 =?us-ascii?q?Zx8UhcyBEpwtxF6JJUDa8BLOrpWkDtrNzYEgM5MwuszublFtp92I0eWXyUD6?=
 =?us-ascii?q?+WN6PStlCI5uYxLOWWeIAVvzP9IeA/5/HylX85hUMdfa6x0JsMdn+4GvVmI0?=
 =?us-ascii?q?OEYXvjmdoBD2gKsRQkTODwi12NTyRTZ3CsUKI4/D07D5imDYjbTIC3nLOBxD?=
 =?us-ascii?q?u7HoFRZm1eDVCMFHDod56CW/gWdC2dPNRskiYaWre8S48uzw2uuBXmxLpgK+?=
 =?us-ascii?q?re4jcYuo771Nhp++3Tkgk/9SRuAMSA12GAVHl0kXkVRz8yxax/pEt9ylCZ0a?=
 =?us-ascii?q?dmmfBXCdtT5/ZRWAcgKZHc1/B6C8z1Wg/ZcNaJSVKmQtG9DDEyUN0x2dkObF?=
 =?us-ascii?q?h5G9m4iRDDxSWqCacPl7OXHJw07r7c33/pKsZ/zHbGyrMuj188TctMLmCmia?=
 =?us-ascii?q?l/9w/cB47NjUqVjbqldaMZ3H2FyGDW72eAsglmWQh8XL+NZmwYa1Oe+db06E?=
 =?us-ascii?q?3cZ7CpDrsjP01KzsvUbuNRZ9noi0hWbOnsNc6YYG+rnWq0QxGSyeCido3vLl?=
 =?us-ascii?q?4B0T3dBU5MqAUa+XKLJEBqHSu6i37PBzxpU1T0agXj9vco+yDzdVM90wzfNx?=
 =?us-ascii?q?4p7LGy4BNAwKXHGv4=3D?=
X-IPAS-Result: =?us-ascii?q?A2AGAABvL8Rd/wHyM5BcCBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBawQBAQEBCwGBcyxsVTKEU49pAQEGgREliWSPSBSBZwkBAQEBA?=
 =?us-ascii?q?QEBAQErCQECAQGEQAKEDiQ1CA4CDgEBAQQBAQEBAQUDAQFshTcMgjspAYJsA?=
 =?us-ascii?q?QEBAQIBIwQRQQULCxgCAiYCAlcGAQwIAQGCUww/AYJSBSAPsh91fzOFToMtg?=
 =?us-ascii?q?UIGgQ4oAYwTGHiBB4E4DIIqNT6CYgKBPA2DKIJeBI0ciEphRZZ4gi6CNoRhi?=
 =?us-ascii?q?2+CNQYbgjyMFIsijkaIMYxxhkQDNIFYKwgCGAghDzuCbU8RFJBBAReDUIpxI?=
 =?us-ascii?q?wOBNQEBjW4qgTheAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 07 Nov 2019 14:54:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xA7EsAZT018387;
        Thu, 7 Nov 2019 09:54:10 -0500
Subject: Re: [PATCH v5] selinux: sidtab: reverse lookup hash table
To:     Jeff Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com, will@kernel.org,
        Jovana Knezevic <jovanak@google.com>
References: <20191107101743.203699-1-jeffv@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9b0959ff-93be-9086-063e-5403accabc8e@tycho.nsa.gov>
Date:   Thu, 7 Nov 2019 09:54:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191107101743.203699-1-jeffv@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/7/19 5:17 AM, Jeff Vander Stoep wrote:
> This replaces the reverse table lookup and reverse cache with a
> hashtable which improves cache-miss reverse-lookup times from
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
> This change also maintains the improvement introduced in
> commit ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
> performance") which removed the need to keep the current sidtab
> locked during policy reload. It does however introduce periodic
> locking of the target sidtab while converting the hashtable. Sidtab
> entries are never modified or removed, so the context struct stored
> in the sid_to_context tree can also be used for the context_to_sid
> hashtable to reduce memory usage.
> 
> This bug was reported by:
> - On the selinux bug tracker.
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
> context_to_sid hashtable. This simplifies memory allocation and
> was suggested by Ondrej Mosnacek.
> -The new sidtab hash stats file in selinuxfs has been moved out of
> the avc dir and into a new "ss" dir.
> 
> V3:
> -Add lock nesting notation.
> 
> V4:
> -Moved to *_rcu variants of the various hashtable functions
> as suggested by Ondrej Mosnacek and Will Deacon.
> -Naming/spelling fixups.

This still triggers a splat for me in running Ondrej's reproducer (also 
ran selinux-testsuite first, not sure if that mattered):

SELinux:  Converting 3784 SID table entries...
kernel: ------------[ cut here ]------------
syscall 1 left IRQs disabled
WARNING: CPU: 1 PID: 8313 at arch/x86/entry/common.c:261 
syscall_return_slowpathModules linked in: crypto_user 
scsi_transport_iscsi xt_multiport bluetooth ecdh_kernel:  crc32_pclmul 
snd_hda_codec snd_hwdep snd_hda_core ghash_clmulni_intel sCPU: 1 PID: 
8313 Comm: runcon Not tainted 5.4.0-rc1+ #57
Hardware name: Dell Inc. OptiPlex 7050/0NW6H5, BIOS 1.8.3 03/23/2018
RIP: 0010:syscall_return_slowpath+0x1e1/0x4a0
Code: ff ff e9 60 ff ff ff e8 2d ad 05 00 e9 2a ff ff ff 48 8d 7d 78 e8 
cf cf 50RSP: 0018:ffff8885a6adff28 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffffed10b4d5bfd7
RBP: ffff8885a6adff58 R08: ffffffffaa219f90 R09: fffffbfff5883615
R10: fffffbfff5883614 R11: ffffffffac41b0a3 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f3e32c67080(0000) GS:ffff888822a40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3e32f145d0 CR3: 00000005a7476005 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
kernel:  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f3e32e11467
Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 f3 0f 1e 
fa 64 8bRSP: 002b:00007ffec6482bc8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
RAX: 000000000000002f RBX: 00007ffec6483d88 RCX: 00007f3e32e11467
RDX: 000000000000002f RSI: 000055b75e5a5600 RDI: 0000000000000003
RBP: 000055b75e5a5600 R08: 00000000ffffffff R09: 00007ffec6482a60
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007ffec6483c4c R14: 0000000000000000 R15: 0000000000000000
irq event stamp: 7292
hardirqs last  enabled at (7291): [<ffffffffab26d9bb>] 
_raw_write_unlock_irqresthardirqs last disabled at (7292): 
[<ffffffffab26db61>] _raw_spin_lock_irqsave+0xsoftirqs last  enabled at 
(7036): [<ffffffffab600494>] __do_softirq+0x494/0x665
softirqs last disabled at (7025): [<ffffffffaa168b8f>] irq_exit+0x13f/0x160
kernel: ---[ end trace 1557497a64e0b001 ]---
kernel: ------------[ cut here ]------------

Some comments below.  Recommend running it by the RCU wizards e.g. Paul 
McKenney too given the subtleties of getting RCU right.

<snip>

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 7d49994e8d5f..c052e620246c 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -17,26 +17,42 @@
<snip>
> +static u32 context_to_sid(struct sidtab *s, struct context *context)
> +{
> +	struct sidtab_entry_leaf *entry;
> +
> +	rcu_read_lock();
> +	hash_for_each_possible_rcu(s->context_to_sid, entry, list,
> +				   context->hash) {
> +		if (context_cmp(&entry->context, context)) {
> +			rcu_read_unlock();
> +			return entry->sid;

This looks unsafe to me; I would have assumed you need to at least save 
entry->sid to a temporary before rcu_read_unlock()?

> @@ -305,29 +284,36 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>   		rc = -ENOMEM;
>   		dst_convert = sidtab_do_lookup(convert->target, count, 1);
>   		if (!dst_convert) {
> -			context_destroy(dst);
> +			context_destroy(&dst->context);
>   			goto out_unlock;
>   		}
>   
> -		rc = convert->func(context, dst_convert, convert->args);
> +		rc = convert->func(context, &dst_convert->context,
> +				convert->args);
>   		if (rc) {
> -			context_destroy(dst);
> +			context_destroy(&dst->context);
>   			goto out_unlock;
>   		}
> +		dst_convert->sid = index_to_sid(count);
> +		convert->target->count = count + 1;
>   
>   		/* at this point we know the insert won't fail */
> -		convert->target->count = count + 1;
> +		spin_lock_irqsave_nested(&convert->target->lock, flags,
> +				SINGLE_DEPTH_NESTING);
> +		hash_add_rcu(convert->target->context_to_sid,
> +				&dst_convert->list, dst_convert->context.hash);
> +		spin_unlock_irqrestore(&convert->target->lock, flags);

Still having a hard time understanding why we need to lock the target. 
The target here is always the newsidtab allocated by 
security_load_policy(), not yet exposed to any other threads in the system?

>   	}
>   
>   	if (context->len)
>   		pr_info("SELinux:  Context %s is not valid (left unmapped).\n",
>   			context->str);
>   
> -	sidtab_rcache_push(s, count);
> -	*index = count;
> +	*sid = index_to_sid(count);
>   
> -	/* write entries before writing new count */
> +	/* Write entries before updating count. */
>   	smp_store_release(&s->count, count + 1);
> +	hash_add_rcu(s->context_to_sid, &dst->list, dst->context.hash);

Exactly what guarantee do we think we are getting from placing the 
hash_add_rcu() after the smp_store_release() on s->count, and is that 
guarantee well-founded?

> @@ -474,7 +463,7 @@ static void sidtab_destroy_tree(union sidtab_entry_inner entry, u32 level)
>   
>   		for (i = 0; i < SIDTAB_LEAF_ENTRIES; i++)
>   			context_destroy(&node->entries[i].context);
> -		kfree(node);
> +		kfree_rcu(node, rcu);

Is it safe to do this without having deleted it from the hash and 
without having taken the spinlock?

>   	}
>   }
>   

> diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
> index 1f4763141aa1..f1f505df97ba 100644
> --- a/security/selinux/ss/sidtab.h
> +++ b/security/selinux/ss/sidtab.h
> @@ -83,11 +88,11 @@ struct sidtab {
>   	struct sidtab_convert_params *convert;
>   	spinlock_t lock;
>   
> -	/* reverse lookup cache - access atomically via {READ|WRITE}_ONCE() */
> -	u32 rcache[SIDTAB_RCACHE_SIZE];
> -
>   	/* index == SID - 1 (no entry for SECSID_NULL) */
>   	struct sidtab_isid_entry isids[SECINITSID_NUM];
> +
> +	/* Hash table for fast reverse context-to-sid lookups. */
> +	DECLARE_HASHTABLE(context_to_sid, SIDTAB_HASH_BITS);

Should this and/or any of the associated RCU-protected structures be 
marked with __rcu for sparse checking?

>   };
>   
>   int sidtab_init(struct sidtab *s);


