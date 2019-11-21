Return-Path: <SRS0=M/73=ZN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6476EC432C3
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 13:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C28020731
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 13:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="pcQnG96m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKUNSH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:18:07 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:30570 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUNSH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Nov 2019 08:18:07 -0500
X-EEMSG-check-017: 32730167|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,226,1571702400"; 
   d="scan'208";a="32730167"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Nov 2019 13:18:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574342283; x=1605878283;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=oVARPzJXuEXx3ROEsvWoGfauNg/urhj13ueKe9hD3wA=;
  b=pcQnG96myj/Tt6R80TApVS+CmnH6pJCvsYLQtUQOlRq1M2VyNzRsr0T8
   WW3a7n9OP/UyRtP3e3abgcLQSmJ1T1wdEoje3gtrorR8pk3UsJbf6YP5l
   cRzWLY+TKTSZPNr1/yumZ6j6sqCZ+ERH0aQjZA+r3Yd/XShEAxCR8T9qC
   wF8IXXWbXyorqvrzMM1a4W/sio0W5Gt9flP8LXPdnuuqBXdlPMuzf3ugd
   P0EeUP/3AIVNrZRF9TkEqFtAcMGw5ybvN7YOiKTvQh/Cq1AJMboA+f1hD
   u0/Z4eqEPngsbV0z2c60uFYywJI+WZc4k24dZSZs40DOu741JdPws31mD
   g==;
X-IronPort-AV: E=Sophos;i="5.69,224,1571702400"; 
   d="scan'208";a="35822778"
IronPort-PHdr: =?us-ascii?q?9a23=3A41m5PRfhmR3g0eY9mln1A+ANlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc24ZxaN2/xhgRfzUJnB7Loc0qyK6vumADFaqsvY+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLq8UbgZVuJqkxxx?=
 =?us-ascii?q?fUv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCReoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/IwgIgEdINvnraotr6O6UdXvy6wqTT0TXObelb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtig9yr0Do5?=
 =?us-ascii?q?G7fS4KxYwoxx7ed/yHc5WI7Qn5WOmNJjd4gXRoc6+8iRaq6UWs1+LxW8au3F?=
 =?us-ascii?q?tKsyZJiMfAu38T2xDJ98SKTOZ28F271jaVzQ/T7/lJIUUzlaXGNZEs2qUwlp?=
 =?us-ascii?q?8PsUTbGS/2hVn2gLeWdko6/uio7PzqYqn8qZ+GNo90lxr+Pr4yms2/Hes4Mg?=
 =?us-ascii?q?8OU3Kd+eugz73s4Vf1QLBLjv0yiqXZsZbaKtoHpqOhHgNY3Yku5wy/Aju7yt?=
 =?us-ascii?q?gUg3YKIExfdB6al4TpPkvBIPH8DfexmVSslzJryujdPrL8GZXANWTDkbf9cr?=
 =?us-ascii?q?Z97E5Q0gwzzctF6J5OBbEBJ+zzVlfrtNPEFh85LxC0w+H/BdV/yIweV2yPAr?=
 =?us-ascii?q?GCPaPdtl+I4e0vI+2Sa4MPpDn9LP0l7eb0jXAlgV8dYbWp3ZwPZXCjAPtmJ0?=
 =?us-ascii?q?SZYXzxgtYOCmoKoAU+Q/LwiFGYUj5ceWyyX6Qi6TE/Eo6mCp3DRo+1irybwC?=
 =?us-ascii?q?i7BoFWZnxBCl2UFnfocoKEW+wKaC2IPsBujCcJVaK/RIA81RGhrhP6x6B7Ie?=
 =?us-ascii?q?rT/y0SrYjj28Rt5+3PiREy8iR5D9yH3GGQS2F5hXsISCUr3KB7uEB9z1CD0a?=
 =?us-ascii?q?9ig/NGD9Bc+/RJUgIiP57G0+N6E8zyWh7GftqRRlemQ9GmATUqQ9Iy3dAOeU?=
 =?us-ascii?q?B9FMumjhzZ2CqqGbAVnaSRBJMo6qLcw2TxJ8FlxnbezqYhkl0mQs5TOm2lna?=
 =?us-ascii?q?N/9BbcB5TPk0qHk6amb6Mc3DTC9G2b12qBoFlYUBJsUaXCRX0ffFfZrcni60?=
 =?us-ascii?q?PcQL+hF64nPhFCycGcMKtKbMPmjVFcSPfkItTebHq7m32sChaQ2rOMcI3qdn?=
 =?us-ascii?q?0f3CXaFkgLiQYT8myFNQUlCSehpGXeDDNqFV3xeU/j7e5+qHboBnMzmiOHYU?=
 =?us-ascii?q?Mp6bOz9hMPzceATP4LluYGtSkvtR17G1Gy29+QAN2F8U4pZ6hYYNUg8H9Z2m?=
 =?us-ascii?q?/D8Q9wJJqtK+ZlnFFNXR5wuhbVyxhvCohG2fMvpXcuwRs6fbmUy3tdZjiY2t?=
 =?us-ascii?q?b2IbSRJW7sqkP8I5XK003ThY7FspwE7+41/hC65lCk?=
X-IPAS-Result: =?us-ascii?q?A2BQAABpjdZd/wHyM5BcCBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBfoF0LGxVMiqEKo9XBoE3iWePXIEQA1QJAQEBAQEBAQEBKwkBA?=
 =?us-ascii?q?gEBhEACgigkOBMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYJtAQUjBBE2CxALG?=
 =?us-ascii?q?AICJgICVwYBDAYCAQGCXz8BglIlD64wfzOFToMzgUIGgQ4ojBYaeIEHgTiCa?=
 =?us-ascii?q?z6CYgKBGyENgyiCXgSNJ4hXYUaXC4I1gjeEY44wBhuCPownizOOSIg4k2UiN?=
 =?us-ascii?q?4EhKwgCGAghDzuCbFARFIZTGINQinEjAzCBBQEBjg2CMQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 21 Nov 2019 13:18:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xALDHxLw019625;
        Thu, 21 Nov 2019 08:17:59 -0500
Subject: Re: [PATCH v8] selinux: sidtab: reverse lookup hash table
To:     Jeff Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com, will@kernel.org,
        paulmck@kernel.org, rcu@vger.kernel.org,
        Jovana Knezevic <jovanak@google.com>
References: <20191121110933.209018-1-jeffv@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8b0bd807-ac0b-93fb-cd33-a18df1dc640a@tycho.nsa.gov>
Date:   Thu, 21 Nov 2019 08:17:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121110933.209018-1-jeffv@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/21/19 6:09 AM, Jeff Vander Stoep wrote:
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
> Sidtab entries are never modified or removed, so the context struct
> stored in the sid_to_context tree can also be used for the
> context_to_sid hashtable to reduce memory usage.
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
> V4/V5:
> -Moved to *_rcu variants of the various hashtable functions
> as suggested by Will Deacon.
> -Naming/spelling fixups.
> 
> V6
> -Remove nested locking. Use lock of active sidtab to gate
> access to the new sidtab.
> -Remove use of rcu_head/kfree_rcu(), they're unnecessary because
> hashtable objects are never removed when read/add operations are
> occurring. Why is this safe? Quoting Ondrej Mosnacek from the
> selinux mailing list:
> "It is not visible in this patch, but the sidtab (along with other
> policy-lifetime structures) is protected by a big fat read-write lock.
> The only places where sidtab_destroy() is called are (a) error paths
> when initializing a new sidtab (here the sidtab isn't shared yet, so
> no race) and (b) when freeing the old sidtab during policy reload - in
> this case it is happening after a policy write-locked critical
> section, which had removed the old sidtab pointer from the shared
> structures, so at that point all sidtab readers will already be
> accessing the new sidtab and the old one is visible only by the thread
> doing the destruction."
> 
> V7
> -Change format of /sys/fs/selinux/ss/sidtab_hash_stats to match
> /sys/fs/selinux/avc/hash_stats.
> -Add __rcu annotation to rcu pointers.
> -Test with CONFIG_SPARSE_RCU_POINTER and CONFIG_PROVE_RCU.
> -Add rcu@vger.kernel.org and Paul McKenney to Cc for review of the
> RCU logic.
> 
> V8
> -Removed the __rcu annotation added in V7. The annotation is
> intended to be applied to pointers to an object, however the
> objects referenced in the rcu hashtable are allocated and
> stored in an array.
> -Fixed bug where multiple SIDs were receiving the same hash
> due to security_get_user_sids() reusing the same context
> struct without calling context_init() on it. This bug was
> discovered and root-caused by Stephen Smalley.
> -Fixed two more places where the context hash needs to be
> added in convert_context().
> -Moved two more function calls from sidtab_context_to_sid()
> to context_struct_to_sid().
> -Verified on Android and Fedora 31.
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> Reported-by: Jovana Knezevic <jovanak@google.com>
> ---
>   security/selinux/Kconfig            |  12 ++
>   security/selinux/include/security.h |   1 +
>   security/selinux/selinuxfs.c        |  65 +++++++
>   security/selinux/ss/context.h       |  11 +-
>   security/selinux/ss/policydb.c      |   5 +
>   security/selinux/ss/services.c      |  98 ++++++++---
>   security/selinux/ss/services.h      |   4 +-
>   security/selinux/ss/sidtab.c        | 263 ++++++++++++++--------------
>   security/selinux/ss/sidtab.h        |  16 +-
>   9 files changed, 308 insertions(+), 167 deletions(-)
> 
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 3a29e7c24ba9..5ccae6ac8cab 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1384,6 +1395,8 @@ static int string_to_context_struct(struct policydb *pol,
>   	int rc = 0;
>   
>   	context_init(ctx);
> +	/* hash the string before it gets mutated */
> +	ctx->hash = context_compute_hash(scontext);
>   
>   	/* Parse the security context. */
>   

I still don't think this is correct/safe.  The problem is that 
string_to_context_struct() can be called with a security context string 
in a non-canonical form, i.e. not the same string that would be produced 
by context_struct_to_string() on the resulting context.  This can occur 
if a userspace program passes in a context that uses an alias name or 
that uses a non-compact form of the category set (e.g. c0,c1,c2 versus 
c0.c2).  I think we can only set the hashes from the strings produced by 
context_struct_to_string() if we want to ensure consistency.  If we 
leave the hash unset here, it will still be set later by 
context_struct_to_sid() or convert_context() so it should be fine.
