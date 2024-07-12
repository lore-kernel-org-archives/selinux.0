Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB31FAA
	for <selinux@vger.kernel.org>; Fri, 12 Jul 2024 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720749207; cv=none; b=LSd9fTJXPDcKkk+dRUDh6AZAb0zU9lyTQ2KTHEhpu+ksTeAzjs9X9EJ9s4hmLMyoRf1FuHXL9YtJUFAG69h7q9LRUb7wJHns5wNiUh5dVSZGHmHnbNaEwtNiHrHjYxA86jPSmSE26xBBhYjJkBVxIJweEZ+SIRjgEJZNHWEr7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720749207; c=relaxed/simple;
	bh=ILvA6CvJBXhAc/f2YCeGH7Z8pNW2XXNOQGhq/W51Ezk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LuWVV/PLu0kwVA4NUvLTG/Kzh3uCjmf8kpDgAiRx4bCgqLaXtRIDRh/pTJv/k669b+kXa3LgtSKJfMjNhx9oTlWObHyXEW9nSWzFH/A0h0+T6dNQcKouo9CXyftMNig+Md7EGQeS2EkLZy0eM+tCQEddUjQH9VxrnUxUIEtSUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WKvdw0n8fz2Cl93;
	Fri, 12 Jul 2024 09:49:08 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id F3FEA140337;
	Fri, 12 Jul 2024 09:53:21 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 12 Jul 2024 09:53:21 +0800
Subject: Re: [PATCH] selinux: refactor code to return the correct errno
To: Paul Moore <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
	<omosnace@redhat.com>
CC: <selinux@vger.kernel.org>
References: <20240711025852.916781-1-cuigaosheng1@huawei.com>
 <4307eaa682df719d7d5d4c61f4a996aa@paul-moore.com>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <1c10e2da-4f48-b8e9-f407-44efc8ffb8b8@huawei.com>
Date: Fri, 12 Jul 2024 09:53:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4307eaa682df719d7d5d4c61f4a996aa@paul-moore.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200011.china.huawei.com (7.221.188.251)

Thanks for your work.

I've removed the modifications to netif and netport, and update the 
selinux_netlbl_sock_genattr's comment header.

On 2024/7/12 5:19, Paul Moore wrote:
> On Jul 10, 2024 Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>> Refactor the code in sel_netif_sid_slow to get the correct errno
>> when an error occurs.
>>
>> Add some similar modifications to selinux_netlbl_sock_genattr and
>> sel_netport_sid_slow.
>>
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   security/selinux/netif.c    | 16 ++++++++++------
>>   security/selinux/netlabel.c | 16 ++++++++--------
>>   security/selinux/netport.c  | 12 +++++++-----
>>   3 files changed, 25 insertions(+), 19 deletions(-)
>>
>> diff --git a/security/selinux/netif.c b/security/selinux/netif.c
>> index 43a0d3594b72..6d8544d8c63c 100644
>> --- a/security/selinux/netif.c
>> +++ b/security/selinux/netif.c
>> @@ -156,14 +156,18 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
>>   	ret = security_netif_sid(dev->name, sid);
>>   	if (ret != 0)
>>   		goto out;
>> +
>>   	new = kzalloc(sizeof(*new), GFP_ATOMIC);
>> -	if (new) {
>> -		new->nsec.ns = ns;
>> -		new->nsec.ifindex = ifindex;
>> -		new->nsec.sid = *sid;
>> -		if (sel_netif_insert(new))
>> -			kfree(new);
>> +	if (!new) {
>> +		ret = -ENOMEM;
>> +		goto out;
>>   	}
>> +	new->nsec.ns = ns;
>> +	new->nsec.ifindex = ifindex;
>> +	new->nsec.sid = *sid;
>> +	ret = sel_netif_insert(new);
>> +	if (ret)
>> +		kfree(new);
> The case where we fail add the new netif to the cache should not return
> an error as we were able to successfully lookup the SELinux SID for the
> netif and return it to the caller.  Yes, we were not able to add it to
> the cache, but that doesn't mean we should fail the operation by
> returning an error code.
>
>>   out:
>>   	spin_unlock_bh(&sel_netif_lock);
>> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
>> index 55885634e880..40b5dcbd97d4 100644
>> --- a/security/selinux/netlabel.c
>> +++ b/security/selinux/netlabel.c
>> @@ -76,11 +76,12 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
>>   
>>   	secattr = netlbl_secattr_alloc(GFP_ATOMIC);
>>   	if (secattr == NULL)
>> -		return NULL;
>> +		return ERR_PTR(-ENOMEM);
>> +
>>   	rc = security_netlbl_sid_to_secattr(sksec->sid, secattr);
>>   	if (rc != 0) {
>>   		netlbl_secattr_free(secattr);
>> -		return NULL;
>> +		return ERR_PTR(rc);
>>   	}
>>   	sksec->nlbl_secattr = secattr;
> You need to update the function's comment header to indicate that it
> returns error codes encoded with ERR_PTR() on failure.
>
>> diff --git a/security/selinux/netport.c b/security/selinux/netport.c
>> index 2e22ad9c2bd0..a75a479515fb 100644
>> --- a/security/selinux/netport.c
>> +++ b/security/selinux/netport.c
>> @@ -152,12 +152,14 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
>>   	if (ret != 0)
>>   		goto out;
>>   	new = kzalloc(sizeof(*new), GFP_ATOMIC);
>> -	if (new) {
>> -		new->psec.port = pnum;
>> -		new->psec.protocol = protocol;
>> -		new->psec.sid = *sid;
>> -		sel_netport_insert(new);
>> +	if (!new) {
>> +		ret = -ENOMEM;
>> +		goto out;
>>   	}
>> +	new->psec.port = pnum;
>> +	new->psec.protocol = protocol;
>> +	new->psec.sid = *sid;
>> +	sel_netport_insert(new);
> Same logic as sel_netif_sid_slow().
>
> --
> paul-moore.com
> .
