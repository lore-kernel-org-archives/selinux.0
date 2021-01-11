Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C45C433E0
	for <selinux@archiver.kernel.org>; Mon, 11 Jan 2021 09:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4663522AAD
	for <selinux@archiver.kernel.org>; Mon, 11 Jan 2021 09:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbhAKJwZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Jan 2021 04:52:25 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:43938 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbhAKJwY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Jan 2021 04:52:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610358720; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=kDRRlMU9xZvzsoyHtTnPDyjsx/BCROLlxB6BQXmIwhk=;
 b=NVGA2GxjmwTzdyD7FpjXKu2KakvoaozRXP+BYvx2C51B0A23r4pEiRbkeSV/ja2U8bmF+Qmy
 Ui0gDCBzuTYlFq6R/i703/qhlEhAaUxRXV8moRezUJkizckqjgGwYPWfLDIDxXylmUSaTfW6
 EsF5Zx5mST33qrVLGVabYMsmwmU=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyIxZmM3MiIsICJzZWxpbnV4QHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ffc1fa58fb3cda82f0b74ed (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 09:51:33
 GMT
Sender: pnagar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 546ACC4346A; Mon, 11 Jan 2021 09:51:32 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pnagar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5942EC43462;
        Mon, 11 Jan 2021 09:51:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Jan 2021 15:21:31 +0530
From:   pnagar@codeaurora.org
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     arnd@arndb.de, dsule@codeaurora.org, eparis@parisplace.org,
        jmorris@namei.org, joe@perches.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jeffv@google.com,
        nmardana@codeaurora.org, ojeda@kernel.org, paul@paul-moore.com,
        psodagud@codeaurora.org, selinux@vger.kernel.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com,
        ndesaulniers via sendgmr 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
Subject: Re: [RFC PATCH v2] selinux: security: Move selinux_state to a
 separate page
In-Reply-To: <20210109010111.2299669-1-ndesaulniers@google.com>
References: <1610099389-28329-1-git-send-email-pnagar@codeaurora.org>
 <20210109010111.2299669-1-ndesaulniers@google.com>
Message-ID: <fe452dce51f07bdbd4c0ae2bc70c3086@codeaurora.org>
X-Sender: pnagar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2021-01-09 06:31, Nick Desaulniers wrote:
> Via:
> https://lore.kernel.org/lkml/1610099389-28329-1-git-send-email-pnagar@codeaurora.org/
> 
>> diff --git a/include/linux/init.h b/include/linux/init.h
>> index 7b53cb3..617adcf 100644
>> --- a/include/linux/init.h
>> +++ b/include/linux/init.h
>> @@ -300,6 +300,10 @@ void __init parse_early_options(char *cmdline);
>>  /* Data marked not to be saved by software suspend */
>>  #define __nosavedata __section(".data..nosave")
>> 
>> +#ifdef CONFIG_SECURITY_RTIC
>> +#define __rticdata  __section(".bss.rtic")
> 
> if you put:
> 
> #else
> #define __rticdata
> 
> here, then you wouldn't need to label each datum you put in there.
> 
>> +#endif
>> +
>>  #ifdef MODULE
>>  #define __exit_p(x) x
>>  #else
> 
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -104,7 +104,11 @@
>>  #include "audit.h"
>>  #include "avc_ss.h"
>> 
>> +#ifdef CONFIG_SECURITY_RTIC
>> +struct selinux_state selinux_state __rticdata;
>> +#else
>>  struct selinux_state selinux_state;
>> +#endif
> 
> so you could then drop the if-def here.
Will update this in next version, thank you for the suggestion.

> Happy to see this resolved when building with LLD+LTO, which has been a
> problem in the past.
Yes, downstream we have this verified with LTO configs enabled. Let us 
know if
you are suggesting to check anything additionally here.

> Disabling selinux is a common attack vector on Android devices, so 
> happy
> to see some effort towards mitigation.  You might want to communicate
> the feature more to existing OEMs that are using your chipsets that
> support this feature.
Glad to know the idea looks good! Yes, we will work on that, will 
communicate
internally as well, thank you.
