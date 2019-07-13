Return-Path: <SRS0=bYD3=VK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB338C31E40
	for <selinux@archiver.kernel.org>; Sat, 13 Jul 2019 18:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7803F20848
	for <selinux@archiver.kernel.org>; Sat, 13 Jul 2019 18:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="K3R69ktN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfGMSqb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Jul 2019 14:46:31 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:43876
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727901AbfGMSqb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 13 Jul 2019 14:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563043589; bh=e5wnfmMsu2WWpxMRWeQEUGo557U6h5N36618l5JnY+8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=K3R69ktNaMmrZkjcTrWoNXutQUAhLhoDCY9MGSy0JytWDAZ5bulD0i0ltG6G6aAD3+SSeusuUgKUuCzYLahgfKaybgdsTXXIyrgQEMZeQ6Ikq/Nn5fihMLr20nBsIP02RQosW98qI9iO8PTz9FTOS08P4nricogoleDzpUg4vM2kma7tAMCFqJy9WLAz63LG/+3DsZAWB2QETwm/KgBMlTVCnqfl37VfFe/cj2wL39UvchDizp9xZq72QroAkMfL/RhzFa2gahR2QB4k5G2YCfooEYEaZ6ABqArQYJJjobkQvMJv+WsLuTr3/7w/zNejN/21yyK0vaKhHjvL/jwUlg==
X-YMail-OSG: cWRypYkVM1m7VxdPgMTkURA5A2Vm7gJzXCag2OYBMMe6WYoHCpi_FIRnDBuWRpO
 B7EhvSmdEo8.9YIXz2O4VkA.GTv1MIaL4XA4Btxx2J3IH.MWvkwyXtGRobj9N4aZVp9UCWWLNtFQ
 .c0zFNLakO5Xg28F972xoFedTyW70LWJfD9dmiFliEM.jyS5QTzWCU9D6Zc43oEc2.TRcF78o6HY
 qzecARtgAXaZZQ57Q7sUN4PMmr5TphNE8t7SgDZvu3djTsc1Jys1uA7xf._FYBbThefBoMfsBefF
 UknwefMmtsbmZK4sjgid0YFOiLWijEBx2J0PnmZ777wx01uMyqoSJaKw_v8B5SjeOYY0swSG31xU
 UMaFe1VVFSYp_GR.iKLJ2m.xSHqw7rVVhrLzzVXeNAIs_6LNKYdkQ8XBASN7omKpH4wkQLJjvHEl
 UerYtYpc3QhSAMZzlmNccGUtw1wTpVpigzo6DdV2nn_jR2xIEdW3ChZloFzYcdP07yFBwe8xP9m2
 ioNqb5JeUCO0JJRbe_1UlCsNgSue21h4TVYmaw_FF0LwMIVBdZWhYT2JfNOiN94zng1nac6Je801
 QdVOgmXHbF4jl0IcUpeHMGkewFVtFG03af5Gx5SYowdRrMpO.jLLPbLTyE2czGmQh4yPiQAMbLrB
 vZrOL5Xyx8c6rJF8x4wReXM1WXCV69ouwbMtmKlHbRbF7xAiMjbsOYOQmcFehkWTQUSOljqrkDpB
 oBBNPpOEYphYa87oKZSKiIjPwuqh_I85OW6a.6VasQwd8gwuZdLvMmO4H3oqntyQmmnh.b3WiwiY
 znoOBbCL1qz9SWw6WIFEzKmFwrtsFIfq5lNP._OR8ceJao3OuCjA7vpIOSeHzbE.Asr1IRda8_ez
 kVAI8UGmhsJECDyXTQyNov6uLpPv5HA0BlbbroOcv.dH7ADRGJCm.R8NtPqzwtbI9.Aan9U5Us2x
 .7Q1t7puN61Jt0nn0rNuE0nRqOvAp7p8ObFT822JHG9tgi7eJ.5ZZcbtHzcICKRhqFOE3iWlFAIm
 3pWR5XgqJQn6BYKBcRFt7JEesJVdM.AeJmxYHe9a1hvERO1H3aHJ.02rxOGuUYZzOC9BUFJsIiFL
 RSXeMCYTEo7nZh06UQ1o__CxiMrYRQTAR534E0aUi8uh_41cCbDU_5LX.Hn3rYcJ9de_rViCs_4N
 1fX2QAzwPMEMFdfGsoaZf5ompISqagkUE5Ubag6EbMx.P6D2sCTxC0VolQxcnjTty30eOvl2YW6a
 ygWmb_62sxf.mh58ajg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 13 Jul 2019 18:46:29 +0000
Received: by smtp409.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 19e0cedecd46ec1a75dade17c3b56bff;
          Sat, 13 Jul 2019 18:46:26 +0000 (UTC)
Subject: Re: [RFC PATCH] security, capability: pass object information to
 security_capable
To:     James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Nicholas Franck <nhfran2@tycho.nsa.gov>, paul@paul-moore.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        luto@amacapital.net, keescook@chromium.org, serge@hallyn.com,
        john.johansen@canonical.com, mortonm@chromium.org,
        casey@schaufler-ca.com
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov>
 <680c35a8-1ee5-725d-b33c-7bdced39763c@schaufler-ca.com>
 <e8de4a1c-7e18-fc20-e372-67bbaa93fd42@tycho.nsa.gov>
 <16cade37-9467-ca7f-ddea-b8254c501f48@schaufler-ca.com>
 <4fb3a599-b1d8-7cc2-759a-02195251e344@tycho.nsa.gov>
 <alpine.LRH.2.21.1907131430030.3804@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <16508448-aa29-1b7b-656a-0de41d8e68e0@schaufler-ca.com>
Date:   Sat, 13 Jul 2019 11:46:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1907131430030.3804@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/12/2019 9:35 PM, James Morris wrote:
> On Fri, 12 Jul 2019, Stephen Smalley wrote:
>
>>>> If we want to apply least privilege, then this is a desirable facility.
>>> The capability mechanism is object agnostic by design.
>> Some might argue that's a flawed design.
> Narrator: it's a flawed design.
>
>>>> I understand that doesn't mesh with Smack's mental modelbut it would
>>>> probably be useful to both SELinux and AppArmor, among others.
>>> I'm perfectly happy to have the information transmitted.
>>> I think a separate interface for doing so is appropriate.
>> As above, I don't see any way to do that that isn't just adding overhead.
>>
> Agreed, and even so, part of the point of LSM is to allow existing 
> security models to be extended to meet a wider range of security 
> requirements.

We bow to the wisdom of the Maintainer.

