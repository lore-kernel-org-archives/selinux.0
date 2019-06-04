Return-Path: <SRS0=onaf=UD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C066FC28CC6
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 21:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A06A2075B
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 21:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FoqQVUgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfFDVTO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Jun 2019 17:19:14 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:34963
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbfFDVTO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Jun 2019 17:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559683153; bh=SL7mQ0GIubjs5kQG+Um9pNJVzd8c3aLxxQeWuVDzLTs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=FoqQVUgPjcy7ek2o/2feD2idQs5JBvmmy+JNiyvezpniNjcijGy+UrLn1rw1q6YGUu1Yvj7RNMRpkh8Rn1nKMVGSx0u9GJO+Q9fh7zji7LVybgEVZcFX5res6ORutRSosQb3N++zGUx5Rmy/2/hevhDd16aOBI/5apONB189GztQ8GJ/T7WyxYVSbGl2oTf2Qj+KiCK+NuTtliDQBH40X2q92MpXkglK9vvlGjjrSAm0pMnAM0REhIG01D6GR7dXvbrx0+rw2IKOyrRyxTwHkValmgfHiyN6BvtavaNpNAXU1zfa4KnHhCttDVeGzXtlTcwG/8qjtcW5lMhBWcpVjQ==
X-YMail-OSG: UlT6ilEVM1lwY6MVGsNFaZN2dKP7erh_k80XRabQE6wdaIJp7PdKJ3LNw5MenUW
 iWw6CNvxYlueeEJWFuBs7fKlAO00vpTCmE4w5tilMuhcuZyE6d8K1gOcwPCpiXfIwyE.4avBOKeU
 iQwEpCWFoOCsog7RcObVphd1q2GkWDjQ2S5OyjnE_wgFzeIqbb8ql_WRMJBKyr2Lkytrr2fTzV1z
 q8z6t1v_jrT1AymQSntVMPJwWl1kqx3VXd.xERdMJNdbzkCrnDjwglPhbmC6AUnH58B.u_BK0gy.
 eWK1jQPO.IKdO3Re.oH0NkHqj0AIHqRDJqpK1F1JDXt.av4Y1mJNATTPb8Su97m1Vkb5uTYAxzhO
 oRNfbEe_pXYeNZDnf9xiauZ.FMcGf8.sM775mKQ6BJgjwr1POH_s34piCmdcwJeE6CSyFex.J8l0
 DPT.B8iZX7zCILvR_rCXq.t5.25IyAlaBjxw1dIdlYT_2k_zmrPcS6Ws_UltIcoFU25kxLwxdOx8
 R7Tql6e6QY6_SGnyVku1U8c5hmk9HXg_m4tqRZ3NdT7KU.g1VLfMvXbAIIrrz3jsb9QFpwq.vZcC
 t7rAtXpZkWpXyJdEKYnZCfXwdQ2_2TzZr2cV5LwyQXjkiec8OzqT4rtxE_DQ2y3PBGVWyjLJCOma
 ZpBhNjwhpNg6n7Kw12kC_x7xgGWhawwLcBSEDgKiaW.9ecYLZjXoDxhg0qM3NPj3w.eksMRFz2tk
 D6A2tqeVzJlD.74hezS_nvmmTAFUikN8ZMkq_RrOu7wG21gGOxgFVCrAoCwXAps7bAk_6StVyV_X
 kb1SkHfwClT_P8aRD8pa8fck8AsBgrnXgjuoMyhvnucdqfHwEKcVAbCyMJwECkF9p5FtOraN6t2l
 9.k8gj6SwF2s8l8L9WH5TBR88IIQ_.HvztWC7hO3iB_xrn9rnbwC22fPQlZu9_hqUp6nsiXaoN5z
 7HqSRHIscg8.gH.5FghiP2Im3uGBfHYcDUUeVsymJEWNNiKD9b8WINmBsGz2dG.bA7qBJ3o9VSbL
 A_zOok3ZQ7dwm_0fAgTZ66u9XKASQs_urhqedTd47y.vP5xGTRQHknl3IUKRn7n.Jhddg8QI80NA
 YlXnXaGcSeOxVKF01AdVIwe_7OxlQeDEhd2fT7JuUJA6CFPuxrgGbkZAuMUiGHrWxkjk2fu8ROLb
 cTLpfN99g13k2baUw6wEk4S77kQ9Gm7_eDjmD7z06nZJbgExzEsG4sn7cDuS9z6VoXYEmepgK2MH
 eAFS7VexxdVBRcUoLhA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Tue, 4 Jun 2019 21:19:13 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6fdcf74cc65cf5e52c1454d7ff8deb05;
          Tue, 04 Jun 2019 21:19:12 +0000 (UTC)
Subject: Re: [PATCH 00/58] LSM: Module stacking for AppArmor
To:     James Morris <jmorris@namei.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        casey@schaufler-ca.com
References: <20190602165101.25079-1-casey@schaufler-ca.com>
 <f71388e9-a4c5-8935-137b-8eb50be7f833@tycho.nsa.gov>
 <66a87b0b-b6f4-74ff-2e51-afc8e2d30de1@schaufler-ca.com>
 <2a9049a7-6259-5ae0-2790-0aaf337c51a4@tycho.nsa.gov>
 <a493956a-8a2f-6239-e5fe-09030640c397@schaufler-ca.com>
 <alpine.LRH.2.21.1906050638550.31292@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <5c89bf57-b136-31b0-6059-6c7fa04744c7@schaufler-ca.com>
Date:   Tue, 4 Jun 2019 14:19:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1906050638550.31292@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/4/2019 1:42 PM, James Morris wrote:
> On Tue, 4 Jun 2019, Casey Schaufler wrote:
>
>>> It isn't free so there should be a cost/benefit analysis.
>> Some benchmarking is definitely in order, but most
>> of what's you're calling out as downside is hypothetical
>> or based on assumption.=20
> When you're proposing changes such as these, which make fundamental and=
=20
> far-reaching changes, the burden is on you to present the cost/benefit =

> analysis.

Granted. There has been substantial conversation about it
over the years, but I have not done well including it in
this discussion.

> You can't just say "Here are some changes and here are the benefits, an=
d=20
> any possible costs are merely hypothetical".

Of course. Nonetheless, no evidence for performance impact has
been provided, while it has been asserted.


