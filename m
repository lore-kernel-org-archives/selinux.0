Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913FBEB64DD
	for <selinux@archiver.kernel.org>; Thu, 20 Jul 2023 20:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjGTUWA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGTUWA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jul 2023 16:22:00 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE44D2733
        for <selinux@vger.kernel.org>; Thu, 20 Jul 2023 13:21:52 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-403b6b7c0f7so10905901cf.0
        for <selinux@vger.kernel.org>; Thu, 20 Jul 2023 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689884512; x=1690489312;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHyuLsgnQpUkZCQoLU/jEv4V7OgD3rMUxhJnhOhWi14=;
        b=Yb5M0PpHwf7QzVRrWXhI4GSejp/dTkjmcf9GRRp+5meR5//PwdIhFLvv0C2zvcyX/K
         g8Y6pOArHQAbTnHiNypVQbTgsb8T+Luo/qOBiIxi14Cs9GC5551IzrAjUpQGsS3uHJHv
         psM6EqNvKuuHc3kzUPlhLEhkOn5XTstkaDloK/ZyX3288Inshx7aEc9xK+yX2tCRb1Ev
         AYwIIGt/fuLEk+lfy77zmV1P+e2xoB84grja0HdmVrhQXsSkBBFGuw3vRd/M1zNe9PCt
         MabIyobFLPMHjg7RDBDpJXYMjX+hhySdzrk5g4mhwLoJcUb6GrgTNnpTm5PDYFfXCVvs
         0bOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689884512; x=1690489312;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHyuLsgnQpUkZCQoLU/jEv4V7OgD3rMUxhJnhOhWi14=;
        b=MzzmQEEXdI7I5MrKoAzJykUOenSGPxh7GiKO8UqtFUlFvrGu6UjS0MV3Mmtq/eUhQL
         hK3eCysfUeIIM1MeC3PhHaHEmG01X6imojs3Ufa4ND+FFg0Ld5oS7561oAm8CYNdtVsc
         ZDsbNRJlGv0YZVp/VdTohA1ZajUrY7wlOoFoA2uo6WpyMMjH0nMrtsUuCV+SxFka7Ova
         +KpwBc26XnoFzhkjMComnqZvcCli+oDOHT0+ldFFiXkBEWyV3nhUI2ZFgshI9sjRWpZ9
         fOBRhaaltyBnmMd6rN8OgGapzDPY7JhQJjsDF61l54DEQeBY/OajCIzNLcdCFSpwuFaT
         Q2Cw==
X-Gm-Message-State: ABy/qLYTIZX+ifSxuASoIy5BTH8GZElwQ7U7nnxYhjurJtp3GHrX/mZO
        2aZ2cMxteKdXvlcX8T0Z8DH7XaWHss+2ljGMdQ==
X-Google-Smtp-Source: APBJJlGrmSXvG5d0+GvWOPLIJSDujnUW0KvP6PNgs53aHmHuR0Q7LjfrbzEvyedSya5UKMHGBoaSsQ==
X-Received: by 2002:ac8:5c4c:0:b0:403:e895:155b with SMTP id j12-20020ac85c4c000000b00403e895155bmr11678qtj.34.1689884511758;
        Thu, 20 Jul 2023 13:21:51 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id fu39-20020a05622a5da700b003f6c9f8f0a8sm673819qtb.68.2023.07.20.13.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:21:51 -0700 (PDT)
Date:   Thu, 20 Jul 2023 16:21:51 -0400
Message-ID: <4e8ed564dd7443b84bd5b9e329efad2f.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 3/3] selinux: log missing anonclass in debug configuration
References: <20230718184921.112786-3-cgzones@googlemail.com>
In-Reply-To: <20230718184921.112786-3-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul 18, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Log under the SELinux debug configuration when a caller to the LSM hook
> inode_init_security_anon does not pass a anonymous inode class name.
> The class name allows policy writers to transition the anonymous inode
> into a private type via a name based type transition.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Is this really a problem?  There are two callers in v6.5-rc2 and both
properly populate the @name parameter.

Considering how easy it is to look up the callers in the kernel source
and ensure they are passing a valid @name parameter I'm inclined to
leave this patch unmerged.

Thoughts?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b8a8a4f0f2ad..f6ffab9958b6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2918,6 +2918,17 @@ static int selinux_inode_init_security_anon(struct inode *inode,
>  	if (unlikely(!selinux_initialized()))
>  		return 0;
>  
> +#ifdef CONFIG_SECURITY_SELINUX_DEBUG
> +	/*
> +	 * Allow policy writers to transition the anonymous inode into
> +	 * a private type via a name based type transition.
> +	 */
> +	if (!name) {
> +		pr_debug("SELinux:  no class given for anonymous inode\n");
> +		dump_stack();
> +	}
> +#endif
> +
>  	isec = selinux_inode(inode);
>  
>  	/*
> -- 
> 2.40.1

--
paul-moore.com
