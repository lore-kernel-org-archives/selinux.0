Received: from sonic307-16.consmr.mail.ne1.yahoo.com (sonic307-16.consmr.mail.ne1.yahoo.com [66.163.190.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4B1F16B
	for <selinux@vger.kernel.org>; Sat, 25 Apr 2026 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079433; cv=none; b=n/KhRpsIox3r2JrjqKfvqf3AQPoJeanlEDUfqOVwJBWpkR4pWYU2PC7fKGk5tHgWzxXqo9eJBZi+76e11Y40q7IzAl3asbSxxhNY1EdHvCOM91gQfY05+Z+KYK87inhln+YkRVb2rFbWUoloeO5FO6uMmR4PcGFVpVayy+PUu1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079433; c=relaxed/simple;
	bh=dkPLu20/XX797k3v5QRKFlqW0c2s2lYt/RVR/bBe1Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwQ8x+OwvVOxAK/ZiG9gJcqq5diLtXVUjczUctBZXtEHvhcsIZ9hX0UP21KPBtN/6LwpXrTRQjkx+uNGH4nhSguFaY3TxoitpIFYkrotikRIcvrKqBhWJWyPrvDpQH53m2nWEl6ZEFdlKRaVD1vz9iPBV2pw/ZKCMNzctMiTafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=SSjwXzQ5; arc=none smtp.client-ip=66.163.190.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SSjwXzQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1777079431; bh=pMqHjcj4aX8BxI66vssw/8fVMjiLymykofzem6zYYcM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SSjwXzQ5y/gEy/u0iEx6Pcao6fnDWjxeUh/bc8eAhXZbU9MhtlRo49jk8HhO+72fjWeb5CovXo1dmbiYUTxJdZx+YJ7vx7CaiUf72AOQx8n30O7FDwdLgYr/HmFbTkzbpAib7hKGt0/arUYWJIeRMw4/pK3skjp7KOMTW6YKdnHi6Iur7cnB3/0g8hc0ot5jHM/gqSEFsxgLmcqKxgRy3BPpbICQYHjtD6rYcrBA9OAkpjy0niDlPhql1+BU19+P7S20Ypx6XzUxrOXSnNXCufTs5obzOnNdVMG7DJRvGnSmFHDUhon1eJFE0Ga6hw85LlIHlmPrTfOu1QPetWm63A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1777079431; bh=R1gWQpSwSSNqNBWtSn5ykOoTb9E1VzwWbLe2MnKvUqy=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=i1MjZp0jgC1mBX7V+/1dEvue/785mgWkp6ji94wIry7vo6OH4+Dy5eN4lC8M49mWKO8ixjcM80BWtWMn+4yDUnR/vMY5rXzlbI/XoFPL7810miIl7soHJyiIl/QpQuu8ajEU5rFV8r3b0D1YdMoruPEOgTYSHOsXWPYBM9urbYbaudD9GePUmZMPNlXhxuU+eM3js1TJI1mk1MXbcAxXiRKsPMmdD5M7c0L97RnhNUmP7sgORhHFMUfwgBzaD3lpmgpRSs9Du+CI3/6aY+y+X1E64PtY+LPrGTkh8l9Y0kxtdzJqV3mi4ZATt2nZKcWIBslo+9afGcDlDuaCfpfGSw==
X-YMail-OSG: GD0iMSoVM1m.r_m1nCcfv1_.sWt0Gn.P8TmP7Vqun7iQlqj5TYMktTbHOmI8X6E
 xJfjSR4xrez.FBxFSncdrCZmDKe3ky5Oln7DB7WrfxQBpKg6iIwyiG0zcAIRVC464uhvyIL6NSzp
 YSw9f7I4pXSoh1Mu4LjNCY.6pPNzxsJTNvc1MB1beE8ByUTqc1mVT3YLBzMjsQM2_PLiafdOIZR8
 3eMEedLaAEAUn6nj8yW7Mo5223FVVCO8vkaIoUGJhkJOitosuyYhxR7OApjyjywGs5BlMRufXPnk
 pBLrieJSiSb2LFgvktN_LrPQauPWBjgR.vfpkOvODoL4u5tnTg2KQTxgTQ5CsRLWRdEpjz7f5RgN
 NcvLbDpB1Re9yJ9PMoG4t8INMIFOjnmwDvuwi04Bs34I.DKhA6RH59BwtFdFgkaNaUT8eVqwXsDX
 FenO3eKC3PkiJE.4lduTL9qI3XWVhztNzsb5ecXW3Kj4JT1tEph_2YOBDlLJESGVNCOD3Z_th48_
 PSwlUQ5vyw01OfXgo5UDzgV0ZgWCnXpfqFO5o037dD_Jrh2xWKSa07QZsX4Kl9NcgDwIlh6TKAG5
 iqwAVJZhqs.wSQJKeRa7w4N5_ujuzxNE3DdM_NeYS24VhrEp6.va.sLJ6gW9lRv3gzJ9Pe439zoW
 5eewDQE5n5tiq4zljZX6acLVlFiBgBOpSAkEc5zJYYLFN5z4Z_cnS_FwXmRzzY9TIFjBxOWPjeYr
 sf1374afRHzs_sVxAxCzqrSiBYFGLlbsp5f.3b7qaBAluxrnp3tTYzOvUaE1_soGd4XljkWU3qYZ
 TN80tRd7.Y8T32MBTx7SJxkMTum1l2Cdcz_6tFvJSyUfuO_JxuXNdbl9T6wPkwNGtrPz0UefWxHP
 hE684izFp6APB_TpncB30klOxpqL_4DgzBxCf3V7E3ycHQNtvrOBGKzdy5gQ9KgnVLHuHEFicxMs
 .p03ZcJL55QLzCwruXWv7BerflDwh48.bu37xqeaPMZ662YntqHoqKaOU5z1srDpTJzef5cmRO4q
 FDRi13movJ7VGXlXhOslK_O9CdyKy_YWMB1LNAK3sv4hjZg7pOco7XsL7aV08NnKnnW5KtSiDW1j
 H8eSE9pqKIICp5X_rcX3rHrpLmGe.lpCrIDBsgX6JDjDbS.YAZ3GFJ5ry1awmhITRhrOovr.7XFb
 bGy2J53VUTElBUKUXoglAwyelVbBK5UwWFXjFi9hshHfhD7BsSDMps3qAU0bF7Mn88_tVu1EBRlx
 fMDo0jIT3Mi8wb5RfTkjbvy2Uebcq3Dcx0v3uTa6iEKHsPUv23XWaI1BDlxmcuxo82F6PrW5tnvb
 cr5uklo50D6UjquCPWTaTdR5IDr6r1LOzImLZuUVV3oYq5kIXol5JaJXALDua1maj9UmIZ04y2Bi
 OA0NMk__FY1xx3.N7dZp5fT_05Jr7TtosNskr_FLSRM8MugqNqyHKNJJ5YZO7vP8T4Qb_8Ts9eUN
 j_RbSOXJ5ZtAxXNHx5d8Ao9bXrhxjYUMntawE24.JUN5QcIOeFSODKb5OMxWYpmZVs7aDrZsQxjs
 pfyF4iHrbC3ax_EsK.z5OZuEg4ODnVNilWXWcVKUwDLn1gqH0FYaZQfXXZfQD875B3eQH1UGcLsN
 a3EMVjsrP47mc3c4GNf.80hbnSCpsahHculmAIpWiavxN2WX9bnHrDpW6OcIr_7H7.KEVeI.eiPt
 DPlURLlualgzppNebuY9MYBNgA3hkxORR6KR8xJLoqg_nRaMfJP.eAxsDZ3Z_fJDAzaasryMMH8d
 .7tO9kLkAcLeVBM4aHmVhrY2Jb3oZK9a3uGX4rNr2oER5V.IW2gRgvbfnYZOvHNSTG579Cfop6ie
 F79gMMhCGGIoaHtO6qlm.CHsGq6b76cPsUxK9schscI_PaClhDWYdb0j2yiqJ6luGYbHVvifHkB.
 Lrsz3v9SBtojjvPXK1kAQK1YzIw0nbRDqY1A8l4Su0XReaBYSM28n6mqZgk.5EzHu01P9F8ZQKoI
 v2X2klCruDKydPhwXM6aP0F8OoxYPIephFQn_94nvp8UXvmnio3osST0wJbsX8L6Lui13vyXfBTt
 V3qmg06NwdhKYD164QNld0y2k7XOcMWpWnLnvT1y_UjiC91iTifgp3cVpT67r6qRppwrUMOj5RSh
 q8R0R2XX0QFd6LkL4Ud70zLy0Zim1GsNrc20xRWArEn2.Z2uRmY.bGeBl6Ofe0njrYcuTm86qjGU
 .pmfwRGm4SMsMrffB_YMHnyIvoOJZzusOXgEJDipOEu.gL3jtOQfZcITD11TPDDQ4CT6a29KXTtg
 3WcNgGQc-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5130c370-2072-4e66-87e1-1b3724a5d0f5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Sat, 25 Apr 2026 01:10:31 +0000
Received: by hermes--production-gq1-7bb7df5c46-rzgvh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 62ac5aef9c3f8e469e057f1fe5e11743;
          Sat, 25 Apr 2026 00:39:11 +0000 (UTC)
Message-ID: <2b773051-58ed-4b81-8118-b3142491e5a9@schaufler-ca.com>
Date: Fri, 24 Apr 2026 17:39:08 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] LSM: Enforce exclusive hooks
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260225192143.14448-3-casey@schaufler-ca.com>
 <c101a47f7d262bded2bce52bf5463586@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <c101a47f7d262bded2bce52bf5463586@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25559 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/23/2026 6:19 PM, Paul Moore wrote:
> On Feb 25, 2026 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> If an LSM hook is marked as exclusive via LSM_FLAG_EXCLUSIVE
>> in lsm_hook_defs.h it will not be added to the set of hooks to
>> be executed if an different LSM has already registered an
>> exclusive hook.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/security.h |  2 ++
>>  security/lsm_init.c      | 66 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 68 insertions(+)
>>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 83a646d72f6f..e3c137a1b30a 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -2404,4 +2404,6 @@ static inline void security_initramfs_populated(void)
>>  }
>>  #endif /* CONFIG_SECURITY */
>>  
>> +extern u64 lsm_exclusive_hooks;
> We already have the 'lsm_exclusive' variable in lsm_init.c, don't create
> another variable that does the same thing.  If the scope of the existing
> variable isn't what you need, change that.

Reusing lsm_exclusive is probably doable. For the RFC it made more
sense to make them separate.

> Although to be honest, I'm not in love with what you're doing with the
> variable anyway, more on that later in the review.
>
>>  #endif /* ! __LINUX_SECURITY_H */
>> diff --git a/security/lsm_init.c b/security/lsm_init.c
>> index 05bd52e6b1f2..dc3c84387a7e 100644
>> --- a/security/lsm_init.c
>> +++ b/security/lsm_init.c
>> @@ -356,6 +356,70 @@ static int __init lsm_static_call_init(struct security_hook_list *hl)
>>  	return -ENOSPC;
>>  }
>>  
>> +/*
>> + * Hooks that are restricted to use by a single security module.
>> + *
>> + * Secmark hooks have not been converted from secids to lsm_props
>> + * due to space limitations in packet headers.
> If this is a general purpose mechanism for all types of LSM hooks, please
> don't put commentary in here about a single class of hook.

OKey Dokey. 

> If this only reason for doing all of this is for secmark, just fix
> secmark instead of going through all of this trouble.

Secmark is the bellwether for using the mechanism.

>> + * Conversions from a secid to a secctx are restricted to the
>> + * single security module. All cases where there may be multiple
>> + * modules providing the input data have been converted to use
>> + * a lsm_prop instead of a secid.
> Okay, yes, the paragraph above is true, I'm just not sure why it is
> important here?

It's important because it addresses the objection that the secmark
issue might be addressed by converting the secmark to a lsm_prop pointer.
I can certainly make that clearer.

>> + */
>> +struct lsm_exclusive {
>> +	struct lsm_static_call *name;
>> +	char *namestr;
>> +	u32 flags;
>> +};
>> +
>> +static __initdata struct lsm_exclusive lsm_exclusive_set[] = {
>> +#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...)	\
>> +	{ .name = static_calls_table.NAME, .flags = FLAGS, .namestr = "" #NAME "" , },
>> +#include <linux/lsm_hook_defs.h>
>> +#undef LSM_HOOK
>> +};
>> +u64 lsm_exclusive_hooks;
>> +EXPORT_SYMBOL(lsm_exclusive_hooks);
> Unless I missed something, we really shouldn't need to export this, why
> did you need EXPORT_SYMBOL() here?

No, you didn't miss anything. It's a carryover from an early experiment.

>> +/**
>> + * lsm_exclusive_hook_denial - Check if exclusive hook is in use
>> + * @hook: the hook to check
>> + *
>> + * Check if the hook in question is restricted to a single using LSM,
>> + * and if the LSM providing single LSM hooks is defined.
>> + *
>> + * Returns true if the hook is exclusive and they are already provided,
>> + * false otherwise.
>> + */
>> +static bool __init lsm_exclusive_hook_denial(struct security_hook_list *hook)
>> +{
>> +	int i;
>> +
>> +	if (lsm_exclusive_hooks == hook->lsmid->id)
>> +		return false;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(lsm_exclusive_set); i++) {
>> +		if (!(lsm_exclusive_set[i].flags & LSM_FLAG_EXCLUSIVE))
>> +			continue;
> The logic on this looks a bit odd.  What is wrong with something like the
> pseduo code below?

This code isn't just looking to see if the hook is exclusive, it's looking
to see if the hook is exclusive and if the LSM requesting it has been given
the privilege to register exclusive hooks. This may not be the cleanest way
to go about it, so I will reconsider how best to do that.

>     for (i = 0; ARRAY_SIZE(lsm_hooks); i++) {
>       if (lsm_hooks[i] == hook) {
>         if (lsm_hooks[i].flags & LSM_FLAG_EXCLUSIVE)
>           return true;
>         else
>           return false;
>       }
>     }
>
>> +		if (hook->scalls == lsm_exclusive_set[i].name) {
>> +			if (lsm_exclusive_hooks) {
>> +				if (lsm_debug)
>> +					lsm_pr("%s denied for %s.\n",
>> +						lsm_exclusive_set[i].namestr,
>> +						hook->lsmid->name);
> The lsm_pr_dbg() macro exists for this very reason.

Indeed. I missed it here. Will correct.

>> +				return true;
>> +			}
>> +			if (lsm_debug)
>> +				lsm_pr("Exclusive hooks limited to %s.\n",
>> +					hook->lsmid->name);
> Same as above.

Same as above.

>> +			lsm_exclusive_hooks = hook->lsmid->id;
>> +			break;
>> +		}
>> +	}
>> +	return false;
>> +}
>>
>>  /**
>>   * security_add_hooks - Add a LSM's hooks to the LSM framework's hook lists
>>   * @hooks: LSM hooks to add
>> @@ -371,6 +435,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>>  
>>  	for (i = 0; i < count; i++) {
>>  		hooks[i].lsmid = lsmid;
>> +		if (lsm_exclusive_hook_denial(&hooks[i]))
>> +			continue;
>>  		if (lsm_static_call_init(&hooks[i]))
>>  			panic("exhausted LSM callback slots with LSM %s\n",
>>  			      lsmid->name);
> I don't think we'd want to simply skip over a hook registration if the
> LSM doesn't have access to an exclusive hook.  At the very least it risks
> unexpected behavior in the LSM and at the worst it prevents the LSM from
> properly enforcing it's security policy.  There is a reason we have the
> panic() call in the existing code if we are not able to register a hook.
>
> The simpliest solution here would be to panic, like we do today.
>
> However, if you want to get fancy and enable LSMs to optionally adjust
> their behavior to cope with the loss of a hook callback (I'm looking at
> your patch 3/3 now), come up with a mechanism to report back to the LSM
> that one or more of the callbacks were not registered.  One quick thought
> would be to return a non-zero error code and add an indicator/bool/flag
> to the security_hook_list that would be set by security_add_hooks().

An LSM can easily check to see if it doesn't get exclusive hooks by looking
at lsm_exclusive_hooks after registration.

	if (lsm_exclusive_hooks != LSM_ID_ME)
		... do something (in)appropriate

