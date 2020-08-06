Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934F3C433E1
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F028B23119
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv/95UJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgHFRWu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729978AbgHFRF3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 13:05:29 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54118C08E834;
        Thu,  6 Aug 2020 06:46:04 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id x7so6104756qvi.5;
        Thu, 06 Aug 2020 06:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Noe4wrhHeIIK26GAoxH7cWbO0xP9alc9hvsEUqIX8NA=;
        b=cv/95UJph2wr3UWInLzIaEl9oiswTM9TRU4cQfMXkEZoqrQEFWcICBh2QDk6mp1Qfw
         KpR6V2c1AOvb2DPEJAgM4oED/8vLiZC8HsU0fFeagcUgfjt4lnO2/8pwAin7o0i/3ekq
         TfLLFQg+VNvw2yYWW01MeOjPuIxsPlD7zR/Kn9dFXY4CCIIEcxFXnq/tbu6ajTWhQ3YN
         Y7WoYGhOLddFLwZkgIaWhNfNcOfwxQVhMQr/ChvdyVmMjhdh2vrKQXTqXGOVRKrn7ae1
         RhP0KgyQ0XmQmIA2BRRKUAyx1LVf61bfgtYtSxz6/tJ6IkGMQWWX6ZCO3meTwThYO3dH
         NM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Noe4wrhHeIIK26GAoxH7cWbO0xP9alc9hvsEUqIX8NA=;
        b=B7zfhbBwNQZQ2Vb3H90MCYBypw/fQiLUkYmd++K5bak74FOnoSWzJNZz4xUmd+X2K8
         NuOhPBNWjGn372D8iFAbqKUwbH/FW0RO36PsPRRJjVv/OV9p0jVrY0DAqBK+Yc3rc0Ce
         A8JiBfwVp2VXpP3UyoC25bjhKKspBUBZ5OFmYVDmY8EF638Ilj6UUm0y8vLRYxOr47/s
         uPGGRzOas+9PZg7zZohv8xJINMODOIbyTiZoMlP4A32lvmgCv8M1CAR3PM96gCxncpiD
         774Kme8oIeZsLi2A6L0P56wss/IZryfqOIhgtVBNP2Gxr7WTFSdlFaaIs5DevtHVtp2f
         1SHQ==
X-Gm-Message-State: AOAM531LrRs4C3w9LqKm3VgUJgRQRgjfXnXiz+jyNSdmzoN8Zlv8GsWk
        pOyH/S62jxHJc//iArEU5CdvZrtk
X-Google-Smtp-Source: ABdhPJw2x4WU2W9FDOCW+Ug5kBjdCTPlTiPVRAcE3dURT7jwFxY8gJBcK+ltJpICNFCiCipgP1PqgA==
X-Received: by 2002:ad4:4ea5:: with SMTP id ed5mr9085944qvb.130.1596721551815;
        Thu, 06 Aug 2020 06:45:51 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id g136sm4331573qke.82.2020.08.06.06.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 06:45:51 -0700 (PDT)
Subject: Re: [PATCH 2/2] selinux: add attributes to avc tracepoint
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     peter enderborg <peter.enderborg@sony.com>,
        =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
References: <20200806080358.3124505-1-tweek@google.com>
 <20200806080358.3124505-2-tweek@google.com>
 <89d23362-39b9-79e5-84f1-d7b89204ef38@gmail.com>
 <8627d780-0e19-6755-0de5-c686deb0f5de@sony.com>
 <971592b6-5d5f-05d8-d243-b521fe65577d@gmail.com>
Message-ID: <07e2c48d-3918-6ceb-a6b2-4e2f18f9ea01@gmail.com>
Date:   Thu, 6 Aug 2020 09:45:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <971592b6-5d5f-05d8-d243-b521fe65577d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/6/20 8:32 AM, Stephen Smalley wrote:

> On 8/6/20 8:24 AM, peter enderborg wrote:
>
>> On 8/6/20 2:11 PM, Stephen Smalley wrote:
>>> On 8/6/20 4:03 AM, Thiébaud Weksteen wrote:
>>>
>>>> From: Peter Enderborg <peter.enderborg@sony.com>
>>>>
>>>> Add further attributes to filter the trace events from AVC.
>>> Please include sample usage and output in the description.
>>>
>>>
>> Im not sure where you want it to be.
>>
>> In the commit message or in a Documentation/trace/events-avc.rst ?
>
> I was just asking for it in the commit message / patch description.  I 
> don't know what is typical for Documentation/trace.

For example, I just took the patches for a spin, running the 
selinux-testsuite under perf like so:

sudo perf record -e avc:selinux_audited -g make test

and then ran:

sudo perf report -g

and a snippet of sample output included:

      6.40%     6.40%  requested=0x800000 denied=0x800000 
audited=0x800000 result=-13 ssid=922 tsid=922 
scontext=unconfined_u:unconfined_r:test_binder_mgr_t:s0-s0:c0.c1023 
tcontext=unconfined_u:unconfined_r:test_binder_mgr_t:s0-s0:c0.c1023 
tclass=capability
             |
             ---0x495641000028933d
                __libc_start_main
                |
                |--4.60%--__GI___ioctl
                |          entry_SYSCALL_64
                |          do_syscall_64
                |          __x64_sys_ioctl
                |          ksys_ioctl
                |          binder_ioctl
                |          binder_set_nice
                |          can_nice
                |          capable
                |          security_capable
                |          cred_has_capability.isra.0
                |          slow_avc_audit
                |          common_lsm_audit
                |          avc_audit_post_callback
                |          avc_audit_post_callback
                |

