Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234B8C77B7A
	for <selinux@archiver.kernel.org>; Tue, 16 May 2023 22:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjEPWaR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 May 2023 18:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEPWaQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 May 2023 18:30:16 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AF75FC2
        for <selinux@vger.kernel.org>; Tue, 16 May 2023 15:30:14 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75773252cbfso16873485a.2
        for <selinux@vger.kernel.org>; Tue, 16 May 2023 15:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684276214; x=1686868214;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phsWgqGi3UqZufaKCLWYfFYpzBCn0GS6y/Ad6f+207c=;
        b=cCzjMmvq887qQgowLdaqX9th2pz8vL+0I/6UBZhQsow15fUlJsmVf4HB8DSvFgv7ur
         BocByuMb6GPgyqURTb/BW+9nXGWe6OBbPVq6z53C80ASog239Ge3xogUwd9Z0/5KL2GV
         4fUZOTS5PmKmAjqBBQd/pfxXPMN55/+Dp2jNkeN0x7XduzbYYgclvbaQy1mDza1QGoKt
         9/D1rjUR4zcwVFTCXKP5sbpmsZwQLujUEOZES7LwSldY58W1f4B1HpqoRp0z69p7bcUw
         5vFwQ2fF5c9uxG9DhU5xDtqVkZsMZHRIpDDPnxN9soHoge8g0ljQrZCRLILPjdiLGrvX
         cjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276214; x=1686868214;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phsWgqGi3UqZufaKCLWYfFYpzBCn0GS6y/Ad6f+207c=;
        b=A76hMFwhlmzUwq3ooRPm7r/H+KmHldT8OsD4cYaFhDI4PnoCuUboDgH+lHkCYY3Qq4
         jh8ZXMsVQ4fPBnmkZZ/7DZwU1dRJpmOElBkxDTDgWAoi+1uBQqLPIG3GBf8arfNBeGZW
         pkxQXRVVpEz85OCZx8WB3HJ9fo6n9VrjplNc1ElmF0h60qUy8fVkkBbtnr/ECCVoY4+8
         pfQF7FEdLL+FzXg3wBY33fUgkmaaVhwu6pNixb8y0x9/37yJ2q5LbDcIQmYu8H1UUgVU
         1jiucAFFSX8ZrHif/1VUwdLFoWqDcfbP7tsYFFO9qGDnVHd+TQ1roZueegnS2QSKmAMk
         MW4g==
X-Gm-Message-State: AC+VfDzkGhtIYbtYS2sGDGA3mGo0Dk9ql1eKldwolynNV4ci7KuMoDM9
        tRw3VmnzOWeokWNlGbJK4cbYWncXzuzWmAoo9w==
X-Google-Smtp-Source: ACHHUZ7uu2XPPCmOy+Nm+WfIrbWujUNwoQZvmiUaG+bDQFgvIXnOEVaxmLUsj8idVK0ANwG1VZfeFQ==
X-Received: by 2002:a05:622a:1aaa:b0:3f2:e4f:49cc with SMTP id s42-20020a05622a1aaa00b003f20e4f49ccmr60904894qtc.40.1684276213886;
        Tue, 16 May 2023 15:30:13 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a120a00b0074d4cf8f9fcsm170055qkj.107.2023.05.16.15.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:30:13 -0700 (PDT)
Date:   Tue, 16 May 2023 18:30:12 -0400
Message-ID: <2379b42f2bdaad95adfc90b38bcbe2b4.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Subject: Re: [PATCH RFC] selinux: TESTING ONLY, PLEASE IGNORE
References: <20230516221253.506628-1-paul@paul-moore.com>
In-Reply-To: <20230516221253.506628-1-paul@paul-moore.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On May 16, 2023 Paul Moore <paul@paul-moore.com> wrote:
> 
> This patch can be safely ignored, I'm testing some new automated
> tooling and needed to do an on-list test.  My apologies for the
> noise.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/netlabel.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

This is also a test, you can ignore this one too.

--
paul-moore.com
