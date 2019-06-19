Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E18C31E49
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 05:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C1220B1F
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 05:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UEt5Vdin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfFSFul (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:50:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34046 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfFSFul (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 01:50:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so9068964pfc.1
        for <selinux@vger.kernel.org>; Tue, 18 Jun 2019 22:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7223D7PaosyC0inJoMjVK54m0ZlKlwIpCc71ClrqYus=;
        b=UEt5VdinZDJKKdgtGt9XZ/V6fhLbBvotEEXelHAYzQ2uDX/XzZVzO+tchRzVsPZMaD
         TEX+P81+IrZOx+pIYSjqYq+sBaWeuqMwbxYdu0QbnS4P0qZR/gHoEQx94Pyb1Z9+fYl1
         jVjQ4LIMQ7vRFg4ln99REW/vRwt9eWApaliNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7223D7PaosyC0inJoMjVK54m0ZlKlwIpCc71ClrqYus=;
        b=TAJltJj1UCtbcLKpqgA7sKl20XsaZ/0zF77FoAnGZmOjt2aJr/5AJ4Ot3zo0CJA9jf
         IEwnE3ipEgnirhBk6xi+sgsQMw25QsahRzATzzJMYj+GT4OIJ6soGeSMx+hMBkzJo9Xn
         wr1lSX9mSmqb5ZcY91WXVcFc1bUA1Ghjd5pNggvR6g7VFSofv6MVyFhJWHcNsgU3vD1v
         7sf7GgoV/yWde07HtHHHzc6XpwXGzD/TKLZq2UapT+hJL9RW2aNTFKBOaFOstyhb0Oao
         YPVrj7S+XbhbAClSK3WYoxwadW04LRqLukrQper8lCzN0WFv/BycSlcBp9GdV7l1LNZb
         cYLg==
X-Gm-Message-State: APjAAAWkgCBX/ZLVgZ3unSdlghtf2eUji600qb2hiy8NWcEj7aL5Erw1
        n7HYkYP7YigAuqXZxI5iqVGQSg==
X-Google-Smtp-Source: APXvYqy8qQzx8uqDBmkPcSR1T6bkZ47OAEVj23Jpr74KHEUILFHp9FvlJbuqaqR3bUt0AJd4sw/+PA==
X-Received: by 2002:a17:90a:24ac:: with SMTP id i41mr9164564pje.124.1560923440735;
        Tue, 18 Jun 2019 22:50:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 30sm1713435pjk.17.2019.06.18.22.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 22:50:40 -0700 (PDT)
Date:   Tue, 18 Jun 2019 22:50:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v2 24/25] Fix slotted list and getpeersec_d
Message-ID: <201906182250.02BF2E47@keescook>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-25-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618230551.7475-25-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 18, 2019 at 04:05:50PM -0700, Casey Schaufler wrote:
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Was this supposed to be folded into patch 4?

-Kees

> ---
>  security/security.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 5a23ccec7c7b..8aca43ab3e81 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -461,6 +461,8 @@ int __init security_add_hooks(struct security_hook_list *hooks, int count,
>  		    hooks[i].head == &security_hook_heads.kernel_act_as ||
>  		    hooks[i].head ==
>  			&security_hook_heads.socket_getpeersec_dgram ||
> +		    hooks[i].head == &security_hook_heads.getprocattr ||
> +		    hooks[i].head == &security_hook_heads.setprocattr ||
>  		    hooks[i].head == &security_hook_heads.secctx_to_secid ||
>  		    hooks[i].head == &security_hook_heads.release_secctx ||
>  		    hooks[i].head == &security_hook_heads.ipc_getsecid ||
> @@ -2269,7 +2271,9 @@ int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
>  			     list) {
>  		rc = hp->hook.socket_getpeersec_dgram(sock, skb,
>  						      &l->secid[hp->slot]);
> -		if (rc != 0)
> +		if (rc == -ENOPROTOOPT)
> +			rc = 0;
> +		else if (rc != 0)
>  			break;
>  	}
>  	return rc;
> -- 
> 2.20.1
> 

-- 
Kees Cook
