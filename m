Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A34187873
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723099447; cv=none; b=LhnOf05R/GmZueAXtTXQVfpuKasW2/ACbw9v8QFo9q2sLmOqUVqODxpgpqMAK6eDRBMvPztnJFUcWTuhw4kEXY7pOovcyICu6eSc4QF7LaTEbMMo+LYOlVqqhZO/ctu01xcrS+ct8BSgBmt/rvmzHVDhVGIm6f/nIF9VHyBrZig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723099447; c=relaxed/simple;
	bh=MzhONwLQA0cfUS2TANGXEh6Nfu7gXmebeRE4o/JAb68=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f1P9OyXvcgVEkzxAlpo3pPIlrX2FEWmb2DOHQFi7R9uVLFEIsivHMpc77d9H0FxJn4obxpjuEAajh/yCmF487plHkQd9Vt7ZRwkWudj7U+0T//1O8Z0QkYRQXjxWheXolSU6MAVc/c7wzmysjkMV+oQ4PObaonx0bcY3YaNlIx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wfcp55mBWz1S74M;
	Thu,  8 Aug 2024 14:39:09 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 339BC1400CB;
	Thu,  8 Aug 2024 14:43:54 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 14:43:53 +0800
Message-ID: <7fb19e0a-118d-46a1-8d1b-ab71c545d7ed@huawei.com>
Date: Thu, 8 Aug 2024 14:43:52 +0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] selinux: use vma_is_initial_stack() and
 vma_is_initial_heap()
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Marc Reisner <reisner.marc@gmail.com>
CC: <akpm@linux-foundation.org>, <david@redhat.com>, <linux-mm@kvack.org>,
	<omosnace@redhat.com>, <peterz@infradead.org>, <selinux@vger.kernel.org>,
	<stephen.smalley.work@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>
References: <ba8477ed-b7a1-4833-a01a-b7d43ddb47b8@huawei.com>
 <ZrPmoLKJEf1wiFmM@marcreisner.com>
 <CAHC9VhSWVdiuK+VtbjV6yJiCp=2+6Bji_86mSkj1eeRL4g_Jfg@mail.gmail.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAHC9VhSWVdiuK+VtbjV6yJiCp=2+6Bji_86mSkj1eeRL4g_Jfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100008.china.huawei.com (7.185.36.138)


On 2024/8/8 9:10, Paul Moore wrote:
> On Wed, Aug 7, 2024 at 5:26 PM Marc Reisner <reisner.marc@gmail.com> wrote:
>>
>> It looks like this issue is still not fixed. There has been some
>> investigation on going in this Bugzilla for Fedora:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=2254434
> 
> FWIW, I recently learned there was also a report in the kernel
> bugzilla about the same issue:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=218258
> 
>> The behavior we are seeing is that when a process has no heap and
>> mmap(2) is called with MAP_PRIVATE | MAP_ANONYMOUS, it allocates memory
>> on the heap.
>>
>> If the address space returned by mmap(2) is later on made executable
>> with mprotect(2), that triggers an execheap avc.
> 
> ...
> 
>> This has been reproduced on kernels >= 6.6.

I try the reproducer, but fails to reproduce on my 6.6
>>
>> In reviewing the code, my best guess is that this is caused by the
>> scenario where brk == start_brk not being handled, though I am not

Is there vma_start,end and start_brk,brk infos, adding some debug print.

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 81fbfa5b80d4..b66c381c558e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3848,6 +3848,9 @@ static int selinux_file_mprotect(struct 
vm_area_struct *vma,
                 if (vma_is_initial_heap(vma)) {
                         rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
                                           PROCESS__EXECHEAP, NULL);
+                       if (rc)
+                               pr_err("DEBUG: vma_start,end=%lx,%lx, 
start_brk,brk=%lx,%lx\n",
+                                       vma->vm_start, vma->vm_end, 
vma->vm_mm->start_brk, vma->vm_mm->brk);
                 } else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
                             vma_is_stack_for_current(vma))) {
                         rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,

>> expert enough in kernel code to know. If the start address allocated
>> by mmap is before the starting program break, and the end address is
>> after the starting program break, then the avc will trigger. However,
>> I don't know how mmap deals with determining an address and if it takes
>> into account the program break, or if calling brk(2) later on will just
>> pick a new location.
> 
> I'm not a mm expert, but thankfully we have some on the To/CC line so
> I'm hopeful they will be able to take a look and provide some insight.

+Cc mmap maintainers too.

> 
> To bring the relevant code into this email, prior to using the
> vma_is_initial_heap() helper the SELinux execheap logic looked like
> this:
> 
>    /* WORKING */
>    if (vma->vm_start >= vma->vm_mm->start_brk &&
>        vma->vm_end <= vma->vm_mm->brk)
>      /* execheap denial */
> 
> ... while the current vma_is_initial_heap() helper has logic that
> looks like this:
> 
>    /* BUGGY */
>    if (vma->vm_start < vma->vm_mm->brk &&
>        vma->vm_end > vma->vm_mm->start_brk)
>      /* execheap denial */
> 
