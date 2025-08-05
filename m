Received: from sonic.asd.mail.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113E1B960
	for <selinux@vger.kernel.org>; Tue,  5 Aug 2025 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754435812; cv=none; b=Irx6HRXNJZ67xPNYVRSHFkWMxXFgtK+Eb0dLtDQOWfeMc4pen9lx5+tImTFs0etFR5LHRQxAcHvfZlvEBv6RGpvrDZsOlHcDSmeUjUSQAB9Vkj2ELiZbkbWw2sE+h4FWfcEzyVrnMKALh/hbAEVP9oIuXOB10/Q/U91tNMgV/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754435812; c=relaxed/simple;
	bh=gI3rS86sC3QWGfG4mXNqTXTeCskURGAfV4laolb/6yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCEHvLTKosqdf5Klk3CuRnmYJ0MP4ueBqB6PWiyQCUWipGaQw1vCnq9Y2Nee9/Yy/eCitV0JVr2dk8Q1q6SoH7ebGr02IlLXz1DNG0jGjzwm56EWZAxW2V96M9Y5qIvkLWCfB+zjvqo3sT/+SsjJu5/KQEb0vKmug53aqvUzmKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ZR1AkoGA; arc=none smtp.client-ip=66.163.185.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZR1AkoGA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754435810; bh=vbjqlMYTXFyo6PdA0ZoJ+EikPHe/xyyE7Pw36UaDjOg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZR1AkoGAB9wRkTh5nTTHaKDbYICr07M9vUtb2HDaa1SjZ6g1bwxQPS8MFD3AbP/mw8/7ki+frcZsEC5oTEYABROy6ELuq+s2Yqq4eEH62ZvTc8N3advJ8INEjELoNt1t59aC1HSYWVzXY7wmqxOqf1a09sViQVp8wWj+76lxOzoJ5ySNV7K2kk/NS4Vtlvcr1/Eo2u8NENvrUUPRgLxBDEfB0yRfyjP2E3YxI7a1hODBpIcdUHZ3sF5i/wGFkokIFlcPCfmFRz4FXgW1qJGbUI/NZX6BrjKz9as/gKZdQbkUJI4lHWDpG53m0gUnXmiUaeW6Xfp4dEKHLye5+UVXVg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754435810; bh=vJ5XlX76HrWg9dFWaj1WtAK9e1AO6S4d3o8xvuTrMI0=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=CJ+9bji4JPQ95kr4W0KUlDPRjlf9yuRjhMw+xyWJFnzzrD0jBfMz8t20k2hzoHT+L3R3jBXEv8KbfSb+2pUvccHRRMyrdujzjawV4Q3SpjZmNnI9bXEeIUNY3PMjapr1xz3I4517fXVZ//8AkCHDcVAoc5GTmrEH3VMynv/aHAYeGQt2Oy2IMI4P+xxILd556Bk+LZSlM1ePQzdnuIV+aVzP9uCcs+OmFern0ftXxvPPTkNMxAo27uNJD6JqdGeaucoTWRYQTjN32EXByywsaujuvhkWOcaGoLTUmi8mu+WGr2lKSgPzGE101qYuuaY94dLycdX2W8cKTNyeqUsnPw==
X-YMail-OSG: wKaFS.MVM1ly25Cc1R1oVG3q2ZYW2SDEy8QrSWYgsuCp8DRdr3gUMdRMN94W8ik
 Yv4H_MFgvgymNHkbzghbm9wQk06kGMTiNgk8b6xSgmUYkODQgkh3fWV3M5ljAphngGiyXlebpP7C
 W195VbExWYFFBl1OEkHqmQAlmyCFbF8ulGo87DLL8AhAW0E6YKfmy6xWLnk_U1Iz4b4VUqsaADhV
 rKCicLTSHoGy8AUUkb7Kdgi18g_Zi.6.IVPlOzHn6K.U7YQIOzRRctELngRG9kJt0Hm8k7HO9G._
 7zP03vZw.KrQPr7GquLWg.skRVDDKasQhbwAEWhNePm6TshajAd8KuENv.7tzsFJxUx.dd1vwJcz
 0TdyxFbi7Dx2z9hhDk0lMVSYh7KlRnvFiPoI.wmFLm0w0Yknm0N0O9leWdSpGT2217txXt779svi
 1.XaNuRGDkGyp6ehJXvdqghe0WH3c6zXqDu9q220clTHpeLwiWRI_OHNq4hlYV5M95R2NJZfDoMV
 yyd.ggO7kGvmGRwBu5wT2a6ubbkgElgijX8K0YlwcUGL5pBHeMb0oq5IWFSh3a0ROlv2VOqzcKZa
 YKj0vmPg0HsnYcaRk.5O2bvH6cQQPQ_MJSCB0dK0PwB138UvdTFKp_hma_hs5K5QQsEV.UhnMCl8
 9H4pVWeyV7fT1Ar5HtUD62u7OxX8pOWE5KdMLkDH8G62HMMpzCrYLHEsoTkOVGY2znEBa4YcK3mO
 UlKMiJ_SMZFN27iStcuGse6UqkbeyC1x7kP2tA.8yxmbLHtqkIOMRt5SH01_qpdexm0XiKKOD5e_
 6ktVKxMS5HgXF_R6gd.qmgdEpqfhDZlHhw0GbAAiwAHH6wyh_Kl15_lWRucCY4esGke3xBnPNcVG
 tJEVI.V2sY_EEHguXy87Pu2xdN_Goldl6f.ysrY5VqNGZPc.tQBUMKC68t4fzniZ3xngWVJa8JiM
 wX3jB3W7AWNDVNIyBq4N.rMZYuHNdISKcn2obEBVAp1b12xqDBKd2BQohMtec1XYM9zc1T1OyJ0h
 VwnDf71gQhOJ4dKW6IYlEK6a.GGV3nBBW4oPTAADZ.J_ljgy0mI7g6f0JNJOiji9Nz_SnKsWoV50
 b4t7PAonsITAiGBsQRKa1kMFTxbhlpDkLL6.3pKfzksLy2dt3JIWiQz45j0dU34Y9KjdZHqHM8kt
 eBFZcgPPGK.kSKiLUX.keRevpwTVokLrQM1nOR4QT4Mqi2dqj26mdXmjn8ftcdAfCIiE9SywicoV
 24oGdpsPZn3dAHUbDD3JkzlriVwY9ns0LWp0MQCX52vMyRmgOmcnGaR7vzCW8TB29z6J0LBQo.8K
 rTZ_anb8Qg.odkZOhJAKawwKALRlRzzaAIvHBa4IsOrMv.x7OAO0lDLfE5hMAhcqPvjj4IA0nuHW
 l309149GIOspfUydcvsaeVgZWrZoiWmtkyPH1o73cYZYjKWfap4OYN11YQiyR4_qYns_lYqB7Rn9
 ljLYMDHdMLUk.X7VpBIaQNpRVm89hiIbcHOGfupw8Fl8cspcE4dteLVrho_rpaSOUsfDX8zDeTaB
 7TFhIGn0PP9LXRboLuJqnnK2jFqWSkqHGItlZw97aHDolQRPDI.b1t1dqZiMucJvfUFMyGnZnT_F
 FP5M7cRThJL5V2ZQBe2XswqmcO7tnNEm2KtntHRrvHGMiiZRbMfA967JdpqfvOAMM4pk4QeuInEn
 K848ZLbHG1W7UXNJHJBjKAb6Py6bs.Alugit.OPdRmF69wUcRxHzOurEHNBHUA54SbronlLvBxyS
 9PwSlpG1K04J4AAuEtLk8uZbJFPX4yBLFJUWIgztFdgeu3gxMa2Hq7nbruvJn2Y5OQuRbqtC2ojb
 8MF9aGmNcaG2tmnkWMIJCcM89yL7bm43JLwj5_gKxX8WyhhA1N2xp.Z8nluWTVODWOPNBCMsM_NF
 ggsuNA_jKS0ZzN116zjqAc8wIccbeFCDh9Ge_FrQjnyH8Hb3fyDymGVedRot0tLGQoZjahSMzc0D
 pUo3ujbN0myKw27eB1ZbbBBlXjcVnmcrc6XBA99sV8.AnUSp1gUL16ub1D35PBP77dOfPrhq242h
 nzD2H6_RtnAYV164nllj8z5DXXvGICtCqZMMiEC4nMKhW9J.HxL6YLVfhZyP2iP0okwX8XLcPp2m
 ObQKCMZ.5UwuYZ64NUU.F2cD1hk23myQAQCXlEjkWlay5rtHCqYt.lmlK_Nsry6eG4k20aBB7304
 StxFOvYNYKMHGeFOHDikqpH_4IBRcHbiBlcGOJRckevgv1Q--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 00470c67-e6ca-4959-ab3d-9f5a80b28ac7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 5 Aug 2025 23:16:50 +0000
Received: by hermes--production-gq1-74d64bb7d7-45lk9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a88e5da3c38f1116d0d02f59c31e11b8;
          Tue, 05 Aug 2025 23:06:39 +0000 (UTC)
Message-ID: <4f6c9294-dfb3-45cf-8f46-c1a0063d2921@schaufler-ca.com>
Date: Tue, 5 Aug 2025 16:06:37 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] Audit: Fix indentation in audit_log_exit
To: Paul Moore <paul@paul-moore.com>, eparis@redhat.com,
 linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250716212731.31628-5-casey@schaufler-ca.com>
 <d5f0d7a5edea8511ab4467e0fb225b8b@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <d5f0d7a5edea8511ab4467e0fb225b8b@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24260 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/5/2025 12:39 PM, Paul Moore wrote:
> On Jul 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Fix two indentation errors in audit_log_exit().
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  kernel/auditsc.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
> As this is indepdendent of all the other changes in this patchset, I'm
> going to merge this into audit/dev-staging now and audit/dev later when
> the merge window is closed.

Spiffy. Thank You.

>
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index 322d4e27f28e..84173d234d4a 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -1780,15 +1780,16 @@ static void audit_log_exit(void)
>>  						  axs->target_sessionid[i],
>>  						  &axs->target_ref[i],
>>  						  axs->target_comm[i]))
>> -				call_panic = 1;
>> +			call_panic = 1;
>>  	}
>>  
>>  	if (context->target_pid &&
>>  	    audit_log_pid_context(context, context->target_pid,
>>  				  context->target_auid, context->target_uid,
>>  				  context->target_sessionid,
>> -				  &context->target_ref, context->target_comm))
>> -			call_panic = 1;
>> +				  &context->target_ref,
>> +				  context->target_comm))
>> +		call_panic = 1;
>>  
>>  	if (context->pwd.dentry && context->pwd.mnt) {
>>  		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
>> -- 
>> 2.50.1
> --
> paul-moore.com
