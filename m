Return-Path: <SRS0=Cb3q=OG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF71C43441
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 17:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9063C2133F
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 17:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9063C2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbeK1ELA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:11:00 -0500
Received: from uphb19pa08.eemsg.mail.mil ([214.24.26.82]:25723 "EHLO
        USFB19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731325AbeK1EK6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Nov 2018 23:10:58 -0500
X-EEMSG-check-008: 92375181|USFB19PA11_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Nov 2018 17:12:17 +0000
X-IronPort-AV: E=Sophos;i="5.56,287,1539648000"; 
   d="scan'208";a="21030552"
IronPort-PHdr: =?us-ascii?q?9a23=3ATa/4bhZC1Xj0uMuNHwYAtZP/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsq/bnLW6fgltlLVR4KTs6sC17KG9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa+bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YfIepUqo/wrEYMoxSjHwmhHP7hxD9WiH/43qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodbvOasOTey4wqvFwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VTryGXL5Z6T8wtTm1yuCs216cKtY?=
 =?us-ascii?q?C0cSQU0pgr2hjSYOGdfYeS+BLsTuORLC99hHJiZb2wmQ6/8VOlyu3gTsm010?=
 =?us-ascii?q?tKrjZdntnMqH8N0xvT59CbSvRn5Eeh2CuP1xvJ5uFYIUE7iarbK5k7zr42ip?=
 =?us-ascii?q?UTqljMEjXzmEX3iK+abkQk+u625OT7erjqu5CROoBuhgz+L6gigNKzDOsmPg?=
 =?us-ascii?q?QUQmSX4eG826fi/U39TrVKlPo2kqzBvZDBOMsbvbW0AxNV04k/6xa/CC2q0N?=
 =?us-ascii?q?IDnXYdNl5FdxWHj5bxN1HUPP/4Feu/g0irkDpzwPDGO7rhAo7LLnfZjLjuY6?=
 =?us-ascii?q?1w61RCxwUuzdBQ/Y5UBqsdL/L0X0/7rMbYAQMhMwyo3+bnD81w1pgAVmKLA6?=
 =?us-ascii?q?+ZNr7SsFCT6+IxLOmDepUVtCz+K/c7/f7ui2E2mVsHcamux5sXZ2iyHu56LE?=
 =?us-ascii?q?WBfXrsntABHH8SvgUkUezqjEaPUSZJaHavW6Iw/zQ7CIWhDYfZWI+hmqCO3C?=
 =?us-ascii?q?C+Hs4eWmcTLVaAC3rqP6CDQPEFYy+RaptmlzsfU7GqRqc72B2uvRO8wL1ieK?=
 =?us-ascii?q?6c4SActJT+xPBr6ODJ0xI/7zp5C4KayW7JB1l9g2dAYjgxxq039VR011Orya?=
 =?us-ascii?q?Flh7ldEttJ6rVCVQJsZrDGyOkvMMz/QgLMeJ+yTV+iRti3SWUqQskZ384FY0?=
 =?us-ascii?q?E7Hc6ryB/EwXz5UPcui7WXCclsoern1H/rKpM4kiye2Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AMAACGef1b/wHyM5BkGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYFaKYE1MyeDeYgYjAhMAQEBAQEBBoEQJYkdjiOBejgBhEAChDEiNAkNA?=
 =?us-ascii?q?QMBAQEBAQECAWwogjYkAYJiAQUjBAsBBVEJAg4KAgImAgJXBgEMBgIBARWCS?=
 =?us-ascii?q?T+BdQ2KA5tQfDOKKYELiwIXeIEHgREnDIJfiAWCVwKPIHePdQmRKgYYkQssm?=
 =?us-ascii?q?VE4gVUrCAIYCCEPgyeCJxeOHB8hAzCBBQEBjQ8BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Nov 2018 17:12:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wARHCE8T006180;
        Tue, 27 Nov 2018 12:12:14 -0500
Subject: Re: [RFC PATCH v2 2/4] [squash] do not store entry for SECSID_NULL
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20181127103605.32765-1-omosnace@redhat.com>
 <20181127103605.32765-3-omosnace@redhat.com>
 <1bd2a5dd-d8cb-1081-76ca-5f4f3de6111f@tycho.nsa.gov>
Message-ID: <24cf3398-9441-3c31-a3a4-1bf213809dbb@tycho.nsa.gov>
Date:   Tue, 27 Nov 2018 12:14:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1bd2a5dd-d8cb-1081-76ca-5f4f3de6111f@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/27/18 12:00 PM, Stephen Smalley wrote:
> On 11/27/18 5:36 AM, Ondrej Mosnacek wrote:
>> This patch is kept separate only for review. Eventually it will be
>> folded into the previous patch.
> 
> This one triggers a lot of warnings (security_compute_av: unrecognized 
> SID 0, security_sid_to_context_core: unrecognized SID 0) and some 
> failures during selinux-testsuite inet_socket tests.  While the policy 
> doesn't provide an entry for SECSID_NULL, the sidtab search logic was 
> remapping it to the unlabeled context and that was apparently being 
> relied upon by the labeled networking code IIUC.

NB I had active ssh sessions to the system at the time of the test (and 
was in fact running the testsuite in one of the ssh sessions).  All of 
the sessions froze during the inet_sockets tests, presumably when 
labeled networking was configured, and then came back to life later, 
presumably once labeled network was un-configured.

> 
> 
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>> ---
>>   security/selinux/ss/policydb.c |  2 +-
>>   security/selinux/ss/sidtab.c   | 25 ++++++++++++++++---------
>>   security/selinux/ss/sidtab.h   |  3 ++-
>>   3 files changed, 19 insertions(+), 11 deletions(-)
>>
>> diff --git a/security/selinux/ss/policydb.c 
>> b/security/selinux/ss/policydb.c
>> index 59359fa0bd74..a50d625e7946 100644
>> --- a/security/selinux/ss/policydb.c
>> +++ b/security/selinux/ss/policydb.c
>> @@ -912,7 +912,7 @@ int policydb_load_isids(struct policydb *p, struct 
>> sidtab *s)
>>               sidtab_destroy(s);
>>               goto out;
>>           }
>> -        if (c->sid[0] > SECINITSID_NUM) {
>> +        if (c->sid[0] == SECSID_NULL || c->sid[0] > SECINITSID_NUM) {
>>               pr_err("SELinux:  Initial SID %s out of range.\n",
>>                   c->u.name);
>>               sidtab_destroy(s);
>> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
>> index fd8115b211a6..e157d8240cf1 100644
>> --- a/security/selinux/ss/sidtab.c
>> +++ b/security/selinux/ss/sidtab.c
>> @@ -23,7 +23,7 @@ int sidtab_init(struct sidtab *s)
>>       if (!s->htable)
>>           return -ENOMEM;
>> -    for (i = 0; i <= SECINITSID_NUM; i++)
>> +    for (i = 0; i < SECINITSID_NUM; i++)
>>           s->isids[i].set = 0;
>>       for (i = 0; i < SIDTAB_SIZE; i++)
>> @@ -86,8 +86,15 @@ static int sidtab_insert(struct sidtab *s, u32 sid, 
>> struct context *context)
>>   int sidtab_set_initial(struct sidtab *s, u32 sid, struct context 
>> *context)
>>   {
>> -    struct sidtab_isid_entry *entry = &s->isids[sid];
>> -    int rc = context_cpy(&entry->context, context);
>> +    struct sidtab_isid_entry *entry;
>> +    int rc;
>> +
>> +    if (sid == 0 || sid > SECINITSID_NUM)
>> +        return -EINVAL;
>> +
>> +    entry = &s->isids[sid - 1];
>> +
>> +    rc = context_cpy(&entry->context, context);
>>       if (rc)
>>           return rc;
>> @@ -116,19 +123,19 @@ static struct context *sidtab_search_core(struct 
>> sidtab *s, u32 sid, int force)
>>       struct context *context;
>>       struct sidtab_isid_entry *entry;
>> -    if (!s)
>> +    if (!s || sid == 0)
>>           return NULL;
>>       if (sid > SECINITSID_NUM) {
>>           context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
>>       } else {
>> -        entry = &s->isids[sid];
>> +        entry = &s->isids[sid - 1];
>>           context = entry->set ? &entry->context : NULL;
>>       }
>>       if (context && (!context->len || force))
>>           return context;
>> -    entry = &s->isids[SECINITSID_UNLABELED];
>> +    entry = &s->isids[SECINITSID_UNLABELED - 1];
>>       return entry->set ? &entry->context : NULL;
>>   }
>> @@ -283,11 +290,11 @@ int sidtab_context_to_sid(struct sidtab *s, 
>> struct context *context, u32 *sid)
>>       int rc;
>>       u32 i;
>> -    for (i = 0; i <= SECINITSID_NUM; i++) {
>> +    for (i = 0; i < SECINITSID_NUM; i++) {
>>           struct sidtab_isid_entry *entry = &s->isids[i];
>>           if (entry->set && context_cmp(context, &entry->context)) {
>> -            *sid = i;
>> +            *sid = i + 1;
>>               return 0;
>>           }
>>       }
>> @@ -334,7 +341,7 @@ void sidtab_destroy(struct sidtab *s)
>>       if (!s)
>>           return;
>> -    for (i = 0; i <= SECINITSID_NUM; i++)
>> +    for (i = 0; i < SECINITSID_NUM; i++)
>>           if (s->isids[i].set)
>>               context_destroy(&s->isids[i].context);
>> diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
>> index dc0a80bc8894..e657ae6bf996 100644
>> --- a/security/selinux/ss/sidtab.h
>> +++ b/security/selinux/ss/sidtab.h
>> @@ -36,7 +36,8 @@ struct sidtab {
>>       struct sidtab_node *cache[SIDTAB_CACHE_LEN];
>>       spinlock_t lock;
>> -    struct sidtab_isid_entry isids[SECINITSID_NUM + 1];
>> +    /* index == SID - 1 (no entry for SECSID_NULL) */
>> +    struct sidtab_isid_entry isids[SECINITSID_NUM];
>>   };
>>   int sidtab_init(struct sidtab *s);
>>
> 

