Return-Path: <SRS0=xZUV=UF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05669C04AB5
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 19:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DA620665
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 19:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mAAhsi2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfFFTRr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:17:47 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:38788
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728996AbfFFTRr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jun 2019 15:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559848666; bh=a8EKIIW7w6tesB916dSo8tE6sAFsF2fBb4gTC4Cuhxk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=mAAhsi2ebOnL91TaeC68N5OaZDwuc4yruxmZdYH+SxX1sINxRxi7Kjkxrr74oIDOngLMAuYIbKFT/yT+Fqm8FT7aHtx1X0g5lDIoPiL5QZ12cJJO1VrnQvHs4nvuihhIltynHWkyY62EfuqMk2ploWV2j+h0FAridVPaxJMSSKA6xGvh8GG7IowGLhDftAO8AcNhj4NCl2xh6pJ6MF290WsAObyCxKGAuq7+UH3iEh/D3XZZ2RWpvWEEq95GSf+ubxy0ay7Kb7FxswidU2BMymbWinYE6V1MfQ4EemDjlYUzo9tDu7UmXvAq2TzdtdR+TBORy4VJgHhIdL2Cu4+9+w==
X-YMail-OSG: JGhJF.YVM1mpRZL6WqB8SWwAfKaRRN4bAkrS3dYq9Kj.3HjLG8zqQSHmCjhrzGX
 rkKM_tpS1rVWnzW3vbO1BbixCVVzUBQKZ_18MCJZ0CVof_Rs5tNr.DBwyk22Iaj.egWuXlF6MIcA
 t56abXz_1t7jTr84uUe3fsiU_Il_KfAVuCJHQ4eDUMxO3mceatDz5hXh8O.8Q_aAUG46hTeo5u_r
 t0KQPlW6pWn27SDXeD2nMtYdtwdx5f5dLcKH0DwM586Uq9PjGO3nSblqC_Ci72kJoP5B0jK0hANI
 tVw.rNnpVSMyyfoDAn.Qs8nmve85xFgBpLoCzHO.skvcx0Gw7HgiXMvbEOaibihLd0QuZtLclfYh
 QnyFdCUEpmiRVK04qXJggTPAZWaEIk58s64JDyLK452AKBVESgiHYmC37wD7O3azoee.dvP5QbBL
 srVukkHD6pTHksBtNt5mqFqFsNQY7xll9ztpATx6ewwiv4s9mi10HvcMAh6n2_ixBSUpHWpsi16v
 Rayqh5_fWyoQbBmmLpQcr4kCnoYhz3UGIUaVQhabbWvyswHMzUxuYGkiIrMsBmk11fnOsRqG4xwU
 HXcyiDJNOZOgEt8nhhQdeDXficIb.cOJVG4aTcedzldj6waIR5HjpNYP6GO__9ttiOZagxiBsBg8
 1ZTM73NE2Dbp4rJb8kDFP06dcVHq9ZawW8u5Ck3HfK_92dMlxWkUmbuFZDVwY5UPbWRxSZ6TX4Z.
 EIS_wG7fhTpHp99Z2aIcNUaO4OcFDQRRCNGEzPsHcyGIsNcbSCmQ069Plx448k..fVGFceE5LUvn
 w5wPPM8TtYlS_.5uZQmVJfVGVbsvMKuxys2LO0ZsBu2g1AI3M0.HaftqgyrFQP8tDk0fVQD63pUY
 v578XQ.MKrtk4g9VDWNq0ogOx1qWgF62jG_bT.XnJwUbdBztvtNihX3J2owhVBxEl1rmXAE_mjLW
 r8YcWIldeSmtzKa5CgN4Qh6wbe3JV3PNnquOMMl2Xt4i8LTvS2VITZojkGTEz.IsJVeJK3A6Lutv
 PBKEF7iWyKCstjHIuMCACP_HKJzXaK6CvPTH_fbOQ72A9TrEcebUyIkTnGKqTYZctdL5OIMpI3TR
 BifmV.4QtNzbmfd32lQHIfP5yQNIxuI64NP1BOTqeuzfF1.tLhBk8hVNXaiKi2Q.9uyKTXlZ95us
 6x.lTj8.qpKVhqJkG2WlarrDO0hAdfNr1zGvwkT.q3vLV7vmczO64shmE6jY6fjRFx163wmxpC2n
 hkHW0LVsOBFQenvC0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Thu, 6 Jun 2019 19:17:46 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID fed3dccd2165e35e8871785e13d2df34;
          Thu, 06 Jun 2019 19:17:41 +0000 (UTC)
Subject: Re: [PATCH 22/58] Audit: Change audit_sig_sid to audit_sig_lsm
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-23-casey@schaufler-ca.com>
 <201906011900.143B72A@keescook>
 <79cc3300-450f-5263-9b81-3186f84010f5@schaufler-ca.com>
 <201906061138.BFE4CFEE@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <dbafd99d-aab7-c497-fbe9-fe467b0c237a@schaufler-ca.com>
Date:   Thu, 6 Jun 2019 12:17:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201906061138.BFE4CFEE@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/6/2019 11:41 AM, Kees Cook wrote:
> On Mon, Jun 03, 2019 at 03:23:07PM -0700, Casey Schaufler wrote:
>> Maybe lsm_export_is_interesting()?
>> I'd love to discover there's a convention I could adhere to.
> I'd agree "lsm_data" seems meaningless. lsm_export does seem a better
> name, though it has the "export is also a verb" issue. Would "lsm_conte=
xt"
> or "lsm_ctx"?
> be better?
>
> then we get lsm_ctx_is_interesting() and lsm_ctx_to_secid() ?

Fiddling around with this led me to think "struct lsmdata"
would work, although maybe "struct lsmblob", in keeping with
the notion it is opaque. Leaving out the "_" helps with the
verb issue, I think. I think ctx or context is right out, as
secctx is the string representation, and it would really confuse
things.


