Return-Path: <SRS0=xPDW=WE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A52C0650F
	for <selinux@archiver.kernel.org>; Thu,  8 Aug 2019 22:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F9B216C8
	for <selinux@archiver.kernel.org>; Thu,  8 Aug 2019 22:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QxR1Gi1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404662AbfHHWWg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:22:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40711 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404661AbfHHWWg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Aug 2019 18:22:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so44057338pla.7
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2019 15:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=avKtmgA8TcHOEC/NjlpnOpgpOoMRsWrtemKQj1WZrWQ=;
        b=QxR1Gi1G3fvEa3R2VB1av1/3jtnXwoMKIeWnOO80q2YcSLY3xAP+rV7kYO7YaHym93
         sAMM19/yagofMQKntNtIwXMaCLr2BKBrnOLJ556Ro/49qsrnUWhlCXMUh/B8eBPe2HNw
         0HwYz+5v9t3WAjJtnEuX6nBEMDTwiIJMY/4ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=avKtmgA8TcHOEC/NjlpnOpgpOoMRsWrtemKQj1WZrWQ=;
        b=Mb6E7Vnjm0VJ1iMYJHW8HmIj6dqbkGKyvT8s43j+4JpEb/l75HwExreGiuWHgBgsIO
         uO4WLhn8E1h1WEcdZQZn65iLDIAe3r2yywC3IccFD0QHQGPbnbcpAI98fSwAuEKpXb12
         GkQlykPxUJ3CDZzxSiiKxsfFMVVyspolX7mmzXLq1pZE8Ct3OjH+SErAVP1Bia8Uk5aK
         hsqXt2NNezHhLafyLalSbG8ykzU891UipMaTB90ZkFLd3Jbo95KTuhCUp9cADxAd7C2G
         wioCqYTjXLrhyY5mFUn5tQUmf/gSXStUMgnjx2VdNwUvD4mFJJUz9AOXlavXQSFcaUxJ
         bwPA==
X-Gm-Message-State: APjAAAU/rnpGs0P/41NWEzgFuCit0DmQ8ieElKhkcS0ppbZxhuyM+U1p
        Y6Oddg0n8mRyDpuWDy2U+jbvNg==
X-Google-Smtp-Source: APXvYqw1ZHMMvcgpYgMZaZgbsEo+7VRzf0ltv7bFlktLpo+lIbOH3e2aXDv/oc0HlR6wU+cRj3Hglg==
X-Received: by 2002:a17:902:2be6:: with SMTP id l93mr16167646plb.0.1565302955552;
        Thu, 08 Aug 2019 15:22:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y23sm101918688pfo.106.2019.08.08.15.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 15:22:34 -0700 (PDT)
Date:   Thu, 8 Aug 2019 15:22:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v7 27/28] LSM: Add /proc attr entry for full LSM context
Message-ID: <201908081521.E0E7CC8F6@keescook>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
 <20190807194410.9762-28-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807194410.9762-28-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 07, 2019 at 12:44:09PM -0700, Casey Schaufler wrote:
> Add an entry /proc/.../attr/context which displays the full
> process security "context" in compound format:'
> 	lsm1\0value\0lsm2\0value\0...
> This entry is not writable.
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
> index 0ea7ee27e331..e9f579483d12 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2046,6 +2046,14 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
> @@ -2063,6 +2071,43 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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

Instead of a copy-paste here, please add a helper for use in both
places...

> +
>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
> -- 
> 2.20.1
> 

-- 
Kees Cook
