Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BD16A395;
	Fri, 13 Dec 2024 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108017; cv=none; b=gTlh9tzY34KZEqeAq91OSnVh5zcn4vmUUL5c6yVXzlBMBuOO1Hn7DPhWzQGAbcWvIxvZGvckRuqnyI90Fd4ad9x4xKwTWQDLzJK/6mr8fOHLhgNcOh4t94IKSz/KuREKxLFoxwJlocv6voIrs+Tn2oylxR6FfD+JZK0lnsHSLug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108017; c=relaxed/simple;
	bh=GDiexkk7pAH8avv7/z7D9a3xAVinxygO3SwzNDcyRFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RJqgp7ibJYZ64L0yfgzhGlQZKG+P1RFfzRsgtdbHgszKoq8GlNqRaTpZ1E0s9e0HY2l56+QNzTnHqhLRqSGJjI3JezRYcWvd3lLY3/tMpeHmQQc234SXwlbJrulw+FqIr/NqQiPijBeYNSgoZsaaFZFTxer2OlOMWKc0jUEF8nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y8w5t0Nz7z6L7FZ;
	Sat, 14 Dec 2024 00:39:14 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 536F1140A46;
	Sat, 14 Dec 2024 00:40:11 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 13 Dec 2024 19:40:09 +0300
Message-ID: <fe8fe02f-db3b-a4a2-508f-dda8b434d44a@huawei-partners.com>
Date: Fri, 13 Dec 2024 19:40:07 +0300
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selinux: Read sk->sk_family once in selinux_socket_bind()
Content-Language: ru
To: Stephen Smalley <stephen.smalley.work@gmail.com>
CC: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	<paul@paul-moore.com>, <selinux@vger.kernel.org>, <omosnace@redhat.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<yusongping@huawei.com>, <artem.kuzin@huawei.com>,
	<konstantin.meskhidze@huawei.com>
References: <20241212102000.2148788-1-ivanov.mikhail1@huawei-partners.com>
 <20241212.zoh7Eezee9ka@digikod.net>
 <b92e65aa-84aa-a66f-2f61-b70fd5c6b138@huawei-partners.com>
 <CAEjxPJ737irXncrwoM3avg4L+U37QB2w+fjJZZYTjND5Z4_Nig@mail.gmail.com>
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <CAEjxPJ737irXncrwoM3avg4L+U37QB2w+fjJZZYTjND5Z4_Nig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 mscpeml500004.china.huawei.com (7.188.26.250)

On 12/13/2024 6:46 PM, Stephen Smalley wrote:
> On Fri, Dec 13, 2024 at 5:57 AM Mikhail Ivanov
> <ivanov.mikhail1@huawei-partners.com> wrote:
>>
>> On 12/12/2024 8:50 PM, Mickaël Salaün wrote:
>>> This looks good be there are other places using sk->sk_family that
>>> should also be fixed.
>>
>> Thanks for checking this!
>>
>> For selinux this should be enough, I haven't found any other places
>> where sk->sk_family could be read from an IPv6 socket without locking.
>>
>> I also would like to prepare such fix for other LSMs (apparmor, smack,
>> tomoyo) (in separate patches).
> 
> I'm wondering about the implications for SELinux beyond just
> sk->sk_family access, e.g. SELinux maps the (family, type, protocol)
> triple to a security class at socket creation time via
> socket_type_to_security_class() and caches the security class in the
> inode_security_struct and sk_security_struct for later use.

IPv6 and IPv4 TCP sockets are mapped to the same SECCLASS_TCP_SOCKET
security class. AFAICS there is no other places that can be affected by
the IPV6_ADDFORM transformation.

> 
>>
>>>
>>> On Thu, Dec 12, 2024 at 06:20:00PM +0800, Mikhail Ivanov wrote:
>>>> selinux_socket_bind() is called without holding the socket lock.
>>>>
>>>> Use READ_ONCE() to safely read sk->sk_family for IPv6 socket in case
>>>> of lockless transformation to IPv4 socket via IPV6_ADDRFORM [1].
>>>>
>>>> [1] https://lore.kernel.org/all/20240202095404.183274-1-edumazet@google.com/
>>>>
>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>>> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
>>>> ---
>>>>    security/selinux/hooks.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>>> index 5e5f3398f39d..b7adff2cf5f6 100644
>>>> --- a/security/selinux/hooks.c
>>>> +++ b/security/selinux/hooks.c
>>>> @@ -4715,8 +4715,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>>>>       if (err)
>>>>               goto out;
>>>>
>>>> +    /* IPV6_ADDRFORM can change sk->sk_family under us. */
>>>> +    family = READ_ONCE(sk->sk_family);
>>>> +
>>>>       /* If PF_INET or PF_INET6, check name_bind permission for the port. */
>>>> -    family = sk->sk_family;
>>>>       if (family == PF_INET || family == PF_INET6) {
>>>>               char *addrp;
>>>>               struct common_audit_data ad;
>>>>
>>>> base-commit: 034294fbfdf0ded4f931f9503d2ca5bbf8b9aebd
>>>> --
>>>> 2.34.1
>>>>
>>>>
