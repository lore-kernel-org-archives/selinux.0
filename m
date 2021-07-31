Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FD0C4338F
	for <selinux@archiver.kernel.org>; Sat, 31 Jul 2021 03:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D3C601FF
	for <selinux@archiver.kernel.org>; Sat, 31 Jul 2021 03:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhGaD5Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Jul 2021 23:57:16 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12433 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhGaD5Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Jul 2021 23:57:16 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gc9Nf39Hnzcjxq;
        Sat, 31 Jul 2021 11:53:38 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 31 Jul 2021 11:57:05 +0800
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 31 Jul 2021 11:57:04 +0800
Subject: Re: [PATCH -next] selinux: correct the return value when loads
 initial sids
To:     Paul Moore <paul@paul-moore.com>
CC:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, <selinux@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangweiyang2@huawei.com>
References: <20210728063110.3652-1-xiujianfeng@huawei.com>
 <CAHC9VhSAA5KmeG9-0t=A6wRyxuHZPLpZ4H=HE0FbT1fwcUeFnA@mail.gmail.com>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <8e53b6ba-2528-1509-71ec-b6ff8dad1e18@huawei.com>
Date:   Sat, 31 Jul 2021 11:57:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSAA5KmeG9-0t=A6wRyxuHZPLpZ4H=HE0FbT1fwcUeFnA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


在 2021/7/28 23:56, Paul Moore 写道:
> On Wed, Jul 28, 2021 at 2:30 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>> It should not return 0 when SID 0 is assigned to isids.
>> This patch fixes it.
>>
>> Fixes: e3e0b582c321a ("selinux: remove unused initial SIDs and improve handling")
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   security/selinux/ss/policydb.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
>> index defc5ef35c66..ad1183e18ce0 100644
>> --- a/security/selinux/ss/policydb.c
>> +++ b/security/selinux/ss/policydb.c
>> @@ -884,6 +884,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
>>
>>                  if (sid == SECSID_NULL) {
>>                          pr_err("SELinux:  SID 0 was assigned a context.\n");
>> +                       rc = -EINVAL;
>>                          sidtab_destroy(s);
>>                          goto out;
>>                  }
> Hi Xiu Jianfeng,
>
> Thanks for the patch, but since you are fixing the error handling in
> policydb_load_isids(), would you mind respinning this patch to get rid
> of the "out" label and just have all of the associated callers return
> directly instead?  I generally dislike jump targets that do nothing
> else other than return a value; those 'goto X;' statements can easily
> be converted into 'return Y;' statements.
no problem, please check the v2 patch.
>
> Thanks.
>
