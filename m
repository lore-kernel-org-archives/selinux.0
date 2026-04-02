Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F43E3C53
	for <selinux@vger.kernel.org>; Thu,  2 Apr 2026 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152769; cv=none; b=VogEIOOKVOjEGLhnKInll4TgcaFFkN58FC8/DppaeEL75G2sfmJUMzRJwb8dJOjpvtzhMFtuQTn7TbwRNNTTiq5ikK6cwOQHQqDdngpDJkinEtKGBEod9DDwIy5PsfxlXK86LFM0OV7fuJ+BBdb4/+sPVCnOhzjxV72gaHui/0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152769; c=relaxed/simple;
	bh=5GZ0g3FSLnxS8kHbyMl57UkANLIDdgpK/fkqjTQu4EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMB1q3WoANzDx2TnqJBxeMTt3pM515QyZoNq+/NhDFj2nd6RlVfQH+jB6L9rSx5Cv0KlGh0KR08i3rnI526op1Bir4xQRLNYZl5ZcapyiQKq/Pn+asG9+2LVKZEyEot6H6mxPGvxmPa5kyjNE2HEhWKhg886Ww323gFCe+7wjnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=AZMQVcsf; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AZMQVcsf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1775152767; bh=5GZ0g3FSLnxS8kHbyMl57UkANLIDdgpK/fkqjTQu4EE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=AZMQVcsfCDAOtV6KWEwzdbuhU98ZZ4WsmxlSzIbIKCZMVoFWphVjBuptkl8nY5jsqi6Tx20LUwtcfcNXGcJ6FVYNf3QfW+/kWcMp3x1g6i3DjFekOH/rj3Rc/eDkEkE6T79YEw2Q5EnxXCt78uoGYB8M7z8N2KsC+R4KUVC099db3FbfZzYUMDpJ7CBI2PhU2UpmIyGO+H1BmjBAjkiFxjexosh5r6bYgRzJ7h4qjRYvCO+CYz92ckuFX0jrsDk0lYO4vHiLsv72AdisZ6ytLkHXbpFU4ZRcowTHBHV9fygpeSpLjUbSS2EfoG1uAw+gGINbPx087yn1QAqJISJu4A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1775152767; bh=MoDeoikwSVXx+Bp3hmA37xwUyKsqRNCBhNyafhn4bd8=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=aEM2ePu6nPKjo7ftEw4/WJNWRlXk7rzk0N1VoQFBj44IXBXaxVH7lLNe1ABAjVHry5T1fmnmjxvvrT3unDQxKpl+9SziEbxy7UOtGBgHNobb98X3KS/c4X5up8oCdZTHPrNp/FUkMEKpk+iUWXlqpYhCdB2V6PVgUXEu7ZnsYioNkoQLFQCBooRS/YT6Nh8dqc8I+d8etzwWOZJyZaYcRHo1LTPPUTfTmTcGX8kPNK7em8XtGXeMv37wrEXHI3XI3Cw3kwmD+rjMlPf1BOvbXUTVBNc8mZxkCrf+hoN33sWI8FhecIG/B6UfG5KZcQJ0YoGLcpQHAltEWFYyfFRaBA==
X-YMail-OSG: 6tFpofUVM1mvuP86l8kOx3ZaLW3AVM.T3vmMKF2R.8hIn6nYK.oCL70m5C0mxxl
 VdFkaDZ9RSRyf6xyGcifps3azg6adKe2iY74Pr8l80HEK4YA9vfmZkqyu0wG0crdO2NzYJO4n5B_
 pV5b.rVGjyTLglYB5H1ixnyJbpGsbo18JrJQ6SVed5vkDJkluyLCo1mKdmjJFHdunXmr5zgH74H_
 jjERNB_tK13cc54_UEgsaTYspU.LcSYqJFnBRm7LiNqclbsJCBFqw6Tt.15nRmHH1ZF9XF3HDF5A
 gxcFfXrV6g8.J9e1oMJPENJiRi_3aB051muorFo1Dja7806NfewAHy59Z6uExOUYK4jWQpnj5fAR
 RTg42LCBW60GO3Ww2rNiuy0Jfni.YaFgsAsDLi9g1ImJuD4RP7grYqXSiaK10sCuZkJnFX_siogk
 8ESNa0GPpnLL0ca11ZDYCNObEyurrUNc.jFLREk.6gO78fp1YhlLv2iT9hTKL49QcRzpgvzvO.gZ
 8qQUHl6mu0RpoB383obftpu1uKdb0mTRnmP_G.MxQzr1PtECQCDL7Tdq1s7PyHWYBE3LAgcix.hJ
 MBdSk3tgrWFPOJNQlNprhRWj9rbonmE8Xp3urgxQqHc8p5oCpFVjJG_vaWACPdzTWStNuVRDZU8S
 0RCLywqHMN5LZCrst4lTJuANwkVVTutmc0y0QPZ6fiuSW9ST_O9wcDW.N91GqXGTkqbvL0UQ1sfM
 IsOLAFQc8GcVmsNcqZDRisG97bi8KfN_WJXkrkKkZh1UcIFrw1LWdlkQPZEHf8cUFUGsiQFe2N2g
 mRhwSqMsoK2KmvF8T5txQc97VB8AJHgdtocq1ufPv2CwzvAxUCqMNz7VPpnQvXreo1KAA2MhsU6a
 eP.DVkqcuDj4TrAw_y8Ulr4ZRL70MD9UzELyBbLoUG2IsuTZKKOc9E3Ltzx8O_0tDPvqG8fwWXqy
 4EGTqY5anpqK7zwwaUngxbkSSs.N14iACrOZtPCJ9KvYevIPmVhaQ.4dIjjjsiHPrMLqDtoZ1vU9
 PlHI5WfLtjiAerOZ_X8sd3qYtn76LcDKcN30EPSxNF1X.WJclcuiLg1FBDC_BuNfUGmHotIIvmuA
 57kCBWbY35WxAwqualKZqfhEx3_Y6agq_3shdYVyfOk7kAUIbAwDtc9XwZUkezNd4RZAXxIfouwT
 bNLSesyCzeSNYooFgDRjqCAFvUyz3utOu.2whZwctmYVm2smA1ZrLjwCgP3qH2Jpw2HVE_dijgzu
 GkpGTd_S8iHn3bSRjU3t6EHq8K7Q9vRIRbM3OXZ.Qo2Cc_z1Ps7zl6mZN4D_ep3qjWnujl.yTOLV
 eDXza0uoToqlGu3XhgVNeb7OkK2h23QO0jov0a8YtRsKEbPWlTzlKnzezjFyl7C4dVnY6O7sl5bF
 7ugSkDL4ColSunytYNExBVZWtYYqmj5c_IzmujAIt9VSv3RAc_3MzjICeG3OkvDhICAR8.y5YaZa
 n3bYe27iEfYqfFiWqQdb_Bt2M2oMo1X2YISHkW.BfdA8QMu9JoV.uzVWsV.Uq_Z6AOHxQ7ont_iO
 .qaFF3PVt4Le4zheP8.eorvqxIRM2ewk6RwBAlpTh0g0FN8q9q8Be3TI0CGdnuzWUwYeWkDbilM.
 ybOQl1aK9JrEN4EuIm8QoeU_PzNuhka.uu1KpqaUtHSvpB9g0FDPq3K5NzEfjyq8vGb2ZJ_h9GNr
 KZ7KEtFRHThmHzWw6G67NLKr5QZonU3NCXDloEuCs.ulYkjcqbUqOM0LOhRgCETaXaHPw6ddqfE5
 JNju7V9t3igFzbtlyJTmmcVoMfbEzmIREdhmSEcSl5ZTlWbdsGqeiuiyo2HOvKCJEehr_1nhY8Ds
 LYRCV9whmwua3a8e2uPWLgPYHqiIWPR1msMF8Bvqe.EcWLfrLRIr9XgInB04ap0F6IywxN2d3yBv
 2qTrEUDWfs0zeWA0YnZag5FVx8ZCCldbiPl2EWNE3RpSBZeIqAeNnr1lKXWXkl8.u5.70.SBObVS
 YB1e9F5Qm7bWUO0BKJhdTiOYytDdzZdPFVLIEoHBHkYiuZ.GQI4z2SPj1j8apKmMAqhluxz5QChM
 FxP0cWBGe4l_PMus1.L9a2J48So2rID4xQ4Zc5rCYma5G3UV7sHlISRcjtt8b89Da5N2viilglKp
 N_WhoMIBTjUOOvgSSbUr81RyB0aQRmewxCg50KNOm.7nvNOUITOy02HBYmrripM36HclfgrQNOU.
 HY2FJ6.dPaQNaPhw3tFj8zjgl8c65Hspbd41QQjHBbTwxLVaY5UtYiPtHzCpWAIuPRg_rpttXqA-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: bbb0ac71-81c0-47e3-bdc2-07f5cb1c536e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 2 Apr 2026 17:59:27 +0000
Received: by hermes--production-gq1-6dfcf9f8b-b9zl5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e2854c90b467af2a2bc094afd898ee69;
          Thu, 02 Apr 2026 17:49:17 +0000 (UTC)
Message-ID: <5e210223-f9a4-4613-8c4b-bea5eea7f8c0@schaufler-ca.com>
Date: Thu, 2 Apr 2026 10:49:14 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: "Dr. Greg" <greg@enjellic.com>, Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 John Johansen <john.johansen@canonical.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
 <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
 <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
 <CAHC9VhRgi8_gdx0nKwkOws1VD6EFG+bHNTN5Q8YCxZ3HOCu5PQ@mail.gmail.com>
 <aclOtS61nbG5Wf3p@wind.enjellic.com>
 <CAHC9VhR1R7TcC2a2wZ9-G8dmXTuhcDK1YedDduq0sFgPC8QxFw@mail.gmail.com>
 <ac5MKr4lFQhc44i6@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <ac5MKr4lFQhc44i6@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25449 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/2/2026 3:59 AM, Dr. Greg wrote:
> That still leaves the question of whether or not CAP_MAC_ADMIN is
> appropriate for gating the creation of a new security namespace.

That will have to be up to the individual LSMs. Not all LSMs implement
Mandatory Access Controls. It would be inappropriate for an LSM that
provides finer grain privilege than capabilities do to be gated by
CAP_MAC_ADMIN. An LSM that implements a novel access control list scheme
would fall under CAP_DAC_SOMETHING, not CAP_MAC_ADMIN. While a time-of-day
access scheme might require CAP_MAC_ADMIN, it might not. Implying that all
LSMs enforce a MAC policy is not a good idea.

