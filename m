Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DC915AACC
	for <selinux@vger.kernel.org>; Mon, 29 Jan 2024 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570731; cv=none; b=oRAmVIwsdpJwWeG7Fvs+dg+tNMw+Xu8W9lq6FqwbPBHiDpG48L0cSJltl0gpLwjhg3saisf2XQg0K06Co4Q+U1n2tgFEg+pteyIh+H3gV2bphxo28R72qdUUVXg37vQkk/I5fAF9V4CqDBHnAW/O1boCuAlyXbEQ5AIEyqieQ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570731; c=relaxed/simple;
	bh=owQ9GR5cbkKUMpIyvRWMTDFW5uBpNJKps4kPJVHj+Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tz1aRG2aphj2tX/wOSRHAcaKLinfH/pynjTCqc2clbgJIkZRH68AdETtEdxeFMU1C/XpDexnkxCxO/nvTOd8lYeBXwajfabO3xsZJJQSYaFt5BJbXWroDuNDmkFByPIUTr/6yXvx4RHKxBuMPA5VyyhmEnaz1mEvluVmkfvXw9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=N8YkMdCT; arc=none smtp.client-ip=66.163.187.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="N8YkMdCT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706570727; bh=WCAcyCB7zCCJog3lXYC30Cy8siq8W6up9AiGRG34tJw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=N8YkMdCTIfyUcdr6LbJcX9nca7BBZuuzqajptJEBcA812bSy8uI0uS8LLkzslFquUqAq7OAQMKeKg5Y3QP8Y+dP/neZud6y/05ilzwFjnkF+iTFi37sDMvoeHbnH78dw/knOuLrVJd8qi9bfvH2zHZ8bbQdiurHrUFVbt6XhLa6oKfJXfKFHHBJXNJWb6pi+e3Ws/ZZdroyaXSZMopUCp475l8KJaQNNfxjRywZSxGSmAi33ph/3hQK7GSh12nPeDrqQscFgTRSXUt7nkod9yopgwIikydik5Eofhn1sEPUut6cY52tAJtPwpVPtqR/uZXrUeYZv4ynFmdzUP7O1Eg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706570727; bh=xpt2Z4oVuv9p3ikwUWhsQmY3KL3kFGjemcgHuqXfeFA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=FaaLoLH4QTUdG4C8UZwNx2SbD+lueycyPEpF8mJU8aktHuqwysu/h2aTiDoDYc+7PzLhffzSj1qAyUR7MJYznxivKeg8T06MfxoLZI84P/QBhta/IMy+TA8Q/7jo0cCjXHL/qwBOJ/Xpjcj2wnMOqZSAkXBzZYXiyBSTsxkRU1Y9p4gd0EpcwqtAselPOLg1Z/tJq8GpWu6cGMvuTDsLYSYIRXO6AVyYKUronmiXyYsmr2/8iAt/K2Z13d+ZfB8fhl+HpQy0s+Xft4NygCj7jHjDQFvT/T3HJEjGNqy87s7p5RAU5FQbKa0CkwK4IWuXvVkPnEJXUhNKvBDR8Ewtig==
X-YMail-OSG: 43WwvL4VM1k.rMQH27cqAEvmEwUAhdNoMYRmbdMpvoDb63nrnXkF.1fYBI9YJOn
 f9yiI2sI.pfxFP4RS0wTI_.5N7NmBQzQizRqK6gV9a3A19gBjEuJqbGcn4oJ174KhQrTzRQ6t2Af
 MQKo0Sd1rZ7Nhd9_TnNkvD2lf5ZE8AavtW1TT._5_qG3PgtjGhJGPLfmBzyfiaHzu9ZjvMtehpaR
 8FFoD8CuS.E663FtJCirD0fx4mycekIvNmIPEmENPHUFI7eRZlsI8MUi5ruI4gU7CVQP3FP0o4Wj
 Uph1hEj46JWVWMR5S9ZDu2ZdQWTvIoGWhJyG3_jyp00024zISxpxZwtZxDAmW8KZekKeRKOZHped
 zPBOWHoOr5gBMjwQD1GCRAT0Li0N8at.OrfYq2nxqcRziect11alElbiQb51RfBV61BS335FiLKz
 X9jQbt2UxJ_3iAi37055k.JNbH_dHJjnfK1ONYM3lM1bpKX4iYd3LyJNeCrmTWoKbtKybJiPH8sy
 lg8c3G8qcWwpJZR2OF_ZKXfgG0eB0xL9LmVzFcuSQHJrFBHiPF39iwNzFJOSeCgVg5JxYdKlT1UG
 H_FJ4.OIiumcNd2yDyT.kq8Yp3Oq5LRUd.1E7P4VdDYfZc3Av2EFU6kuBnMjTFpsIj7sYhZm6tIW
 X_oP8XFqpS9pyrdBAPR_OFjUS_pdnYhZTXefRdX7gdGbSzqDuML.LjUd4bzF08VPUWk7jKgle1vv
 xInX_A0QRcWrY3cVWCGxjwEq7p1AR8q8M1e2596LOg1klmh1q5FqtZcxdcxLSs9a24W8xFmkyXXN
 0zVXBGSzC3xMdggDTt4N7reJ.WrMIODmOqFqE_P.VZVPvS.fwhFWJzVwUhGujmwfOkmiEsSgLMld
 3YH86phswsVjQgcPF2Kl.5FpHHkBnYQNiYmREb1HR7pWHX2PBuvI7A78NjVLPwNgPpoS3Sa.AdlY
 s6xZ0UbKh6.D.9041swffJTRTsFE1uo9acHVR_GdeOGW_b9UZK_H_XcDCowNis6mOwlR_W36T6NL
 kMdOZGb4XQkJdlQXvRp_.oIsu3osqeF09u5IPWoat5.MA6N09yRP1gDcKFIqPST.aGwGy.nUmYK6
 DlkTyVMH.mOJ_1GcMSH.VyxnzP.KegVffq2EaDNXspEObwErFrJUyZwKjq9vVIwgt.xi7Z9v4gv.
 _GNNuypbrfijp8RU8gaVO8.rVlDXsvz3pa1AB287omogUFm7fWVgJpaMGN6HAQT5oy.dMrTICWHA
 y1xUDKvx996NNF0WOIK1C1YJKcLIrtf8AZsXoBUPIL88DZ_Iy3CwCFYEetBYx2Qjyyzo71uu9HYP
 yBG2Fe.aFNoPVuPp3IoXbF0YHf8wRu6n2eWnJdw6jp4.dfz2OjpS5lkY04Hp6.f.rBnO7ILUtJ5M
 bWlvqnLgntPVbry0JduD.UA5mA3hIN.IDLn9.qaFqK2DS4h8H7W6IGO0qgsv7XZ1hhJvEnKu4AR8
 Qzgf7ukzQj89CzO3HAAzpmYRxqkjXqeqcDkhlcM8E6I7b.T_y6gvEQP01JPPeeviYVO3PvqEtK7z
 mPWVwnscMuqWcYB22iN.hde2nGc16ZT.m5ivOZmWdVk4GQJJOqW9SS6kHP0BsjgK1Lu1axIsM2Yl
 NAGdxvaU_z6yNQmWDsCWbPxpfZItLCO8QL.4MODaU2a04WHG86_a3D9REQjyl9ZT9AuO5hyQhNjs
 PQc_5hXPVcRe7CaM6ra6EY_bN4MLuu2bBAHI0Uv.zOF8RWQo_le2ygLQ93EpKETrayI1vR4c5Uwj
 EABFJEFhVc.8X8_IBaC8KrXfIFyydET4Yr1vM3ryKw_d5enEmqfyAYD01gh3_XfSTaKKzCTrTpYm
 rPMlrG4cohUyUFUJFL966UGeAjXZLkW_l41S8nfbr4XgcCNskQTM8A771gScG6KxksoJN_gM.cOU
 ynhMcn.zcENhg.46j.cFCjoF39HL8V7LNC9UCImQ6osUULHw0cLV81IT_jxy_lZoU39m.sQWi26C
 YF_VKeIL.vGXbvpekac.Na8chGAKFx4zCqcl2WK4Ijqq7CutJbveYT0GrQhoPpR9y3hkBYYJREoU
 SvryD9hXnWBhiwk.VvYPCmyjsFmcs6pB5CwTWPJ9gogNJFsq12phBC2OXkvAsPXkyyowbs6zFyxA
 WIMLL890yP_rJMXboSL.10ZYs5M9NFfFgbIDrQaPEgadcRE74SWR1U8IaNaFuaeRUjq8kqo5pB3P
 UJPQgMkyRfRctAVGzzAq_P9y1Ua8TLzJOTk3JVy0Vh9BgdGZninTmPkbafqlhh2Nq2M85qUxJgfb
 lOc4Z
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7c0044c9-750f-47f2-b215-2e912e2b6e6a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 29 Jan 2024 23:25:27 +0000
Received: by hermes--production-gq1-5c57879fdf-nxlqc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2d4bad9b125f7719ca7c725667d41fa4;
          Mon, 29 Jan 2024 23:25:21 +0000 (UTC)
Message-ID: <6e98ef30-ba98-4e99-bb03-9878c50e957b@schaufler-ca.com>
Date: Mon, 29 Jan 2024 15:25:20 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: fix default return value of the socket_getpeersec_*
 hooks
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240126184531.1167999-1-omosnace@redhat.com>
 <CAHC9VhRy2uYmfoWYx57P6dRcZsJHmgCmdixi56hUoO=YvOqa5A@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRy2uYmfoWYx57P6dRcZsJHmgCmdixi56hUoO=YvOqa5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22046 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/29/2024 3:02 PM, Paul Moore wrote:
> On Fri, Jan 26, 2024 at 1:45 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> For these hooks the true "neutral" value is -EOPNOTSUPP, which is
>> currently what is returned when no LSM provides this hook and what LSMs
>> return when there is no security context set on the socket. Correct the
>> value in <linux/lsm_hooks.h> and adjust the dispatch functions in
>> security/security.c to avoid issues when the BPF LSM is enabled.
>>
>> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>> ---
>>  include/linux/lsm_hook_defs.h |  4 ++--
>>  security/security.c           | 31 +++++++++++++++++++++++++++----
>>  2 files changed, 29 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index 185924c56378..76458b6d53da 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -315,9 +315,9 @@ LSM_HOOK(int, 0, socket_getsockopt, struct socket *sock, int level, int optname)
>>  LSM_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level, int optname)
>>  LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
>>  LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb)
>> -LSM_HOOK(int, 0, socket_getpeersec_stream, struct socket *sock,
>> +LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_stream, struct socket *sock,
>>          sockptr_t optval, sockptr_t optlen, unsigned int len)
>> -LSM_HOOK(int, 0, socket_getpeersec_dgram, struct socket *sock,
>> +LSM_HOOK(int, -ENOPROTOOPT, socket_getpeersec_dgram, struct socket *sock,
>>          struct sk_buff *skb, u32 *secid)
>>  LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t priority)
>>  LSM_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
>> diff --git a/security/security.c b/security/security.c
>> index 6196ccaba433..3aaad75c9ce8 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -4624,8 +4624,20 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>>  int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
>>                                       sockptr_t optlen, unsigned int len)
>>  {
>> -       return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
>> -                            optval, optlen, len);
>> +       struct security_hook_list *hp;
>> +       int rc;
>> +
>> +       /*
>> +        * Only one module will provide a security context.
>> +        */
>> +       hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
>> +                            list) {
>> +               rc = hp->hook.socket_getpeersec_stream(sock, optval, optlen,
>> +                                                      len);
>> +               if (rc != LSM_RET_DEFAULT(socket_getpeersec_stream))
>> +                       return rc;
>> +       }
>> +       return LSM_RET_DEFAULT(socket_getpeersec_stream);
>>  }
> I'm beginning to wonder if we shouldn't update call_int_hook() so that
> it works for LSM_RET_DEFAULT() instead of assuming a zero/0 return
> value.  Thoughts?

call_int_hook() was intended to address the "normal" case, where all
hooks registered would be called and the first error, if any, would
result in an immediate failure return. Hooks that behaved in any other
manner were expected to be open coded. The point of using the macros
was to reduce so much code duplication. I really don't want to see
call_int_hook() evolve into something hard to work with, or that has
non-obvious side effects. I think we could probably integrate
LSM_RET_DEFAULT() safely, but I'm wary of hiding these abnormal cases
in the macro.

