Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726CCC25B67
	for <selinux@archiver.kernel.org>; Thu, 26 Oct 2023 15:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345413AbjJZPOH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Oct 2023 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345466AbjJZPOA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Oct 2023 11:14:00 -0400
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0981B1BE
        for <selinux@vger.kernel.org>; Thu, 26 Oct 2023 08:13:57 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SGTpX2bnFzMpnd5;
        Thu, 26 Oct 2023 15:13:56 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4SGTpW6r2pzMpnPl;
        Thu, 26 Oct 2023 17:13:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1698333236;
        bh=GNTUIcIytvsrGMRiXhUR2N5F3/NkaYm5Wab5id7VLgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9slTbQxjdHYp4peeQV1+ezGGqwWk4DYJAEOcQL4fB3kH+y10xJELOmidpDKZ3jtb
         aSpehuoZqAZHBR9OvxvIxr9D+JRbnydgIKNS7FyK2rnk2o4qvPOBj+KjZP9e+70etx
         csolRq4Fdki2o7Qt8rT8hDOJdpafDnwTFTZfry9Q=
Date:   Thu, 26 Oct 2023 17:13:53 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [RFC PATCH 3/3] lsm: consolidate buffer size handling into
 lsm_fill_user_ctx()
Message-ID: <20231026.ieyieDie4see@digikod.net>
References: <20231024213525.361332-4-paul@paul-moore.com>
 <20231024213525.361332-7-paul@paul-moore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024213525.361332-7-paul@paul-moore.com>
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 24, 2023 at 05:35:29PM -0400, Paul Moore wrote:
> While we have a lsm_fill_user_ctx() helper function designed to make
> life easier for LSMs which return lsm_ctx structs to userspace, we
> didn't include all of the buffer length safety checks and buffer
> padding adjustments in the helper.  This led to code duplication
> across the different LSMs and the possibility for mistakes across the
> different LSM subsystems.  In order to reduce code duplication and
> decrease the chances of silly mistakes, we're consolidating all of
> this code into the lsm_fill_user_ctx() helper.
> 
> The buffer padding is also modified from a fixed 8-byte alignment to
> an alignment that matches the word length of the machine
> (BITS_PER_LONG / 8).
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---

> diff --git a/security/security.c b/security/security.c
> index 67ded406a5ea..45c4f5440c95 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -773,42 +773,49 @@ static int lsm_superblock_alloc(struct super_block *sb)
>  
>  /**
>   * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
> - * @ctx: an LSM context to be filled
> - * @context: the new context value
> - * @context_size: the size of the new context value
> + * @uctx: a userspace LSM context to be filled
> + * @uctx_len: available uctx size (input), used uctx size (output)
> + * @val: the new LSM context value
> + * @val_len: the size of the new LSM context value
>   * @id: LSM id
>   * @flags: LSM defined flags
>   *
> - * Fill all of the fields in a user space lsm_ctx structure.
> - * Caller is assumed to have verified that @ctx has enough space
> - * for @context.
> + * Fill all of the fields in a userspace lsm_ctx structure.
>   *
> - * Returns 0 on success, -EFAULT on a copyout error, -ENOMEM
> - * if memory can't be allocated.
> + * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
> + * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
>   */
> -int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> -		      size_t context_size, u64 id, u64 flags)
> +int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
> +		      void *val, size_t val_len,
> +		      u64 id, u64 flags)
>  {
> -	struct lsm_ctx *lctx;
> -	size_t locallen = struct_size(lctx, ctx, context_size);
> +	struct lsm_ctx *nctx = NULL;
> +	size_t nctx_len;
>  	int rc = 0;
>  
> -	lctx = kzalloc(locallen, GFP_KERNEL);
> -	if (lctx == NULL)
> -		return -ENOMEM;
> +	nctx_len = ALIGN(struct_size(nctx, ctx, val_len), BITS_PER_LONG / 8);

Why the arch-dependent constant?

I'm not even sure why we want to align this size. We'll only copy the
actual size right?

> +	if (nctx_len > *uctx_len) {
> +		rc = -E2BIG;
> +		goto out;
> +	}
>  
> -	lctx->id = id;
> -	lctx->flags = flags;
> -	lctx->ctx_len = context_size;
> -	lctx->len = locallen;
> +	nctx = kzalloc(nctx_len, GFP_KERNEL);
> +	if (nctx == NULL) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +	nctx->id = id;
> +	nctx->flags = flags;
> +	nctx->len = nctx_len;
> +	nctx->ctx_len = val_len;
> +	memcpy(nctx->ctx, val, val_len);
>  
> -	memcpy(lctx->ctx, context, context_size);
> -
> -	if (copy_to_user(ctx, lctx, locallen))
> +	if (copy_to_user(uctx, nctx, nctx_len))
>  		rc = -EFAULT;
>  
> -	kfree(lctx);
> -
> +out:
> +	kfree(nctx);
> +	*uctx_len = nctx_len;
>  	return rc;
>  }
>  
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1fe30e635923..c32794979aab 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6480,30 +6480,32 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
>  	return error;
>  }
>  
> +/**
> + * selinux_getselfattr - Get SELinux current task attributes
> + * @attr: the requested attribute
> + * @ctx: buffer to receive the result
> + * @size: buffer size (input), buffer size used (output)
> + * @flags: unused
> + *
> + * Fill the passed user space @ctx with the details of the requested
> + * attribute.
> + *
> + * Returns the number of attributes on success, an error code otherwise.
> + * There will only ever be one attribute.
> + */
>  static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
>  			       size_t *size, u32 flags)
>  {
> -	char *value;
> -	size_t total_len;
> -	int len;
> -	int rc = 0;
> +	int rc;
> +	char *val;
> +	int val_len;
>  
> -	len = selinux_lsm_getattr(attr, current, &value);
> -	if (len < 0)
> -		return len;
> -
> -	total_len = ALIGN(struct_size(ctx, ctx, len), 8);
> -
> -	if (total_len > *size)
> -		rc = -E2BIG;
> -	else if (ctx)
> -		rc = lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
> -
> -	kfree(value);
> -	*size = total_len;
> -	if (rc < 0)
> -		return rc;
> -	return 1;
> +	val_len = selinux_lsm_getattr(attr, current, &val);
> +	if (val_len < 0)
> +		return val_len;
> +	rc = lsm_fill_user_ctx(ctx, size, val, val_len, LSM_ID_SELINUX, 0);
> +	kfree(val);
> +	return (!rc ? 1 : rc);
>  }
>  
>  static int selinux_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
