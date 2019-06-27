Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA08C48BD6
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 16:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B362133F
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 16:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AI6tTuS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfF0Q33 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:29:29 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:39048
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726464AbfF0Q33 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jun 2019 12:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561652967; bh=M1xB46aNlSCBxiNJJ9PqcaAAwcT9MG0UlsKtruggPUI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=AI6tTuS8zesQeKfnuwzuRlVVoS7VevRpxmGGYLBvBiEChMetkFxKzx6Vwx8JGO0BEpPgz1p8neuHKgtq79JdXjpdO6555v5QAfAjRA2AmZLIlCE4ET29MXY2w+48mUk/OjSImwErgUdNJBTU2CgqRzhVlqUnJX8VyBV8J77FTjzAX1vQjPA6AOn0sK04u3xoAKFRsHrbGVVkiwVyzax/gaUvuVuYxikrfjk1L8xyPIu2XtNOYQFGLbCJpOAwocN1LYvFHPqVSuvsd0Wukog7PJpLQ5RJW5Tdzc/bPBVIkzquC2XNOPkaygAthWHBtWSYRv/8yPp3Iud0XKCOVv86dA==
X-YMail-OSG: eOfqfOEVM1npjKe_3KMfjN3eUyewTv9cjr_IA7KGHDEUridsTLWLrHWpNCdimvJ
 KwzsZuD8kVA7Wb16pBuYUCGOBrYdgLnMYgU6WXzh4PltaJgnwP90Ea1hekCddnwTscyGKxcZ27yO
 owhivNSQar.6V.5Bp2tdeCtLVXVygyabQ1Bj2PjI6jCBcYPSdaeF9IveV5wjaYPRGLfJzqkqRjEV
 CSLBQZjWojcDL_NBPE2Zz6_vL64pJ3QSbuNae.1__vCmepq1_cUWYdB5qCwVtBnDtwUSm1Ed0guw
 0XDxIAHdq7x_TZau5YKHXNkEQYnG5js6M0srmp_WzdVu4nU7cGC9rBv0VjMnPlwV5oi3k6sSz0Ek
 kcOn._0m9IrIjkZYQT_.AS206jVTDZifMkC6pXMKAncrB8ColB1vN87XX2_btR6qkhyhJsarqx1Q
 DYKh1FUMgEu_17sdhUGM6W7LRk0zJ1kHYfznkQS3s6eo.db9Kr9x8Xsw.2CR8Bn_RBlbWD6da1A7
 E0KkHQRHeZ2cNpYcDQ1RA_P.RzDwNH3GQQggUcqjTrVYqRsK3MNxJtPQXxuHYB0ALzo9L8J6HLNa
 GwrPVJ5JgHTumOVX7P5_rzH1jLf_gjD1AH8aT1pBYXPkMSdA8UzfIPRLqlkjcl3cIw11apD9NXhH
 Wgb3z7Gz2wHAQ35dsGLVjsIXUxDDBHIWwh4BlDLjFzwmzyMfdmDUdbqItEWUXuYfgcwUR6hJ2rwk
 VRvo3MF.NYZMOMF579ciuP.xeeXy075DM6D675SONqmaBuqhvQJYBNDx7DrRSi6ngtIgtVBUkkHL
 v9EZ1zXjttrRjUJu4cbYIuCyPAvp3wW29rSmQyoIIBahtPf3B8rKH43q9e5DKmw1rWfP1g2guXKr
 dHOWD9hB89frnGVgw2MtgnoDT7j089fBPZvA47rjB_VlKPQlemVPaRTAcnykatzeVZRbxgEu7EBa
 8XYrxpFZ51zPBqb27oHRvDT6lHYgIhymG2WbLMOZlC9BDaBmjCKYD671ShJ9F0jsaAL5uBSm7U.D
 P43G30lkSm3N9D7qGA8886g_UnSAKbojHeGhCgFcc5GvhDrbwIw3H8fJWQ77zNMFr5nw741kDpgs
 7pCXPybtvvHVqbPt6OrN_f4riL1jKiYbJ9go1OMHeBNTQaf16wnodpz3638fSh5TF1KEk13k8wa5
 e3VW4X7Xagjj.Z8_6jLx7xECUFt5yPA_hSSr6rj1JomLutCO2OshsroL.p6Nydr3S9gANm_DlS8j
 rQwcKsWXoXrTP2vAuZS0grMKfwcVkTCHzipEU
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Jun 2019 16:29:27 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp414.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID bc434acf80f1e8bc79fe79f6fff6914a;
          Thu, 27 Jun 2019 16:29:27 +0000 (UTC)
Subject: Re: [PATCH v4 17/23] LSM: Use lsmcontext in security_secid_to_secctx
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-18-casey@schaufler-ca.com>
 <201906262051.59B064019F@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <cacf9eda-7486-80d3-f47d-b0dbb6872091@schaufler-ca.com>
Date:   Thu, 27 Jun 2019 09:29:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <201906262051.59B064019F@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/26/2019 8:53 PM, Kees Cook wrote:
> On Wed, Jun 26, 2019 at 12:22:28PM -0700, Casey Schaufler wrote:
>> Replace the (secctx,seclen) pointer pair with a single
>> lsmcontext pointer to allow return of the LSM identifier
>> along with the context and context length. This allows
>> security_release_secctx() to know how to release the
>> context. Callers have been modified to use or save the
>> returned data from the new structure.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  drivers/android/binder.c                | 24 ++++++---------
>>  include/linux/security.h                |  4 +--
>>  include/net/scm.h                       |  9 ++----
>>  kernel/audit.c                          | 29 +++++++-----------
>>  kernel/auditsc.c                        | 31 +++++++------------
>>  net/ipv4/ip_sockglue.c                  |  7 ++---
>>  net/netfilter/nf_conntrack_netlink.c    | 14 +++++----
>>  net/netfilter/nf_conntrack_standalone.c |  7 ++---
>>  net/netfilter/nfnetlink_queue.c         |  5 +++-
>>  net/netlabel/netlabel_unlabeled.c       | 40 ++++++++-----------------
>>  net/netlabel/netlabel_user.c            |  7 ++---
>>  security/security.c                     |  9 ++++--
>>  12 files changed, 72 insertions(+), 114 deletions(-)
>>
>> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
>> index 89e574be34cc..5d417a7b9bb3 100644
>> --- a/drivers/android/binder.c
>> +++ b/drivers/android/binder.c
>> @@ -2874,9 +2874,7 @@ static void binder_transaction(struct binder_proc *proc,
>>  	binder_size_t last_fixup_min_off = 0;
>>  	struct binder_context *context = proc->context;
>>  	int t_debug_id = atomic_inc_return(&binder_last_id);
>> -	char *secctx = NULL;
>> -	u32 secctx_sz = 0;
>> -	struct lsmcontext scaff; /* scaffolding */
>> +	struct lsmcontext lsmctx;
> As James found, this needs to be zero initialized:
>
> struct lsmcontext lsmctx = { };

Thanks! I'll incorporate this in v5. It's great to
have y'all checking it out.
??

