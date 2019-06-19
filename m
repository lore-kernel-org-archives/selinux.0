Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0C7C46477
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD5321537
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uAw3s74X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfFSQsj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:48:39 -0400
Received: from sonic311-30.consmr.mail.gq1.yahoo.com ([98.137.65.211]:34867
        "EHLO sonic311-30.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbfFSQsj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 12:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560962918; bh=jEicFefw+jMYxSDKsFAJ+8GHwDeG2pVC1Ves2U24euA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=uAw3s74XWYFWb5lJOMKkIYrc6k4amPib6tFHqiFgpMT8IuWszx79Yluriq8/xYgF8zq+SSBZa+XBgBE2HPSjGufU2mvq8aEFd5wMWux0JUbpSdX1QIRid/uzvw+ifU9wjP5dtUyBJOPii6BTk8UkyvCkZ1CSHZdpyiUD3R8WggnhlUQfoqphfLQRe/ljX2l1J5pWjSzGauZthJloLHiHBT+Ib21c0MHdQiRq5DoeD+ib32CHbJqmOI2EfEgknrsRHPweCKAY9RI0agF0rpASNRnSQa8l3GPpBxa8AenZ70TaBgbBrkxur/rnNfzvLMqLlOjF4ETSWO8MkLbjoD2Mrw==
X-YMail-OSG: 779c3TcVM1mpQCS6ywDhzrgr74S8uruH6hew6OEIg.rfKLC.odwfeD.watGjR4l
 2xntg56TvlgVRx1IBSaxsAZKDLdRdy4BRltw9eBNCUNQRif1q4ZPyB7F8NyM_PgM9EKaYtYRv90a
 afHmYTYUedXf8vnYjdyFgONyOT53USVwd3QXXSA0V83GBcXqoO56lyaNednwvsVySpWI1dC0Smiw
 TZjxxoGGZSHpDQIbOZm8X_xbKhJLvuhMbPqArDcUCJf4srPa2b4HTMtu_Xw996Hpk70F43r4EaVR
 80f.Dfp9EKvmKM46Tv7Z7BPC3Et64f1iZyZwcrNnDzcbKnXWrSfwuTdNzKpvN_0GhrCFc9kZsT3E
 t5UPZcVb1gEeKgKkMcATtzyHw8ySIG44qTGyBaXFkunj33T5aKuDk.7bF7xNhTnUxVSCPqN9aPZk
 rW6azJUunRxgF175IsVFAt.MZTdKun20q3gdPi.KHMgHmHIPhKZOlr91TnSPJhxJl3LP8LtkxICz
 uVXdx50eDhttSqs0io_5C7WI4_41GhVBPbCz2gONzuptUavujm8ifN2BQBtm4qpa574Vk5I20wkQ
 IgyQ1PGeIfEstK6usiEeLr13t1JJZG_GeGbXjH05UVyoqCpVtSK6AS3Zyag7htnWl.XOvQHdQunP
 8aGumDYgEKjcpde9hEjKBCcDJyywds3jjebSqo11s9lS4p9vWFxwXZ6xQak41Q0Uh40fMnnUdx0_
 yewJy981tRnuDNzIBbx0tjEip2I91.c3uBq4n_mU7KbnbA0QJ04EIYMt8dQwjFNhWEt0425QOK_b
 N3q79oFXTbu8HKX.8kq2v33hHgjRysgzLapiOgwjCD.yTyn5Um5MK7nWtKhcvaSh42AvGQImVP.B
 TBqr0axNHmLfr69qcqRyfElqYyxvHxdSJZp9UCOp.5t3Oz_4cj_btduWMbgoNJAOO5n10s7.DMlX
 9VEfhNKc8e7Ncqz4rc7Nz.xyl2Hs33uZ5pTPrl25RDouAhQd9sh0zG4H3U2.tC4HvTATIXXrIoY.
 LFSTx4Bo.d2ZziVR3g1TQeUfYN4uh0S3zPGHCuHwJEKiIP2BJi.nGFlonX.wNx.8evlmXinebmJl
 4ue1h7DfijMzNOhXRAsw5H1Ph2yFLV2GOychyP0XE6wsW4S5jr9qSAaWdAGb4uiaL0Iu.86TioKY
 xqZvC1rYwyWXXz7cHR3D9WHSYrIH7TYHlCjlT06M4nwhOTUiMYApiwaxyGOcIkG7utvr6vU.FL1z
 oNswoD9WJHV_18Bd6qw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Jun 2019 16:48:38 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID edb024cc2aa7a1378efc583d75a85e93;
          Wed, 19 Jun 2019 16:48:36 +0000 (UTC)
Subject: Re: [PATCH v2 00/25] LSM: Module stacking for AppArmor
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <201906182214.6DC4C1DB9@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <cd52f07d-610e-3bcc-0059-929447e10544@schaufler-ca.com>
Date:   Wed, 19 Jun 2019 09:48:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <201906182214.6DC4C1DB9@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/18/2019 10:21 PM, Kees Cook wrote:
> On Tue, Jun 18, 2019 at 04:05:26PM -0700, Casey Schaufler wrote:
>> Patches 0004-0014 replace system use of a "secid" with
>> a structure "lsmblob" containing information from the
>> security modules to be held and reused later. At this
>> point lsmblob contains an array of u32 secids, one "slot"
>> for each of the security modules compiled into the
>> kernel that used secids. A "slot" is allocated when
>> a security module registers a hook for one of the interfaces
>> that uses a secid or a security context. The infrastructure
>> is changed to use the slot number to pass the correct
>> secid to or from the security module hooks.
> I found 14/25 in your git tree. Very satisfying to see all the
> scaffolding vanish for process_measurement() :)
>
> I like this progression in 4-14; I find it much much easier to review.
> My only complaint is the variable names. I think I'd prefer "blob" over
> "le" or "l", which are both contain very little information about what
> they are.

I know what they are! OK, I get it. Using "blob" would make it
more obvious. It's an relatively easy change, so I'll incorporate
it going forward.

