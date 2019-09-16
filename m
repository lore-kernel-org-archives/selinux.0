Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF0CC49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 17:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0E720665
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 17:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="NI4ELDBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfIPRbI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 13:31:08 -0400
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:8312 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfIPRbH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 13:31:07 -0400
X-EEMSG-check-017: 28368959|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="28368959"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Sep 2019 17:30:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568655031; x=1600191031;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kSslRlFshMuNF61KJbNFCXvdj861jUUeo4LhSdQqv6A=;
  b=NI4ELDBLIVF3VoePccbLjuirfY6KpSNQfCdwM0vzoKdry4AwM0UTCMpa
   b6wkCxPDVXYgddBQtjhCtTc0b1JVh0OxCWBjOZF/vSrqX1nfoKeXEJWzp
   3vuvRLF+4ZBzYTsTG1ytoBrMazds8CoLa92WL6+S/mKDdhYc2ocACeCoF
   ZmkDvTrPmYUBBSjsbpLh34frWFF9HgiyOD1DURDLEu1B+pcNmpCPkmQrl
   vnLqB/QkhFP8QVj43tVSq4bl2rHDbo9Vk6IuTDtF75xpuGfZ88DiYPHGF
   awysUuBydPydbbGDgUqg6Oy7wuD1sdr+ixW2PpWdYdiAHvq8MEHCgvU/M
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="27962768"
IronPort-PHdr: =?us-ascii?q?9a23=3ALtMcfxT0NxC0P8fFr53sv081Ltpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZRSCt8tkgFKBZ4jH8fUM07OQ7/m7HzVbqs/Y6jhCKMUKC0?=
 =?us-ascii?q?Zfz51O3kQJO42sMQXDNvnkbig3ToxpdWRO2DWFC3VTA9v0fFbIo3e/vnY4Ex?=
 =?us-ascii?q?T7MhdpdKyuQtaBx8u42Pqv9JLNfg5GmCSyYa9oLBWxsA7dqtQajZFtJ6osxB?=
 =?us-ascii?q?bFuGZEdupZyW91OF6fgQv36sOs8JJ+6ShdtO8t+9BaXanmY6g0SKFTASg7PW?=
 =?us-ascii?q?wy+MDlrwTIQxGV5nsbXGUWkx5IDBbA4RrnQJr/sTb0u/Rk1iWCMsL4Ub47WT?=
 =?us-ascii?q?K576d2UxDokzsINyQ48G7MlMN9ir9QrQ+7qBx+x47UZ5yVNOZ7c6jAc94WWX?=
 =?us-ascii?q?ZNU8BMXCFaHIiyc5UAAPYAPeZAronyuV0OrQelBQKxAO/j0yJEimPq0aE/1e?=
 =?us-ascii?q?kuHxvG3Ag9FNwQtnraosj+OKMLXe27yKTEyDPOZO5U1zjg8ojFag0vr/GSU7?=
 =?us-ascii?q?J+csTfx0cgGAzHgVqMpoLoJC+V2+cXvmSH8+ZtW+Cihmg6oA9xuDivwcIsh5?=
 =?us-ascii?q?HUiIIJ1F/E7SV5z5gzJdalVUB7ZMSrEJ9Uty6EN4p9X8QvQ3p1tyYh0bAGpZ?=
 =?us-ascii?q?66czQKyJQg3RLfbeeHfJKS7hLsU+aRPy51iXR4c7yxgBay9FKvyuz6VsSsyl?=
 =?us-ascii?q?ZFsDdKktnWuXARzRDc9s+HSv5780y82jiPzxje5vxLLE07j6bWK4MtzqQump?=
 =?us-ascii?q?ccr0jPBDL6lUPrh6GMbEok4PKn6+H/b7XjoZ+TKpF7hxnlMqQrhsy/GeM4Mh?=
 =?us-ascii?q?USX2SD+eSzyrnj/UrhTbVWlPI2iKjZsI3BJcgBuq64AxNa0oYk6xqlCTepzM?=
 =?us-ascii?q?8YkmUdIFJAeRKHi5DlO1DIIP/mEfeym0mgnThkyvzcPrDtH4/BImbMnbv/Z7?=
 =?us-ascii?q?px9lZQyA8pwtBe45JUBKsBIPX2WkLpr9zXEwQ5Pheow+fnFNp91oQeVXiJAq?=
 =?us-ascii?q?+CKqzeq1CI5uUxI+WUfo8apC79K+Q55/7plXI5nlodfa6y3ZsRcn+3AuppLl?=
 =?us-ascii?q?6DYXXyn9gBEX0FvhYkQOP2j12CVCZZZ2yuUKIk+jE7FIWmAJ/YRo+zhLyB3S?=
 =?us-ascii?q?G7HoBZZ21dFFCMHmnnd5+eV/cPdi2SOMlhnSIAVbS7TI8hzx6uvhfgy7V7Nu?=
 =?us-ascii?q?rU5jEYtZX72dht/eLTiBUy+CdsD8uHzmGNS3h4nmYPRz8xxqBwv1ZxxUuE0a?=
 =?us-ascii?q?h9m/ZYD8Bc5+tVUgcmMp7R1+l6C8vsVQLCeteGVkqmTc+9DDErUN0+3t8ObF?=
 =?us-ascii?q?xhG9m4kh/D2C+qUPcpkOmsApAu/6CU+n/qIc92xnWOgK4kiEIgS8BCHXeriq?=
 =?us-ascii?q?52607YAIuf1w2CmqKrc7kM9DDC+X3FzmeUukxcFglqXuGNZXkCYgPzqtPj6w?=
 =?us-ascii?q?uWV7azDZw/OxZFjMuFLbFHLNbuiAMVau3kPYHlf2+pm2q2TS2Nz7eIYZuiL3?=
 =?us-ascii?q?4Rxw3BGUMElEYV5n/AOg8gUHTy61nCBSBjQAq8K3jn9vNz/TbiFR45?=
X-IPAS-Result: =?us-ascii?q?A2DgAQBOxn9d/wHyM5BmHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?W0qbVIBMiqEIY9WAQEBAQEBBoERJYlzj0CBZwkBAQEBAQEBAQErCQECAQGEP?=
 =?us-ascii?q?wKCbyM3Bg4CDAEBAQQBAQEBAQUDAQFshS4MgjopAYJnAQUjBAsBBUEQCQIOC?=
 =?us-ascii?q?gICERUCAlcGAQwGAgEBgl8/AYF2FA+RHptvfzOJAYFDBoEMKAGLdxh4gQeBO?=
 =?us-ascii?q?AyCXz6CYQQYgQKBBIJMglgEjGegA4Isgi6EV411BhuZGY4JiAyTBiKBWCsIA?=
 =?us-ascii?q?hgIIQ+DJ4JOF4NPim8kAzABgQUBAY9uAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Sep 2019 17:30:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8GHUQLR021491;
        Mon, 16 Sep 2019 13:30:27 -0400
Subject: Re: [PATCH] selinux: optimize MLS context to string conversion
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     Michal Sekletar <msekleta@redhat.com>
References: <20190730124852.7670-1-omosnace@redhat.com>
 <2412f6e1-8f70-1ede-2776-79470083b912@tycho.nsa.gov>
Message-ID: <e4390a08-4043-49bc-e792-c600d3183d5b@tycho.nsa.gov>
Date:   Mon, 16 Sep 2019 13:30:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2412f6e1-8f70-1ede-2776-79470083b912@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/16/19 10:43 AM, Stephen Smalley wrote:
> On 7/30/19 8:48 AM, Ondrej Mosnacek wrote:
>> When mls_compute_context_len() or mls_sid_to_context() encounters a
>> context with large category ranges, it behaves suboptimally - it
>> traverses each positive bit of the category bitmap, each time calling
>> find_next_bit() again.
>>
>> This has a large performance impact on UNIX datagram sockets with
>> SO_PASSSEC set, since here the peer context needs to be converted to
>> string for each recieved datagram. See [1] for more information.
>>
>> This patch introduces a new helper for ebitmap traversal, which allows
>> to efficiently iterate over positive ranges instead of bits -
>> ebitmap_for_each_positive_range() - and converts the two mls_*()
>> functions to leverage it.
>>
>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1733259
>>
>> Reported-by: Michal Sekletar <msekleta@redhat.com>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>> ---
>>   security/selinux/ss/ebitmap.h | 46 +++++++++++++++++++++
>>   security/selinux/ss/mls.c     | 76 +++++++++++++----------------------
>>   2 files changed, 73 insertions(+), 49 deletions(-)
>>
>> diff --git a/security/selinux/ss/ebitmap.h 
>> b/security/selinux/ss/ebitmap.h
>> index 6aa7cf6a2197..a415741cb206 100644
>> --- a/security/selinux/ss/ebitmap.h
>> +++ b/security/selinux/ss/ebitmap.h
>> @@ -42,6 +42,10 @@ struct ebitmap {
>>       u32 highbit;    /* highest position in the total bitmap */
>>   };
>> +struct ebitmap_range {
>> +    unsigned int start, end;
>> +};
>> +
>>   #define ebitmap_length(e) ((e)->highbit)
>>   static inline unsigned int ebitmap_start_positive(struct ebitmap *e,
>> @@ -80,6 +84,43 @@ static inline unsigned int 
>> ebitmap_next_positive(struct ebitmap *e,
>>       return ebitmap_length(e);
>>   }
>> +static inline unsigned int ebitmap_next_negative(struct ebitmap *e,
>> +                         struct ebitmap_node **n,
>> +                         unsigned int bit)
>> +{
>> +    unsigned int ofs;
>> +
>> +    ofs = find_next_zero_bit((*n)->maps, EBITMAP_SIZE,
>> +                 bit - (*n)->startbit + 1);
>> +    if (ofs < EBITMAP_SIZE)
>> +        return ofs + (*n)->startbit;
>> +
>> +    for (*n = (*n)->next; *n; *n = (*n)->next) {
>> +        ofs = find_first_zero_bit((*n)->maps, EBITMAP_SIZE);
>> +        if (ofs < EBITMAP_SIZE)
>> +            return ofs + (*n)->startbit;
>> +    }
>> +    return ebitmap_length(e);
>> +}
> 
> This is likely moot given that the patch was deferred on exploring the 
> cache option, but if/when this patch is revisited, you don't seem to 
> account for the possibility that there could be a hole between the 
> bitmaps represented by (*n) and (*n)->next, and that might be where the 
> next negative/zero bit is.

You can see this bug manifest by doing the following:
runcon -l s0:c0.c383,c768 bash
id -Z

The correct output of course would be s0:c0.c383,c768, but your patched 
kernel will report s0:c0.c768.

> 
>> +
>> +static inline void ebitmap_start_positive_range(struct ebitmap *e,
>> +                        struct ebitmap_node **n,
>> +                        struct ebitmap_range *range)
>> +{
>> +    range->end = range->start = ebitmap_start_positive(e, n);
>> +    if (range->start < ebitmap_length(e))
>> +        range->end = ebitmap_next_negative(e, n, range->start);
>> +}
>> +
>> +static inline void ebitmap_next_positive_range(struct ebitmap *e,
>> +                           struct ebitmap_node **n,
>> +                           struct ebitmap_range *range)
>> +{
>> +    range->end = range->start = ebitmap_next_positive(e, n, range->end);
>> +    if (range->start < ebitmap_length(e))
>> +        range->end = ebitmap_next_negative(e, n, range->start);
>> +}
>> +
>>   #define EBITMAP_NODE_INDEX(node, bit)    \
>>       (((bit) - (node)->startbit) / EBITMAP_UNIT_SIZE)
>>   #define EBITMAP_NODE_OFFSET(node, bit)    \
>> @@ -122,6 +163,11 @@ static inline void ebitmap_node_clr_bit(struct 
>> ebitmap_node *n,
>>            bit < ebitmap_length(e);            \
>>            bit = ebitmap_next_positive(e, &n, bit))    \
>> +#define ebitmap_for_each_positive_range(e, n, range)        \
>> +    for (ebitmap_start_positive_range(e, &n, &range);    \
>> +         range.start < ebitmap_length(e);            \
>> +         ebitmap_next_positive_range(e, &n, &range))    \
>> +
>>   int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
>>   int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
>>   int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2, u32 
>> last_e2bit);
>> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
>> index 5e05f5b902d7..3abd6b950c66 100644
>> --- a/security/selinux/ss/mls.c
>> +++ b/security/selinux/ss/mls.c
>> @@ -35,10 +35,12 @@
>>    */
>>   int mls_compute_context_len(struct policydb *p, struct context 
>> *context)
>>   {
>> -    int i, l, len, head, prev;
>> +    int l, len;
>>       char *nm;
>>       struct ebitmap *e;
>>       struct ebitmap_node *node;
>> +    struct ebitmap_range range;
>> +    unsigned int rlen;
>>       if (!p->mls_enabled)
>>           return 0;
>> @@ -49,24 +51,14 @@ int mls_compute_context_len(struct policydb *p, 
>> struct context *context)
>>           len += strlen(sym_name(p, SYM_LEVELS, index_sens - 1));
>>           /* categories */
>> -        head = -2;
>> -        prev = -2;
>>           e = &context->range.level[l].cat;
>> -        ebitmap_for_each_positive_bit(e, node, i) {
>> -            if (i - prev > 1) {
>> -                /* one or more negative bits are skipped */
>> -                if (head != prev) {
>> -                    nm = sym_name(p, SYM_CATS, prev);
>> -                    len += strlen(nm) + 1;
>> -                }
>> -                nm = sym_name(p, SYM_CATS, i);
>> +        ebitmap_for_each_positive_range(e, node, range) {
>> +            rlen = range.end - range.start;
>> +            if (rlen > 1) {
>> +                nm = sym_name(p, SYM_CATS, range.start);
>>                   len += strlen(nm) + 1;
>> -                head = i;
>>               }
>> -            prev = i;
>> -        }
>> -        if (prev != head) {
>> -            nm = sym_name(p, SYM_CATS, prev);
>> +            nm = sym_name(p, SYM_CATS, range.end - 1);
>>               len += strlen(nm) + 1;
>>           }
>>           if (l == 0) {
>> @@ -91,9 +83,11 @@ void mls_sid_to_context(struct policydb *p,
>>               char **scontext)
>>   {
>>       char *scontextp, *nm;
>> -    int i, l, head, prev;
>> +    int l, first;
>>       struct ebitmap *e;
>>       struct ebitmap_node *node;
>> +    struct ebitmap_range range;
>> +    unsigned int rlen;
>>       if (!p->mls_enabled)
>>           return;
>> @@ -109,43 +103,27 @@ void mls_sid_to_context(struct policydb *p,
>>           scontextp += strlen(scontextp);
>>           /* categories */
>> -        head = -2;
>> -        prev = -2;
>> +        first = 1;
>>           e = &context->range.level[l].cat;
>> -        ebitmap_for_each_positive_bit(e, node, i) {
>> -            if (i - prev > 1) {
>> -                /* one or more negative bits are skipped */
>> -                if (prev != head) {
>> -                    if (prev - head > 1)
>> -                        *scontextp++ = '.';
>> -                    else
>> -                        *scontextp++ = ',';
>> -                    nm = sym_name(p, SYM_CATS, prev);
>> -                    strcpy(scontextp, nm);
>> -                    scontextp += strlen(nm);
>> -                }
>> -                if (prev < 0)
>> -                    *scontextp++ = ':';
>> -                else
>> -                    *scontextp++ = ',';
>> -                nm = sym_name(p, SYM_CATS, i);
>> -                strcpy(scontextp, nm);
>> -                scontextp += strlen(nm);
>> -                head = i;
>> -            }
>> -            prev = i;
>> -        }
>> -
>> -        if (prev != head) {
>> -            if (prev - head > 1)
>> -                *scontextp++ = '.';
>> -            else
>> +        ebitmap_for_each_positive_range(e, node, range) {
>> +            if (first) {
>> +                first = 0;
>> +                *scontextp++ = ':';
>> +            } else {
>>                   *scontextp++ = ',';
>> -            nm = sym_name(p, SYM_CATS, prev);
>> +            }
>> +            nm = sym_name(p, SYM_CATS, range.start);
>>               strcpy(scontextp, nm);
>>               scontextp += strlen(nm);
>> -        }
>> +            rlen = range.end - range.start;
>> +            if (rlen > 1) {
>> +                *scontextp++ = rlen > 2 ? '.' : ',';
>> +                nm = sym_name(p, SYM_CATS, range.end - 1);
>> +                strcpy(scontextp, nm);
>> +                scontextp += strlen(nm);
>> +            }
>> +        }
>>           if (l == 0) {
>>               if (mls_level_eq(&context->range.level[0],
>>                        &context->range.level[1]))
>>
> 

