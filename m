Return-Path: <SRS0=VC3m=Y6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D67C5DF65
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 16:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4932075C
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 16:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="m4nOtgXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfKFQLY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:11:24 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:38796
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727321AbfKFQLY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Nov 2019 11:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573056682; bh=CrZAz+Sj5gDxFZPTm+BtkRmc3G8kO/Opjnz0eLUZQvg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=m4nOtgXg14KNHf+qfuVHMaZaC2+5xX/4Ud5owwuMc6B0zs1LSIF8wfpAq+yWI772pxFRmfo7LHe3Qx8kGMeq7YSmtleD486Jf9vusU+TzNJkjeFIJGXMd6sUraxTcNSavSohsz1E3p4OPPIpKCv/iSzBRTrJjxVB5YcxrCceiJgZoL4aBvp/zKYxPAHp7HxU0LnLLNAgBcHX3U9Ot50tY1v655Ce3MG/qJwHIEp2RASsusfUwRTsbrg3ZY/qFlCAfVkVvLrsyT/sLgiE/WwG7xX2Pep6T5TivwdAHGSq+1iUDvaj0kfHJP2LtGtuwR39zr/E3mxfuuABzjQBZ6sPLw==
X-YMail-OSG: pR4z7LYVM1nnjdFa2M1NpdsppqwdGdmVzMOiki4rAmOZqTqr8fMw..XOaZKSw8a
 UF7X7BE.5QDrUGADlXl51LDR7koFA2hl1OtKqyOLCH014qMNg6_bkPfx9apywdcM.JVL.qFdxOFb
 43mZtdtsSrXUeg92UPrqRtC9Dlvg4RJAr4Q6tZk21SmSY_LTYY6Oh8ZsTPe6lJwpLDoA7xpnA3Rn
 5WbHSELvkJFopUuxZdP3Fp.Y65hgTKa0aeQXBgJKuPcjLI0f0y945LQCmQ_W3EAt7NoYqz5pc82Z
 xVpmqjoSg0l.kV8qfwAomqU9bflQQwZSfWfSRG4gXCWnSeRBZ3Pa7YJoC3quW7c21CyTqIoophh9
 xdJGTbNz2Ei4OyPLpsLmpu6SmkvxfJxsX7tB2DZxuUHZoG2g1mbdL_pFEuHXhsqM7OO3AZYc6usF
 YHPgjxWMB3ymkmr_X4cpXVe8WB2QEHsjUDQ.QP8P1wJGw2ZaA3W9SQGPuJ8YSwpSTrfxjAKKRYU_
 1M721ag9OBRqfVBW3a3vVEkWi4yq7yhGNTekDRB6hEbBjBeApLHrB4tf5VxfmiXWjaPIptKL0Apy
 HS9jTiDNEUdtGFrKmzGYxuvASDEiAkied9DSPP_RqcB4QL5i4R5MNRyU.iZAK9C3gR8hwmYIWJma
 L_dG.ndKm4PzLgG.oQ9VQDgnFXxkXflwr2CqrICMq025RGSLWSSbV2FyUt_t8H.zvqIyYRBZLkUx
 .MgR5K0D3ZJTSrx7oquWyr_CFTHUfobUMB33tIu3IInuWX9xdEs1sWGSnubMb441xFu.QJQ.r7EH
 Ix8FbWviy7AOhkwIusld8vP4X61n_zLomztCcSgRK9Kxbl0oxJTYKRd3obtyuUhZt1kY2MMBqNvj
 0tYQHQOwLiFhZ18oj9N56P0frvjEAr4E9kl382q8olGPyynznhLL2SvY9IjjVWCOdo1c9w79xT69
 MymlklwEGS2fOrewm.nlLjkhzOcneIk8endMyiAlDr47PLqJ1isXp8bN7Dwc0PC.Kjs9A6oR5l9E
 x9BtI.JGEcjoJO4_H47O53awzKgovlzybhkU6MPrGw7R3Hf1hh6Hbg0epyofQt.ipbuB3AopnzLz
 NrAh4fsSRsfiQ8ALkb.DxAo6xq.MT75RkXv.hfH0GWVKbxR1sybHzhWTWDnkM1bhfh3QPzRKum7M
 2wG2QmDZgFwj1q2iUEoqINHz8fBEsHxM_Nfbe7w1dE8kyKu1A0XWLlkafIEh7n_eTqbkxZ4909wO
 RFTOdd0kK5Ut8vWZgev_SiKW3ZTE.X9XP4zskwxqf3Fc0524x8qP9L43SAc0GlpkPogy0GCTll.U
 eJVgZZTglbQ.1371KuRMteu5sADv1AXdrzSVexC.MBLv29ZNLi7.3MPCT2JfQGRP_xXsPXnFVpSz
 D61WHfsc_B0HYmzfgJhnd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 6 Nov 2019 16:11:22 +0000
Received: by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2ef20c71a389486de47b188df9650803;
          Wed, 06 Nov 2019 16:11:21 +0000 (UTC)
Subject: Re: [PATCH v10 00/25] LSM: Module stacking for AppArmor
To:     James Morris <jmorris@namei.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        casey@schaufler-ca.com
References: <20191024205228.6922-1-casey@schaufler-ca.com>
 <ce6c4861-2767-89ab-bad5-f633a67b3fc9@tycho.nsa.gov>
 <19e2696d-ab07-21e5-ba22-4ffdcae3c97c@schaufler-ca.com>
 <alpine.LRH.2.21.1911060238410.30342@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <0e9b813b-a658-ea35-b2ee-90f013fe2500@schaufler-ca.com>
Date:   Wed, 6 Nov 2019 08:11:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1911060238410.30342@namei.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14680 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/6/2019 2:40 AM, James Morris wrote:
> On Tue, 29 Oct 2019, Casey Schaufler wrote:
>
>>> Can you re-base on something more recent than v5.1-rc2 (that's the ba=
se for that branch currently)?
>>> At present it won't even boot for me on modern Fedora.=A0 Two key mis=
sing commits are:
>> Sigh. It's based on James' next-general. As it's going up through Jame=
s,
>> and he hasn't updated that branch, I'm sort of stuck. BTW, I have a re=
-based
>> version, but don't see how to get it into my git tree without mucking =
up
>> the eventual merge.
> Don't use next-general for this. Use the most recent released kernel if=
=20
> that works.

On 9/24/2019 10:56 AM, James Morris wrote:

> I'd probably create a new branch (next-stacking) from v5.4 for this wor=
k.

I'm planning to switch over once next-stacking gets created. I've stuck
with next-general because my understanding has been to not rebase unless
necessary, and to not get ahead of what where you're expected to land.
I'll rebase now, but fear I may end up with git tree issues moving from
security#next-general.

I am counting on getting next-stacking shortly after 5.4. Let me know
if that plan changes.


