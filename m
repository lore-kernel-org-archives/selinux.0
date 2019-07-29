Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F13C7618B
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 17:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50A3206BA
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 17:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T9BRSfeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfG2RQA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:16:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43694 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfG2RQA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 13:16:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so20768345pld.10
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2019 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mJa2uNlrOs5Ycd8kkCZonxIrJ2wkl4csVg49yMx7vSQ=;
        b=T9BRSfeL7bBiOZd/490J53zpbv+AJvUxQfvAh9d+1BRF5o37FYC0F/4/mdHI3ZEpQW
         Xg+zlRXWYt0e7qfD4kMdVIYXLneKrnQ2MEcF9wfTyssZ3VHpKOHZiBCh652Hd2M3il6H
         ipEMrE9GkhCv8lC0vuycLWQxc8GnpmPoCsfeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mJa2uNlrOs5Ycd8kkCZonxIrJ2wkl4csVg49yMx7vSQ=;
        b=R5HPirHKuwKSEUz2gPgxabY98ueL+m9a/Vmvr7pyoat+2pbWPfYk+72G9/DUD7qMbJ
         PeVM2QhwlO2W/HwiHJ/KIPzhRK1zgxqVA0yIkDcZoJwmW2RDh4A/rspnnN291oTFUwOu
         qenZIzJ4t477Le75kPNOzl9tXRdUQaPSmCHmr2TjNE//zT+W8dJh9MSp4aW4XLSqpL6k
         aWu0WNqGm5RhZcayUmMhSliE+PJx8v5D18YeD9d7gFqqT/egLkd0p2dv4mKu0Og4SYlq
         O2za3SlBmfyUqoi6wHHBJ50FKHv1PCUNvn6kekooBlx/SBIE5p+AIauglmcdBQjH8d1l
         cy5A==
X-Gm-Message-State: APjAAAUxO0OosUL1SliJRlGXGqZM1xavgRueQ5eRD2W24J2lIBKTPJXH
        2YKInOICfpjjgP0PHbd41DXScA==
X-Google-Smtp-Source: APXvYqzSoWMSymcRQJ3cT2Z3QIaX0tzzGi0zVJu0Xx6wdrceBbsXoyJthrDivNyhu1FQhAt5BtGMCw==
X-Received: by 2002:a17:902:724:: with SMTP id 33mr108469763pli.49.1564420559457;
        Mon, 29 Jul 2019 10:15:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w16sm75231469pfj.85.2019.07.29.10.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 10:15:58 -0700 (PDT)
Date:   Mon, 29 Jul 2019 10:15:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 24/27] LSM: Provide an user space interface for the
 default display
Message-ID: <201907291015.2654808CF@keescook>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
 <20190726233923.2570-25-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726233923.2570-25-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 26, 2019 at 04:39:20PM -0700, Casey Schaufler wrote:
> Create /sys/kernel/security/lsm_display_default which contains
> the name of the security module used when no display value
> has been set.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/inode.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/security/inode.c b/security/inode.c
> index b7772a9b315e..538a4d6796da 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -321,6 +321,22 @@ static const struct file_operations lsm_ops = {
>  	.read = lsm_read,
>  	.llseek = generic_file_llseek,
>  };
> +
> +static struct dentry *lsm_display_default_dentry;
> +static ssize_t lsm_display_default_read(struct file *filp, char __user *buf,
> +					size_t count, loff_t *ppos)
> +{
> +	const char *name = security_lsm_slot_name(0);
> +
> +	if (name == NULL)
> +		return 0;
> +	return simple_read_from_buffer(buf, count, ppos, name, strlen(name));
> +}
> +
> +static const struct file_operations lsm_display_default_ops = {
> +	.read = lsm_display_default_read,
> +	.llseek = generic_file_llseek,
> +};
>  #endif
>  
>  static int __init securityfs_init(void)
> @@ -337,8 +353,10 @@ static int __init securityfs_init(void)
>  		return retval;
>  	}
>  #ifdef CONFIG_SECURITY
> -	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL,
> -						&lsm_ops);
> +	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL, &lsm_ops);
> +	lsm_display_default_dentry = securityfs_create_file(
> +					"lsm_display_default", 0444, NULL,
> +					NULL, &lsm_display_default_ops);
>  #endif
>  	return 0;
>  }
> -- 
> 2.20.1
> 

-- 
Kees Cook
