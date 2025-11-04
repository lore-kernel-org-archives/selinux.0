Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679A0341648
	for <selinux@vger.kernel.org>; Tue,  4 Nov 2025 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276071; cv=none; b=Go0VEJgPmNd91kmZMkAq9BTKTxEYqLiKTwjTaAnPFNHaU2MMUKspB24FqtGdv5Vs9ZVddA7NKW4689JkbroiZwC7/wFtH+BxHSxxzmqtFuaZegRuMxrNy9L7bb5GdGJ1EM9EBgW3xWCEyXyvUVqbjAs8+eR7rC5UVWNj3dWJtv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276071; c=relaxed/simple;
	bh=rW8RxOerMoyM4MqnenlynS27B4Et6oQmxBD0ATCBfms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBOQuIxDzya25YeptdmpN3Skx2T1Wmk0btGYK0616EvGuNyoxkHmfAkBWR9fyAMD+td6qjPZm2newLSLJXCadhDgu0a/4at7ElcIrWPPA41eAPkYgjp36PMfHwyT8DDr/xmnjOYEdMmdVYclQy8sCFjuOR3+C06IMurYmiOur4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=HAD87Kls; arc=none smtp.client-ip=66.163.184.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HAD87Kls"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762276068; bh=8qYzY7hUini0UwA4Q2shkOft76aItYPRxDBwJVldq6I=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=HAD87KlsliwImcBIyxSMYqTXc7fX/SbHFJaLgGUqyweHvNl8WaxhneplBWD92+0gb0+wn9BAEtrntVJ6iZmDXV4dH9+rex8/EVkCzySTP7+WY8Woaaq0Rl1SiWnO5I5QER6AR1GOKBXs+Gg14C5etH0dypc9Pzf/UedG9lvafMzFIyD6+EIysf2V3XlA9xsRRm5gKt/G7vFOMzzB9+rmY9af6HqQ7xbaLBQ70sHRWEyCExuNN21PetMn37N4gBlPC3iYXP91vfTH2depuU6zatKYS1bEIEZNCuCNXulwROyR5vrUKgvh8kpy+uDA+tTwCQpP+hTAnoNT24IdviWbVA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762276068; bh=iFbbmueiFFIVpQxrrUdAIKxGl/u6sJDH2sb9NbAJHXu=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uVX0J1piIHI99V8fO4307rPbsdlY5lOZ0+pOdjrMdULc5d1OZt8BAbJYpU5VPWhOUkFf1vETa1uAY0oB8m/E2Ecp6UJVjV4EmXtC6tSTSsNoDSYE8rbsP5+K6ptOeqDQLzVRYkBG3VbCtBaTT2DnJ8cgjpB2FoEXDJdrquNnJG1/RfwIqWLiniySUnUe4nbc1fb/Q1J96XWD/FNcNEKYiIAOU3SVK8Xr997VY5e5eqmU3GWrL5COEtb6tT4NfjaRMOrvrxOEO4VMBXvJUdcTZDQ0j2Yy37ewWbf8qOPeBV+ZhR16/czpoIcg30n+PLsDFZ7M9iXfSh7YGQ3D2wHX8A==
X-YMail-OSG: 7zkIHbkVM1krKP9Xoceiwr7pcgQm8WNaL92Jnc21aGALrEDFMvZIZOytsY6Gbyb
 PbgCFOjDptxh0fOX6CbNcRv8nBBiH913XGo.sdisPtTcmsKm2ksnttOQBpoksMmfD8LT7_eaRe36
 cRUCxFpfKp6ilk6b_dKKsoA1aQKKNyBkajjVWmY6mF.K6IgWDSjlaE.n3Ie95Deol6BKb0idTsHw
 z0kUgvoUrzL7RkIX_sHzjYgCyVYuReMMdxeYZfa7G.mBgimPqZQ7J2esRdm.uixDX8aEnf7McHhL
 0kHbx1FYexN.vbLTMcHEQ3FjrQhMhJpx7HM7LkUGz.fC4RvDWhnFkH8546OZ.5b2DRoSbnky.5ht
 RMj2xNzMeLPe5ZvAU4xkrBZPblEUJ1X33y0hz10LymQZ40zEUrUuEG0IeGoj3al9U6ppsFO11063
 SLMcpp5REd2gpDbtCLoDs7up3xYKtZRum_MVGRq5nuIErFIHRJuqZLPcd7h23f0YPSJ84z.N6ygb
 H7RFkAF0E1YeleXh84j0nnAwlggNZFsdEkB1hAgugq.oCQCYhGypSUbORZ0UYtQgZQLZFMHTcTbm
 xiH8.BMbdoqJiMWMTimy94MpRgut2vIiqmHCLbNgYdaocYRYcZ0LDhidzr.xEdAbq1gW7Of0Xbpz
 qwZB7CBngSDR9gG5krex4Vj_PasfPltzIJN8LMapcjcBTFp38Xv6kBO2mWYaoTF_edKuSCgF.3xH
 PJwjEQNC3OrZuKQPIFCM9LuQVImXpzf5viivVOemyA2fyP0S32waxy8qZKbN7iNkKLS.8jMaZTeG
 bU2Zrsr1ijAzJOcGR4cx.hdYu5g3c8oW7aMX_rwHaY7Vfm1umbWKrhamPSgdWewurxCFw9IihOwY
 T8ZnW5wrBzclwmwLvohH0SzQdlYOZRjLEwFcCsyTsBsTAVu_FOLKKjMYudYydA9NGQsPd5TC2W8a
 W_McUF15P38Nkl72Yk0EXasmzGqAUZkTSWmCqxewL0Pl91fRVJb8QIIUyvpBXuPcs8s_9WJoQEk6
 .R3.UqengoA3zNsv8vsxymQEn0dekief8alQxHN1GSpFxQ264UnRPW0bcg4YHXW0Hpo3h4mIAVOe
 VnM_b08J5gg.2iJmGX1P7G75nREyYWoI8MiTOKO6WnBlSw1j76EJlB8G5pnXzMee6epHqA6SPRxh
 EH1z9umyv5ULuFgu026x8i4mJSsuh5XYRtqlP868AjUS9CJq1GmzR2d9o.MP5s2hYDjM5AUVHM0N
 F3pWVbdmCtSRK7cpWkNj8vg.YvFpB1M1JkDd3PzKAV0YaaRFGuOHFbYxgjL2DPHzE_Bw2RX080kA
 4U5bVmxuEy2fAi8H_ApxQLcGVwuEZur62j1R6uHBvcv8l6meaFGZg_vLkYzLs2_1xDUX7XeO87rH
 zVTi.aSiV4UWRS5rZexoaU2q_suhXqOdocB6oCzJGJ7zaiO8mg0WtVDEogzILNa06Pbb4x7LPMAL
 1TeQZKth_mLVlb1rJfY95l0gkBsBb2czpgCqps7NQB5i7zOwilaGD0C7w9SyjLVylRt44.zeLhoj
 l1FVxt4QMHdruY0jUxHiNkcFBf9WMAyqgra61witQy3FfFOSEH5CbA9PQ2E_6m8J8ijg..PzsVDO
 Ej5wqa_QQRqD5LQD9iMtyN5qjIBXKco.pYMkL5bmtjF8vqFRyfoMz7EajZHiy1G9TFAOr2HtcU90
 g8xkM6zV53j5M.2jmjtHmJNIawKpzEvQzaZAsu8HkqxOZmja8a0liTFYcC1gR5umaTTV9Wr1lsXu
 F9zbrGCfGzQ0_vYmcijMArG32YTB1L0LGuUsmG8lzeXTZCvFlLxY3.h6IT41kLoL8s_i9nhVTyjW
 2vEf40x4byfQu9Xxbc8IiezKKIgrT0OtaGeWPfpgamgdh46PPlqGUDv9bfmQhhObzHvDTppEcU9E
 5_ttoAwZsXTV8s2mDZRVDEBlAwWs4GJ0_sbOGF7NEJRGu8ZaO57SCDnGTtIRUe.XYXVnyhc8EPbu
 sD.D4gM6D_1bfvOw1JwokCJIHP1CUpLYbgWh5Sc8HjkM1bt.I0weCu6ztxR5jhaaMxwK1SX1yRTB
 WiElCzX1m9IFQSwc_obKFqADfr2YuGUrcSIevlQeCvliMqp40dtRcRtedkSN7ad2tMrT2KSweaaJ
 EAw9esau_aW3szoat4VmeS8rti2LMKQ385jJHgVRDtYr8jxHhHnUQaybZI2H_iffEqkbXLhoPxdA
 ojel7TRWpxvgljs2HER.3J0UFPuQA0T49SoIgQETBUXDvye.Hex9DJNUUFpQdAu2NbTp5kTa79ic
 3hYxzqS.apoMedxCycw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 24153a9a-e3f3-493f-aa36-f6b66203855a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 4 Nov 2025 17:07:48 +0000
Received: by hermes--production-gq1-bd8655d9-mzs7q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0b8ce03b4b12c09a0a5c5764cedaf979;
          Tue, 04 Nov 2025 17:07:44 +0000 (UTC)
Message-ID: <613960bd-1ba5-4503-88ec-5d13234b2bcb@schaufler-ca.com>
Date: Tue, 4 Nov 2025 09:07:41 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] LSM: Allow reservation of netlabel
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
 keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20251001215643.31465-1-casey@schaufler-ca.com>
 <20251001215643.31465-3-casey@schaufler-ca.com>
 <CAEjxPJ48PiZ5ZOZbZjka5YeiBxaWFsCufoGcY_jEztM+wtEUCA@mail.gmail.com>
 <ec89959d-c3a0-403d-bfb0-7405639eb0cf@schaufler-ca.com>
 <CAEjxPJ5N+vGS4rhBJmCfoW+rUnjPm7TVAC9reRmu6YCaJWTO+Q@mail.gmail.com>
 <01879779-d529-40f2-8693-257cc598dcd7@schaufler-ca.com>
 <CAHC9VhSBxhiTvxPpHHqZJygDTTuMWOPFpQcoMSsvZD6Bueg0ZQ@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSBxhiTvxPpHHqZJygDTTuMWOPFpQcoMSsvZD6Bueg0ZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/13/2025 3:21 PM, Paul Moore wrote:
> On Fri, Oct 10, 2025 at 5:11 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 10/10/2025 12:53 PM, Stephen Smalley wrote:
>>> On Fri, Oct 10, 2025 at 11:09 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 10/9/2025 11:53 AM, Stephen Smalley wrote:
>>>>> On Wed, Oct 1, 2025 at 5:56 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> ..
>
>>> But some security modules may not function correctly (or at all) if
>>> secmark and/or netlabel are silently disabled on them, and the end
>>> user needs a better way to express intent.
> This is the point I was trying to make in patch 1/2 with secmarks, but
> Stephen has captured the idea much better in the sentence above.  To
> be clear, the argument applies to both secmarks and NetLabel.
>
>> I'm open to suggestions. Would boot options lsm.secmark and lsm.netlabel
>> be sufficient to address your concern?
> No.  Please no.  We already have two LSM initialization related
> command line parameters, and one of them is pretty broken and very
> confusing in the new world of multiple LSMs (as an aside, does someone
> want to kick off the work to deprecate "security=?").  Maybe we have
> to go this route eventually, but let's keep it simple for right now; I
> don't want to add a lot of user-visible APIs for something that is
> pretty niche.
>
> If you absolutely can't live with the "first one gets it" approach,
> look at the no/wants/must idea in my patch 1/2 comments.  It would
> require work in the individual LSMs to support it, but I'd rather try
> that route first.

I'm fine (for now, at least) with the "first LSM" approach, which is
what I have implemented. What I *am* afraid of is SELinux deciding that
it can only ever possibly work if it is the "first LSM". Best I can tell,
there's no reason for it beyond "configuration is hard". Which it is,
but we're already there.

