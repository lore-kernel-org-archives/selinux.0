Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06E0C433E0
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567C82311A
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8F5MFMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgHFRWv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbgHFRFS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 13:05:18 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F065C034606;
        Thu,  6 Aug 2020 05:32:40 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j187so44659201qke.11;
        Thu, 06 Aug 2020 05:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MrPgmRKoIt5tINqjcxkNbe0xvTFGlqQ3fNUFCJE5Byo=;
        b=b8F5MFMkpPLTisV29sfk9+/fgaNb7SzgZ5y93TB4vjbUtAi9SRdlcdzeLf7YHacqps
         iVMPPJOeeIrOFaZFGYL/DTpQG+t15q7ukh1lG5yteuHBnHesTU6lx3+YPJTlwparDRH0
         M5PLm570k1vVH8E7K/1kaSqm3juFXkQB0j2RzG38qerfqd4PWg5mP6EbgK5hsZvPRr01
         Cte6Q4ae35fkfF1pn9fHxQZc+pnc0AGkLWvmhnSqIdN5/T4KypgCnU/qs6v9pnohwu42
         Mexzy6vhjPeG6yvNUEoUzwP3TXc5A/Oxjq3t7ay79hBgYfwYRSMlmN7MWFWjqUbp1T4E
         2Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MrPgmRKoIt5tINqjcxkNbe0xvTFGlqQ3fNUFCJE5Byo=;
        b=GE2ikYgNS8SFzsmN/fkTF04EkDr45vM/aMEEVeCwg+E3tmh2CL10Rkzfdipd58qalF
         rPLvIzh8vkRQEzaaosBoHNGCdE0H5kBUe+i2babk+966W0bVCKR7cTArepSVWwitnDzR
         z7gVdphw5z5IU0neODpfPi/Kk44/CP7SfibhAaIdQsbrLzBYImRRaLY5lTHeJsr0duh7
         LYumoSouC6xdf8Cuk2Yy0KRwc5CF27sjADtVckKZVkjLqCkcWd+LaEeF6zQ3TLTX84RJ
         gjayO6y70ZZH3N6AKRoW11OioZL1Iu1LO5gKFVvU6ESzbg2tPiXeH3x4xc9hlIkN9qU7
         mRBA==
X-Gm-Message-State: AOAM53080mpGYBOIHDMi/At5tmESqfYtc2rA0I4S5ylNBPgX3wKlioh9
        dLkHu9QxLuoUsLPU0e0i26s3Ajyl
X-Google-Smtp-Source: ABdhPJyx9omDeyEteSo3cfGKjhw01pVAD3AWhJ0uL3GUCySwHoAJzCAtfvgLTH3R29udm5b2vyK6RQ==
X-Received: by 2002:a05:620a:4c2:: with SMTP id 2mr7811456qks.80.1596717159524;
        Thu, 06 Aug 2020 05:32:39 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id v28sm5351254qtk.28.2020.08.06.05.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 05:32:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] selinux: add attributes to avc tracepoint
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
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <971592b6-5d5f-05d8-d243-b521fe65577d@gmail.com>
Date:   Thu, 6 Aug 2020 08:32:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8627d780-0e19-6755-0de5-c686deb0f5de@sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/6/20 8:24 AM, peter enderborg wrote:

> On 8/6/20 2:11 PM, Stephen Smalley wrote:
>> On 8/6/20 4:03 AM, Thiébaud Weksteen wrote:
>>
>>> From: Peter Enderborg <peter.enderborg@sony.com>
>>>
>>> Add further attributes to filter the trace events from AVC.
>> Please include sample usage and output in the description.
>>
>>
> Im not sure where you want it to be.
>
> In the commit message or in a Documentation/trace/events-avc.rst ?

I was just asking for it in the commit message / patch description.  I 
don't know what is typical for Documentation/trace.


