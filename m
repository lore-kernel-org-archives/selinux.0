Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41935C43215
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 21:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADE52230F
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 21:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="QG2CyW5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKRVLi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:11:38 -0500
Received: from USAT19PA21.eemsg.mail.mil ([214.24.22.195]:11407 "EHLO
        USAT19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfKRVLi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 16:11:38 -0500
X-EEMSG-check-017: 51967892|USAT19PA21_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,321,1569283200"; 
   d="scan'208";a="51967892"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Nov 2019 21:11:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574111495; x=1605647495;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kYZ4TgIZz8ogSX028iFo+u7VaXXDNL20NkluQZH1nSs=;
  b=QG2CyW5u/LEKjhJdHwoyQZzh+nDSWwOD5K2oJySL21EGxz2WkfK4RAC3
   jEPJieGfrLnjS2GpmtXOzjW5eUSNTwGaFs56OW9RP5QTF44Na2zb+bw0v
   VAV0mPKg1vCHi/x4v4Mnk07i1P9I1Zdy1J8WkXoHK9eJBCL08Nqqn1q6R
   hwNV/qFLgYs9f9aLIVZFK/cYxxerA8+nZ9S8xpZ1//f3HvEYc6UCxs0m1
   gzbdeo79r21Aw2F8819TDB0t6AcEzg4jivx8FxWhwkifOQiqSPXkgFigQ
   UdAm8lgwO0vzySqaoTB2ynMLorVqgmZKhM+oQxPLeKqaYvusEHjdxdv7y
   g==;
X-IronPort-AV: E=Sophos;i="5.68,321,1569283200"; 
   d="scan'208";a="35685877"
IronPort-PHdr: =?us-ascii?q?9a23=3AJxpGfxHcyfmwWgzpE3r1lZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76pc+/bnLW6fgltlLVR4KTs6sC17ON9fm8BydZu83JmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/MusQZgIZuJbs9xg?=
 =?us-ascii?q?XHr3BVZ+lY2GRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7XragdJsgq1FvB2hpgR/w4/Kb4GTKPp+Zb7WcdcDSW?=
 =?us-ascii?q?ZcQspdSylND4WyYIsVC+oKIPhWoY/zqVATqReyHBegCefqxjJOm3T437A10/?=
 =?us-ascii?q?45HA/b3AIuAdwOvnfaotr7O6gdU/y6wqbTwDXfbP5bwyvx5JTGfx0jp/yHQL?=
 =?us-ascii?q?J+cdDWyUkqDw7Lk0mQppL9PzOVyOsNtXWQ4fdlVe21j24nrx9+oziyzcorkY?=
 =?us-ascii?q?nGm5kVx0vY9SR53Ik1Jdq4RFR9Yd6/CpRcrS6aN4xoQs47RWxjpSg0yroDuZ?=
 =?us-ascii?q?GhfSgKzowqxxHea/ybc4iI/wnsWPyNLjd/gXJofq+0iRWq8UW41+HxWca53E?=
 =?us-ascii?q?xKoyZYiNXAqH8A2wLJ5sSaTPZ2412v1iyV1w/J7+FJOUU0la3GJJE/2rMwjZ?=
 =?us-ascii?q?8TsVjbHi/xhUX2kLeadkU69eis7OTqeqnmqYWGN491lwH+Kb4imtC/AOskMg?=
 =?us-ascii?q?gOWHKX+eKg27344UL1WrBKjvwykqXBsZDaI9oUprKhDgNI3Ysu5AyzAje73N?=
 =?us-ascii?q?gCg3UKI0xJdAiag4TxPlHBOvH4DfOxg1S2lzdrwujLPqb8DZXWNXXDjLfgcq?=
 =?us-ascii?q?p9605b0gYzy8tf6IhOBrEOJ/LzRFf9tMbEAR8hLwy03+HnBc1/1owAV2KPDL?=
 =?us-ascii?q?GZPbjdsV+P4eIvLO2Ma5EPtDnhLPgl4ubkjWUlll8FYampwZwXZWijHvt4J0?=
 =?us-ascii?q?WZYHzsgsoOEGoRoAo+Q/LliEeYXT5QeXmyRaQ86S8/CI68CofDXI+tiqSb3C?=
 =?us-ascii?q?inBp1WenxGCleUHHfvcoWEXOwMaCSILcB9jDMJTqKhRJE82hGurgD616BrIf?=
 =?us-ascii?q?bT+i0drZjjzsR65/XPlREu8jx5F9yd3HuQT2FwhW4IXyU53L17oUBkz1eD1q?=
 =?us-ascii?q?94g+ZGGtBJ+/xJVQI6P4bGz+NmE9DyRh7BftCRRVeoQ9WmBTUxQ8kyw9AQeU?=
 =?us-ascii?q?Z9HcutjhTZ0yqtGb8VmKSBBIYo/aLEw3jxO8F9xm7e1KY7klkmRs5POnGlhq?=
 =?us-ascii?q?Nk9AjcGZTJk0OHmKaub6gc2zTN9Gibx2qUoE5YSBJwUbnCXX0HfEvZscn561?=
 =?us-ascii?q?jcT7+hF7snKBFNyc2cJatQbN3mk1FGSO3kONTEbGK7g32wCgqQxrOQcIrqfH?=
 =?us-ascii?q?0Q3CfaCEgaiQ8T+2yJNQslCyeupGLeCzNuFVbxbE/27eZ+r3a7HQcIyFSoYk?=
 =?us-ascii?q?Nvn4S8/BIYn7SnV/QexvpQuiovpStcE1G60NbbTdGHolwlNL5RZdI7/Udvy2?=
 =?us-ascii?q?3UrUp+M4amIqQkgUQRICptuEa77Al6EoVNl4ARqXouyAdjYfaD3EhpayKT3Z?=
 =?us-ascii?q?e2PKbebGb14kb8OObtxljC3YPOqe804/MipgCm5Vv4Gw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BOAAAACNNd/wHyM5BdCBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBfoF0LGxUATIqhCqPXAaBNolmj1yBEANUCQEBAQEBAQEBASsJA?=
 =?us-ascii?q?QIBAYRAAoIjJDgTAg4BAQEEAQEBAQEFAwEBbIU3DII7KQGCbQEFIwQLAQU2C?=
 =?us-ascii?q?xAJAhgCAiYCAlcGAQwGAgEBgl8/AYJSJQ+VTJtzfzOIdoFCBoEOKIwVGHiBB?=
 =?us-ascii?q?4E4gjY1PoJiAoEbIQ2DKIJeBI0kiX2XCII0gjeEY44vBhuCPowiizGOSIg4k?=
 =?us-ascii?q?2EiN4EhKwgCGAghDzuCbFARFJElGINQinEjAzCBBQEBiyWCMQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Nov 2019 21:11:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAILBXLT006880;
        Mon, 18 Nov 2019 16:11:33 -0500
Subject: Re: [PATCH v7] selinux: sidtab: reverse lookup hash table
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Jeff Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com, will@kernel.org,
        paulmck@kernel.org, rcu@vger.kernel.org,
        Jovana Knezevic <jovanak@google.com>
References: <20191118122150.198992-1-jeffv@google.com>
 <0bc7a3f5-378f-fe00-71b4-03860453238f@tycho.nsa.gov>
 <11b181ad-fd96-5e21-3212-50dc9f1f4b58@tycho.nsa.gov>
Message-ID: <7ce5a5d8-30a7-7b58-746d-53c40d01e75b@tycho.nsa.gov>
Date:   Mon, 18 Nov 2019 16:11:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <11b181ad-fd96-5e21-3212-50dc9f1f4b58@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/18/19 9:20 AM, Stephen Smalley wrote:
> On 11/18/19 9:19 AM, Stephen Smalley wrote:
>> On 11/18/19 7:21 AM, Jeff Vander Stoep wrote:
>>> This replaces the reverse table lookup and reverse cache with a
>>> hashtable which improves cache-miss reverse-lookup times from
>>> O(n) to O(1)* and maintains the same performance as a reverse
>>> cache hit.
>>>
>>> This reduces the time needed to add a new sidtab entry from ~500us
>>> to 5us on a Pixel 3 when there are ~10,000 sidtab entries.
>>>
>>> The implementation uses the kernel's generic hashtable API,
>>> It uses the context's string represtation as the hash source,
>>> and the kernels generic string hashing algorithm full_name_hash()
>>> to reduce the string to a 32 bit value.
>>>
>>> This change also maintains the improvement introduced in
>>> commit ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
>>> performance") which removed the need to keep the current sidtab
>>> locked during policy reload. It does however introduce periodic
>>> locking of the target sidtab while converting the hashtable. Sidtab
>>> entries are never modified or removed, so the context struct stored
>>> in the sid_to_context tree can also be used for the context_to_sid
>>> hashtable to reduce memory usage.
>>>
>>> This bug was reported by:
>>> - On the selinux bug tracker.
>>>    BUG: kernel softlockup due to too many SIDs/contexts #37
>>>    https://github.com/SELinuxProject/selinux-kernel/issues/37
>>> - Jovana Knezevic on Android's bugtracker.
>>>    Bug: 140252993
>>>    "During multi-user performance testing, we create and remove users
>>>    many times. selinux_android_restorecon_pkgdir goes from 1ms to over
>>>    20ms after about 200 user creations and removals. Accumulated over
>>>    ~280 packages, that adds a significant time to user creation,
>>>    making perf benchmarks unreliable."
>>>
>>> * Hashtable lookup is only O(1) when n < the number of buckets.
>>>
>>> Changes in V2:
>>> -The hashtable uses sidtab_entry_leaf objects directly so these
>>> objects are shared between the sid_to_context lookup tree and the
>>> context_to_sid hashtable. This simplifies memory allocation and
>>> was suggested by Ondrej Mosnacek.
>>> -The new sidtab hash stats file in selinuxfs has been moved out of
>>> the avc dir and into a new "ss" dir.
>>>
>>> V3:
>>> -Add lock nesting notation.
>>>
>>> V4/V5:
>>> -Moved to *_rcu variants of the various hashtable functions
>>> as suggested by Will Deacon.
>>> -Naming/spelling fixups.
>>>
>>> V6
>>> -Remove nested locking. Use lock of active sidtab to gate
>>> access to the new sidtab.
>>> -Remove use of rcu_head/kfree_rcu(), they're unnecessary because
>>> hashtable objects are never removed when read/add operations are
>>> occurring. Why is this safe? Quoting Ondrej Mosnacek from the
>>> selinux mailing list:
>>> "It is not visible in this patch, but the sidtab (along with other
>>> policy-lifetime structures) is protected by a big fat read-write lock.
>>> The only places where sidtab_destroy() is called are (a) error paths
>>> when initializing a new sidtab (here the sidtab isn't shared yet, so
>>> no race) and (b) when freeing the old sidtab during policy reload - in
>>> this case it is happening after a policy write-locked critical
>>> section, which had removed the old sidtab pointer from the shared
>>> structures, so at that point all sidtab readers will already be
>>> accessing the new sidtab and the old one is visible only by the thread
>>> doing the destruction."
>>>
>>> V7
>>> -Change format of /sys/fs/selinux/ss/sidtab_hash_stats to match
>>> /sys/fs/selinux/avc/hash_stats.
>>> -Add __rcu annotation to rcu pointers.
>>> -Test with CONFIG_SPARSE_RCU_POINTER and CONFIG_PROVE_RCU.
>>> -Add rcu@vger.kernel.org and Paul McKenney to Cc for review of the
>>> RCU logic.
>>
>> Also, the hash function doesn't seem to be very good; after booting 
>> Fedora with this patch, cat /sys/fs/selinux/ss/sidtab_hash_stats shows:
>> entries: 2571
>> buckets used: 152/512
>> longest chain: 1008
> 
> Curiously, running load_policy to reload policy once after boot improves 
> the situation markedly:
> $ cat /sys/fs/selinux/ss/sidtab_hash_stats
> entries: 2587
> buckets used: 490/512
> longest chain: 13
> 
> I'm not clear on what is happening there.

Hmm...are you always setting context->hash before inserting the entry?
Contexts loaded from the policydb won't have them...

> 
>>
>>
>>>
>>> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
>>> Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
>>> Reported-by: Jovana Knezevic <jovanak@google.com>
>>> ---
>>>   security/selinux/Kconfig            |  12 ++
>>>   security/selinux/include/security.h |   1 +
>>>   security/selinux/selinuxfs.c        |  65 +++++++
>>>   security/selinux/ss/context.h       |  11 +-
>>>   security/selinux/ss/policydb.c      |   5 +
>>>   security/selinux/ss/services.c      |  83 +++++++--
>>>   security/selinux/ss/services.h      |   4 +-
>>>   security/selinux/ss/sidtab.c        | 263 ++++++++++++++--------------
>>>   security/selinux/ss/sidtab.h        |  18 +-
>>>   9 files changed, 300 insertions(+), 162 deletions(-)
>>>
> 

