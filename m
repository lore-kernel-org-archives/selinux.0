Received: from sonic.asd.mail.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDBC1FFC41
	for <selinux@vger.kernel.org>; Wed,  6 Aug 2025 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522199; cv=none; b=TAbB/hqfsVFPiHh5bbG2/2XPfygeRrK3I7NB2vJAKsVrN5eNm1BZFP7ihZ5gCr+4K2v+DLBLIgmFjvNSzp0D2zL9SCki1B7XUwITRPHgdbgaAtW7V0jPRuAYrZrmFxcAcYPLT9F+VpwODmxIiGIZAmUeQHQGQ/4fLSDfuJ30BF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522199; c=relaxed/simple;
	bh=cJl4At+1cXXYug9GtLBmkxDFdTibYeN0XuD6qJlLMJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esx9B5Po79wAGsq1skuI+oVOFPYka3L7JoN1OUAH0d4QZ5je0d3JhgGQfQKxa8fJUGzgSdMAtMQBm7Mlvvc5gFrQ+G8djchAm4nSISQB0yr3xTQdYHfnb8HvU3u+e7pNgtGtv1phPLrBE9uJTMbOK7o6YCnchta0WoIQHdc2y0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=EKvq2quM; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EKvq2quM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754522194; bh=HkvgS4SbiUOpqGxoegOo03fYCtOsJFgBfX5j5w+YXUY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=EKvq2quMrV2JBhF6hZh6sqWDP6lSLswwqjOqZvR56/WKwjrOMcTWQdRAwd123CM26Ckj+f3tWmcg8UT81kst+BnGmCOW+TOwYjPUHk8i2mwQyDMgsA3Gr+Df6ocbHY21Spf0dobsaWhkEZ6zuOG85v/FKWGpYoPwYQzIwbsMlazVJCXj+ujKPFVj2xXFnyFuBmpBBtD4LT83DE0sNsxGVC01tfPPef0geau+pioqEG973wyO6Wy6KRxAKGHC95kDCaBwt++rnsvRKc2wGkIOcmrQttX5c9a7EX3Szgz3YeeeLBgbLJW60PCUMNS7vZfK5sdYgU1iHQWQyts9fvmtBw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1754522194; bh=QICMMo0gp/PvXWOz2m+vJg/+hzHvlUicoPijRI9U7TS=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VByQ32/zED11Iaa0n3ySfhs1SPBq3g0LEPSwAfBHSiAavawBUU7shb25E+bYhvs4nfAzDyTUCHBKV5/mW66LZqiiToZGLMHlsfLhmTD7VIgbre1EjHRvRAbJzyIX4oYfY5fGwHTtbcvgWuizczOx3Jxyo8I/ImSzhrCwIUHszvaxTo/CEsU5lp28No14UsLUFcLIiAM32fDVOa8oRatRza2TW4zPTgGCATKAdJ5EuMFyQPwfsUvPaKmdAq8dSVOosCD48eZbillph+Do3ocKq0IvLE5VFLipbtJSBMYz79GeA1wKtlYtbH4LNz7I/SXBEIPiu7tc/u/APTwLIV4LRQ==
X-YMail-OSG: CHRBBxUVM1l_twm2XTZ7Or3KxBS9VJAFaZCbzgLl8jzXjFQi7NGXp5kIVJzBxCb
 uHFIjKOGlxDbhfKorbScrG3cRD3ZoRlVEt345ttrIAtLQtGGWgJZiQFcgxjtEk8La2O9hZHwjO6t
 bDcOrWaRqAoWVrdkqgvQlxxs29cvknCultinMa27XfPEWCA0SxqTGQ9QIrKg70ov9eiTug9BC6kx
 7znv6he4.MHvtn3jcfsUEAkdrgUBGvH6g2QG.bdXue8iLfLFysXOZen89RCF3dRnN_jDLxzF_ZA3
 qMDoFlkewmtyeFfPqVKjdooMfKerqeaXcYUHlE1y78efnqdtbAJyTZo4WVpLgD2RDnUPP4G04nG0
 3n1.RiFj28ErIt2RgXfvxci27kmUClGVtgFANQm6CWCDFyHXEIgWjlV.OGf4CqqlKB1D0wUAJab6
 9Q1.vG1zrXaT0sCKTzCZf8hqFRQwXjqC9NAcDBUPuAU25ivbl.u5Nu6RgNXWb9VWUw6BDS_1Xbnu
 ChO8OtmaXP0CxcKppu8w0ziiVL0jSbPLWvU40dsL4kvk3YfNs40l0KU_F5eYHr7Qcu9omAl7Ugwa
 aTQXb_h20ez5Fw0sAQMtz6Q0Mo05NSL6hi2t9uMBzO5FcVClBTr7.94RcPyC6L9Ko55lu2REPtE5
 dWp.dAltUAJmQLfsmLb.kpShBuUKEpOC.I1zmO9Jyerx1GHu4X4Ing9uulRBknOC.g2sxocRhQnq
 pZ6suO07fd95zyVErh1uakAJKnJme2QazcStVmu_aNsSbsH7mQOt8DvE1Uwxej2.aydb2MtHBsxA
 UPEYsLcVMBZZcWO16Ir6QGrHiE71mp7.m6G2FnFkEwR_jJo8S6cK7vmFh3l7YvqUrgtSGiOYKXLP
 KRbOkYIy6mRAmN3cBXQNRAEVQ0NoNuFhOtIdlUbgt2MuE8B889w6gVshrMDYhLkUorU6Co3fPl6y
 hBkDIU3Z0uF7oY3mpWJsfcLRMbTAJrCzOwsCjRVI78QDChSIsyFP8rJzpKYQaGnjaDGlwGJ.tnZA
 wR2zg2s0D0Q.7qYqs90p3vw_M.JdY6orrDZmrWhUKkiKc09vQ.eIshgHDyTbeEfmRVc5ezQDZGvn
 aBGvbSIkSlw3jheETn_BeUGG2TXFHeH4QjdrZ7DK.fYhn45v3NlelX4maZbm58dZhrakQVzIAZsw
 ENH4Bo0oO1PLF8bxssXcJuLoXBx8nG1o42DPOagaP09.QR033AfiC1bs.CdgPwfhY0If4PRy7hUg
 v9OsOFl_GNA.fmcwjYmOwU_RGdcYDKTiyLlx9Z8NG5Acts37WQuJOBbM0XYOJn6kkkDLKRjWYBD7
 k.uk1UYgzDn9D0PliPDSkPYPf4Xq3ft411qnUoivodKusvK1BabpZfe1umlk0I9._f.vpMw6ntge
 feIpTTjGfsy0sd.TcJcV80REKAnOQ5qLolr0QAM9UNXu.2phXCS8RKB.YUwO8QgtWcb0or.v.JLn
 TFG7cpcd9Ua_2NZqkpEUR9iwkiUmX0r7INvULuK_jqdHlyqGUVxx7KNj2Okbq_ZWzct0oG0OJ34N
 sI1147IfWkV_JwihSZht_Nj_fFwFwWOHEQ1RolAEYsaPeFjzFtPRwFa_rXmHL0KW4IUiYzZXTJDZ
 AGRF2._Ek6Pt97.aXSMBH.stlaz.Td78toIUxE2fbVyv.Eibx1GFH1QYkKucmTjFDg1i6hG0cLhV
 qdUxxNSVSY1K9shmNSJj5uUhVqK8l0YkE4CyE.TzcY3ayCUpa_QWWpjMk7Qt9legg91Mkw9DjGB0
 S_QdsGbVLq5qhSl6As0ygafmb48Qe1FLXAitBoUBUpRyegaUsuxq57BBPIyzknOH43i8JANrPP1I
 DoUAej93SbO6G9hJYn.15iCsGemguf1EKSypYZwdZRh26xiNDQ0.4ELmd9a_xWWDXBPzS0bgcXp4
 q6TbgluGIQjN52SNb2Xy6x7ooblnS_NCPkTZNqfoQF1VAfY60eG8z_fXeQGF9dg5hLVH5SogSbgp
 azkijnWblKiuOq_whBqxref.p34bs.5xZzf2Y8STm0KtVDv8Tt6dcltFyetvo61vh_TU2NYX.05m
 i7OtjEYM.CoOjfTRlqPsbLkPdrwX436EkWerHjiU9BwelXAQ.lSi2mF0fym7OokDdzmsAQiiidJV
 wquMW4sAEjcjxI.C9Hd69bJUeDbkeHwSeWJJ7xjs0Kz7wv7bncpKt78XL7U_zohZSWf2uel3Ge6O
 TOoJFeeklxbSRDI0T4fbUw93bqkoV_h2tYU0mdoH2h1uaiOe0lxGk2pBBgsrpVKEb6gEVUyloznd
 WdXd2QoS720xHsc60mb14Tdtgjg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4924f168-a661-4c96-87bc-3b4d4db3576a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 6 Aug 2025 23:16:34 +0000
Received: by hermes--production-gq1-74d64bb7d7-w6q4t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b7ef53b8b4b8be522c44d02d81cf19fa;
          Wed, 06 Aug 2025 23:16:30 +0000 (UTC)
Message-ID: <f3a8cbc4-069f-4ec2-8bb5-708b90360b05@schaufler-ca.com>
Date: Wed, 6 Aug 2025 16:16:28 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] LSM: allocate mnt_opts blobs instead of module
 specific data
To: Paul Moore <paul@paul-moore.com>, eparis@redhat.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250617210105.17479-3-casey@schaufler-ca.com>
 <f7e03785a79a0ac8f034cd38e263b84f@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <f7e03785a79a0ac8f034cd38e263b84f@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24260 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/6/2025 3:06 PM, Paul Moore wrote:
> On Jun 17, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Replace allocations of LSM specific mount data with the
>> shared mnt_opts blob.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h  |  1 +
>>  security/security.c        | 12 ++++++++++++
>>  security/selinux/hooks.c   | 10 +++++++---
>>  security/smack/smack_lsm.c |  4 ++--
>>  4 files changed, 22 insertions(+), 5 deletions(-)
> ..
>
>> diff --git a/security/security.c b/security/security.c
>> index 8a4e0f70e49d..ec61fb7e6492 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -904,6 +904,18 @@ void security_sb_free(struct super_block *sb)
>>  	sb->s_security = NULL;
>>  }
>>  
>> +/**
>> + * lsm_mnt_opts_alloc - allocate a mnt_opts blob
>> + * @priority: memory allocation priority
>> + *
>> + * Returns a newly allocated mnt_opts blob or NULL if
>> + * memory isn't available.
>> + */
>> +void *lsm_mnt_opts_alloc(gfp_t priority)
>> +{
>> +	return kzalloc(blob_sizes.lbs_mnt_opts, priority);
>> +}
> It's probably better to use lsm_blob_alloc() here so we have some
> allocator consistency.
>
> Also, make this private/static as we should just handle the blob
> allocation in the LSM framework (see below) just like everything else,
> unless you can explain why the mount options need to be handled
> differently?

The mount blob is different from the other blobs in that it is
only used if there are LSM specific mount options. If there aren't
LSM specific mount options there is no reason to have a blob.
I know it's not a huge deal, but there is a performance cost in
allocating a blob that isn't used.

If you'd really rather accept the overhead, I can make the blob
always allocated. Let me know. 


>
>>  /**
>>   * security_free_mnt_opts() - Free memory associated with mount options
>>   * @mnt_opts: LSM processed mount options
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 88cd1d56081a..f7eda0cce68f 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -2808,7 +2808,7 @@ static int selinux_fs_context_submount(struct fs_context *fc,
>>  	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
>>  		return 0;
>>  
>> -	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
>> +	opts = lsm_mnt_opts_alloc(GFP_KERNEL);
> See above.
>
>>  	if (!opts)
>>  		return -ENOMEM;
>>  
>> @@ -2830,8 +2830,12 @@ static int selinux_fs_context_dup(struct fs_context *fc,
>>  	if (!src)
>>  		return 0;
>>  
>> -	fc->security = kmemdup(src, sizeof(*src), GFP_KERNEL);
>> -	return fc->security ? 0 : -ENOMEM;
>> +	fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
>> +	if (!fc->security)
>> +		return -ENOMEM;
> Another case where we should do the allocation in the LSM framework.
>
>> +	memcpy(fc->security, src, sizeof(*src));
>> +	return 0;
>>  }
>>  
>>  static const struct fs_parameter_spec selinux_fs_parameters[] = {
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 44bd92410425..1d456df40096 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -622,7 +622,7 @@ static int smack_fs_context_submount(struct fs_context *fc,
>>  	struct smack_mnt_opts *ctx;
>>  	struct inode_smack *isp;
>>  
>> -	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +	ctx = lsm_mnt_opts_alloc(GFP_KERNEL);
>>  	if (!ctx)
>>  		return -ENOMEM;
>>  	fc->security = ctx;
>> @@ -673,7 +673,7 @@ static int smack_fs_context_dup(struct fs_context *fc,
>>  	if (!src)
>>  		return 0;
>>  
>> -	fc->security = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
>> +	fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
>>  	if (!fc->security)
>>  		return -ENOMEM;
> Same thing in Smack.
>
> --
> paul-moore.com
>
