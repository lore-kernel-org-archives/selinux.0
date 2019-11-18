Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E10C432C0
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 14:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1536520727
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 14:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="FinantLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfKROTS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:19:18 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:23352 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfKROTS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 09:19:18 -0500
X-EEMSG-check-017: 31870730|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,320,1569283200"; 
   d="scan'208";a="31870730"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Nov 2019 14:19:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574086754; x=1605622754;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uR07GcBRIBHy9zXETaP0yG8LIY0Y5/xNJvCp2TmXKcM=;
  b=FinantLWbiqfmiYhnVDV0OU/tRnMaw3Z9sFT/VIZUGU6axfMdJWip2LM
   zb+KVft4tirXjCF0G/ioLHtWiWPSjG6gbRNtVLeylFaJMT2zmz5Kcge1v
   jrSdlAvLkeSSMWACjvY6T7V1XNqx5GG406Gr5NsJ++RAQQwqSjJ9oRB+h
   EWjAGb2MgthZT5rPRrGKfKD3YoUTbFhs/PkLrPc9YJ1YvO6R/AqUkZXs4
   b52dLce0UZgdnPOTZONUTt+oL+/IWqYcbPMFCuTp63MyYJu1ww6OFvHCh
   ULZYkhjTaVozvoLjlLbNjcHcAvYVjm59YLI96YTVCqEGy7c6mlH+WO/Aj
   A==;
X-IronPort-AV: E=Sophos;i="5.68,320,1569283200"; 
   d="scan'208";a="30208605"
IronPort-PHdr: =?us-ascii?q?9a23=3Afs2P6RLArSs7f/ZY3NmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKP/5rarrMEGX3/hxlliBBdydt6sfzbOK7eu7ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngi6oArQu8UZj4ZuNrs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1cQqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1wavSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0sRGFovTw1yrwAuZ?=
 =?us-ascii?q?OjcygKyYgnxx7Ca/OcaYSH/hXjVOOXLDxlh3xlYKqyiwu9/EWv0OHxVtS43E?=
 =?us-ascii?q?xUoidKjNXArG0B2hrO4cadUPR95F2u2TOX2gDW7eFLPF47mLLAK54k3r4wjp?=
 =?us-ascii?q?0TsVnfHiPumEX5kquWdkI89+i08evneLTmpoKHN4NulgH/Mrghmsy4AegiNA?=
 =?us-ascii?q?gBQ3Ob9vim2L3m/E35RK1GjvwwkqbHrJDXPdkXq6G2DgNP0osv9gyzAymp3d?=
 =?us-ascii?q?gGh3ULMUpJeBedgIjoP1HOLur4DfC6g1m0izdk2uvGM6b9ApTNMnfDkLDhca?=
 =?us-ascii?q?x7605H0gU/199f55VKCr0ZOvL8RlfxtMDEDh8+KwG0wfjoCNtz1oMAQm+PDa?=
 =?us-ascii?q?iZMKTdsV+M+O0jOfWDZIgQuDzlMfgq++bujWMlmV8aZaSpxoUYaHS5HvRgPk?=
 =?us-ascii?q?WYbmHhgskOEWgUpAoyVu/qh0OYUT5VeXmyW7gw5jYhCIKpFY3DXJyigKSd3C?=
 =?us-ascii?q?enGZ1bfmdGClWLEXfzcYWLQesDZzyJL897jDMLSLihRJU91R20qAD6zL9nJP?=
 =?us-ascii?q?LO+iIErZLjyMR15+rLmBEq7zN0EsCd3nqVT25ug2MIQyY63KV4oUx60FeMz7?=
 =?us-ascii?q?J0jOBfFdxW//lJSBs1NYbAz+xmDND/QgzAftaNSFaiWdimAi8+Tsg3w9AQZ0?=
 =?us-ascii?q?ZxAdKijgrM3yCyGb8ai6SLBIAo8qLbx3XxP9xyy2vC1Kkkk1YmQdBCNW64ia?=
 =?us-ascii?q?5l8QjcGYrJn1+el6aweqQWxDTN+3ubzWqSoEFYVxZ9Ub/ZUnACfUbWs9v56V?=
 =?us-ascii?q?3YT7O0CrQoLBFBycicJatOcNHpik9GRPj7MtTEf22xg3uwBQqPxr6UborqfH?=
 =?us-ascii?q?sd0z/bCEcekAAe5nmGNQ85Bieup2LREiZiGk7oY0PpoqFCryaZQ0E6hz+DaU?=
 =?us-ascii?q?FszfKO5hkYnbTISf4d0KwstyAmpDF5Wl262oSSQ8GNowtnYbV0f9ww+hFE2H?=
 =?us-ascii?q?jfugg7OYavfI54gVtLSBh6p0Pj0V1MD4xElcU75CcxwBFaNbOT0FQHcSiRm5?=
 =?us-ascii?q?/3JOuEeSHJ4BmzZvuOiRnl29GM9/JKsa5ppg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BXAACDotJd/wHyM5BdCBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBfoF0LGxVMiqEKo9aAQEGgTaJZo9cgRADVAkBAQEBAQEBAQErC?=
 =?us-ascii?q?QECAQGEQAKCIyQ4EwIOAQEBBAEBAQEBBQMBAWyFNwyCOykBgmwBAQEBAgEjF?=
 =?us-ascii?q?TYLEAsYAgImAgJXBgEMBgIBAYJfPwGCUgUgD68KdYEyhU6DJ4FCBoEOKIwVG?=
 =?us-ascii?q?HiBB4E4gjY1PoJiAoEbIQ2DKIJeBI0kiTdGlwiCNII3hGOOLwYbgj6MIosxj?=
 =?us-ascii?q?kiIOJNhIjeBISsIAhgIIQ87gmxQERSRJRiDUIpxIwMwgQUBAYstgjEBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Nov 2019 14:19:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAIEJCv8027257;
        Mon, 18 Nov 2019 09:19:12 -0500
Subject: Re: [PATCH v7] selinux: sidtab: reverse lookup hash table
To:     Jeff Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com, will@kernel.org,
        paulmck@kernel.org, rcu@vger.kernel.org,
        Jovana Knezevic <jovanak@google.com>
References: <20191118122150.198992-1-jeffv@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0bc7a3f5-378f-fe00-71b4-03860453238f@tycho.nsa.gov>
Date:   Mon, 18 Nov 2019 09:19:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191118122150.198992-1-jeffv@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/18/19 7:21 AM, Jeff Vander Stoep wrote:
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

Also, the hash function doesn't seem to be very good; after booting 
Fedora with this patch, cat /sys/fs/selinux/ss/sidtab_hash_stats shows:
entries: 2571
buckets used: 152/512
longest chain: 1008


> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
> Reported-by: Jovana Knezevic <jovanak@google.com>
> ---
>   security/selinux/Kconfig            |  12 ++
>   security/selinux/include/security.h |   1 +
>   security/selinux/selinuxfs.c        |  65 +++++++
>   security/selinux/ss/context.h       |  11 +-
>   security/selinux/ss/policydb.c      |   5 +
>   security/selinux/ss/services.c      |  83 +++++++--
>   security/selinux/ss/services.h      |   4 +-
>   security/selinux/ss/sidtab.c        | 263 ++++++++++++++--------------
>   security/selinux/ss/sidtab.h        |  18 +-
>   9 files changed, 300 insertions(+), 162 deletions(-)
> 
