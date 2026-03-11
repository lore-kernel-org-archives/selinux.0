Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80DA2D595D
	for <selinux@vger.kernel.org>; Wed, 11 Mar 2026 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247044; cv=none; b=sbrvl+bQ1ONglVo8ZKfVV3JOkopHPtMpI0SW8CCvZhmTc2ieRmHKaF8U0x5NC9X1Jvsco+3wKSJLVM1tcuLpe7+FsPKZY6LFlGpvkBHPNimtUigjQoB2coYWPwl8f7Kqhc3T9Rha/eLCgCDZqA+zwEmX95k7Vu81Sdug6Wo5GeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247044; c=relaxed/simple;
	bh=y5xcwD5HSLcsAkYDhlJFluKvVgMmP8d2ny8wSpR1ago=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzdCIh9lyZaBmzBPIHVTdIAsQtvNmcHnSIHN2CmTnTgEf6A8D0EeTPtX3oQN03NhM/YLybxSr/OEPH7ObYmM7GaH3+ICFUYUocooaWtqWFsSWJSEtYiR68UzdUzUUkUXNypuvtDJ7Cqif0OjVn6U5m7FnQDUUYiLqPhVg1retj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CGMGFlqV; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CGMGFlqV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773247036; bh=JZul/JdSQ6BogT6yJzGrSadZ4bqvsCuLBuJ14sn8TgM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=CGMGFlqVhQomt6L84QkqknsGU+LQofKjigDQJeHL9VMCahR2HRJEOnTDVQeKy/WAUOaKW8HW6EAXdbZjU7cYCcl39jvbXI5JeCEGtAAO3tI4I1Mm73Q1CO8QUqf1eQ+UryFJ/2Erg8Xbf5UHDnygFakm215V39u0M4TpAsjQYC7wmGYvx/BB/2yYiKv//Ey84qs5iyeL/f1yHGGgL7WJ+udH3CLp+kcGcfr2Q6gaSSgMnKHEEFH26YSZDAQW5tUNgW0jESwv4q2A7DJGHRIUEWSPmYUhjFWFr4kmo9iN41ZboynaxCamK3HPPxHNmfX3EBpfwjXjVefH5e1q85aGCw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773247036; bh=hSVufePW+YtcauRSeVZI5MT+lI7ZSWiKwIj0zMSJ1KZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ulQiNQAfseVkTZtc7DBzjg2TLHo16V4C3VCBgjmjLOC96Ly2hpN0EXhr2u5mKwjEevQRm/Q/H833+ej0znI190dmRENLhFxuJSuNNTojP56Xn3bZCgP4xp2Dw5PUrBHxzjhRZ0bnxGyEuI1Q7ZaWdF9h8HYbhC3yEVmKy/zwYMwcQgWFJ6UYFNtV1lpLG7erCNw8kCmgz5gBkAD4RxRUg5plIGkKY92FMI+cxWSwroqBOaTszMpO22AC7InJqnE2d67zeBqV5ZypyaUsPBRmZSnUbp9Zh045a/XPsIXeQoBUw10OfaxPkwt6Hqs/Wmf9wGrX2q5maLUx7J7EADj5aw==
X-YMail-OSG: IWPzEmcVM1muBLVPcWpznxJ2erh9bvvVoIfeWYtPSiW_jxQcLfHpnuq0GLIZJEa
 GZ9WZAMmCZzy7kkZWBzS1ADYU2ekrQBzbSMCihTzHK2wOu8EZmnGNCo1OsPW73G.5Q9mDu2MaQPk
 AXCO0qLotUfWpu0Zgw0HCckfiX9hqQ26nCCFKFCUoFjWt_lq1XLSwnpnit14EFeEUZf7evZ4F3H8
 kyV39nZlJrNEmZ9mAlxIHV3nM655C.TfPhvZyfucsc9H.oW8CehG3sihXA_dpXm4sH_tGMjtiO3E
 QnwyaahTHmDf0VbJJ6IsW9_Zs4nf.jfxRsLIpM1lCODuc6yQuEsoDWAM4wbR7DWvclZsrU1yXfp0
 .iEYP5n7htgfnweVffKjujw4uBpWkYFqvDqIzsp4j4vhz75KemYRq_K_aZGPc.hwoPNPW8qm8Mpx
 AQhFqoQXOus7VkmAA6cDnf_3vSjWn7l40QtZTR1ga3aFX0zwp8VG_hancfk2KOEz8Qdm5RpSVoq3
 zwtDZMwld0.SZtHmNfAgZ7.q6joUr5.e4WfJ2nUJElIOLWHemPj0hAhHDrYelbSnv.B2TB8NvVrX
 3Ve.tUf1o7pkToaugwiyaVwqMNg8LL4xiGUsouEtcTvIEmJoPnHQue1QBzUJrDte0AKmMv0I.ZVi
 DL70MyzJAmcowhX8kbwa0ri4phcec5sQioxkKT.BTNfF4ngJSf7oxZisx0XpMhkpMD0dTY2WqzAa
 HEccKQU_fr2EHRI3oFIUTy4Exb3CN0Gh0NfsIQnIRHW_gt6PeLZ6J9OTqteLwhVqJQ_mrFJB3X5z
 VLzRL4xStN1K6EX3Ja8r52lo.gi19mkuo9QdmDPvbbqLe8kk8436_N85PL8mFEoIPpM1AqD5MXlk
 LOyh2qoOdAaKLKz5nDqd0xpVC2Zw78qx8z5kOq47RapZN2rlHJTNmwMCvp.MgLfA6JJh8CrHsIwx
 LUryftUrlzzVgYoNWcim_LJtSB2BoiY9lkKahcop5o0ulaTHSzfFlRYFyw_hSynCIVVY5qSwP89e
 yJ5iv0LXmBz2Gt9fSfpuvN6xzEI4aCcEBmzUloW8DQVMOigoMph5m8o3kner7m9VLDl26jqns2mM
 kN7SLvzrCZlJtysQ7mujZU.LpBsROp52q79Iu_qiVEnSC_a07SFQGggWZbwrI2acefUvOvh_eBt9
 bCT7E5ol.45glgm_EcY.6K732p98yD0pc4LZcYQYsezVab5Y50NJT5y8xek8bqh5yjx8n2snlHvF
 6ZnKxNnjTEuqsNzROz2rCvmaQkhNDDfMfFOwIP72NfNzjA1suv9iFdIBEr4Q37J3unN5YlI1nXtp
 ma7DYcxjTF.dujLmv8P2h9M0j5VdP5QnyY9dmNaLaLQqowydUE_5sAFrG3d3ilCOHhptPeLjvsO2
 AGenv5RB1T4oQZugUNB.VevLm8ByFrNNLSa8iYyDaBO0B4CgkEHBXw1Zm37StsHkojFhhwJlaKqF
 6s8gvqdN6WgBk061xgJfnSva7TZbee3mR.BcwnZ4ZA.EuyFp.NiM0ULFLbt4iXdXii5t.wNMiz.j
 .Cs.02Sld2ayIwPzfYZfrRNwEFGUVQDtYvipgp9IcgHxfZLB60Hxd8yBf3aDViNI41DcNpIdVcUC
 ZGc1cWdCun_0fuD8RyPFjtAA4UzjSQcTYKk5fZ0uO2enhWUay7V5i7Ns3Fn7mJSxsv6VAcQ3gRFw
 NiOdHy4y1k2sQMugknjqf1QSaeZgrHuu6RobIl425XxuTHjKaXRbHVe9ctgBh2y8pnvG3we1Ew69
 m_GnkUVonuBwEvwW8cD3WM.WMQBE3f4UJrfuGGAWQOOV0n7C.ZRIpziudHDsx_v0wQyLQkvSG57w
 pT2LRkbnntm8U3a_kVC6dYHIrxusBqvGYNJt9igbm7qKc6cdx709Lyv84eO.EXsEVj4I.wKhkEyz
 XUlXIt6aTxkCYaenrSypsj8a18yT6yGiSEUcX44GtZScpUzgUOJ4nAMVuvgapq3A6a3naPSHKspW
 Tt7zq0TzowXLn0Ywk9jGvE6QlaIe0qGgRFKjMuBucdCsXiLst.ZbyPdS7N0QLTiJfo6NifTognyO
 Jnc06HiytbzYpwbUBmd7GwAKHv_usMg9WAXEcVFQUWbtsjE0qFfB_fYpQBlawd6v7DXH4fh6Q6yn
 VKgQBXWWjt9qxNO7TbrjxXCMb7ac1eqZGXJkcjX9BecjsV25IJ6J8Le9JDbHBTo5k.KzMR9QHc6Y
 HCdf0FoH5RTuV3F88oJylCWSbXkCp7QuY3JyjzUorQem4XLw8CfzcWEIKTlMmUQCshds1ztIyJDL
 tKrtk5ba9Sw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: eb61c581-cb5b-4937-8354-363a1c0a7ab0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 11 Mar 2026 16:37:16 +0000
Received: by hermes--production-gq1-6dfcf9f8b-xs62w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 24648e7493ca04f0df50e0e0751218f5;
          Wed, 11 Mar 2026 16:37:15 +0000 (UTC)
Message-ID: <39aab889-8534-485b-a4c3-b6bcb3889721@schaufler-ca.com>
Date: Wed, 11 Mar 2026 09:37:12 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: "Dr. Greg" <greg@enjellic.com>, Paul Moore <paul@paul-moore.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 John Johansen <john.johansen@canonical.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
 <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
 <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
 <20260306174815.GA9953@wind.enjellic.com>
 <ae5e9c1b-d0cd-476b-87d2-70c0bc8ba09c@schaufler-ca.com>
 <CAEjxPJ7yuJ6sAZ-ViqT04M5WPC9O39m5UUGw2f3+GDR87tvbsA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEjxPJ7yuJ6sAZ-ViqT04M5WPC9O39m5UUGw2f3+GDR87tvbsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25198 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/9/2026 11:15 AM, Stephen Smalley wrote:
> On Fri, Mar 6, 2026 at 4:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 3/6/2026 9:48 AM, Dr. Greg wrote:
>>> On Tue, Mar 03, 2026 at 11:46:53AM -0500, Paul Moore wrote:
>>>
>>> Good morning, I hope the week is winding down well for everyone.
>>>
>>>> On Tue, Mar 3, 2026 at 8:30???AM Stephen Smalley
>>>>> I think my only caveat here is that your proposal is quite a bit more
>>>>> complex than what I implemented here:
>>>>> [1] https://lore.kernel.org/selinux/20251003190959.3288-2-stephen.smalley.work@gmail.com/
>>>>> [2] https://lore.kernel.org/selinux/20251003191328.3605-1-stephen.smalley.work@gmail.com/
>>>>> and I'm not sure the extra complexity is worth it.
>>>>>
>>>>> In particular:
>>>>> 1. Immediately unsharing the namespace upon lsm_set_self_attr() allows
>>>>> the caller to immediately and unambiguously know if the operation is
>>>>> supported and allowed ...
>>>> Performing the unshare operation immediately looks much less like a
>>>> LSM attribute and more like its own syscall.  That isn't a problem
>>>> in my eyes, it just means if this is the direction we want to go we
>>>> should implement a lsm_unshare(2) API, or something similar.
>>> Stephen's take on this is correct, the least complicated path forward
>>> is a simple call, presumably lsm_unshare(2), that instructs the LSM(s)
>>> to carry out whatever is needed to create a new security namespace.
>>>
>>> There are only two public implementations of what can be referred to
>>> as major security namespacing efforts; Stephen's work with SeLinux and
>>> our TSEM implementation.
>> Please be just a tiny bit careful before you make this sort of assertion:
>>
>>         https://lwn.net/Articles/645403/
> I believe both AppArmor and TOMOYO also have namespacing
> implementations already upstream, so SELinux is certainly not the only
> one. Looks like the Smack implementation you cited above was based on
> extending user namespaces rather than purely Smack-internal like the
> others; is that why it wasn't ultimately merged?

Less sophisticated solutions to the problem Smack namespaces were
intended to address became available. The effort stalled for lack of
a use case that required it. Much of what you want a namespace for
can be accomplished using process specific rules.


