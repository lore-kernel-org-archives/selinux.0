Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631E3EBF03
	for <selinux@vger.kernel.org>; Mon, 26 Jan 2026 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769392125; cv=none; b=A5FO9XhVrjstXIFMNFJMMUalEOAF9EBKIXpOcs14ajtKQSklt/0pBfsAUYZiRojrQEP3c2Ff6kjvzeMGfL0SUQUeCBmdGX+i4qwR+YgR6K7kvv8QFIC7xEVCBQRkvd4n6c+oCO8/JBnkQIIhXphOKwtLKtkXIMc9KQDM1XVjAho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769392125; c=relaxed/simple;
	bh=7YKiBqXuc+UqIAhrC2u3+gg/sE/GoxHqqLhHl2FCkuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYni946zkxij0OKXxkbRJVonffdOT2YKU+Cwnr9NYg9df5L59fsq2uZGDXi4P1jEKoDrvnGCQxZxWQBjU5LZUfhBD97VuPVsLfKl7SvLuGDA6S8bGY3XCEWYyi17/YbkjqoaNRag1RxmsQVBtaED4Dy9uq6hxb/BfitfCm1hM/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com; spf=none smtp.mailfrom=perfinion.com; dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b=pnMIhNfF; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=perfinion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b="pnMIhNfF"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b6b0500e06so4999529eec.1
        for <selinux@vger.kernel.org>; Sun, 25 Jan 2026 17:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20230601.gappssmtp.com; s=20230601; t=1769392122; x=1769996922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tlELvn/OJnmUU2Vt6FgO+LPwIatcvDbi+s4Yf0T34oo=;
        b=pnMIhNfFQANIlrjdj2Sgmv70fdYFhYu0NAFZA2fF9dvI7TPLLUhh2qnGJYL6vJI8Qt
         sAqXbn7GBlAKyDS6IUoAfyjog2LriVweO/LWmigMWcph9zhbZBVBdASIjq4X96f8L7v6
         i3nkjENzXMTJX1wTjaarah88FfBm5H1ZdphCAdtH3KVCy59Bca/Hx3ERi/VTm86o1DhA
         zpAL4Hg8NhpjLjETPPvNgijqUm+cC2wz4Wml+coeetzIFn/15xjbICvK4TVs7Ch4wLkU
         zbESgT1HA6QM1oq2leRlo4sCRG5UnjKnF44Xc+xivSYNXKQkBuqJdgX3Tj385F17G6mO
         e18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769392122; x=1769996922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlELvn/OJnmUU2Vt6FgO+LPwIatcvDbi+s4Yf0T34oo=;
        b=kRDBA802t2IPr+evLZzRjW3VX8Okal7pmMNm4TMHnve6x2gxoJBrxK5LruPf7dUTW2
         qFDjhGL8TQfeff2/d9trqWA2K5sYDhge6uFSqdWTV8Pzrj8unGq8dmB45ztKhzczK8+/
         FcPHhCoqZ2/pz8L8vJP+a43vbmusRRbAMzTN2pXASKgbi00S9EE5TYYKmrIju8EqCCrD
         FpkypeyrhfTz7KKd9XehS0z5VIbwfll6i70gW/wOeYiBhRVa4LgWiuw+dtL/dmJtgy8d
         T0FoxzpzxLV7j/W2RNRWuM5N3DoMsAlTzaWLAKeW/EGw2bWt2KQc8M5tzNwv4K7xvvlv
         8YOA==
X-Gm-Message-State: AOJu0Ywa4kjf9rjjqRUlJZUI7ADOKW7QIU+/oprmKy0jmCMXrxjhGZcx
	mzfooUT8Y7eFNZDksQCOLx4EDgllD6sl2oyXdTBRFZmYz2GDplctxJ7tdxWLU22vX00=
X-Gm-Gg: AZuq6aLcYtE5Cg9seXG/zmIJqwpwan5GxXSpEn40sJnSftGbR9DiBIFpybMWd4fThza
	roWLOcQ8PbCIk/B5FlUfQztbneYTPvl69I95583pFpTTfobmvX04jjWuhAR5+WrY+oDWGhhY1XO
	/Q7Xq4v/82wvkYtt8ZCAJ+PbDScYObynU0uZ10RAld7NSoWZZVCch/M+FZkCWZ/3nTWnfF1zJrH
	8Ke7I7c50scNh2A/77gEsUjv14k7ANvWYhuwaPlmxWCnAuXYow5Iku3b+nT4h4oOWsFHCm6CKK6
	vr8Giyf5qAEbsFM4Holtux+6KGjxS2c+73V+kkE8oNtlGqMyLUiIHtzV2ifk0IIbS1Kq1lx0wKT
	uCcBPdDLi/7SmcrsF6U4AfWI4Zsh6tfaO+rR3OguGtnYA35xyCgol2ziob4PhAxkRM/DDEGzQDU
	6OZdIM1nsqa8Ak4trkcfqQlDPQ0Rvjm9GdVnWfkYGxmGy8t08=
X-Received: by 2002:a05:7300:e607:b0:2ae:598e:abe5 with SMTP id 5a478bee46e88-2b76451af70mr1242343eec.35.1769392121513;
        Sun, 25 Jan 2026 17:48:41 -0800 (PST)
Received: from localhost (142-254-17-81.fiber.dynamic.sonic.net. [142.254.17.81])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b73aa2b656sm11862311eec.33.2026.01.25.17.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 17:48:41 -0800 (PST)
Date: Sun, 25 Jan 2026 17:48:40 -0800
From: Jason Zaman <jason@perfinion.com>
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH 1/3] libsepol: Tighten checks on MLS range and level when
 validating
Message-ID: <aXbH-OK7zi1rNUPx@anduin.perfinion.com>
References: <20260122160602.65567-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122160602.65567-1-jwcart2@gmail.com>

On Thu, Jan 22, 2026 at 11:06:00AM -0500, James Carter wrote:
> Because of various corner cases, the checks for MLS semantic
> levels and ranges and the checks for MLS levels and ranges do not
> give an error when the value for the sensitivity is 0 (which occurs
> because it has not been set).
> 
> The corner cases only apply to users and, even then, not to all
> policy types, so user's MLS portions are not being checked as
> strictly as possible. Range transitions are also not getting checked
> as strictly as they could be either.
> 
> For user datums:
> - Only check the MLS portions for MLS policies.
> - Do not allow unset sensitivities in semantic levels and ranges for
> a modular policy.
> - Do not allow unset sensitivities in levels and ranges for a
> kernel policy.
> 
> For range transitions:
> - Never allow unset sensitivities.
> 
> Reported-by: oss-fuzz (issues 471456886 and 471525113)
> Signed-off-by: James Carter <jwcart2@gmail.com>

Signed-off-by: Jason Zaman <jason@perfinion.com>

Thanks,
Applied this whole series


> ---
>  libsepol/src/policydb_validate.c | 50 +++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
> index 5afbfa49..9ee71bf2 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -661,9 +661,9 @@ bad:
>  	return -1;
>  }
>  
> -static int validate_mls_semantic_level(const mls_semantic_level_t *level, const validate_t *sens, const validate_t *cats)
> +static int validate_mls_semantic_level(const mls_semantic_level_t *level, const validate_t *sens, const validate_t *cats, int allow_unset)
>  {
> -	if (level->sens == 0)
> +	if (allow_unset && level->sens == 0)
>  		return 0;
>  	if (validate_value(level->sens, sens))
>  		goto bad;
> @@ -676,11 +676,11 @@ bad:
>  	return -1;
>  }
>  
> -static int validate_mls_semantic_range(const mls_semantic_range_t *range, const validate_t *sens, const validate_t *cats)
> +static int validate_mls_semantic_range(const mls_semantic_range_t *range, const validate_t *sens, const validate_t *cats, int allow_unset)
>  {
> -	if (validate_mls_semantic_level(&range->level[0], sens, cats))
> +	if (validate_mls_semantic_level(&range->level[0], sens, cats, allow_unset))
>  		goto bad;
> -	if (validate_mls_semantic_level(&range->level[1], sens, cats))
> +	if (validate_mls_semantic_level(&range->level[1], sens, cats, allow_unset))
>  		goto bad;
>  
>  	return 0;
> @@ -689,9 +689,9 @@ bad:
>  	return -1;
>  }
>  
> -static int validate_mls_level(const mls_level_t *level, const validate_t *sens, const validate_t *cats)
> +static int validate_mls_level(const mls_level_t *level, const validate_t *sens, const validate_t *cats, int allow_unset)
>  {
> -	if (level->sens == 0)
> +	if (allow_unset && level->sens == 0)
>  		return 0;
>  	if (validate_value(level->sens, sens))
>  		goto bad;
> @@ -712,7 +712,7 @@ static int validate_level_datum(sepol_handle_t *handle, const level_datum_t *lev
>  	if (level->level->sens == 0)
>  		goto bad;
>  
> -	if (validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
> +	if (validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavors[SYM_CATS], 0))
>  		goto bad;
>  
>  	if (level->isalias) {
> @@ -740,11 +740,11 @@ static int validate_level_datum_wrapper(__attribute__ ((unused)) hashtab_key_t k
>  	return validate_level_datum(margs->handle, d, margs->flavors, margs->policy);
>  }
>  
> -static int validate_mls_range(const mls_range_t *range, const validate_t *sens, const validate_t *cats)
> +static int validate_mls_range(const mls_range_t *range, const validate_t *sens, const validate_t *cats, int allow_unset)
>  {
> -	if (validate_mls_level(&range->level[0], sens, cats))
> +	if (validate_mls_level(&range->level[0], sens, cats, allow_unset))
>  		goto bad;
> -	if (validate_mls_level(&range->level[1], sens, cats))
> +	if (validate_mls_level(&range->level[1], sens, cats, allow_unset))
>  		goto bad;
>  
>  	return 0;
> @@ -759,14 +759,19 @@ static int validate_user_datum(sepol_handle_t *handle, const user_datum_t *user,
>  		goto bad;
>  	if (validate_role_set(&user->roles, &flavors[SYM_ROLES]))
>  		goto bad;
> -	if (validate_mls_semantic_range(&user->range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
> -		goto bad;
> -	if (validate_mls_semantic_level(&user->dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
> -		goto bad;
> -	if (p->mls && p->policy_type != POLICY_MOD && validate_mls_range(&user->exp_range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
> -		goto bad;
> -	if (p->mls && p->policy_type != POLICY_MOD && validate_mls_level(&user->exp_dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
> -		goto bad;
> +	if (p->mls) {
> +		int allow_unset = (p->policy_type != POLICY_MOD);
> +		if (validate_mls_semantic_range(&user->range, &flavors[SYM_LEVELS], &flavors[SYM_CATS], allow_unset))
> +			goto bad;
> +		if (validate_mls_semantic_level(&user->dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS], allow_unset))
> +			goto bad;
> +
> +		allow_unset = (p->policy_type != POLICY_KERN);
> +		if (validate_mls_range(&user->exp_range, &flavors[SYM_LEVELS], &flavors[SYM_CATS], allow_unset))
> +			goto bad;
> +		if (validate_mls_level(&user->exp_dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS], allow_unset))
> +			goto bad;
> +	}
>  	if (user->bounds && validate_value(user->bounds, &flavors[SYM_USERS]))
>  		goto bad;
>  
> @@ -1323,7 +1328,7 @@ static int validate_context(const context_struct_t *con, validate_t flavors[], i
>  		return -1;
>  	if (validate_value(con->type, &flavors[SYM_TYPES]))
>  		return -1;
> -	if (mls && validate_mls_range(&con->range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
> +	if (mls && validate_mls_range(&con->range, &flavors[SYM_LEVELS], &flavors[SYM_CATS], 0))
>  		return -1;
>  
>  	return 0;
> @@ -1484,7 +1489,7 @@ static int validate_range_trans_rules(sepol_handle_t *handle, const range_trans_
>  			goto bad;
>  		if (validate_ebitmap(&range_trans->tclasses, &flavors[SYM_CLASSES]))
>  			goto bad;
> -		if (validate_mls_semantic_range(&range_trans->trange, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
> +		if (validate_mls_semantic_range(&range_trans->trange, &flavors[SYM_LEVELS], &flavors[SYM_CATS], 0))
>  			goto bad;
>  	}
>  
> @@ -1663,8 +1668,7 @@ static int validate_range_transition(hashtab_key_t key, hashtab_datum_t data, vo
>  		goto bad;
>  	if (validate_value(rt->target_class, &flavors[SYM_CLASSES]))
>  		goto bad;
> -
> -	if (validate_mls_range(r, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
> +	if (validate_mls_range(r, &flavors[SYM_LEVELS], &flavors[SYM_CATS], 0))
>  		goto bad;
>  
>  	return 0;
> -- 
> 2.52.0
> 
> 
