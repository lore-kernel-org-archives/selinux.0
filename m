Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A33C64EC7
	for <selinux@archiver.kernel.org>; Sat, 25 Feb 2023 14:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBYOcW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 25 Feb 2023 09:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYOcV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 25 Feb 2023 09:32:21 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E29199F9
        for <selinux@vger.kernel.org>; Sat, 25 Feb 2023 06:32:18 -0800 (PST)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PP8Gs0PM7zKmNC;
        Sat, 25 Feb 2023 22:27:17 +0800 (CST)
Received: from [10.67.110.167] (10.67.110.167) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Feb 2023 22:32:11 +0800
Message-ID: <0ccc9aba-2e67-9239-5678-f59eac711c9f@huawei.com>
Date:   Sat, 25 Feb 2023 22:32:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/3] libselinux: performance optimization for duplicate
 detection
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
CC:     <selinux@vger.kernel.org>, <weiyuchen3@huawei.com>
References: <20230209114253.120485-1-wanghuizhao1@huawei.com>
 <20230217084458.40597-1-wanghuizhao1@huawei.com>
 <20230217084458.40597-4-wanghuizhao1@huawei.com>
 <CAJ2a_DeQaPZV+GRTFM+HOHUkyTBe=hLdD5pJxOryJ+X2_y1zNw@mail.gmail.com>
From:   wanghuizhao <wanghuizhao1@huawei.com>
In-Reply-To: <CAJ2a_DeQaPZV+GRTFM+HOHUkyTBe=hLdD5pJxOryJ+X2_y1zNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.167]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500007.china.huawei.com (7.221.188.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 2023/2/24 20:00, Christian Göttsche wrote:
> On Fri, 17 Feb 2023 at 09:45, wanghuizhao <wanghuizhao1@huawei.com> wrote:
>> When semodule -i some.pp to install a module package, duplicate items are
>> detected for the module. The detection function is nodups_specs in
>> libselinux/src/label_file.c. The algorithm complexity of implementing
>> this function is O(N^2). In scenarios where N is very large, the efficiency
>> is very low.
>>
>> To solve this problem, I propose to use the hash table to detect duplicates.
>> The algorithm complexity of new implementing is O(N). The execution efficiency
>> will be greatly improved.
> Isn't the new complexity O(N * log(N)) due to the hashtable insertion
> of O(log(N))?


It's a little inaccurate to use O(N) here. When the hash table is 
inserted,  the hash value is calculated based on the inserted data. In 
this scenario, regex string is traversed cyclically. But these have 
nothing to do with O(log(N)).

If there is a hash collision, or if duplicates are detected, it will 
take a little time for pointer manipulation and strcmp.

However, in the original solution, a large number of strcmp operations 
were performed, which was also extremely time-consuming, although the 
second layer loop was only half the original.

for (ii = 0; ii < data->nspec; ii++) {
         curr_spec = &spec_arr[ii];
         for (jj = ii + 1; jj < data->nspec; jj++) {
             if ((!strcmp(spec_arr[jj].regex_str,
                 curr_spec->regex_str))
                 && (!spec_arr[jj].mode || !curr_spec->mode
                 || spec_arr[jj].mode == curr_spec->mode)) {

Maybe I should state that there is another symbol M related to the 
length of the string, and the overall time complexity is O(M * (N^2)) -> 
O(M * N) ?

>>   /*
>> + * hash calculation and key comparison of hash table
>> + */
>> +
>> +static unsigned int symhash(hashtab_t h, const_hashtab_key_t key)
>> +{
>> +       const struct chkdups_key *k = (const struct chkdups_key *)key;
>> +       const char *p = NULL;
>> +       size_t size;
>> +       unsigned int val = 0;
>> +
>> +       size = strlen(k->regex);
>> +       for (p = k->regex; ((size_t) (p - k->regex)) < size; p++)
>> +               val =
>> +                       ((val << 4) | ((val >> (8 * sizeof(unsigned int) - 4)) +
>> +                       k->mode)) ^ (*p);
> v1 added k->mode after the bit-wise or (probably changed by the added
> parenthesis due to the compiler warning).
> Using
>
>       (((val << 4) | (val >> (8 * sizeof(unsigned int) - 4))) + k->mode) ^ (*p);
>
> gives a slightly better spread (tested against refpolicy (master)):
>
>      nodups_spec:  6062 entries and 606/606 buckets used, longest chain length 21
> vs
>      nodups_spec:  6062 entries and 606/606 buckets used, longest chain length 20
>
> And for a adjusted hashtable size (see below):
>
>      nodups_spec:  6062 entries and 3807/6062 buckets used, longest
> chain length 6
> vs
>      nodups_spec:  6062 entries and 3815/6062 buckets used, longest
> chain length 6


That's good advice. I compared the two hash calculations with my own 
test set.

Using

      (((val << 4) | (val >> (8 * sizeof(unsigned int) - 4))) + k->mode) 
^ (*p);

The hash result is better.

root ~ # semodule -i myapp1.pp
nodups_specs: 5002 entries and 500/500 buckets used, longest chain length 16
root ~ # semodule -i myapp2.pp
nodups_specs: 10002 entries and 1000/1000 buckets used, longest chain 
length 20
root ~ # semodule -i myapp3.pp
nodups_specs: 20002 entries and 1539/2000 buckets used, longest chain 
length 20

adjusted hashtable size:

root ~ # semodule -i myapp1.pp
nodups_specs: 5002 entries and 3550/5002 buckets used, longest chain 
length 3
root ~ # semodule -i myapp2.pp
nodups_specs: 10002 entries and 7060/10002 buckets used, longest chain 
length 4
root ~ # semodule -i myapp3.pp
nodups_specs: 20002 entries and 13454/20002 buckets used, longest chain 
length 4

If I use the hash calculation of the patch v2, the result is as follows:

root ~ # semodule -i myapp1.pp
nodups_specs: 5002 entries and 500/500 buckets used, longest chain length 16
root ~ # semodule -i myapp2.pp
nodups_specs: 10002 entries and 1000/1000 buckets used, longest chain 
length 22
root ~ # semodule -i myapp3.pp
nodups_specs: 20002 entries and 1310/2000 buckets used, longest chain 
length 22

adjusted hashtable size:

root ~ # semodule -i myapp1.pp
nodups_specs: 5002 entries and 3551/5002 buckets used, longest chain 
length 4
root ~ # semodule -i myapp2.pp
nodups_specs: 10002 entries and 5602/10002 buckets used, longest chain 
length 5
root ~ # semodule -i myapp3.pp
nodups_specs: 20002 entries and 8975/20002 buckets used, longest chain 
length 6


The result is obvious that the hash calculation of the patch v1 is 
better. Thank you very much for your review and I'll fix it in the next 
patch version.

>> +       return val % h->size;
>> +}
>> +
>> +static int symcmp(hashtab_t h
>> +                 __attribute__ ((unused)), const_hashtab_key_t key1,
>> +                 const_hashtab_key_t key2)
>> +{
>> +       const struct chkdups_key *a = (const struct chkdups_key *)key1;
>> +       const struct chkdups_key *b = (const struct chkdups_key *)key2;
>> +
>> +       return strcmp(a->regex, b->regex) || (a->mode && b->mode && a->mode != b->mode);
>> +}
>> +
>> +static int destroy_chkdups_key(hashtab_key_t key)
>> +{
>> +       free(key);
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>>    * Warn about duplicate specifications.
>>    */
>>   static int nodups_specs(struct saved_data *data, const char *path)
>>   {
>> -       int rc = 0;
>> -       unsigned int ii, jj;
>> +       int rc = 0, ret = 0;
>> +       unsigned int ii;
>>          struct spec *curr_spec, *spec_arr = data->spec_arr;
>> +       struct chkdups_key *new = NULL;
>> +       unsigned int hashtab_len = (data->nspec / 10) ? data->nspec / 10 : 1;
>>
>> +       hashtab_t hash_table = hashtab_create(symhash, symcmp, hashtab_len);
> v1 used a hashtable size of `data->nspec`, instead of its tenth.
> Since the hashtable implementation from newrole does not contain a
> resize feature, like the one from libsepol, the size will be fixed for
> its lifetime.
> Using `data.>nspec` gives slightly better (but probably negligible) performance:
>
>      Benchmark 1: DESTDIR=~/Downloads/destdir/
> ./scripts/env_use_destdir ~/Downloads/destdir/sbin/setfiles -c
> ../refpolicy/tmp/policy.bin ../refpolicy/tmp/all_mods.fc
>       Time (mean ± σ):     340.4 ms ±  14.4 ms    [User: 280.6 ms,
> System: 59.7 ms]
>       Range (min … max):   328.1 ms … 386.0 ms    30 runs
> vs
>      Benchmark 1: DESTDIR=~/Downloads/destdir/
> ./scripts/env_use_destdir ~/Downloads/destdir/sbin/setfiles -c
> ../refpolicy/tmp/policy.bin ../refpolicy/tmp/all_mods.fc
>       Time (mean ± σ):     334.7 ms ±   5.9 ms    [User: 279.6 ms,
> System: 55.0 ms]
>       Range (min … max):   327.5 ms … 362.1 ms    30 runs
>
> Since your policy contains much more file context definitions, could
> you run some benchmarks yourself?


I can't easily execute this test script in my corporate environment. So 
I manually performed multiple tests.


When the length of the hash table is `data->nspec` :

root ~ # time semodule -i myapp1.pp          (10 runs) 5002 entries

Average Time real : 0.723s

Range (min … max): 0.695s ... 0.725s

root ~ # time semodule -i myapp2.pp          (10 runs) 10002 entries

Average Time real : 0.952s

Range (min … max): 0.933s ... 0.973s

root ~ # time semodule -i myapp3.pp          (10 runs) 20002 entries

Average Time real : 1.888s

Range (min … max): 1.866s ... 1.916s


When the length of the hash table is `hashtab_len ` :

root ~ # time semodule -i myapp1.pp          (10 runs) 5002 entries

Average Time real : 0.730s

Range (min … max): 0.713s ... 0.743s

root ~ # time semodule -i myapp2.pp          (10 runs) 10002 entries

Average Time real : 0.965s

Range (min … max): 0.933s ... 0.983s

root ~ # time semodule -i myapp3.pp          (10 runs) 20002 entries

Average Time real : 1.908s

Range (min … max): 1.886s ... 1.946s


The larger the hash table, the lower the probability of hash collision. 
When the length of the hash table is `data->nspec`, The overall 
efficiency will be improved a little.

My idea is to set up a macro here to control the reduction in the length 
of the hashtab table. Users can determine the reduction ratio of the 
hashtab. Memory is a scarce resource in my usage scenario, so I may need 
to limit the size of the hash table. However, in a computer or server, 
memory resources are sufficient, and a large hash table can be used.

