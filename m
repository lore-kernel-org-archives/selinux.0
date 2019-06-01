Return-Path: <SRS0=ThDI=UA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C78DC28CC1
	for <selinux@archiver.kernel.org>; Sat,  1 Jun 2019 15:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBE327713
	for <selinux@archiver.kernel.org>; Sat,  1 Jun 2019 15:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WGASHefW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfFAPXn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 Jun 2019 11:23:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33685 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfFAPXn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 Jun 2019 11:23:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id g21so5234512plq.0
        for <selinux@vger.kernel.org>; Sat, 01 Jun 2019 08:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F0B1ps+ogRvMl+w6JhEnp7ZTeNOfQPalt9N+gdwQfXY=;
        b=WGASHefWAFVXlwrt8GhItKHS04JYwRLyTz10b2erx6HAd9LAyV1mY4k8W9wr7eRCMA
         7EoTOEH4OnAkR1v6uBcFE+3s58uMTslw0+r46UIBX8XGxlj4BCk7hmnTmaMlc1aNO16A
         6AjnM9qdtyMatMFwNncjH4j69roQLD3t3mlW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F0B1ps+ogRvMl+w6JhEnp7ZTeNOfQPalt9N+gdwQfXY=;
        b=CFTxgYgKTbLaZ+xhbqM3kCg+aIwbRci1slx/fM05x9dZEyYIiDvBiy9Cpgc0N7Wfmh
         70Zedq0eKvMXnYiZ241fBU30QUuWx3Xeb8wGGFPyYwK/PcytcqjqPBJgNa0e3JAZtv7Y
         pe1TEgEvNrBB/YhCYjt//0tRJYo6KGpRA2AtVadQqlvhxxMXERdgfPzlSnw+BCsgRD+X
         tY9zyBq4hcntOO854kPTwq+g1z3YtVNXbwK7VHZPLKSeIme4zuXgCUPZgyVaYUbCUJ+j
         k02+3K3ie4ayjrIp1XefsE9G/e4W82dFqcUbqj8Cp59A4GOWog6N9XT/o0p8CD1Rhd/c
         b/pw==
X-Gm-Message-State: APjAAAXeEtQHJLh8dNJrXDVQoQKpOSKYNvi/ZjI3w6mlEmAyrgqQRrRB
        QQMA7mmXHRP+3VcY/zmGRkNkrA==
X-Google-Smtp-Source: APXvYqwGnmV7QqOvSFxwr0SsrW853jFK6X2Z7OKZ+88zmXB2h/SSTiYWKG9ugw1TV1x+G/eM5xMaaw==
X-Received: by 2002:a17:902:1029:: with SMTP id b38mr16786384pla.72.1559402622661;
        Sat, 01 Jun 2019 08:23:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p21sm12498214pfn.129.2019.06.01.08.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2019 08:23:41 -0700 (PDT)
Date:   Sat, 1 Jun 2019 08:23:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 04/58] LSM: Create an lsm_export data structure.
Message-ID: <201906010822.03972E152B@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531231020.628-5-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 31, 2019 at 04:09:26PM -0700, Casey Schaufler wrote:
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Thoughts below...

> ---
>  include/linux/security.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 49f2685324b0..81f9f79f9a1e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -76,6 +76,18 @@ enum lsm_event {
>  	LSM_POLICY_CHANGE,
>  };
>  
> +/* Data exported by the security modules */
> +struct lsm_export {
> +	u32	selinux;
> +	u32	smack;
> +	u32	apparmor;
> +	u32	flags;
> +};

I think it might make more logical sent to leave flags at the start.
While I don't expect to add more fields, I find it surprising that
it is at the end. :)

-Kees

> +#define LSM_EXPORT_NONE		0x00
> +#define LSM_EXPORT_SELINUX	0x01
> +#define LSM_EXPORT_SMACK	0x02
> +#define LSM_EXPORT_APPARMOR	0x04
> +
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>  		       int cap, unsigned int opts);
> -- 
> 2.19.1
> 

-- 
Kees Cook
