Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407A6C43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 23:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D152176D
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 23:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LVLwaB2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfLQXuy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 18:50:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33270 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfLQXuy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 18:50:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so201924pgk.0
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2019 15:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JA8rujxzdMo9z42ceJ2aBRVpTbt0LiN1bnwbLAlZoOE=;
        b=LVLwaB2+AAW4GOIhISk3crRh44lA32q9l/wh33nermIQm6AP54FrN+KKtKQXCpCwYx
         Tj5SWb8UK4eyIZ4SmMosZIRcZNWHPYEzVyRz0Z+AqUYkkt04kblVJoql2o3XoC2SaGX6
         FsseUy7LkAPz5lzT1hqzbtGNyyFbILyhkJhVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JA8rujxzdMo9z42ceJ2aBRVpTbt0LiN1bnwbLAlZoOE=;
        b=q0OehU8qjYsimd7qQJfGaHOYu+IxLsogEbSE9lCPpPmFegnCWhCS9ErODqAgFULiQN
         YY77XZJeHHm0/i3Dfq8bxJgwQBivx0ACh2lt8TxDSsiFC+0D20tqIjHl3EZAqGt74/Yj
         cpfByHMoAXZ0XFvYlGfdAaMoWZ3DnaQh1+YnCrNcIeEg/k5zq8jxWUKX31ARpqbhsnjg
         so6/UxxAuWv6YhR8iKBbs/mWK6ErHpDMdQnyMIbMlnEFCzvuFws8D27vCl1BsxU1HFYB
         T2+RVDaNkC+plZ1Si0on7jGjQ3x3ppjpSveJjH00zLGf0MlHaHyRTiibuySD27ifCDAD
         HSBQ==
X-Gm-Message-State: APjAAAUDkVz33bGEKrLAJD4YtVqr/0gIX5eyb603gZB5f733U8y4cLQx
        IHTZPi/R79o+pSMjRdYo7zS75dRoyDI=
X-Google-Smtp-Source: APXvYqwJ2KxqzYKSMw4MKOgVg1Q0YspgeOblxlhbDnWKVP+XIhVz43VW3hwWYqa+EA47Djt1XekPRw==
X-Received: by 2002:a65:41cd:: with SMTP id b13mr28633070pgq.385.1576626653583;
        Tue, 17 Dec 2019 15:50:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k15sm147476pfa.153.2019.12.17.15.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 15:50:52 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:50:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     paul@paul-moore.com, selinux@vger.kernel.org, omosnace@redhat.com,
        jeffv@google.com
Subject: Re: [RFC PATCH] selinux: randomize layout of key structures
Message-ID: <201912171550.C731CA1C@keescook>
References: <20191213202838.7323-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213202838.7323-1-sds@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 13, 2019 at 03:28:38PM -0500, Stephen Smalley wrote:
> Randomize the layout of key selinux data structures.
> Initially this is applied to the selinux_state, selinux_ss,
> policydb, and task_security_struct data structures.
> 
> NB To test/use this mechanism, one must install the
> necessary build-time dependencies, e.g. gcc-plugin-devel on Fedora,
> and enable CONFIG_GCC_PLUGIN_RANDSTRUCT in the kernel configuration.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> I would have expected that two kernels built with the same config
> with this enabled would have yielded different struct layouts in
> pahole vmlinux output, but that doesn't appear to be the case. They
> do have different seeds.  Am I doing something wrong?
> Also, does DEBUG_INFO_BTF effectively undermine/negate the benefits of this
> change if enabled?
> 
>  security/selinux/include/objsec.h   | 2 +-
>  security/selinux/include/security.h | 2 +-
>  security/selinux/ss/policydb.h      | 2 +-
>  security/selinux/ss/services.h      | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index a4a86cbcfb0a..330b7b6d44e0 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -35,7 +35,7 @@ struct task_security_struct {
>  	u32 create_sid;		/* fscreate SID */
>  	u32 keycreate_sid;	/* keycreate SID */
>  	u32 sockcreate_sid;	/* fscreate SID */
> -};
> +} __randomize_layout;
>  
>  enum label_initialized {
>  	LABEL_INVALID,		/* invalid or not initialized */
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 49737087ad33..3ea406ad91b6 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -110,7 +110,7 @@ struct selinux_state {
>  	bool policycap[__POLICYDB_CAPABILITY_MAX];
>  	struct selinux_avc *avc;
>  	struct selinux_ss *ss;
> -};
> +} __randomize_layout;
>  
>  void selinux_ss_init(struct selinux_ss **ss);
>  void selinux_avc_init(struct selinux_avc **avc);
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index bc56b14e2216..98afe52a3d19 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -307,7 +307,7 @@ struct policydb {
>  
>  	u16 process_class;
>  	u32 process_trans_perms;
> -};
> +} __randomize_layout;;
>  
>  extern void policydb_destroy(struct policydb *p);
>  extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
> diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
> index fc40640a9725..c5896f39e8f6 100644
> --- a/security/selinux/ss/services.h
> +++ b/security/selinux/ss/services.h
> @@ -31,7 +31,7 @@ struct selinux_ss {
>  	struct selinux_map map;
>  	struct page *status_page;
>  	struct mutex status_lock;
> -};
> +} __randomize_layout;
>  
>  void services_compute_xperms_drivers(struct extended_perms *xperms,
>  				struct avtab_node *node);
> -- 
> 2.23.0
> 

-- 
Kees Cook
