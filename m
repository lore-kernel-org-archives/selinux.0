Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C589C204696;
	Thu,  9 Jan 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440143; cv=none; b=NRQAUbOYieft18MZ68gEqqPNAVOGUGsej6km67C2N6wRim7uAifNeO0IduHiWIH/6eOcc5/T5lkOEHC/4HkhDcEKRVLCQ2hyp396uAkg9gD7Z9kJTGV+dx2eewVYVX2YOAckAejatW+PUlX50rFCzUNv3bK2LQhyn0ERxfAwnoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440143; c=relaxed/simple;
	bh=LY+UcBNNQ8laUKraGNYop55PbT/9+G7RgawT7Kn5oOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bKGDtq7JRxwvHZ3pfyp4NvW1GOfd2RdnUTvgJ7fExKxySfvEPX7PT/tIbES2hfbnqNX9wg8Ytgpmc0uQX2UngacITbu1myjj/dW+4RNl1yDtedKVuzW/z5VdaMuWI8eO+jp+T06LaeyHIeTbVptEWTmIKAmpVq3xPOGqgZ9SEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YTVVB4ydjz6JB8L;
	Fri, 10 Jan 2025 00:24:18 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C7B0140A86;
	Fri, 10 Jan 2025 00:28:57 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 9 Jan 2025 19:28:55 +0300
Message-ID: <66ee4364-d4e6-cd98-559c-1bf00905ec71@huawei-partners.com>
Date: Thu, 9 Jan 2025 19:28:53 +0300
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selinux: Read sk->sk_family once in selinux_socket_bind()
Content-Language: ru
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley
	<stephen.smalley.work@gmail.com>
CC: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	<selinux@vger.kernel.org>, <omosnace@redhat.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<yusongping@huawei.com>, <artem.kuzin@huawei.com>,
	<konstantin.meskhidze@huawei.com>
References: <20241212102000.2148788-1-ivanov.mikhail1@huawei-partners.com>
 <20241212.zoh7Eezee9ka@digikod.net>
 <b92e65aa-84aa-a66f-2f61-b70fd5c6b138@huawei-partners.com>
 <CAEjxPJ737irXncrwoM3avg4L+U37QB2w+fjJZZYTjND5Z4_Nig@mail.gmail.com>
 <fe8fe02f-db3b-a4a2-508f-dda8b434d44a@huawei-partners.com>
 <CAHC9VhRT3VSvWbecSa5pnWMUkgmFVCAiMn=OtguHr_GCYcYbzw@mail.gmail.com>
 <CAEjxPJ7+13QMFefy9uKYr449db2pi66CU-0GOFZ+BszpQJcStA@mail.gmail.com>
 <CAHC9VhQ4sQYRriRA-NMPBhUdN9Abb439oxTz5EQtEKJHNv=Nug@mail.gmail.com>
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <CAHC9VhQ4sQYRriRA-NMPBhUdN9Abb439oxTz5EQtEKJHNv=Nug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 mscpeml500004.china.huawei.com (7.188.26.250)

On 1/8/2025 12:00 AM, Paul Moore wrote:
> On Tue, Jan 7, 2025 at 3:16 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Fri, Dec 13, 2024 at 3:09 PM Paul Moore <paul@paul-moore.com> wrote:
>>> On Fri, Dec 13, 2024 at 11:40 AM Mikhail Ivanov
>>> <ivanov.mikhail1@huawei-partners.com> wrote:
>>>> On 12/13/2024 6:46 PM, Stephen Smalley wrote:
>>>>> On Fri, Dec 13, 2024 at 5:57 AM Mikhail Ivanov
>>>>> <ivanov.mikhail1@huawei-partners.com> wrote:
>>>>>>
>>>>>> On 12/12/2024 8:50 PM, Mickaël Salaün wrote:
>>>>>>> This looks good be there are other places using sk->sk_family that
>>>>>>> should also be fixed.
>>>>>>
>>>>>> Thanks for checking this!
>>>>>>
>>>>>> For selinux this should be enough, I haven't found any other places
>>>>>> where sk->sk_family could be read from an IPv6 socket without locking.
>>>>>>
>>>>>> I also would like to prepare such fix for other LSMs (apparmor, smack,
>>>>>> tomoyo) (in separate patches).
>>>>>
>>>>> I'm wondering about the implications for SELinux beyond just
>>>>> sk->sk_family access, e.g. SELinux maps the (family, type, protocol)
>>>>> triple to a security class at socket creation time via
>>>>> socket_type_to_security_class() and caches the security class in the
>>>>> inode_security_struct and sk_security_struct for later use.
>>>>
>>>> IPv6 and IPv4 TCP sockets are mapped to the same SECCLASS_TCP_SOCKET
>>>> security class. AFAICS there is no other places that can be affected by
>>>> the IPV6_ADDFORM transformation.
>>>
>>> Yes, thankfully we don't really encode the IP address family in any of
>>> the SELinux object classes so that shouldn't be an issue.  I also
>>> don't think we have to worry about the per-packet labeling protocols
>>> as it's too late in the communication to change the socket's
>>> associated packet labeling, it's either working or it isn't; we should
>>> handle the mapped IPv4 address already.
>>>
>>> I am a little concerned about bind being the only place where we have
>>> to worry about accessing sk_family while the socket isn't locked.  As
>>> an example, I'm a little concerned about the netfilter code paths; I
>>> haven't chased them down, but my guess is that the associated
>>> socket/sock isn't locked in those cases (in the relevant output and
>>> postroute cases, forward should be a non-issue).
> 
> We still need an answer on this.

Sorry for the late reply,
I found out that security_sock_rcv_skb() can also be called without
locking the IPv6 socket (this can be easily verified by manual testing).

Netfilter hooks seems to be ok, family value is taken from the
nf_hook_state structure, so there is no access to sk->sk_family.

SCTP and MPTCP hooks should not be considered, because IPV6_ADDRFORM is
only available for TCP, UDP and UDPLITE protocols.

There are 2 more functions that access sk_family:
* security_sock_graft() - socket is locked by inet_accept(),
* security_inet_conn_established() - socket is locked by connect(2) or
   in BH context (Cf. tcp_v6_rcv).

> 
>>> How bad is the performance impact of READ_ONCE()?  In other words, how
>>> stupid would it be to simply do all of our sock->sk_family lookups
>>> using READ_ONCE()?
>>
>> I could be wrong, but I don't think there is any overhead except on Dec Alpha.
> 
> Then perhaps the right answer is to use it everywhere.
> 

Indeed, using READ_ONCE() in the considered hooks should not lead to
any overhead. I wonder if it would be better not to touch the SCTP
and MPTCP hooks anyway. Adding READ_ONCE() in selinux_sock_graft() is
fine if you think it's better this way.
