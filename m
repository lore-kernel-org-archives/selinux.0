Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792FDDCD
	for <selinux@vger.kernel.org>; Wed,  4 Sep 2024 01:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725412529; cv=none; b=H2na1KOsfd4NEFABo1T54tzEjjocCsiV2s5+f4Q9qPTfDfTNBe6fjuLsP34pWnl0bie9V5tWqfgkt7xN/KyN7Q7NAaSoj+vuXX6XKholxs7CiLqpbEusD4eE4JaS49bFUDXE+bJo/xt9OAgownD1F47uMeD1v+PADzkdWoI7xf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725412529; c=relaxed/simple;
	bh=uHVALou1oAwqM8fxiZO2GwA3ylRDLnXc4bDtqGxtylg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeXRkxYO2gVPuAwO2HfWfVErwcfLhAojEgQU/k6ziS5yNJii2N4BZFeZPk2X2C46LkqEPSJ4vRXgBbTZ91pCI2Bc27vJZvixKa709Eekf7kjIk+XiakMiPwQjQvDKxvmdvcBoI1j4P54AEOw1TE5PxPlRhlosTU0ci0PIHF43CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qTUiFVvF; arc=none smtp.client-ip=66.163.186.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qTUiFVvF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725412525; bh=snpXjr+C7r0iS2NCLZtza3wNeKj/q8B2OQyAr4G9X9w=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qTUiFVvFk3lkYJM9pjyYM0lIsDJQaxjrcx8sid+pU9ZLZUZRIQhTwi2kUdB25XzJevkY4f8OekvlL6cm/Y5k6KgqtIiYtQGFH+6v44JJG5JS8ABV/mfUu+E683Jwfi0K/pl77f+T0ktSUCCun3WtcdVFUB6fXrRJsXlD9h8/l+tSW3LEqPIJBdVlZFsoX/X52Wktr1PiSBOff4yj/o1mwnUakfx5xfqcKXcLiK+8gn2pRZptNpWaFjF2EFXP4iBS/pU9LrxwK5nhcO6GjMgx2y/Qss6bVoAgcjF8rCXpDuTb/bCRdrvSmCtmgcEnQH/7KtAanhm39mKOD6q6xVQEvA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725412525; bh=Dvhr4w48EtKRKLmV0BVSpiCN/AUUc6+ft0yeSVXGbRf=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=DoA0D1Kjr3D/ohDPACQnlTDLphNb7toKa72VpQC9A7D5IbJFfDjeG2mNOitlsn3xPc4X+1r+X+XsrECFqQ3yXAmfcTmPwGAE8cT3hcHXwruc0TV/r9Lym6aj0U/OOZS0TPGttQ3nhxA5lP3XLQBBwPu6thsKbv4xNmLb3csMO8ghwUv9eAY5CxyviVAeg1yHKpY8Vtj1s8BuYwp2FfDU67XzBKloIr7mGyxOcvOg3/8CjMRbg8Ed9K7ulJx48l68gS6bwA7dJOfEsyhgj2y3btLry2PVDwsI4hJqB/tx0hpvcBbUVtSxEBLWMTas1Iz6qz57SS5yp0hcyVtODWCEkQ==
X-YMail-OSG: rCaMIT4VM1lxR6NJqJysi16lYbBYXL_tujfWvu95kBdsdKqoAq4Y1MLBdur146W
 TjuFOkQxiHiCdGuUIV7avgAFhwJw9lb8JZrFVB7Zh6NuAevXxVDQNlbhI4Pk5tdr13f_wEkuIWSs
 PaOOGAEqAKklk3X5N_RtsjZzicjsnYyykcXD_c3gBxdN6zzocH.ssEE2SCRiEdX0frV8p2tREefW
 NLqkhjUoOUbFDwStjUN1nkJtpAWTVAou7gIS4nHa0Sejm50kzZz8HW2EE5OntWqkPahJtZlaOTUF
 qFJemrAvI6fnzVUZhFlO.OCeE98_KZzkOqiEiKdGO8CmKbjsjUb_O3YSCIO.v4TJ_H_B0W8rYGIL
 NBasc9AgtjLnGdTRzc0Xn3NwNYIToqW3AhGYYooJ3Pqm2vmanhWjRNsziylmAypa425uB2gIrqrl
 Wh8k87Aze.tlw3bPiswv1WjQTi6ekC6fW6gi_X_yYnPaQWX1Owy7gN44AM.Cbw2uME8.OUjAd_wi
 yq70Oj3an6jDbsZ12Ygaa1Fldf8hp0JbfO6W2FRDEFL5NSlvd5NjXi8HgPIN4fZgxiE48toYOT_4
 2i6QF6K73cEGMYqEW4Gq9.jzQ_kvD7iARrrUDuTbbOfMSkrG2Dl83J23h0kOfraQIV4OtKJhvn5p
 dKaL74HlOmkUOIAWpSs34b6c.0SnsaJPRwCxgNNXGcc1HwmD.1WpKNPI2WDSW6PFfTw37HhirTcd
 vioYqYo.DgNdWQmSSu3I_Mir1NUoXUn.1JHVPZ9i28aJ.G9lQxZC4OYeKTlaXDYWl_cWNu6wDP8l
 em9D4lWOTExFvCqXdaJ8krnSWXOzKpuUTETk_3hdgwS49bUXOgKLYSNgbGTFODvXpM2H_JIOXCQM
 eGexxqFUYJMKxue14DP6HHsrvQsS_x_tyjXkMguvl2lwWNVWofjOl1WDEqZ_hmqLtAakxGl8Rtu.
 _a2md3zUPGQaDIDAFnqgxaNfo4hdlGc8srLaREzD1svT7Mo09cZoWJIvcLSVVK1CWqrfzb3Pdznj
 rDPPVN1dKB1YsZipvSe5lKj94gO.6akcOpE2Fxa1vWwOLd_65GLAGC5pBeb1ZyLqxMxHgHzc.EIc
 ZZxIvgUQD5EQJqf9GfsvxTp.kKx3AeIN.CG1fqKNvSvPR0_v.gVxtk7EshqPPKRWjDrDqvt20wYa
 _f0noFoYp1vFyZ9ypmhyu3C3_L7d6pyJiEDmcZy_NA.E52PBSdODEueTDUCdLX2ZGPfZjnpwyATP
 cjT9IEyEAEtOIp9QQP7lob9MUv0eekNJCAjlreZBWj9YV41Vq8XsNj_NI2KCuO6775FvowRfdapq
 sLsZhSYl..DOOxteZPAAhRWncESj0DwFvYrrVZuKg2Yme0O6gSMBS7f7zF3XhKHogMC5AKTRe.QO
 9524LsufFa.hb3f63emLgN3aCVAQthq71vDKcvao.44dTKWCjuW61iI1nNdeG5klANcjOBvqbxGp
 WDL_.oj.WR_Deyce1cyXCMNTPy97.zAT_gY_B9CzElCOCIi5wr5kDZlZCVHImOJwb9B117Mg6Fck
 S8yOeNzMQDt1OrKc8C4h2a1P9fk_MZAMW3HWWMTubXBubbsHdgnuYnLlaYr5IsQgF6oA.u2uboHz
 Dd4hQoqM29g_WkvIBedAaf3TIQshkMQLdZmxUeZ3g2JceiZp6aRF6uZ1KG6S_k8J0P01Cxn_WyBv
 juhxzrGHBcRxLMul2u60R1FFx_YwYBFMr.5NmZ6fooyRqaPso_pjfFaLPaLU3tvyJv.0cXIyenaA
 O8kJyi7XI2vWbDI.ykoNklrEaFnDtxaW4wG0yMingGJMaIvWGb5N2Z0qGAhvoPDXeZYtBBrhFnvE
 lWpL7BDe1pgf.6jlJO.MM_VIQbQuxGkd4AUJGzbcVLopY.f0R6s2gF5FKWpdwuMGOEXXWNjN8BG9
 v0tHlCddJOHXw6xtK2t_6HSWvo8stoPOHmK54BC3irTGLfKLEZ1Z56JjBowOZhJ4YOauagXwP7wY
 gQR3hWX5vjURfg0aoA_Fmo6r_O0vbKJmOqlxStH8JxvC0lEW.cW.AGY6GrOaPo3GpDe87L7w1BqX
 DPiS4u3sx1ZHQsFQySFMuMzQHQ3FFPPESUnfavJaiTDvgFDXk3reXwjdz8XXVgokLlCDO7HFcndf
 dEtApcsnEhAJspJsOP3NNeAqgAz2bqYMNTrd6i.bdsghzOPO.BmwWa8v9TDB4EXwfXMMdB5wnd54
 LBxSt_UPal8cOI1xqRxRIJNRP7N__kmxV0sxUOHJi8CgvfskLFZigXrED9n56ViCaIZfYHvPkRwg
 xveg_ql4zlQwdbZ4LdeFFDs0yvZQSfpseyT4hYg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a7ee2418-0d41-4974-9d9d-99101b3bb70d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Sep 2024 01:15:25 +0000
Received: by hermes--production-gq1-5d95dc458-24x88 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12b4acc5d73ffa7a6d15274920c8ee9a;
          Wed, 04 Sep 2024 01:15:24 +0000 (UTC)
Message-ID: <61b60364-72e7-40f2-90dd-255d5714b9e7@schaufler-ca.com>
Date: Tue, 3 Sep 2024 18:15:22 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/13] LSM: Add lsmblob_to_secctx hook
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, mic@digikod.net,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240830003411.16818-4-casey@schaufler-ca.com>
 <faf28485e8d2846e78f89c39d2f737ac@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <faf28485e8d2846e78f89c39d2f737ac@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/3/2024 5:18 PM, Paul Moore wrote:
> On Aug 29, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Add a new hook security_lsmblob_to_secctx() and its LSM specific
>> implementations. The LSM specific code will use the lsmblob element
>> allocated for that module. This allows for the possibility that more
>> than one module may be called upon to translate a secid to a string,
>> as can occur in the audit code.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hook_defs.h     |  2 ++
>>  include/linux/security.h          | 11 ++++++++++-
>>  security/apparmor/include/secid.h |  2 ++
>>  security/apparmor/lsm.c           |  1 +
>>  security/apparmor/secid.c         | 25 +++++++++++++++++++++++--
>>  security/security.c               | 30 ++++++++++++++++++++++++++++++
>>  security/selinux/hooks.c          | 16 ++++++++++++++--
>>  security/smack/smack_lsm.c        | 31 ++++++++++++++++++++++++++-----
>>  8 files changed, 108 insertions(+), 10 deletions(-)
> ..
>
>> diff --git a/security/security.c b/security/security.c
>> index 64a6d6bbd1f4..bb541a3be410 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -4192,6 +4192,36 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>>  }
>>  EXPORT_SYMBOL(security_secid_to_secctx);
>>  
>> +/**
>> + * security_lsmblob_to_secctx() - Convert a lsmblob to a secctx
>> + * @blob: lsm specific information
>> + * @secdata: secctx
>> + * @seclen: secctx length
>> + *
>> + * Convert a @blob entry to security context.  If @secdata is NULL the
>> + * length of the result will be returned in @seclen, but no @secdata
>> + * will be returned.  This does mean that the length could change between
>> + * calls to check the length and the next call which actually allocates
>> + * and returns the @secdata.
>> + *
>> + * Return: Return 0 on success, error on failure.
>> + */
>> +int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
>> +			       u32 *seclen)
>> +{
>> +	struct security_hook_list *hp;
>> +	int rc;
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
>> +		rc = hp->hook.lsmblob_to_secctx(blob, secdata, seclen);
>> +		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
> Wrong default value/hook, but see below ...
>
>> +			return rc;
>> +	}
>> +
>> +	return LSM_RET_DEFAULT(secid_to_secctx);
> Same problem, I'm guessing a cut-n-paste-o.
>
>> +}
>> +EXPORT_SYMBOL(security_lsmblob_to_secctx);
> We should be using the call_int_hook() macro instead of open coding using
> hlist_for_each_entry() and I believe the code above could be converted
> without any difficulty.
>
> It should also solve the compile problem seen when using lsm/dev or
> lsm/next as the base.

Yup, sorry for being sloppy. Will get fixed in v3.

>
>>  /**
>>   * security_secctx_to_secid() - Convert a secctx to a secid
>>   * @secdata: secctx
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 55c78c318ccd..102489e6d579 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -6610,8 +6610,19 @@ static int selinux_ismaclabel(const char *name)
>>  
>>  static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>>  {
>> -	return security_sid_to_context(secid,
>> -				       secdata, seclen);
>> +	return security_sid_to_context(secid, secdata, seclen);
>> +}
>> +
>> +static int selinux_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
>> +				     u32 *seclen)
>> +{
>> +	u32 secid = blob->selinux.secid;
>> +
>> +	/* scaffolding */
>> +	if (!secid)
>> +		secid = blob->scaffold.secid;
>> +
>> +	return security_sid_to_context(secid, secdata, seclen);
> We should probably just call selinux_secid_to_secctx() here so we limit
> the code dup/sync issues.

In SELinux code I'll defer to your style choices.

>>  }
> --
> paul-moore.com
>
