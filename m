Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53680C433E3
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 16:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FA120792
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 16:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbTdyvk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbgG1QTO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730810AbgG1QTO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jul 2020 12:19:14 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D67C061794;
        Tue, 28 Jul 2020 09:19:14 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id u64so19147286qka.12;
        Tue, 28 Jul 2020 09:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EsguC6o+0bCS2WlgIG23ocbIUJ3J1g2D7VCPRNwaMRg=;
        b=UbTdyvk/Cf20rAMpcX8s5PJXTmqyjX2bZIeR16jpiij4Vv8cIa+IjZu95WjAn6E4aC
         6kQR0XZu9wbpJWvpUEkkJu58/kauCjJkAtz1tVP7SRmkJgdhRJ2OqckETRm69S1LVike
         HseyN7twbGF41uyAxqw8TSyAqaWE2Xq7AQQxaoRFPGs7sWcXhOaWvWDnRDVHYQDMFnzs
         iZGJ19kwNvv6nxtOSEnzX0+3DYRTCkZ+IrblhZ1P1w3RB32552dmd7ZsSwqQplqEm0yV
         N8FF+QR4lECk54lc6ZH3mdaUcj/NWyk3ecRcMdt0N5f2/MMUDdLPtkDP+DQTc0AcAPID
         6m/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EsguC6o+0bCS2WlgIG23ocbIUJ3J1g2D7VCPRNwaMRg=;
        b=UVFwduPEMR0gRpkac8mX21Gi1J2UR+gzn1VAVYGPu4e/j9xB+OnKt8deED+TXesX+L
         OUerXCoevEhT9/vlOXyDO883txIBy8e3BW1EX5MbSfm7XX9mk8OBOLUFNzT1OhwN20Q5
         ccG/6S3MP7Bl0HM+ZTR1XW8ScXL27an+EYNzccSmREe4iTKrPS8tO3/unL6yXYPvKnJI
         Jmari9AmYa38akTKgxBXiNwzdHRi3YZ3PPyrFr+kIhKwfkMtKjM+rEhPJ0a8DF/aY31M
         fyFzXc0lfrFZgXr78tLo/ptIyiF+mrgk0XMzjQhs2CYEsgjtHsJWjMvhIu6tPL8sDSqx
         AmtQ==
X-Gm-Message-State: AOAM531yGnLh/UGLXRXX+MCM79T9hkYk2RM/q6k1zwYnoRyudOItUkYJ
        vRaaRaHStAnLi53LpoLCKhzdq+/oCKM=
X-Google-Smtp-Source: ABdhPJxYsXtbVjAqEuzNPfyii6lXfqywAD+mXixIuPOAsUJsdmyjMZJDT66LAFG48SFGTzpssttSYA==
X-Received: by 2002:a05:620a:1188:: with SMTP id b8mr7472071qkk.440.1595953153117;
        Tue, 28 Jul 2020 09:19:13 -0700 (PDT)
Received: from [192.168.1.190] (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id k25sm12294916qtp.72.2020.07.28.09.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 09:19:12 -0700 (PDT)
Subject: Re: [PATCH] selinux: add tracepoint on denials
To:     =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
References: <20200724091520.880211-1-tweek@google.com>
 <CAEjxPJ45ij3obT37ywn_edb9xb89z-SdwzejfN6+jrvAtghXfA@mail.gmail.com>
 <CAHC9VhS4aXD8kcXnQ2MsYvjc--xXSUpsM1xtgq3X5DBT59ohhw@mail.gmail.com>
 <CA+zpnLfczC=9HQA8s1oBGKGQO+OkuydF85o89dhSxdOyKBHMgg@mail.gmail.com>
 <CAHC9VhT1sGSpfCKojbKR+O2Hf_h+wnKnBwwSo09CbFaCYLcOHA@mail.gmail.com>
 <CA+zpnLecz_gvXYnrwNGW8SLaJsu==M_n9MuJgjqX9nPJtuTZBg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <3033ddfa-9788-0030-fb66-fc471d2355c0@gmail.com>
Date:   Tue, 28 Jul 2020 12:19:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+zpnLecz_gvXYnrwNGW8SLaJsu==M_n9MuJgjqX9nPJtuTZBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/28/20 12:02 PM, Thiébaud Weksteen wrote:

> On Tue, Jul 28, 2020 at 5:12 PM Paul Moore <paul@paul-moore.com> wrote:
>> Perhaps it would be helpful if you provided an example of how one
>> would be expected to use this new tracepoint?  That would help put
>> things in the proper perspective.
> The best example is the one I provided in the commit message, that is
> using perf (or a perf equivalent), to hook onto that tracepoint.
>
>> Well, to be honest, the very nature of this tracepoint is duplicating
>> the AVC audit record with a focus on using perf to establish a full
>> backtrace at the expense of reduced information.  At least that is how
>> it appears to me.
> I see both methods as complementary. By default, the kernel itself can
> do some reporting (i.e avc message) on which process triggered the
> denial, what was the context, etc. This is useful even in production
> and doesn't require any extra tooling.
> The case for adding this tracepoint can be seen as advanced debugging.
> That is, once an avc denial has been confirmed, a developer can use
> this tracepoint to surface the userland stacktrace. It requires more
> userland tools and symbols on the userland binaries.

Providing an example of the tracepoint output in the patch description 
would be helpful IMHO.

