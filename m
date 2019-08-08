Return-Path: <SRS0=xPDW=WE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17E0C433FF
	for <selinux@archiver.kernel.org>; Thu,  8 Aug 2019 21:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BD721874
	for <selinux@archiver.kernel.org>; Thu,  8 Aug 2019 21:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aMlu8V6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbfHHVzb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:55:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45121 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfHHVzb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Aug 2019 17:55:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so44836890pfq.12
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2019 14:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wzGrWRLQEctANPU42R08Zw9FXHkmiyo0W0Tvmmuc3Mk=;
        b=aMlu8V6tCbIUuBH2e9JkwTjhIDrvW3Wikv8ApOp3Y8AagUKJyT2sWoG5YnccEVCLy1
         wx1E+lYCqI68Iz/lRmYOjaIfqyrwiNE+Fa37xYsqQjZ4lqGkZyv0i1V74t34TWcdU3ls
         zVusmmZpdGIICKhBOEDI4UpggMmZbW5OqpPmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wzGrWRLQEctANPU42R08Zw9FXHkmiyo0W0Tvmmuc3Mk=;
        b=Uy8ftvBOBVc5WV7lTM7PCnyAHF0OjsHKtlgGca3AonKgjhZXsSkueI0BZGU7ohiMez
         Ub7Dhp20kuQYCQ2RHJOneGlqKYrzh6cgj+jKk6jHdMXQqRVXiu61EZm6un1L9u1L1zAX
         O+SS05bpCw2lRqtazb79ww3/iFoQyq3aYFvUqVDWfJr/yRsJ4eFp9dSeYBCswp8gUOcM
         7f3/50oDbeyH4+PPH6qtKeE94xbEc8CNHDsVY47xHBQ9z72pvZTEH9g02FblUnZDY3z2
         ZAZtNKVZtxdbNCoymzIjJNYT9KK9TEeutfOlAjXzc8Wqf3oTDQQAaSn9u1ig+kCnxk2v
         6o2Q==
X-Gm-Message-State: APjAAAXixNk4cIsbc6Mdbk3g+wod0KZ7XI+eip2NfKyI13f84vjiTAbY
        IADE0hVN4Pme60YItUyjPT1Ggg==
X-Google-Smtp-Source: APXvYqy8Q6innX4+TRUt6bPTeM3/cplr2JWTopeRtamigOHl9WCvFqC+/EZVhzVfHlTcLJHBPb78Sw==
X-Received: by 2002:aa7:9ad2:: with SMTP id x18mr18542659pfp.192.1565301330388;
        Thu, 08 Aug 2019 14:55:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s6sm139204331pfs.122.2019.08.08.14.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 14:55:29 -0700 (PDT)
Date:   Thu, 8 Aug 2019 14:55:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v7 22/28] SELinux: Verify LSM display sanity in binder
Message-ID: <201908081454.FF7420D8D@keescook>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
 <20190807194410.9762-23-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807194410.9762-23-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 07, 2019 at 12:44:04PM -0700, Casey Schaufler wrote:
> Verify that the tasks on the ends of a binder transaction
> use LSM display values that don't cause SELinux contexts
> to be interpreted by another LSM or another LSM's context
> to be interpreted by SELinux. No judgement is made in cases
> that where SELinux contexts are not used in the binder
> transaction.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/selinux/hooks.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 352be16a887d..fcad2e3432d2 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2009,6 +2009,28 @@ static inline u32 open_file_to_av(struct file *file)
>  	return av;
>  }
>  
> +/*
> + * Verify that if the "display" LSM is SELinux for either task
> + * that it is for both tasks.
> + */
> +static inline bool compatible_task_displays(struct task_struct *here,
> +					    struct task_struct *there)
> +{
> +	int h = lsm_task_display(here);
> +	int t = lsm_task_display(there);
> +
> +	if (h == t)
> +		return true;
> +
> +	/* unspecified is only ok if SELinux isn't going to be involved */
> +	if (selinux_lsmid.slot == 0)
> +		return ((h == 0 && t == LSMBLOB_INVALID) ||
> +			(t == 0 && h == LSMBLOB_INVALID));

What is "0" here? Doesn't that just mean the first LSM. I though only -1
had a special meaning (and had a #define name for it).

-Kees

> +
> +	/* it's ok only if neither display is SELinux */
> +	return (h != selinux_lsmid.slot && t != selinux_lsmid.slot);
> +}
> +
>  /* Hook functions begin here. */
>  
>  static int selinux_binder_set_context_mgr(struct task_struct *mgr)
> @@ -2016,6 +2038,9 @@ static int selinux_binder_set_context_mgr(struct task_struct *mgr)
>  	u32 mysid = current_sid();
>  	u32 mgrsid = task_sid(mgr);
>  
> +	if (!compatible_task_displays(current, mgr))
> +		return -EINVAL;
> +
>  	return avc_has_perm(&selinux_state,
>  			    mysid, mgrsid, SECCLASS_BINDER,
>  			    BINDER__SET_CONTEXT_MGR, NULL);
> @@ -2029,6 +2054,9 @@ static int selinux_binder_transaction(struct task_struct *from,
>  	u32 tosid = task_sid(to);
>  	int rc;
>  
> +	if (!compatible_task_displays(from, to))
> +		return -EINVAL;
> +
>  	if (mysid != fromsid) {
>  		rc = avc_has_perm(&selinux_state,
>  				  mysid, fromsid, SECCLASS_BINDER,
> @@ -2048,6 +2076,9 @@ static int selinux_binder_transfer_binder(struct task_struct *from,
>  	u32 fromsid = task_sid(from);
>  	u32 tosid = task_sid(to);
>  
> +	if (!compatible_task_displays(from, to))
> +		return -EINVAL;
> +
>  	return avc_has_perm(&selinux_state,
>  			    fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
>  			    NULL);
> @@ -2064,6 +2095,9 @@ static int selinux_binder_transfer_file(struct task_struct *from,
>  	struct common_audit_data ad;
>  	int rc;
>  
> +	if (!compatible_task_displays(from, to))
> +		return -EINVAL;
> +
>  	ad.type = LSM_AUDIT_DATA_PATH;
>  	ad.u.path = file->f_path;
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
