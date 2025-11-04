Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909122F531C
	for <selinux@vger.kernel.org>; Tue,  4 Nov 2025 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272636; cv=none; b=SBWeXgMqsM7QAYg8B5UJP8nbnAcTdTaW4XudtnEcRett/NnYdIIrDDfK0SKgnL4XVDbhDZeZmO+1gmwTp2itGJyRsZp1z6VS+8LiI+i8naYIQl0iJLQXbVbDpRnsxf9HVa0s9rW9c3BHZMzf8fJw5C+UyzNYV+3idCekwEcyGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272636; c=relaxed/simple;
	bh=F5wTwlPeqv/P0weo9Z3cX7yXdvdLkgndYm6p3j3f/kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbQwF0Amm26wSBA5aPc+LjpIu6A4wynluVcG+x2D6kgs90CeE7pwNeLpGxt8H2/CYlv6C1RSfZkW1jPvu5QlsaZb0jOFeKGIR1R8VMLBQkB9VKU4cLeVOY/qv4aXKirefs29zMnutD+luDT4hwi3YeLVwqvjyML2U2Il7i+iwcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FzYeH9t/; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FzYeH9t/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762272632; bh=tribQdEuQHZnZfmWubrTsreLihCksXvfegAHEnde0Qg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FzYeH9t/K9NDb7vZHCiPJmd4rfDmdxM2gs/yl7AahhQZcvWMa+iiaiK3w3mIEC2q6k3VTp6BkRTI7p20OJd07+yN0iP231CkVxJi32vtLwGAlHq8UXaWuIfd2nlNyQPny/+8JL+ddO7tJ4hHRS81eoNK1nQXuJ8RsJxF2SFjvrZVl24k0Wq0/JRYMyH5GmRwbwtVKXyQxJjmkLQHobXikjRebNuF0CcCPrCzcLqOczD2Yvw9F7vHgUk66ftBawbeE4Khe9poN2sXWgxTmzlcOYtNWbEeiWfDdJeFwMbs796MKe1an4/gwmzCmUPyasESqEiBYHxgo9PXT+GDWLHcfg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762272632; bh=rjlYJknxNBMl3GBZpVvEoy6R4T4d7nD+I5lSQLe0ijN=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qB1IIPkV1rS9zzx1bP+Peo9c2OLxkTC1Zsv/X7NsMKvU4hB9E4q3aOugSI6VWKV1spQ/UjXlq/gy9S7gJ1c+8lGJZub2UQCSXxKCnJBZFyHqbAUGCaHETNJBuRmX4+BOAiMeMmIo0OekHV25OfXntsqlWbLTTapUKNtnysaJuGU199SMZJyNCMJUo4JGKBBg4TKe6flX1+EQflmBujhX8jYMPWjC24CzsfnifWaPI++vsQCipCFq0Y96GoDp59mgp6eQjs9co08QqNN/uNxv6/ye+hJ+LFGk48RPFMjEVtYsprHvHQM0DqfEMUjSQeQTFGaV9TbasAaQ5PF13inYWA==
X-YMail-OSG: BlAm0CgVM1kr39uzWq9dBnRV1Sp1ZFfu6Mimh8dNIGQNqbpnQQfM10bZ_cY9vrB
 2xnbw6L6DpPPuCPp8DBytsz6v9PhoooJD8c4XoY5QFvc.hRPNYvoys7uTi8GQ1tPTZslfX.AfN_d
 du4v5B_hSNZrZqs4tHSF4I16El_mZ4uaTcF7FL8dMhMS0q2VrMCnrxlEB0_uTmfrBkkzfR4h2bEM
 24jNxrchux7RFIZnoy5Xfs_DgErjAqESiG1GJWmUKKOLfDnyTESegC8Bf2piSOTdrlU3m9.bdKEj
 L_zKzuI0kAcVrfRZvZgmRDwdERIDmXvQaaBhs6EChhFwotdJecQZst4gXcxz8ToCmLj9CGxeo3o5
 s63LSxszt3cDuhqsSJn8tfJURUfht8iNK0UgCI_tZXRT_MaBG68jrEJoP4GXq_oyYd0nYOJh_I5t
 pNEL_OA_CkuJfSOZ9sIqpkZXgfGa6P7yz38fr0eTKzOLou_luNOeeIGX_DC.UUZYHyFn8mqZxDoe
 dPWJASG.TiXpNl1mbQUEZYPSoB8MqtOzQ8vfNnEq1iSpC7zFXXZ.yQ6Tf_cXeIes0HrSgNOpWc0I
 FRFrLlaQlvAXoFeUbNQHANp3x3czYJ6v9YJaw.C9jpz5g_Z9kwgOOZktiEbv5O_f3zemXrCzfhIZ
 JEc9vYxPvUY1H8wfbIOr7Oo4KTsGwMkkuD6kbF9Mv.7sQ8pIwYkxwu7fhLfWM6agQ9BMz9pVcb7R
 UwBq60NV.AoGi5GKsyTC4H0YmB4xWVTkPR7tq7mgGcZVBPFevUE.WNBRiQxbv6Ot1P1Woo7AhXD1
 in3uaDVEwbWhVwnMGFVYgyZCvpkmccJ3Mepq2EvDqPaBMdsomSlW2_chL0v4x23ynJpjNCCwhHpI
 68mOI5b4vPHs.N6GWTNIQvdokNVudil1b7TssAtHn3OTz63gB7rTnUck1ttUT7Bzw9qeUnkKqfSz
 _rPHSJeqca5L2Ae6A0bsyQPHXJuTnMloFtCWsRWstqd3zUzFy.6JAnfUgG1cZ9AGXnJqfGN.YDaN
 2N9IN5M3tJP9IQnABceD_f4gmv52oeHUiQV0JKEdaqJgx_HWxiB1E7WvDA9Ho3CRX28U.bAuVIgR
 yoaOTAN8qRU0Il_Sz0skHyemDeE_HrPVjzjBXGvBDrlv9N5YV8YP.uCx_cp7hv0oRH_NGZsaZ0uX
 XzQ61HlvhZCgs9L0aehNaFSSNCeswA4me8Z1aROmQM1eAiB2ii0Df9GJWCwc99LIwZ0DL9mVR0zy
 m4vv4HLkPuhold6x0Pq_WdGRQr_PpjbFO3TIa3KUGCVc9X.XRMwMmaG7dABE.zPotX0k_25ZTyvM
 5gyzz4lNObhNX2FgH98P5CiJ_xXz_qWmmJdXiB3sReh8KXyLLOVvd_6QT718m0hhsuImw4m3TGf9
 XeDT8tp0VljLeR.YdH95UpeJS_S.mjjI2Ygwro_ZPscOTP9c9aie4cerVPoWMZBfFlw1wLr8brdI
 cZL0Shj3Ml0TSzmAxItyUMKcfdrqIQcmrdBsgdJ2u8X7HKP6BCZkQWOlFYsTliQMOYOMNygK_Liq
 uCicsLPY664rb4EwfVyM.Lta5yebJcho5lgJUu3yxZKsV7n06Ha6Ax7VbBp8jxyAU0x8k48.n3iK
 2oLKQgAvY2A3N8kyMzvL48FqOCqOwZnwmkdLVrJvbE7U4.wRcIgZmAVOt0CHjIru.Qzbeyuxq4WH
 2SIb12rTrk22ufC16iTWzR8CsbzGkcN1fFsh2CC0ky4gbEsE8.ToAKcMh3FDNZhIZa9CS_lNZY9i
 ZYwAabVgZQ_cpL3nLr7bVuODRFpfB9spwrtSo.BwCJUa4mFuHSuuU1_WjTCzwWk4.duojbq.EeVR
 Dhs3zYmfmixC0BEbMfo6YbNNdftKnS.lUZjqO8jqPi.0uwANyMh6BVOGcgt_RI3Sh_ndMSYrHzm9
 .HPe9oO_f85IHpgWUdxaVrfbFvbXQCExAKge2mlP7OXfUNfMYQohIKuToftzFxDf03iDTAWqXs1O
 .gg3vL6_v8pnHxu_yK6ewDI3Z1EszVWRAvq7CKHDOo0va5_3MyALhQPKyvosvn3SfR9M3n1o4WRp
 grsdOXTlyJSGyxsWpPuolKmmvuJZmDWNXGJBCfIALuXTyHZwnY_lTih3MyO1ioS9FSWM1tBD91ey
 DvbXW_xmFURg4SKGb3HvL1P.mfuRZO0wkwNF_wQK2TOGZSQD2OkRITHQL81rJo41LHKblV6Eawg9
 FJcWJDPIMOClW2qzqke2TzmabE_A.vFsq7wfCUCQn8aNErdom0w9GJoQP4bjPraQ5mLI4bOqUyBd
 vt0TWKks6thsL96F53WhkIUNfUIGEkQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3dd02983-d416-427c-9230-2a67029a5c13
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 4 Nov 2025 16:10:32 +0000
Received: by hermes--production-gq1-86c5846576-qzzfn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 941545f190b32d1bdf3fc1f206b502e7;
          Tue, 04 Nov 2025 16:00:22 +0000 (UTC)
Message-ID: <4c8a2252-5df3-451b-b6f5-e87cf7a161b9@schaufler-ca.com>
Date: Tue, 4 Nov 2025 08:00:20 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/15] LSM: Single calls in secid hooks
To: Paul Moore <paul@paul-moore.com>, eparis@redhat.com,
 linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250621171851.5869-6-casey@schaufler-ca.com>
 <ee015074a9019ef4725f7e613fd76f86@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <ee015074a9019ef4725f7e613fd76f86@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/14/2025 4:12 PM, Paul Moore wrote:
> On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> security_socket_getpeersec_stream(), security_socket_getpeersec_dgram()
>> and security_secctx_to_secid() can only provide a single security context
>> or secid to their callers.  Open code these hooks to return the first
>> hook provided. Because only one "major" LSM is allowed there will only
>> be one hook in the list, with the excepton being BPF. BPF is not expected
>> to be using these interfaces.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  security/security.c | 24 ++++++++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/security/security.c b/security/security.c
>> index db85006d2fd5..2286285f8aea 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -3806,8 +3806,13 @@ EXPORT_SYMBOL(security_lsmprop_to_secctx);
>>   */
>>  int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>>  {
>> +	struct lsm_static_call *scall;
>> +
>>  	*secid = 0;
>> -	return call_int_hook(secctx_to_secid, secdata, seclen, secid);
>> +	lsm_for_each_hook(scall, secctx_to_secid) {
>> +		return scall->hl->hook.secctx_to_secid(secdata, seclen, secid);
>> +	}
>> +	return LSM_RET_DEFAULT(secctx_to_secid);
>>  }
>>  EXPORT_SYMBOL(security_secctx_to_secid);
> Two thoughts come to mind:
>
> If we are relying on BPF not using these hooks we should remove the BPF
> callback.  It looks like the secctx_to_secid and socket_getpeersec_stream
> callbacks are already absent from the BPF LSM, so it's just a matter of
> working with the BPF folks to see if socket_getpeersec_dgram can be
> removed.  If it can't be removed, you'll need to find another solution.

That should be doable. If BPF decides they want to use lsm_prop data
they already have a passel of work to do, and I see that they have
already suggested removing the BPF data from lsm_prop.
The socket_getpeersec_dgram interface uses secids, not lsm_prop, but
that's an artifact of networking attitude, not what's "right" for it.

> Instead of opening up the call_int_hook() wrapper here, what would it
> look like if we enforced the single callback rule at LSM registration
> time?

I have considered that approach in the past. It would require that
security_add_hooks() know which hooks are single callback and only
call lsm_static_call_init() if no LSM had requested the hook before.
This would be fairly straight forward and have the advantage of allowing
the infrastructure to report which single callback hooks have been
chosen and which disallowed. It does raise the question of whether the
LSM that requested the hook should be notified in the case it was
discarded. That's messy, as there are multiple single callback hooks,
and you could have a case where some are chosen and others disallowed.
I would go without notification, as it's hard to say what an LSM would
do with that information.

I'll give it a go in the next version.

>> @@ -4268,8 +4273,13 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>>  int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
>>  				      sockptr_t optlen, unsigned int len)
>>  {
>> -	return call_int_hook(socket_getpeersec_stream, sock, optval, optlen,
>> -			     len);
>> +	struct lsm_static_call *scall;
>> +
>> +	lsm_for_each_hook(scall, socket_getpeersec_stream) {
>> +		return scall->hl->hook.socket_getpeersec_stream(sock, optval,
>> +								optlen, len);
>> +	}
>> +	return LSM_RET_DEFAULT(socket_getpeersec_stream);
>>  }
>>  
>>  /**
>> @@ -4289,7 +4299,13 @@ int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
>>  int security_socket_getpeersec_dgram(struct socket *sock,
>>  				     struct sk_buff *skb, u32 *secid)
>>  {
>> -	return call_int_hook(socket_getpeersec_dgram, sock, skb, secid);
>> +	struct lsm_static_call *scall;
>> +
>> +	lsm_for_each_hook(scall, socket_getpeersec_dgram) {
>> +		return scall->hl->hook.socket_getpeersec_dgram(sock, skb,
>> +							       secid);
>> +	}
>> +	return LSM_RET_DEFAULT(socket_getpeersec_dgram);
>>  }
>>  EXPORT_SYMBOL(security_socket_getpeersec_dgram);
>>  
>> -- 
>> 2.47.0
> --
> paul-moore.com
