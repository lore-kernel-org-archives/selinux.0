Return-Path: <SRS0=8ULP=VT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404C8C7618F
	for <selinux@archiver.kernel.org>; Mon, 22 Jul 2019 16:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01B821901
	for <selinux@archiver.kernel.org>; Mon, 22 Jul 2019 16:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D2/khJ/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfGVQu2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:50:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42855 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730071AbfGVQu2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Jul 2019 12:50:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so17923036pgb.9
        for <selinux@vger.kernel.org>; Mon, 22 Jul 2019 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k/rr/IC+b+AYCwJkVS7iG5L4dyRMGQKjuA/sVJR994Q=;
        b=D2/khJ/uccM0e7ifGngji8tllhujFab/EMpZoqNEEWfBonhrU/b7gbtAWayI5FF4i8
         srA5U8gP2GWO48phfpjjBZNSDHzDByMRLm1UnySrJc7RFc4SKcNZCs51udT+PZu0VJg2
         cVnf8kvipv+4sr5no0ViJug5gBzRFZ1onFPw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k/rr/IC+b+AYCwJkVS7iG5L4dyRMGQKjuA/sVJR994Q=;
        b=ncVBDwScvuMtkSjbBBkoLhacV7+xiir87iiuAY2EKpIbCArT8SEjtM0Na0bdd05l5l
         P71EygtXTJcyMft9o7w547a2wP0tjPJiuyIyehVMSi9QlLS43/iO9WAXUwo2f3gYnbzP
         Mh0Bz4OBYi9hfS7qtgi714i3b2XCq5DYP4wEQri40h86Iywce0FBZlFGP1ONHpa5d8Hv
         IhtAOng7u5JQ+9JyWiTyWoEAF+4EewtRJ4uH4j/EL8AFQOzWcUfrrZrYz2qT0jM2jt2X
         keNyQbngdWrXfWjRT3jBVo8DerQPO3eBcT2h2j8rsmDtu2DOs0lnSk2OtJEoRbi2hDmz
         kuNg==
X-Gm-Message-State: APjAAAUHpLffxUY5FqkEDp7b4KZH0kWG7OC0Ta02gfrYK5GIsolDoC9t
        wCPNKstHS6LO2mUw3bKi15rEYQ==
X-Google-Smtp-Source: APXvYqxwNoQslvK+01tS+iio6up2ZIza4GT6x75SDtylvByFPBUJY96xDK06HHEF02ZC3ljYUTIILg==
X-Received: by 2002:a65:42c6:: with SMTP id l6mr75952221pgp.442.1563814227861;
        Mon, 22 Jul 2019 09:50:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cx22sm33409024pjb.25.2019.07.22.09.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 09:50:27 -0700 (PDT)
Date:   Mon, 22 Jul 2019 09:50:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        NitinGote <nitin.r.gote@intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] selinux: check sidtab limit before adding a new entry
Message-ID: <201907220949.AFB5B68@keescook>
References: <20190722132111.25743-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722132111.25743-1-omosnace@redhat.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 22, 2019 at 03:21:11PM +0200, Ondrej Mosnacek wrote:
> We need to error out when trying to add an entry above SIDTAB_MAX in
> sidtab_reverse_lookup() to avoid overflow on the odd chance that this
> happens.
> 
> Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve performance")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Is this reachable from unprivileged userspace?

> ---
>  security/selinux/ss/sidtab.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index e63a90ff2728..54c1ba1e79ab 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -286,6 +286,11 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>  		++count;
>  	}
>  
> +	/* bail out if we already reached max entries */
> +	rc = -ENOMEM;
> +	if (count == SIDTAB_MAX)

Do you want to use >= here instead?

-Kees

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
