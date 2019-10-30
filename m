Return-Path: <SRS0=VtUM=YX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4BACA9EC5
	for <selinux@archiver.kernel.org>; Wed, 30 Oct 2019 17:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A0C20659
	for <selinux@archiver.kernel.org>; Wed, 30 Oct 2019 17:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Y6ygemDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfJ3ROi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:14:38 -0400
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:62325 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfJ3ROi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Oct 2019 13:14:38 -0400
X-EEMSG-check-017: 22462680|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,248,1569283200"; 
   d="scan'208";a="22462680"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Oct 2019 17:14:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572455674; x=1603991674;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=G9OIyh76rIP2ujTeVj+sLpQspx9OmZplx0ztOgMOlEA=;
  b=Y6ygemDR+9E0A7u1O1ZbgyGK1wV8fLOQgXCVqitFHr3wUuHdJNU0GUoh
   rl4gZWWxPnfPmlKYoplUke8k7vYqUqIi8Fa2PkStianRUZ/eLWcPYbRkT
   iJOUZ/dWTTMO+q190Ahjbspk8dJ8xAzrtLoM3hDyNfnyIikUonokf5JRP
   nQn9A1Rqs5qs4mgY6KkgvxVEfmbUTfKykDoEQfA3upGbry4qesCQO9+rZ
   UkdcNiQGP0HglNybMUynXNMjIwsjOD9Y5LEbStBXxXTh24e5b3B1cQ3Cn
   +5a1yCDZqim09Mva7cKFl57Tm6NZnA6pZ9jfWXLIYV0iSUckgMRsjPUvq
   g==;
X-IronPort-AV: E=Sophos;i="5.68,248,1569283200"; 
   d="scan'208";a="29570374"
IronPort-PHdr: =?us-ascii?q?9a23=3AsNZggxMBoyxAOtbqF1Ul6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/zzp8bcNUDSrc9gkEXOFd2Cra4d0KyP6/urCDJIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQnNuMQajo9vJ6cswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcDox+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?ohDw/G0g8uEdwAv3vbrtr6KKgcXPupzKTL1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsTWZouCMgxb0Hv5?=
 =?us-ascii?q?62ZCcKyJU7xx7fdvyIaJKE7Q7kVOaUJzpzmXFreKqnihqv/kWtxffwW8mp3F?=
 =?us-ascii?q?pQsCZIncfAumoQ2xHV98OJUOFy/l271jaKzw3T7+ZELl0qmqfDMJ4hx6Iwlo?=
 =?us-ascii?q?IUsUTeAi/6gEX2g7GSdkUj4uWo9/7oYq/npp+BLI94kB3+M6Qylcy/BuQ0KA?=
 =?us-ascii?q?4OUHSA+eugzrHj+Ez5QLFSgv03lKnWrozaKNwGqqO2DAJZyIYu5wulAzu439?=
 =?us-ascii?q?kUg2MLIE9ddBKClYfpOlXOIP7iDfe4hlShiCxryO3dPrD6HpXMLmTMkLfmfb?=
 =?us-ascii?q?pn7U5c0xA8wcpQ55JTFLENOOjzVVPptNzEEh85NBS5w+T5B9Vz2IMeR3mCAq?=
 =?us-ascii?q?CeMKPVvl+I4vwgL/OQa48SvTb3M+Il6OL2jX8lhV8derGk3YAJZ3C8H/RmJV?=
 =?us-ascii?q?iZYHX3j9cfHmcFoBA+QPbpiFKcSz5TYWi9X6Ym6jE8EoKmAp/JRpqxj7yZwC?=
 =?us-ascii?q?e7AppWa3hEClCLD3fnbYOEVO0PaC+JLc9hlTsEVbelS4A/zx2hqAj6y79/JO?=
 =?us-ascii?q?rO5iIYrY7j1MRy5+DLkhEy8Dt0D9+b026XU257gHgFRyUo069ioUxy0EuD3b?=
 =?us-ascii?q?JkjPxfENxZ/+lJXRsiNZ7A0+x6DMj/WhrbcdeUTFarWc2mDissTtI12tMOZk?=
 =?us-ascii?q?F9G9K4jh/dxSalH7gVl7nYTKAzp4DR0Xa5Gc97x3vcnJI9iFQ+Cp9NOGOomI?=
 =?us-ascii?q?Zw8A/cA4OPmEKcweLibqkY3SjQ5E+dwmeU+kJVSgh9VePCR39MSFHRqIHC+k?=
 =?us-ascii?q?7aT7KoQY8iOw9FxN/KfrBGcfX1nF5GQ7HlI92YbGWvzTTjTS2Uz6+BOdK5M1?=
 =?us-ascii?q?4W2z/QXQ1dyFEe?=
X-IPAS-Result: =?us-ascii?q?A2CfAAC5w7ld/wHyM5BdCBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBfYF0LGxVMiqEKI9ZAQEBBoERJX+IZIVFigWBEANUCQEBAQEBA?=
 =?us-ascii?q?QEBASsJAQIBAYRAAoNmJDgTAgwBAQEEAQEBAQEFAwEBbIU3DII7KQGCbQEFG?=
 =?us-ascii?q?gEIBAsBBUEQCQIYAgImAgJXBgEMBgIBAYJfPwGCUiUPl0+bcX8ziQ+BSIEOK?=
 =?us-ascii?q?IwRGHiBB4ERJwyCKjU+gmICgTwNgyiCXgSMbxoKiluWAIIugjOEXY4bBhuCP?=
 =?us-ascii?q?HKLFosajkCILJMzIjeBISsIAhgIIQ87gmwJRxAUgw8CAReDUIVChS0lAzCBB?=
 =?us-ascii?q?QEBjWUBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 Oct 2019 17:14:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9UHEVRb018503;
        Wed, 30 Oct 2019 13:14:31 -0400
Subject: Re: [PATCH] selinux: sidtab: reverse lookup hash table
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Jeff Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org
Cc:     Jovana Knezevic <jovanak@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
References: <20191030101949.191788-1-jeffv@google.com>
 <b48c1e53-f51a-8e56-967b-79e2e8d6daa4@tycho.nsa.gov>
 <6d623c38-320a-4660-2305-87dd562eb39a@tycho.nsa.gov>
 <b6cd9f11-789e-ceea-2a2d-441d7c6346ff@tycho.nsa.gov>
Message-ID: <30b43801-7e68-406a-1916-4fdce3225a2e@tycho.nsa.gov>
Date:   Wed, 30 Oct 2019 13:14:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b6cd9f11-789e-ceea-2a2d-441d7c6346ff@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/30/19 12:36 PM, Stephen Smalley wrote:
> On 10/30/19 12:32 PM, Stephen Smalley wrote:
>> On 10/30/19 11:24 AM, Stephen Smalley wrote:
>>> On 10/30/19 6:19 AM, Jeff Vander Stoep wrote:
>>>> This replaces the reverse table lookup and reverse cache with a
>>>> hashtable which improves cache-miss reverese-lookup times from
>>>> O(n) to O(1) and maintains the same performance as a reverse
>>>> cache hit.
>>>>
>>>> This reduces the time needed to add a new sidtab entry from ~500us
>>>> to 5us on a Pixel 3 when there are ~10,000 sidtab entries.
>>>>
>>>> The implementation uses the kernel's generic hashtable API,
>>>> It uses the context's string represtation as the hash source,
>>>> and the kernels generic string hashing algorithm full_name_hash()
>>>> to reduce the string to a 32 bit value.
>>>>
>>>> This change also maintains the improvement introduced in commit
>>>> ee1a84fd which removed the need to keep the current sidtab locked
>>>> during policy reload. It does however introduce periodic locking of
>>>> the target sidtab while converting the hashtable. Sidtab entries
>>>> are never modified or removed, so the context struct stored in the
>>>> sid_to_context tree can also be used for the context_to_sid
>>>> hashtable to reduce memory usage.
>>>>
>>>> This bug was reported by:
>>>> - Stephen Smally on the selinux bug tracker.
>>>>    BUG: kernel softlockup due to too many SIDs/contexts #37
>>>>    https://github.com/SELinuxProject/selinux-kernel/issues/37
>>>> - Jovana Knezevic on Android's bugtracker.
>>>>    Bug: 140252993
>>>>    "During multi-user performance testing, we create and remove users
>>>>    many times. selinux_android_restorecon_pkgdir goes from 1ms to over
>>>>    20ms after about 200 user creations and removals. Accumulated over
>>>>    ~280 packages, that adds a significant time to user creation,
>>>>    making perf benchmarks unreliable."
>>
>> Something went very wrong with my system after running the selinux 
>> testsuite; it started triggering entrypoint denials in various 
>> situations that should have not checked entrypoint at all.  I assume 
>> this means that security_transition_sid() started returning new, 
>> different SIDs for processes for the same context and therefore 
>> selinux_bprm_set_creds() applied an ENTRYPOINT check instead of an 
>> EXECUTE_NO_TRANS check.
> 
> So the likely reproduction case would be to add some types to policy, 
> reload, use contexts with those types to allocate SIDs for them, remove 
> the types from the policy, reload again.

Looks like you aren't setting the hash for newc in the two cases where 
it is left unmapped.  Not sure why it would manifest that way though.

> 
>>
>>>>
>>>> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
>>>> Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>> Reported-by: Jovana Knezevic <jovanak@google.com>
>>>> ---
>>>>   security/selinux/include/security.h |   1 +
>>>>   security/selinux/selinuxfs.c        |  27 +++
>>>>   security/selinux/ss/context.h       |   9 +
>>>>   security/selinux/ss/policydb.c      |   5 +
>>>>   security/selinux/ss/services.c      |  81 +++++---
>>>>   security/selinux/ss/services.h      |   4 +-
>>>>   security/selinux/ss/sidtab.c        | 283 
>>>> ++++++++++++++++------------
>>>>   security/selinux/ss/sidtab.h        |  20 +-
>>>>   8 files changed, 283 insertions(+), 147 deletions(-)
>>>>
>>>> diff --git a/security/selinux/include/security.h 
>>>> b/security/selinux/include/security.h
>>>> index ae840634e3c7..8c0dbbd076c6 100644
>>>> --- a/security/selinux/include/security.h
>>>> +++ b/security/selinux/include/security.h
>>>> @@ -395,5 +395,6 @@ extern int selinux_nlmsg_lookup(u16 sclass, u16 
>>>> nlmsg_type, u32 *perm);
>>>>   extern void avtab_cache_init(void);
>>>>   extern void ebitmap_cache_init(void);
>>>>   extern void hashtab_cache_init(void);
>>>> +extern int security_sidtab_hash_stats(struct selinux_state *state, 
>>>> char *page);
>>>>   #endif /* _SELINUX_SECURITY_H_ */
>>>> diff --git a/security/selinux/selinuxfs.c 
>>>> b/security/selinux/selinuxfs.c
>>>> index ee94fa469c29..ebdec88d9ccb 100644
>>>> --- a/security/selinux/selinuxfs.c
>>>> +++ b/security/selinux/selinuxfs.c
>>>> @@ -1482,6 +1482,32 @@ static ssize_t sel_read_avc_hash_stats(struct 
>>>> file *filp, char __user *buf,
>>>>       return length;
>>>>   }
>>>> +static ssize_t sel_read_sidtab_hash_stats(struct file *filp, char 
>>>> __user *buf,
>>>> +                    size_t count, loff_t *ppos)
>>>> +{
>>>> +    struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
>>>> +    struct selinux_state *state = fsi->state;
>>>> +    char *page;
>>>> +    ssize_t length;
>>>> +
>>>> +    page = (char *)__get_free_page(GFP_KERNEL);
>>>> +    if (!page)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    length = security_sidtab_hash_stats(state, page);
>>>> +    if (length >= 0)
>>>> +        length = simple_read_from_buffer(buf, count, ppos, page,
>>>> +                        length);
>>>> +    free_page((unsigned long)page);
>>>> +
>>>> +    return length;
>>>> +}
>>>> +
>>>> +static const struct file_operations sel_sidtab_hash_stats_ops = {
>>>> +    .read        = sel_read_sidtab_hash_stats,
>>>> +    .llseek        = generic_file_llseek,
>>>> +};
>>>> +
>>>>   static const struct file_operations sel_avc_cache_threshold_ops = {
>>>>       .read        = sel_read_avc_cache_threshold,
>>>>       .write        = sel_write_avc_cache_threshold,
>>>> @@ -1572,6 +1598,7 @@ static int sel_make_avc_files(struct dentry *dir)
>>>>           { "cache_threshold",
>>>>             &sel_avc_cache_threshold_ops, S_IRUGO|S_IWUSR },
>>>>           { "hash_stats", &sel_avc_hash_stats_ops, S_IRUGO },
>>>> +        { "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUGO },
>>>
>>> Not sure that this belongs under /sys/fs/selinux/avc versus top-level 
>>> or a new sidtab dir since the sidtab is not part of the AVC.  Also, 
>>> checkpatch.pl whines about using S_IRUGO and prefers octal so maybe 
>>> we should be using octal for new files (@paul)?
>>>
>>>>   #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
>>>>           { "cache_stats", &sel_avc_cache_stats_ops, S_IRUGO },
>>>>   #endif
>>>> diff --git a/security/selinux/ss/context.h 
>>>> b/security/selinux/ss/context.h
>>>> index 513e67f48878..01fea944177d 100644
>>>> --- a/security/selinux/ss/context.h
>>>> +++ b/security/selinux/ss/context.h
>>>> @@ -31,6 +31,7 @@ struct context {
>>>>       u32 len;        /* length of string in bytes */
>>>>       struct mls_range range;
>>>>       char *str;    /* string representation if context cannot be 
>>>> mapped. */
>>>> +    u32 hash;    /* a hash of the string representation */
>>>>   };
>>>>   static inline void mls_context_init(struct context *c)
>>>> @@ -168,6 +169,7 @@ static inline int context_cpy(struct context 
>>>> *dst, struct context *src)
>>>>           kfree(dst->str);
>>>>           return rc;
>>>>       }
>>>> +    dst->hash = src->hash;
>>>>       return 0;
>>>>   }
>>>> @@ -182,6 +184,8 @@ static inline void context_destroy(struct 
>>>> context *c)
>>>>   static inline int context_cmp(struct context *c1, struct context *c2)
>>>>   {
>>>> +    if (c1->hash && c2->hash && (c1->hash != c2->hash))
>>>> +        return 0;
>>>>       if (c1->len && c2->len)
>>>>           return (c1->len == c2->len && !strcmp(c1->str, c2->str));
>>>>       if (c1->len || c2->len)
>>>> @@ -192,5 +196,10 @@ static inline int context_cmp(struct context 
>>>> *c1, struct context *c2)
>>>>           mls_context_cmp(c1, c2));
>>>>   }
>>>> +static inline unsigned int context_compute_hash(const char *s)
>>>> +{
>>>> +    return full_name_hash(NULL, s, strlen(s));
>>>> +}
>>>> +
>>>>   #endif    /* _SS_CONTEXT_H_ */
>>>> diff --git a/security/selinux/ss/policydb.c 
>>>> b/security/selinux/ss/policydb.c
>>>> index e20624a68f5d..e369b0092cdf 100644
>>>> --- a/security/selinux/ss/policydb.c
>>>> +++ b/security/selinux/ss/policydb.c
>>>> @@ -878,6 +878,11 @@ int policydb_load_isids(struct policydb *p, 
>>>> struct sidtab *s)
>>>>               sidtab_destroy(s);
>>>>               goto out;
>>>>           }
>>>> +        rc = context_add_hash(p, &c->context[0]);
>>>> +        if (rc) {
>>>> +            sidtab_destroy(s);
>>>> +            goto out;
>>>> +        }
>>>>           rc = sidtab_set_initial(s, c->sid[0], &c->context[0]);
>>>>           if (rc) {
>>>> diff --git a/security/selinux/ss/services.c 
>>>> b/security/selinux/ss/services.c
>>>> index a5813c7629c1..29076c15cdf7 100644
>>>> --- a/security/selinux/ss/services.c
>>>> +++ b/security/selinux/ss/services.c
>>>> @@ -1257,6 +1257,11 @@ static int context_struct_to_string(struct 
>>>> policydb *p,
>>>>   #include "initial_sid_to_string.h"
>>>> +int security_sidtab_hash_stats(struct selinux_state *state, char 
>>>> *page)
>>>> +{
>>>> +    return sidtab_hash_stats(state->ss->sidtab, page);
>>>> +}
>>>
>>> Should we be taking the policy read lock to avoid interleaving with 
>>> sidtab replacement on policy reload?
>>>
>>>> +
>>>>   const char *security_get_initial_sid_context(u32 sid)
>>>>   {
>>>>       if (unlikely(sid > SECINITSID_NUM))
>>>> @@ -1384,6 +1389,8 @@ static int string_to_context_struct(struct 
>>>> policydb *pol,
>>>>       int rc = 0;
>>>>       context_init(ctx);
>>>> +    /* hash the string before it gets mutated */
>>>> +    ctx->hash = context_compute_hash(scontext);
>>>>       /* Parse the security context. */
>>>> @@ -1442,6 +1449,7 @@ static int string_to_context_struct(struct 
>>>> policydb *pol,
>>>>       rc = -EINVAL;
>>>>       if (!policydb_context_isvalid(pol, ctx))
>>>>           goto out;
>>>> +
>>>>       rc = 0;
>>>>   out:
>>>>       if (rc)
>>>
>>> Try to avoid unrelated whitespace changes.
>>>
>>>> @@ -1449,6 +1457,42 @@ static int string_to_context_struct(struct 
>>>> policydb *pol,
>>>>       return rc;
>>>>   }
>>>> +int context_add_hash(struct policydb *policydb,
>>>> +             struct context *context)
>>>> +{
>>>> +    int rc;
>>>> +    char *str;
>>>> +    int len;
>>>> +
>>>> +    if (context->str) {
>>>> +        context->hash = context_compute_hash(context->str);
>>>> +    } else {
>>>> +        rc = context_struct_to_string(policydb, context,
>>>> +                          &str, &len);
>>>> +        if (rc)
>>>> +            return rc;
>>>> +        context->hash = context_compute_hash(str);
>>>> +        kfree(str);
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int context_to_sid(struct selinux_state *state,
>>>> +              struct context *context, u32 *sid)
>>>> +{
>>>> +    int rc;
>>>> +    struct sidtab *sidtab = state->ss->sidtab;
>>>> +    struct policydb *policydb = &state->ss->policydb;
>>>> +
>>>> +    if (!context->hash) {
>>>> +        rc = context_add_hash(policydb, context);
>>>> +        if (rc)
>>>> +            return rc;
>>>> +    }
>>>> +
>>>> +    return sidtab_context_to_sid(sidtab, context, sid);
>>>> +}
>>>> +
>>>>   static int security_context_to_sid_core(struct selinux_state *state,
>>>>                       const char *scontext, u32 scontext_len,
>>>>                       u32 *sid, u32 def_sid, gfp_t gfp_flags,
>>>> @@ -1501,7 +1545,7 @@ static int security_context_to_sid_core(struct 
>>>> selinux_state *state,
>>>>           str = NULL;
>>>>       } else if (rc)
>>>>           goto out_unlock;
>>>> -    rc = sidtab_context_to_sid(sidtab, &context, sid);
>>>> +    rc = context_to_sid(state, &context, sid);
>>>>       context_destroy(&context);
>>>>   out_unlock:
>>>>       read_unlock(&state->ss->policy_rwlock);
>>>> @@ -1805,7 +1849,7 @@ static int security_compute_sid(struct 
>>>> selinux_state *state,
>>>>               goto out_unlock;
>>>>       }
>>>>       /* Obtain the sid for the context. */
>>>> -    rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
>>>> +    rc = context_to_sid(state, &newcontext, out_sid);
>>>>   out_unlock:
>>>>       read_unlock(&state->ss->policy_rwlock);
>>>>       context_destroy(&newcontext);
>>>> @@ -2033,6 +2077,10 @@ static int convert_context(struct context 
>>>> *oldc, struct context *newc, void *p)
>>>>               goto bad;
>>>>       }
>>>> +    rc = context_add_hash(args->newp, newc);
>>>> +    if (rc)
>>>> +        goto bad;
>>>> +
>>>>       return 0;
>>>>   bad:
>>>>       /* Map old representation to string and save it. */
>>>> @@ -2280,9 +2328,7 @@ int security_port_sid(struct selinux_state 
>>>> *state,
>>>>       if (c) {
>>>>           if (!c->sid[0]) {
>>>> -            rc = sidtab_context_to_sid(sidtab,
>>>> -                           &c->context[0],
>>>> -                           &c->sid[0]);
>>>> +            rc = context_to_sid(state, &c->context[0], &c->sid[0]);
>>>>               if (rc)
>>>>                   goto out;
>>>>           }
>>>> @@ -2374,9 +2420,7 @@ int security_ib_endport_sid(struct 
>>>> selinux_state *state,
>>>>       if (c) {
>>>>           if (!c->sid[0]) {
>>>> -            rc = sidtab_context_to_sid(sidtab,
>>>> -                           &c->context[0],
>>>> -                           &c->sid[0]);
>>>> +            rc = context_to_sid(state, &c->context[0], &c->sid[0]);
>>>>               if (rc)
>>>>                   goto out;
>>>>           }
>>>> @@ -2416,14 +2460,10 @@ int security_netif_sid(struct selinux_state 
>>>> *state,
>>>>       if (c) {
>>>>           if (!c->sid[0] || !c->sid[1]) {
>>>> -            rc = sidtab_context_to_sid(sidtab,
>>>> -                          &c->context[0],
>>>> -                          &c->sid[0]);
>>>> +            rc = context_to_sid(state, &c->context[0], &c->sid[0]);
>>>>               if (rc)
>>>>                   goto out;
>>>> -            rc = sidtab_context_to_sid(sidtab,
>>>> -                           &c->context[1],
>>>> -                           &c->sid[1]);
>>>> +            rc = context_to_sid(state, &c->context[1], &c->sid[1]);
>>>>               if (rc)
>>>>                   goto out;
>>>>           }
>>>> @@ -2601,7 +2641,7 @@ int security_get_user_sids(struct 
>>>> selinux_state *state,
>>>>                            &usercon))
>>>>                   continue;
>>>> -            rc = sidtab_context_to_sid(sidtab, &usercon, &sid);
>>>> +            rc = context_to_sid(state, &usercon, &sid);
>>>>               if (rc)
>>>>                   goto out_unlock;
>>>>               if (mynel < maxnel) {
>>>> @@ -2672,7 +2712,6 @@ static inline int __security_genfs_sid(struct 
>>>> selinux_state *state,
>>>>                          u32 *sid)
>>>>   {
>>>>       struct policydb *policydb = &state->ss->policydb;
>>>> -    struct sidtab *sidtab = state->ss->sidtab;
>>>>       int len;
>>>>       u16 sclass;
>>>>       struct genfs *genfs;
>>>> @@ -2707,7 +2746,7 @@ static inline int __security_genfs_sid(struct 
>>>> selinux_state *state,
>>>>           goto out;
>>>>       if (!c->sid[0]) {
>>>> -        rc = sidtab_context_to_sid(sidtab, &c->context[0], 
>>>> &c->sid[0]);
>>>> +        rc = context_to_sid(state, &c->context[0], &c->sid[0]);
>>>>           if (rc)
>>>>               goto out;
>>>>       }
>>>> @@ -2770,8 +2809,7 @@ int security_fs_use(struct selinux_state 
>>>> *state, struct super_block *sb)
>>>>       if (c) {
>>>>           sbsec->behavior = c->v.behavior;
>>>>           if (!c->sid[0]) {
>>>> -            rc = sidtab_context_to_sid(sidtab, &c->context[0],
>>>> -                           &c->sid[0]);
>>>> +            rc = context_to_sid(state, &c->context[0], &c->sid[0]);
>>>>               if (rc)
>>>>                   goto out;
>>>>           }
>>>> @@ -3026,8 +3064,7 @@ int security_sid_mls_copy(struct selinux_state 
>>>> *state,
>>>>               goto out_unlock;
>>>>           }
>>>>       }
>>>> -
>>>> -    rc = sidtab_context_to_sid(sidtab, &newcon, new_sid);
>>>> +    rc = context_to_sid(state, &newcon, new_sid);
>>>>   out_unlock:
>>>>       read_unlock(&state->ss->policy_rwlock);
>>>>       context_destroy(&newcon);
>>>> @@ -3620,7 +3657,7 @@ int security_netlbl_secattr_to_sid(struct 
>>>> selinux_state *state,
>>>>           if (!mls_context_isvalid(policydb, &ctx_new))
>>>>               goto out_free;
>>>> -        rc = sidtab_context_to_sid(sidtab, &ctx_new, sid);
>>>> +        rc = context_to_sid(state, &ctx_new, sid);
>>>>           if (rc)
>>>>               goto out_free;
>>>> diff --git a/security/selinux/ss/services.h 
>>>> b/security/selinux/ss/services.h
>>>> index 9a36de860368..fc40640a9725 100644
>>>> --- a/security/selinux/ss/services.h
>>>> +++ b/security/selinux/ss/services.h
>>>> @@ -8,7 +8,7 @@
>>>>   #define _SS_SERVICES_H_
>>>>   #include "policydb.h"
>>>> -#include "sidtab.h"
>>>> +#include "context.h"
>>>>   /* Mapping for a single class */
>>>>   struct selinux_mapping {
>>>> @@ -39,4 +39,6 @@ void services_compute_xperms_drivers(struct 
>>>> extended_perms *xperms,
>>>>   void services_compute_xperms_decision(struct 
>>>> extended_perms_decision *xpermd,
>>>>                       struct avtab_node *node);
>>>> +int context_add_hash(struct policydb *policydb, struct context 
>>>> *context);
>>>> +
>>>>   #endif    /* _SS_SERVICES_H_ */
>>>> diff --git a/security/selinux/ss/sidtab.c 
>>>> b/security/selinux/ss/sidtab.c
>>>> index 7d49994e8d5f..e4710f32b6d9 100644
>>>> --- a/security/selinux/ss/sidtab.c
>>>> +++ b/security/selinux/ss/sidtab.c
>>>> @@ -23,23 +23,32 @@ int sidtab_init(struct sidtab *s)
>>>>       memset(s->roots, 0, sizeof(s->roots));
>>>> -    /* max count is SIDTAB_MAX so valid index is always < 
>>>> SIDTAB_MAX */
>>>> -    for (i = 0; i < SIDTAB_RCACHE_SIZE; i++)
>>>> -        s->rcache[i] = SIDTAB_MAX;
>>>> -
>>>>       for (i = 0; i < SECINITSID_NUM; i++)
>>>>           s->isids[i].set = 0;
>>>>       s->count = 0;
>>>>       s->convert = NULL;
>>>> +    hash_init(s->context_to_sid);
>>>>       spin_lock_init(&s->lock);
>>>>       return 0;
>>>>   }
>>>> +static u32 context_to_sid(struct sidtab *s, struct context *context)
>>>> +{
>>>> +    struct sidtab_node *node;
>>>> +
>>>> +    hash_for_each_possible(s->context_to_sid, node, list, 
>>>> context->hash) {
>>>> +        if (context_cmp(node->context, context))
>>>> +            return node->sid;
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   int sidtab_set_initial(struct sidtab *s, u32 sid, struct context 
>>>> *context)
>>>>   {
>>>>       struct sidtab_isid_entry *entry;
>>>> +    struct sidtab_node *node = NULL;
>>>>       int rc;
>>>>       if (sid == 0 || sid > SECINITSID_NUM)
>>>> @@ -52,9 +61,57 @@ int sidtab_set_initial(struct sidtab *s, u32 sid, 
>>>> struct context *context)
>>>>           return rc;
>>>>       entry->set = 1;
>>>> +
>>>> +    /*
>>>> +     * Multiple initial sids may map to the same context. Check 
>>>> that this
>>>> +     * context is not already represented in the context_to_sid 
>>>> hashtable
>>>> +     * to avoid duplicate entries and long linked lists upon hash
>>>> +     * collision.
>>>> +     */
>>>> +    if (!context_to_sid(s, context)) {
>>>> +        node = kzalloc(sizeof(struct sidtab_node), GFP_ATOMIC);
>>>> +        if (!node)
>>>> +            return -ENOMEM;
>>>> +        node->sid = sid;
>>>> +        node->context = &entry->context;
>>>> +        hash_add(s->context_to_sid, &node->list, context->hash);
>>>> +    }
>>>> +
>>>>       return 0;
>>>>   }
>>>> +int sidtab_hash_stats(struct sidtab *sidtab, char *page)
>>>> +{
>>>> +    int i;
>>>> +    int chain_len = 0;
>>>> +    int slots_used = 0;
>>>> +    int entries = 0;
>>>> +    int max_chain_len = 0;
>>>> +    int cur_bucket = 0;
>>>> +    struct sidtab_node *node;
>>>> +
>>>> +
>>>> +    hash_for_each(sidtab->context_to_sid, i, node, list) {
>>>
>>> Safe for this to be entirely lock-free?
>>>
>>>> +        entries++;
>>>> +        if (i == cur_bucket) {
>>>> +            chain_len++;
>>>> +            if (chain_len == 1)
>>>> +                slots_used++;
>>>> +        } else {
>>>> +            cur_bucket = i;
>>>> +            if (chain_len > max_chain_len)
>>>> +                max_chain_len = chain_len;
>>>> +            chain_len = 0;
>>>> +        }
>>>> +    }
>>>> +    if (chain_len > max_chain_len)
>>>> +        max_chain_len = chain_len;
>>>> +    return scnprintf(page, PAGE_SIZE, "%s:  %d entries and %d/%d 
>>>> buckets "
>>>> +             "used, longest chain length %d\n", "context_to_sid",
>>>> +             entries, slots_used, SIDTAB_HASH_BUCKETS,
>>>> +             max_chain_len);
>>>
>>> Odd choice to pass "context_to_sid" as argument.  And probably can 
>>> avoid the checkpatch.pl warning here too.
>>>
>>>> +}
>>>> +
>>>>   static u32 sidtab_level_from_count(u32 count)
>>>>   {
>>>>       u32 capacity = SIDTAB_LEAF_ENTRIES;
>>>> @@ -150,7 +207,7 @@ static struct context *sidtab_search_core(struct 
>>>> sidtab *s, u32 sid, int force)
>>>>       if (sid != 0) {
>>>>           if (sid > SECINITSID_NUM)
>>>> -            context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
>>>> +            context = sidtab_lookup(s, sid_to_index(sid));
>>>>           else
>>>>               context = sidtab_lookup_initial(s, sid);
>>>>           if (context && (!context->len || force))
>>>> @@ -170,132 +227,70 @@ struct context *sidtab_search_force(struct 
>>>> sidtab *s, u32 sid)
>>>>       return sidtab_search_core(s, sid, 1);
>>>>   }
>>>> -static int sidtab_find_context(union sidtab_entry_inner entry,
>>>> -                   u32 *pos, u32 count, u32 level,
>>>> -                   struct context *context, u32 *index)
>>>> -{
>>>> -    int rc;
>>>> -    u32 i;
>>>> -
>>>> -    if (level != 0) {
>>>> -        struct sidtab_node_inner *node = entry.ptr_inner;
>>>> -
>>>> -        i = 0;
>>>> -        while (i < SIDTAB_INNER_ENTRIES && *pos < count) {
>>>> -            rc = sidtab_find_context(node->entries[i],
>>>> -                         pos, count, level - 1,
>>>> -                         context, index);
>>>> -            if (rc == 0)
>>>> -                return 0;
>>>> -            i++;
>>>> -        }
>>>> -    } else {
>>>> -        struct sidtab_node_leaf *node = entry.ptr_leaf;
>>>> -
>>>> -        i = 0;
>>>> -        while (i < SIDTAB_LEAF_ENTRIES && *pos < count) {
>>>> -            if (context_cmp(&node->entries[i].context, context)) {
>>>> -                *index = *pos;
>>>> -                return 0;
>>>> -            }
>>>> -            (*pos)++;
>>>> -            i++;
>>>> -        }
>>>> -    }
>>>> -    return -ENOENT;
>>>> -}
>>>> -
>>>> -static void sidtab_rcache_update(struct sidtab *s, u32 index, u32 pos)
>>>> -{
>>>> -    while (pos > 0) {
>>>> -        WRITE_ONCE(s->rcache[pos], READ_ONCE(s->rcache[pos - 1]));
>>>> -        --pos;
>>>> -    }
>>>> -    WRITE_ONCE(s->rcache[0], index);
>>>> -}
>>>> -
>>>> -static void sidtab_rcache_push(struct sidtab *s, u32 index)
>>>> -{
>>>> -    sidtab_rcache_update(s, index, SIDTAB_RCACHE_SIZE - 1);
>>>> -}
>>>> -
>>>> -static int sidtab_rcache_search(struct sidtab *s, struct context 
>>>> *context,
>>>> -                u32 *index)
>>>> -{
>>>> -    u32 i;
>>>> -
>>>> -    for (i = 0; i < SIDTAB_RCACHE_SIZE; i++) {
>>>> -        u32 v = READ_ONCE(s->rcache[i]);
>>>> -
>>>> -        if (v >= SIDTAB_MAX)
>>>> -            continue;
>>>> -
>>>> -        if (context_cmp(sidtab_do_lookup(s, v, 0), context)) {
>>>> -            sidtab_rcache_update(s, v, i);
>>>> -            *index = v;
>>>> -            return 0;
>>>> -        }
>>>> -    }
>>>> -    return -ENOENT;
>>>> -}
>>>> -
>>>> -static int sidtab_reverse_lookup(struct sidtab *s, struct context 
>>>> *context,
>>>> -                 u32 *index)
>>>> +int sidtab_context_to_sid(struct sidtab *s, struct context *context,
>>>> +              u32 *sid)
>>>>   {
>>>>       unsigned long flags;
>>>> -    u32 count, count_locked, level, pos;
>>>> +    u32 count;
>>>>       struct sidtab_convert_params *convert;
>>>>       struct context *dst, *dst_convert;
>>>> +    struct sidtab_node *dst_node, *dst_node_convert = NULL;
>>>>       int rc;
>>>> -    rc = sidtab_rcache_search(s, context, index);
>>>> -    if (rc == 0)
>>>> -        return 0;
>>>> -
>>>> -    /* read entries only after reading count */
>>>> -    count = smp_load_acquire(&s->count);
>>>> -    level = sidtab_level_from_count(count);
>>>> -
>>>> -    pos = 0;
>>>> -    rc = sidtab_find_context(s->roots[level], &pos, count, level,
>>>> -                 context, index);
>>>> -    if (rc == 0) {
>>>> -        sidtab_rcache_push(s, *index);
>>>> +    *sid = context_to_sid(s, context);
>>>> +    if (*sid)
>>>>           return 0;
>>>> -    }
>>>>       /* lock-free search failed: lock, re-search, and insert if not 
>>>> found */
>>>>       spin_lock_irqsave(&s->lock, flags);
>>>> +    *sid = context_to_sid(s, context);
>>>> +    if (*sid)
>>>> +        goto out_unlock;
>>>> +
>>>
>>> rc never set here, used in out_unlock path.
>>>
>>>>       convert = s->convert;
>>>> -    count_locked = s->count;
>>>> -    level = sidtab_level_from_count(count_locked);
>>>> -
>>>> -    /* if count has changed before we acquired the lock, then catch 
>>>> up */
>>>> -    while (count < count_locked) {
>>>> -        if (context_cmp(sidtab_do_lookup(s, count, 0), context)) {
>>>> -            sidtab_rcache_push(s, count);
>>>> -            *index = count;
>>>> -            rc = 0;
>>>> +    count = s->count;
>>>> +
>>>> +    rc = -ENOMEM;
>>>> +    dst_node = kzalloc(sizeof(struct sidtab_node), GFP_ATOMIC);
>>>> +    if (!dst_node)
>>>> +        goto out_unlock;
>>>> +
>>>> +    if (convert) {
>>>> +        dst_node_convert = kzalloc(sizeof(struct sidtab_node),
>>>> +                       GFP_ATOMIC);
>>>> +        if (!dst_node_convert) {
>>>> +            kfree(dst_node);
>>>>               goto out_unlock;
>>>>           }
>>>> -        ++count;
>>>>       }
>>>>       /* bail out if we already reached max entries */
>>>>       rc = -EOVERFLOW;
>>>> -    if (count >= SIDTAB_MAX)
>>>> +    if (count >= SIDTAB_MAX) {
>>>> +        kfree(dst_node);
>>>> +        kfree(dst_node_convert);
>>>>           goto out_unlock;
>>>> +    }
>>>>       /* insert context into new entry */
>>>>       rc = -ENOMEM;
>>>>       dst = sidtab_do_lookup(s, count, 1);
>>>> -    if (!dst)
>>>> +    if (!dst) {
>>>> +        kfree(dst_node);
>>>> +        kfree(dst_node_convert);
>>>>           goto out_unlock;
>>>> +    }
>>>
>>> Generally we'd introduce another goto target for these repeated 
>>> sequences of free calls.  Just put it after the out_unlock sequence 
>>> and then it can jump back to out_unlock after the frees.
>>>
>>>> +
>>>> +    dst_node->sid = index_to_sid(count);
>>>> +    dst_node->context = dst;
>>>>       rc = context_cpy(dst, context);
>>>> -    if (rc)
>>>> +    if (rc) {
>>>> +        kfree(dst_node);
>>>> +        kfree(dst_node_convert);
>>>>           goto out_unlock;
>>>> +    }
>>>>       /*
>>>>        * if we are building a new sidtab, we need to convert the 
>>>> context
>>>> @@ -306,25 +301,35 @@ static int sidtab_reverse_lookup(struct sidtab 
>>>> *s, struct context *context,
>>>>           dst_convert = sidtab_do_lookup(convert->target, count, 1);
>>>>           if (!dst_convert) {
>>>>               context_destroy(dst);
>>>> +            kfree(dst_node);
>>>> +            kfree(dst_node_convert);
>>>>               goto out_unlock;
>>>>           }
>>>>           rc = convert->func(context, dst_convert, convert->args);
>>>>           if (rc) {
>>>>               context_destroy(dst);
>>>> +            kfree(dst_node);
>>>> +            kfree(dst_node_convert);
>>>>               goto out_unlock;
>>>>           }
>>>> +        dst_node_convert->sid = index_to_sid(count);
>>>> +        dst_node_convert->context = dst_convert;
>>>>           /* at this point we know the insert won't fail */
>>>> +        spin_lock_irqsave(&convert->target->lock, flags);
>>>>           convert->target->count = count + 1;
>>>> +        hash_add(convert->target->context_to_sid,
>>>> +             &dst_node_convert->list, dst_convert->hash);
>>>> +        spin_unlock_irqrestore(&convert->target->lock, flags);
>>>>       }
>>>> +    hash_add(s->context_to_sid, &dst_node->list, context->hash);
>>>>       if (context->len)
>>>>           pr_info("SELinux:  Context %s is not valid (left 
>>>> unmapped).\n",
>>>>               context->str);
>>>> -    sidtab_rcache_push(s, count);
>>>> -    *index = count;
>>>> +    *sid = index_to_sid(count);
>>>>       /* write entries before writing new count */
>>>>       smp_store_release(&s->count, count + 1);
>>>> @@ -335,27 +340,41 @@ static int sidtab_reverse_lookup(struct sidtab 
>>>> *s, struct context *context,
>>>>       return rc;
>>>>   }
>>>> -int sidtab_context_to_sid(struct sidtab *s, struct context 
>>>> *context, u32 *sid)
>>>> +static int sidtab_convert_hashnode(struct sidtab *s, u32 index)
>>>>   {
>>>> -    int rc;
>>>> -    u32 i;
>>>> +    unsigned long flags;
>>>> +    struct context *context;
>>>> +    struct sidtab_node *node;
>>>> -    for (i = 0; i < SECINITSID_NUM; i++) {
>>>> -        struct sidtab_isid_entry *entry = &s->isids[i];
>>>> +    context = sidtab_do_lookup(s, index, 0);
>>>> -        if (entry->set && context_cmp(context, &entry->context)) {
>>>> -            *sid = i + 1;
>>>> -            return 0;
>>>> -     ��  }
>>>> -    }
>>>> +    node = kzalloc(sizeof(struct sidtab_node), GFP_ATOMIC);
>>>> +    if (!node)
>>>> +        return -ENOMEM;
>>>> -    rc = sidtab_reverse_lookup(s, context, sid);
>>>> -    if (rc)
>>>> -        return rc;
>>>> -    *sid += SECINITSID_NUM + 1;
>>>> + ��  node->sid = index_to_sid(index);
>>>> +    node->context = context;
>>>> +    spin_lock_irqsave(&s->lock, flags);
>>>> +    hash_add(s->context_to_sid, &node->list, context->hash);
>>>> +    spin_unlock_irqrestore(&s->lock, flags);
>>>>       return 0;
>>>>   }
>>>> +static int sidtab_convert_hashtable(struct sidtab *s, u32 count)
>>>> +{
>>>> +    u32 i;
>>>> +    int rc = 0;
>>>> +
>>>> +    for (i = 0; i < count; i++) {
>>>> +        rc = sidtab_convert_hashnode(s, i);
>>>> +        if (rc)
>>>> +            break;
>>>> +
>>>> +        cond_resched();
>>>> +    }
>>>> +    return rc;
>>>> +}
>>>> +
>>>>   static int sidtab_convert_tree(union sidtab_entry_inner *edst,
>>>>                      union sidtab_entry_inner *esrc,
>>>>                      u32 *pos, u32 count, u32 level,
>>>> @@ -400,6 +419,7 @@ static int sidtab_convert_tree(union 
>>>> sidtab_entry_inner *edst,
>>>>           }
>>>>           cond_resched();
>>>>       }
>>>> +
>>>>       return 0;
>>>>   }
>>>>
>>>
>>> Avoid unrelated whitespace changes.
>>>
>>>> @@ -449,7 +469,16 @@ int sidtab_convert(struct sidtab *s, struct 
>>>> sidtab_convert_params *params)
>>>>           spin_lock_irqsave(&s->lock, flags);
>>>>           s->convert = NULL;
>>>>           spin_unlock_irqrestore(&s->lock, flags);
>>>> +        return rc;
>>>> +    }
>>>> +
>>>> +    rc = sidtab_convert_hashtable(params->target, count);
>>>> +    if (rc) {
>>>> +        spin_lock_irqsave(&s->lock, flags);
>>>> +        s->convert = NULL;
>>>> +        spin_unlock_irqrestore(&s->lock, flags);
>>>>       }
>>>> +
>>>>       return rc;
>>>>   }
>>>> @@ -478,6 +507,19 @@ static void sidtab_destroy_tree(union 
>>>> sidtab_entry_inner entry, u32 level)
>>>>       }
>>>>   }
>>>> +
>>>> +static void sidtab_destroy_hashtable(struct sidtab *s)
>>>> +{
>>>> +    struct sidtab_node *node;
>>>> +    struct hlist_node *tmp;
>>>> +    int i;
>>>> +
>>>> +    hash_for_each_safe(s->context_to_sid, i, tmp, node, list) {
>>>> +        hash_del(&node->list);
>>>> +        kfree(node);
>>>> +    }
>>>> +}
>>>> +
>>>>   void sidtab_destroy(struct sidtab *s)
>>>>   {
>>>>       u32 i, level;
>>>> @@ -491,4 +533,5 @@ void sidtab_destroy(struct sidtab *s)
>>>>           --level;
>>>>       sidtab_destroy_tree(s->roots[level], level);
>>>> +    sidtab_destroy_hashtable(s);
>>>>   }
>>>> diff --git a/security/selinux/ss/sidtab.h 
>>>> b/security/selinux/ss/sidtab.h
>>>> index 1f4763141aa1..85afef719a43 100644
>>>> --- a/security/selinux/ss/sidtab.h
>>>> +++ b/security/selinux/ss/sidtab.h
>>>> @@ -13,6 +13,7 @@
>>>>   #include <linux/spinlock_types.h>
>>>>   #include <linux/log2.h>
>>>> +#include <linux/hashtable.h>
>>>>   #include "context.h"
>>>> @@ -66,7 +67,16 @@ struct sidtab_convert_params {
>>>>       struct sidtab *target;
>>>>   };
>>>> -#define SIDTAB_RCACHE_SIZE 3
>>>> +struct sidtab_node {
>>>> +    u32 sid;
>>>> +    struct context *context;
>>>> +    struct hlist_node list;
>>>> +};
>>>> +
>>>> +#define SIDTAB_HASH_BITS 9
>>>> +#define SIDTAB_HASH_BUCKETS (1 << SIDTAB_HASH_BITS)
>>>> +#define index_to_sid(index) (index + SECINITSID_NUM + 1)
>>>> +#define sid_to_index(sid) (sid - (SECINITSID_NUM + 1))
>>>>   struct sidtab {
>>>>       /*
>>>> @@ -83,11 +93,11 @@ struct sidtab {
>>>>       struct sidtab_convert_params *convert;
>>>>       spinlock_t lock;
>>>> -    /* reverse lookup cache - access atomically via 
>>>> {READ|WRITE}_ONCE() */
>>>> -    u32 rcache[SIDTAB_RCACHE_SIZE];
>>>> -
>>>>       /* index == SID - 1 (no entry for SECSID_NULL) */
>>>>       struct sidtab_isid_entry isids[SECINITSID_NUM];
>>>> +
>>>> +    /* Hash table for fast reverse context-to-sid lookups. */
>>>> +    DECLARE_HASHTABLE(context_to_sid, SIDTAB_HASH_BITS);
>>>>   };
>>>>   int sidtab_init(struct sidtab *s);
>>>> @@ -101,6 +111,8 @@ int sidtab_context_to_sid(struct sidtab *s, 
>>>> struct context *context, u32 *sid);
>>>>   void sidtab_destroy(struct sidtab *s);
>>>> +int sidtab_hash_stats(struct sidtab *sidtab, char *page);
>>>> +
>>>>   #endif    /* _SS_SIDTAB_H_ */
>>>>
>>>
>>
> 

