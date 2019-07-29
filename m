Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1420CC433FF
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 17:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8B0206BA
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 17:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HOxvhQ5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfG2RTb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:19:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42675 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfG2RTb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 13:19:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so27800143plb.9
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2019 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QbSdB9R3qB91c4KmMBBKDjdhHQvn+sIwQisQEtg6if0=;
        b=HOxvhQ5pgNRydYEDcpAhwd1PrrqoSIYNdYrN9t8hx5f3A96QH+4xbD7ivDioePMzC5
         cVEO5m4942/vEg2Ub7ZbgmFBMOme5OgwJ3h0Gnyj9vJScJ8eQlVCRgtUCh9IxVy4Ea4E
         mJzMCMMTFp7bBsv2uZI8HotbWf13a7T/M8Z9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QbSdB9R3qB91c4KmMBBKDjdhHQvn+sIwQisQEtg6if0=;
        b=OomoM+AmimWDCtylBuzHfDSR2wSEJOztrXMQOC8zGtvTKEm4/Mpj8IeyCh2mG1k/Vi
         z5CCfxk1c4sZUJK6BYRIO0bUj93saLWnrcCpjuyUrBjmmdmp1R7kuhI+KOIawH2mGFh2
         kYkg7PS4IExzeDzs7h5HvhzTa1lS3j/g1G9d+08LZ619aqUOBdeFiiWoT4keYvjcXgyU
         0iGbd1/YfvsH9YyMKOC4NdqlnhQxzZ8MNrwyCydwghIWJiZjMGtRcyx3U3Jx8WXolIaG
         D6zMv1/UMjqIvdL2peZQXDPlsQr0+Yh2I0tir8IdxX/LFKFH3kJKMDydL1W0489cOmiq
         Sg+Q==
X-Gm-Message-State: APjAAAUzQwqE9oY50eGfQe13ep58uCQy/C8AG024JgiLUVV3JGtxr+6s
        VQjUPyLE2Shqs/DhaBbqayOlzg==
X-Google-Smtp-Source: APXvYqzSSTLzfkQde20zPnUVN6qqLSXmScDCubPVTGVo0ZPkf89eouKkfyFQbqvv4QJMX7URW2z+Dw==
X-Received: by 2002:a17:902:16f:: with SMTP id 102mr107161421plb.94.1564420770892;
        Mon, 29 Jul 2019 10:19:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k8sm59714831pgm.14.2019.07.29.10.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 10:19:29 -0700 (PDT)
Date:   Mon, 29 Jul 2019 10:19:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 26/27] LSM: Add /proc attr entry for full LSM context
Message-ID: <201907291018.CD249AD02@keescook>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
 <20190726233923.2570-27-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726233923.2570-27-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 26, 2019 at 04:39:22PM -0700, Casey Schaufler wrote:
> Add an entry /proc/.../attr/context which displays the full
> process security "context" in compound format:'
> 	lsm1\0value\0lsm2\0value\0...
> This entry is not writable.

As this is a new API, would it make sense to make this a bit more
human readable (i.e. newlines not %NUL)? (And if not, please justify the
reasoning in the commit log).

-Kees

> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/proc/base.c      |  1 +
>  security/security.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 7bf70e041315..79600df5f7a2 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2619,6 +2619,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>  	ATTR(NULL, "keycreate",		0666),
>  	ATTR(NULL, "sockcreate",	0666),
>  	ATTR(NULL, "display",		0666),
> +	ATTR(NULL, "context",		0666),
>  #ifdef CONFIG_SECURITY_SMACK
>  	DIR("smack",			0555,
>  	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/security/security.c b/security/security.c
> index 5551c146c035..6a89a6b90cce 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2057,6 +2057,14 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>  				char **value)
>  {
>  	struct security_hook_list *hp;
> +	char *final = NULL;
> +	char *cp;
> +	char *tp;
> +	int rc = 0;
> +	int finallen = 0;
> +	int llen;
> +	int clen;
> +	int tlen;
>  	int display = lsm_task_display(current);
>  	int slot = 0;
>  
> @@ -2074,6 +2082,43 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>  		return -ENOMEM;
>  	}
>  
> +	if (!strcmp(name, "context")) {
> +		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
> +				     list) {
> +			rc = hp->hook.getprocattr(p, "current", &cp);
> +			if (rc == -EINVAL || rc == -ENOPROTOOPT)
> +				continue;
> +			if (rc < 0) {
> +				kfree(final);
> +				return rc;
> +			}
> +			llen = strlen(hp->lsmid->lsm) + 1;
> +			clen = strlen(cp) + 1;
> +			tlen = llen + clen;
> +			if (final)
> +				tlen += finallen;
> +			tp = kzalloc(tlen, GFP_KERNEL);
> +			if (tp == NULL) {
> +				kfree(cp);
> +				kfree(final);
> +				return -ENOMEM;
> +			}
> +			if (final)
> +				memcpy(tp, final, finallen);
> +			memcpy(tp + finallen, hp->lsmid->lsm, llen);
> +			memcpy(tp + finallen + llen, cp, clen);
> +			kfree(cp);
> +			if (final)
> +				kfree(final);
> +			final = tp;
> +			finallen = tlen;
> +		}
> +		if (final == NULL)
> +			return -EINVAL;
> +		*value = final;
> +		return finallen;
> +	}
> +
>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
> -- 
> 2.20.1
> 

-- 
Kees Cook
