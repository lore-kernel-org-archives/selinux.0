Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5971FC433DF
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 14:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369C12078B
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 14:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN8AN+jX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHTO46 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgHTO4y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 10:56:54 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAB6C061385;
        Thu, 20 Aug 2020 07:56:54 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 6so1397849qtt.0;
        Thu, 20 Aug 2020 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Aj8swNHTLXjkG9bLY7spgFYe1odfR1bjDLgI0T/CK9Y=;
        b=UN8AN+jXwuZMLc2Z5c9JWEuF1Jl8bWTuU6bK9RswOM9EYD143bNKT21EmJn1zMFsGz
         f14kqlJct0Onwr6knV0jwgrcNer/X0pwrUHRRDf/nDbTNo8Goexa0tskUx4tADq0+JOk
         dmdiP76O63oBvJWyvepXuSDCSyTb0jRlRTbF/Wir1L6AjtmKH/6Fbp9vUCi2++pm5iBO
         0ABxi6kuAoU6zP/ca0y9d0US6OuYqQ7DG1ZWxiONTb2JIVY+MUTcq9CuNiipuUYXWmYi
         Ic1B1VCoy0v/Rxk05SkryuT74UxSUDZiJ6IIDej20fzd4rYBF4ippHsYkhpRixLcKuOI
         Capw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Aj8swNHTLXjkG9bLY7spgFYe1odfR1bjDLgI0T/CK9Y=;
        b=bgrptNkt9557Pp8+92Q4ar9NkTDqPFCRkwGYsAQ3zDmq0lw179yRnJgD3G81LNh0aH
         2cJn7Owx5SNWlW6oH4SeXoODy0bQLNIYSas6S63kN/Yst1PwjT7BjDIUzWjfIf77ALvI
         jPl+VTNty/jfWOuT/pr7UMaf3KAnIOWbwHwAJ2aQI+5tIydgIIx5ZumFDY4ywC90k6oe
         NksR666xEhjlFciXCQAAi9HOo22sovgKjqdOkqMis6i1uocmlFR3iZGPPcNeMDytLeqQ
         oeJ1T2+olPikDnM2Epthb5F8CaTYDKAojZYUm/RYhKl4VaXtdopueITBFjrEnckuDiy3
         SLBw==
X-Gm-Message-State: AOAM532eX3SuMqyqj+6Bu9DQz5++E0zOvGRBZ2ofUD1IuoX9RZDHzzi+
        KasNkvCmWalAL9QpqUf3V4k=
X-Google-Smtp-Source: ABdhPJy2lqyJmwieoQRg5REi3uNH+34q1jf0hjirpAmmbqXJqmELkLTIVCZomL0v0wh1p/JnQ50weQ==
X-Received: by 2002:aed:3b57:: with SMTP id q23mr3112581qte.150.1597935413736;
        Thu, 20 Aug 2020 07:56:53 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id q7sm2574085qkf.35.2020.08.20.07.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 07:56:53 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] selinux: Standardize string literal usage for
 selinuxfs directory names
To:     Daniel Burgener <dburgener@linux.microsoft.com>,
        selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20200819195935.1720168-1-dburgener@linux.microsoft.com>
 <20200819195935.1720168-4-dburgener@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <e0ebc015-cf52-d233-4967-3f5de4a3ebc9@gmail.com>
Date:   Thu, 20 Aug 2020 10:56:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819195935.1720168-4-dburgener@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/19/20 3:59 PM, Daniel Burgener wrote:

> Switch class and policy_capabilities directory names to be referred to with
> global constants, consistent with booleans directory name.  This will allow
> for easy consistency of naming in future development.
>
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>

Not strictly needed for policy_capabilities since it isn't being removed 
anymore but no harm.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

