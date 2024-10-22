Received: from sonic306-9.consmr.mail.bf2.yahoo.com (sonic306-9.consmr.mail.bf2.yahoo.com [74.6.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C51A81E
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 00:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556173; cv=none; b=A2jgkTMgcy8Xsh1/fUikyWC8fwlDqpE2tzlmkXMmAmd92s+QhumYkUAk1KOEan4wkarF9s2qlowl5J6tnP8C99g/KaiP3xPo0WkJOIM3lYGR+3QoheztODBDbu9WdJGjYp7bb00xXPhjMs5XhWFW3VQ34JNnFFdQqIuuiWypK18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556173; c=relaxed/simple;
	bh=PBvO+JmDcUXPLakhUBN7WxelfxPE9dinaqB6xdOpU60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVlgTioYIuwtidrmpf7cPYYUa5tZX3KDmhQGFQYn712DPBXqQrvxFIETs3Ct6YVvgLkqmtyCOdzk1X0Z5vcvVBHfo8OiBDfmv4boFUr3KlblfM99pSAY4vbNUPAmTjBPqtq9pN9ty5aLT6HgZ2tIuZevHI8Jru/9RyVKTKcEeV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=V6OjES8Z; arc=none smtp.client-ip=74.6.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="V6OjES8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729556171; bh=uKAdnfZ8DHGLvEgYRuEDP9dXyb6uc8wXDnOoyjaz+OM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=V6OjES8ZBNE/9ylrW8rUgOPDYllf464yiWTr0AQ73F/KOf0DmLAWIDFjYPlM06eQ5cyMrI7x9oG8sbPVVy00RWW6AXHq71M/pIppfB6zdNAmp7ARx3eHfcv2MqH3ooECFX0KyNA6KfZJJPCI2OFJb1tUQizOQUgLiR2zVQJKnEcW2c/9JKI6JIkSSJw3y7a8p9KcB6ZLYTbd8Qj3pRCjE8b5CHScfQvI5rjnpf2OWrNBEpjQ4w5gx+1B9LMjZcLnBpFCGTst3vBSOKbVKRnKbzk5oTpnipAAG8ztSkYBMzfZDByp0YBAjYEcUsKbMOyVF1LKFhIJUjBP4ARESIMiVw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729556171; bh=RWrMdywalzfmC9rZoxxd/iK0HtYcbJK4L5lxeQsYNfi=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=bUMV7b2yLQpupKkufgnxhbAjzOry2aZgA02f58YXWTopzl8akI3o2G7H6xNDQFUJkLHauhJokZ1bOLwcQlN9jfXx9ovhKB7vtrfEm/7O4yzAYErj+MbfHD9EtdxCetJVtdi5jLpETPUISj98cBf/HYUCVCu8s4UhJNiXKlo1Q143b/bpKSI50QHdBbworrhl1V9jEDOydHGYxCx6i3MrtNIS6JYdjq8zFWA5ikId0+ZQp8CP+c98X+yAH6zMqrsUNdDcDR63thzNVhKXoCjn82dQNOgC4XWci/T31tpOtBiRyUKoVZd8Ma/1vg1U5CQVpn3sbB4+XULs+M+oVfF89Q==
X-YMail-OSG: 7JVnBMcVM1nUp6p6J5_sNh2r48TJEL5JprpnqW2z3f_7NhyC9s_DCLkp8QVEMG8
 byZGgFdSkJ1Ac.A4d6ICWVHLkhfAoZjXtfJzM0FGYg6Y17mOZqtQay_A6yAo_SDOiJ.DBakRTNKG
 bqqSPr_Fll8.HRjXEU7xLYGc8AWY1Y2LPrU7zE4.rXXugM4DjwaIONE4_92drKdU5gSktDXJxiPx
 tyORtYIXL0smebo70JS7OukXzPAtciJeXPw8GKcJKGDubW1bLu6K06qxmQnwmWXYftBa3f3E_4T8
 1nuEK1pKeLNvfomrDWM4di_a8I1HaIfDx7Z.3U9YySi2dSgTLDO7VJ4eKeZdMGj4kBdNmFHxVzQN
 z7db03NhYqoysJOE7kYOz_IdMLuz.R1wX5cjj54cZX.8P7G_FYMr7EcsW8pghrhxL54XE4b7hVn9
 8r7h3NaS8PyB3qJmUy.duBj13KHSjHnD3niS5HSrmtFL6UFFL5CMvgneWiQhSnUptJZCsK.NALm3
 jQIwPOg7jVh0J4G13em6XXKF3bzJzza8MHCQzzix7zwNNpgSFv_IyNC5aKJDUqDk9Jm4Sb.3KofN
 pU.UOGsTO6xJJeyEEFQ38Sy2E9Uv9ZoFEuKBRUbeQ0JjCbO_gMkmqJC44.zDjX_fQpfEMu0N0Tux
 zNLwtVQjxGnDfoRg0AIoggE2602EXAB86YkI9eFdKe_txrPUClBsz6O0QbO5GkcGy2CFR70ySkm7
 TNqVHros4pFNCD3zwKthD1Y62JRQBp9_kiOGP792KEu34_JJ6.7G1.FvLFdesCikuzvOyy2ZZ5X6
 jJEoAaIFtddua7pmzKREUJiLpoh1XPlx9v33obbdt3Ot_I4Kq4DzS_HsBOIc6mQP.XYvR8CSIpJ.
 2VaJG4Go8pi_dJ9kHB2FhrpVPMLjY3Qa89p7v2hkXeTbnTrywKr5N1wkEtZlukQJHdFv..mEG7ji
 aYjdc0E._D4FUsTq5d9xamyx_lemy2e4W6MeK3zsjipEZRjPO3Ee7zsy9LXUry8FdT.MD.87NGKP
 ahgfoAsKDwJxDPv3H1GOdPnYUd8c9i9DwKcvRZyQnx8GDMKJfMKtcC41ZZrFIdORHgbGXAQ2K696
 TqwCqRZlvIjvDl4m_g.M0bHFMNGUqNMBeAFWutwmgMDSBnHf8paJCnYmHVP2PpDVkbPlyFlQyrSn
 pt4P_Ot6mol9QjdwwjnOYQKB.ARqx9o2_sGP0LeNQXfeoz1HNF4nKaGPtxFiRaR0iIsWO_.T2m5n
 JVgy3J2uwdjwxF6qFQSjacYwoY9n64QfzH6ka92ntWqmdhaMkDlQtSSr.RAc0bMo7TBL2ipXzV1X
 cO92SYzozaXQSQ0c0iKiUFZLG1tHpP.0bcXfpvTsBkGhGquydQpDkZFyuSZl04vbjCvJx6pvrj9Y
 wBGkD18IG9fhxj1bEaMxIoki0SGwaIjTnQimrXAvQ9PPi_96tSUmKpbjsfVH7PCux.M0HND4IwsK
 sJqxmEfnuWU0dkCihFRfUOyXgyrMh1b2_8D69Vd3Q3GVrc7VdZ.5fOZinoOl3J_puaM6dw1mfCxk
 ZRlTAjQUeoxIWF71ekPN3vOiXgURef1x3BGMKlqyyjpKLcHwl7r97t5ynab1H.7T89JCpKiw2mRn
 4zfk18ksEv3lShx1G_pXVoR9m.So8_JfVc7l5BieIUjJVGAQU7IFPfLt_FSJrPvVTJuUsqeXc9Uw
 JjMv6LrVXsxglIQ1vAVOR4mRrA56nvGTOmAuM8W6I6fnISTs_8GVzBUlDLMxWVmLnlvStbToylIo
 RLaQzSZiDF9xXIW2J_uFpx8F3VK.307.fWFpwPpoCEoJqgT4W18nctCz20ZtRLjbyc10yCGkJ.7u
 aozQRNggyhCDx3e8BUets.0Pfkz98itJxzib_U.rHxRKp1Nt0oyebvXFWgpX7ucBsn74A9v6_rg4
 L2Cu4BUgzZ_C9QBqXbXX74ErRwIT3TsNoDi5OFJ3CxOvQhCGJCVvwqgNSZu2URb_UxFUg.A2DjXC
 pA_9SwAxq58PWlnop2o0Eo8aXie74y5wqDIeLaIM5eQRqJ6axMOhiXX5BuLYArHXh4I4b78PRkl7
 Mr12G5B8MEXO.WycncYxxthzIQ8Mo641z2VLaxNYv90wuOoRWe2iWuntQpSyVWT5KJv2QlZGFu5F
 UPKsG31wcFw9BhYsmUldvL8dtKA2._8XbxfkEBEAd0uKQgA3AXa7A2j1ovUm6BPS8H_O7pImObyl
 nCy3rWosLRqamUkTJwlgwLmYkJ32D4jQW1hXkMhL4E8Ethm28cQM_N_FKYoMPWtrecrWEac8nZHl
 KTiR4QG1XbsfhPM.VcKJ64Xu1AzSuuA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fe59fcbb-91bc-4fad-b327-28214724d246
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Tue, 22 Oct 2024 00:16:11 +0000
Received: by hermes--production-gq1-5dd4b47f46-5kxd4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9ab5b1500e56173fe5efd6e5094bcf97;
          Tue, 22 Oct 2024 00:06:01 +0000 (UTC)
Message-ID: <617a2679-404c-4127-8dfd-4f3895e2372f@schaufler-ca.com>
Date: Mon, 21 Oct 2024 17:05:59 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] LSM: secctx provider check on release
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, mic@digikod.net,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241014151450.73674-6-casey@schaufler-ca.com>
 <5b6addd938c9feae0b4df8f54d56f9f0@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <5b6addd938c9feae0b4df8f54d56f9f0@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/21/2024 4:39 PM, Paul Moore wrote:
> On Oct 14, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Verify that the LSM releasing the secctx is the LSM that
>> allocated it. This was not necessary when only one LSM could
>> create a secctx, but once there can be more than one it is.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  security/apparmor/secid.c | 10 ++--------
>>  security/selinux/hooks.c  | 10 ++--------
>>  2 files changed, 4 insertions(+), 16 deletions(-)
>>
>> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
>> index 5d92fc3ab8b4..974f802cbe5a 100644
>> --- a/security/apparmor/secid.c
>> +++ b/security/apparmor/secid.c
>> @@ -122,14 +122,8 @@ int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>>  
>>  void apparmor_release_secctx(struct lsm_context *cp)
>>  {
>> -	/*
>> -	 * stacking scaffolding:
>> -	 * When it is possible for more than one LSM to provide a
>> -	 * release hook, do this check:
>> -	 * if (cp->id == LSM_ID_APPARMOR || cp->id == LSM_ID_UNDEF)
>> -	 */
>> -
>> -	kfree(cp->context);
>> +	if (cp->id == LSM_ID_APPARMOR)
>> +		kfree(cp->context);
> Should we set cp->context to NULL too?  One could argue that it's an
> unecessary assignment, given the cp->id checks, and they wouldn't be
> wrong, but considering the potential for a BPF LSM to do things with
> a lsm_context, I wonder if resetting the pointer to NULL is the
> smart thing to do.

Wouldn't hurt. I'll go ahead and add that. If a BPF LSM does anything
with a lsm_context we're likely to hear about the many issues quite
quickly.

>
> This obviously applies to the SELinux code (below) too.
>
>>  }
>>  
>>  /**
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 79776a5e651d..b9286c2c5efe 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -6640,14 +6640,8 @@ static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>>  
>>  static void selinux_release_secctx(struct lsm_context *cp)
>>  {
>> -	/*
>> -	 * stacking scaffolding:
>> -	 * When it is possible for more than one LSM to provide a
>> -	 * release hook, do this check:
>> -	 * if (cp->id == LSM_ID_SELINUX || cp->id == LSM_ID_UNDEF)
>> -	 */
>> -
>> -	kfree(cp->context);
>> +	if (cp->id == LSM_ID_SELINUX)
>> +		kfree(cp->context);
>>  }
>>  
>>  static void selinux_inode_invalidate_secctx(struct inode *inode)
> --
> paul-moore.com
>
