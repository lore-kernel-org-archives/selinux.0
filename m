Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA87C46467
	for <selinux@archiver.kernel.org>; Sun, 15 Jan 2023 22:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjAOWRu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 15 Jan 2023 17:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjAOWRt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 15 Jan 2023 17:17:49 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5EA76BB
        for <selinux@vger.kernel.org>; Sun, 15 Jan 2023 14:17:48 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so10593536pjm.1
        for <selinux@vger.kernel.org>; Sun, 15 Jan 2023 14:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=54G/B/bxRW6yaKXptv7WebflHitGnTC3Y4+Fo46SAZg=;
        b=cF1p2nPcdWQF8VS9XarQca1xlZAjqhI4BFUL2A6RmEZNIVEqxNUUcSlqYu5HV1ll7K
         rfmIbrxwoj1K+n0JHsuMaIDjwldYfxzS2TrHa14OwV0IFEgxF5NYvcDVzxP3U+ShbyiS
         B1hM45qLZHDif280BbD0bQ/p8OBA/7GFiI7nLRkpIPQXKGLC1fcHuMlHLcAECK7jKIm/
         1pb9XyhC5N2etsHS+GtNReM7HF04ZuPaG8D5VoMDEIaCh6pJMIJn80VESecBNjN8llDi
         4VV1rap/BA1+UchQkQPNv+OBR2aDlJZWD4joEnmL1Z95zBC9XMfiv/r6fnM3qNRDCLyY
         3t7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54G/B/bxRW6yaKXptv7WebflHitGnTC3Y4+Fo46SAZg=;
        b=QkK/5pjx2dbO8OOUUBwbv7nDzCwhfse0JNvLTlwsoK/AI+zvr/4NPyGxCcDUqISaJn
         X8C7aD197D0dgYKwSDo2Bn/fXy6bIG8q7/7g+vLrdEUUxrOrpTsd1S4HUjo1MMa94ebT
         YzD5cKuXUx0IYxf5NAHeNauaesYxCj7WOXregNG/SWfsEtzoC3JOJGK1xInT6UuwHfCY
         i1QyLlrwMmIQJ6+qRzDzcoQbW+l0XPUFLUzoClk7kY0GWTkkHCllOPBiEzcV1wcWx+2D
         IY2P2Ky4z0TekcS/FhcvUadPpfb6G0mq7Tung31MBp/s1jRfIpMnwMKtKoqzkWO2B3ZQ
         i7ig==
X-Gm-Message-State: AFqh2krcj5vTYO02mAcSmIzZgd8zsgM3LWNLxoJOBun13FEI6oO5+jDn
        7ct2Xeflv0Xfs0tFeHrV5PMZpQ==
X-Google-Smtp-Source: AMrXdXsYqMKYjy11Cj+1BlRSY1kfbq+7dcQDu4D5P23407czCFPp5zFZ29n1QS3bJrIS//Xi0SJBbA==
X-Received: by 2002:a17:902:740a:b0:194:59c2:a155 with SMTP id g10-20020a170902740a00b0019459c2a155mr14860996pll.16.1673821068038;
        Sun, 15 Jan 2023 14:17:48 -0800 (PST)
Received: from localhost (99-123-3-233.lightspeed.sntcca.sbcglobal.net. [99.123.3.233])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902ef5200b00187033cac81sm17868955plx.145.2023.01.15.14.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 14:17:47 -0800 (PST)
Date:   Sun, 15 Jan 2023 14:17:46 -0800
From:   Jason Zaman <jason@perfinion.com>
To:     Inseob Kim <inseob@google.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] libselinux: Workaround for heap overhead of
 pcre
Message-ID: <Y8R7iq430fl44eMB@anduin.perfinion.com>
References: <20230112091408.2880781-1-inseob@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112091408.2880781-1-inseob@google.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 12, 2023 at 06:14:09PM +0900, Inseob Kim wrote:
> pcre's behavior is changed so that pcre2_match always allocates heap for
> match_data, rather than stack, regardless of size. The heap isn't freed
> until explicitly calling pcre2_match_data_free. This new behavior may
> result in heap overhead, which may increase the peak memory usage about
> a few megabytes. It's because regex_match is first called for regex_data
> objects, and then regex_data objects are freed at once.
> 
> To workaround it, free match_data as soon as we call regex_match. It's
> fine because libselinux currently doesn't use match_data, but use only
> the return value.
> 
> Signed-off-by: Inseob Kim <inseob@google.com>

Acked-by: Jason Zaman <jason@perfinion.com>

Merged,
Thanks!

> 
> ---
> v2:
>   - add AGGRESSIVE_FREE_AFTER_REGEX_MATCH macro
>   - remove match_data from struct regex_data
> ---
>  libselinux/src/regex.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index 149a7973..4b4b9f08 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -60,11 +60,13 @@ char const *regex_arch_string(void)
>  
>  struct regex_data {
>  	pcre2_code *regex; /* compiled regular expression */
> +#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
>  	/*
>  	 * match data block required for the compiled
>  	 * pattern in pcre2
>  	 */
>  	pcre2_match_data *match_data;
> +#endif
>  	pthread_mutex_t match_mutex;
>  };
>  
> @@ -84,11 +86,13 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
>  		goto err;
>  	}
>  
> +#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
>  	(*regex)->match_data =
>  	    pcre2_match_data_create_from_pattern((*regex)->regex, NULL);
>  	if (!(*regex)->match_data) {
>  		goto err;
>  	}
> +#endif
>  	return 0;
>  
>  err:
> @@ -138,10 +142,12 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
>  		if (rc != 1)
>  			goto err;
>  
> +#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
>  		(*regex)->match_data =
>  		    pcre2_match_data_create_from_pattern((*regex)->regex, NULL);
>  		if (!(*regex)->match_data)
>  			goto err;
> +#endif
>  
>  		*regex_compiled = true;
>  	}
> @@ -203,8 +209,12 @@ void regex_data_free(struct regex_data *regex)
>  	if (regex) {
>  		if (regex->regex)
>  			pcre2_code_free(regex->regex);
> +
> +#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
>  		if (regex->match_data)
>  			pcre2_match_data_free(regex->match_data);
> +#endif
> +
>  		__pthread_mutex_destroy(&regex->match_mutex);
>  		free(regex);
>  	}
> @@ -213,10 +223,30 @@ void regex_data_free(struct regex_data *regex)
>  int regex_match(struct regex_data *regex, char const *subject, int partial)
>  {
>  	int rc;
> +	pcre2_match_data *match_data;
>  	__pthread_mutex_lock(&regex->match_mutex);
> +
> +#ifdef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
> +	match_data = pcre2_match_data_create_from_pattern(
> +	    regex->regex, NULL);
> +	if (match_data == NULL) {
> +		__pthread_mutex_unlock(&regex->match_mutex);
> +		return REGEX_ERROR;
> +	}
> +#else
> +	match_data = regex->match_data;
> +#endif
> +
>  	rc = pcre2_match(
>  	    regex->regex, (PCRE2_SPTR)subject, PCRE2_ZERO_TERMINATED, 0,
> -	    partial ? PCRE2_PARTIAL_SOFT : 0, regex->match_data, NULL);
> +	    partial ? PCRE2_PARTIAL_SOFT : 0, match_data, NULL);
> +
> +#ifdef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
> +	// pcre2_match allocates heap and it won't be freed until
> +	// pcre2_match_data_free, resulting in heap overhead.
> +	pcre2_match_data_free(match_data);
> +#endif
> +
>  	__pthread_mutex_unlock(&regex->match_mutex);
>  	if (rc > 0)
>  		return REGEX_MATCH;
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
