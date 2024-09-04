Received: from sonic312-31.consmr.mail.ne1.yahoo.com (sonic312-31.consmr.mail.ne1.yahoo.com [66.163.191.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931D46FD3
	for <selinux@vger.kernel.org>; Wed,  4 Sep 2024 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413061; cv=none; b=Ks/wIAEnt4SFi1DPy7uQDPbbeknQ9TBrt49vKzdiTf/v7QpPtQKjeRf2ZoYmO4d6oeApLbL3PQLL1wqsqWZslNPHBx5vszezJ9oDBfxoRQ68tQm4qj0IR9ZscqwgyIDiIxQ7mnnnybqDgTUBEpNt7A9z7qrbiXtRD2cA7u/KMBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413061; c=relaxed/simple;
	bh=RKCgTzochwovyb9kCSLQxVjYNDW6VyjBEiwa6teJO2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6lbcQSQgDRjzfk4GckJyM1I8aKy3qYlPoEXf1bDElIqIiyVEI8fOCLC9UB/Se2CEPBELB2uNOww7hUiS7csRJkxbkCzRiqbOvGUp9OKi1qfyjtl9WrotrFZankwIRrcRGjPmejOwYF2Ha0mvhlcATh1SEw5c4Qvc00QVZMyoO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=TJXoLPBI; arc=none smtp.client-ip=66.163.191.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TJXoLPBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725413051; bh=tJRb7v4V+QlyUMl5WlOAjWe7MohT11j+U4Ue4Dt9LFM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=TJXoLPBIeR/MhovKGtt7p777vza4yPCEZRqkd8qb4XI7m9cStRAPN84TPV3cJSSSIT4p/MAL3jlZ6b5AuMUi8l4XltVj9uLObJnJku+dWj0fWaS86csirfX6JEQXTFnE3Xo5FDTNrb9z4cPo+quF/fcmbm23q9ebeO9eYNauAF0rtt1PWkkJ5AE14E8fsx0gCAMXIBYqi6KGBaFI2Kj3MEzM9mJnMJjFmW1OBK7tg1/S1hP0Rcdkk9Rfxcgmyuumj/4ZJ6ZOc/jsEKGWJn9tsTLaEPVy4+lQb5UxIFduZ6pwRypqlrsVSBnhSkL6OAkVg3m4/9B6Y1W+5oV3LSQT7A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725413051; bh=xmuvqwCgV0weKOD3WeWeeYyRSb9I0kOOE3MhdtzwNXL=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=dZzLg80xePzpBrtVh8diO5YA98iFYPxprgAe0HLm5LicB2awEXjw69W9HbqpBBiwxEMV9CDtTKee2Lsj2PoMgweu8OtrtVUx4crxvMIkqyRhQkLQHLoJgtnwLyvcB+YkK4CSFwFX7U9FLLaLIHPX0teTga82ly72RKV33ausDNCKYzOr2oaUjnQGVsfQ3UZwRiBIUBOhMn2/wOMvxD8ugAjagfBcNKVlyWfcmNHv8cr2rzIcMkHFNFQthc/pum8J9EA2XIkx+zt4pIg+jVAy2hg0UiiDPc+NSmSAwm6WMA0thYc0kCx/2/bXmA+tEvLNm9ODMYfHM3oC0vj1ShDUgw==
X-YMail-OSG: Ric5DJUVM1nRyf00.eiLfxw_YUlzfH0_.1p6k6FyqDW5bSvgDwqP8l0biJea0Q8
 52yYDBRa7kTkqBHUNqSdc1PRX3F3gMPsfDC.Ag6MhV5Q2ZAt5scaDr.zSiGp0t9b.5QlGjo3xysv
 YYD5qiHELtAdhOx0E_NWmc4rVnOcxAtVkoU.nBLZWh.GyoiwIocJz195sVZj8WNp2gusrNg.94iy
 6teLI2CL1Bv9V67sKwRXvQeqTKuHi63bvgPlNYiD5kNrMej0tL0LZqQSmfSo8DBMGTaPWxC1NZnR
 o9HTdvJLgyPPA7sWnTm0w9tQNhJoDKFiU7c59curZi4c0ahDXQSaI_zw4iUmAvJQRZ5gRgoyXvAZ
 46.c3ReozRB3YdOyf9rAhleeu68WrOLZUUS2kkYcvBa5ki2t2HH3VXMeeG0Pe_iFdJ3Jv4n61D0L
 AwWHWZMRBqyTOmyS5VcGZac6yhhnJuh1jpw52aUFSKmuhVpJGdzUvWO3JEuPosgMRcN83LXDBNWM
 rCXfi4XsdMqHEhKH.8CUNPcA9XRfhQRFBd.ZG_NwAjmZYFvR0IYOYcO5Ejgr7zF6xotEgylwSRxo
 kDwUoqxqjUGktkJu_P4oklzogZ02.MAJ_45abbSUCEHZf2Lso_QKIMwObFoc32vvDHRUBLq_ETWe
 9OHNdtEtF3vuZq.bGy0whHeLMQ.TVwfFW2XsKRNDfd0jPOtQeoBKQxjb0TNGsrx3Mfd6YivGViQ.
 XdD7cTN1JOuEJOWjRjvoGd4ov2CGe_txeLxO5aftQNWzQ8vOGIQxCGRhBCWpt80n8LasnpmZeqVN
 pdI3GeNJq8e35RJmK52XMxaTWjHQ23YI220DVIdXujFWPtQ.621CTXoNUzUwSvWOX4QBt6ax69oq
 XL_jCDUBM4LcshNyat9f1KYZJoYg.n6qwZgO5o8UctWcTftOxmMQO7aguC9AXy840lRRrPvGiawd
 VDiuPK0sEF2DIfNGpt2zgGffMB1ooBmga4R0IDxgY54oZ.3LFbBiRJJMRGvvGnSJkpk17Ntw1.BO
 aSMzH3vddSV45X1M87YIAss3STUrcxFIlm22hIFsJ7eWqMJP6jqbM_4vRPV3Ya6jdPqzRm1nygct
 pOURPggHUTqfSFrXBlANuFQ.CSBHEie8Qr8M5IfMFZ.jou84PtQa0xbczaGZXZZzMJsPwXSuVzhi
 Fgx7krJzQjd3M5yaBSwhSGtiUsUZIA7dCFnNQb8TQEOg1JvKkIAJ98TKmK.QEapZkGIi.ySR7SGw
 .C7AsRRooj5B_w8qp_HYiPLABsd2Jc5qY._j.esIp2_ya8HQcrVBuQmef97x5YrrbdFkt3E0kPRN
 Hf.zJYkKm1j7RCnXd9quHbtVH0apxU.Qsuf3jMr_52QcREDUmGBLR8teCbPpmWpK7mRg3bfwaOgW
 wD1HO660URhKCBlpjlqa6cD2olsysZP8ngn_YRMiupcvRni.C7y0raFNBpjELTNjgqDsCV6ul93m
 _5BNnkQ9_1F7PhHK0OD_Z_FhzrPunTSxHV9hBG68anmbAqyRVluKSkTqgMZcNbGdUNyfDKtwASb_
 pAbcXtF9cuV2OVZvLzcS3JscRXBbRE27B7qgUAIhCZ5.xg13ealivnvZz4Ejg0dewfWiDBVcOQWZ
 d8vdJRMt8AvSReCxzPl.fe2tY0Spk3hT5ZqYRzJg5L3iGEpqtTf5V8VOvBZOqV6fDMKc_CRzlvE1
 XE92hXYjgBZm3qwQYwljCUK08V_nY.iqSWjDlZ.ykiHNQ.cu440ZOyY25B02b7yPTu6GkuN9y68R
 SXMgxOKxLOJH2FyjDAcqr086SUD2Ob403sZFdGgExRn60Yn3YoLeAOHw8WlbsRH0ZKZdg5RM7uOO
 aIE4T8LBrJ7hNjr6ufP4Gc6YC6dUcULGjsc0EIIcnCPHjnG7mEp2lnj7WgK8aFzGsvuvI_DA_l8Q
 .eqcPi9gX.L7MScxPk7y5EWPH1KPxb.OuzH3XqmGfti1BaBXfgWKGOwdb4j4k0ZZywuZdBu7t5mR
 8R262slT0YAw5lS3UUSqBm2bd352VLEagRMymuBVMRvxJcxfjFeLOTUZQ5Y8DE_.Lo3YG_4iODlM
 tN0Vo.peCzNdju1gWV31qzFO7nucKEFM_.kpzEgaGsA7283Qpd39WEIy.NbvtC5mRlDE54dL9Edd
 BCYhlnHPsT7eTfq_VNwSNfCAdDhP3aiKYw1OXXSIK32ZNSIv7qXES.4ppp9tbvG79OYeH2MduXvO
 BW3D9FYRclLG.1jwyXSXemX02unly2I2VjYb_cYhRR9T8wI..O.Vlfd6Vqker_AcX0y9PVs4iKFB
 iUHXzRdTdr1n4g13309z1NlOGotT8TCLowNg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e1aa14b8-a45e-491f-8cef-f2332b3cdbd6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Sep 2024 01:24:11 +0000
Received: by hermes--production-gq1-5d95dc458-4hqnr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a23a87e4c8353ec23c9f44cc171b2acc;
          Wed, 04 Sep 2024 01:24:08 +0000 (UTC)
Message-ID: <98cc9d27-6e96-48b7-93ea-6705aeba4759@schaufler-ca.com>
Date: Tue, 3 Sep 2024 18:24:07 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/13] LSM: Use lsmblob in security_ipc_getsecid
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, mic@digikod.net, audit@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240830003411.16818-6-casey@schaufler-ca.com>
 <e7c67e345b136ba6c4ebc5a8debe9338@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <e7c67e345b136ba6c4ebc5a8debe9338@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/3/2024 5:18 PM, Paul Moore wrote:
> On Aug 29, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> There may be more than one LSM that provides IPC data for auditing.
>> Change security_ipc_getsecid() to fill in a lsmblob structure instead
>> of the u32 secid.  Change the name to security_ipc_getlsmblob() to
>> reflect the change.  The audit data structure containing the secid
>> will be updated later, so there is a bit of scaffolding here.
> I think that last sentence needs to be updated based on the current
> ordering in the patchset.

Agreed. Thanks for noticing it.

>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: audit@vger.kernel.org
>> Cc: linux-security-module@vger.kernel.org
>> Cc: selinux@vger.kernel.org
>> ---
>>  include/linux/lsm_hook_defs.h |  4 ++--
>>  include/linux/security.h      | 18 +++++++++++++++---
>>  kernel/auditsc.c              |  3 +--
>>  security/security.c           | 14 +++++++-------
>>  security/selinux/hooks.c      |  9 ++++++---
>>  security/smack/smack_lsm.c    | 17 ++++++++++-------
>>  6 files changed, 41 insertions(+), 24 deletions(-)
>>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index 3e5f6baa7b9f..c3ffc3f98343 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -253,8 +253,8 @@ LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
>>  	 struct inode *inode)
>>  LSM_HOOK(int, 0, userns_create, const struct cred *cred)
>>  LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
>> -LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
>> -	 u32 *secid)
>> +LSM_HOOK(void, LSM_RET_VOID, ipc_getlsmblob, struct kern_ipc_perm *ipcp,
>> +	 struct lsmblob *blob)
>>  LSM_HOOK(int, 0, msg_msg_alloc_security, struct msg_msg *msg)
>>  LSM_HOOK(void, LSM_RET_VOID, msg_msg_free_security, struct msg_msg *msg)
>>  LSM_HOOK(int, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index a0b23b6e8734..ebe8edaae953 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -290,6 +290,17 @@ static inline bool lsmblob_is_set(struct lsmblob *blob)
>>  	return !!memcmp(blob, &empty, sizeof(*blob));
>>  }
>>  
>> +/**
>> + * lsmblob_init - initialize a lsmblob structure
>> + * @blob: Pointer to the data to initialize
>> + *
>> + * Set all secid for all modules to the specified value.
>> + */
>> +static inline void lsmblob_init(struct lsmblob *blob)
>> +{
>> +	memset(blob, 0, sizeof(*blob));
>> +}
>> +
>>  #ifdef CONFIG_SECURITY
> Once again, I think we may want a !CONFIG_SECURITY variant too.

I expect so. This is a scaffolding function, but compiles need to work.

> --
> paul-moore.com
>
