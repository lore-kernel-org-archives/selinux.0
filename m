Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE01C3BF5;
	Fri, 13 Dec 2024 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087466; cv=none; b=fYqzw4GwxDGk/GZ5DLCbpRGjfpER+1To3kPil4Ubif6+MVJAo6shNb9QDz/BtmqAgaj675mLED6lXoDUjABVlhgx+cfQA0XsbBZWY+A7CvU/6l3wk8NwEyki1fHPoP3vN0IF54HpTiUD4EJT9V4hxtD4QncgIztHFOORyZyJNVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087466; c=relaxed/simple;
	bh=hRMOVVhsH85xo+YHkd5+b7Twl6ICG93NoR/iHXt5nUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ceZ9igpFoAoB/DQkDYrszgSm+SofNP0tP4sm+dOzRs6VApNH2TdNg8r8h94NOv2ItgruMwPx+LKFpZd/i1NiBnrXijJYzX+PRmJFXvYHf2KvfbnEiQJmfGaP9NT+e3NFyPaIPOi2Atco38Nx4FPdtx/XvWCIRz755FzUH1H0gjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y8mRs2lKHz6K5rG;
	Fri, 13 Dec 2024 18:54:17 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 208AF140134;
	Fri, 13 Dec 2024 18:57:39 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 13 Dec 2024 13:57:37 +0300
Message-ID: <b92e65aa-84aa-a66f-2f61-b70fd5c6b138@huawei-partners.com>
Date: Fri, 13 Dec 2024 13:57:34 +0300
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selinux: Read sk->sk_family once in selinux_socket_bind()
Content-Language: ru
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
CC: <paul@paul-moore.com>, <selinux@vger.kernel.org>,
	<stephen.smalley.work@gmail.com>, <omosnace@redhat.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<yusongping@huawei.com>, <artem.kuzin@huawei.com>,
	<konstantin.meskhidze@huawei.com>
References: <20241212102000.2148788-1-ivanov.mikhail1@huawei-partners.com>
 <20241212.zoh7Eezee9ka@digikod.net>
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <20241212.zoh7Eezee9ka@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 mscpeml500004.china.huawei.com (7.188.26.250)

On 12/12/2024 8:50 PM, Mickaël Salaün wrote:
> This looks good be there are other places using sk->sk_family that
> should also be fixed.

Thanks for checking this!

For selinux this should be enough, I haven't found any other places
where sk->sk_family could be read from an IPv6 socket without locking.

I also would like to prepare such fix for other LSMs (apparmor, smack,
tomoyo) (in separate patches).

> 
> On Thu, Dec 12, 2024 at 06:20:00PM +0800, Mikhail Ivanov wrote:
>> selinux_socket_bind() is called without holding the socket lock.
>>
>> Use READ_ONCE() to safely read sk->sk_family for IPv6 socket in case
>> of lockless transformation to IPv4 socket via IPV6_ADDRFORM [1].
>>
>> [1] https://lore.kernel.org/all/20240202095404.183274-1-edumazet@google.com/
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
>> ---
>>   security/selinux/hooks.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 5e5f3398f39d..b7adff2cf5f6 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -4715,8 +4715,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>>   	if (err)
>>   		goto out;
>>   
>> +	/* IPV6_ADDRFORM can change sk->sk_family under us. */
>> +	family = READ_ONCE(sk->sk_family);
>> +
>>   	/* If PF_INET or PF_INET6, check name_bind permission for the port. */
>> -	family = sk->sk_family;
>>   	if (family == PF_INET || family == PF_INET6) {
>>   		char *addrp;
>>   		struct common_audit_data ad;
>>
>> base-commit: 034294fbfdf0ded4f931f9503d2ca5bbf8b9aebd
>> -- 
>> 2.34.1
>>
>>
