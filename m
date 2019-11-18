Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4041C432C0
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 14:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A095820722
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 14:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Kn5BJucq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfKROU4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:20:56 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:47637 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKROUz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 09:20:55 -0500
X-EEMSG-check-017: 27699858|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,320,1569283200"; 
   d="scan'208";a="27699858"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Nov 2019 14:20:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574086853; x=1605622853;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dvrSXzcYqr4Sbk10GVHunXVFHORaA4hd0IJMamh9kBM=;
  b=Kn5BJucqr3Z1NuGsIA2/q9dflbugsJ2LOtTLnxUXtXm76rWNGfrCg9Nf
   iwghFx87VvqjVVTdSblx/KVPmPzTceK83Hd1p0AL/OHkaQryqwYjkBsrw
   h+rYZqc35cGgQ2yD8ERMFO6MYoebITokAViGx+WC+oHGBiPm9+koc7zQr
   YCC9/2wVBNf0okOeLQ7dp7W+9EadeaNK7eXTGHLqeuuZLq8fpvXzdgm4D
   FBKSGnE3/czykFjBumuI37+nilUyds7mbiOHpzN+UR7mxgLYm3Cas14Wn
   qmyW4dGJEOMx77K+vnm8A72Rg3Mw6ZekKGZOwz5s2QAH8qq7FFk4PkHFm
   w==;
X-IronPort-AV: E=Sophos;i="5.68,320,1569283200"; 
   d="scan'208";a="30208685"
IronPort-PHdr: =?us-ascii?q?9a23=3ArWvnGh8rWfOjAP9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0ekUIJqq85mqBkHD//Il1AaPAdyArasY1aGN6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe65+IRq3oAneuMQanZZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLzliwJKyA2/33WisxojaJUvhShpwBkw4XJZI2ZLedycr/Bcd8fQ2?=
 =?us-ascii?q?dOUNxRVyhcCY2iaYUBAfcKMeJBo4Xjo1YCqB2zDhSuCuzy0D9FnmL4060k3e?=
 =?us-ascii?q?QvEg/I0gIvEN0Mv3vIo9v4L7sSXOOvwaXU0TnOYfFb1DHg44bIaBAhpvSMUK?=
 =?us-ascii?q?ptf8rN10YvDwPFgUuWqYf4Ij2V0/4Cs2yf7+V+VeOklmkqqxpsrTi03coslo?=
 =?us-ascii?q?nIiZ4VylDD7yl5xp01KseiRE50Zt6kDoJduieHPIV4RcMiRntnuCc8yrAetp?=
 =?us-ascii?q?67fTQKyJQ6xxHEcfCIb4+I4hflWe2MIjl4nGpodK+wihu960StyvDwWtOq3F?=
 =?us-ascii?q?tFsCZJiMTAu3YQ3BLJ8MeHUOFy/kK51DaK0ADc9/9LLFgvlareN54h2rkwlo?=
 =?us-ascii?q?cPsUjbHi/5hkH2jKiOe0U44Oeo8eXnYqj9ppOGK491ih3xMqQpmsClB+Q3Lh?=
 =?us-ascii?q?MOUHSB9eS51b3j+VX1QLRMjvIojqnUqI3WKMsUq6KjAwJZz5wv5wiwAju4yt?=
 =?us-ascii?q?gUgGELLFdfdxKGi4jpNUvOIPf9DfqnmFSjjSxryuvaPrzhHprNLn/DnK3nfb?=
 =?us-ascii?q?Zm8UFQ0gUzzddB555MELEOPOrzWlPttNzfFhI5MRK7w+jpCNVjzY4eVmWPAq?=
 =?us-ascii?q?iWMKPWr1CE/P4gI+6JZIUNojbyN+Al5+LyjX8+gVIdZrem3Z8WaHC+A/RnLF?=
 =?us-ascii?q?6UYWTjgtgfC2cGpAk+Q/LwiF2ETzFTY2y+X6Um5jE0EIimF5vMRpixgLyd2y?=
 =?us-ascii?q?e2BppWZmVBClCXF3fnbZmLVOkXZSKIPMBujzwEWqK9S4M7yR6uswr6waJ9Lu?=
 =?us-ascii?q?XI4i0YqY7j1N9t6u3Ljx4y6Dh0At+F026XUmF0mnoERzox3KB4u0xy1E2P3r?=
 =?us-ascii?q?R/g/xdDdZT/e9GUh8mNZ7AyOx3E97zWgPFfteNU1umQcupASs3Tt0vx98CeU?=
 =?us-ascii?q?F9G8+tjhrbxSqlH6cVl6CXBJwz6q/cx2L+J9t5y3bDyKYhjEIrQshROm28gK?=
 =?us-ascii?q?5w6QzTC5TOk0WDmKagbb4c0zLV9Gef0WqOu1lVUBRsXqXYRn0feETWosrj5k?=
 =?us-ascii?q?/YTL+hF64nMg1fxs6GMKdKbcfpjVpeTvf5JNvee36xm3u3BRuQxLOMa5TqdH?=
 =?us-ascii?q?8b3CrHC0gJiA8T/XGBNQgxAieuvXjSAyBpFVLqMAvQ9rxcpX21BnE9yQ2HdQ?=
 =?us-ascii?q?Vay7244lZBh/GSRe070bUDtyMs7T5zGQD5l8nbD9uGuhpJYqpRe5U+7U1B2G?=
 =?us-ascii?q?afsBZybbK6KKU3vUITawR6uQvV0hxzDohR2ZwxoGgC0Bt5KaXe1khIMTyfw8?=
 =?us-ascii?q?ajafXsNmDu8UX3OObt0VbE3YPTo/1e5Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BZAACDotJd/wHyM5BdCBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBfoF0LGxVMiqEKo9aAQEGgREliWaPXIEQA1QJAQEBAQEBAQEBK?=
 =?us-ascii?q?wkBAgEBhEACgiMkOBMCDgEBAQQBAQEBAQUDAQFshTcMgjspAYJtAQUjDwEFN?=
 =?us-ascii?q?gsQCQIYAgImAgJXBgEMBgIBAYJfPwGCUiUPlAybc4EyiHWBQgaBDiiMFRh4g?=
 =?us-ascii?q?QeBOAyCKjU+gmICgRshDYMogl4EjSSJfZcIgjSCN4Rjji8GG4I+jCKLMY5Ii?=
 =?us-ascii?q?DiTYSI3gSErCAIYCCEPO4JsUBEUkSUYg1CKcSMDMIEFAQGLLYIxAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Nov 2019 14:20:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAIEKpTl027280;
        Mon, 18 Nov 2019 09:20:51 -0500
Subject: Re: [PATCH v7] selinux: sidtab: reverse lookup hash table
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Jeff Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com, will@kernel.org,
        paulmck@kernel.org, rcu@vger.kernel.org,
        Jovana Knezevic <jovanak@google.com>
References: <20191118122150.198992-1-jeffv@google.com>
 <0bc7a3f5-378f-fe00-71b4-03860453238f@tycho.nsa.gov>
Message-ID: <11b181ad-fd96-5e21-3212-50dc9f1f4b58@tycho.nsa.gov>
Date:   Mon, 18 Nov 2019 09:20:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <0bc7a3f5-378f-fe00-71b4-03860453238f@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/18/19 9:19 AM, Stephen Smalley wrote:
> On 11/18/19 7:21 AM, Jeff Vander Stoep wrote:
>> This replaces the reverse table lookup and reverse cache with a
>> hashtable which improves cache-miss reverse-lookup times from
>> O(n) to O(1)* and maintains the same performance as a reverse
>> cache hit.
>>
>> This reduces the time needed to add a new sidtab entry from ~500us
>> to 5us on a Pixel 3 when there are ~10,000 sidtab entries.
>>
>> The implementation uses the kernel's generic hashtable API,
>> It uses the context's string represtation as the hash source,
>> and the kernels generic string hashing algorithm full_name_hash()
>> to reduce the string to a 32 bit value.
>>
>> This change also maintains the improvement introduced in
>> commit ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
>> performance") which removed the need to keep the current sidtab
>> locked during policy reload. It does however introduce periodic
>> locking of the target sidtab while converting the hashtable. Sidtab
>> entries are never modified or removed, so the context struct stored
>> in the sid_to_context tree can also be used for the context_to_sid
>> hashtable to reduce memory usage.
>>
>> This bug was reported by:
>> - On the selinux bug tracker.
>>    BUG: kernel softlockup due to too many SIDs/contexts #37
>>    https://github.com/SELinuxProject/selinux-kernel/issues/37
>> - Jovana Knezevic on Android's bugtracker.
>>    Bug: 140252993
>>    "During multi-user performance testing, we create and remove users
>>    many times. selinux_android_restorecon_pkgdir goes from 1ms to over
>>    20ms after about 200 user creations and removals. Accumulated over
>>    ~280 packages, that adds a significant time to user creation,
>>    making perf benchmarks unreliable."
>>
>> * Hashtable lookup is only O(1) when n < the number of buckets.
>>
>> Changes in V2:
>> -The hashtable uses sidtab_entry_leaf objects directly so these
>> objects are shared between the sid_to_context lookup tree and the
>> context_to_sid hashtable. This simplifies memory allocation and
>> was suggested by Ondrej Mosnacek.
>> -The new sidtab hash stats file in selinuxfs has been moved out of
>> the avc dir and into a new "ss" dir.
>>
>> V3:
>> -Add lock nesting notation.
>>
>> V4/V5:
>> -Moved to *_rcu variants of the various hashtable functions
>> as suggested by Will Deacon.
>> -Naming/spelling fixups.
>>
>> V6
>> -Remove nested locking. Use lock of active sidtab to gate
>> access to the new sidtab.
>> -Remove use of rcu_head/kfree_rcu(), they're unnecessary because
>> hashtable objects are never removed when read/add operations are
>> occurring. Why is this safe? Quoting Ondrej Mosnacek from the
>> selinux mailing list:
>> "It is not visible in this patch, but the sidtab (along with other
>> policy-lifetime structures) is protected by a big fat read-write lock.
>> The only places where sidtab_destroy() is called are (a) error paths
>> when initializing a new sidtab (here the sidtab isn't shared yet, so
>> no race) and (b) when freeing the old sidtab during policy reload - in
>> this case it is happening after a policy write-locked critical
>> section, which had removed the old sidtab pointer from the shared
>> structures, so at that point all sidtab readers will already be
>> accessing the new sidtab and the old one is visible only by the thread
>> doing the destruction."
>>
>> V7
>> -Change format of /sys/fs/selinux/ss/sidtab_hash_stats to match
>> /sys/fs/selinux/avc/hash_stats.
>> -Add __rcu annotation to rcu pointers.
>> -Test with CONFIG_SPARSE_RCU_POINTER and CONFIG_PROVE_RCU.
>> -Add rcu@vger.kernel.org and Paul McKenney to Cc for review of the
>> RCU logic.
> 
> Also, the hash function doesn't seem to be very good; after booting 
> Fedora with this patch, cat /sys/fs/selinux/ss/sidtab_hash_stats shows:
> entries: 2571
> buckets used: 152/512
> longest chain: 1008

Curiously, running load_policy to reload policy once after boot improves 
the situation markedly:
$ cat /sys/fs/selinux/ss/sidtab_hash_stats
entries: 2587
buckets used: 490/512
longest chain: 13

I'm not clear on what is happening there.

> 
> 
>>
>> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
>> Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
>> Reported-by: Jovana Knezevic <jovanak@google.com>
>> ---
>>   security/selinux/Kconfig            |  12 ++
>>   security/selinux/include/security.h |   1 +
>>   security/selinux/selinuxfs.c        |  65 +++++++
>>   security/selinux/ss/context.h       |  11 +-
>>   security/selinux/ss/policydb.c      |   5 +
>>   security/selinux/ss/services.c      |  83 +++++++--
>>   security/selinux/ss/services.h      |   4 +-
>>   security/selinux/ss/sidtab.c        | 263 ++++++++++++++--------------
>>   security/selinux/ss/sidtab.h        |  18 +-
>>   9 files changed, 300 insertions(+), 162 deletions(-)
>>

