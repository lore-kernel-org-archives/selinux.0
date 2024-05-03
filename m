Received: from sonic302-27.consmr.mail.ne1.yahoo.com (sonic302-27.consmr.mail.ne1.yahoo.com [66.163.186.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A315444D
	for <selinux@vger.kernel.org>; Fri,  3 May 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751495; cv=none; b=UpKbsV0znyDrSAAuTmxHTTMXt1HQ6uAoOwz7vfyURNXYP4kjzVURFPEno4sG6FqNTfLofUMq5/ukbJce7Sf1KbelraWXLawqy6nHOGASRJHpPEOyx0oBOl0YBnAY8BevHCQbWLqCTMcRpVie2hDSrkcr++YALz4Sw6a+j8ql+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751495; c=relaxed/simple;
	bh=U94f7v1W0y3zR9WcHLqwDXvE42ydImaJE8IdAFwbzpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCj6B9WxvZ6EDubTlvdooSH/Ui7uwoefb2t3uAlEh98j1WfrrF6gTRD+oQRpBaqHU/3GKgVkNVg96o9KFa7PcwoidIBQLbIOCk2SgUz5xqfKC6TYCeWcD7RBYW78K6u/kwCSYL63pabMndAjWIg8Oh1Ye4jI1ZF/3zD+YwK1JBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=NqR/ewZc; arc=none smtp.client-ip=66.163.186.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NqR/ewZc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1714751487; bh=AalrBo8Vh0rTwISME4HEiXE+turnqO+9OH7THqX9pAE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=NqR/ewZc9+uA7d+kM4PW118R7FGBLIYXTMFFwhAzDQTvne9Logr2Y/Y8PNhne2TqD3Xx+Bua0iwJxUZO95yJ78vX0Rmg0BtU3TykiiPwFTWZmW2NgfacUKcg9o2FUXkrHpn0okdylod15Fl19DKHzLLt7S1cCp3qBG16gBgFbG4DUk9oqhfZBahJXWEhgIzbv7s0pZ4WPUHy7ijxWLKWL6XfI6813zmU3YlPQifsF4tPrDe0i2JqJb1HZIU+/eE5iINHz7xY3v72ky0/45CLwesZwydy5m3vdg+Eh6n+scjlZ4mtHmRtV2YcAVoYC4vpRjL7f3Jsco1Z4q1qqR8Ilg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1714751487; bh=wr8zOi+yzcOO18KYfixr89+xoVUF/FVEwu8eyDwcjSQ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=G2E+0J8Y9Zt9DJ2czYIEU1rRtIJzhSHVJrBHreCAL2H/s6sf6vKX6jejpmiG9aJqDgb6QanFYapUtSZW95DcCEIkrPUTUaMtQeJgZHlJ4ecG6Z4zlFifN8+vhhAiOX+eLKrZml8w8+HE7gx5YXeNhQwo0tPndPq66YBHFW3sIwNsh98hP8I/f1SwtUyYXDr9yHML9Zpe4HRcZj5C6LZj47plnjPWPMEcTWbUwBS794i9eeW1Qs12RhmC8PDGlx1maVEa6npnuB+iGiVek1faZr20UPxUGAkNoKs7xdjB2MA05VDNZB9VqaBEUUVQ5ow5Kq8oaKFvPbNTlgobajOiVg==
X-YMail-OSG: yc6uZM0VM1nPQQifn7_4fajCCD5caViUJU0I8r1ONWLr91sC50k59ZRahXJl8Tq
 JWC3KYIOnRsdSR8qVpvgP.L611w9AoVrqJ6WDQ2VsoimpJ.uFAsFMOE.XPmgcZpcc1OHoyUVcqUY
 k5z6vtdN.vDfly42ILMHqUnVjmc3nWgkWFDw8oOoAijD5QC.ch1n8vea2puHz2GmMGPJeyGbTiH8
 xkAa3Y_ulelEeDwrHjkvcEm0cpzAw7gArR5.q_Xl_SKzBdmsn3i_1TOTafdlEx2I8RsKcoCvqxqx
 HvPMop_IS_7G6hCbcMhd4_BekrscyeQTElPaMdtAqmE_YPIcmJTTaaxvIEX_fHOefME0m9F0vnE5
 LLJJ04GoGISdMeKSXtFu96VvFATfRveFaOuDHMtOuQHuE1ejYFSpsYLlwRhOwfjvaDK7atkAYRcc
 nibHsPB8YuotUDYu3Ivp7R6jKT5G06vdtqadxxmodKlF9j6twGPKVi1LxkiHH.3oQPFSdOfPLXLq
 H_yRJmWGqkMaNrb8V6leQN91BpfNMvCAEaNxM.AgboCKoyFVO4g4hMCXPh34axoz8vdHFHtr5yAB
 EQY244dElqVvMAcF.b47n3SDdAWDW19.V_re9CY0E3AjOkYVDb1tsz535CbFD0.faFD5zDP7oDH0
 5SoS1Yx09aYqJl2AR71tEqtUklVJk6PyzGlGFychC0_WYmkjtcJzM8U8bHJQ2.Xwl6QdOlaG7Iya
 QPnbvbRO1Fbb6e4vIef9qnYkB_IxC_DnBEk0D4h4cp_PdfjmGMuio.ZC3ehvZXCEatfQBtL30gwK
 tunM9ugoyaa692uQU9r9hYOmAXNqkf.ZBWbRI8FlAO2pvubdpqXG.eEthgUW4Hye1JblPfvkO7ji
 4XBQfvQ3RZx6rx03emhuwxzFeaTj3Fpc5SgfHOzC7z.e3vLOBoTIupMeNmYEEulrJVgZXrZ_4mJB
 mZjVr5YqnV7Gk_zIdc.8NMTnbTBuRQTSm4tP1NIKjLzRlRaugACZCqHGzIlpP4W0gxMGgfR6yUY0
 Ohw.MBTO_qMIBEiBuYWrC6.fJPJrqCA0vNlSiNydGnmwrHZkVDwgoGLtt1Bpf3PhioVsgBM0bmqu
 XvNgp946vfEUqZMshT1IdtmvoDY1AiZaztep4ysy_6kLPotQP1FxhAYBzqm_4l1gCAXOEVnHcl_L
 VpLhQ9px6juMMIlkY9VbnZIrwFO_u1fiHPcB4rEEaUWBZfcrsZy1y3tPpK0xP1V2gzIhxaPBz2NP
 7hmFwC1OqUFGrTY_o8GSOMd9J0AyeS7.BhycS9FQ3u78W7NC5PtOqY5TTsybGpf1oRLGldR50Zp0
 BHBR7r2hw7S_bf0PkIu1qZrlcmbwg1EbPLN2zELnphNlngohCUNCNBE.mq6U.f_n9RxHpj4vUpTz
 XeQknAC62uMrAzyq3LBfjykU6yPLzAWmKwlng9Nqhh.1gWj_2h_xXW5LUMMA07XyzJr97xVyZSMW
 6fagThAeLTYya.KwZnOE1KTDEl2Eg4EDRe19OslTGm.93JuZc_Y_D1cW_Z0l__ECuamX8NXaPrB1
 SezCKbkDtXrU6GqfQrWlRiNUPnc4nvMDMwQzw2NK.8yGykuEfpKHIbDTmCG1__lorMMTk9VyZ0Wf
 hQvsJJo.9NKDsCp5zST6OqDimg7B6zsfoxkoiZTKz2rae3JYiL3CqR4k7KSuvtuKox42KymIevmO
 T1tg9Il4QHVOJ0Ln372QbWyPqly.wid3WCx.Ek5FIJCagGJimEC4LscPYiZqfuq3ZfQyC2wjY25B
 tgFf5RTydewpManNQwHBN0BY4tMUw3690lFo77CdBv67vBNhs47QFOvxhqDhRR0MVBcwCYUOStyH
 ryY5xVrGuQ6falM7565eOItRLbbUTHtURrQ0NKJ0zxwHjM1Zn_snHq2uBh77VVPyT0nU61v2gts3
 8dbNyaS20vF503nxFTh.WcBNQJivqp5aopm8A5cmRHGUXLsoULMk.fxkDXFHgITyVf_D9gJL0RX.
 JELK0NMeW3dkXyPRML0IdZWDApBO.ekOuxUqT6xp4H36ylKR91FCb7uw8yhGU5vwlKyO5AVytSny
 P.XrZONX.559qRMxbpB.G_te4s2FLctapaEe93rP_Y40pY460OGmqndelMTzMvQbrJqxaBM7OOc0
 FjaAgNfvoTcoFVl.O2Q64157TgG31y6I4Il4gWch.HYRSrHFC3L3RHB7Wezlu3RHxjJGe8KOiDps
 1Wtz4ueSZXQ_qcln.yjx0nMLT
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4ce86392-bb2b-4b3e-bf8a-a7c314625789
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 3 May 2024 15:51:27 +0000
Received: by hermes--production-gq1-59c575df44-s9h84 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 612facb619501f9afdec47723c008f19;
          Fri, 03 May 2024 15:51:25 +0000 (UTC)
Message-ID: <18c63d96-d574-4ce2-8fd3-7755d2da6c74@schaufler-ca.com>
Date: Fri, 3 May 2024 08:51:23 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
 Ondrej Mosnacek <omosnace@redhat.com>, Felix Fu <fuzhen5@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240503005850.466144-2-paul@paul-moore.com>
 <06dc0e21-f44b-48c0-8552-9840147facfc@schaufler-ca.com>
 <CAHC9VhQUW42aicyiMAVaSEsCR-G8E+uVZJVCXodDv8obC3V0VA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQUW42aicyiMAVaSEsCR-G8E+uVZJVCXodDv8obC3V0VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22256 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/3/2024 8:36 AM, Paul Moore wrote:
> On Fri, May 3, 2024 at 11:26 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 5/2/2024 5:58 PM, Paul Moore wrote:
>>> The current security_inode_setxattr() and security_inode_removexattr()
>>> hooks rely on individual LSMs to either call into the associated
>>> capability hooks (cap_inode_setxattr() or cap_inode_removexattr()), or
>>> return a magic value of 1 to indicate that the LSM layer itself should
>>> perform the capability checks.  Unfortunately, with the default return
>>> value for these LSM hooks being 0, an individual LSM hook returning a
>>> 1 will cause the LSM hook processing to exit early, potentially
>>> skipping a LSM.  Thankfully, with the exception of the BPF LSM, none
>>> of the LSMs which currently register inode xattr hooks should end up
>>> returning a value of 1, and in the BPF LSM case, with the BPF LSM hooks
>>> executing last there should be no real harm in stopping processing of
>>> the LSM hooks.  However, the reliance on the individual LSMs to either
>>> call the capability hooks themselves, or signal the LSM with a return
>>> value of 1, is fragile and relies on a specific set of LSMs being
>>> enabled.  This patch is an effort to resolve, or minimize, these
>>> issues.
>>>
>>> Before we discuss the solution,
>> https://lore.kernel.org/lkml/20231215221636.105680-1-casey@schaufler-ca.com/T/#mac61625dc1983d13ee5e8015fd22e1165381f079
>>
>> ... or am I missing something?
> Yes, that patch, as well as some of the others that have been posted,
> change the ordering of the access control checks, moving the LSM-based
> checks ahead of the capability-based checks.  The patch I'm proposing
> here not only preserves the current ordering, but it sticks with our
> access control convention of DAC-before-LSM.

Fair enough.

