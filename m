Return-Path: <SRS0=eXnu=2F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398AAC43603
	for <selinux@archiver.kernel.org>; Sun, 15 Dec 2019 00:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04740214AF
	for <selinux@archiver.kernel.org>; Sun, 15 Dec 2019 00:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6j7020v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfLOAdH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 14 Dec 2019 19:33:07 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:34176 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfLOAdH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 14 Dec 2019 19:33:07 -0500
Received: by mail-pf1-f178.google.com with SMTP id l127so1773967pfl.1
        for <selinux@vger.kernel.org>; Sat, 14 Dec 2019 16:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WIlNEGDxNwW/8ESd9m3XOO1N744Tq8N7W6A6F/F+Eos=;
        b=Q6j7020vzUdvcK8pxHsXR4pUyww7LgMUsmsEcBVqLWrDRAYik6AEza2vlYb/nlXgCs
         NDyYWU5+LYWzvbJMXPARnslF1CCWUEF08t7517U25fpifNx+ygtCDm7NAi/1x/wjC6GZ
         qsMz/zt01zjDThLN0Cy1q6wc1ezNTubhv2/IkG0huQepo9zmemqtH6KVn58K2bJ5rWJM
         iCThXjaFYG8feZm4Y5N0O3VFDwIsejk2P+nfQpT+HQR6fWJ0tiZVQ7GY6yupE5YcNf60
         KYhCi17ccyTSboCpKw0Wo/xBt8leT/mU4LmEQLXKpD/AOp/qTC9ZgPfb8aOoqd6AqjUU
         +uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WIlNEGDxNwW/8ESd9m3XOO1N744Tq8N7W6A6F/F+Eos=;
        b=tJkluRRN0wZUZNMBOugg/kV+BgJA2Whr7R3RajUaW67wAz4Dan4UrvJ7sd0dfLf59B
         Ur80zZ9ixPWL4ZcD/Zwm43MYbnfUXa7TsTpopipxK2uX7yY7nHBONTNJ0LofZTluzDo1
         N6JaM8wG6jx5iL80mC3jeEV1kwWFLq/XeinE5qlqUkppl2JA3WprDtXxqHoMa56xEZJR
         mjfO5ZMI6wg3/0YGLVv945XVmp4U0P/1+xhlqaZf1kzukLsohuckgg6hpUu0+mUpyxxE
         3VszL0vIQgT/H6+gjLdqBzzJnOCSFX/xFtSMyW7cM9NkfNpehc2NP4bdSfgzdatYezZ0
         hW8g==
X-Gm-Message-State: APjAAAUw6KlU1uxB9PFomzjuCM/Y5BIplRRniCx3xEWrI0iG3+6Bz7Ku
        7gu6Pp8lzIjrKuadsjN6Ags=
X-Google-Smtp-Source: APXvYqyyZhdkXK8g0sLePyR6l4zhfnmyb2KiofxkUTUsjgKZqct8BNzsdp6s2tb9C4rZ8V0W5saZcg==
X-Received: by 2002:a63:f910:: with SMTP id h16mr9065781pgi.148.1576369986531;
        Sat, 14 Dec 2019 16:33:06 -0800 (PST)
Received: from [192.168.0.180] (c-71-63-171-240.hsd1.or.comcast.net. [71.63.171.240])
        by smtp.gmail.com with ESMTPSA id j21sm16551583pfe.175.2019.12.14.16.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2019 16:33:06 -0800 (PST)
Subject: Re: Does anyone use RANDSTRUCT?
To:     Dan Aloni <dan@kernelim.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        SELinux <selinux@vger.kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
References: <bf727420-b7bd-d3e9-a597-812922ba20a3@tycho.nsa.gov>
 <201912130943.A301DBF@keescook>
 <7514d477-3a27-0d35-d611-335a103290ec@tycho.nsa.gov>
 <20191213223958.GB31026@gmail.com>
From:   Connor Kuehl <cipkuehl@gmail.com>
Message-ID: <bc8d099a-2973-22cb-d6b0-cae8786eeea8@gmail.com>
Date:   Sat, 14 Dec 2019 16:33:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213223958.GB31026@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/13/19 2:39 PM, Dan Aloni wrote:
>> Do you know if there is something inhibiting usage in e.g. Pixel devices?
>> Performance impact?
> About performance, the gcc RANDSTRUCT implementation also includes a
> performance-preserving feature where randomization takes cacheline
> boundary into consideration. The Clang implementation is expected to
> have this as well. It's a valid concern and definitely garners testing
> for anyone enabling the feature.

Just confirming this: the development branch (well I suppose that's 
technically the only branch :-) ) for Clang randstruct does already have 
this feature -- it will try its hardest to squeeze the fields into cache 
lines. It's worth noting however that this algorithm is in its first 
iteration with potentially many more to come as people that are much 
smarter than me start digging into it and contributing optimizations 
while Clang randstruct gets closer and closer to getting merged upstream.

Unfortunately I have not measured or collected any data on the 
performance implications of Clang randstruct yet... but that is 
something I am interested in doing once we've gotten all of the wrinkles 
figured out.

- Connor
