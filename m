Return-Path: <SRS0=xZUV=UF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A605C04AB5
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 21:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF65208C3
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 21:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dd1T+xxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfFFVGu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jun 2019 17:06:50 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:43017
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726969AbfFFVGt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jun 2019 17:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559855208; bh=OT8bNURL+8m2MCBXt8SpThP8bgOSbSp41MjTfKtmrEU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=dd1T+xxQ9vQGRzVxxGsevwDLPRfevx44s7WrGCGjKHN8fEctB6OPqnTrBJ4x5R/jaDlUNnMb+FiICFlTVZbGU/JN9VcG5AB+wdMJ3O6omgBPoJaqnb+DkoHzh3l8FYkD2Yziqbx1dKdSrSvVTgMvfqViioWaD3Ghw6BWhqnGXhZ3cYj4QSlfIo0OBfmeqqKGUvTGvEPz8K2gYBSfhkc4SaN7LOYITTehGzrJtp6KVglgep3TdDS5UCoMJae5kbuWoQgHZ7erbkME/7X5fm2KSFZGfSpfkMuGzLcoD5NGFTHmIbygFzKkWmTW342yXd7zEDWIhXatGpVUDVX23ZrKhA==
X-YMail-OSG: UKgAZjsVM1nxcczk6CrSpC5QaOxakR2.jDzRVoRTAluJB5d6euC31hsfZ2C6LU9
 NrDBaIWl9DCedvRVP7q6vBZCGdB6yOZ3NYyL1lTZbQ98Gh9EZ_CwE64RkhBl3YRL_SYvGP_V05Jz
 pJmAAoHhQZSm6SCLtHkUos6wl0sB9gpDDdXbrT43AKAHKKc6XjkG33Z4JljHgVyp_5FRFgInQSMQ
 pMvCMgyp7v0GuVex7Z42CwmdPJrdud2Dc65F72DZHrt6z0fdLIQfwOVHgeKqG4AviUr0vHsyMyFz
 HLyLkHa1RbJ7IXTrzbsXSoXPyW50MyVm8lWn1wzl9CDavqhA8YPCxEAEOTOZfWQ4ja1t0ybPpwVU
 yZYpkGv68knep0uB33DCSLYeNYfBk0rHazUX.2b_79WXucHkkSpTvpdNjyHyIwXWNDPXW72kxGIe
 yDge_y6dd6DCzafbtrToiJV2K.0xj2sZ4hY_Mpqxa3lkvnMk.4O.ORvdyialwDRjKDU6Vntx9MOu
 mtyMa9Dv5DIRdpv6uHzizIXc92t99RWcizXLgX4.Oo2FbruBAyBy9V7gK_YrkjGuYwA6BcqCnYWy
 JU1w_2hOIGGUL2.BUkKuyGpL5ggmuVwHi4rm71hxGtHnzPBS8y5qYd2OWYxQWLP9Ckhupn4_rC6Y
 0bqy2TDvMPzfzTMQK6XFo2wE3gCTAaS8lmlhFpsI46A5dclYD6yllE34HQxzs0_usU_lsL9nPWrE
 SMCeY7v0bz8cNkKdSUpMFwqjqKZk8jL42RQYeUlZWXWqi2Cx8lKFUWPZE521P5TdE0uhJNTOZisl
 XpTDFEW3l3ah87aHFS6zYr4oPnV4BeeMmHIpuF612HSZ2blHcN2KATGPwIibsol8UZT3ebgoNm6d
 2wSI_9DOAbhlWKtmjqFMO4YhBLTuwrrcFnbZUp1Y79zrovngYvuprCdXKwxO9EzqjZuUXPnJegwH
 7AhOcHIY_LHFt3EywwoEwKLl5lPTv3Vwnc2ASjSeJGcRMkJ1QlbsQVY2PkwEEP5rq_GpL7s93it_
 Qo_t3zr2rYtS57kOT8cYpz9m3pka0y09YNRywFzecBqs_2nzM.N.vhWn_.oUDhbK_RkKvFx.98NT
 .7vGucrOqC9XUzqnIufbggz6mkrfdnIaMj2pECcWLBlAcExzoU9aDxuILM1C5IBSyni850jCFEtG
 1an8ml1Xuqko2gB5CQx.184sjTkQOzzCxxFr9jejYEiA.52U6eot6K7whcXn5F.neujuFdKRzl1Q
 QyfBs7UuuF83sbpE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Thu, 6 Jun 2019 21:06:48 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp432.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 31404dc91f7aa1b57539d6d64236b05b;
          Thu, 06 Jun 2019 21:06:43 +0000 (UTC)
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
 <dbafd99d-aab7-c497-fbe9-fe467b0c237a@schaufler-ca.com>
 <201906061351.B12D10D5D@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <5010ae20-ce00-be1e-0c2b-7568282b6b39@schaufler-ca.com>
Date:   Thu, 6 Jun 2019 14:06:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201906061351.B12D10D5D@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/6/2019 1:53 PM, Kees Cook wrote:
> On Thu, Jun 06, 2019 at 12:17:42PM -0700, Casey Schaufler wrote:
>> On 6/6/2019 11:41 AM, Kees Cook wrote:
>>> On Mon, Jun 03, 2019 at 03:23:07PM -0700, Casey Schaufler wrote:
>>>> Maybe lsm_export_is_interesting()?
>>>> I'd love to discover there's a convention I could adhere to.
>>> I'd agree "lsm_data" seems meaningless. lsm_export does seem a better
>>> name, though it has the "export is also a verb" issue. Would "lsm_context"
>>> or "lsm_ctx"?
>>> be better?
>>>
>>> then we get lsm_ctx_is_interesting() and lsm_ctx_to_secid() ?
>> Fiddling around with this led me to think "struct lsmdata"
>> would work, although maybe "struct lsmblob", in keeping with
>> the notion it is opaque. Leaving out the "_" helps with the
>> verb issue, I think. I think ctx or context is right out, as
>> secctx is the string representation, and it would really confuse
>> things.
> Ah yeah, good point on "context". Does "blob" conflict with the existing
> "blob" stuff?

I don't think so. Some people might think it a bit too cute,
but I kind of like it.

>  If it's always going to be u32 data, do we want it to be
> lsm_u32 ?

At some point I would love to have the Smack data be a
struct smack_known pointer, but that's a future thing.

>  Or, since it's a multiplexor, lsmmux ?

I'd rather describe what's in it than how it's used.

