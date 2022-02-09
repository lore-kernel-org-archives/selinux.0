Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E96CC433F5
	for <selinux@archiver.kernel.org>; Wed,  9 Feb 2022 06:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiBIG7G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Feb 2022 01:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiBIG7F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Feb 2022 01:59:05 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD867C0613CB
        for <selinux@vger.kernel.org>; Tue,  8 Feb 2022 22:59:07 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JtrLN51KQzbk2f;
        Wed,  9 Feb 2022 14:58:04 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 14:59:05 +0800
Received: from [10.67.108.157] (10.67.108.157) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 14:59:05 +0800
Message-ID: <faf9f594-f7fd-fd3f-9bd4-98eb613b8790@huawei.com>
Date:   Wed, 9 Feb 2022 14:58:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH testsuite] tests/binder: Build only for 4.11 and later
 kernels
Content-Language: en-US
To:     Ondrej Mosnacek <omosnace@redhat.com>
CC:     SElinux list <selinux@vger.kernel.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Xiang Yang <xiangyang3@huawei.com>,
        Cui Gaosheng <cuigaosheng1@huawei.com>,
        Lu Jialin <lujialin4@huawei.com>, Yi Yang <yiyang13@huawei.com>
References: <20220113020915.13560-1-gongruiqi1@huawei.com>
 <CAFqZXNsCMkxeGrvXrWRr71FByV-cKJL2zK+o1Xr=AKPY8mjS4g@mail.gmail.com>
From:   Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <CAFqZXNsCMkxeGrvXrWRr71FByV-cKJL2zK+o1Xr=AKPY8mjS4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.157]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 2022/01/31 21:47, Ondrej Mosnacek wrote:
> On Thu, Jan 13, 2022 at 2:48 AM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
>> Following compilation errors occur when building the tests with
>> userspace headers exported from kernel 4.4:
>>
>> binder_common.c:111:14: error: ‘const struct flat_binder_object’ has no
>> member named ‘hdr’
>>    switch (obj->hdr.type) {
>>               ^
>> client.c:58:9: error: dereferencing pointer to incomplete type
>>   if (obj->hdr.type != BINDER_TYPE_FD) {
>>          ^
>>
>> It's been checked that member `hdr` of `struct flat_binder_object` and
>> `struct binder_fd_object` were both introduced by commit feba3900cabb
>> ("binder: Split flat_binder_object") in kernel v4.11-rc1. Fix this
>> by adding kernel version check at compile time.
> 
> Sorry for the late reaction... In a corner case, one might be on a
> system where the kernel UAPI headers don't match the running kernel
> version 100%, so I'd prefer to grep the header for 'struct
> binder_fd_object' over a kernel version check here. In this case the
> actual ABI is the same before and after the kernel commit, so it makes
> sense to only check if we have a <linux/android/binder.h> that we can
> compile against.
> 
> Something like:
> 
> ifeq ($(shell grep -q 'struct binder_fd_object'
> $(INCLUDEDIR)/linux/android/binder.h && echo true),true)
> ...
> endif
> 

Just came back to work from the long New Year holiday... Yeah it sounds
good. Checking the kernel header is a better solution indeed to avoid
overkill. I will prepare a new patch for this. Thx.

>> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
>>
>> ---
>>  tests/Makefile | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/Makefile b/tests/Makefile
>> index 3f7cae3..22458a7 100644
>> --- a/tests/Makefile
>> +++ b/tests/Makefile
>> @@ -54,8 +54,10 @@ SUBDIRS += prlimit
>>  endif
>>
>>  ifeq ($(shell grep -q binder $(POLDEV)/include/support/all_perms.spt && test -e $(INCLUDEDIR)/linux/android/binder.h && echo true),true)
>> +ifneq ($(shell ./kvercmp $$(uname -r) 4.11),-1)
>>  SUBDIRS += binder
>>  endif
>> +endif
>>
>>  ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && echo true),true)
>>  ifneq ($(shell ./kvercmp $$(uname -r) 4.15),-1)
>> --
>> 2.17.1
>>
> 
> --
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
> 
> .
