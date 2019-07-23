Return-Path: <SRS0=Z/YK=VU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634F0C76186
	for <selinux@archiver.kernel.org>; Tue, 23 Jul 2019 22:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37821218D4
	for <selinux@archiver.kernel.org>; Tue, 23 Jul 2019 22:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AAitTFh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbfGWWP3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:15:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40300 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731353AbfGWWP3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jul 2019 18:15:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so21094176pla.7
        for <selinux@vger.kernel.org>; Tue, 23 Jul 2019 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Icfg5DcCCEWimw0gGN65g6qUR7rCNKmXBTgcheDTHT0=;
        b=AAitTFh2B1QRrWnzVv1syYfrHTyY0naNYdK1DbZWAxXpVZ82DU0Irl3dPPzLxjGCt7
         luuUN83r3FbCK99c2hnssohgwYEk2pxj1VRGiN1xIRzQT8xC4hSWm2QIcASeTD1gbsUX
         E0aHWa9Xodhg1vNuqeTUbyoDE69Y4OaK1BCU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Icfg5DcCCEWimw0gGN65g6qUR7rCNKmXBTgcheDTHT0=;
        b=tgUGYHuNL7VjCYWXXqgWazYs+DrEXEAAyj5mBmN93Hm58PvFK81vrt1RD5jiB+fKGf
         7abY+89tWShhdtyAiMc16tqql1x/Tu0VcMUrJggpFj2WGUm2XWEDCi49pVKw1MmQoVxS
         04XEX6JkVkKC1/az2Hx2FULTYEnXOKV6Ys1taCeDHSxumtk5mXu3ClvQ0guqrl4phGTJ
         X+YxTB2NI8lSV5c7wXUfdZDYZ7lToVjJoE4BYDvTuVjqYNW16j1WnrxQGe2k7jM+TS05
         a88kpHMbTLMIK/ZRRJePWLNfyI4fMqzIlKTMlnOCAZl3jxd7rrFl6dsaPuQ6szuBLGHH
         zXag==
X-Gm-Message-State: APjAAAVZ/yHGlofGfLZI5ns5Q6QmfaT6zT541fDSdYQG6cGWHCgjE/wE
        AoWZPb0iWgVb4NhHwU/x4RBTzA==
X-Google-Smtp-Source: APXvYqxoNU4NH/h4TE8rzkylhvVL55TyYXlrleqGKlj7SubNJWr2FLU6Gr22QEQzgWsjYYr7scRn5g==
X-Received: by 2002:a17:902:1129:: with SMTP id d38mr83569879pla.220.1563920129029;
        Tue, 23 Jul 2019 15:15:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x67sm46967981pfb.21.2019.07.23.15.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 15:15:28 -0700 (PDT)
Date:   Tue, 23 Jul 2019 15:15:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        NitinGote <nitin.r.gote@intel.com>,
        kernel-hardening@lists.openwall.com,
        William Roberts <bill.c.roberts@gmail.com>
Subject: Re: [PATCH v2] selinux: check sidtab limit before adding a new entry
Message-ID: <201907231515.DCFF5B6582@keescook>
References: <20190723065059.30101-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723065059.30101-1-omosnace@redhat.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 23, 2019 at 08:50:59AM +0200, Ondrej Mosnacek wrote:
> We need to error out when trying to add an entry above SIDTAB_MAX in
> sidtab_reverse_lookup() to avoid overflow on the odd chance that this
> happens.
> 
> Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve performance")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/selinux/ss/sidtab.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index e63a90ff2728..1f0a6eaa2d6a 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -286,6 +286,11 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>  		++count;
>  	}
>  
> +	/* bail out if we already reached max entries */
> +	rc = -EOVERFLOW;
> +	if (count >= SIDTAB_MAX)
> +		goto out_unlock;
> +
>  	/* insert context into new entry */
>  	rc = -ENOMEM;
>  	dst = sidtab_do_lookup(s, count, 1);
> -- 
> 2.21.0
> 

-- 
Kees Cook
