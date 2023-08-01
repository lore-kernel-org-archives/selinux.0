Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B10C0015E
	for <selinux@archiver.kernel.org>; Tue,  1 Aug 2023 19:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjHATiD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Aug 2023 15:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjHATiC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Aug 2023 15:38:02 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A636119A8
        for <selinux@vger.kernel.org>; Tue,  1 Aug 2023 12:38:01 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a7065d0f32so403576b6e.1
        for <selinux@vger.kernel.org>; Tue, 01 Aug 2023 12:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690918681; x=1691523481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gWSZMRHstSwq3yuT2l6v9MEskzR0WZlsvSqWsc6jNc=;
        b=dqUQjDLvaXbmd2VGcfaFqb2tY97FVFLOw7XSVW9LwVij3xqCFRi0lx5g93hS3d1waK
         ECtThCKOiQgUafYmVSnLpudwM3BTA9xA+BXwcRHvkH8cEOuaeK1hWeSdCyXNrgVnlNpe
         Bk7PmKBbpKyqolcO7GfOyL/BkMp6r8GhNyBhtw16x0odJb8UhxhDAQtMO2UDgZFYwGCg
         gveKMZXcklhdaLIsKlSaWbJo/AyLQhHkUCNkv1n64jM6MJW/6P+tFfnYBeUPTSMiox/f
         WfghsXGvpZC4SYwY47DgEjOomjoqfTOrj2Irps4PzxljArYLdiKAiRXSeTEFonU9ckFm
         xYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690918681; x=1691523481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gWSZMRHstSwq3yuT2l6v9MEskzR0WZlsvSqWsc6jNc=;
        b=YCNj0aLemSMaFhhS1pzpbRiFY9JzOUTSkkJ9zgpG03DGm47FO1bJqhA6TVXAg127+5
         B2XGVe0Rkf6LgcYxvabqU72NPZ3+x9yHla5aPi5Mhn3UdYaL55hkAKEviwgegMDS04ZZ
         vai0KmokQdasFxBNW12h31ewE5jFI1rnEGpxZq/PGGIUFAYaqzfvGLXNTjEit8PYJPk/
         YqgY4VEPq0umetfsgK7PI0Co7jrGed658BzObC+pTLCMYWYRy1kEMxEr0lmAXmjk4y1d
         OVzFWYKzizCR6ok3b1aDWcrskKPC2OdIyOtiVCTJzgT9I9tD/Q0NWr41dDtloepB/B0L
         nrhA==
X-Gm-Message-State: ABy/qLbX+/5c0Ze+RBX5UuoGBoUWftCUa8TexIVed/+85OwiYCROF2NP
        h3zV80fnk0SkmIUxpjGEIcfhquSSJ8U=
X-Google-Smtp-Source: APBJJlEwRUFyhWCJBJM0sFuapwvWfgM+x7sFfSanyepfLMmpgc546igfRMCHgS251QqF2OXjT94Oqw==
X-Received: by 2002:a05:6808:1802:b0:3a3:37dd:e052 with SMTP id bh2-20020a056808180200b003a337dde052mr11380325oib.5.1690918680855;
        Tue, 01 Aug 2023 12:38:00 -0700 (PDT)
Received: from [172.31.250.1] (192-063-109-134.res.spectrum.com. [192.63.109.134])
        by smtp.gmail.com with ESMTPSA id c20-20020a056808139400b003a721e92f1bsm2973448oiw.33.2023.08.01.12.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 12:38:00 -0700 (PDT)
Message-ID: <aced6072-1ca3-e01b-4964-67c36a869824@gmail.com>
Date:   Tue, 1 Aug 2023 14:37:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Network ports - multiple types?
Content-Language: en-US
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <5d5fdc57-6bf3-ec9a-b71b-b17e259f55d7@gmail.com>
 <CAEjxPJ63oh92-49Oz3BjVxc=Kn6Rcwf1BbdziE_qLTnQ24VbLg@mail.gmail.com>
From:   Ian Pilcher <arequipeno@gmail.com>
In-Reply-To: <CAEjxPJ63oh92-49Oz3BjVxc=Kn6Rcwf1BbdziE_qLTnQ24VbLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/31/23 07:13, Stephen Smalley wrote:
> On Sun, Jul 30, 2023 at 5:03 PM Ian Pilcher <arequipeno@gmail.com> wrote:
>> # semanage port -a -t fdf_port_t -p udp 1900
>> ValueError: Port udp/1900 already defined
>>
>> # semanage port -m -t fdf_port_t -p udp 1900
>>
>> # semanage port -l | grep 1900
>> fdf_port_t                     udp      1900, 3483
>> ssdp_port_t                    tcp      1900
>> ssdp_port_t                    udp      1900
>>
>> And, sure enough, my FDF service is now able to bind to udp/1900.
>>
>> I was not previously aware of this feature, and my internet searches
>> aren't turning up anything about it.  I'd just like to confirm that this
>> is expected behavior (as it just seems really weird).  Are there any
>> caveats to doing this?
> 
> As far as the kernel is concerned, there can only be one type assigned
> to a network port, so your new definition is overriding the earlier
> one. Is the earlier one in a policy module rather than being created
> via semanage? A potential concern with what you are doing is that any
> rules written on the earlier type obviously won't be automatically
> applied to your new type, so anything relying on that behavior will
> break.

Yes. The earlier context rule (ssdp_port_t) is in the default Fedora
policy.

Just to make sure that I'm understanding you correctly, it sounds like
modifying the context of a port with 'semanage port -m' effectively
changes it to the new type.

So is it fair to say that the 'semanage port -l' output in this
situation is deceiving?

Thanks!

-- 
========================================================================
Google                                      Where SkyNet meets Idiocracy
========================================================================

