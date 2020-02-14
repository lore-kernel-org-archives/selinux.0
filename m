Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29B5C2BA83
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 18:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD396222C2
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 18:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="fayNFbuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394771AbgBNSTq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:19:46 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:53174 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394770AbgBNSTp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 13:19:45 -0500
X-EEMSG-check-017: 56603579|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="56603579"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2020 18:19:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581704383; x=1613240383;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=1D/nkGWZojJe8wAtdJo6OugCugfPkXEf7UDlNGpi83A=;
  b=fayNFbuqPohiqPCMAZUqWRHJTK8W6iGQdmVGrBkfXZNqVw/nbykhWIc2
   6zoqlB5Lzq9e08MYoTVjZxB2enLcd1nCfUmmGGsAORQPavzH4ktKszW5p
   BIgHNZQquT98BzdmB5hVgAW7jTHbMcQdJOIhk/IXpM1j2xkRLL/ypBmyD
   a7R+wejq0an1QQHQZRqx+VmcCndFzgrUyCemLp3TSpJcJOBS7rlMblKQN
   UhNdR921xusBWBjb8PHZ5CVNy2tP/SqX+CLbI6TCi/yCbhhbj1cMQA42x
   FDo5MzbQ18AHkzxno/HS708nLBTPP8BZHmvajauSHnp+O+IWf0OirnZ2d
   A==;
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="33088628"
IronPort-PHdr: =?us-ascii?q?9a23=3AE1WkcRAdh9Cc3WHRYTEFUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX+pcbcNUDSrc9gkEXOFd2Cra4d16yJ6+u5ADVIyK3CmU5BWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRq7oR/Tu8UKjoduN7s9xg?=
 =?us-ascii?q?bUqXZUZupawn9lKl2Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElRrFGDzooLn?=
 =?us-ascii?q?446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXj?=
 =?us-ascii?q?Si8rtrRRr1gyoJKzI17GfagdFrgalFvByuuQBww4/MYIGUKvV+eL/dfcgHTm?=
 =?us-ascii?q?ZFR8pdSjBNDp+5Y4YJAeUBJ+JYpJTjqVUIoxW1GA2gCPrhxzJMg3P727Ax3e?=
 =?us-ascii?q?Y8HgHcxAEuAtIAvmrarNv2OqkdX++6w6vUwjvMdP5WxTTw5ZLUfhw9r/yBX7?=
 =?us-ascii?q?R9etfRx0k1EAPFi02dp5H5PzyLzuQNs3aU7+x9Xuyyjm4osQVxojyxycYsl4?=
 =?us-ascii?q?LEgZkVxU3f9Shi3IY0JcG3SE58YdK+FptQrDuVO5F5QsMlXWFloSA3waAFt5?=
 =?us-ascii?q?6jZCUG1ZsqyhHFZ/GHboSE+AzvWemPLTtimX5ofq+0iQyo/ki60OL8U9G50F?=
 =?us-ascii?q?NNriVYjNbBrmsN1xnP6sifTft941uh1S6P1w/N7uFEJlg5lbbBJJ47w74wi4?=
 =?us-ascii?q?ETvV7CHi/wlkX2i7SWeVs49eSy9+TmYqnppp+bN4NujAHxLr8uldClDeQ9Mw?=
 =?us-ascii?q?gOW3CX+eW61LL94U30WKhGg/I5n6XDsJ3WON4XqrC2DgNLyIov9g6zDzK839?=
 =?us-ascii?q?QZmXkHIkhFeBWCj4XxIFHBPev4AOyjg1WsjDhrx/fGMqfnApXWNHfPirjhfb?=
 =?us-ascii?q?Fj60JE0go80chf545ICrEGOP/zXUrxtNvDDh8/KQO73/joBc5n1owARG2PAr?=
 =?us-ascii?q?WWML/IvVCU4eIvJvGGZJUJtzblN/gl+/nugGcimVADeamp3J0XaG23H/l9PU?=
 =?us-ascii?q?WZbmTjgs0bHWcJoAU+Vurqh0OGUTJJYHayRa08tXkHD9eBC4vZS4Llpbua2i?=
 =?us-ascii?q?6wE54eMmdDDUuKGHzlX5+JV/cFdGSZJco31nQfWLygTZIx/Q+huRW8yLd9KO?=
 =?us-ascii?q?fQvCoCutar9tFw6vabvhgo6TFuR5CfzGqEVX0utn8ZTD8xmqZkqApyzUnVgo?=
 =?us-ascii?q?ZihPkNLsBe//NEVE8BMJfYy+FrQ4TpVhnpYsaCSFHgRM6vRz42UIRikJc1f0?=
 =?us-ascii?q?9hFoD63Vj41C2wDupQzufaCQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2B1AgDF40Ze/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBSJA4ZZAQEEBoESJYlwkUoJAQEBAQEBAQEBNwQBAYRAAoIlOBMCE?=
 =?us-ascii?q?AEBAQUBAQEBAQUDAQFshUOCOykBgwIBBSMECwEFUQkCDgoCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgmM/glclkj+beX8ziSGBPoEOKow+eYEHgTgMA4JdPodbgl4EmA2XbYJEg?=
 =?us-ascii?q?k+TfAYCGpsYjmidPyKBWCsIAhgIIQ+DJ1AYDY4pF45BIwMwkFgBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Feb 2020 18:19:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01EIIgRw233398;
        Fri, 14 Feb 2020 13:18:43 -0500
Subject: Re: [PATCH userspace v2] libsepol: cache ebitmap cardinality value
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        James Carter <jwcart2@tycho.nsa.gov>
References: <20200213133959.14217-1-omosnace@redhat.com>
 <1a11d058-eee1-41c5-9686-da01ecf6ea33@tycho.nsa.gov>
Message-ID: <68198406-85ad-4a99-7549-15b8c4e0a517@tycho.nsa.gov>
Date:   Fri, 14 Feb 2020 13:20:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1a11d058-eee1-41c5-9686-da01ecf6ea33@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/14/20 12:38 PM, Stephen Smalley wrote:
> On 2/13/20 8:39 AM, Ondrej Mosnacek wrote:
>> According to profiling of semodule -BN, ebitmap_cardinality() is called
>> quite often and contributes a lot to the total runtime. Cache its result
>> in the ebitmap struct to reduce this overhead. The cached value is
>> invalidated on most modifying operations, but ebitmap_cardinality() is
>> usually called once the ebitmap doesn't change any more.
>>
>> After this patch, the time to do 'semodule -BN' on Fedora Rawhide has
>> decreased from ~14.6s to ~12.4s (2.2s saved).
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> 
> This seems fine but I was wondering how many of the callers of 
> ebitmap_cardinality() actually need anything more than ebitmap_length()?

Regardless,

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> 
>> ---
>>
>> v2: corrected time values in commit message
>>
>>   libsepol/include/sepol/policydb/ebitmap.h |  1 +
>>   libsepol/src/ebitmap.c                    | 10 ++++++++++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/libsepol/include/sepol/policydb/ebitmap.h 
>> b/libsepol/include/sepol/policydb/ebitmap.h
>> index e62df01c..53fafdaa 100644
>> --- a/libsepol/include/sepol/policydb/ebitmap.h
>> +++ b/libsepol/include/sepol/policydb/ebitmap.h
>> @@ -37,6 +37,7 @@ typedef struct ebitmap_node {
>>   typedef struct ebitmap {
>>       ebitmap_node_t *node;    /* first node in the bitmap */
>>       uint32_t highbit;    /* highest position in the total bitmap */
>> +    unsigned int cardinality;    /* cached value of cardinality */
>>   } ebitmap_t;
>>   #define ebitmap_length(e) ((e)->highbit)
>> diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
>> index 6c9951b7..d23444ce 100644
>> --- a/libsepol/src/ebitmap.c
>> +++ b/libsepol/src/ebitmap.c
>> @@ -67,6 +67,7 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * 
>> e1)
>>       ebitmap_destroy(dst);
>>       dst->node = tmp.node;
>>       dst->highbit = tmp.highbit;
>> +    dst->cardinality = 0;
>>       return 0;
>>   }
>> @@ -128,9 +129,14 @@ int ebitmap_andnot(ebitmap_t *dst, ebitmap_t *e1, 
>> ebitmap_t *e2, unsigned int ma
>>   unsigned int ebitmap_cardinality(ebitmap_t *e1)
>>   {
>>       unsigned int i, count = 0;
>> +
>> +    if (e1->cardinality || e1->highbit == 0)
>> +        return e1->cardinality;
>> +
>>       for (i=ebitmap_startbit(e1); i < ebitmap_length(e1); i++)
>>           if (ebitmap_get_bit(e1, i))
>>               count++;
>> +    e1->cardinality = count;
>>       return count;
>>   }
>> @@ -194,6 +200,7 @@ int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * 
>> src)
>>       }
>>       dst->highbit = src->highbit;
>> +    dst->cardinality = src->cardinality;
>>       return 0;
>>   }
>> @@ -309,6 +316,7 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int 
>> bit, int value)
>>                       free(n);
>>                   }
>>               }
>> +            e->cardinality = 0; /* invalidate cached cardinality */
>>               return 0;
>>           }
>>           prev = n;
>> @@ -339,6 +347,7 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int 
>> bit, int value)
>>           e->node = new;
>>       }
>> +    e->cardinality = 0; /* invalidate cached cardinality */
>>       return 0;
>>   }
>> @@ -358,6 +367,7 @@ void ebitmap_destroy(ebitmap_t * e)
>>       e->highbit = 0;
>>       e->node = 0;
>> +    e->cardinality = 0;
>>       return;
>>   }
>>
> 

