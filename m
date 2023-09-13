Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1067DEE01FE
	for <selinux@archiver.kernel.org>; Wed, 13 Sep 2023 17:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjIMRrD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Sep 2023 13:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjIMRrB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Sep 2023 13:47:01 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41A81BCE
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 10:46:55 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77058512c18so6891085a.1
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694627215; x=1695232015; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RwMj9CV1ar3+oq7/cp83rZlUQWbuMO2u1KsPFYY/2HQ=;
        b=PbNa2acykmtwpK5qmr4v2YqVvvNwLkNJrr3+xc5Ex8esRRbENvEpF8a/BAjsrPvLmb
         LV+tsbQIOci2Z5+X36lf8w/zbL6MkwePhNjq5+cuFFahi19C8M0Y7miN2KAX8ki0sqqk
         ADwlTgbdvgbuAGrUK5u2BUEwdcb1mKXvjgmoJfBWWf+j+810JZMrzza+G755cLerdjpv
         LQwp5RbsiWkUxK/Bqw1Ebrd36h0rVDrOCcWR6e951VZX/U+f3v761A4ElL7FirooJXwo
         63XEoXnQ8cuE03xZubIr3Ouz/bj5+5NQbQt6OhJ4tKqho7qb0cSMXflw1tkuv6TpqKCK
         hP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694627215; x=1695232015;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwMj9CV1ar3+oq7/cp83rZlUQWbuMO2u1KsPFYY/2HQ=;
        b=LOZ3mColFx0BcnB/cHX1pGhRy6k69iaNOXEfVWcEYNOYH1jLj5VVO6cgwMIzRzqX2D
         DB31x8PoK0Uqj/f8YJnlUh+1CxWfNWGE6JfiYbQN7LmmTSGzvbUjIhNfULt1nGQNvmY7
         qhhmnbaaY2MnErUSHyRNvueLwsLyMpDjZO4zYTUcKNswk+blmD9xqUgy2EHKr1Vu7WmK
         R5cSAAKffsZY8/B0lbfoVi8eYvSMk8UWEQUBt1OoRzsjUH0aHx3NAteJsVf5rQjMwFHc
         beEPJs9JzG7A7ghwU0C/1OiT5eA7o4L79QC5k2BBld9aRYpg/GkA6PU6IRG0+CxPM7j7
         kRsQ==
X-Gm-Message-State: AOJu0YzkpshtSM5J94mFMVHFC+aQk4fpB/BcsLdpeZfzmW4HC18seH7e
        28u3gS21FcMyaNeE3FbRNm7W
X-Google-Smtp-Source: AGHT+IE43H1tKTPpK87upOxx8lwGF3DbnW12hEwme+ovZDMYkHiprYxqc3Q2LTetzSVAHOV7qJ/vLQ==
X-Received: by 2002:a05:620a:2486:b0:76f:2f7b:cf41 with SMTP id i6-20020a05620a248600b0076f2f7bcf41mr3925219qkn.48.1694627214979;
        Wed, 13 Sep 2023 10:46:54 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id s26-20020a05620a031a00b00767d8e12ce3sm4039697qkm.49.2023.09.13.10.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:46:54 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:46:54 -0400
Message-ID: <98b6b64781e87c822ded50fe81e5d793.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] selinux: improve debug configuration
References: <20230818151220.166215-2-cgzones@googlemail.com>
In-Reply-To: <20230818151220.166215-2-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Aug 18, 2023 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> If the SELinux debug configuration is enabled define the macro DEBUG
> such that pr_debug() calls are always enabled, regardless of
> CONFIG_DYNAMIC_DEBUG, since those message are the main reason for this
> configuration in the first place.
> 
> Mention example usage in case CONFIG_DYNAMIC_DEBUG is enabled in the
> help section of the configuration.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/Kconfig  | 10 ++++++++++
>  security/selinux/Makefile |  2 ++
>  2 files changed, 12 insertions(+)

Merged into selinux/next, thanks!

--
paul-moore.com
