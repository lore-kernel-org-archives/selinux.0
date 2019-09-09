Return-Path: <SRS0=qD/R=XE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D29C49ED6
	for <selinux@archiver.kernel.org>; Mon,  9 Sep 2019 16:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8E020692
	for <selinux@archiver.kernel.org>; Mon,  9 Sep 2019 16:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sBYGIqJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfIIQA4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:00:56 -0400
Received: from sonic311-7.consmr.mail.ir2.yahoo.com ([77.238.176.250]:37273
        "EHLO sonic311-7.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388236AbfIIQAz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Sep 2019 12:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1568044853; bh=Xj6owETe0qrf7GCSYZt7kxdL4q4YHxZnBDMS69wJb4g=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=sBYGIqJsNaFoVL5TPNk0tKrNFmuxR5SfyjoCJcZSMFqcDEDOtgBmX62alm6Dsz/P82glfRUJNNOaT4WMqknw2qRb5Yewa/qCyzAmd5B+5hi+WT7vkz1x1rbMJgRRiPdo2/GY2MS3rfDfw9MyjLQWesrZlLuwAgld1V++KtK642j9N4kDclOZfr678ZxKhVnbkcXc5UuM36xhkLgLPCUG/VKkvJ47a5xdsB58WrPCb1KT3lfL54S38/dFETjTC+OaoRMods2McpWtr2GI8uYKSZLQGb1zo5m0tByotkR/PF3QiZosjnzOkZzu/nIyjU7LxqHGJNDrGXgy/XmL12DqDA==
X-YMail-OSG: 9gnusFIVM1kcJq40QfvAzRUt6elJbug3apdMKeDHNhoIkH0xtYZteI.53LIls1T
 0dwYDJAmVNNlUmFXUbZ4_PQlKO9EgMGdAkCRXIQ9SGIaRCJRTzFgiULCm.SD10Hy7pmv356TcD9C
 iZAogPuiGjAQsmxhWTefqxyKenana_qCJcLVp91326ISB6jgcR7jcHD54bbFFoVXyQ18qfrDJV3.
 4CnovNjkfa72J6Th.OciHl52ALR7o7AtwxEpL9klJ.jL_1uYhHz6pVH7alCZ.rbayGrOgPwbNyJu
 6D5V6fLBoMXpG0N4lx_MRiiWATiqXmt31aeCSd36caXn4AhhKQS.95FJ9blKiCSTfxBLhlDcVXm.
 9HOQFxLTqQnQda7psZ.kmTC2VyjhBZ6FSlveSQPGGyE3bsVrzd972NJp5_fhjdIfBdImLKsq_fis
 5Ez_cEyAzAzMhzGxdNhKMfd1O9MGi6PWB7lDfLCjMrf1WuhctzbSTmJJsWFm3Spnum.itO7xNcB6
 HOOSH_gpeHhxHRxR2vPOK7HOnjSO2aIZLlFN3ivjvh4FQlWC2qbJo2v_KsyVhtt1QE9p.bc1x8ez
 12i_.MOuU1GzhWt8zi6MPqC8hmpC1TsFH8OxETzTNcBvrUTZMOFTvNv9NMYrCa86KRKDiv7Tveg9
 1PIh1m9IUcPr5qbwcvbYF3ZTFBshyirFjLPHeCskJSvgi54nsvQl0AywOwRUITBGD_WfjqKue7zD
 uGZIB24BHVmCwWEzBDCgH1D4bAouh4MW6a6K4WFggG.be1G4tWzBWHHldLMiNiUeE91Hrz48LdgF
 NHo9NFQg5wIzz3dI2xPB2RBS3lXE7r5h1TGjuS1JV_wOqkORVIOKBgEMfxb0uBPH0lDnrLHILe9Q
 A6ONdgEVp37evRdZy40dh5n6sBB9g2cVKxtJcrBgNXmAsqhm_Oyl6AVvG3AFCrTQsX0jION2T6KG
 7itpjlMPf0Xh2OB7wfBJ.P09qIiLENqLqF2Huo3sJm_rWMX5qKJWnA7jUTvik5NIxYeT4JmJbHuM
 V2NQ_CAKFpkfXNbD6lZd7N4oVQtdjgxRaHMCDHJWdKR7Nr_Yu7YQdEoxzkoxAW8ipWpu2srVCOlm
 O3937UVFzhPvIxBJkvoWdT9ILhunBmrqxkW7bHMY9VzW9JyA3ip4KG4Ze4WmfGkb9wwfWkZbp9c1
 U8wC7zWUl7UCk3BjYyx97DDucEzqrczfdBJxJjM.JyMFoxGn2GX_AesuAPvmAvvLu4WyaUCaJ5ie
 09kl0MyVmQWUetRa2Yji4JBwkvRirV.5HJLIe4wBGLMj1_VfN7Y0WCEwoUaYQO9q22UuxJryyCsI
 m0uWDcU5KRHR3cA.r5eXki6hIuPoiOjck_hnQm9HdE1dv5w_0iqynahj75DR4810DGrdnfOVrY8F
 P5hLkvGgiyhw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Mon, 9 Sep 2019 16:00:53 +0000
Received: by smtp414.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d19967bce1726bf2544e96d77b5ebebc;
          Mon, 09 Sep 2019 15:58:52 +0000 (UTC)
Subject: Re: [PATCH] lsm: remove current_security()
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
References: <156763801639.13084.2856415198922787618.stgit@chester>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <3fb46173-5be2-4e83-3074-0f66b6edd632@schaufler-ca.com>
Date:   Mon, 9 Sep 2019 08:58:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <156763801639.13084.2856415198922787618.stgit@chester>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/4/2019 4:00 PM, Paul Moore wrote:
> There are no remaining callers and it really is unsafe in the brave
> new world of LSM stacking.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks for this. It should have gone in with the last
set of stacking patches.

> ---
>  include/linux/cred.h |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index efb6edf32de7..98b0a23ddd23 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -384,7 +384,6 @@ static inline void put_cred(const struct cred *_cre=
d)
>  #define current_fsgid() 	(current_cred_xxx(fsgid))
>  #define current_cap()		(current_cred_xxx(cap_effective))
>  #define current_user()		(current_cred_xxx(user))
> -#define current_security()	(current_cred_xxx(security))
> =20
>  extern struct user_namespace init_user_ns;
>  #ifdef CONFIG_USER_NS
>
>

