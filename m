Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7607AC433E3
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E2C221E3
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu45qcus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgHFR3B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgHFRA4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 13:00:56 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AFDC061A13
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 05:03:07 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t6so17309996qvw.1
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zX/fCw+K58Pdu4L95m8RQj3cCMHyHCuRDrv3Bd1QWi8=;
        b=mu45qcuswXTIMhOV553W1f0QQE7KDuVOnXGyNqb80s+LJEVayMvzGEr+u5Uw7wu0if
         h5B6wyQnmYAPCDid3SVQeDdX1NeQGCd52zA+AM7keWswPb4EZ/FdlsLqWEdM02mXeTuX
         Wwd31RMKVLUlzH2yo8uj4KsHqJh6zHkwwt7tfC/OVYKreezReaoy+kigcvpnkrmDIiXa
         A6lTDeNYqtNB5ZiWFzPQB+OJQx3dHmaqi4IsA28PnngpcRNFL8MILLwDUjAikfAX0nTx
         Y/bLj4gBgaxG5fcsJnGOq7T94pIf1G4hBFLZy+sbuDccAX1a5kFOYUm9FeDDq30ZhJ3r
         z4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zX/fCw+K58Pdu4L95m8RQj3cCMHyHCuRDrv3Bd1QWi8=;
        b=p1+xOBk9188IU6hBPK/tUVDpExZ3NdiN2nyq48Hlmn9Q41aZMZBPihrTwt842yEst7
         YohPmzMvWN8qow9h3Xu/FCaSUNqukRjrGp4B625qOFVM9c607w3jt1w7gf/3ZrM74dq3
         PG+u4kwYXlGyyTG9qndFwwYLtpuG/ems7jiY+CVMLHFadSFtPGoAzJs9aR04/NFD1anf
         H4NnLEv8FBsPmIHtpGaW5dIMmLq14aBhwBVWhte905/KzWPDju/TCJFaJ2foq6s+XfPJ
         KCDOSCjGXhY4jcvmAJlUW0NElnEyaRCM1HUtlUnvZeQFR0nkDBOiIDH1IFzOIPCbrSB1
         N9Eg==
X-Gm-Message-State: AOAM532Sn0PwJvUHdV8X+GKAqYugPXCkCvDRhXD7kXmiV38TSukkPTNv
        4HsvclvAwsZs8azz2/rjp/4=
X-Google-Smtp-Source: ABdhPJxLEiuH283FiTzbMXa6eWQOAmcvO5w5f0cGp4Z8VBoXzxdoVfesfIX0P83YVcHYaeRvxA07UQ==
X-Received: by 2002:a0c:e844:: with SMTP id l4mr8161459qvo.154.1596715379083;
        Thu, 06 Aug 2020 05:02:59 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id n184sm4078718qkn.49.2020.08.06.05.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 05:02:57 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] libsepol,checkpolicy: optimize storage of filename
 transitions
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>
References: <20200731111035.498656-1-omosnace@redhat.com>
 <20200731111035.498656-2-omosnace@redhat.com>
 <e57f8b36-6134-bc19-35a7-f03a6f7b7bb2@gmail.com>
Message-ID: <32928866-c2a9-6167-b897-4c54c2940b3f@gmail.com>
Date:   Thu, 6 Aug 2020 08:02:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e57f8b36-6134-bc19-35a7-f03a6f7b7bb2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/3/20 9:56 AM, Stephen Smalley wrote:

> On 7/31/20 7:10 AM, Ondrej Mosnacek wrote:
>
>> In preparation to support a new policy format with a more optimal
>> representation of filename transition rules, this patch applies an
>> equivalent change from kernel commit c3a276111ea2 ("selinux: optimize
>> storage of filename transitions").
>>
>> See the kernel commit's description [1] for the rationale behind this
>> representation. This change doesn't bring any measurable difference of
>> policy build performance (semodule -B) on Fedora.
>>
>> [1] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?id=c3a276111ea2572399281988b3129683e2a6b60b
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Thanks, applied.
