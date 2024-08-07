Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8520D1A288;
	Wed,  7 Aug 2024 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022198; cv=none; b=ZHLtN6Z6UMc5ra5FGDevpC+jrhVQ9+ueja3NMXZe66GyEi9O/W0uf4EwfxjJRGyHOmuV+tV6FJoSFmoAzNWPuh3Z3dufbgjS/Z+H1HNrQLRxe6beA4/2KShPbFUdf2oKSro6R9Wqc4L2fksy9lVKzFEWJXdiuz+Ud+HetNbBy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022198; c=relaxed/simple;
	bh=BSePUza6mY10gNCSOCdJYFa1PrOu6WP5wsmTSJDSndQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fteeQGd8zP8++7gIyyjrjcndkf7t4lZCq/jCCO66s6BFe24ub6r0z1F7vSpR32GYXQdh9XCLaGg+r+E/C06UQwSvL8jPpe5RiAI6gmp1kK6u9OLOhtPlO8JiUmVwgrSOXYLgh29lXU6vAQAudCEc1j2pSUpyuLTJ+UoEm/EPVUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wf4Ks207Gz4f3lfh;
	Wed,  7 Aug 2024 17:16:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9669F1A06D7;
	Wed,  7 Aug 2024 17:16:31 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4VrO7Nm+zwNBA--.20939S3;
	Wed, 07 Aug 2024 17:16:29 +0800 (CST)
Subject: Re: [PATCH] selinux: Fix potential counting error in
 avc_add_xperms_decision()
To: Markus Elfring <Markus.Elfring@web.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, selinux@vger.kernel.org,
 Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Vander Stoep
 <jeffv@google.com>, Nick Kralevich <nnk@google.com>
References: <20240806065113.1317-1-thunder.leizhen@huaweicloud.com>
 <600318b9-928c-4466-a8d1-334fab8c512f@web.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <8e9f8931-0fd8-5808-8898-761e31e55208@huaweicloud.com>
Date: Wed, 7 Aug 2024 17:16:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <600318b9-928c-4466-a8d1-334fab8c512f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj4VrO7Nm+zwNBA--.20939S3
X-Coremail-Antispam: 1UD129KBjvdXoWrWFWrtrykXw13ur1fCw4kWFg_yoWxXFb_CF
	n5CF1UW395GFWDZFs5Kw47Ar95uwnrJF95A3W8WrZrCw15JanxZF43GFZ5Aw1fu39rCFn7
	CF4aq3y8Z3W2vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQ6p
	9UUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/



On 2024/8/7 0:30, Markus Elfring wrote:
>> The count increases only when a node is successfully added to
>> the linked list.
> 
> 1. Please improve such a change description with an imperative wording.
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.11-rc2#n94
Ok, I'll try to improve it.

> 
> 2. How do you think about to omit the word “potential” from the summary phrase?
I added "potential" because it's unlikely that the memory request will fail. Maybe "possible" would
be better.


> 
> 
> Regards,
> Markus
> .
> 

-- 
Regards,
  Zhen Lei

