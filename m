Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AFAECAAD8
	for <selinux@archiver.kernel.org>; Wed, 21 Sep 2022 19:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiIUTKk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Sep 2022 15:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIUTKh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Sep 2022 15:10:37 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCEB67475
        for <selinux@vger.kernel.org>; Wed, 21 Sep 2022 12:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663787435; bh=w9KIWMFQdeDJ4ZbLTO8Vog4yWxnLP/2QRgO66wTkMG0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=mTRnZnXsmA5oYVM5hP+5Ce055EV4EngSi63Jc7rzzhn0swuH/gAxnWZcs5nX19+IwDhtfYrOcp1wlyIKZGQ5wSCPoJE3YXypWAGqC4QE0KUHalVj79WqEyWxMIokqefYbvpq5/SLcM81ZhS/WI7lwpEOgEiskC2vWyZOgH0M/5xenB4UBVWMTQbEUV+e4i4O+1+nfKJCD0cHoegnE/QlXas01qoQj64niZmmYlj1+N+mmpypbHC4SWGFpmEG4HpcdWoNDIi9mWloqeGBo90yQD46n9JupcvaPkQlIAqjwFXlhzJ6DthXOQoQbb+IOazzv5cock7yI3tVRRzxqmCKTQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663787435; bh=EmFS1eH/mqnwNEsSf/l3Bjnyuzwi0hd3fUbtvEQYtEw=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=F3TMxgcythaAqeBbpKkFq2vmNIQzJjogeJBfpRSgAGa2Ww6DeKyJLX1Ca67/uxRi9N/Tw7uvcjaA9DukHYbvvcbnbK5dcK5hIWzPnQ60pLv9aUSAOpFqL0KlJKEaBZv3RO8kLt+Oh0+G6gVzWvJjmiLDgxTehc+MBspZ0kx2/wic+FQC4DMIov+ZTCcmzIwngn7LEPlcCjIaPQNQXNqXKbZjJyYh20dJ4LkSbU/MSm13PQAgmqjYz9X+Cdg8U2cLOTMGgz/0XeUMx3ivBc7clLHZfL1jvjLuatt4ftR9uSrlHJzWCdCjEMYh3ISh5kirJCBzbN/cDNh6GmhcZIc6NA==
X-YMail-OSG: fxoPkiMVM1mvr8Bb7x.M2q3zehzJtVpMDyz_QuO5MYBzTocj2XSX4Y7kqVhHfnG
 aLCSP8n07ehxVA9aq8OU.nRN7KQkH5UL3TMilb.xAl1Nq0vrD0NDhPD852.lh6Pbncko9TRz00Be
 Z65T2VK5dLdLi5P2HQHzdqFEVwkXiPoAwuVd1CLIiUf9xxn7oJ1Uz5.Y1XK_fm.JOnomVPSNuKXV
 mnyTpWgBf3d7.zh2ZysYIcI0UE48w.OrU1Yga16JjsH8JefbDpepsddQ_PKzUrlZj8rvRbRtlDCl
 L53F2dZArbgMmHAhtiwL3yBA8.yaRNQ2FE7ye9vPMKYsjryLHRFfDTKdRve8fz8nZOciUm5FhJAz
 HxMKhezOFKdfowuFjijDdkzdsCcvBJ_e7kJET2KPlAqdGCxkBa1_bxvtB5Ry1cyponPhtfRa6onb
 bl6mQUeZSeWhdgI8ZpOmWybyEmD_VUUeyEnMdkmA6O2pYzECipE9pPsOsDQV.9.gPtMNkFsjNv.y
 LBQQ.7lNxbrsrLptoHGaXnY2mw4VgcQ3kzbPt5jCQ39o9a8KdXGG3qH_UBSufjhhk9pD7Em6c5Pn
 IUPPBRtGk8PERVyniGvGDjc8cfSHEJXe7DK2aeUiRjEKEH7cslnostH6zPPZsMxqMkMAqO0MWIeJ
 3xthqMexh.usG9KwtbbcFf3AoCqdeLQ8JK8N27kav7PgU9vmZ0mpr_w7AdBi5AFQWL0IBU3XrCNF
 ovdWo.sKJldkxNu5zd1bzL3fZR54luLOtXQiEEu6i.iqXiMD0E31vwndBK7RZ4FM5AgbvhTpibkG
 U4fmdo8YFeM6rYoIdUgHj4tJNp3PfU0hFGFnfFosVy0EGLgh6TQRv1M3AGlL.DEIAFLS_0B8dBw4
 ysAvpW24tzLx1GHLgwNt_ASXNtBB3UyQqjLkRwmawOPajB0JRBpuyzA9WTTiKbh_8UIVdhqPBtDg
 Adxfan6fFXdBSXVTbKKP3U0JPI7I9EXfc9u3PPKwCq6mMdsLflDGB49sN2VxqFDZwcNEfryAwNYj
 L.5M1gpIb21yiV8qeislQsE0Rcy4XLp1JPXNQfVT7ea8uj2mf_gRN7nR6wna42qChkYTvgU1GO.d
 vmcsQPF1hhDBMl0KUVZB7GkCxY2eo2ExWJnr0g_M8YQvS3g2yDnoZrl5DGI54TZzY4C_hG2nae4F
 hONuZLOEgUHZ2GP1gY9Gbkz_IKWt3m4vgP72G579DJtHBK8TdGwus4CY9s05TDn7ZIwo61aHsV3S
 w6HeSn.kiozy.Yz4gaOPaZtj3o5LmdWK_wCri3FwreAYe0epMEa4S5W0eSucZ6.lu8y6gdwr5H73
 rxoo7IpvQ2pxP__csN0COuyQwtwRWKi6AQmn08ylNsSjZEBA36tXdkrpFyR_PEpAYHHQrjtoOm.s
 q6rW.jmmkM6Z.nUp.Hu7cg5hVCV0lBUtL86TFUeQvUF5MGnS6NO5HjyulwLYwQi1m82jrMMqfszb
 ZUty4Ln9tGnEedDd0nX9JM61C7kcGsWPH9dmvVUtm9caf2VPtkvKn_U_6hRGOYxfANDCcoOYUdvY
 DhnH3RFJkAGWFURIrwSEnUskGSUKjGpg94D4IwaxTeODOpJ_rLusCvDCPbkXXV3ObV8LuNxQpICi
 uqm2pSb4zz87uwb1XI57gsIHUZFUq0gA0s57SPGLjbEoheeEWKEb9ImbKaiQD4yCNQ9pZgMtO9bq
 9ufCMj7IY1ihF456PscnPQKwNNYNhFyjcOQNx50VK_OeavKML_ddVxafioLuXbrkR_EjOkpNZxXf
 iJ7PPJ4DQhgnTpvsyMmjNn9eJ6WX1XcAm9Knswv8L2wSYr1tB88eKgwol9Ii5SnCOaUMdDNu9u8n
 PGQTJ5Y5ZQ_xdJX_uixgnQFilr1hmROTtU6Yxgl8EGmLUkwH62UW0c6.D5DaYCm0FjQChGasRdT2
 ligPLEGMAiGTqtUvmdGbQaXuNDWxhzJBWRtingoNkIVNOrJphPDaJi.9C81_zutgniZEiFordz9T
 oz5xbBw8TsB94hAEPyHr_CrjGI2pf0s8maiky4bRGaqBz.ITaqoFatD40TEhjSgl77z8gpE02wOL
 jZzKSNN73ERr8z3R.UNF3sr.L_XOpNGC2Ynisq3TlkLvbwOwfr4Q3fbzRXl7eZfCcrDoLj8sMpI9
 hARr_QtoPfYa3NEMGazSym927OvJP7xEIhKI898XaIA6fjJM1fKBFahm39Zt_CCOOOiw_cocsO87
 0H5e9ADtdp0vPA2Ct6_yPKXNJgj8uCdt2D9_a5KAc
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 21 Sep 2022 19:10:35 +0000
Received: by hermes--production-bf1-64b498bbdd-pvbhs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c542988d0e83e1f92413f98b3eb38b34;
          Wed, 21 Sep 2022 19:10:29 +0000 (UTC)
Message-ID: <6c7f00d2-12aa-af65-1f3a-0087a1744633@schaufler-ca.com>
Date:   Wed, 21 Sep 2022 12:10:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/1] Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
Content-Language: en-US
To:     jeffxu@chromium.org, selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        groeck@chromium.org
References: <20220921185426.1663357-1-jeffxu@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220921185426.1663357-1-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20663 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/21/2022 11:54 AM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> This patch was originally developed by Luis Hector Chavez
> <lhchavez@chromium.org>
>
> For systems that use SECURITY_SELINUX_DEVELOP=y and allow permissive
> domains. The audit log from permissive domains can be excessive in
> practice, and this patch is useful to avoid the log spam.

Doesn't this defeat the purpose of permissive mode? If you aren't
logging the events that would have failed how can you learn what
policy you should have? 

>
> Luis Hector Chavez (1):
>   Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
>
>  security/selinux/Kconfig | 10 ++++++++++
>  security/selinux/avc.c   |  9 +++++++++
>  2 files changed, 19 insertions(+)
>
> --
> 2.37.3.968.ga6b4b080e4-goog
>
