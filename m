Return-Path: <SRS0=kJrL=Y5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28D7C5DF60
	for <selinux@archiver.kernel.org>; Tue,  5 Nov 2019 18:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8F5206BA
	for <selinux@archiver.kernel.org>; Tue,  5 Nov 2019 18:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DfCSsAl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390485AbfKESnr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:43:47 -0500
Received: from UHIL19PA36.eemsg.mail.mil ([214.24.21.195]:45926 "EHLO
        UHIL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390432AbfKESnq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Nov 2019 13:43:46 -0500
X-EEMSG-check-017: 45829214|UHIL19PA36_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,271,1569283200"; 
   d="scan'208";a="45829214"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Nov 2019 18:43:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572979423; x=1604515423;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gEmdpAvsQslqUiaxnwLaUuq3TYNAfCJtDhqpnxuoy5g=;
  b=DfCSsAl+aXs2q2xyHgJ/EOQN1w7xV22yuY2O5hsB2zhok7qsjYaKwQJg
   TVcREZdOmV3fFY9NLOSTRZqINdsNZlB0aCBCFBXU6XMmO5NS//4fMlIWb
   m6HucborcuZKEnu7/VWBPWSha0Tan8jR0BFUfs1Kv7WF5IZrVhVE5eR4i
   GbNtTyGNzEgSZPqCUxr4g0/FCcqjei5wAVfmZnS9axO4V28ewUoFXbDEh
   fdZ2BsvsELqwH0jvH/sqtruGeXTVUc7vlW+JP+DCHn5MF2bJuSV0Vase1
   u/nOJ76kwnu1DcUieXD+D3hgUrs3ZIfUaeMy3WI0fQB82i29iWBNYHIH7
   w==;
X-IronPort-AV: E=Sophos;i="5.68,271,1569283200"; 
   d="scan'208";a="29782615"
IronPort-PHdr: =?us-ascii?q?9a23=3A6hJ/Jx/0SaIJkf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0+4VIJqq85mqBkHD//Il1AaPAdyArasd1qGP6v2ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBmrrQjdudQajZZiJ60s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BfWCxbBoO3cpUBAewPM+1Fq4XxvlUDoB+7CQSqGejhyCJHhmXu0KMnze?=
 =?us-ascii?q?ohHwHI0g8uEd0Av3vbrsn6OqgJXOCpzqTF1ynPY+9Y1Dr/7oXDbxAvoeuLXb?=
 =?us-ascii?q?J1acff1FUvGB3djlWQt4PlOS6e2PkIs2eB6+pgUfygim46oAx2uTig29wsh5?=
 =?us-ascii?q?LVhoMV1l/E9SJ5zJwzJd2jUkF3e9GkEJxOtyyDMYZ9X80sQ2ZtuCkgy70Gv4?=
 =?us-ascii?q?a2fCcLyJQ7xx7fdueIf5KU7RLkUeacJypzinF9eL+nmhq//ketxvf8W8Wpyl?=
 =?us-ascii?q?pGsCVInsfWunwQ0RHY99KJReFn/ki73DaCzwXT6uZZLk8qjafbMJshwqIolp?=
 =?us-ascii?q?oUrETDAjf6mEXog6+ScUUp4vSo5P79YrXnu5+cLJV4ih3+M6symsy/Bv40Mg?=
 =?us-ascii?q?4SUGiA5euwzrjj/Uz9QLlSj/02lLfWsIzCKMgGqaO0DBVZ34Y+5xqlETur38?=
 =?us-ascii?q?oUkWMaIF5dfRKIlYnpO1XAIPDiCve/hkyhkCx2yPDdJbDhHpXMIWTDkLfmZ7?=
 =?us-ascii?q?p97VVcxxApwdBQ4JJUFKkNIOjvVU/pqNzYEhg5PhSzw+biD9V9zYUeVniTDa?=
 =?us-ascii?q?CHK67Sq0GH6f8vI+aWeI8ZoiryK/8g5/T2l382hUcdfbW13ZsQcH24HOppI0?=
 =?us-ascii?q?uXYXrymdoBHmAKvg0xTOzullKOSyJcZ3G3X6gk/DE0FJqmDZvfRoCqmLGBxz?=
 =?us-ascii?q?m0HplXZmBAF1CNHmzld5uLW/gSciKeOMxhnSIeVbinVYAh0QuitAjgy7poNu?=
 =?us-ascii?q?DU4DEXtYr/1Nhp4O3ejRMy9TtqD8uH1WGCVWJ0k3gHRz8x26B/rkh9xUmZ3a?=
 =?us-ascii?q?dkhPxYEI8b2/QcdQE2L5Peh8l9ENb7UQ/CNoOOTVG9RNytDBkrQ94xysNIaE?=
 =?us-ascii?q?F4TZHqrB3N0WKUCrkZmqbDP4Az/7qUi3r8Kchj43nB06Ylgh8tRc4ZZkO8ga?=
 =?us-ascii?q?sqzBTeH47ElQ2ikq+ucakNlHrW+Hyr0XuFvEYeVhV5F6rCQyZMNQPtsd3l6x?=
 =?us-ascii?q?aaHPeVArM9P14EkJXTJw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DiAABTwsFd/wHyM5BeCBsBAQEBAQEBBQEBAREBAQMDA?=
 =?us-ascii?q?QEBgX6BdCxsVAEyKoQpj2EBAQEBAQEGgTZ/iGWPXIEQA1QJAQEBAQEBAQEBK?=
 =?us-ascii?q?wkBAgEBgUyCdAKEDiQ4EwIOAQEBBAEBAQEBBQMBAWyFNwyCOykBgmwBAQEBA?=
 =?us-ascii?q?gEjBBEzDhALDgoCAiYCAlcGAQwGAgEBgl8eFwoBglIFIA+wOHV/M4VOgyqBQ?=
 =?us-ascii?q?gaBDiiMFBh4gQeBESeCNjU+gmICgTwNgyiCXgSNFohGYUSWdYIugjSEYY4hB?=
 =?us-ascii?q?huCPIwMiyGOQ4gukz8iN4EhKwgCGAghDzuCbFARFIMRAReDUIpxIwMwgQUBA?=
 =?us-ascii?q?ZEMAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 05 Nov 2019 18:43:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xA5IhbED029138;
        Tue, 5 Nov 2019 13:43:37 -0500
Subject: Re: [PATCH v2] selinux: sidtab: reverse lookup hash table
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Jeff Vander Stoep <jeffv@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jovana Knezevic <jovanak@google.com>
References: <20191104191535.23642-1-jeffv@google.com>
 <CAFqZXNvgcnYDER9aoV5aUfLL=jwDdoTs3EroOYchK+6PMWsO+w@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ea72bc7a-b30d-b752-8bd1-f36ed26be4c9@tycho.nsa.gov>
Date:   Tue, 5 Nov 2019 13:43:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNvgcnYDER9aoV5aUfLL=jwDdoTs3EroOYchK+6PMWsO+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/5/19 8:28 AM, Ondrej Mosnacek wrote:
> On Mon, Nov 4, 2019 at 8:15 PM Jeff Vander Stoep <jeffv@google.com> wrote:
>> This replaces the reverse table lookup and reverse cache with a
>> hashtable which improves cache-miss reverese-lookup times from
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
>> This change also maintains the improvement introduced in commit
>> ee1a84fd which removed the need to keep the current sidtab locked
>> during policy reload. It does however introduce periodic locking of
>> the target sidtab while converting the hashtable. Sidtab entries
>> are never modified or removed, so the context struct stored in the
>> sid_to_context tree can also be used for the context_to_sid
>> hashtable to reduce memory usage.
>>
>> This bug was reported by:
>> - Stephen Smally on the selinux bug tracker.
>>    BUG: kernel softlockup due to too many SIDs/contexts #37
>>    https://github.com/SELinuxProject/selinux-kernel/issues/37
>> - Jovana Knezevic on Android's bugtracker.
>>    Bug: 140252993
>>    "During multi-user performance testing, we create and remove users
>>    many times. selinux_android_restorecon_pkgdir goes from 1ms to over
>>    20ms after about 200 user creations and removals. Accumulated over
>>    ~280 packages, that adds a significant time to user creation,
>>    making perf benchmarks unreliable."
>>
>> * Hashtable lookup is only O(1) when n < the number of buckets.
>>
>> Changes in V2:
>> -The hashtable uses sidtab_entry_leaf objects directly so these
>> objects are shared between the sid_to_context lookup tree and the
>> context_to_sid hashtable.
>> -Move the hash_add() statement to after the smp_store_release()
>> to ensure that the contents have been written before the object
>> becomes available in the hashtable.
>> -The new sidtab hash stats file in selinuxfs has been moved out of
>> the avc dir and into a new "ss" dir.
>>
>> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
>> Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
>> Reported-by: Jovana Knezevic <jovanak@google.com>
>> ---
>>   security/selinux/Kconfig            |  12 ++
>>   security/selinux/include/security.h |   1 +
>>   security/selinux/selinuxfs.c        |  64 +++++++
>>   security/selinux/ss/context.h       |  11 +-
>>   security/selinux/ss/policydb.c      |   5 +
>>   security/selinux/ss/services.c      |  87 +++++++---
>>   security/selinux/ss/services.h      |   4 +-
>>   security/selinux/ss/sidtab.c        | 249 +++++++++++++---------------
>>   security/selinux/ss/sidtab.h        |  16 +-
>>   9 files changed, 287 insertions(+), 162 deletions(-)
>>
>> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
>> index 5711689deb6a..2d9788ad2d77 100644
>> --- a/security/selinux/Kconfig
>> +++ b/security/selinux/Kconfig
>> @@ -85,3 +85,15 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
>>            via /selinux/checkreqprot if authorized by policy.
>>
>>            If you are unsure how to answer this question, answer 0.
>> +
>> +config SECURITY_SELINUX_SIDTAB_HASH_BITS
>> +       int "NSA SELinux sidtab hashtable size"
>> +       depends on SECURITY_SELINUX
>> +       range 8 13
>> +       default 9
>> +       help
>> +         This option sets the number of buckets used in the sitab hashtable
>> +         to 2^SECURITY_SELINUX_SIDTAB_HASH_BITS buckets. The number of hash
>> +         collisions may be viewed at /selinux/ss/sidtab_hash_stats. If chain
>> +         lengths are high (e.g. > 20) than selecting a higher value here will
> 
> s/than/then/
> 
>> +         ensure that lookups times are fast and stable.
> 
> lookup times are short and stable
> 
> <snip>
> 
>> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
>> index 7d49994e8d5f..31cdb4848d67 100644
>> --- a/security/selinux/ss/sidtab.c
>> +++ b/security/selinux/ss/sidtab.c
>> @@ -17,26 +17,37 @@
>>   #include "security.h"
>>   #include "sidtab.h"
>>
>> +#define index_to_sid(index) (index + SECINITSID_NUM + 1)
>> +#define sid_to_index(sid) (sid - (SECINITSID_NUM + 1))
>> +
>>   int sidtab_init(struct sidtab *s)
>>   {
>>          u32 i;
>>
>>          memset(s->roots, 0, sizeof(s->roots));
>>
>> -       /* max count is SIDTAB_MAX so valid index is always < SIDTAB_MAX */
>> -       for (i = 0; i < SIDTAB_RCACHE_SIZE; i++)
>> -               s->rcache[i] = SIDTAB_MAX;
>> -
>>          for (i = 0; i < SECINITSID_NUM; i++)
>>                  s->isids[i].set = 0;
>>
>>          s->count = 0;
>>          s->convert = NULL;
>> +       hash_init(s->context_to_sid);
>>
>>          spin_lock_init(&s->lock);
>>          return 0;
>>   }
>>
>> +static u32 context_to_sid(struct sidtab *s, struct context *context)
>> +{
>> +       struct sidtab_entry_leaf *entry;
>> +
>> +       hash_for_each_possible(s->context_to_sid, entry, list, context->hash) {
>> +               if (context_cmp(&entry->context, context))
>> +                       return entry->sid;
> 
> For this to be semantically safe against entries being added, it would
> need the hlist head -> first member to be read with
> smp_load_acquire(). Probably in practice you would always get fresh
> data when dereferencing a pointer, but I don't think we should rely on
> that... In fact it looks like hash_for_each_possible() wasn't really
> written with lockless traversal in mind - I checked a few random
> places that call it and they all either do it under some lock or
> expect the table to be immutable. I believe you will need to introduce
> a new equivalents of hash_add()/hlist_add_head() (that does
> smp_store_release() instead of WRITE_ONCE(), because the 'next'
> pointer of the node being added must be written before the head's
> first pointer is set to point to the new node) and
> hash_for_each_possible()/hlist_for_each_entry() (that loads
> (head)->first with smp_load_acquire()).

This is a good point; I don't see that you can safely use hash_add() and 
hash_for_each_possible() safely with a completely lockless read code 
path.  So you either have to create (or find) variants that do the right 
things here or perform locking on the read path.

> 
> Then again, I'm not an expert on this synchronization stuff, so I
> might be wrong... But you will have to prove it :)
> 
>> +       }
>> +       return 0;
>> +}
>> +
> 
> I am a little uneasy about this function having the same name as the
> context_to_sid() in security.c. It could be confusing when debugging.
> Maybe you could name the security.c function to
> context_struct_to_sid()?
> 
>>   int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
>>   {
>>          struct sidtab_isid_entry *entry;
> 
> <snip>
> 
>> @@ -305,29 +275,35 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>>                  rc = -ENOMEM;
>>                  dst_convert = sidtab_do_lookup(convert->target, count, 1);
>>                  if (!dst_convert) {
>> -                       context_destroy(dst);
>> +                       context_destroy(&dst->context);
>>                          goto out_unlock;
>>                  }
>>
>> -               rc = convert->func(context, dst_convert, convert->args);
>> +               rc = convert->func(context, &dst_convert->context,
>> +                               convert->args);
>>                  if (rc) {
>> -                       context_destroy(dst);
>> +                       context_destroy(&dst->context);
>>                          goto out_unlock;
>>                  }
>> +               dst_convert->sid = index_to_sid(count);
>>
>>                  /* at this point we know the insert won't fail */
>> +               spin_lock_irqsave(&convert->target->lock, flags);
>>                  convert->target->count = count + 1;
>> +               hash_add(convert->target->context_to_sid,
>> +                        &dst_convert->list, dst_convert->context.hash);
>> +               spin_unlock_irqrestore(&convert->target->lock, flags);
> 
> Do we really need to lock the conversion target here? The
> (undocumented) contract here was that as long as the conversion is in
> progress, the target sidtab is "owned" by the master sidtab and any
> modifications of it would be done under the master's spinlock (the
> target's spinlock wouldn't be used until it is swapped-in to be the
> new master). Did this contract change with your patch? I think this
> nested locking is the cause of the lock warning that Stephen is
> getting so hopefully you can fix it by simply removing this extra
> locking.
> 
> <snip>
> 
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
> 

