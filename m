Received: from sonic306-26.consmr.mail.ne1.yahoo.com (sonic306-26.consmr.mail.ne1.yahoo.com [66.163.189.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB72198E6E
	for <selinux@vger.kernel.org>; Fri, 11 Oct 2024 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661961; cv=none; b=Sc4CqwLuQPr1krmJWydZxAHlKd6fSm5UiOvf11IJQqQ1LXw4oWFH/7Ja6DGBZOLenxqi/MsaIa0P3aFfCtRoFd+AUoaZV4yGqGx1pEBzpvKO5f0TlCAvwx1I3KTOHWOgmr+8S3Acmir4GefbgQlmC1zglfwastiMpKczmNW1UvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661961; c=relaxed/simple;
	bh=RA74rVuHs3yAU4tC4HgxR/dneVnDMKT2HWAGtKDsckY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shMl8Cs1K5egkYJJFzXOYrIJYWJRIXWMVKHzKLCAG2rSJ0mExLVf971pdP0ruyVF8BW7qfNrojbv65i1wyOm8q2OFHeku2W6v6G2FAvAiO0335XXlo1un25nuS7uJdYhse0PQZSuRPdzZdRHGM2zOXz3qBtgE2ODFqeoR+HMVIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=YX6kmSJP; arc=none smtp.client-ip=66.163.189.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YX6kmSJP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728661952; bh=e0YFQvia8zJ6RpAa5LDyrXWrGmAco2qgjw0aK2nGuv0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=YX6kmSJPeQ4j5ieGSpxeNXhTTqyl4fHg1TdbEYELUlWMQ/mr2fiVw6ikFEZbOdkH0+SNMobr9jcC8OMbPZoBEY74tGzyf2HY8MJqdqBb6XXyW6VeT+U3ehHhXe2n2tya/L6LUBELpS+LxhVGLeyPgO+mdBfco3fWe8d+PHUdDWbLnPiUSVkgEelAHM9ZDW6GCLlwnfbqy+26yb+gBdTjxfkxDSxcckEa9igBvUnwdBkbi5D3YQvps1uMnTnm/X8nYmukFk7+k4/F3Z7sWsAEUL0lY36T+BfkIjuDRg4MylK4WsnLGGN8fdBXVt4ydtbJbCsESPDPTPUByWwlnXMGoA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728661952; bh=CQuW+d5beSYbgF/ibUz4J8Aky1EO87zn0qIQXWIC1GE=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=LaCQtSViVwnA2+ThRqi/ZnSujlTCWcEWvz0L1Wl7p+vPRFre3+zZrcYfzFsM1QgIaYMlF/SkgQDy2jAnGV+ggUMPyaMzXPLXsxbhd2Zlz2bEcM+lpaGk5TBcAbIqwBdQKgOGnzlesEyWu6Y5+sIzf4hh6hzP18bcmi8Tw62lTv7kta6RRJo/8e5r+W9MdY7AauNmzfSgS7oDzbNsCutCNo9wl6iDin9dJ9VPK4n3Ixh264CNb+I2lFFdUSA2rv+kbbDmMJDO7YqQq1SCpuX/9bsNryP/8ZHt7Vs4unMS09bhvwp+nSAw9PaykToz12VQCpceB7WVzx4B+bLBbyolew==
X-YMail-OSG: YgPM3rkVM1m0FAacpf0YZ5dXqDTfKfEeFdP3JCzjtIftTJ8d609x6lKBEeGX2HH
 88ESKkUCMbqh8Q5Sm0QhtQefBwOrRhiS4QPJVh9fL1wUMVldLhzNygvwWVDDBeKiJf.StUoPEMfq
 DxYYYPC98dKA8O8FK4aLYAy8hnU2VJPK3DYCYNal5_ApMjlRV1tB163G8DL8.h7KJGgHQDYIM1kL
 3YLGMCfeq.t.npBmvIBjtuJdAxa3j7LtXpK9WfXcLjgtMeqmhfvarrpPOJwyYMyUJ8ch4CeY0eNP
 VF8dUCVfmZckeQtuRwzOBLstV08lJdA5eiFT9HOhK8guLPIWLm9XlA_ebvyyInqROUMqUEFaqqx7
 SBgQlaEt.2IJyvAZqm5dZqvclJTtZ5Zjw2I2Aq0iRun1hNmPyIk01KXr.6WPc3a_82DjBjXJzzIr
 _A3YJX3esOVELE2HCOS7Fu48RHfc1C7uuhcjn4u_Fwhdu3rzVO1pQMTvo9JvM8yo6Gli4I4Y1ROa
 oD45cyjDImgNr0SHWtitSHWnQzSopg_Gq.frDpoIxqwq1t7994MEqZVeto7H07e7JTKIzwwfuxtv
 h1HXhdAzqs7xQK_6j.XEIaI2DChuge8zLLAMnXTkiZS5NCpEUhYW.UBSFi.YhjL8r02bTIG_Qn0y
 NVKwagnwcGUAdzoPzfgqapQ_1D0yEJ5Li6o8yNAp8961bSm0h1H74pChsqbhVkHB_PaSH2LPj9wK
 O2s_GV_merC5BORl_ihiqfyG9EIroKn3Ga2URRc3fY.RcbhUDXXlTtK.nwsGUv0FyUthew2BDtUs
 TIcA6KXfJz.gIZ9pC2FTKNw8nyBxdeYYbuCBvDZ3gvnLyAeswbt_zh3qSDHB0d6Z36.PsLco.K1x
 XOcXSzyWHA_HoUEoQtMWWq4E5C.ARsXneVW4e_VTGN2e5dKZEx.asl0OQ4_J99VKHsfPVHf6sP4R
 z3hMOsrEnhplEdsXemT07qW23OP5JuhbNtf6UCt7lxNxQSIwhfdpp7RsfzLsk_vr_0vqFnXXk6WM
 NlUClpnR3VWYx5FpEBLv2LU9hJAa0bqRH0Pvlma7PoCIVIjtKjGhscobdvRqcKUj.ZbicrLIoC7i
 n9v7PX9TSa72FscDa0a0xNQ76GE.wNESHaE2S3qMzzu7.YPeYdQ4.rx31W4.E7kp1fzzh88Ahsg6
 nLElePeMN3pxEnTSEkb9GRDv2uZZ9BswVTHZPy8i23.e2OMc.x3YVVhHYLe188K9ivcBIws7Dkj.
 K8eDoE6jOnHPuLExnGhGwpgd4XdYfH08D_KG3Dnco9Sf5eXhtf8BM.OGZYuc.U7HVi7NQn3VQfKf
 LJ3k076RKq8J9sHEqTJfw7e5r703zuQMWOsZK76FUL2kKD9s1Vg5fqI0.IUCc31I8ATLVJ11qBUt
 z7IpjiBQdDF4OKCjXAaybRVtLDArb8_Qgn4pqdOs200UaXVWLpmnBwJUnaNeg1h0f5f6QNgT3zl9
 Sxk3WyH211rj7t7Zmtj43gKQwdSWV2pZSgRAs0bX6IjcHwW3Z4uzmJqNtGNDUG8zhPcrpWrjb767
 yThWtc.cjw1A_mnyRrHSXKXLP.f1UpBHi_lYh60g3FQNLAZH9QYBh_xlWStbEDifm.pZFHJt5C.k
 jTd6dbnKhx3i1YhgPvfyjfSUfbD5HF.XH_ikh3IJDctJWKF1ldqivNKJvUy7WTpH3_k8zhXi3ALx
 jfAjIiBiZpQi9w9lF.cAyCzOKyasvDltIlm5Oq99aBpxEkK9Q1e8SLVOCMhjToCzquH9nwZWbYPN
 XbKoWfreBkPvUvIa.ZK_QsUQ2FDZ7aWeowLLeDf89LbrZ01zniy0MGqy8Uhj4tGmfeItom2WLzMS
 Se7DvDxv4FHsu2NQbT4QqUY06axDXxEahM1kXgJFvKfO6TM29RldhVcMJgx9FiWkgI9X_vWzkEPH
 QuUwfau.EOrbamA8QapiSiYjKoRlmf50yzy8jb57ksl2v3tnxa25R.zPpjL.amvtjVOo8qt.259R
 0qMRNrvF4YhtL2.k4ygiY7VH0onDdG.hjtiBOtm7YzakEP9SAw_k3WQJSCpJ8zKa._oGiPovCUAu
 hRsfss9fKNg9r05QRGEpmNN2VU2tEH1MfJ0_EVSVXM3X06pK9g19uHLT1yObeNaJgKgQlx5KVJLg
 Pjb6Dyw1c13dW9btRYZ_U0Xql0FIWEPXsz6fCbxokxriSgwDi3gqVLdArMT9dMEYKArYW6VKoj0Y
 GwKRy5RSKLtoTadlL1OHNBIu9mBVC5IIoKr2pc5DmialxPlenoxkM3mMMVfAj0seX5h57rriNjM9
 74oiiiDM_bNxlgwAPtaGY6YvLuv6pq2n0FMJQ3g--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d656ef46-e3fc-4aa1-8449-ffb9c785f0f4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Oct 2024 15:52:32 +0000
Received: by hermes--production-gq1-5d95dc458-6q8w6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9bf1e624fc56d8b92f682bf01497cc11;
          Fri, 11 Oct 2024 15:52:26 +0000 (UTC)
Message-ID: <a4094e38-44c9-4ab2-9b37-c1eafee16d5e@schaufler-ca.com>
Date: Fri, 11 Oct 2024 08:52:25 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/13] Audit: maintain an lsm_prop in audit_context
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, mic@digikod.net,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241009173222.12219-5-casey@schaufler-ca.com>
 <4e2669fc0be9b0f1ca15b17ca415a87d@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <4e2669fc0be9b0f1ca15b17ca415a87d@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/10/2024 8:08 PM, Paul Moore wrote:
> On Oct  9, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Replace the secid value stored in struct audit_context with a struct
>> lsm_prop. Change the code that uses this value to accommodate the
>> change. security_audit_rule_match() expects a lsm_prop, so existing
>> scaffolding can be removed. A call to security_secid_to_secctx()
>> is changed to security_lsmprop_to_secctx().  The call to
>> security_ipc_getsecid() is scaffolded.
>>
>> A new function lsmprop_is_set() is introduced to identify whether
>> an lsm_prop contains a non-zero value.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/security.h | 24 ++++++++++++++++++++++++
>>  kernel/audit.h           |  3 ++-
>>  kernel/auditsc.c         | 19 ++++++++-----------
>>  3 files changed, 34 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index f1c68e38b15d..5652baa4ca3c 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -291,6 +291,19 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
>>  
>>  #ifdef CONFIG_SECURITY
>>  
>> +/**
>> + * lsmprop_is_set - report if there is a value in the lsm_prop
>> + * @prop: Pointer to the exported LSM data
>> + *
>> + * Returns true if there is a value set, false otherwise
>> + */
>> +static inline bool lsm_prop_is_set(struct lsm_prop *prop)
>> +{
>> +	const struct lsm_prop empty = {};
>> +
>> +	return !!memcmp(prop, &empty, sizeof(*prop));
>> +}
>> +
>>  int call_blocking_lsm_notifier(enum lsm_event event, void *data);
>>  int register_blocking_lsm_notifier(struct notifier_block *nb);
>>  int unregister_blocking_lsm_notifier(struct notifier_block *nb);
>> @@ -552,6 +565,17 @@ int security_bdev_setintegrity(struct block_device *bdev,
>>  			       size_t size);
>>  #else /* CONFIG_SECURITY */
>>  
>> +/**
>> + * lsmprop_is_set - report if there is a value in the lsm_prop
>> + * @prop: Pointer to the exported LSM data
>> + *
>> + * Returns true if there is a value set, false otherwise
>> + */
>> +static inline bool lsm_prop_is_set(struct lsm_prop *prop)
>> +{
>> +	return false;
>> +}
> If we're going to call this lsmprop_is_set() (see 5/13), we really should
> name it that way to start in this patch.

Agreed. That's an unfortunate artifact of the lsmblob to lsm_prop name change.

> Considering everything else in this patchset looks okay, if you want me
> to fix this up during the merge let me know.

I can do a v5 if that makes life easier, but if you're OK with fixing it
during the merge I'm completely fine with that. Thank you.

> --
> paul-moore.com
