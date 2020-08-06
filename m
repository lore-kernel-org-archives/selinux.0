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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E10C433E0
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E649D20786
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQuqgtfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgHFRDD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgHFRB5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 13:01:57 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06287C061A1D;
        Thu,  6 Aug 2020 05:11:32 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b79so44603520qkg.9;
        Thu, 06 Aug 2020 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oD5+bJ3r0NN3+6TONla3cei1wENXPPPflhOciZ2VB4s=;
        b=dQuqgtfS6RBkdriO+slPy4lqyTseXAvt2kbP+a1MviCWr9QEOseah3mcpt4MMUd4AN
         s9u0+9nplkK/NeuiuUWGtd5DDu0wFR9YgP4ezxKA6fCk+al+KkRRq6PBC4C0V0i6Slc2
         F28jZ228C3U9HAm7NPVeisPP/d2JemUwFTyU1VDuXRqvoY5eyAnLUb6Y3Ib4ngXlnmir
         HnbhWJhcz2HM2OFdOI+RRr0o30KwdMB6fKM3M+I9D1uHPmFeD7ZH7QKDEwIgiWvtl9hm
         ZtQpcY+drUgwU0tLHp0JGt7/WDDogsveRySF7Of7qLekv+FulU6yqQtdvX2H9OCENWiG
         itig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oD5+bJ3r0NN3+6TONla3cei1wENXPPPflhOciZ2VB4s=;
        b=gC1h/dtY5HG631euLh9C2VSHmhLklWGB/IjpZGeWv52X8Frs7ZScepECdqS2S12Qe6
         +CGMWmWbSMqiQbAxdxxB/HvZfrmoP+/kjvFo/W5nvlMziajyJ5wobc7uVdZDJ4TZGtwh
         De7fTiSPEpyepNCBw4aLZIqjdchgpohfueL1h/kh//0ReOToDs2b9k12ApQ8y5lEnfTV
         TGwKzf4x/OhvAcBpITaWw0Fn79VesrTU78ezluOFp0Kn1kUn9COHOrzBAp0likF0F8h2
         2SfhhB9Cs9yHLt06oOgZz0HIc7P1+JBv/cOiomcNRAs7cue/GEVHCDt5axCS3JsNBiK2
         deyQ==
X-Gm-Message-State: AOAM531ROIHQPGgZV0TljFtzan+1ROqx6opax7H31GYDmtsi4DNwLT76
        fDGCT3UkIhurgDmFkesZc71KGwPH
X-Google-Smtp-Source: ABdhPJzOx37xQt8ecJxvdZYrYkmBbnSyOV8Y4LF22tgQGi9lvs1/OfjNG+kYv30K1IpGIUALFHXSfA==
X-Received: by 2002:a05:620a:a0b:: with SMTP id i11mr8653585qka.65.1596715889932;
        Thu, 06 Aug 2020 05:11:29 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id 7sm3959910qky.89.2020.08.06.05.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 05:11:29 -0700 (PDT)
Subject: Re: [PATCH 2/2] selinux: add attributes to avc tracepoint
To:     =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
References: <20200806080358.3124505-1-tweek@google.com>
 <20200806080358.3124505-2-tweek@google.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <89d23362-39b9-79e5-84f1-d7b89204ef38@gmail.com>
Date:   Thu, 6 Aug 2020 08:11:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806080358.3124505-2-tweek@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/6/20 4:03 AM, Thiébaud Weksteen wrote:

> From: Peter Enderborg <peter.enderborg@sony.com>
>
> Add further attributes to filter the trace events from AVC.

Please include sample usage and output in the description.


