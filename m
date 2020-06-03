Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E2CC433E0
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 22:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81024206E6
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 22:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hq0i2axV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgFCWit (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:38:49 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:39933
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726645AbgFCWis (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jun 2020 18:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591223927; bh=Gx2XzRm+Z+xBtg5AfAZKtt2V3x0bnaPU/sVUutAaSmU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=hq0i2axVGHrVgEZvFCD9wApK4Mc3aVFpLVXGLCdYgq92JblGL+igdzROOM5atapvHTM1046M0/HuEdKABdBoJ7ratrY1weeVSpC0S7NkM0D5+j1e/yky/e8sSN77DCbZcVbFpP0yf/GG6j+qwcRgiSv+1KZ80SMbb8gTAxyRfin4AXfUSviiABLhWstLdvsT+irUzxTiWYNIuJqju99cO+E+Pxr5LnSytk3KIxM5YhHuX7nuNJGPaYOZkON7bDTnvd3Iq0s5oZHiE9mTs0uE+Wj2kPzN4TrHwp/yCU8353/0uEqEngr/WS+c5NMHbNm+YppZLzqImekRe7VZ6U4qFA==
X-YMail-OSG: djsLCScVM1nZlS1I4A.hTLOew4.QaqfX03Pz1mDKpph.6Z1q_iC2qVn4930VBvt
 FsVnBXPpALLqpBSCN_Pw.QDWBJfhnshdtFPSJdKIpvK.pZjJWCaVuFPMEOLo4RMfLX5YC.POm9T1
 CCq5CbsvB9u1UAUTbIY14jjftxdhY.Gw6kEbTmnVETeHQd9jBVSXQJifPuVNQaBxNmyi14hy5gtv
 6MOleISxrxKHKaUwUT8LEmVOlGBnnZyRXHAFNf81WAe7XmZLxDDZvhU2xASjoY_EWD9ZRSnAIcog
 P.hj8414UDA4QJyMLajl23n3q7rhb_U8h3YXcDTbCN2asTsVqFRhRsNX9oQ7_2QfAGVpaXSqLA4o
 CaZ7bMxBHhH4Rxw4yOJyeSz_A08c5ChiZ4hsSOMgA9aXTIbnsiENeJSHQFLcvUS9r9uzAyjwvAPn
 qab3idRHmKTDDJvC_LcC0pOjqsTOtkPNOF4nAnsuy.S_yGIH3Pftxk2VXk4tTP2elHAyn5SL93Uv
 7DCFlyBkX8QK3iZxvfqLmkxC7GYzsSAAnIPv6Vs_bDduzjy4uBCxFQjOOh0K96nNzN5s.OKpNdwY
 FurIV.NwUdrdGROhz_JusMn9XP2saxAHUCcx7K1Vb196B5Qo2oUeZOTqhVDAI.CtCY8brlwlB6Ad
 jhdnvYQp6gXm9UzJ9xUbeurmNo1Ww.p_bNfH7I41PfQp6B6bDLGIGUGiAYuzbB7YtB484RiAelHs
 eUnv5l076r_YvtURishn5D8ElMMZlIdlaz0ouNC7k2cswqTHGDUF68NQQQ0Y2qqk2k_sC88kK_zb
 a1eBAHAnmIsQq9.7Xpd0wxa8TnRzZV5RIMWhSgA4r2.xW3_VD0eDiHRVm78Rm5vnQfJrxqQ5fMYp
 T4d0l.txOH3sn24yEmRmCiZh4N.cW2meaKuf19t61kEp3iGQ3p_feghVFtLYl109EqGD4j.OotnZ
 8SFNe8D19aWIBc9NVvLs52ENQ0TizfvYYKokTXGpF7sJ0BYqq4uZtM1LmT2CWw55PTLf47hRjacE
 fN53V7nvDUFwAgImnOWUTm2jc_neICd6igcn4iruXcnA3Qxnqc8I0SlnluFHzNMvtDXbzrRrmwB9
 OUyAacPYCdBQM7nfjmBDodrLp6_d8_fhjG9wUEF1Y3y9ambXMSbqFZ3sLPR1b0UqzUGMIkRCEql7
 Jf2ox.ykN9fo7sxMktbAfuk2IjGpkzATiosjc4J9H4JlPYnUE5TeYmy8e4P.EOewS2dhBf9e3hPg
 fRPqXVicaF2882XRUQU6xC2DfqbkQd4OZQPXonC7JTUmWbd_xtXUfkmojJMdQIjcLnrdaqTIrm6C
 zXfJpWkQp.QADrK_URNe14dqkRtgNyLdJ73vhFdFYJIpxv3mqVklZs30UTTpeCRc2u61POc45Nce
 GLcOdU6rtUM2kteM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 3 Jun 2020 22:38:47 +0000
Received: by smtp412.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f5aa7d329c3647264f56349380598c86;
          Wed, 03 Jun 2020 22:38:45 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v5.8
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
 <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
 <290017a8-d943-570f-1f90-acecf1c075a1@schaufler-ca.com>
 <alpine.LRH.2.21.2006040809280.6050@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <761f5d15-3422-1834-7be5-8f3276d10172@schaufler-ca.com>
Date:   Wed, 3 Jun 2020 15:38:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2006040809280.6050@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16037 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/3/2020 3:12 PM, James Morris wrote:
> On Wed, 3 Jun 2020, Casey Schaufler wrote:
>
>> The use of security modules was expected to be rare.
> This is not correct. Capabilities were ported to LSM and stacked from t=
he=20
> beginning, and several major distros worked on LSM so they could ship=20
> their own security modules.

Capabilities has always been a special case.
Until Android adopted SELinux the actual use of LSMs was rare.



