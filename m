Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021DD1706
	for <selinux@vger.kernel.org>; Thu,  7 Dec 2023 17:20:29 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SmYGw6HsPz14Lvb;
	Fri,  8 Dec 2023 09:20:24 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 09:20:26 +0800
Message-ID: <fd1c5f6f-583b-4d49-8f18-ea0c8a38305d@huawei.com>
Date: Fri, 8 Dec 2023 09:20:25 +0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix VMA heap bounds checking
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
CC: <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
	<selinux@vger.kernel.org>, <linux-mm@kvack.org>, <david@redhat.com>,
	<peterz@infradead.org>, Ondrej Mosnacek <omosnace@redhat.com>
References: <20231207152525.2607420-1-wangkefeng.wang@huawei.com>
 <20231207141613.1d7d59d8c151729e25be53fa@linux-foundation.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20231207141613.1d7d59d8c151729e25be53fa@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected



On 2023/12/8 6:16, Andrew Morton wrote:
> On Thu, 7 Dec 2023 23:25:25 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
>> After selinux converting to VMA heap check helper, the gcl triggers
>> an execheap SELinux denial, which caused by different check logical.
>>
>> The old from selinux only check VMA range within VMA heap range, and
>> the new will check the intersects between the two ranges, but the corner
>> cases(vm_end=start_brk, brk=vm_start) doesn't be handled correctly.
>>
>> Since commit 11250fd12eb8 ("mm: factor out VMA stack and heap checks")
>> only a function extraction, it seems that the issue introduced from
>> commit 0db0c01b53a1 ("procfs: fix /proc/<pid>/maps heap check"), let's
>> fix above corner cases, meanwhile, corrent the wrong indentation of the
>> stack and heap check helpers.
>>
>> Reported-and-tested-by: Ondrej Mosnacek <omosnace@redhat.com>
>> Closes: https://lore.kernel.org/selinux/CAFqZXNv0SVT0fkOK6neP9AXbj3nxJ61JAY4+zJzvxqJaeuhbFw@mail.gmail.com/
>> Fixes: 0db0c01b53a1 ("procfs: fix /proc/<pid>/maps heap check")
> 
> I suggest this should be Fixes: 11250fd12eb8 ("mm: factor out VMA stack and
> heap checks").  Sure, 0db0c01b53a1 may have been wrong, but is there
> any point in suggesting to people that they backport this fix over 12 years
> worth of kernels?  Or is it the case that only kernels which contain
> 11250fd12eb8 need this change?

Fair enough, also thanks for updating the commit message.
> 
