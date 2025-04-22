Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6725224229
	for <selinux@vger.kernel.org>; Tue, 22 Apr 2025 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347044; cv=none; b=InIMud4lVYqj1IN+JrMVkKMOK7mUV0YKMWQHKViBo+XXxQGt0Z5jIzClDCe/AFUXyyOTsaHHFoq2RNcFwUeN2tcI2DGWysiLyWUFcDQk/CPZXoaa+T42Irt4BBN4XpK/+I6tTrmiuqDEm78rmFdVsClxQLc3lnMqdCmJV/Tab3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347044; c=relaxed/simple;
	bh=+rzrHo869x8h7N8YuwICP1XfwIGYhn3g8bbf8gyWPf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rg830cjgRFMNqUFFYWdlOHqbMFERPIUKoMtRD8nxFDAIvVCht56HlkvZshFBpt5IG9PoMfJVsqFYHtLdIb3rtCSuLYqFirYBWyrqe5xcQbSOwX4ygcfpOWJ8GcaNfreeO6/kuyOjhYkgw2e8KdY4To0xEbi4gyp9IZU/Q7vHA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=UqqG5GUt; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UqqG5GUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1745347041; bh=09HDEEzLASA7b6B1bqm10pM3vJOnmxXBwZbHHCMiQBU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=UqqG5GUtgMnqrjvisrkVGTfY+itd/KhLJ8d0u43m8Ni9XEGnygN6KqA5E4F+gi0CvGpXC8lrHoNF0sGzXNtEW2VdikTFsU2NDPcs1HWMip1K1I5N1TW+B90o6oSIciQmVl9Y61Z/6EtI7oE2KMqLZTZUCCHK18f2z5I5YmQZrr2JmsnLbUSta8VsNEJNAKIcwhfIZ60qYmirEkgq9H+RlZ/A79l8fxczf1XjdWXQx4CR22Yz6qBlq1g6UFh9P/ZjiqYKZMkkcxINn5e7RO7upEU2O75IhrA0KA2qdtB6Tzl+0GAvXHJD90Uzs6RqHz9iqIM8PxdZbhAzLMlXHy6cPg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1745347041; bh=ilZvMsDeh6Fg/p6esMweNKr0/ai0lMYxhtq8bFHRYn/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OB/cRO9eQ5TnCcJ89Ud46fAFbWOq/6om4S4Wtdr4tzx80WzQkgQ6xzEDeT/fOlcVMF4axHjjv2sXaASxHpfdNK6LU4eua3bY5j3NJ5jAD4gd1+1uL2ZoA3JPFoE16dmyWJb76An77T75pIUeeU1b6YrLEebV5mipn5CDxQd/JmFSdD1THISFLA8jTCPJN/rN3+H1ymIqjioyj0sNlZSEI2M1uTKyhtPQeg60wE6ARjst4/VbPAK1pj/mLF7jnIwp9HOqo/JxReuuhJSQxtco7DmnRosqgjKWbzqd1Jd3rt9z984pdMXFhP+CvuOTBJGDRYlic+8nISRtfnaKpVAoSw==
X-YMail-OSG: iSYy6bIVM1nE6UZB9HL7WE5atHfuDFKxurn3ZdX1SewhuIJH.BYiejlKCFIGIk2
 Or2weG0_nJ2k2uBUYxvTagrXm7IKXoT7wfgHrzDmIbQ_OyNJxL0OxFBILH33g8_SCeNIs0YYmJ44
 2ugJV0us.R5ektVwb9uhRjRB5HO3ksYROPoWHtglEgrGaAZtFRMUdojiZobphsm0Xk1uwtD9TgOq
 fBWq0cS2Gq8D1GpTRJ0OSxqLG34kuaCY7K6F3VpCz3coljpY9x6TS5eyPO7qkDP3KmapyUuOqOls
 rwRdau_9v_goe72UDn_yyMkzBZrs9Gh2xF1DnYVXUDAvLvgAPXxZqO4oxMc3wynD5Oj40HL6edQ_
 5MH0qn_w07wUmyOsbsSETnGr6ETBCeUS5M9dSirXZXXvDo6.x324ddKEGVIwjsF.Xf1bR_4srmLE
 d2MAk1W87hb0tIbmnKNl7snSahzFX4TstjDEwJu30hn9kHZ6pB9UWgeWPQvtvwtdnlIl7d5nH9Tv
 kpR.UAQeFeUWCE9jdXz_pJJGYAFLLiLgjw2hhRACwdTgae7OfIB0cp.7ZBJHuVQC2qUp3DRAjK4c
 zx2kLk5dquD3sIe1nr4ZO_SImkgLW71bld1EaGlzMyK65v4jzEd5sWWcMnYTW1jZxo2QanPPtNO8
 SRj_gEvloV.z6OrA_b67WN_zigGPbJeW8XX0FvtJSzOoo3sG0L.U80MpR6hVSFMHtspUzfgsX0hF
 JQjaePaEu6ZF4cPocjlXRCy5nFmN4csEDnqzS5qh1uku8EShJT7_DMf8elEMr6SSlqZvCgHf1MvH
 xdouUfdOvWfpm3YNKr5U8w_3BS2k4oGEOpYHKpJ4Q95oPHV3zaGUzJdjUomikydw7m2rfS3VEy0v
 e8.6YtUMF0fBLzspvlIwy4btnl.Diu0JSVeRJYP8v8eYfz.oc2sf1Fdv8gnO2TnH6IwXsC7ReiJS
 o0oivP9BI_9IqO5EOv8qwUyVtO52mOBY9OD7.YyyBhDDS76oj52eQUtf0xeQLevvXYUyFabP7Bmo
 L.aGYnYn0nBYXvekP.ief0cqNraijTa3v9KkYvw0lzZ1pH25V_RO2f4loxxLqhGcqzOCV6AUZwbK
 0nMHbVZ8s6kc._qlJzA3WO776ECNzVBiwl9z_5R3puHOj9urzqydBqN7R1U09ZP1wnHXaLxRVZIk
 rO4C1TFeJyNcbqkCoX9.CO.W80bIT5E.TRIP35Jv098fGRZ6nIJInlAryUnK.3M0ZWsCpeLnHVMW
 VOL4cR.xFKpfiOzIVGpSlhfAwPt6dxiSEcF_ksWG6vyZykN662_aI.cjSRPKanodrQ9wm..T493q
 lKn97tdXL2NMBHlpRwyRfcz9I9jJeuGVWn5o8D92UHuWqQQK_dpR1MdfxKrsWqZUbpS2gdoz_f5P
 AZTBIzPvmBAt8wrl51gd9UwMLEMKkMUQqYpudKXEugId07NsLx4c3vAqF7t5TfFpSNV32TyMG.uc
 uZ0SGzlDMCvrByUGLjSL6zAjU_GuO3vKcuOULRU29Nc.bDTX8y9boUlfoKQ.4FMMYactFVXJi4bT
 BAvZRJFbodMk8x2zNZnr_8KTPaxm5X.xxeq1ypJVx5tlynhwHgzXLtcyxyplozuptEE3BidfOjbH
 lDCAuftOctQN_bEfDOwoQ7_z3mfliUmkWGW5xTdLMmnlIuH4HdxPwdPHFXnuCGa7GSscRdozzl48
 2wg3JGW2OJAcKpstBOHF1wZa1iyXfbmD4lq8YBh5uRPbDjpgfzc7y1qa33IzI4lSxSkrHDMsdXrL
 S24pcqZdDq7OEphOnoD2cCli1IgXs00_ppQEJpswP3utciZr38wNrr96ad9oL90jqiAwIHCg1it3
 XOJtVbfoNW61NgDn6w3XJItpxBRFGPDr.BSVVHDaI_Gs1dKV0_ErnbSz5mpLJVMF.36p7l05hn_.
 caWMnCOlW_rHZtcTQxDyCUQoVedFr_T46OClPfjeE2u6oXCI.0_9PU5gi62tX_pZnPvsuPZ__9c3
 hU2XfuJK7BLJLlyErnkvyb.PJ1CTxG6y8JjTPwG1z06tCXroquDAUrDI_vJLwZrC6REM.dBg7.Qo
 SeXGlfW.oMPzi_No6UOy4JGE21sdWWzOuKBe96_KfvcXMWv0PALB4hwRFa.yjSY85b6xb9BVl8OQ
 XuDItuWSMr0rLf7D78EhdJNLsx_.iKO4QxrCHr7K13BYquRDAIpeuBDZ6IjI61FTDN3lXZOq9im5
 Ej5n1jdOnudYqUKdB3e0P04XfzFVnqifRGSMrhwz9VAC6kaDpQ5raVJ86hRMcZYznOA6O7JnAgGK
 dtC2B1_Nk.nLI
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: aa5b9e5c-3c56-4e20-a5dd-49cd5df49c68
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 22 Apr 2025 18:37:21 +0000
Received: by hermes--production-gq1-74d64bb7d7-cskn8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 280c9d524fc6eeb3aa9b0311bebbfba6;
          Tue, 22 Apr 2025 18:06:53 +0000 (UTC)
Message-ID: <2afda875-867a-42f0-a454-00d42b62254c@schaufler-ca.com>
Date: Tue, 22 Apr 2025 11:06:54 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ls from coreutils 9.6 doesn't show labels of some files
To: Rahul Sandhu <nvraxn@gmail.com>, paul@paul-moore.com
Cc: omosnace@redhat.com, selinux@vger.kernel.org,
 stephen.smalley.work@gmail.com, Casey Schaufler <casey@schaufler-ca.com>
References: <D9DB7KSD01JE.1LSPBCYV65C6Y@gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <D9DB7KSD01JE.1LSPBCYV65C6Y@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23737 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/22/2025 9:31 AM, Rahul Sandhu wrote:
> Hey,
>
>> I can't think of a good reason why we would ever want the *listxattr()
>> syscalls to not provide security.selinux,

If you're using Smack instead of SELinux as an LSM you want to see
security.SMACK64, not security.selinux. Returning a value for security.selinux
makes no sense in this case.

>>  if there is an individual
>> filesystem that is different/broken in this regard it should be
>> treated as a BUG and fixed.
> I've spoken to coreutils upstream[1], and they also seem to see this as
> something which should be fixed in the kernel too[2][3], and appear to
> want a soloution in the kernel rather than working around it in ls(1).
>
> Thanks,
> Rahul
>
> [1] https://lists.gnu.org/archive/html/bug-coreutils/2025-04/msg00011.html
> [2] https://lists.gnu.org/archive/html/bug-coreutils/2025-04/msg00025.html
> [3] https://lists.gnu.org/archive/html/bug-coreutils/2025-04/msg00031.html
>
