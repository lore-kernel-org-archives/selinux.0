Return-Path: <SRS0=NJTS=56=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282B5C2BA19
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 15:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5C820787
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 15:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cJksA6vR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440141AbgDNPh4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440526AbgDNPhr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Apr 2020 11:37:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DBAC061A0C
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2020 08:37:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k18so64081pll.6
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2020 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E1aYFwnZHmaudukbuDpuckl4Me4QrYjpxukZl9/v5Pc=;
        b=cJksA6vRI/OpucqyltkEqi/g4FHYX/ysEsoEv/KNCMkKJjrrMa/CcldDIerUr/NH2A
         TCcH4sUDObpTfuodRKf24wbOtWZTSHqcJ7LHkR0hBhzVi/JiI8iZYZazt2fLbC24sFsM
         qyh3Knm3aqJBelNv6sHuzEBeH1tFgIt4FpHyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E1aYFwnZHmaudukbuDpuckl4Me4QrYjpxukZl9/v5Pc=;
        b=QXpO+z/0wzH9cjz9KgoEg8ac/mMuTTjw4y57RQYim/OM2DKMcn06m3XAKdI0T68hMf
         x3eqeSk1VDGAIlwGGEvuzXlgDPuVdLiGNnH4IlrfcJsmI/ahiQnuRRZnF+Ga+4DxRXAO
         0xweZPdf8eA/5Fow0ESd41BjEzdnSVCEBut1d1Pn2hyLBHPLKY/MyZnMp5NuLiCXADYN
         eNdDD5UQRArBNNN3jYHDd7cOaFePaWQSLrcrrlksoV0LDJRk5t2N7bzHxodRj+EgBO+R
         doLSHmUqscNPjfrJrFb+OEF0p5IqkS7M1isy0NTNvhyaj6Wdpm0Se1vBe4HJnLoU+PF4
         5bjg==
X-Gm-Message-State: AGi0PuY0m2DKfL4PjrTLYLHaiTrSBmeJxgkkS2CctQb5OtWjXZomfJBv
        NThOafD2ODFRhvOrIM7pPaRaNg==
X-Google-Smtp-Source: APiQypIRWk4iyKx4psWtu4YClwaOg2eIlmxFEDaY/xknPiDJMgJe9NnDov5onsLb2MGZpZ4/anHxgA==
X-Received: by 2002:a17:902:167:: with SMTP id 94mr466156plb.229.1586878665691;
        Tue, 14 Apr 2020 08:37:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b11sm11481685pfr.155.2020.04.14.08.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 08:37:44 -0700 (PDT)
Date:   Tue, 14 Apr 2020 08:37:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] selinux: free str on error in str_read()
Message-ID: <202004140837.C4A4EB66@keescook>
References: <20200414142351.162526-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414142351.162526-1-omosnace@redhat.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 14, 2020 at 04:23:51PM +0200, Ondrej Mosnacek wrote:
> In [see "Fixes:"] I missed the fact that str_read() may give back an
> allocated pointer even if it returns an error, causing a potential
> memory leak in filename_trans_read_one(). Fix this by making the
> function free the allocated string whenever it returns a non-zero value,
> which also makes its behavior more obvious and prevents repeating the
> same mistake in the future.
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1461665 ("Resource leaks")
> Fixes: c3a276111ea2 ("selinux: optimize storage of filename transitions")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/selinux/ss/policydb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 70ecdc78efbd..c21b922e5ebe 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1035,14 +1035,14 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
>  	if (!str)
>  		return -ENOMEM;
>  
> -	/* it's expected the caller should free the str */
> -	*strp = str;
> -
>  	rc = next_entry(str, fp, len);
> -	if (rc)
> +	if (rc) {
> +		kfree(str);
>  		return rc;
> +	}
>  
>  	str[len] = '\0';
> +	*strp = str;
>  	return 0;
>  }
>  
> -- 
> 2.25.2
> 

-- 
Kees Cook
