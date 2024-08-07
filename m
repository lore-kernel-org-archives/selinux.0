Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359813A3F0;
	Wed,  7 Aug 2024 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723036854; cv=none; b=e4yka9Ane5wkvSxnbLFOSBlYz6ueIkivVlo5Eh4jTZy9tZoJ2KknTTCoiTjRHodiSYpRXi6p2XaHK+8CT4xCMPUcvMziFCPZEAub+/vgaZ0arNXQcpXzR2AzGEZqofslb7UcGTDnH3xj0WOWSxC7oV/18nO+sIBr73PjMGhMh3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723036854; c=relaxed/simple;
	bh=ZSgSy8dFYIshQOupesyvcm8CHOFuw1V9C05ltd3/cQI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EOWhKCs6pbd++azaId6WVwGhSR5G3lkdvjVU+OA2q32GiEcxjhnxCDTmZtT+PrtkJrbOGFIR38bGgMLjSksePkBgfLuXrLhuIBEuNtv6BIY6ltuZpPTbLee4GsE3zbIf1PyXz2F3bxbwRW7sS3QjzQLR7QaB+fZIq/U5rE6n6bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wf9lp0y6Nz4f3k6C;
	Wed,  7 Aug 2024 21:20:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 24A261A06D7;
	Wed,  7 Aug 2024 21:20:47 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgCXv4WpdLNmjCMdBA--.28525S3;
	Wed, 07 Aug 2024 21:20:43 +0800 (CST)
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
 <8e9f8931-0fd8-5808-8898-761e31e55208@huaweicloud.com>
 <d3f95ed9-a8f2-aedb-9097-0ac420d5bfa1@huaweicloud.com>
 <ed7f98e2-596b-4e4a-bc8a-d88543eeaa6d@web.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <069f3a84-eb29-5f6c-7343-f837d9e96fff@huaweicloud.com>
Date: Wed, 7 Aug 2024 21:20:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ed7f98e2-596b-4e4a-bc8a-d88543eeaa6d@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXv4WpdLNmjCMdBA--.28525S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy3Zry7Wr4rKFykZFWkWFg_yoWkurg_ur
	10kw4kuw4kJa1DtFn5AanxJr9ruwnxWa4rZ3yrJFW7G34UAayDZanxGr93Zw1fJrn2krnx
	uFyFqr1rXw12vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsU
	UUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/



On 2024/8/7 20:06, Markus Elfring wrote:
>>>>> The count increases only when a node is successfully added to
>>>>> the linked list.
>>>>
>>>> 1. Please improve such a change description with an imperative wording.
>>>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.11-rc2#n94
>>> Ok, I'll try to improve it.
>> I see this patch has been merged into selinux/stable-6.11.
> 
> Interesting …
It's not surprising. Because maintainers deal with programmers in many countries,
they will find over time that some programmers write descriptions that are not
pleasing to the eye, not his intention, but poor English. So step back, as long
as the patch is correct and clearly describes why it's done, it's enough. It's
not a bad thing to be more inclusive of others.

> 
> 
>> So I decided not to change it, and I re-examined it,
> 
> Further collateral evolution can become more helpful,
> can't it?
> 
> 
>> and it seems that there is no problem you mentioned.
> 
> There are obviously different preferences involved for patch review processes.
> 
> Regards,
> Markus
> .
> 

-- 
Regards,
  Zhen Lei

