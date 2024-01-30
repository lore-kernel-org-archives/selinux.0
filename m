Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFE286AD7
	for <selinux@vger.kernel.org>; Tue, 30 Jan 2024 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631454; cv=none; b=FQip0EDyTSMJki3LCLj1VlKT9GW+tpRZH151mR7jIxkQw0E2vUHUIRvzNfW9ccZHNc1z78Z1m6T1/r0F3AnPuzwXNuO5r5CHsVujOp4LczGcECs5H08UdQfh9vnNlwmNpYZz0Hb/7wUmfpPQ9SEqrvc8exNV/u/Mhh7MjtluVo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631454; c=relaxed/simple;
	bh=68yZ+c3z1GmTdSv7zugPx6d7+DJA8vIlQd3IHKXXwug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jh1uMwQhBvc0WX/gorDzvaXwQ2q5hP38y/6d0+4luUHXRsds50NLaUMsUwLhjCWG/oX7F/ekRdg1m/3l2zPNy2pEdv8AJG72gCtGEqn4zXyT4xdeXlN1jJmTXLdmAK4xn0Ix1/tbsE1aJ00KMWI6D3+Gr6I6BX23CGmLXqCCO54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JIq4gtc5; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JIq4gtc5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706631451; bh=vT54Pes9trkkaveOGpsrSHSWGSqqhEzokO+FMQQeAmk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=JIq4gtc5uXMsvmq5W+evbg4xxlAmX7fKUYm4gFqU3DgTO/v+2m7KPijo6zCRYB4xG7mY5K0Etug6djfFZGfndyDZRpV6OoLtlCoqF04zy9iWL3xnwpn7nUhnUviAjCiIrZ0UmopGFjydzCnDBtnsQEAH8oBftg4wy+EK4z5FkOw6AJtzHDyt/RrH3A/Uzc7YAf+E1v09GR3fj3MohP8mGB6QuUk6Wqsvqwd32/diqXcrv6jIb/hYjSCIOHfTGI2ayybvnoYkos425y8kZpV5NblylUfkPI5UyEhuBhKvVvJh43hdo9EdyyKzgCFberL5akkfUHvY4umeyBVU66YNeA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706631451; bh=hKVKboP7bvQ077OA+wfGLxBbSvKTixK5sedmOBIPHMR=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rFrV58YXurciQT+03CTX9E4cJ0ULWEW8hznP5D76N2HEc4hLVpqFlDEjpsmUpGElZxfM9BXzCWaBcT/Au580CgSjGD6aXmSaAcSO5Ix6zkiuSnQqRv0lD0/CeToSv5E4H6ASNtElIQUGZ7FnpTOwn4BYgcGXcBXLX5h65uwDmY9R0l+Ktf1DHpgsH9xCtIEshRJuW962H7fNL1dfVlBhdJOvoiYwZbtBrA4cIDzCCggFG4B/9Iv4FvWQmbS7I3LSVdy49YhFKZP0hR76M7KWGv6TKOkXeSOLK47MwdgVqoSUwFUYwvnBm1Nc5sYRfQP5MnZpjqKpFrQIGklrKKyiLw==
X-YMail-OSG: FEudBj8VM1kWB0qcX8bG1jC8ZW85GO6GLqx0bvuoThvfSooTD7SkYN38qsiGOx4
 PvJTtb7NNGQX4GtjazB0iohyWWKYNtW6QRH6xZVLuFlnsMfuo2_ufC23h8QCz6Dr1G26VClR.b9u
 jNcI0hA77qfnvpnaemBLMYnTic4zNrJ4YPTm9J8qwzmWCyXIO5yDNYgzH05HRs09Tk6H23RbKMZt
 dSE7gnfsYZn2ZyLpgA9BUbbZBeabYl3bsGYWT1aAdumjlhUUFm3SolAoFJSg6suKsG.3mwnHfnQL
 .lltv8IslsRIp_yLdmXCIjdGaqgkN3QCUSC3H8JfiQPfzo9b_3.iccRi3keRPeq_da_0Mo45ibPI
 HOx6xGju9DZYAtlLv3u9gU6dMW90ohSY7s3Uz1zhQNPTa8LQ8FzARTwfFPJaK9RDwrTmG3JfCGDw
 FtBTJOsoZ6JbHarO0XiPJleMICcKPCQTNVma0_vW9HmyAOervua8vizXhZ8PyHrz.s0Jat0m028z
 v6eMX4NJsjfJXiDwjwmcNDeuQGhUuMKD3eNFMOi2c5SB5acN_SdQj7TKoN1xluTdFjiCKR1mkT9f
 oISxW6FU._ocRq4HQvFI3_hSfqJLCw.mVfIU3BnYh5v05DBx69znnprj48GrFXfeO6TlD_zIRXP6
 6k90vHsOJpLSxAjG4TJIg5VlmT8TtRW0OltOTsymQZDK5oq7_MlX8WJiE9m7_fU8AUTPTewyf.kh
 65AgMw.zS_yFy9dr4MeExajx7gl3t09EZ8yxbbG.dgOrYHA_AXhYHCSBVEOVHxMkb.jJNDqV1j4g
 vXabgw2tlfZmU4q3Uc4kgOPdBRNBTr._1fXYWO9o9h5SG4Ec3DH1fvia3Koz7npIIi41mbmTSOpC
 MlabiwlJSX3wXKKVbYEjZ5McYfXFhQZ7l7bJjiBlZ6SGH1XqGDxc8NXszJokwBgdliB7rh_.Ah5j
 yr2T9wvHUIIuNrmFbeOnpnA2sMLctUVkWuGlOZMpxn0EVWN_8yXXTi2ri3dW2W8ZrlN5jqwn3OHx
 AeVsn2cqg_ltx1qFqkVwGcgaTs0jEkTYsQUBQcAR8Z0Km3VMW5.0hBguIwySs7g0aJB1wU0.FiqK
 svuEviW7orwBo99gPVnONpdFB.V2ZTX2_hPsGqv9.uygamOiW5bI_orkW5gaAZgnIWDk4Wnispvp
 yrq5RtB5rthAb0e_8oZuulcFknCUDNywvdPnxa.Dqg6l6vx7rTrLXYt_AZs38mlOGKmr2lVaKOZq
 bG40rMYwuDWAJ.ye7p3GYOrJ3wzYrFjSTdpuEyu.QKbOxwTA.TNhxpnbizqn1GLcslxCDFriqja.
 5Tkgo8enyA_.KrBcyPvgQxYcRWRczDSwX4ihiOyvBZp4czhkdyui2tqsCiHzwJ4nOUMe2206lw4i
 i5vfLT7UP.V2XrZbnYCAXzavW6BFPIHaeSp2CbJR4m3N7HJkPnzr3Jbvz5HcAyies0aEflNOraLx
 iMR_I1ik1A5vdDNhvojBO8A7Mg6llJSV97IkUNM_HKXoQCJNzWj.oDI8xcEo91DAgMJGY6a4pdCz
 MfBlASNCKRvvrbznr9gyMpKbmOXmLlgjsXwrUADfZC2xckwu7x5X88vCsxkxlizhDx7i6Nr8Cjvu
 TOpzuUnsafcf3XlSZpFy94emVXXQtVDBobJffAhLs6ALg6kbncRQbxzCOCr2zUHlE3Fifb2ZsBxR
 538u9w9KdB26KgdD5SJPklefpF89gmulxgbASfSwhDthGUjhZgvNT0npDjxgSIq3cvQ7zitFuLid
 3oqpNoc8lzCMla.TB2uZK1pDmD2ayD3M0JVeEf06NWg.s7Q0WH3KJGc4n_jLD3n7j_KqFWcigYKm
 zKjR9jTIhcseaGTpcEd4L990A88StMO3jq6ZZhFgGdyusdEbI6pIICmPngNqtiuDRROzauH9rmcy
 1BS6Rv.SH49zNWgrQMPHY6ZR11OpPoZRxqN39MtsrIsIwz0AwXp0Zh6h8hNxQxQCeGdxQHNn6BGR
 tqnnATELZi1UAcLhgoFdhoNo2sbn0PKqSsv23EpEVP6CC3NHcH1Dqt40VHM.aoE7vaRlgOKIkuI.
 juFLgrvtA01ILmiQRDLWN6A.N4ZK2g5ahAylsrYs8lenm47autDUX7d5cJ7FI6Jh788V4EWGrgGM
 ifNpJn21SkgShAwJqzrJoHxvrw2J7a2WdZz7vT8blDX2GXwpL2kC9WA2Um2bw6jiEQUIxTraafPD
 Qpm49TCjiY0jQJPM.YLemUesEG7dQJi_oYwuyhdbeEW9jUBl7uph4d7kEwgPuPXhuZuvmeeZ.7Ol
 MaG2a
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3c6322fb-a137-4d7c-ad3e-b7c2f869e628
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 Jan 2024 16:17:31 +0000
Received: by hermes--production-gq1-5c57879fdf-bmngc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f98b13204dd9e0376973f987393161e6;
          Tue, 30 Jan 2024 16:17:28 +0000 (UTC)
Message-ID: <35e3a47c-a7ea-4fe6-ba60-d253ea728098@schaufler-ca.com>
Date: Tue, 30 Jan 2024 08:17:26 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: fix default return value of the socket_getpeersec_*
 hooks
Content-Language: en-US
To: Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240126184531.1167999-1-omosnace@redhat.com>
 <CAHC9VhRy2uYmfoWYx57P6dRcZsJHmgCmdixi56hUoO=YvOqa5A@mail.gmail.com>
 <6e98ef30-ba98-4e99-bb03-9878c50e957b@schaufler-ca.com>
 <CAHC9VhRv260QHLe4RWYCD62DRv5-b7o-Davn_A9J_ZHJhMiJag@mail.gmail.com>
 <CAFqZXNtLPM7vWDM5CMeG9r+8kB=HcaFfh0ZCqAQy0jfBnE_XDg@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAFqZXNtLPM7vWDM5CMeG9r+8kB=HcaFfh0ZCqAQy0jfBnE_XDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22046 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/30/2024 12:29 AM, Ondrej Mosnacek wrote:
> On Tue, Jan 30, 2024 at 4:01 AM Paul Moore <paul@paul-moore.com> wrote:
>> On Mon, Jan 29, 2024 at 6:25 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 1/29/2024 3:02 PM, Paul Moore wrote:
>>>> On Fri, Jan 26, 2024 at 1:45 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>>>>> For these hooks the true "neutral" value is -EOPNOTSUPP, which is
>>>>> currently what is returned when no LSM provides this hook and what LSMs
>>>>> return when there is no security context set on the socket. Correct the
>>>>> value in <linux/lsm_hooks.h> and adjust the dispatch functions in
>>>>> security/security.c to avoid issues when the BPF LSM is enabled.
>>>>>
>>>>> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
>>>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>>>> ---
>>>>>  include/linux/lsm_hook_defs.h |  4 ++--
>>>>>  security/security.c           | 31 +++++++++++++++++++++++++++----
>>>>>  2 files changed, 29 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>>>>> index 185924c56378..76458b6d53da 100644
>>>>> --- a/include/linux/lsm_hook_defs.h
>>>>> +++ b/include/linux/lsm_hook_defs.h
>>>>> @@ -315,9 +315,9 @@ LSM_HOOK(int, 0, socket_getsockopt, struct socket *sock, int level, int optname)
>>>>>  LSM_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level, int optname)
>>>>>  LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
>>>>>  LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb)
>>>>> -LSM_HOOK(int, 0, socket_getpeersec_stream, struct socket *sock,
>>>>> +LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_stream, struct socket *sock,
>>>>>          sockptr_t optval, sockptr_t optlen, unsigned int len)
>>>>> -LSM_HOOK(int, 0, socket_getpeersec_dgram, struct socket *sock,
>>>>> +LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_dgram, struct socket *sock,
>>>>>          struct sk_buff *skb, u32 *secid)
>>>>>  LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t priority)
>>>>>  LSM_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
>>>>> diff --git a/security/security.c b/security/security.c
>>>>> index 6196ccaba433..3aaad75c9ce8 100644
>>>>> --- a/security/security.c
>>>>> +++ b/security/security.c
>>>>> @@ -4624,8 +4624,20 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>>>>>  int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
>>>>>                                       sockptr_t optlen, unsigned int len)
>>>>>  {
>>>>> -       return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
>>>>> -                            optval, optlen, len);
>>>>> +       struct security_hook_list *hp;
>>>>> +       int rc;
>>>>> +
>>>>> +       /*
>>>>> +        * Only one module will provide a security context.
>>>>> +        */
>>>>> +       hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
>>>>> +                            list) {
>>>>> +               rc = hp->hook.socket_getpeersec_stream(sock, optval, optlen,
>>>>> +                                                      len);
>>>>> +               if (rc != LSM_RET_DEFAULT(socket_getpeersec_stream))
>>>>> +                       return rc;
>>>>> +       }
>>>>> +       return LSM_RET_DEFAULT(socket_getpeersec_stream);
>>>>>  }
>>>> I'm beginning to wonder if we shouldn't update call_int_hook() so that
>>>> it works for LSM_RET_DEFAULT() instead of assuming a zero/0 return
>>>> value.  Thoughts?
>>> call_int_hook() was intended to address the "normal" case, where all
>>> hooks registered would be called and the first error, if any, would
>>> result in an immediate failure return. Hooks that behaved in any other
>>> manner were expected to be open coded. The point of using the macros
>>> was to reduce so much code duplication. I really don't want to see
>>> call_int_hook() evolve into something hard to work with, or that has
>>> non-obvious side effects. I think we could probably integrate
>>> LSM_RET_DEFAULT() safely, but I'm wary of hiding these abnormal cases
>>> in the macro.
>> Yes, I'm not talking about modifying call_int_hook() to handle
>> something like security_vm_enough_memory_mm(), I'm just talking about
>> updating it use LSM_RET_DEFAULT() instead of zero.
>>
>> While we are at it, we should probably get rid of the second parameter
>> too, @IRC, and just use the assigned LSM_RET_DEFAULT().  That always
>> struck me as a bug waiting to happen if/when those two fell out of
>> sync.
> You're reading my mind :) I already started writing a patch that does
> exactly that after I posted the security_inode_getsecctx() patch.
> While working on it I gradually found two more pre-existing issues, so
> I wanted to post fixes for them before the refactor for better
> backportability. I should be able to post the patch today.
>
> BTW, the IRC param removal means that a few of the existing
> call_int_hook() calls have to be open-coded, but even then the patch
> removes more LoC than it adds, so I think it's worth it.

OK, I'm good with it. Getting rid of @IRC is the clincher.

