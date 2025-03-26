Received: from sonic313-14.consmr.mail.ne1.yahoo.com (sonic313-14.consmr.mail.ne1.yahoo.com [66.163.185.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAF31DED5F
	for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001079; cv=none; b=UCdOwe3chEte/HbtBi7AW7+FHejB4B9E4zkpgudHhMQnoejwCPft3vs3bOF1bEjzKiPlmn6IlagCdTI4b+S+6jQA0I7+a2Pi18B7rNdI1gKNKlwgd83GdOANZJ2mzhSEp1WdIRrglZUjMRz5Pxyhk14jOCcpiZ9vnPVDoQuiiZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001079; c=relaxed/simple;
	bh=exv5Wd+eewQMayU5CJaut22C+m8Jzxi/ThRV8Id15Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgTleqILrtXQnKuD2TVoA2N9MohLjbxvDsONoBP1a1mn+bLK21J4wVarWXLV6pPP+vQlO4jjh4bI0FB0D6bYKBWiVnrTc39mKCt39Ky/fGa/4jET7HUkj/NtwhMwEJwK03pLG0qUha3omQ+JJHgI6R7g+jai1WaPUVOdM2avVzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Kn7oAQyX; arc=none smtp.client-ip=66.163.185.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Kn7oAQyX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1743001075; bh=edSQWyJIbHxEQY7kDkt5m8uNXpnowVSyw4X2RefTDEQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Kn7oAQyX3LQkDujintSS6WMPbLbFfqx+uUl+txcyPWBAY/XSWJLgQYmNBwd1sJyy+0DbJkZex7Zi8pCRs1+wCHqEHLTf8P9yK14b+6xwdl5dqVNTSGfvCY5ItSIyrjEejR6zKVVpPT9Z4NadZK9GTEYrw6nWmJ/EK2zmV1fYaUI92i/e4e0RiW7I/ld6aToPk9olGxA0CoHar4ph6sMGYPu27xQk8tV6q6mHAK4IsiezHeFLZ4io2Ei0Tq8c2+ILFVkLte9iWAxRLyRloOr14vlcMKXYREC1lYjdNZAqCJaskYxauDSqXHxQ4LNsEEfi0EZJjhX+Mjuso8EQrJ2XRA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1743001075; bh=qUZwwiXdqNDjulSLo1nrFVA/6+WE+UQNhELVP4j1Cq8=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=DOa65X926qz3PKdl4Nl9dJGF5F2ZGZVLnywRXG01OhujRBpFnd1vozK6Z6ma2WSWuveVyzO8OomMWK4UNa46ZlD3pAi4wiLPDYaDSsKg/rbNUH6DePONaUp7Rd+noy5sSNAp9gtyXSc1AY1N/D9MJzlh+7bTqhnKiVJ46MoVNy3lJmlgINMqPOsgqXUQFcG0UbMV1ZR8CbC+Z0kmSjQ92dst9UCq2zT18oBs+26aVve2HAZNjA2T1a2vaaI0o+uSpG56SkX/Tr5LJ3VSRSQAEMnEo8IQkxfeDGg8G0cpXjbq/9nolcdMupxHcE6pItnk+WUj1Ozn9N8/h2Xp/N7Fug==
X-YMail-OSG: S52zud8VM1k0bDiH9z4vTJRHaQvs6lYhmhKL3OC3tdFo0J4IosFYzYtN4tUTQgk
 qs6PhsXoji6WtW2QhYMqH8_j0bYlO6ZZWJyqohF85bPXisH3ATrfVyc5b6qJ9Zc_j5uKMWs2qRzv
 CmutXd5KUTG6DqpLT9y9MJTsRm7wH4zMYAhhuFXPxJX0hMTgvlHhHMKv7mZHzU_L_byhGeC9n4nk
 IVIaFGYBuDTgTsL.4skKMN3d8dJWYEUgjyzEo8_6OWebQ6q7hJoDsnUJXtyjipCgGgZ_E8a3JXda
 8ojtI5zeMGHhGNSUSqnIlzPnLhmUbOB9s4BFqnWVFK9cVnXRwZOEVj8u3ENAPhOjAt6Vb6vQGGeO
 gEeEs0KU_HreOFgPr9tK_uoymsPNfKqAK6qCcBeEj_Szgz8qLvCAmEr8UMn7.q_373iqOP6TphUB
 AS30MpuI55RADwsO2fVpCsYE4M_bUrY6XKmbYb6drlqrVZgN8747IiikCjw81ZnUsAZM5X5RLFfX
 dsz48yt8m_ykJdpWA.v73XGczWrIPHfcKgqGcImPGtWr3KS.oHYO5NtPlzy6nBO46.GK4ZRzYD7f
 oN1Tri5fuOtba80PgKlCGWrH2gT6z_GCXqH5IkqwajoW7PdyvrqX_raNFlo6eVlXZdTGHYDCPA_K
 s3jhuqvRLrEj2fkISgEyOv1CKQtifJksC.yAsEw38zA6JmPCBiwWIz._SJUxlX2QJIITEueIVaF.
 rqFyb.0aIoiyMkdxIPYPkMnXZKRfxGgiulgzaBJ7dlHpLUNjtvThBZodPnHKk9pFUtwNGWjBmsad
 e31KwCoUnmrW7KZai7I709osjZwjqXbfH.u1AFzNcuIhFmHeOE5ot6UYs9njwaDsyRu4L9NDI66O
 yEZHq3UcLOhKgJI2lp93_qRevmqDi8LAGRr5aETMnQFLe7o_voNejwGfpcmjp6_8PVVXL2Rotz5D
 8V6fA7FEbatvSMLYVAAVBC9DDl9TxUNTerRcI5X185ZCSoPoB0ZRiX_nY.Yg89LkHMfoo__Pjahg
 BvW3sbruPJV0OdxKoQhqSzUJ3bVYc8gv1jfkWIE7hRoZQwogqKxY309HpyIv5QCEn.msukwDpIaG
 rXGtcgV7pyAfsEuNdGrKUBcNn5eG0qYhLOmFjiZ0XgagVhtwYb47En.e8hiBcu8H8Gaq2C9OxHr1
 .h32MfGjomz89pMJEkzOdkrFGOZgVM3Bw4Woi8XvbjikIOxJL5COh5425xgYymmd6OkzVIzAsNBJ
 AcLAaEqCsSYo639ZF73IcWfp4sPitdkX3SIigWKhr1QLiaEkhZauHoaxp6h.Gsm34wQD48GjJDBc
 XCNHPOWymty90Q9PfSunfwc3htRKH5e4MIyYmw.Wyip7c3xRR5O4n.TEzjf2DgCSRCSD1auQ_L3j
 qKg_4qpoZ4x3xEeO16Cv_qsM9PYkt8GUI7.nROfQJkQK0as0DaTbUdXqOEr78GNZBmdgWivZKcFG
 6ubxqKRZcuJWnsOyaWCDAOIOJtBKlYhLvjWs8IS162WiXpCAUvXCcsBrkKpZN9MBab6hTIIoBXb8
 MtdNF8mcWDVW_Us5rv_Ju..OAlqEPDIZM6di17ZmW0zdmr7I7eD1RA92i6On471YeSU_nAB0HXit
 pZpSpwIOsFujcvhxO1E5YX0rtiZxmMNA9aav.8z3NmLWK_hQxbG8OUS7ddfjOpXzAWeCvbtye3xu
 lZDZrRSg9fJscJxQtEXYDuQuC_1aXaq7cdXJUvrKlMV6x3ZCDYqBsWjWEhhxO0wozjGyHGO9uHes
 M9eD8U_O_gaasTjNVebcrWhvH6rwsAHY3VzZvp2w7JLcHjsA9vRJ7780247_TW3vimsOMN.Vp6zE
 zcP64orcYRQrZ8kMxPhdVIzRbqLxkgCW.3y8G84XaVynV892BgdeYJl6FqZkIMv_wJ95RZmdlpDT
 B.TH.0_K._exf_76o5dB0nnYsetAp.BaYMhKaQVc2pNRRUFXLgZ_uoKTG3nDI.I4c.peAe8B9aHI
 TOndCOVfvJT66kybH0e0zqYF.7zVLWEpu6T3JMa.EH_ML798DzKSXmQnZ7ESpd7gOPuLAWlUMY3A
 tGpdx6AHR896CeFnC3n.HUPw2BzEFHcDFwgsLUtLDprpF5fiKBRvd29TlADyH7A5kHlmYbzTjWAV
 26DkEuKpILVy36k.sVQ3K5dp1XLFcC.Zd.tYhRN0P7oGbn_FHXBXPl5Cytyki9HsV2v0SdkxJex_
 3cWq2TSw.ADFQp8vK8pt6iD0EqpzPu61pfEg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 29969114-1e5d-42ed-aa9c-e2f60df9c6f7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Mar 2025 14:57:55 +0000
Received: by hermes--production-gq1-5c477bf655-cprz5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 369724ad237849deda3651c5f1ab10e1;
          Wed, 26 Mar 2025 14:57:50 +0000 (UTC)
Message-ID: <aeceeebb-c207-43fb-999f-f7ffdeffd513@schaufler-ca.com>
Date: Wed, 26 Mar 2025 07:57:48 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] LSM: security_lsmblob_to_secctx module selection
To: Fan Wu <wufan@kernel.org>
Cc: paul@paul-moore.com, eparis@redhat.com,
 linux-security-module@vger.kernel.org, audit@vger.kernel.org,
 jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250319222744.17576-1-casey@schaufler-ca.com>
 <20250319222744.17576-3-casey@schaufler-ca.com>
 <CAKtyLkGGbB8yeWo3V4y2cMfcB=GyxLHtcH4HkGJQ7KZ_jz=XeA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAKtyLkGGbB8yeWo3V4y2cMfcB=GyxLHtcH4HkGJQ7KZ_jz=XeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23533 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/25/2025 4:44 PM, Fan Wu wrote:
> On Wed, Mar 19, 2025 at 7:50 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Add a parameter lsmid to security_lsmblob_to_secctx() to identify which
>> of the security modules that may be active should provide the security
>> context. If the value of lsmid is LSM_ID_UNDEF the first LSM providing
>> a hook is used. security_secid_to_secctx() is unchanged, and will
>> always report the first LSM providing a hook.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ..
>> diff --git a/security/security.c b/security/security.c
>> index 143561ebc3e8..55f9c7ad3f89 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -4312,6 +4312,7 @@ EXPORT_SYMBOL(security_ismaclabel);
>>   * security_secid_to_secctx() - Convert a secid to a secctx
>>   * @secid: secid
>>   * @cp: the LSM context
>> + * @lsmid: which security module to report
>>   *
>>   * Convert secid to security context.  If @cp is NULL the length of the
>>   * result will be returned, but no data will be returned.  This
>> @@ -4338,9 +4339,17 @@ EXPORT_SYMBOL(security_secid_to_secctx);
>>   *
>>   * Return: Return length of data on success, error on failure.
>>   */
>> -int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp)
>> +int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
>> +                              int lsmid)
>>  {
>> -       return call_int_hook(lsmprop_to_secctx, prop, cp);
>> +       struct lsm_static_call *scall;
>> +
>> +       lsm_for_each_hook(scall, lsmprop_to_secctx) {
>> +               if (lsmid != 0 && lsmid != scall->hl->lsmid->id)
> It took me some time to figure out why if LSM_ID_UNDEF is passed the
> first LSM providing a hook is used, might be better to change it to:
>
>                if (lsmid != LSM_ID_UNDEF && lsmid != scall->hl->lsmid->id)

Thank you. That change will be in v4.

>
> Otherwise, it works as described. I'm working on adding a new IPE
> property based on SELinux file labels, and this just came up as I
> needed it. Thank you.
>
> Tested-by: Fan Wu <wufan@kernel.org>
>
>> +                       continue;
>> +               return scall->hl->hook.lsmprop_to_secctx(prop, cp);
>> +       }
>> +       return LSM_RET_DEFAULT(lsmprop_to_secctx);
>>  }
>>  EXPORT_SYMBOL(security_lsmprop_to_secctx);
>>
>> --
>> 2.47.0
>>
>>
