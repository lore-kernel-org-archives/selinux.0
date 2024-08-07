Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A768E1BD01D;
	Wed,  7 Aug 2024 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723029695; cv=none; b=MYH9/raxJLA1C06dPIbkn1oAn2BLg3xrRXpREiQcRBwNb05zbYxdf7NVPItJsKc8V1iMffb+Q2DSNpRxChNFBv76e59BGbLyJRAzt3YRqb3uFD5tm702/Mc97TAYLwzNzCGuVPTZBL5KmoNIP8bnLr/td4S6X1qroYgdwiD0YKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723029695; c=relaxed/simple;
	bh=7kUihphe2zNIaO+acMvQ8uuv0hZ4WpqvWcV0Y4YQrG4=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oQi2bLFWkHKoKGzQ8WIOLeBOks7xoLoJsGgWH6L2G0VOUMnMqX/ZLaxwCs2P8sN0oZHmlWOeBhjw5JkbIccTSrbeUQvTeeJHF5yHee5dNsIOXx9Ay9ZYlYKRn0lrfITbog13pvCX7865VfQf06QwfiIrpt2nnuRxYJ1FFaSeZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wf7676FTqz4f3jqw;
	Wed,  7 Aug 2024 19:21:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D97D71A0568;
	Wed,  7 Aug 2024 19:21:28 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgBXzIK1WLNmWlgVBA--.57192S3;
	Wed, 07 Aug 2024 19:21:27 +0800 (CST)
Subject: Re: [PATCH] selinux: Fix potential counting error in
 avc_add_xperms_decision()
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
To: Markus Elfring <Markus.Elfring@web.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, selinux@vger.kernel.org,
 Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Vander Stoep
 <jeffv@google.com>, Nick Kralevich <nnk@google.com>
References: <20240806065113.1317-1-thunder.leizhen@huaweicloud.com>
 <600318b9-928c-4466-a8d1-334fab8c512f@web.de>
 <8e9f8931-0fd8-5808-8898-761e31e55208@huaweicloud.com>
Message-ID: <d3f95ed9-a8f2-aedb-9097-0ac420d5bfa1@huaweicloud.com>
Date: Wed, 7 Aug 2024 19:21:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8e9f8931-0fd8-5808-8898-761e31e55208@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXzIK1WLNmWlgVBA--.57192S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKrWkKF4rXF4kJrW3Zr4rGrg_yoWfXFb_CF
	1SkF4DW395GFWDAFs5Kw47ArnxurnxJas5A3W8XrZrCwnxJanxAF13GF9ay3WrZrWfCFnr
	uFyavayUZw12vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267
	AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
	ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UU
	UUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/



On 2024/8/7 17:16, Leizhen (ThunderTown) wrote:
> 
> 
> On 2024/8/7 0:30, Markus Elfring wrote:
>>> The count increases only when a node is successfully added to
>>> the linked list.
>>
>> 1. Please improve such a change description with an imperative wording.
>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.11-rc2#n94
> Ok, I'll try to improve it.
I see this patch has been merged into selinux/stable-6.11. So I decided not to
change it, and I re-examined it, and it seems that there is no problem you
mentioned.

> 
>>
>> 2. How do you think about to omit the word “potential” from the summary phrase?
> I added "potential" because it's unlikely that the memory request will fail. Maybe "possible" would
> be better.
> 
> 
>>
>>
>> Regards,
>> Markus
>> .
>>
> 

-- 
Regards,
  Zhen Lei

