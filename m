Received: from sonic313-14.consmr.mail.ne1.yahoo.com (sonic313-14.consmr.mail.ne1.yahoo.com [66.163.185.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C738128816
	for <selinux@vger.kernel.org>; Tue,  4 Nov 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274494; cv=none; b=Oad4gPEZGtM5zWTzRyL7Sx3dcunvJ3X08GW6y6vKUAa0Z17BXPWgMbQx1oFCgHB+OxT4i/xxGvLZCGmhhjn82yYtxc2QTvnPLHMkBuQQz/7JOGc1bPSc4Ha6GPNUG/PCb2HykYgEBoFvpPIpNBnUV9kMyDrWKbSYAqDPWIxpcHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274494; c=relaxed/simple;
	bh=2Vf4vrgcEB8HozOSD/Tnbia/8CPrjaryooAVE+duGtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfudUxFSgJDkfG1rRwLunsVufsRGXKMDkkMa/YTu9vFc3Dm1K5PGgtLT1WUljX/+Noor6RNdQgS6J2WrOvlxiF/6rbcMMiVc8gFBgoO+EmvMfJUwWHM0c1t1Ou7bzSyZFSEgKZdBIjctGvtlTpbFCIA8Nls5Di3gYRZvxe29cbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Yur66hPU; arc=none smtp.client-ip=66.163.185.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Yur66hPU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762274491; bh=/DM4fNCQVWc6fj4goDP8P4A2rMU2yXGGnT9FUEAA0Ls=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Yur66hPU5EY2F0/FN9pgYNEtCUrL0cBbxcAEJiMFdGhCow3Aoqt0NAL5g6seJaLXWlNkOSu3TbW25FVdV7q0ifgB5/ffBV7saw7SKJVJojvq3lt3zA4wkTz41eQR3iQXYTZgii7fOWmftAwp4nhRt4nhEHDm/8zEmp8uBUMn81hL4YndwG30+esnJ7ZtDRmYDuWdU0DPlr0Xi1hhzeL5p+RvR3XA7s7Wx5sn3oN4eJb4jLlNEClsyBUoL7V60X9aAIYQCiNK9rKzqZpzyjCPrxbapAczDamnRbnLKM6D5igAv/wzalLJPLgWFbfdjakX45neXtyniCrLKlTR7+it4w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762274491; bh=768KR83JNKaLF2asu/rPSNtbwh+O0LB4Ha4affH58e3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HKZiTdXvwNye3vbzKLsV2yc4GLQQskVaNN/Q8UPM6LVYojb7TJKMpNzfZGdRjoYqqG25eRUMeANzO80RU7uREDZLBfzGQ2jD4Vt2eEq3Ju60eSaHQNFBosdnfGvdKCOvU7lsQPODMv20ob9KJag03Mmv2zcCuw1JcMtVDTV0WHvpy28gzULo9VfdHkoxqgBW+IgxbzNCikasIgLZoIjTVNOAXatYuInLg9QDm0JxcboKl889+y//bpVauYAt/6+zSgBEtCxYp4PUKEO5qI7G+nSym7oH99JPBJYUhyskxvljEffmQNbcn0vNMMOoqWvelNL2IWGOKJRBSF9eXB00jA==
X-YMail-OSG: gm1VRt4VM1lcRj8weC7wjhvOk4m2ADIMoG__fzfhzpvqVBLF5Wb7OY9iLb3xumZ
 KwDmbl4BFhAlG1.AvE0oz6pzCBQ.Ar2IFGmiEA4270fK9N..LBnVij3Lnuvvx207fVc8iKLK3LaE
 Rtb9Saseuvom1nhopO1JYu3JytQ0WdJJogEUF_Lp249mgybwDYgRUhR7LzVSSwEuQxXRT7ydo6Gp
 oVgtzrer4YCP9xrjJdTGvfa01Vltx_NjrlfhjOJD1oFWPw1raOKbwYE4fdrK4AhBz1DeEBXHzK9q
 CViS43COe2JczokyG5S.8LwohU13_gHK7LQg0IA57ETCAy.T2NvIIFwIaWJI2aL3bR9.H3NfVhNN
 RsqMZvjqLec5NdBJDj7OhfbCiTHCTdgYwkVE5SYMzwenZNEp5vo7SNImLcVAQIsyFjTYFSaWM30n
 e9pe8OLx_EC95QlLqjbxWiRoLm0jEDCYowUq3RbrfX0DSH5zdu3EDdn9.rZ77O6Fpxx3Aq7tRaNd
 Jlv.HZ5gKIEijpF_.vIPb3XxRYlym.xM1NBTj4.i9EgTYEO23L898_Ks70P70bjM2eEQ_uIhrref
 xWRPBBHh0C5u.aBF8nUf93LHW8QkmR_m6KHAjKD5m48UuVF8jAoC2dZ0yYRjOp6g_6QT_OpCEEwy
 FoWeYClTsQyqheQxAk.RS7zX24A1sly_1257pie7D4UVlYH5EnjzBTVlrNutxbXirGoLI8R76ICJ
 WHqnEWBgdnfmZfs4QRJck2r0b4_ShEgxTmnrwPyL55pCfcc3jD1_LktbvBzmkM0ZvzNWMm45M0vX
 TCkzEINoH0MLwi65Zo950I1KlNCkXIs.bZ57TiDnxUB2yAIV1UvRhRdYF0jamEIFXpfKqjomt4vt
 GEFPH8uCXWm5V4lV9Dj1fxyLodlb6jU3ecgA5ePWGRw2FX0dWpfEe_mDfD6aq6nEeMVa_CRXF6S4
 tRxSzJJCWwuK9tvODWmATk3EW54nFNmOy2jEbCULWoK_6_8wC44f5pbpFDA2CDqHt1.sAiV3aMZ9
 OV_ankuzAxoM.oRK6CVJiIuApWoMBGlxROKUMSlapqF9UIT07RtUCXITwpipUt6AjbNo5YtIjUzI
 htdXngloeJMVNwhU8aEGD8L0rR0zjdsb_9e2uvORs22Ven2DlUo_8_7pNJTMMOpv_eVxTn3vqE9A
 8dSybDNlvtlUHv.6ksvVcYks90vRVB4YFQG0PMRiNg.5TmahIkur32yhAJ6Dm5imdOqsO7_Bd.QC
 d8x80Iw0NEXIyxU0mUKcRuWqAGGSJnAS9E_TxELvAMJ0ENgd9_BtTuq8VMr91rz_zgoGOfsjKHf5
 f2sNupmUoGTd5n68txPCZ6M_t.9OiotYoLHy7zlcZ7K_JzSSQebei4h_6ZsUzxLmUBrbRic8Ly8l
 ZUCxeyDcQ7Toi8pHR.WUr.vBpQrRufS6Vx2V1rJYDglqjAf4a7rzkSvBE7vPo.mNlIqhYs.Uf.VY
 Di2R12gTcImYWoejCaWYKx8kX.uJEOqCp3dkkK5rUlGkBxQKLbmyKDsN108CoWg8CFDkmr0zehOo
 1NuAq9exYaEc_VS.II38_x.77MoUxkV6bNU_jgpw_JVWpc0nusFuypi.nQbPeD0r71hb9brUrJye
 dJKq7dZSCQc_IKDUlj7PJV7s7xQCIKDK0_dSTtPxOnT35B7bGLgaOygUN3gCHYLa90NBv6OjAWLJ
 20QZ9yT4317RrAjcomWFCXCgcW3StroOdY4AbTOlvvYNnw2ek5HSO1eRa6kgcWrcZ2Uq1ZnjY2xt
 CYR_phIzJ09ZHHi8.ulEZ6Yuemm5b.HrkuvoWF986KllOwYMVdclIHrZbb85Pfu8qbNN1IwLkGnw
 QC8OaDnWTqi89IkpcUXNZt82ZKZI7gsIi48WmOyCk2nEsG3O4MtpPvTIwK2ykuC5rJB57lWww24v
 QIVrTg75Yhl9f2B1sRpreZpAKd5ncTtFkeVG_.asykcnGp1cbCc_na5GRbABYPM8pU4tFcUi0_Ee
 vySbojnZ6DSeMX_JVWTZPJFTxO9WF6wlom9FF7DymXYRh6ALDcrQJihjRiXbG6yy7lOoKnRMDAl9
 Qgh6KJD6wRPBjGWJwgAw5nZC0SrRqkUQ6LwcZXSqIir_TVuqrLF_3BjBBbJSneGTs7Y_dN6nwn3c
 mYFaXiZupdmA9BGP3xvMxpvJKMVhEwdvnGKq6FZPJUomyPxj._VVuX3euIPI3tNZKegyqyyS0emP
 CaXlevWdrFlbU5x.XbvxqLZWusNeXv9XXlr9GD93bZplCeI6NnWrKuMzq68RtgU5c50Jdsru39b2
 xZW79FluiFe2aCXb4iThcmfIrSYF4kTKU35b8Gw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c89224d2-1f4c-4dac-b68b-4e08985361f7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 4 Nov 2025 16:41:31 +0000
Received: by hermes--production-gq1-bd8655d9-8lml7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 37682e68f1ae2f38fbd32d7050253b9a;
          Tue, 04 Nov 2025 16:41:26 +0000 (UTC)
Message-ID: <c1dbe57e-e5fb-4ca7-8329-e245c03680af@schaufler-ca.com>
Date: Tue, 4 Nov 2025 08:41:24 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] LSM: Exclusive secmark usage
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org,
 serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20251001215643.31465-1-casey@schaufler-ca.com>
 <20251001215643.31465-2-casey@schaufler-ca.com>
 <CAHC9VhTJBSejFr78csXudG4xKW5hXVy3undDP-m8YdjhJLYrYA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTJBSejFr78csXudG4xKW5hXVy3undDP-m8YdjhJLYrYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


On 10/13/2025 2:57 PM, Paul Moore wrote:
> On Wed, Oct 1, 2025 at 5:56 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> The network secmark can only be used by one security module
>> at a time. Establish mechanism to identify to security modules
>> whether they have access to the secmark. SELinux already
>> incorparates mechanism, but it has to be added to Smack and
>> AppArmor.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h        |  1 +
>>  security/apparmor/include/net.h  |  5 +++++
>>  security/apparmor/lsm.c          |  7 ++++---
>>  security/security.c              |  6 ++++++
>>  security/selinux/hooks.c         |  4 +++-
>>  security/smack/smack.h           |  5 +++++
>>  security/smack/smack_lsm.c       |  3 ++-
>>  security/smack/smack_netfilter.c | 10 ++++++++--
>>  8 files changed, 34 insertions(+), 7 deletions(-)
> ..
>
>>  /* Prepare LSM for initialization. */
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index c95a5874bf7d..5b6db7d8effb 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -164,7 +164,8 @@ __setup("checkreqprot=", checkreqprot_setup);
>>   */
>>  static int selinux_secmark_enabled(void)
>>  {
>> -       return (selinux_policycap_alwaysnetwork() ||
>> +       return selinux_blob_sizes.lbs_secmark &&
>> +              (selinux_policycap_alwaysnetwork() ||
>>                 atomic_read(&selinux_secmark_refcount));
>>  }
> This is an odd way to approach secmark enablement in SELinux, and not
> something I think I want to see.  Ignoring the
> selinux_policycap_alwaysnetwork "abomination" (a joke I think only
> about four people in the world might understand), the
> selinux_secmark_enabled() function is really there simply as a
> performance optimization since the majority of SELinux users don't
> utilize the per-packet access controls.  Using it as a mechanism to
> effectively turn off SELinux's secmark functionality could result in a
> confusing situation for users who are setting SELinux secmarks on
> packets and not seeing the system's policy properly enforced.

One could argue that a user who creates a system that would have this
problem has configured it incorrectly. A system with Smack before SELinux
( https://lwn.net/Articles/645245/ ) would, by the "first LSM gets it"
rule, give the secmark to Smack. If the user wants SELinux to use secmarks
SELinux must precede Smack. The SELinux policy, as well as the Smack rule
set, are going to have to be correct for the configuration, as are any
netfilter rules. Yes, that's likely to make some sysadmin's heads explode.
Complex configurations are admittedly difficult to get right. When you
start with a system that isn't simple and add to it you can help but run
into situations that are baffling.

You can create a correctly behaving system with the "first LSM" behavior.
You can also create a system that goes completely wonky. Just as you want
a well trained developer creating your SELinux policy, you want someone
who knows what they're doing composing LSM stacks.

This is going to be an issue for other features, including audit rules and IMA. 

