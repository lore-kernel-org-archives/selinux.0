Return-Path: <SRS0=WnGO=YL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC88CA9EA1
	for <selinux@archiver.kernel.org>; Fri, 18 Oct 2019 09:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55DD222BD
	for <selinux@archiver.kernel.org>; Fri, 18 Oct 2019 09:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Oxy49GIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632977AbfJRJB6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:01:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43590 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632965AbfJRJB5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Oct 2019 05:01:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id t20so8004271qtr.10
        for <selinux@vger.kernel.org>; Fri, 18 Oct 2019 02:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jd/g3MDHFfMrZY7vWfm0vHT5SS2ZUWGyn15qLyYT9I0=;
        b=Oxy49GIsSBeh7RvQI2SR9hGofZsANWOJ3eqydv5goPDIZDeSRaUEhjhMqFcIpNgwrH
         qAgJf1EsfBF/oNNF610ZGpKyJd3XHn6PCB1ZDWOsi1KKPvsXtHXG16/g/gTNKHYfhz+5
         SAHwEue593i2tBG/0Iq02JDYT3kt7Kvq3Hz74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jd/g3MDHFfMrZY7vWfm0vHT5SS2ZUWGyn15qLyYT9I0=;
        b=mnMnPs1L4xGBEQ3ZdGMlwBBzNv9WKwdVvn2zo5XUQPY31yrLbY36cwg/gKwzRlDT1W
         dAmyUBUGJCWlMr2GY8oF48A3Rf6ccOAkb77V+R5k4D+z71EKQYgVe6dFngG9e5/LD0tr
         9JYcjHEgYH3ZQ6FLPXr1SF5OizcNd/NzecxrZEAGWR3wVdWcEVYTOPwpr84GMVfIGh8J
         CxZF3iDBcOGuWzTlK/4cMGIiodilsR9VUne5g4PNWs8iUmxlXrMzxN3Mw1eEKYcYRYGd
         Ke3FvbLq3tsjW0G5zmG4dOOMbjnxpoq2tTnFrUYXC3A3bjHNFIEvWppRqlrYmCh2B3p7
         kipw==
X-Gm-Message-State: APjAAAW6NPQ+ufQBVFMQ6FeF2/xSAei1O08MWyWCy679p3lU8mGLxBH9
        gcr+kPuNspCCW2efKLiPdaEMKtSvJ1E=
X-Google-Smtp-Source: APXvYqwSOrvV/77OpZIyJvmirSVMeQEUM/8XR1PgcuMajsCLotpvcp/UTeb44rhIhYxVaQ2/GOJfoQ==
X-Received: by 2002:ac8:610e:: with SMTP id a14mr8595228qtm.187.1571389315618;
        Fri, 18 Oct 2019 02:01:55 -0700 (PDT)
Received: from [192.168.1.190] (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id f144sm2456445qke.132.2019.10.18.02.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 02:01:55 -0700 (PDT)
Subject: Re: [PATCH userspace] sepolicy: generate man pages in parallel
From:   Chris PeBenito <pebenito@ieee.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20191014080647.19602-1-omosnace@redhat.com>
 <d6755428-b0bd-1d88-69f7-0dd953eb7300@tycho.nsa.gov>
 <CAFqZXNsMVm2OmWOTiMaKybkhX8Zerp6rDeFfEd0UwhZRiNuNXQ@mail.gmail.com>
 <511ca06c-7786-1b90-4694-a5cb842a8fca@ieee.org>
Message-ID: <0a554b63-df42-fbc0-6877-f58c16156a9e@ieee.org>
Date:   Fri, 18 Oct 2019 05:01:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <511ca06c-7786-1b90-4694-a5cb842a8fca@ieee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/18/19 5:00 AM, Chris PeBenito wrote:
> On 10/18/19 3:44 AM, Ondrej Mosnacek wrote:
>> Since there are plans to support
>> only Python 3 in 3.0+ this may not be an issue, but I could also add a
>> few lines to fallback to sequential execution under Python 2 for the
>> sake of compatibility. Would that be OK or should I not bother?
> 
> Python 2 end of life is in less than 2 months.  Please don't add new 
> code only for Python 2 compatibility.

I can't count.  It's a little over 2 months.  The point still stands :)

-- 
Chris PeBenito
