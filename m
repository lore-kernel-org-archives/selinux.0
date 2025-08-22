Received: from sonic308-14.consmr.mail.ne1.yahoo.com (sonic308-14.consmr.mail.ne1.yahoo.com [66.163.187.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07055289367
	for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874685; cv=none; b=kXUU5b9tkeCzzuutGk7TWtOByIEnKzkdLZaan7G6OGYBl8KkD+SUpfv+MwI08wtNtEm91Zf6fsMyEOGP97TGCyTMl8Infl8CzWIBN578jz1yAINBh0G5dzt9vsz1csHaAc4aRjo9WyKciPZK13/P4Fq98VLFEmVuyRiAjNUxpM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874685; c=relaxed/simple;
	bh=0uBDp71UoYPwyOUhhl+RNtU1adNBg4dLjJdIaxsH8wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWgbBTL3+usSspgwpJdv7C9YgqTpmM4R8eNKiMkIkMz5BdVV4ma8AzJICleTzlL5RuSUUA04VBQmxnsxLi5Mrif9csYU717Ab88rPKOnyj5I4vyfQ53rULKpXswV4cjZWK/JRreGHAhSnSA2EMd90blrghJbjcr7inN7+SKvPbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=a73wdz/R; arc=none smtp.client-ip=66.163.187.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="a73wdz/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755874682; bh=jgAvmR9fLvEdFinMwbwUuyk5/7co1gaNpIW47yD8sEQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=a73wdz/RKqMAO5s1I4ud22UsQmvqUdhUA8FVYLUF3bMhXDvBbvcSGsBz7c3xyzJE4EE2Dc9UxySfbjgjSjkBEV2rq63rtf6A/1hlJ+q20NxEH0LikldGnlmQBflX7Kq7cTH9izMiszsnhTAlf+ztEYD9zET1HVHk984anir0JkBcqTnGPJ0AWnQBVMrxyVr6BqHKbZHP8YJnTS5er4sBeppWxD1d8WAFEnkXCNs0LlkbOCxQsqZDhzRiGO9cEchywf8OU5hIQVF6R3t0jnKyneUlMpoWrpUtKhYZYS5jIGzMEzTW/P4GmNLOHFWQGb+Mowi1wsSHEbTha4HRgLLq6Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755874682; bh=TUilJkWQlUWQnZy5RRaCA+nsu3jpq8/VvuBTgGyiHB5=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rtrt79MD25Ioat6YgBTMKbl46Sk5Zu1EJ+psf4irOyZ+mnjm1Gva3TF8M20mCP9XDb/hHeOtPLSPBrPOJhYYQWlluU1GQch+2uMyyXpCaVQIjyojDF6wZ1B+7d2yyPuh2nU5fnVQ0bMmqOf2Be+JqxusgAafNpB4a0UVkGI4HYzxIU8L1qmFVpoAsQzuUMF8hppKCq45qsWLFoI+Vdk4L644oZl3Q0JiIRKxdbeiM80gAOHaOvHPRFuAwLO1D5METLI9LncUHZLCMrCLBlWbAItm7c/eavEa7HMs9eH43KwBUWUFpcODYZEVftGUoaCSMMNQJI40Phzmq2w/JitJYw==
X-YMail-OSG: GbaHoxcVM1lU0.QHsTTTinSc1bQV0KtWS3Qj_v0KCstbTTUDzta70p6RqjemQVB
 iOzHT7ZDy1G_IRfm0QK1fZJe8wgceZhxNvmMN7Kcmr36B6HGFU_amuUK.4fnS1CBH5prfHKXr0iO
 5WASrITUUmdjFJo.RuMgWDi_FRXPXGAS3PfOgt1cQ3N_Fv78uKxHwVTE.30Wxl5yOOnr1QGJ07RQ
 5Nwz.PKdpekEX9VCWOy7ItNufMsljYTM0ecoq0Qf1DZR8QrG5GOrq7BqWMIjK.X4MFxEcD.9F2pL
 mGc4npjR4h63tcuFBZeOZCumpXZ1zpz2SXeMFzQW4TfB5dLW.IkExWFiaDH97xDGSoEFa.099r7R
 xJCqZRp0YjDfoivpnfCHGqBtT2llc740mNsR5VKsOxB9BYsnTSCf5m1R7HtKeXVTejav7k.gcrjR
 Nz2VNFNAEc6Gx71pzOvUsttbVHCxNJck31ozR7xB6DqGaQlXE4Y7tJqcuQXglnFaLLlJlotDp5_h
 zUgTiN2WMc0I.cuk.d02gWiAyosdlFD206PGyrW0UcIOloBo9MijBIip3YTWS51G1HfObpYufaL3
 7TNNPU6XNeGkyMhvkD5GE4O2nROviEwj0DDRNHpHPSXJGbLHVLpJb7U7EXNsvFaBYPct5MX_cimc
 lwuyF_ghZe0Ojvnf7kZ0RWjQvUmNVSC9KPrKkFcLZIUv0ExNS8QGHBybxJPFhwVCcxOGT4xwPRjY
 iNOxh5hA07RZJlC2MT3pvMe7lSR9EUtSyUZMjUrjLL7b.h5nrgabmhj0BtuxC6bs6EnENcQsf4be
 HDl55dGUeC_huF0BZQSClmBNXkUTON6gLwoBvTgY6KQn6uD7Kf37870GM08eL1isg1HxZkMSpUWC
 6i9IMdVnIjGqq9wogm4XHaUbLfPsz6WoTmsiQ4SXYXiMctO0h5SWFhkQ43bluQDvjHwPFR3O616X
 bEZThbG55qsiFK0acq7aAd.tFejqzmlegUEuHE.Gi0_kAFE5FVRlMX9pBB7mtUNh66lQAa76IZYM
 tVgt2_untc4tZbJ_9xybLG7u.FE0P8KK.m6xt2Y4cnfnz6._eyhP8i379votqMGq8HdjNruzkjI7
 chZuN5H4stHxG8uwoLieNkV9sf8twdFhU5DLRzxCX1Jk2OJ8qOiGqj7wiNjodHhKyDdf1GySWGgb
 mPWomvEtmb5_zSv7QwxvfXoB_IO5HPJanyFHcvdzcpOCJV_LZ8BujrFk5VjudJLrFuWZl9Njy.PR
 T1nggKMi11rEasPKo4JMFcke63SCkdqL0aaStFJA7RKJJ7RVUfSWZrAt4LyQT495U2nmC2dqOYpc
 uBHz9pevlBIy.33QyDxIq2S3_QR11.vscf.3tG3.kKLTzpvy8HA26mqza5Bodjzp6Gb09cZ9FXL_
 NwkprninSzGqkm895Yadow8nr0i_VfMIujDEDAHrhCpsXSWItOKcnapXNgm_8nXHFeXuongRvcnu
 KpZHIc3hHD66rgjLzx9yRwaz.VAIJHppwqYWEGT4ybkoWLLTUX5uD7mhtrqml_6Y13AGeSR41EP6
 UVFHp4VBQJr6mSpJ3ZOMhJ105Nrm7I6vkkx3A8.UYAqX4zZ9IYqLdrMD4QhkO3k72gzLGxe691qB
 mv56KTU2TWUEfU9NGcvECuxVR94T4oQqTS8QmT010sx_Lye_2SQEBavk3OX8Y_dh5KQgIPpBfH2o
 wnhXR8RAKPUukQ_9UwSwCfHwFlE5Watu6Sk57YVdTAapoUiBkX7RVw0SkD.B_BgW46GVxiyn5d5Y
 K._hjST2amMkg66cka4fSHz3nqmJoz4UUvIteCEUX5qYB478gCM2yDd5ACvOs7xk6HWQT.Xv0gcw
 FIxRBkpjOLfEDJ5hxHu9VBdMP.lUAHrOi5HfyXf3en5k5juIGuZmtPNHIQdgbKM5lQOQjRV6Rbbb
 r1hXn_InBH3u5EaQpCX43NbseO7Rv1D08eBRxgl_mCPwOGVSfwrvj_him.2bgTx_vjSiARAKIljM
 j1PhmvsScHF9O1eaAyaSi67R1aFZHo4sWNoq3mjsHoXScAeEzfCTxWCq5i6Po2eN03pEovjM1ZJt
 zl.Ndx2brUpQL3maF5nqzKy.EmusP.nSWOxeBd5mYzy5OOQ2wNhkjPgXeC5N9cpc2mu3vLf1u0cc
 Rl.RsrCSCOoyo9YRfXbH5wqkR_ft36zVk13pEeN6KQ.c9fAgDjPlIlvSujEt3lfkEyeX4y4askfh
 ggDR1AgFuLpnG8_eSMwGYgOMmM.epMiACyJ1YOA9_n7pgzN.cAlbjgxixeECaP_pKxRxVWRI3yaX
 nNwlFMlbM.LfSOf8tOA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 77d36f34-8c9e-401b-8a86-cf22f9007e46
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 22 Aug 2025 14:58:02 +0000
Received: by hermes--production-gq1-74d64bb7d7-bcggp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cd81e3fa79d1c28c8db669a0b7f10f5c;
          Fri, 22 Aug 2025 14:47:54 +0000 (UTC)
Message-ID: <5612ec76-9257-402b-ac98-bdc8a8287a60@schaufler-ca.com>
Date: Fri, 22 Aug 2025 07:47:51 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: Paul Moore <paul@paul-moore.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 John Johansen <john.johansen@canonical.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com>
 <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
 <20250820.xo0hee4Zeeyu@digikod.net>
 <CAHC9VhSS1K0Zsq_ULP4sK9Okwthd+CO3vUdVPAf+F8FKfZsVqQ@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSS1K0Zsq_ULP4sK9Okwthd+CO3vUdVPAf+F8FKfZsVqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24362 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/21/2025 7:14 PM, Paul Moore wrote:
> On Thu, Aug 21, 2025 at 6:00 AM Mickaël Salaün <mic@digikod.net> wrote:
>> On Tue, Aug 19, 2025 at 02:40:52PM -0400, Paul Moore wrote:
>>> On Tue, Aug 19, 2025 at 1:11 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> The advantage of a clone flag is that the operation is atomic with
>>>> the other namespace flag based behaviors. Having a two step process
>>>>
>>>>         clone(); lsm_set_self_attr(); - or -
>>>>         lsm_set_self_attr(); clone();
>>>>
>>>> is going to lead to cases where neither order really works correctly.
>>> I was envisioning something that works similarly to LSM_ATTR_EXEC
>>> where the unshare isn't immediate, but rather happens at a future
>>> event.  With LSM_ATTR_EXEC it happens at the next exec*(), with
>>> LSM_ATTR_UNSHARE I imagine it would happen at the next clone*().
>> The next unshare(2) would make more sense to me.
> That's definitely something to discuss.  I've been fairly loose on
> that in the discussion thus far, but as things are starting to settle
> on the lsm_set_self_attr(2) approach as one API, we should start to
> clarify that.
>
>> This deferred operation could be requested with a flag in
>> lsm_config_system_policy(2) instead:
>> https://lore.kernel.org/r/20250709080220.110947-1-maxime.belair@canonical.com
> I want to keep the policy syscall work separate from the LSM namespace
> discussion as we don't want to require a policy load operation to
> create a new LSM namespace.  I think it's probably okay if the policy
> syscall work were to be namespace aware so that an orchestrator could
> load a LSM policy into a LSM namespace other than it's own, but that
> is still not overly dependent on what we are discussing here (yes,
> maybe it is a little, but only just so).

Policy load and namespace manipulation *must* be kept separate. Smack
requires the ability to "load policy" at any time. Smack allows a process
to add "policy" to further restrict its own access, and does not require
a namespace change. There has been an implementation of namespaces for
Smack, but the developers disappeared quietly and sadly no one picked it
up. Introducing a requirement that LSMs support namespaces in order to
load policy beyond system initialization is a non-starter.

