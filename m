Return-Path: <SRS0=r71v=SA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E83C43381
	for <selinux@archiver.kernel.org>; Fri, 29 Mar 2019 15:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098AF21871
	for <selinux@archiver.kernel.org>; Fri, 29 Mar 2019 15:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rUfFtm/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfC2PWo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:22:44 -0400
Received: from sonic302-27.consmr.mail.gq1.yahoo.com ([98.137.68.153]:36357
        "EHLO sonic302-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728992AbfC2PWn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Mar 2019 11:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1553872963; bh=XxfoYfDV7GveqTi3MJzPeWXcKvLpJ0Refbu9/OAASBE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=rUfFtm/Gf1oIPsIcMb677E1Xhu+xb9pYYe4XgCE1R8EjH3omDiTSMj20fcOmNxWLpErlUt8ud9kTKMB7b0Luv1du3LeairnjRL4arz1l0TnZZeDzsX9XtGOs9lA+THgiXzZaAbbwziLZGvf/QAOnHSapz9TxVmH5XXCP41CKo/6dTIrcwxFEsvr0WO8i6CzNKDfuRcGXf3ulsq2CAfKCFmuqgSMqM+HTQHiaj7jqwcAQbVB2V/biNLU0o/MbYtJsijPgzFy0FHgiJq1QeZDvC5NseZskG9mEoTuOQBQ/mCru0TEq7zjF/0CTf1dLORDYDbCx8cC5FOaD74z+zmSLVQ==
X-YMail-OSG: qiwv1P8VM1mIZkchkuZ6W1uKFFYMV7TUfF6SFu5MS1ZVHU.GpYXbU9T9OQPWS7R
 rnpTBfCKbNWPvg.R_TWU_Is9qhU6lDF6eKXjZegvKLROlt5N2K0ohSr_pmIFAaYpDX7Krbuke_C4
 XVF1T9BypJG0ZUzZNGieDoC6JE8rKRE3kFFpxQ6iJwcPfKj9OW4PY2iiH3thDiqRDEDVmW3NpzUG
 _7M2iINTl0p__nXou0uiDI_TH0HeH0cpYL9pTpOvW2oquwVhv6As4ZSSF1xcX0iOOpu5fzzbQC90
 NlSEM9w1D_aGY2JA7N2axnbjE3ajVJ725.bXFPaCHhJY7wrY0FhHOTt64AjM8NHf5oBhGKHRzyG8
 uZ91oWCwTIvbgOC0FSxHZ5yh2mYdRRTkorD3nBvYSt36uaLnvXy7MCjc9l22JODAuN6hD7jn7JwD
 i.a8XyNTiew7LE6YWzPCnr9Fc2of7dHS5vWArSFdZtXplosniqdkFpeyNW02bWBFL6nJt0AwRRmk
 ejZdWBDR4vHfrJ8NI9PZQLXeLHlzS_BnZkFoMCRkIAE52csCKCyerf1zcWrZQGBfSMj_KV8ZcqLB
 fjYl5w2mRUrDV9caXhV10P3IOP08PZf.iR3fKt5EAz5PbDj7NsRw3ZfuXL.97l.8M7lYdUccutMq
 hsEpHKAQtbymHDCJO8p9.OjdaiecQU2cbrVZHJ7AHFloaMhe6ZD6yfUtX8RcbMtNHzMzqbv5tKX6
 uWtJ4gld90o_jmtiGSS4QkBvN_hXhsyXOUUEyi.FpfAgCqs.fFb.gQRodBLMswJsEMTyJ5FrAnT1
 tnohCW6Tvz_3e1wWyCCHTjzwmmriFfWzAMdzY80GUqsd40FwgcS0Ke.nnPZW2DiQGvlC80Fctq0u
 cf.wQRAwfySV5xkEvSIf0dLO0rM79ChD4xyrmjkLpMR1R4a2Q9NuVIvIkxl58OSOSsa4ZNBTU3vl
 nt3XXkjG3dIJ6GtuZUwEnOP1wtNAb0aJ02_T9NRpteHqp6tc3e.gS9EiJqGBPQtKMjfyeQvettO0
 iwIpqD4GFa2BPtRQM9zLqpp7vFeFHKsvA_KuklfleDu2APHUhEPyCT5iM60cPB74tC2fuf2A0Xwl
 MDXvRAd4qa5CTvTDa10DNIF3wVlSBkUsdXjEtUscA5pmUi5g9OkcMaI_IKXOJzSnil0NRBRLJSD0
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Fri, 29 Mar 2019 15:22:43 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 40785259f151e5088712ba2aa88d58dc;
          Fri, 29 Mar 2019 15:22:41 +0000 (UTC)
Subject: Re: [PATCH] Bad file pattern in 'SELINUX SECURITY MODULE'
To:     Paul Moore <paul@paul-moore.com>
Cc:     joe@perches.com, linux-kernel@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        keescook@chromium.org
References: <20190325232125.1781-1-casey@schaufler-ca.com>
 <CAHC9VhRJUxnEyFvJQ3PR+aQTnGt=GZ+EZ-oBQihEE9WgQ9n5EA@mail.gmail.com>
 <CAHC9VhReNxpWNg6WfCShRijO+AWC9TR8dzCP8COwz_Qe0xr4wA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3e26c0e8-c427-dc40-cc3b-6201f80b383c@schaufler-ca.com>
Date:   Fri, 29 Mar 2019 08:22:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhReNxpWNg6WfCShRijO+AWC9TR8dzCP8COwz_Qe0xr4wA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/29/2019 6:33 AM, Paul Moore wrote:
> On Mon, Mar 25, 2019 at 7:52 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Mon, Mar 25, 2019 at 7:21 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> The include/linux/selinux.h file has been removed.
>>> Remove the entry from the MAINTAINERS file.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>   MAINTAINERS | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 3e5a5d263f29..1039c34dff3c 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -13947,7 +13947,6 @@ W:      https://selinuxproject.org
>>>   W:     https://github.com/SELinuxProject
>>>   T:     git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
>>>   S:     Supported
>>> -F:     include/linux/selinux*
>> This is fine with me, but if we're updating this file, we should
>> probably add the following:
>>
>> F: include/uapi/linux/selinux_netlink.h
> Are you going to update this Casey or should I?

I wasn't planning to do more than fix what I'd broken.
Have at it. Thanks.

>
>>>   F:     security/selinux/
>>>   F:     scripts/selinux/
>>>   F:     Documentation/admin-guide/LSM/SELinux.rst
