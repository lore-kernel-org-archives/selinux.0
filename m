Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054A12E2286
	for <selinux@vger.kernel.org>; Tue, 19 Aug 2025 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623506; cv=none; b=oAsXoI5j1uKty1k9vRZ9zsEmFB4GzA5jtd41mvdHkdW+uxjM7vA4+vu/3NDvgbjxO3HpcZNTuzx67mCmuoJHCQqJlm8vONNSY2XuMhYydETawg/c9EHqMYya42/0C49uzAaMBndNpgbo1Pvsz2QYze8uTlotlPocAMPmr0FguT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623506; c=relaxed/simple;
	bh=ZRu4YNoX/J31s7R8KAKPX539Ox0EyUw1bjcudhp/QwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G03677IWCv92DjCiLb58gymAiYJ5C5B7FLvCZJ4ft3czDyabDmXkb45CMX85IWtm2H9/9VfVl85gXLOdPqcEx4lW+59ViKpvaW+vKCTrQTpn00O07b+XRhkGX2oQ5Wi7Ri2kORhmKxoAyknfkOVDPg8npf6/uKogg2AvymhMsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=OMKYSeHL; arc=none smtp.client-ip=66.163.188.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OMKYSeHL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755623497; bh=/1E6ssvZo+5xNJS83/HebDJcCGNytS8ZT++2ckhutME=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=OMKYSeHLwDDKiTTWjea3JEoeVVEuEXK0jnbfjIw0Llgk2uDOWOTlYXolKZvbT2OkMkkWn/sydYUHtlyR7O41nqcziv7/T0Mz+E03tSRTTeZpbiafIQqZLG9j051mPLw+wsZaD0I21WMtd3TCkTpIRvMlQloUtCjo+loMItpMxyWKesERRzLhLqc7K0UifVAGtTPQtvRB+4syLEdF2e1Nenfql5VhRJkJXPWhlKRj/WFngtUkKgSnfzC8CWX6glWisqQlldW5j5TtIS50j8ven8OpVSD8/LsIpNRjVP4HWBYN9l6wkxE3JWgDiomsTDqFM2VnpMpHE4kiYVLDPQECNg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755623497; bh=efE2fgKYWOKKpfVyj4H3nB0BqgTkxDtHTP2lWQFGoTC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=t+kRkSbxcHQVP1FcYsZxLnnwtyCvALcfpvZJfoQnHG7Mja2rzWJA3aFaqE9/YaN5a0mYFEg6EFMDXn1CQGagNZw/M89P5+VdxmADK7W1H3Ss4sr3+OXqKDxsGuh9FFClFaOmZlx4wD9TmtCyYyoMkvBbKSX8kg0lV0O/iSVFtPQaERwdnXhlwCaykovMgYzRbr3hYqGnON3gR8/EQTzscOIoEqPCWq0l4AMUlaZiXumrZ3/mD/DUa8zhl8gE8R82Fgo6HWTqkR2wS4IUYO/2KyVZLpOqMybE4B+ZqEDYypsNBhtTjtcVrs23bTPrlK+MiQuUpQnm0O2czbYV1I6E2A==
X-YMail-OSG: jA5hBX0VM1nuaxHlHJqigza4TT9TzYryTnbyFfsZdIBKX3EWlFNOAY25fBd99va
 mEAzQvjGWENqwkF5GKec8DlQzHdXX3hp1RJddVehRIsnbyUR7pcs..MyBJGEz_RUtDH1a1b1_KP0
 7JHCP5Ymt2SN96D.suPADoEShtl_UkJQqKtPyPXV00yi8qJdxwpAlBprpuRdIYDe9jpAq6EJx3OM
 IYrxR_6UgJ7MX8dpbDhCpEGsVpNt.WJF8IK7ayUBg5PED4NR_IN_c7LgRyD4cxgEw5.Y8A.t85ry
 aK2IY_MYtRYrLhU0mprXsPtHwoeOsnLXroX_It_6ov7w1lmqHnMAnV_K7p8QosqYAyNaS3i1ooLy
 3eOgF8dWweeBKD.Cc4M8LDATHKI5FhQY32haxWSqKWY_fDkAKLNvwqhbJmDRWwwxvrk2bXxwDo7u
 3tof196M3a0m.sZHsQoW0GGXoPwbpXDWX0SQwWBIRmRbGeB.cRoCVfqU9sG4LMG9Om2HEoExXrV9
 cMq_5NK16K4xrsb2.ZxxG1ze_adlFuSWvXv196SPi7KYM_NT0cWNGLTg8TNY5ARf7g.G7_22Ff_P
 QwSURglMmyJqgUoLa9fP4WwoofMopn6zCmQvlg4JU34KQrkX0Ang3iF7qjP09g7krsjaX8RflPPJ
 mGB7zzdxGw2udtQYUJOOOO7iHNByQSD1FbHva9aMo.31VGXidc5dODyEc8iDg8iV4a3R_3JQhn5r
 2x6dZL7aakUAipswQHONxMofAhkabzk5JS3GOxag2vXj26TxXplyXu6owZ_nzynG3lUb4VHDaW97
 dOimHhSEGr.xXH2GGJLy3HpYVNKJA3Rg1H_vj.D3XQjUgIO4cpEH0yARI92xTU3OjESLeXTK6vBu
 Qi1amnm0iiRVyJTTiXGkG9vymFdhGs3sYZDMAvbMsDzSYQGI20OewFDtLIGhjQghl3QNzW6Atj8S
 NXlHiHf.EV7pOJuUq5R6joJ.hPCTxXj700ELmifkdL82xHAO8OXnFnsQfuR6MiMkodhc5rh3x7LG
 YWVqFRJAbm8ilCMcZsR_Gja0R7DFMfAiGTKYsmEP5hxwCirkSyTCKepgiZddKR_cjrIgQo0bxJAO
 Lzl0_SkQJ3ppHuXuC_mACX.aRFivr5j50FuAiQ6SI6AI2XQ2058oMKKP72qOKaga_C0cHGiNvKk2
 jL4G2pMRLc8OaVx9P6QBEudyym9wahDJV.Nnf4ttxOTOc9XADlqKARW7iPjklBb9l7vTqblm1x7E
 fZthnav9RWej6om6HKKbWDFvrvGd8_YVc75xkoYh6a5VPXTUn3D2jpQml97TqKt9mkWCkY.H..yD
 DCR7AnIbadfrmat0JL2fMwtcG2WdA.9A6GvT4EcRyMq3YNmroijLHLGJSCBj1WwP5X5.lgOkJ78V
 tIEkhtMRJ.cgIVT_bemIeCQPZehAWSahdrTpWH75XgmjA3KseOC0D09c7LZ791K4Pt2Uq6c_SzKd
 8IhDGL5y7D0wEhR325o_DUg4CTZYMzKEXvpvzZ82_pTQ4qGrQOit.tHKefRfXQfZYeBr_H7xpPhK
 EpMEjyge6CY7MlEKU2KnQXAW9UgprNWAfpkewb8NXfg_D3SJbYNb8M7MmfnN8cJ4zy6fYLAjZh3u
 9_pyaJS8W18BTf63ldYDEz9ptvcWqofeeoqgHaoY1eSyvOZOFWxXA1NUn5n.1kVVyvM1UXSlMV_U
 2qm7ePEZX0LR.B3Xj6PYSflcxcj8Mm.r6tjryJ8l1gb2qaUQRoA7B9VtnUqnVjPp_vBW3MZ9FJEv
 Otcu.2NMaLvRXUPNoyTIkT6fTwDHA2Ij4zBgQH6ZR6Ygs5wn5z6stsae8nnJCerFdgPw9r2g_n5i
 eWMqeoe9Zh2IYsm9fSoXT60p9Ygko6IgAW1gwyWoBp0zciQY6yMdSnFsRoPY4QSLShZUde9w9hKL
 lEo.IVwHeTgn5j7vuXNOiLvXNOGL2alK1XtekOHkom.uwL8yAaXgbE7NNxi8qMQ0ly2LRswxdIPc
 MClOANSEH.EErA5dCkIweVodstmalxPSQr4LaoU2lPmZhHC4S9TWNh1dKkKm8NLE3YP1qT0p8XGU
 bUqA2UH8tVm4u5yAxSHr9zechdGD_K_mMVqj6fyoug38unRgBCGu_QGAvwfpIEoQKd9xowEpOZyE
 Oi3mnu.WeBo5EETSjbPMXX8VGgGlEuCeEk_vyilURBwDdRfrf27FvAOSSSQXuteW8JccMdfVkzb7
 wWGiocHGaaxQUOvTszQbnMaYlsGjmWwDYOYZKS59YMU2u
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 49ae05ba-3c3f-48cf-b651-fd9860be2964
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 19 Aug 2025 17:11:37 +0000
Received: by hermes--production-gq1-74d64bb7d7-5qmwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a8c6d512a45e6802883c92915fa05902;
          Tue, 19 Aug 2025 17:11:34 +0000 (UTC)
Message-ID: <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com>
Date: Tue, 19 Aug 2025 10:11:32 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24338 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/19/2025 7:56 AM, Paul Moore wrote:
> Hello all,
>
> As most of you are likely aware, Stephen Smalley has been working on
> adding namespace support to SELinux, and the work has now progressed
> to the point where a serious discussion on the API is warranted.  For
> those of you are unfamiliar with the details or Stephen's patchset, or
> simply need a refresher, he has some excellent documentation in his
> work-in-progress repo:
>
> * https://github.com/stephensmalley/selinuxns
>
> Stephen also gave a (pre-recorded) presentation at LSS-NA this year
> about SELinux namespacing, you can watch the presentation here:
>
> * https://www.youtube.com/watch?v=AwzGCOwxLoM
>
> In the past you've heard me state, rather firmly at times, that I
> believe namespacing at the LSM framework layer to be a mistake,
> although if there is something that can be done to help facilitate the
> namespacing of individual LSMs at the framework layer, I would be
> supportive of that.  I think that a single LSM namespace API, similar
> to our recently added LSM syscalls, may be such a thing, so I'd like
> us to have a discussion to see if we all agree on that, and if so,
> what such an API might look like.
>
> At LSS-NA this year, John Johansen and I had a brief discussion where
> he suggested a single LSM wide clone*(2) flag that individual LSM's
> could opt into via callbacks.  John is directly CC'd on this mail, so
> I'll let him expand on this idea.
>
> While I agree with John that a fs based API is problematic (see all of
> our discussions around the LSM syscalls), I'm concerned that a single
> clone*(2) flag will significantly limit our flexibility around how
> individual LSMs are namespaced, something I don't want to see happen.
> This makes me wonder about the potential for expanding
> lsm_set_self_attr(2) to support a new LSM attribute that would support
> a namespace "unshare" operation, e.g. LSM_ATTR_UNSHARE.  This would
> provide a single LSM framework API for an unshare operation while also
> providing a mechanism to pass LSM specific via the lsm_ctx struct if
> needed.  Just as we do with the other LSM_ATTR_* flags today,
> individual LSMs can opt-in to the API fairly easily by providing a
> setselfattr() LSM callback.
>
> Thoughts?

The advantage of a clone flag is that the operation is atomic with
the other namespace flag based behaviors. Having a two step process

	clone(); lsm_set_self_attr(); - or -
	lsm_set_self_attr(); clone();

is going to lead to cases where neither order really works correctly.

On the other hand, it's better to have a mechanism with a few drawbacks
than nothing at all. I think it could be workable.

