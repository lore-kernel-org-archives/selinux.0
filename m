Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FFAC31E49
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 05:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7AB20B1F
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 05:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HR9Rl3XY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfFSFlq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:41:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33959 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfFSFlp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 01:41:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so9008307pgn.1
        for <selinux@vger.kernel.org>; Tue, 18 Jun 2019 22:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+p8x2jjIgmRSTfkWtkCD5g3Lrqs0d0z8ySCg6d5CaPw=;
        b=HR9Rl3XYP8mCfd548/pK5/en1DqUJJMaXRsDG7oBVStUq/LX6bzdWB/3Gi4SY9Ie77
         dVmeUY+vWqVsC3LfR+qibFbQAoQDagmYs6loSu8K+iar1CXBXsyMFauc7PAXpXzBIfLq
         M2tIwFf6Ns+MhZB25ibdqT80UpDQxOWwJJ+go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+p8x2jjIgmRSTfkWtkCD5g3Lrqs0d0z8ySCg6d5CaPw=;
        b=tyktdClmf3FLmx1ZeWlMno9z2lCVx2KbNttVDhbz7AtrnV+FDv2mfSkNRa8P8vME7r
         OdO2EePDhuG6vtFdC940j7m9oSliBhFCxqzSgWMsl8ZdXfWXensf21RRZg9oSoHP3sg5
         JLh/gBs+iyxFvQmvcxrnIl8sunf44F6Y0zR44gRKp6GwawHWDIiWa2AQVSLHDynZaAkK
         8EmHzKnY3KCMjgcw+KWj66zUfiSJ8bu89NKufHnkbNoaYVO6v/uD99ndZ2hp4d8e9JjB
         IR7aDXNQr+VeDsCJHEt9akUHajfzWu9Mtbtz/kmTd/b54J4qDTp9lSG0G9XVQ4yLrREB
         MIBQ==
X-Gm-Message-State: APjAAAUQYXvW1hS1fn5c/N6lYWr1d4yQgY0wctkl1lRr2rSlN7kUAo/S
        qEVOAu/f5Y20qdpzYglD1NeHzv/HsBu8ag==
X-Google-Smtp-Source: APXvYqwFlcjeIUErgFgjv5FHH/ITJE4/3Mko4fDQ99OhDegCdIwmQV29guTgQxeVLaI/ucUvcbQpOA==
X-Received: by 2002:a17:90a:9a95:: with SMTP id e21mr8966743pjp.98.1560922904862;
        Tue, 18 Jun 2019 22:41:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n89sm8003759pjc.0.2019.06.18.22.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 22:41:44 -0700 (PDT)
Date:   Tue, 18 Jun 2019 22:41:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v2 18/25] LSM: Use lsmcontext in
 security_dentry_init_security
Message-ID: <201906182238.4EBF8C17DB@keescook>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-19-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618230551.7475-19-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 18, 2019 at 04:05:44PM -0700, Casey Schaufler wrote:
> Chance the security_dentry_init_security() interface to
> fill an lsmcontext structure instead of a void * data area
> and a length. The lone caller of this interface is NFS4,
> which may make copies of the data using its own mechanisms.
> A rework of the nfs4 code to use the lsmcontext properly
> is a significant project, so the coward's way out is taken,
> and the lsmcontext data from security_dentry_init_security()
> is copied, then released directly.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/nfs/nfs4proc.c        | 26 ++++++++++++++++----------
>  include/linux/security.h |  7 +++----
>  security/security.c      | 20 ++++++++++++++++----
>  3 files changed, 35 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index af1c0db29c39..952f805965bb 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -113,6 +113,7 @@ static inline struct nfs4_label *
>  nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>  	struct iattr *sattr, struct nfs4_label *label)
>  {
> +	struct lsmcontext context;
>  	int err;
>  
>  	if (label == NULL)
> @@ -122,21 +123,26 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>  		return NULL;
>  
>  	err = security_dentry_init_security(dentry, sattr->ia_mode,
> -				&dentry->d_name, (void **)&label->label, &label->len);
> -	if (err == 0)
> -		return label;
> +					    &dentry->d_name, &context);
> +
> +	if (err)
> +		return NULL;
> +
> +	label->label = kmemdup(context.context, context.len, GFP_KERNEL);

I think this is wrong: for NUL-terminated strings, "context.len" isn't
currently including the NUL byte (it's set to strlen()).

So, if kmemdup() is used here, it means strlen() isn't correct in the
context init helper, it should be using the "size" argument, etc.

> +	if (label->label == NULL)
> +		label = NULL;
> +	else
> +		label->len = context.len;
> +
> +	security_release_secctx(&context);
> +
> +	return label;
>  
> -	return NULL;
>  }
>  static inline void
>  nfs4_label_release_security(struct nfs4_label *label)
>  {
> -	struct lsmcontext scaff; /* scaffolding */
> -
> -	if (label) {
> -		lsmcontext_init(&scaff, label->label, label->len, 0);
> -		security_release_secctx(&scaff);
> -	}
> +	kfree(label->label);

Should label be set to NULL here and len reduced to 0?

>  }
>  static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
>  {
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1fd87e80656f..92c4960dd57f 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -346,8 +346,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
>  int security_add_mnt_opt(const char *option, const char *val,
>  				int len, void **mnt_opts);
>  int security_dentry_init_security(struct dentry *dentry, int mode,
> -					const struct qstr *name, void **ctx,
> -					u32 *ctxlen);
> +					const struct qstr *name,
> +					struct lsmcontext *ctx);
>  int security_dentry_create_files_as(struct dentry *dentry, int mode,
>  					struct qstr *name,
>  					const struct cred *old,
> @@ -718,8 +718,7 @@ static inline void security_inode_free(struct inode *inode)
>  static inline int security_dentry_init_security(struct dentry *dentry,
>  						 int mode,
>  						 const struct qstr *name,
> -						 void **ctx,
> -						 u32 *ctxlen)
> +						 struct lsmcontext *ctx)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/security/security.c b/security/security.c
> index 2ea810fc4a45..23d8049ec0c1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -453,6 +453,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  		 * secid in the lsmblob structure.
>  		 */
>  		if (hooks[i].head == &security_hook_heads.audit_rule_match ||
> +		    hooks[i].head ==
> +			&security_hook_heads.dentry_init_security ||
>  		    hooks[i].head == &security_hook_heads.kernel_act_as ||
>  		    hooks[i].head ==
>  			&security_hook_heads.socket_getpeersec_dgram ||
> @@ -1030,11 +1032,21 @@ void security_inode_free(struct inode *inode)
>  }
>  
>  int security_dentry_init_security(struct dentry *dentry, int mode,
> -					const struct qstr *name, void **ctx,
> -					u32 *ctxlen)
> +				  const struct qstr *name,
> +				  struct lsmcontext *cp)
>  {
> -	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
> -				name, ctx, ctxlen);
> +	int *display = current->security;
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
> +			     list)
> +		if (*display == 0 || *display == hp->slot) {
> +			cp->slot = hp->slot;
> +			return hp->hook.dentry_init_security(dentry, mode,
> +					name, (void **)&cp->context, &cp->len);
> +		}
> +
> +	return -EOPNOTSUPP;
>  }
>  EXPORT_SYMBOL(security_dentry_init_security);
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
