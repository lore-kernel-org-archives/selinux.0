Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486933E7
	for <selinux@vger.kernel.org>; Wed,  4 Sep 2024 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725412735; cv=none; b=nAWj0Mr9dSAIfaFAOFrAmKfhnEoBd6HO3npPPQrwFAa+fjBecwF/X95COtUbEtkMXu7zvZRnVOwilcoaWqgDLjPZfZiOJR0MkML5SEkTU8Lk5LBeIbZ6zfRarJq/rKiRuvY7Xjtyc7NDOf7o474i0rVEZkutvX+xfOFiYC/4nkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725412735; c=relaxed/simple;
	bh=yNs/1T5HEKuYw3butknZxMSzlK71t80xJgmUI08RvpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iaQxvJqHUzCeaHZykfFAy9UoQrCwuLjRxtQH/v4/DaDvCRgUAHcln8c/PyCdwic6azwNQPBsbwEox38oSxtVwyWoucyahRdqRFbMT6JoxhaC7rL670CjBETWWTAa+B39i2yl6yXi83eEuxGkZa9dqFRH+bKUTWpICd6Bm0nQsfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tsAdRym/; arc=none smtp.client-ip=66.163.190.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tsAdRym/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725412727; bh=+F1gdXx2llHjfLSdb7DiIsvu2+e0ubmkCeOlGInmv24=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=tsAdRym/Niytq25mpqJbWRVFIivtx4NF76stWbPB+KEZoHKM8zeXT1eZzorZULYvhW0dWOfq0rhXH11t8z/5Tc/dsfbcMyMoNs+yrv6/tEFNef4SFE1JXHuTl9rPMHopu8txtiRxKJiP0GVK+CXfigmEbrwyb9LkEcmIVi2iQ1LYjd07vE2Bcy9Tj/RTEqx1ku4+dWyYApa/uNIRdK1+8Ua8zxz3SuLW3441zenQ63EDg0CY4d4HtEJq9F9+ztPpB7JUKdX8Tm9Mn2LvD5tlnbDr/ctAlU/TJ5CcYkQqpinTTtsC2w09Qevr+hM3ngignSBhGQj7iJLldiARIxHtOA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725412727; bh=FMDCe7+1+swmeLJWcZd63dmuPT0xDVMwdUwCLUFUjSm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MuRxmVIS+dbXVS65hWWXv733XYvL9gjJFpSDQmTcq7VkL0dZCDpTC1l2RQSnV8RTwl3h96lfnNRQNxGUYXIGrTVvG1N25nvJzcKOKJFacVpOyMbGQzT691lBcGx9E2QSfwNzsrRVo9K7YWovfDZN1dm0XhbrRP/8TfSB73XvDKYJk0oCOqfot06kJ51BJzQyMcOvKLInHcan4JIJTO9c/u/y+ObiqaHzId4ZZGz58bB5y69PdI+zySGDbmYjG467kGaIK6D+H3RcOn2SqbWN/tIfzn8krHEM6oNLSP/pkt88/sVty5IzVCbySyKDBfVnNudk6iYjqf8Bt3P2LBxdSg==
X-YMail-OSG: sWivKUcVM1lE_IiAxBNJTIfcBPpURTyUAx5r5HCy2XL6T3cp8PvRtLxmjlgvrbH
 27qXMjEMM1_8qSLNUOufF4seADeBsH7y3Vy76AJVVHqqRcRH0FqoGYj3ALgrV2I4OEPsA2COLRSj
 eZ4kzbqfmtKHQA65wwKIOszIvp_OQ9B4a.vRchCwzl_WcSgEJVF71i.R_Brs9PMpjAtub3m_p54Z
 ip61Or0HrH2Mv7D31q2NnczwMsMvuPz.N0ozIef6dLzOXJxi.vQj9b3hSJa5HCB8F9pz08eo09rk
 yZyy1yvC1Rwwpv0EmU8H1uYJbuolSHpwp.lpOpoZAvE73nkBIeRF7baKrM1ywxms_TpUAVOFkmKJ
 NjjfRqWtz6rSSe96.lx9x6TRvox7Vmu8debR0o6bIE0w7djc3oK3V8_2QQIaRE8Qc00Vb6i6ODfD
 HhL9qufPsmDdHQr2663FRWLY.ld_jLgl3Emsd5eu_KmknVWRDpS4c8JIwpi_FX.a8m.dS5dnWIrg
 6s_1ds65n8IqUbwr1Iugj_24z6g2vwOmEpF9Pswz5rwHMZO4W3LIcaNYoQ2KWbNoF.e1AOQwR2rG
 i9K_R1K_fOjfDXFXEbeCCSKAEA75aDizdCK16Pn5OISI83SwOBfhsoQv1BltMIsj.9HS3WTMwNyc
 481dQcU9AviRpVlq8rertIzoadtZkEgQk..I4GywYTWH7IpKKhu4oVS8NwhBkN9YIqSZ8FvTv1ZA
 8tWjkJyXZ0HbHFY3Q2YbbWIauHob.Q0xpw1BZ0RTuMynfQVUkwTBKrf2zWSP34CGezn7cL7AKs1q
 XYypXWvMgZ_BtK0L9C02h.a9sZd9bKREjkQ.ASwCdix5ELstIOndvT9UTK8.w3xeFPQ1r6kjBFv4
 wdOdQOm24SXUFUR3hMUz97UzibFMGFzyeaIDIENHD7SOp3OT_aVkR.HEkTkdohEXV4mS3csQ93nE
 kanuHnSGiU8lEkfXUvR7cIauF5uPGwnIMnNGNVrykkmp.foRCUZLOZHR_IUE6Jg4UIdMqMi40Kcr
 MFTjeBhXzmoc.VgbZwqG.PU2HU49jGBYr3TKChr.8_WT_RusNxvkKhAiwUes0ACglOJVNAIX9dOl
 Exy0hoBZX1vUDfvq56GkLSl8cABD4Gnv2DfPI5lrEdN1_Uje9ILRtiEEzLW2q9rKsQDnUdyrtn1o
 GD.rbxfjXRGTD5P8pNsf7h9LWp9CfpkLQhkW6KYKV26yHZiDA1jFGiFGTdm4x5ocLNZ1us2HAijm
 ZhijTpHfWC83CfC7lncnEFfRRliw0gg35VLF64H9vvXCfjk2BU3nAA1PwOZ.F8lWZmjlqKSbIoqy
 nzvdeETIhtqN2FjSU92IXTXQKBsQ5e4SlHtOKituiHDE9mj2kYnmqCTuXVJFIZZUPmqWdRsZh5sj
 7aGLsPum60exn9M4nrukQj2PQwkQN1hJTIsCAU1TDsmkQ8s1b3AjAK6OXco07MDPZ0HVEuUYoxYW
 6MiDEC4yAPH83W5LbU0EIwzBknz5K.Y4dCvuTAfXTN9EQq8v2B9Muq8IaDmqJWu9OtQ0VH35v475
 YHFO.YEMaODkObFPMdcIvi6wwFKbjItzLtjDQmTuYK6a5eE.hHsRZe22v_y1Mwy7lCrJFwAShTPP
 8tYYmhr_ymFVeda13VTDcKyl66xSlmGcklUJZUYPoil6DK0BsOAVq2nJqccH.cu5PuOKRAMxa2Gn
 LUbfI.67y_4W_uY0JBRQACifLMdC9DKNh0UCqzYd42jET7FQ1zST5EHGbwJ6K1G4dYgFTR8e_2ZZ
 PD3zWI69MD9NxDgPJfd0OQo2tWfqMQwfzVbpDyu_HCvPwv4DlKjEtgDqK6VLxdLxgxTGPXLnS_Sd
 QpSAsz9jaZHDiIPeEDkHMcZUZowSDmWKQ1a4cnuTONV5hFGOFmgmuN9gwAfJsnDT0Fs16FFTLSvG
 WxYlhclc8R8sz9DZQtjzLo0QdujbtKSC9jBM9fdoFxrcuWjPvsHF4NwnFxc6X_m4820tZV.BQzNb
 3ndjIFEb0Ms0RBjvJZF.iWCNes.NHIh.oJc1NcU1BJ0zCiVqGJtNsIiAxZ9GDUjS6NF151TZwXeT
 TziS.rubW1qLrQAa6DEpG1UDXm4ObcgqbF0YBDjxeSzeFlIPAABLiqbd1phxirL5pWhx0C7eSEGz
 3777ZdiFt7REkza49tnGpvQdMIL1_0cjwVgOEWVCAdWmdpzC_9qEVlEQJ5KMh1tj2.H59b_gKJqW
 MJTCMhht05qlaGi96tdSMw944YujSc6xr3rWWj16UoPNGO7dkErbHqASY65D8Zu19XK2WfrZtxn9
 GJsKM4Gf9Tw8DJpMj6tpBYB6mDh9A7qwO2ACaFw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 2a6852c9-3ea1-4fa7-9ffe-6faf840d5e4a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Sep 2024 01:18:47 +0000
Received: by hermes--production-gq1-5d95dc458-4tw7n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aa61bd69138485d742123d35d89a14b4;
          Wed, 04 Sep 2024 01:18:44 +0000 (UTC)
Message-ID: <56cfa89c-1a62-4c48-a67a-186226de1843@schaufler-ca.com>
Date: Tue, 3 Sep 2024 18:18:42 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/13] Audit: maintain an lsmblob in audit_context
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, mic@digikod.net,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240830003411.16818-5-casey@schaufler-ca.com>
 <9c8268660e3c07af7edab592e8249276@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <9c8268660e3c07af7edab592e8249276@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/3/2024 5:18 PM, Paul Moore wrote:
> On Aug 29, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Replace the secid value stored in struct audit_context with a struct
>> lsmblob. Change the code that uses this value to accommodate the
>> change. security_audit_rule_match() expects a lsmblob, so existing
>> scaffolding can be removed. A call to security_secid_to_secctx()
>> is changed to security_lsmblob_to_secctx().  The call to
>> security_ipc_getsecid() is scaffolded.
>>
>> A new function lsmblob_is_set() is introduced to identify whether
>> an lsmblob contains a non-zero value.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/security.h | 13 +++++++++++++
>>  kernel/audit.h           |  3 ++-
>>  kernel/auditsc.c         | 19 ++++++++-----------
>>  3 files changed, 23 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 457fafc32fb0..a0b23b6e8734 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -277,6 +277,19 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
>>  	return kernel_load_data_str[id];
>>  }
>>  
>> +/**
>> + * lsmblob_is_set - report if there is a value in the lsmblob
>> + * @blob: Pointer to the exported LSM data
>> + *
>> + * Returns true if there is a value set, false otherwise
>> + */
>> +static inline bool lsmblob_is_set(struct lsmblob *blob)
>> +{
>> +	const struct lsmblob empty = {};
>> +
>> +	return !!memcmp(blob, &empty, sizeof(*blob));
>> +}
>> +
>>  #ifdef CONFIG_SECURITY
> We probably want a !CONFIG_SECURITY variant of this too.

I'll check, but I expect you're right.

>
>>  int call_blocking_lsm_notifier(enum lsm_event event, void *data);
>> diff --git a/kernel/audit.h b/kernel/audit.h
>> index a60d2840559e..b1f2de4d4f1e 100644
>> --- a/kernel/audit.h
>> +++ b/kernel/audit.h
>> @@ -11,6 +11,7 @@
>>  
>>  #include <linux/fs.h>
>>  #include <linux/audit.h>
>> +#include <linux/security.h>
>>  #include <linux/skbuff.h>
>>  #include <uapi/linux/mqueue.h>
>>  #include <linux/tty.h>
>> @@ -160,7 +161,7 @@ struct audit_context {
>>  			kuid_t			uid;
>>  			kgid_t			gid;
>>  			umode_t			mode;
>> -			u32			osid;
>> +			struct lsmblob		oblob;
>>  			int			has_perm;
>>  			uid_t			perm_uid;
>>  			gid_t			perm_gid;
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index 23adb15cae43..84f6e9356b8f 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -724,9 +724,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>>  				/* Find ipc objects that match */
>>  				if (!ctx || ctx->type != AUDIT_IPC)
>>  					break;
>> -				/* scaffolding */
>> -				blob.scaffold.secid = ctx->ipc.osid;
>> -				if (security_audit_rule_match(&blob,
>> +				if (security_audit_rule_match(&ctx->ipc.oblob,
>>  							      f->type, f->op,
>>  							      f->lsm_rule))
>>  					++result;
>> @@ -1394,19 +1392,17 @@ static void show_special(struct audit_context *context, int *call_panic)
>>  			audit_log_format(ab, " a%d=%lx", i,
>>  				context->socketcall.args[i]);
>>  		break; }
>> -	case AUDIT_IPC: {
>> -		u32 osid = context->ipc.osid;
>> -
>> +	case AUDIT_IPC:
>>  		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
>>  				 from_kuid(&init_user_ns, context->ipc.uid),
>>  				 from_kgid(&init_user_ns, context->ipc.gid),
>>  				 context->ipc.mode);
>> -		if (osid) {
>> +		if (lsmblob_is_set(&context->ipc.oblob)) {
>>  			char *ctx = NULL;
>>  			u32 len;
>>  
>> -			if (security_secid_to_secctx(osid, &ctx, &len)) {
>> -				audit_log_format(ab, " osid=%u", osid);
>> +			if (security_lsmblob_to_secctx(&context->ipc.oblob,
>> +						       &ctx, &len)) {
>>  				*call_panic = 1;
>>  			} else {
>>  				audit_log_format(ab, " obj=%s", ctx);
>> @@ -1426,7 +1422,7 @@ static void show_special(struct audit_context *context, int *call_panic)
>>  				context->ipc.perm_gid,
>>  				context->ipc.perm_mode);
>>  		}
>> -		break; }
>> +		break;
>>  	case AUDIT_MQ_OPEN:
>>  		audit_log_format(ab,
>>  			"oflag=0x%x mode=%#ho mq_flags=0x%lx mq_maxmsg=%ld "
>> @@ -2642,7 +2638,8 @@ void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
>>  	context->ipc.gid = ipcp->gid;
>>  	context->ipc.mode = ipcp->mode;
>>  	context->ipc.has_perm = 0;
>> -	security_ipc_getsecid(ipcp, &context->ipc.osid);
>> +	/* scaffolding */
>> +	security_ipc_getsecid(ipcp, &context->ipc.oblob.scaffold.secid);
>>  	context->type = AUDIT_IPC;
>>  }
>>  
>> -- 
>> 2.46.0
> --
> paul-moore.com
>
