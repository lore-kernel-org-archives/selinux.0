Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB82C4332F
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 22:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjKAW0f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 18:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjKAW0f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 18:26:35 -0400
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57780119
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 15:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698877591; bh=CI5Jmbvv91wNZ87a1yFPp+SbMOdm8vqBTHgkiLKLcQc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Jva7VkLIbNbu8vX5P3+ELUWHHVaKficFpRuz7/uDrcEBrVC4RcDf/Gkixxg7bZ1y4UoCLa9q07zDcSm4/ZacCyC7pXv7DPvGoP/LYauJKw/YXU2Q0yNcVpox2geHHhKSPb5ZEytxEUgCnZigOsrANi6u+wYS3E/S3GEf7N3Euj8UuvbBTix7CzzvPsTPZ7iQ5v+pI5e+/D4yWuE+S9UfFug9VOZa8JgGznx/oiwSe0g8dwIwdgjXIPSu4YBuZllpNAUqDRagrZvjVmdOvE6aohvzOS+gDn/8TX1UJ2l5yIDWuhMzerRtenFbcrp+iRjlS3NlMHQADhJBeOfoCEpOSQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1698877591; bh=N5lFJy3HyiJoxFeRMzM6d+gEtZ1I84IxCormbhilkPj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cPOHU90U0ZyTGi8bnROETWpgl8cQzzp4YqfOMo1KTN3pMczuJHfpgL0UWRDQQ2RabhIf09A2efrjIqMxX9BmHhj0FWCjt/RTTdPpCh9uPqbD6DysrI06x7QcRzd9kMStk01/DLeziXwWViGYHdSiwlHZlTmYekXiz+JqbrkVA+D8DhG21T/m3KID6W6kCZ/lSEBEdD8eRPk/Zr3Q2/emdICRTTc/5yyRYwakmK7bEK0QNxZwPeOGXKrUQsWMRD3TAzyADkzUVOdNy6qtg4z7EOTioEN05vg6CtCr7a9UTZxZs6M5Ninyd2wAxs7pNtDeL3Ua8fIFpraLyRXgWXWBcQ==
X-YMail-OSG: dH7FTtwVM1kwOmueqHiAu5BbbQwtAOvv_kDdS2YUHLRWvr5VUgGpkyThTxr4BnM
 qvHgix5AkijnHy1WrApZyRipCY7iTCawdBPbVJCuQzv2jishWDNrv4OrO9kOCyVk6YVGkwES6Qb7
 qfyqCGIVSDfI.yWGtajW1WEtmjo9wETI83k_Ti0ZwilkteH092pFtEE0F7eeTMuLKezJrjybe80B
 n.wdO0.oWR2hqPKWcA5lm4lU9YbkK7u8tBOmeb.ycOzr7k0qZcjLD591YBK0XP4Ha5K.coYeGWrF
 ZqEHD6YMNnBnezg.VJZ3RxbfGek3LzT0TjFF_YMQVXY0AekdSH6l9lrUAKL2wtOLBV5fbwL_kx1P
 MSaio7QzZKrnkFvjkdFbhAIHT6InJwhtZQqSkCAagPRZJGtKBYEcRdiZnqpBqVNqYIoNP0LcDWyp
 eH2cUwo2U4RWkMvwJkkoTHv3COjwM2dXEz1l68ZLKgIRZ0auKRNqEqPVf3INWy46iZG.oh1QTU3f
 wd97Ao5MNV6dYJd7kxejDvQBbYjLhqGx4VCnDnendo_dXTwyEfLu_hQHgvwAzcsY1NbyCX6enMAR
 YfKhv2p519sQEZziyNrq0HKpjxEvG68fTV7P8laHa.2Xj2eCES15nRVuATyEe08hfXEXyolJ8X.Z
 Z2KXyK4ZYqGmxQi6L8h3ay0nqvyOReuaBcykciJP32mU5Q7wZA_N4v5sZiVNFTJR_dw1R.E_4nmc
 BIEPF_8A84ZD0qU52Leho9HDuLGhGG7pLURBHgmub0dhn2BOS.HzsAsIWWs.7CUARDUEX5lHyxCc
 rdcPVaZ6yEM.mhgwDjvM.KZ1VoVOXhBD0BWJzFCNnaPrEDlP4iHVv85Pe3pqVz9wJ0a.6Dv5LloC
 .1SmtrZls2F790q7fQrpLi5MpQ0AXazWukTDLlNKJVJSpfyVD3t7i5m5J_vctBOMX1ETlmKjqVJe
 m.7KEvvPjfw_te4ijbuZtv3gKPNBSL8iltO2jLSScwKCupCudqRbaw.bF7wPHl9JNFSb_..xc.Ih
 fJX5YVkjb.USUzFoVObAF7hHp5Ep_n8.I66Meb9dmmqBv.u3kSZr4cyXaau80jlNO5uM7ahQ.AJv
 xcNzneFzojk1_418f40PCJfE0Y9tnkQ.fP.iZF3tMF6PWSLPEykfuL1k7LK4B43TdDR8kM8Wyyro
 J8u4ZH1LRXiEJwARgttaSp5dlHyUelEMb8E13MV988eb3e1H24JScCBnsJ8KSMPumwn3EzmCZX78
 wGC68J.BMy6mNL8F6_.OuwN9taeXm3Y3_2el02VBvsBWv65GzoCKyQxl2MYsi3J6ydIi.lGhW4MB
 2IleHALOitcqnPbuHuPxYeA.KOBGzriL6qTJtMmu1MUY_wTxoTy9MFDTtWJP7AsWj1eT8nb8rjYH
 xRjcYFEDmaaVFJEGyKyrAyA3lYsWXgjIanERhEhOa4wULuw7WwJfojCPLdCLLnuAAbZ3D6mArmgB
 Osc5Tuqd6curOJtK5uwiWOX6vnB0Xz_8Hb2OC3PPzdxLBUmdf5PANXII2n9wbs3rsXpOQCW_ZCZI
 KhfvdaOJxPnjKCyaVObg2WjJdf0XiKZBypVItK09gGlM8kHolyGlSqVES9GXpx4zdzgKplRyIuJ6
 e5UQIbIsxpZiYmWttPtEfDFlsg2hcvsFf6ib4e8cgzY7CaXfpufwxRBaFCk1pzpSKnHRmtGN8BeP
 hf0DoqnyHq9UnYlp_MnpEUWQ8FtHK5hmcdGRAMh3SbeSG7M.7b27xL6Ckk4oslCBAzRcthY7BN0p
 AAxnP4bq_VoWQqlAEjghjBDzyqyM6jGfeIBuvEfdOl2djZN9lggbTIMWQeFkuTwelyHnOCLgYQc7
 JDCc5BIKGwCvP60IPjSfcir6ZPmpFnXt.Z2diBroiEJHx9KPKmQebBz7v.FgPYbkvcgMS.0jcrvE
 ItXI0xoS7CrGxT3VqHJ63VP8SnqVsGdhr7jjk0wtu8_5aFVZllzUygf8t8OAu3CgRqjUVQ.6Tkqi
 LsnIEfoEyUoE.lxX95KsKdAc2CY1v6H255jlm1ylKgovYQHw64R2ZIsCUOhJXEuOkvCi4ytXD70b
 rgRUZwGbKvtTydUTPB1tYr6DESOT47cTCn1lMwN2oQi_fcwPMxx8Mn8UtP0zDhGQ4kD77.Uw3SGu
 F3w9t5yMVR.y6gWq7gTO5yOIoSfzOERpbiv5lNJQ5xGN9uHFU0FFVAvB7Ykr8r6n_Y73cR2_vJZL
 _5xSs6pDsf2Jr8GZfIXIIhmQ.Jf3vmbRPSgNCaklz2OCxZGtuLecPrOfLK4TTdjWXuXOd4F4FZzo
 vlZCQGrRDxYM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c65fb66e-a27a-44c6-b355-70d524afddb9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 1 Nov 2023 22:26:31 +0000
Received: by hermes--production-gq1-59b5df67b6-tqc5s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4d5825d2ac609e50c455089abc1b4ae0;
          Wed, 01 Nov 2023 22:26:25 +0000 (UTC)
Message-ID: <2c71a8a6-cadc-474f-bb70-857ac91a7313@schaufler-ca.com>
Date:   Wed, 1 Nov 2023 15:26:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] LSM syscall tweaks
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20231024213525.361332-4-paul@paul-moore.com>
 <CAHC9VhQwwqji4m3mXLVzy6cY8G5ObbH3pv+AgsunQypi84cX1w@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQwwqji4m3mXLVzy6cY8G5ObbH3pv+AgsunQypi84cX1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21890 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/1/2023 2:24 PM, Paul Moore wrote:
> On Tue, Oct 24, 2023 at 5:39 PM Paul Moore <paul@paul-moore.com> wrote:
>> Three rather small LSM patches to address some minor issues found during
>> the review of the latest LSM syscall patchset that now lives in the
>> lsm/next-queue tree.
>>
>> I'm marking these as RFC patches as they have yet to be properly tested,
>> but I'm building a kernel now to do that and I'll report back when testing
>> has completed.  In the meantime, reviews and ACKs are appreciated.
> I went ahead and merged these into lsm/dev-staging and rebased the
> branch on Linus' latest to incorporate the syscall additions in his
> tree.  As the merge window is open, I did not do the corresponding
> update to the lsm/next branch, that will be updated when the merge
> window is closed and -rc1 is released.

Excellent. Thank you.

