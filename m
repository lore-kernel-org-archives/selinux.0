Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE47C48BDF
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 01:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10BC611AE
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 01:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFKBIm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 21:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhFKBIm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 21:08:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20CBC061574
        for <selinux@vger.kernel.org>; Thu, 10 Jun 2021 18:06:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k25so1897468eja.9
        for <selinux@vger.kernel.org>; Thu, 10 Jun 2021 18:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2IbE0UDqkplcoBwYyFLTzh0YSSXPcpK0pIRNcznpsk=;
        b=1eGkRAu1mECX3+QYmR6Ax3ULxHRk79Pq25bI74ffIR34iYh3LeO+i/dGwJD8BFDQdX
         cnJSZEB6fJGYpggDS9Nq5hoau6y+je5XFcaw4/lwxQyLCiLpXnPWI7n8X0xHLRtZl+zT
         os32e2S+mSlAH3xZ6Ux1CEJ9JtabY3hK3zQMbdjwyZ9cZAsXjzYO2HA7fEQh7WDVYyZX
         nlinu6YBYfBi2jr+9yzGDUlIE3TWNoB/eDvZJMEjxYrHmwChFAWiVX3c/8wzakJpJiTJ
         kICFm4qG4cruDcECs9sSbJjn9KFzK9xvCEelMWRLucoGJ0d/4e6X/BKktJqMhl/EyiFi
         XMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2IbE0UDqkplcoBwYyFLTzh0YSSXPcpK0pIRNcznpsk=;
        b=taQm3Y9WaSt/iqp/fwIhC4QIaniZtqFyHZEcWp3ZZLpVbkOh21fTJcBGLt9k4BvA4X
         ZraKB1GuS7+FivMfdzITGBHaONBDz7zJsXMABC8KKx32hsvic/Sh9T056xJTilh9hF0G
         Qkd4MIdAqJZ7AjWpdV6DyoZ4P0M1+9hTHckkJCIylaOhF+IYyYK32alPM1Z1dAdAlIqi
         TaAMwytM6QpLQ/OGGWCd/fluFKwubyVh598Lbuv6Z7sl3PTvKzjY3KAE0r8ile7IKKBX
         7zBgQd8tUI5+zLJ6xoMHmYvL7LeiJcXD4sPVmY11L/JtCzsoiLfLtVjziREFRN92PPNF
         6X2A==
X-Gm-Message-State: AOAM532i3GhsTtEiAR8UrGUgRz+dj47JjwdS1C2yfgDpIEnkGBbKXe2h
        veIU+EeY/fZyrFe7uuQApxtPbOQsoZkJiZ3C0EEj
X-Google-Smtp-Source: ABdhPJx0TKHfTUKKbwofo48lOHqY6bpNs5Fp96fPiNYMnxeGs/QUBiv+pKoyaYieeFTyVC9y9U95lqqCoiocDB1iEQA=
X-Received: by 2002:a17:906:4111:: with SMTP id j17mr1050234ejk.488.1623373586316;
 Thu, 10 Jun 2021 18:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <1623317883-54209-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1623317883-54209-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jun 2021 21:06:15 -0400
Message-ID: <CAHC9VhQ_XkZ=ADhe5=PqV-zNuEGOHDZfsBnSErW3j+zz5b4Qrg@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, nathan@kernel.org,
        ndesaulniers@google.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 10, 2021 at 5:38 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix function name in ss/services.c kernel-doc comment
> to remove a warning found by running make W=1 LLVM=1.
>
> security/selinux/ss/services.c:2437: warning: expecting prototype for
> security_pkey_sid(). Prototype was for security_ib_pkey_sid() instead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  security/selinux/ss/services.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 3658488..bb043bf 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2423,7 +2423,7 @@ int security_port_sid(struct selinux_state *state,
>  }
>
>  /**
> - * security_pkey_sid - Obtain the SID for a pkey.
> + * security_ib_pkey_sid - Obtain the SID for a pkey.
>   * @subnet_prefix: Subnet Prefix
>   * @pkey_num: pkey number
>   * @out_sid: security identifier

This kdoc function header block is also missing the selinux_state
description.  Would you mind adding something like the following and
resubmitting your patch?

  * @state: SELinux state

... I suspect there are a number of function header comments with
similar problems in the SELinux code.

-- 
paul moore
www.paul-moore.com
