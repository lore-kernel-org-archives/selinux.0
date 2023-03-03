Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A92C678D4
	for <selinux@archiver.kernel.org>; Fri,  3 Mar 2023 14:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjCCOQK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Mar 2023 09:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCCOQJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Mar 2023 09:16:09 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0225D472
        for <selinux@vger.kernel.org>; Fri,  3 Mar 2023 06:16:03 -0800 (PST)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PSqhl6Qfqz9tJh;
        Fri,  3 Mar 2023 22:13:59 +0800 (CST)
Received: from [10.67.110.167] (10.67.110.167) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 22:16:00 +0800
Message-ID: <a236c473-4f18-c882-2197-f49195d84051@huawei.com>
Date:   Fri, 3 Mar 2023 22:15:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   wanghuizhao <wanghuizhao1@huawei.com>
Subject: Re: [PATCH v2 3/3] libselinux: performance optimization for duplicate
 detection
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
CC:     <selinux@vger.kernel.org>, <weiyuchen3@huawei.com>
References: <20230209114253.120485-1-wanghuizhao1@huawei.com>
 <20230217084458.40597-1-wanghuizhao1@huawei.com>
 <20230217084458.40597-4-wanghuizhao1@huawei.com>
 <CAJ2a_DeQaPZV+GRTFM+HOHUkyTBe=hLdD5pJxOryJ+X2_y1zNw@mail.gmail.com>
 <0ccc9aba-2e67-9239-5678-f59eac711c9f@huawei.com>
In-Reply-To: <0ccc9aba-2e67-9239-5678-f59eac711c9f@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.167]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500007.china.huawei.com (7.221.188.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 2023/2/25 22:32, wanghuizhao wrote:
>>>   /*
>>> + * hash calculation and key comparison of hash table
>>> + */
>>> +
>>> +static unsigned int symhash(hashtab_t h, const_hashtab_key_t key)
>>> +{
>>> +       const struct chkdups_key *k = (const struct chkdups_key *)key;
>>> +       const char *p = NULL;
>>> +       size_t size;
>>> +       unsigned int val = 0;
>>> +
>>> +       size = strlen(k->regex);
>>> +       for (p = k->regex; ((size_t) (p - k->regex)) < size; p++)
>>> +               val =
>>> +                       ((val << 4) | ((val >> (8 * sizeof(unsigned 
>>> int) - 4)) +
>>> +                       k->mode)) ^ (*p);
>> v1 added k->mode after the bit-wise or (probably changed by the added
>> parenthesis due to the compiler warning).
>> Using
>>
>>       (((val << 4) | (val >> (8 * sizeof(unsigned int) - 4))) + 
>> k->mode) ^ (*p);
>>
>> gives a slightly better spread (tested against refpolicy (master)):
>>
>>      nodups_spec:  6062 entries and 606/606 buckets used, longest 
>> chain length 21
>> vs
>>      nodups_spec:  6062 entries and 606/606 buckets used, longest 
>> chain length 20
>>
>> And for a adjusted hashtable size (see below):
>>
>>      nodups_spec:  6062 entries and 3807/6062 buckets used, longest
>> chain length 6
>> vs
>>      nodups_spec:  6062 entries and 3815/6062 buckets used, longest
>> chain length 6
>
>
> That's good advice. I compared the two hash calculations with my own 
> test set.
>
> Using
>
>      (((val << 4) | (val >> (8 * sizeof(unsigned int) - 4))) + 
> k->mode) ^ (*p);
>
> The hash result is better.
>
> root ~ # semodule -i myapp1.pp
> nodups_specs: 5002 entries and 500/500 buckets used, longest chain 
> length 16
> root ~ # semodule -i myapp2.pp
> nodups_specs: 10002 entries and 1000/1000 buckets used, longest chain 
> length 20
> root ~ # semodule -i myapp3.pp
> nodups_specs: 20002 entries and 1539/2000 buckets used, longest chain 
> length 20
>
> adjusted hashtable size:
>
> root ~ # semodule -i myapp1.pp
> nodups_specs: 5002 entries and 3550/5002 buckets used, longest chain 
> length 3
> root ~ # semodule -i myapp2.pp
> nodups_specs: 10002 entries and 7060/10002 buckets used, longest chain 
> length 4
> root ~ # semodule -i myapp3.pp
> nodups_specs: 20002 entries and 13454/20002 buckets used, longest 
> chain length 4
>
> If I use the hash calculation of the patch v2, the result is as follows:
>
> root ~ # semodule -i myapp1.pp
> nodups_specs: 5002 entries and 500/500 buckets used, longest chain 
> length 16
> root ~ # semodule -i myapp2.pp
> nodups_specs: 10002 entries and 1000/1000 buckets used, longest chain 
> length 22
> root ~ # semodule -i myapp3.pp
> nodups_specs: 20002 entries and 1310/2000 buckets used, longest chain 
> length 22
>
> adjusted hashtable size:
>
> root ~ # semodule -i myapp1.pp
> nodups_specs: 5002 entries and 3551/5002 buckets used, longest chain 
> length 4
> root ~ # semodule -i myapp2.pp
> nodups_specs: 10002 entries and 5602/10002 buckets used, longest chain 
> length 5
> root ~ # semodule -i myapp3.pp
> nodups_specs: 20002 entries and 8975/20002 buckets used, longest chain 
> length 6
>
>
> The result is obvious that the hash calculation of the patch v1 is 
> better. Thank you very much for your review and I'll fix it in the 
> next patch version.


(((val << 4) | (val >> (8 * sizeof(unsigned int) - 4))) + k->mode) ^ (*p);

I found that this hash calculation would cause a problem. In a scenario 
like this：

(1) regex: /tmp/something  mode: 0

(2) regex: /tmp/something  mode: 123

In the original checking logic, the two are judged as conflicting. 
However, in the new function implementation, `mode` is added to the hash 
calculation. As a result, they may have different hash values, so 
duplicates cannot be detected. I will fix this bug in the next patch.

