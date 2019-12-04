Return-Path: <SRS0=lyW+=Z2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D92C3F68F
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 15:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8332073B
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 15:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="TE3r4MzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfLDPso (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:48:44 -0500
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:60788 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfLDPsn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Dec 2019 10:48:43 -0500
X-EEMSG-check-017: 54084053|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,277,1571702400"; 
   d="scan'208";a="54084053"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Dec 2019 15:48:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575474521; x=1607010521;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=03WeiBGmDwbhCXcA8ZS63ILEUJPR9zKbpTQkSndm6rU=;
  b=TE3r4MzRV7f6VWzc9XS+y5sAGL7iiVJeNLCMhXKXm4PhtODzUU3okb5l
   9zP5qIsSUUy68NBbYMHxg89LHdYmcc5OQyorBvjoig30/yR47jDVZDXe5
   xy7ghM9rMkB0HmuuxiTVN4GlspHX002nRb00UnnpyxYYU7W6a3Hvud5pI
   porM8liP6QUePYk14eHlrIxP3cG99ePDwCdLDapf6YchOGRuEfYk7lsXt
   oMxPWwnJ9XYk3rw4ABZuVEQTZPD+xrl4Mys+w929y0b3eQoRv/BLTRe3D
   vlYwUfvHnhOzBNL+Y0KUSL/SW6AmJ88BQV9/4bcLTAZgTIFZF48AJ5JV4
   A==;
X-IronPort-AV: E=Sophos;i="5.69,277,1571702400"; 
   d="scan'208";a="30748261"
IronPort-PHdr: =?us-ascii?q?9a23=3AwAzPYRLYw68mV6jEDNmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKPT7rarrMEGX3/hxlliBBdydt6sfzbOJ4uu/BiQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngi6oAfVu8UZg4ZvKLs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1cQqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1wavSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0sRGFovTw1yrwAuZ?=
 =?us-ascii?q?OjcygKyYgnxxrFZPOcaYSH/hXjVOOJLTd3hXJlZLK/hwup/kS61uL8Ucy03V?=
 =?us-ascii?q?BXpSRGitnBrm0B2hPc58SdSvZx412t1SiA2gzN8O1IPEY5nrfBJZE72L4/jJ?=
 =?us-ascii?q?8TvFzGHi/xhUr5krebdl4h+ui08+TnZajmpoOEO490lA7+NqMul9SjAesiKA?=
 =?us-ascii?q?gOXnWb+f+m2L3i+035TrJKjuYonabFqpzaOcQaqbK5Aw9SyIoj7QqwDyy639?=
 =?us-ascii?q?gCmHkHLVZFdAqGj4jvJV7OPOj1Aeqwjlmjijtmx+3KMqf/DpjCMHTPiqrtca?=
 =?us-ascii?q?5460FGyQozyd5f54hTCrEEOP/zQVL+tMfDAx8lMw273+bnCNJn2oMYQmKAGL?=
 =?us-ascii?q?WVMKzVsV+W/u4vOfWDZJcJuDbhLPgo//nujXo+mV8Ge6mmx4cYZ26jE/R8PU?=
 =?us-ascii?q?qWfHrsjc0dEWsQogU+S+nqgkWYUTFPf3ayQ7485jYjBYK+F4jDW4StjaeZ3C?=
 =?us-ascii?q?ihA51WYnlKClWLEXfvbYWLRe0AZz6VIs9kijYET6SuS5c91RGysw/307hnIf?=
 =?us-ascii?q?Ta+i0Wq5Luz9d15+rUlRE98Tx7Ed6R3H2KT2FxhmkIXSM53LhjoUxhzVeOyb?=
 =?us-ascii?q?N4jOJcFdxS4fNJTwg7OIXCz+x1Fd/yQBjNftSXR1a8RNWpHzUxQsg2w98UbE?=
 =?us-ascii?q?Z3A8+igQzb3yq2H78VkKSGBZI18qLY23j8PMV9xGjc1KknkVYmRtFDNWq8hq?=
 =?us-ascii?q?5w7wLTHZLGk12Fl6a2cqQRxDbN+32ezWqKuUFXTA1wXL7GXX8BfEvWq8r25k?=
 =?us-ascii?q?fYQ7+pE7QnPRNLydSeJatSdt3pkVJGSe/5ONvCfmK8gHmwBRmWybOWdobqeH?=
 =?us-ascii?q?sS3D/bCEcalwAf53GGNRIxBi25uWLRECRuFU7zY0Pr6eR+qnS7TlEuwAGMdU?=
 =?us-ascii?q?Jh1KG4+hEShfybRPMT2qwLtD09pDVzGVbul+7RXv2GqxBsfu15Zsg76VxK1i?=
 =?us-ascii?q?qNsAl6JZqpJK1KnFMScw1r+Ujp0kMzQr1JjMxiiXQt1gc6fbqRzVdpbzqF2d?=
 =?us-ascii?q?X1PbrNJy/5+xX5OIDM3VSL68qb4qcC7rwDrlznuAy4Xh45/25Pz8he03za4I?=
 =?us-ascii?q?7DSgUVT8SiAQ4M6xFmquSCMWEG7ITO2CgpaPPlvw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BJAACz1Odd/wHyM5BdCBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBfoFvBYEYVSASKoQriQOGYgaBN4EBiGiPXYEQA1QJAQEBAQEBA?=
 =?us-ascii?q?QEBLQoBAYRAAoI0OBMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYJuAQUjFTYLE?=
 =?us-ascii?q?AsOCgICJgICVwYBDAYCAQGCXz8BglIlD7BigTKFT4MxgUIGgQ4ojDF5gQeBE?=
 =?us-ascii?q?ScPgig1PoJkAgKBGyENgyiCXgSNMII0hw1GlxOCOII5hGaONQYbgkGMLYs4j?=
 =?us-ascii?q?kqIQY8EhG8iN4EhKwgCGAghDzuCbFARFIxxAReDUIpxIwMwjzaCMgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Dec 2019 15:48:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB4FmSn3094290;
        Wed, 4 Dec 2019 10:48:28 -0500
Subject: Re: [PATCH v9] selinux: sidtab: reverse lookup hash table
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Jovana Knezevic <jovanak@google.com>
References: <20191122093306.17335-1-jeffv@google.com>
 <CAHC9VhQ-piMePyfOeLsrAtgSCG5iWjk9xFbjOvURe3WLD-z89g@mail.gmail.com>
 <CAFqZXNun_-aWx19UKUMfiYuQuttxCgMOoAczBAddDv3yaCZyxw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ce68c5cf-ca29-a6b6-92ff-9426f122a368@tycho.nsa.gov>
Date:   Wed, 4 Dec 2019 10:48:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFqZXNun_-aWx19UKUMfiYuQuttxCgMOoAczBAddDv3yaCZyxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/4/19 4:11 AM, Ondrej Mosnacek wrote:
> On Tue, Dec 3, 2019 at 1:33 AM Paul Moore <paul@paul-moore.com> wrote:
>> On Fri, Nov 22, 2019 at 4:33 AM Jeff Vander Stoep <jeffv@google.com> wrote:
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
>>>    BUG: kernel softlockup due to too many SIDs/contexts #37
>>>    https://github.com/SELinuxProject/selinux-kernel/issues/37
>>> - Jovana Knezevic on Android's bugtracker.
>>>    Bug: 140252993
>>>    "During multi-user performance testing, we create and remove users
>>>    many times. selinux_android_restorecon_pkgdir goes from 1ms to over
>>>    20ms after about 200 user creations and removals. Accumulated over
>>>    ~280 packages, that adds a significant time to user creation,
>>>    making perf benchmarks unreliable."
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
>>>
>>> V8
>>> -Removed the __rcu annotation used in V7. The annotation is
>>> intended to be applied to pointers to an object, however the
>>> objects referenced in the rcu hashtable are allocated in an
>>> array.
>>> -Fixed bug where multiple SIDs were receiving the same hash
>>> due to security_get_user_sids() reusing the same context
>>> struct without calling context_init() on it. This bug was
>>> discovered and root-caused by Stephen Smalley.
>>>
>>> V9
>>> -Do not compute the hash in string_to_context_struct
>>> because this string representation is non-canonical.
>>>
>>> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
>>> Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
>>> Reported-by: Jovana Knezevic <jovanak@google.com>
>>> ---
>>>   security/selinux/Kconfig            |  12 ++
>>>   security/selinux/include/security.h |   1 +
>>>   security/selinux/selinuxfs.c        |  65 +++++++
>>>   security/selinux/ss/context.h       |  11 +-
>>>   security/selinux/ss/policydb.c      |   5 +
>>>   security/selinux/ss/services.c      |  96 +++++++---
>>>   security/selinux/ss/services.h      |   4 +-
>>>   security/selinux/ss/sidtab.c        | 263 ++++++++++++++--------------
>>>   security/selinux/ss/sidtab.h        |  16 +-
>>>   9 files changed, 306 insertions(+), 167 deletions(-)
>>
>> Thanks Jeff, as well as everyone else who contributed reviews and feedback.
>>
>> I've pulled this into a working branch and I'll be merging it with the
>> other sidtab patches before posting it to a "next-queue" branch for
>> review later this week.  When done, I'll send a note to the list, as
>> well as the relevant patch authors; your help in reviewing the merge
>> would be greatly appreciated.
> 
> I tried doing the merge on my own here [1], you can use it as a sanity
> check if we came to the same/similar result. I based it off your
> existing next-queue, which contains only Jeff's patch at the time of
> writing. I only build-tested it so far.
> 
> Note that there are two whitespace cleanups included in the string
> cache commit that I intuitively did while resolving the merge
> conflicts. You might want to move those to the first commit or just
> ignore them.
> 
> [1] https://gitlab.com/omos/linux-public/compare/selinux-next...rebase-selinux-sidtab-string-cache

FWIW, this merge tested successfully for me.  Looks like we can't 
leverage the cached strings for the reverse hash computation rather than 
dynamically generating the string since we don't yet have a sidtab entry 
at that point IIUC.

