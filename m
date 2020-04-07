Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C473C2BA80
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 18:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258B520768
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 18:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lEEFfkSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgDGSrZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:47:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34338 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGSrZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 14:47:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id v23so1855750pfm.1
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lBM478ptNZ+mXPkBTDrWju1nd+FEGJmPSRx/pSF4GdI=;
        b=lEEFfkSLatJXRvqSzlrhOAdf9B2HOWMrw6pjcOWYjJklIuBxGHbrRt/D/k2uXzn3iL
         nZx8Ly6aw7f7rbrHI68rFIDj9Cdsg7bHhO8hEWMQ683Y/u04T1TCZ/ZCaLr18PWEI/+1
         ID6pNcYsSVPZRDEZY4CMZ14uRf1qIz/VyTZEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lBM478ptNZ+mXPkBTDrWju1nd+FEGJmPSRx/pSF4GdI=;
        b=f9Sz22zpdP87mEp0NZqodc4vJDkPtXMHrC0gu2wyvf0eOhqj2gTsxka0DB7H3Oh9EQ
         1VRrQtZBxPsO+0CSaeiIWIxhNxaZGqCNScRygIL7zZ1V672m2mlgckNzf8/ARiAma86d
         0Yj6fatI0OR57tlzzEC/UTMbQg69qMdPxe6GM63PnJJGWf68VNs2sKiJatWzdyVfRYkB
         hKhH+lMRnXb058bANM/7RgBCg7rpttiodBCvpjddXqmGLtVb+k8vACbKbZCyzVVKY46X
         tKoO7q+jG7VikZVg7sQumrMlV7SxabIsl605bWgAuMRV01Dh5y90YwC+uzieiVz5bszv
         XYBQ==
X-Gm-Message-State: AGi0PuYINbCfrre4i3xmq5Q7eSDZGpAARVy+K+1tXINtv80T/jQwSGfL
        yF2/xfiVMkIcQQOOzzAxxB5UPQ==
X-Google-Smtp-Source: APiQypJUKFtNnGZpWZI+kN9uCwkeVsjibmdDh+2DxPIMP+R+0eU7Kj6JqiL+pqadezDG56nZd+/4dA==
X-Received: by 2002:a62:fc07:: with SMTP id e7mr3943387pfh.299.1586285243275;
        Tue, 07 Apr 2020 11:47:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s22sm15188402pfh.18.2020.04.07.11.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:47:22 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:47:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: Re: [PATCH v16 22/23] LSM: Add /proc attr entry for full LSM context
Message-ID: <202004071147.6073511E9@keescook>
References: <20200407000159.43602-1-casey@schaufler-ca.com>
 <20200407000159.43602-23-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407000159.43602-23-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 06, 2020 at 05:01:58PM -0700, Casey Schaufler wrote:
> Add an entry /proc/.../attr/context which displays the full
> process security "context" in compound format:
>         lsm1\0value\0lsm2\0value\0...
> This entry is not writable.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Cc: linux-api@vger.kernel.org
> ---
>  Documentation/security/lsm.rst       | 28 +++++++++++++
>  fs/proc/base.c                       |  1 +
>  include/linux/lsm_hooks.h            |  6 +++
>  security/apparmor/include/procattr.h |  2 +-
>  security/apparmor/lsm.c              |  8 +++-
>  security/apparmor/procattr.c         | 22 +++++-----
>  security/security.c                  | 63 ++++++++++++++++++++++++++++
>  security/selinux/hooks.c             |  2 +-
>  security/smack/smack_lsm.c           |  2 +-
>  9 files changed, 119 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
> index aadf47c808c0..304260778cab 100644
> --- a/Documentation/security/lsm.rst
> +++ b/Documentation/security/lsm.rst
> @@ -199,3 +199,31 @@ capability-related fields:
>  -  ``fs/nfsd/auth.c``::c:func:`nfsd_setuser()`
>  
>  -  ``fs/proc/array.c``::c:func:`task_cap()`
> +
> +LSM External Interfaces
> +=======================
> +
> +The LSM infrastructure does not generally provide external interfaces.
> +The individual security modules provide what external interfaces they
> +require.
> +
> +The file ``/sys/kernel/security/lsm`` provides a comma
> +separated list of the active security modules.
> +
> +The file ``/proc/pid/attr/display`` contains the name of the security
> +module for which the ``/proc/pid/attr/current`` interface will
> +apply. This interface can be written to.
> +
> +The infrastructure does provide an interface for the special
> +case where multiple security modules provide a process context.
> +This is provided in compound context format.
> +
> +-  `lsm\0value\0lsm\0value\0`
> +
> +The `lsm` and `value` fields are nul terminated bytestrings.
> +Each field may contain whitespace or non-printable characters.
> +The nul bytes are included in the size of a compound context.
> +The context ``Bell\0Secret\0Biba\0Loose\0`` has a size of 23.
> +
> +The file ``/proc/pid/attr/context`` provides the security
> +context of the identified process.
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 505331ab7a14..4cc418ce9c3e 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2744,6 +2744,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>  	ATTR(NULL, "keycreate",		0666),
>  	ATTR(NULL, "sockcreate",	0666),
>  	ATTR(NULL, "display",		0666),
> +	ATTR(NULL, "context",		0444),
>  #ifdef CONFIG_SECURITY_SMACK
>  	DIR("smack",			0555,
>  	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 2bf82e1cf347..61977a33f2c3 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1321,6 +1321,12 @@
>   *	@pages contains the number of pages.
>   *	Return 0 if permission is granted.
>   *
> + * @getprocattr:
> + *	Provide the named process attribute for display in special files in
> + *	the /proc/.../attr directory.  Attribute naming and the data displayed
> + *	is at the discretion of the security modules.  The exception is the
> + *	"context" attribute, which will contain the security context of the
> + *	task as a nul terminated text string without trailing whitespace.
>   * @ismaclabel:
>   *	Check if the extended attribute specified by @name
>   *	represents a MAC label. Returns 1 if name is a MAC
> diff --git a/security/apparmor/include/procattr.h b/security/apparmor/include/procattr.h
> index 31689437e0e1..03dbfdb2f2c0 100644
> --- a/security/apparmor/include/procattr.h
> +++ b/security/apparmor/include/procattr.h
> @@ -11,7 +11,7 @@
>  #ifndef __AA_PROCATTR_H
>  #define __AA_PROCATTR_H
>  
> -int aa_getprocattr(struct aa_label *label, char **string);
> +int aa_getprocattr(struct aa_label *label, char **string, bool newline);
>  int aa_setprocattr_changehat(char *args, size_t size, int flags);
>  
>  #endif /* __AA_PROCATTR_H */
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 16b992235c11..02f305ab2c69 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -593,6 +593,7 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
>  	const struct cred *cred = get_task_cred(task);
>  	struct aa_task_ctx *ctx = task_ctx(current);
>  	struct aa_label *label = NULL;
> +	bool newline = true;
>  
>  	if (strcmp(name, "current") == 0)
>  		label = aa_get_newest_label(cred_label(cred));
> @@ -600,11 +601,14 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
>  		label = aa_get_newest_label(ctx->previous);
>  	else if (strcmp(name, "exec") == 0 && ctx->onexec)
>  		label = aa_get_newest_label(ctx->onexec);
> -	else
> +	else if (strcmp(name, "context") == 0) {
> +		label = aa_get_newest_label(cred_label(cred));
> +		newline = false;
> +	} else
>  		error = -EINVAL;
>  
>  	if (label)
> -		error = aa_getprocattr(label, value);
> +		error = aa_getprocattr(label, value, newline);
>  
>  	aa_put_label(label);
>  	put_cred(cred);
> diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
> index c929bf4a3df1..be3b083d9b74 100644
> --- a/security/apparmor/procattr.c
> +++ b/security/apparmor/procattr.c
> @@ -20,6 +20,7 @@
>   * aa_getprocattr - Return the profile information for @profile
>   * @profile: the profile to print profile info about  (NOT NULL)
>   * @string: Returns - string containing the profile info (NOT NULL)
> + * @newline: Should a newline be added to @string.
>   *
>   * Returns: length of @string on success else error on failure
>   *
> @@ -30,20 +31,21 @@
>   *
>   * Returns: size of string placed in @string else error code on failure
>   */
> -int aa_getprocattr(struct aa_label *label, char **string)
> +int aa_getprocattr(struct aa_label *label, char **string, bool newline)
>  {
>  	struct aa_ns *ns = labels_ns(label);
>  	struct aa_ns *current_ns = aa_get_current_ns();
> +	int flags = FLAG_VIEW_SUBNS | FLAG_HIDDEN_UNCONFINED;
>  	int len;
>  
>  	if (!aa_ns_visible(current_ns, ns, true)) {
>  		aa_put_ns(current_ns);
>  		return -EACCES;
>  	}
> +	if (newline)
> +		flags |= FLAG_SHOW_MODE;
>  
> -	len = aa_label_snxprint(NULL, 0, current_ns, label,
> -				FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
> -				FLAG_HIDDEN_UNCONFINED);
> +	len = aa_label_snxprint(NULL, 0, current_ns, label, flags);
>  	AA_BUG(len < 0);
>  
>  	*string = kmalloc(len + 2, GFP_KERNEL);
> @@ -52,19 +54,19 @@ int aa_getprocattr(struct aa_label *label, char **string)
>  		return -ENOMEM;
>  	}
>  
> -	len = aa_label_snxprint(*string, len + 2, current_ns, label,
> -				FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
> -				FLAG_HIDDEN_UNCONFINED);
> +	len = aa_label_snxprint(*string, len + 2, current_ns, label, flags);
>  	if (len < 0) {
>  		aa_put_ns(current_ns);
>  		return len;
>  	}
>  
> -	(*string)[len] = '\n';
> -	(*string)[len + 1] = 0;
> +	if (newline) {
> +		(*string)[len] = '\n';
> +		(*string)[++len] = 0;
> +	}
>  
>  	aa_put_ns(current_ns);
> -	return len + 1;
> +	return len;
>  }
>  
>  /**
> diff --git a/security/security.c b/security/security.c
> index d3bf71d66724..6643be07e778 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -754,6 +754,42 @@ static void __init lsm_early_task(struct task_struct *task)
>  		panic("%s: Early task alloc failed.\n", __func__);
>  }
>  
> +/**
> + * append_ctx - append a lsm/context pair to a compound context
> + * @ctx: the existing compound context
> + * @ctxlen: size of the old context, including terminating nul byte
> + * @lsm: new lsm name, nul terminated
> + * @new: new context, possibly nul terminated
> + * @newlen: maximum size of @new
> + *
> + * replace @ctx with a new compound context, appending @newlsm and @new
> + * to @ctx. On exit the new data replaces the old, which is freed.
> + * @ctxlen is set to the new size, which includes a trailing nul byte.
> + *
> + * Returns 0 on success, -ENOMEM if no memory is available.
> + */
> +static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char *new,
> +		      int newlen)
> +{
> +	char *final;
> +	int llen;
> +
> +	llen = strlen(lsm) + 1;
> +	newlen = strnlen(new, newlen) + 1;
> +
> +	final = kzalloc(*ctxlen + llen + newlen, GFP_KERNEL);
> +	if (final == NULL)
> +		return -ENOMEM;
> +	if (*ctxlen)
> +		memcpy(final, *ctx, *ctxlen);
> +	memcpy(final + *ctxlen, lsm, llen);
> +	memcpy(final + *ctxlen + llen, new, newlen);
> +	kfree(*ctx);
> +	*ctx = final;
> +	*ctxlen = *ctxlen + llen + newlen;
> +	return 0;
> +}
> +
>  /*
>   * Hook list operation macros.
>   *
> @@ -2073,6 +2109,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>  				char **value)
>  {
>  	struct security_hook_list *hp;
> +	char *final = NULL;
> +	char *cp;
> +	int rc = 0;
> +	int finallen = 0;
>  	int display = lsm_task_display(current);
>  	int slot = 0;
>  
> @@ -2100,6 +2140,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>  		return -ENOMEM;
>  	}
>  
> +	if (!strcmp(name, "context")) {
> +		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
> +				     list) {
> +			rc = hp->hook.getprocattr(p, "context", &cp);
> +			if (rc == -EINVAL)
> +				continue;
> +			if (rc < 0) {
> +				kfree(final);
> +				return rc;
> +			}
> +			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
> +					cp, rc);
> +			if (rc < 0) {
> +				kfree(final);
> +				return rc;
> +			}
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
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 75af88abb346..c5f2ff29645b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6257,7 +6257,7 @@ static int selinux_getprocattr(struct task_struct *p,
>  			goto bad;
>  	}
>  
> -	if (!strcmp(name, "current"))
> +	if (!strcmp(name, "current") || !strcmp(name, "context"))
>  		sid = __tsec->sid;
>  	else if (!strcmp(name, "prev"))
>  		sid = __tsec->osid;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 5bee05bd7a42..453923eee950 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3479,7 +3479,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
>  	char *cp;
>  	int slen;
>  
> -	if (strcmp(name, "current") != 0)
> +	if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
>  		return -EINVAL;
>  
>  	cp = kstrdup(skp->smk_known, GFP_KERNEL);
> -- 
> 2.24.1
> 

-- 
Kees Cook
