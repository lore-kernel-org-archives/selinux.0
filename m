Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7A157480
	for <selinux@vger.kernel.org>; Fri,  3 May 2024 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754520; cv=none; b=kZHykwtPwN4boNFx20THan8io5Bal32WA2+JLF4Wzf9gP0t0VLyAyM+9IO+vUte2+dcnmWSYvfDUF5rw2HzItUDgAi52PIq+pe5EmfzUpgJSkhrdZ0rkXrwNcsOGDkP+6Y9qsVJdvmwgZzi9OumBJk/KWA2NQKieYBZnwEivZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754520; c=relaxed/simple;
	bh=VYjBXXMBApPcl0cqzZQVwBrgLkcTHw+J9dEIwXz+nA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArE2D8wWihbDMFjwXvKV5stvB0ivAeVkpT6VYXp/POR2gQDwunyJRzuzuA4Iw9/78E/mhgnHdUelK2eyLcKA/GkAkXnhSqEQRfu9zlSZbeewy8E9ZWuWcpPExIbHsscGkU7MvBOBhFoOuSNtpL6OQn1j8cJnbmYVyOBRVU8KH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qhju/WeK; arc=none smtp.client-ip=66.163.184.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qhju/WeK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1714754512; bh=zD9tsz1NnfEzyHia9o6fF5mGiwIsbCvABxP7MKxZeGg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qhju/WeKI00ddW8Kni4MDHOkzKo+K/wmDH0+07NVk5HYytZRGzmxd3V0/9XcRmYyv60UpfvePpvhbEJR8kPOVOXlDltyuk7yFoQSe4fepuKZi2Ix6CIr4EZwk57RTuoufLyLsN5hXm4QC5UlCQdfQ2dxkarEXVuW2d6sKijpFOcnZOrb1wlDcWFYU7brTPBe7YkbQqTv7XkJxRJMFZz/LmJniOVHw5Unhtcxjtev7FW9EnccViuaWviaaXnKwX60uArp/3TVwRLdEaAWpF3tRv9HdiuGPdLl5R1aCoiDfv4WwoLZJSdxNnQBGUu+etYdatsSmssjG9iuYTCGOJLxYQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1714754512; bh=4VB1D/RvcDYwht1T97qPE/cdGt4Sx68a2TibwiDWWZx=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tjE4aBDFINfO+iDAzpnrqF18f5xwBH3+aoe5arQtEICDkDC26p7r1tTo3VtnsxkhYcHMnOd5/mWjXgDQUt9uCCd6SZ6LSW8ifewLud4x7CDom2PiY54IiUles+m4yiQ3EanTrvUjRmvXPN/Yq1ka17yKp3HRFZTEj72GczguKcDVxrBQyb5ncdQq5cdS509XM9pvn1M600uVkQJsY7L1wz0Hvt15/0hhL31NNpNR/Lqd/KDZ130SBiqe8rAvmGYPojClrSD50PuqGxqHjDdmkN0qqP8K5z0UVzDP4qUedUmQXLnrlHciI8BJz3OkjlVCDgq2sMsg3eEssyse62h/SQ==
X-YMail-OSG: trJ6hPIVM1lHtbcO3HChc6fAU5qwDQ0NG9qze7K4tBS_vRp_9HuxG6ynuV5GloM
 qVS2ry.M1mYEHX0r.Tuz.9JIFzlx8D2OrN11jom6Fg7wugEwJH2KCqVnkGVGkPhal1SdOIcOxkn9
 Wm0iEy4KaZN4YPrzX5ikHfn5dVTlN2cXMflYRag1_XULiDRntCbKkLp.Oazoo4kmsY.nq7FHAuqv
 kSXUSpe08VkTturjcri.6.UP6sYrTy4FwCo6AzaUVTq3JWMaBkl7O2NpBzYm3BJZFkM04q4.K5tg
 N3nhWiC7HOxEGe1LQuZcq5wYJy9BgNqBwf6BNYvuprLaTCqczvQRkDmiQGe.9RORM0novOIVVP7m
 wI2JBKcFzoT_RHfVgMRtu0TfOAu_DsIYh9C2ZJhk1IUUJwgKoXPLLsPLgZSmzih0MTTX9glGy7CN
 1mpTtgbIm9hO6lcxucwV4voK1gwshTwH.RbPBdbhl8fXK23ENyuXCXqXBAAgMUIU6FOlE.Ze7iaq
 D3SwFjs9K0YLXRFHHnP2.S7Jk_oLpYmnVbzTC3JC.FYnp1vbO8hnCZO6fQacM72z7fpGjPMKWzvO
 pyUskqDkePs4ljF5cZFU2RMxIkzz6Xl2YjIuZKO_ax.dRSzhM5bCscDZipiqFwZFjQ9Yg_B3ICuy
 AFAmK1ShUf0amSH82zBsFRiHX2HnoBZz.c24UGi16XB_Gr2Slp_lHU_dTjc0G8E0oKyylqttuh7U
 bYGQmvYj8n90RziFdl.JMSMxP5gXVtxVafoSd_nLpbnDln_rO0A12dV9QW4nkbfFI9fY6TQqFm2A
 qozg7aAMf9.cm.0EOffO4Lh8gjClWaEPIiGUrOFcAyg578qnv5ZokYap68A83ggRa7toJeGn8Wwd
 HOdwIxNFUppwasRgtHrvM2A7Tbk6zWk94Ik.RSMe8baEZm7ksOnzycUbCVFKpIoc3gKTCpH_lHtO
 W18JDdzOlDrFsQjQn611hf6krHt7MGALGQ2vLrfyobRyabnmzhBJUCgVuTfT27dwqeDrt0R5Jz07
 s8AJGV178hXYTWXZCNtqXZOtwrdEECeaF6su3Ist8XGhga3UhMkW3U1LBh0JsLtG0DKgN51QltHG
 crvegW1QE.UdWeKqbEh0ywMxP6AOq6t4nLMB6VXOAqouctIDNEOrXCDqhBir0Po1mFDK5FzidcdI
 oGnCzYrtj6B3RKvqgGFDhLvjH2ChHz3l78ZQ8S6Y5tQSIpkGi8tA8sb90BC9pl_QsDAtDat.xBTL
 1TnOiYGt1r7ribMec6OtnVbTB9jnRkcLE5xQvcbw3y8AymkQ9qhjaYKsv382bBry465.Fh1sOLJN
 I_4S_nnfgyHGDQtvwdmq19ATLq2pTDo.._x1iqMk43f6AHNvkXeDFdd2ybw1izhgd9hr6vAkPkpT
 RDWqYUQXlUiDt.fEF2XTxuC32GABT.qbVi6ujIKOtSwj02Os8bnccmDoTkuZKNy_a30c7ieJsZBk
 PEivAgIQy5_hNGsUfDIPM8EuLRkuhOBj42X8QyecO7ldTDkLXyklvf3V0sZgQgRcSvFU4v8khOCf
 jLeGNPoG99lVMzoHCfRCBqeWsPlb6rg8SkFcYQabheZvw0MRSAqPi7j0i5PAV.WNJq5xNNMTTTtv
 gQKNq5RKXkSpKiHWhHIyJWHHRV01iVwCp1xaRL9glWDHRkiE_guIUr49dfRwzc53yYmqH0JU8isc
 F8t4.nA9oEKx_Q_nbnP9SSbMtpXSYQhSmd99r3QjifmbvViKso3j6oFw58.iYHixGU.TWle.GFWr
 7FfUWbfHF_9Cya..zh_.tVXBTe3VNJUmMyz5LvtJWgZeXgPBUUsbZ5Dd1Ccl1PwncX7MdDOCAr2H
 1TruQP5uw4ERlJfrpv_GVaZPK7ynaIumAPzI3Gn71A5Hnw3O9uV3xfxPgzjXzZ0MYj47zkdf5DgF
 meDf5Cfl0f4tjHP7ya75qv6YL5a6ajN2xYQAxk2Su3a_nIDa8BjsSZpT7ia7jl18X1OSBlRzYsgy
 BN_2_yjWR30cnfAlwDpNQlR8sXr6.ht0TuXik_F9g1g_jj88cutShSmqTjUF4OCSOvyDks_z8SVc
 xZbJM4FtYZJwXHwBtYII8pfWFvaoFvtS8MlkYx.luyQi5SAs15WOA1uf3fetn5MALalSAlGaHugR
 tCo_EmL5EctaCV7HYSZLZB0Nan2d_Spf7TNWuh9DCIKxjeE55myJhWhSzC_s6nIhBUFwHMhDRzgs
 UmahUsjACvg1.1_ANzXBOLkvZl2EQXY3nNldsmBpbYVB414uTiEevkfyJjsKvr01H2sVI5Obbogr
 eQsbxYW6lx43vJS4Vs2M_Rz6lMQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 795d5e57-7b76-43b7-a737-82ee981f36d9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Fri, 3 May 2024 16:41:52 +0000
Received: by hermes--production-gq1-59c575df44-zhcxz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84f5c52a964e238d162837c8de9e3480;
          Fri, 03 May 2024 16:41:46 +0000 (UTC)
Message-ID: <d5c467aa-9458-42f9-b89b-b6e883a1c715@schaufler-ca.com>
Date: Fri, 3 May 2024 09:41:44 -0700
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
 <18c63d96-d574-4ce2-8fd3-7755d2da6c74@schaufler-ca.com>
 <CAHC9VhQcUrxxejcJP9m5SwyN8D=Y0rOiF7=w6SQR4=fF=nBNDw@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQcUrxxejcJP9m5SwyN8D=Y0rOiF7=w6SQR4=fF=nBNDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22256 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/3/2024 9:26 AM, Paul Moore wrote:
> On Fri, May 3, 2024 at 11:51 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 5/3/2024 8:36 AM, Paul Moore wrote:
>>> On Fri, May 3, 2024 at 11:26 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 5/2/2024 5:58 PM, Paul Moore wrote:
>>>>> The current security_inode_setxattr() and security_inode_removexattr()
>>>>> hooks rely on individual LSMs to either call into the associated
>>>>> capability hooks (cap_inode_setxattr() or cap_inode_removexattr()), or
>>>>> return a magic value of 1 to indicate that the LSM layer itself should
>>>>> perform the capability checks.  Unfortunately, with the default return
>>>>> value for these LSM hooks being 0, an individual LSM hook returning a
>>>>> 1 will cause the LSM hook processing to exit early, potentially
>>>>> skipping a LSM.  Thankfully, with the exception of the BPF LSM, none
>>>>> of the LSMs which currently register inode xattr hooks should end up
>>>>> returning a value of 1, and in the BPF LSM case, with the BPF LSM hooks
>>>>> executing last there should be no real harm in stopping processing of
>>>>> the LSM hooks.  However, the reliance on the individual LSMs to either
>>>>> call the capability hooks themselves, or signal the LSM with a return
>>>>> value of 1, is fragile and relies on a specific set of LSMs being
>>>>> enabled.  This patch is an effort to resolve, or minimize, these
>>>>> issues.
>>>>>
>>>>> Before we discuss the solution,
>>>> https://lore.kernel.org/lkml/20231215221636.105680-1-casey@schaufler-ca.com/T/#mac61625dc1983d13ee5e8015fd22e1165381f079
>>>>
>>>> ... or am I missing something?
>>> Yes, that patch, as well as some of the others that have been posted,
>>> change the ordering of the access control checks, moving the LSM-based
>>> checks ahead of the capability-based checks.  The patch I'm proposing
>>> here not only preserves the current ordering, but it sticks with our
>>> access control convention of DAC-before-LSM.
>> Fair enough.
> Are you okay with the patch otherwise?  It's too late for v6.9, but if
> everyone is okay with this approach I'd like to merge this after the
> v6.10 merge window closes.

I'm not real happy with the shear size of the change, but I
don't see a better approach that meets the stated objectives.
You can add my Acked-by.

> I also need to track down the appropriate commits for the 'Fixes:'
> tag(s); I'm not entirely convinced that some of the other patches were
> targeting the proper commit ...
>
