Return-Path: <SRS0=4X/7=3D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7C2C33C9E
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 23:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E47222C4
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 23:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mW/9gqOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgANX73 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jan 2020 18:59:29 -0500
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:39958 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728848AbgANX72 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jan 2020 18:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579046367; bh=zpEQoE71h37YGQf8xNIWDqiL3vD1FfCpR3LenEFeHsQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=mW/9gqObIfJmaO09vblkjZu/+rjP59ZTtQF0AdRp+0FqPsh/c82+lXTLwrzrys7inn2t05VxGNNz/CElh77S8QGZxxoq8/J2TCdFJ9w53wBTwudR2708qdR4veCy0wsEh+GWsv73FWI9HYAJ9NP4QVUN8vCmLPU0EDchGA0y6yCDaqatl/dQVfRnLUwopRyc9mQUP1fMCzy16gE1Xe9LdsoZIs1quhhDE8Ej8wAu6x0o1jO9dHw3AdSpj2Bn2s4kwiNK3PmCx893+ldVhdhi786aFFC3WZujTJRyOXdnZGVRQw0H04kp5AysVDFlGNVIS1e6Gln2joFqb1bBMkekJQ==
X-YMail-OSG: 7DDDNm0VM1m91zIUyjeEk6xI3UIuxnZBuEptD4HhOQOviteXGajkKMF3rKEGRN9
 IE.b4ALYHom6OZ4uC8nWOnctg4WOGPKFvB2MsUZMhwpxTKlMxYDUgQyGPi_ienxKvAQvmt1.CcHB
 C_IVDWeEm4H3sp97z.42qyInd_SoRk1MilI4cRqN0SaqdN0IRVBQ9aMQzRdCc4b9raGmonnHBRqh
 WDRw1.6NR1RZYc2aIA6_bDovMFPfxT3Cd12qfQJU2_bIlA1C8ftJc6ht.YsMVx.WdrptaEN4wMZD
 2d1FwBfKkqLxjrUhNVZ8S_9vvr3RL8fzHvS6pi1KN93SGLeH.UjEcdqXQ6awCFZ89Nlf1dRERP1S
 ZxCVixfmqT.bcr2DId3F8wstgjgCMUR54GBE8hdmLfSjYkjx0Ri17a82HxjsL1OA.TKbFUvKmESu
 NS6tB4B7VCVskLfz1NH7P0KChAYZfdROtsl96fHKvbpkYg3QxwUMXFn4YM71QQQm_SarPRrUyGvL
 yENxcuth9ucATuhQHRE6etVEzHNi6LLepBkpKkPkJWw9bK_BTCWF4trKgQG7itC5luUToaLKg00T
 UulALuHckQ0lg1R6mPgfXNdCAds3bj3F_jolVZddJsnz3ZOQmCt0vweA1keDdgllw8.uyBnUv1Qu
 mU6WthWTyHk1Wc2vtlUHQ3SEXgqzkB4GMBmi2gcxRjBAoVsu4ky2J60e.YsWCU_icGzLszeRaEWB
 jjSiu9IAh6lUTnw0Cw1wCfj_p9ugAWwYPkY5bJHeaYdyl9b9n8d25NR3BpprRhplR.YzVzTK94CE
 cQhjE2jwi6gyvoD_tqRFRUdTGCoZHIwKZdQRPHqTFLegYnCbwzvFULt.nrzaVtFDe.sBNj41ciJx
 Iqb8iLzLFZbC58IddQysvkH9BhRCS.3VaCOqYnDvqHE0I1LdgtEGszmoRXmNvTzzJB_1wymg9g_1
 oDS8wPKR.292uGQUYALmcEIQ5CqaUWOXHstppEgel0YZP01ay47Ai.xkflP9X6Ekom3Fq2mYDOGP
 B1FIAprh8BzHY_0sYOh1V55mHx5Twq0n7XZh5w1heZwXghdnhSuqJsJyx4nMfm9Z6jwZlayDZ3RS
 Jec7hrxK5YGusuM4_W7jc58z2ykf5.DGqOtYHmIzprJrfrOb568yICX2Cljbp0Rivr9qzzNpTQxg
 1lBEZ3H_DEhSTuazBaDMCk84e2TSxfozIfGouQI_fVDEODEo8zDFe4MryhSKw9_48fCEpVJ_GkgP
 HfdlXODyHqqWYyjombtbOr9ZT7Zv6kdi0wZdzPvcqpTRkecLzYiUohRX.Ik4eBOQNwOtjhxyf90r
 ckfkreaDlkX4AMvuuHjBYpeB24kQhkrv_caRPmx0KiufKCo0soRHSUs_50YS2ZF.LDpSPNE4T3b9
 oZESu1Xo9SitQUpooAyF.ZmF_RzNnT.0VFoYP7CieN1mlZhg5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Tue, 14 Jan 2020 23:59:27 +0000
Received: by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e324bbe8e4fd9cac429457b256cae513;
          Tue, 14 Jan 2020 23:59:22 +0000 (UTC)
Subject: Re: Perf Data on LSM in v5.3
To:     Wenhui Zhang <wenhui@gwmail.gwu.edu>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        SELinux <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAOSEQ1poqrUQdRc+ZLNbEoPqgd4MMomeYmefjca_mj-2zxrdUA@mail.gmail.com>
 <7ebd42d8-5392-90f6-fc08-4364176cfbb6@schaufler-ca.com>
 <CAOSEQ1p0q4gxVwN3MJkP=xxn4GUVaKsaArtQpxNy5rv7vYvVVw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <3993c054-8094-56aa-b66c-1f97b325ca96@schaufler-ca.com>
Date:   Tue, 14 Jan 2020 15:59:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAOSEQ1p0q4gxVwN3MJkP=xxn4GUVaKsaArtQpxNy5rv7vYvVVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/14/2020 1:15 PM, Wenhui Zhang wrote:
>
> On Tue, Jan 14, 2020 at 4:08 PM Casey Schaufler <casey@schaufler-ca.com=
 <mailto:casey@schaufler-ca.com>> wrote:
>
>     On 1/14/2020 12:15 PM, Wenhui Zhang wrote:
>     > Hi, Casey:
>     >
>     > I just performed=C2=A0a performance check on=C2=A0
>     > 1. v5.3 with DAC only, and=C2=A0
>     > 2. v5.3 with DAC and MAC framework, an empty-policy enabled in su=
b-modules(e.g. selinux)
>
This is great. Do you have data for a system without CONFIG_SECURITY?


