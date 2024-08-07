Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBF31B29C5;
	Wed,  7 Aug 2024 06:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012080; cv=none; b=ZRj7t11D+nwheGu8i6hz39z69qMiVzoi9365xvtalU6fxTvZpmbiaZIoCfA8mwwklX5Cj9R578vWYpaOrf55sgwN/vhhbMgoAkgKU6eoTJ67Vy/o+6dDFF27RK7BR5n7bRM2Rs/cXHSWUfvYKOhrY8JpLx4ASF8HapEbvqsiB1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012080; c=relaxed/simple;
	bh=5M+DIdusGSA7JOx3wGFaBqWCLkpdzKxkFnMf2utQf6A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nTNXEuLX9XWMWEIevrF0pjZYRhEaKzOnnUrLk0Fprp5Q+3Kx5M2/rX73smWn/PbLee5dXpjNJdDkPnFRxG7FExOe+D39CBb5w1/Y2bWGJPX3EdMI8XUX7AIt+E3QJShs6n41wc3EzXGZEPuvL8fWb0wxT0IFPYMyph+6nLf+9Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wf0bH5gnLz4f3js9;
	Wed,  7 Aug 2024 14:27:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 249D11A06D7;
	Wed,  7 Aug 2024 14:27:53 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgBXfoTnE7NmEy8CBA--.15279S3;
	Wed, 07 Aug 2024 14:27:53 +0800 (CST)
Subject: Re: [PATCH 1/1] selinux: Fix potential counting error in
 avc_add_xperms_decision()
To: Paul Moore <paul@paul-moore.com>, Zhen Lei <thunder.leizhen@huawei.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nick Kralevich <nnk@google.com>,
 Jeff Vander Stoep <jeffv@google.com>
References: <20240806065113.1317-1-thunder.leizhen@huaweicloud.com>
 <CAEjxPJ59=rHFovk3scmkhLuiAdu2uinGiua60y0naJ0e95GLmg@mail.gmail.com>
 <CAHC9VhTWye8Pm3EUr-Fy-mxq+6H1ThtAekqZd0nXX70f8xP5rw@mail.gmail.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <eb0d43b5-dc2a-6aec-da5b-493c86b3ae8b@huaweicloud.com>
Date: Wed, 7 Aug 2024 14:27:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTWye8Pm3EUr-Fy-mxq+6H1ThtAekqZd0nXX70f8xP5rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXfoTnE7NmEy8CBA--.15279S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4UAr1rGFWrKFW5Zr1UWrg_yoWDCrg_ZF
	yvyw1qv3ykXFsrJanrCry3XF13GF1rCas8Z34kuF9rZFyUJFWkXFy0yF1kZw43Can7XF9x
	KFn5AFZ29w12vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/



On 2024/8/7 5:55, Paul Moore wrote:
> On Tue, Aug 6, 2024 at 9:26 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Tue, Aug 6, 2024 at 2:51 AM <thunder.leizhen@huaweicloud.com> wrote:
>>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>>
>>> The count increases only when a node is successfully added to
>>> the linked list.
>>>
>>> Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> This looks correct to me ...
> 
> It looks good to me too, unless I hear any objections I'm going to
> merge this into selinux/stable-6.11 and send it up to Linux during the
> v6.11-rcX cycle.
> 
>> ... but I also notice that the caller is not
>> checking or handling the return code for the -ENOMEM situation.
> 
> Good catch.  We should also fix this, ideally in the same PR where we
> send the count/len fix.
> 
> Zhen Lei, would you mind working on a separate fix for checking the
> error code in the caller?

Yeah, I'd love to.

> 

-- 
Regards,
  Zhen Lei

