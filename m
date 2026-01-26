Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB383EBF03
	for <selinux@vger.kernel.org>; Mon, 26 Jan 2026 01:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769392171; cv=none; b=gQkl01bx5GU9zybIkvGOH57+ngDW+EtirbkYmP4Us2fEoW7MygFksGdczdjMbjEaDBU0BCImSPxmEua5BcPIAwXZdAqjiX73nGWvT+gkdMPJV2y/IwBj61ZHYjdjIDlAFNjns0UnDSJb54USJ7+N/RkJsAnIBhCftSoeud6AxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769392171; c=relaxed/simple;
	bh=rSF5gYw/TiecLFUcynthNqxTrJBmcwJU8i+Fz4+FIUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMAmPeQRevuR3OanvHCsmXQ7dSUw2kQt8i+mg7+M3EFCCQofiJlaB0yGC9UuVmKEdqBvQz4qdYHICHriLbxT7yi98z+S65+7OE9+tAcWpIPq/iUI/dVz7h9ocD5GlyYiizOmInaESki3OPkBPCto8q+ZIjjH+sKabX+paeUfmbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com; spf=none smtp.mailfrom=perfinion.com; dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b=zNKC36Ju; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=perfinion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b="zNKC36Ju"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12331482b8fso1158112c88.1
        for <selinux@vger.kernel.org>; Sun, 25 Jan 2026 17:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20230601.gappssmtp.com; s=20230601; t=1769392168; x=1769996968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vnvEguBEuFOTZ2VKZEH00trXbs62OSv0jkGYUNy0fJg=;
        b=zNKC36JuE9RHmtwbt/NVm/Z18CBOzpsbqkyt7r3QFZbJlh+U1Erl/w5TBnVo5/qxR4
         s7Dyp6pjXYFzfgcU2l950QhJrUn6Z0vJCRCvd4vuBfDRk8kFAjTzn2ydsNujKhvwGWKQ
         gHs1J3e5hCow7Lmo/+y/GHw5gFYm7KWMm8Wix+LWSOxZbzBhjYMZ6x3/e5e7BgMyDhKr
         tqZ3g7yO+34hgqJjr5ClHzC7+lIfK1aKhFFfu9h4IwWLxscu1eyy/FjoMHh6WLjlj6HW
         bhB2D1Fu37epN2TfgMyLeiBoNJzP1qK8oOdKrUmxtmvoGby4RTLoiXlizow6RwWxJU5m
         V0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769392168; x=1769996968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnvEguBEuFOTZ2VKZEH00trXbs62OSv0jkGYUNy0fJg=;
        b=KxkZGq8APRODgOHQV0alEltU8588T04bBysi7zlui9Ym3h94IATNppRVowWHuAugug
         PBlLoYCgecv9TEI72VYPhcGB2FR+Td9uyhpTZUjJWjcuAfZVimlZF76S+MdZpOBdL6q5
         HMVNG1sfegUOUaFKeZDETLIzHiqrpR5E5R+K8DwDZLGXJ61yKjRz3/QY2npAVosont6y
         5D6HufziNnhLvXgFIbut1Vc2UTstn9fD11YQaXbfyeAZAaQlLwpga7k6359nCQvaE7tT
         c0f39IbwacymxchhXg71BdRY/BcfTuRayMsCBsdpNd5PdFcktmPuW81esD75o5tH8keZ
         ByOw==
X-Gm-Message-State: AOJu0Yy3TpKSgX/OwxZWVX+mK+HTcBfEegALmW66GSEuUs6FZHmnkzBT
	dYfzALhh9nheOg2fRTm5EMNnWYAyWuE5QmqmV0lPEwZfkXiwgL6G+6uM8t62tg0VA8U=
X-Gm-Gg: AZuq6aL3zEJWubc4CXnSmCNeZXuF0FzERwHpU5l9cFAQeq9kan5ksbB6kmfPry/UFGw
	r+eUWwHsPj4bBTUGGsgVDBzltKoks23faYZhHcZUlWJ/IPuYCKQehFgvc7k14jnLJTdZK5qPcrJ
	75CLm+ryN6laL0S1VvSzzYA5X+neV23C5CymMVK4+0lG2P91Mb+1yJim9AA7xHqgQ4qSkB/3Lv0
	icPoHM/LEb1EuLI2SDvA4Bmn+EhBE+8hhRBpXVWuHqjad3364K27d9CAwshmXJ5inK1z9jjWIoQ
	OtgG6gHtGJYzIQ/lwwnOiTWp8RYC33n7YWFzRqWbJyKZcVCK5Pa6ppPOWsTTLBZUZbdXzl6m0a+
	1a8XFE5dv3B7app8MTpfb/gJWADen4oZtoOFWN884OlHj9L3rQr75hjq0LBYOqxCM/OkGumUUL2
	YgmW4zTr0OBszspjSqzwjc6LbtR2oSAjbvPl59Q5Iga6VCFuY=
X-Received: by 2002:a05:7022:6183:b0:123:3356:7abb with SMTP id a92af1059eb24-1248ec87252mr1779874c88.46.1769392167834;
        Sun, 25 Jan 2026 17:49:27 -0800 (PST)
Received: from localhost (142-254-17-81.fiber.dynamic.sonic.net. [142.254.17.81])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b73a9e1c52sm11365822eec.16.2026.01.25.17.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 17:49:27 -0800 (PST)
Date: Sun, 25 Jan 2026 17:49:26 -0800
From: Jason Zaman <jason@perfinion.com>
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] libsepol: Fix potential NULL dereference in
 policydb_read()
Message-ID: <aXbIJiufoRlLvd2t@anduin.perfinion.com>
References: <20260122164545.77705-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122164545.77705-1-jwcart2@gmail.com>

On Thu, Jan 22, 2026 at 11:45:45AM -0500, James Carter wrote:
> Since there can be gaps in the type_val_to_struct array for very
> old policies (version < POLICYDB_VERSION_BOUNDARY), need to
> that it is not NULL for a particular index before using.
> 
> Reported-by: oss-fuzz (issue 474424148)
> Signed-off-by: James Carter <jwcart2@gmail.com>
Signed-off-by: Jason Zaman <jason@perfinion.com>

Thanks, applied.
> ---
>  libsepol/src/policydb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 6aaa18f2..9760b164 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -4513,7 +4513,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
>  					if (j >= p->p_types.nprim)
>  						goto bad;
>  
> -					if (p->type_val_to_struct[i]->flavor == TYPE_ATTRIB) {
> +					if (p->type_val_to_struct[i] && p->type_val_to_struct[i]->flavor == TYPE_ATTRIB) {
>  						ERR(fp->handle, "Invalid to have type attributes associated with an attribute for a kernel policy");
>  						goto bad;
>  					}
> -- 
> 2.52.0
> 
> 
