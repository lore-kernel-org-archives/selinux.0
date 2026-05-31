Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EE5362156
	for <selinux@vger.kernel.org>; Sun, 31 May 2026 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780244295; cv=none; b=uqWVKc6Zjk6RtQFi1sS9UMg7mF0Y93u2aVN3YDojZLs4aofU73SxgGcAwCdmFgvZ6Zz0srCTmcZOeDOC5mFhulH3Ktsxo/YwcgySPSnPCAAM51OLlfIgLEUkqHQ/9ZpX4Z07Vww9ZLLXPdNrYD5tmp/pqW2PN0gDcpQMrBoBBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780244295; c=relaxed/simple;
	bh=a8uDziLcsJjjIOde62aXT5Ua5oTmQdmUkktgNMjdJHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uu3Qlq74G3rd5yQdDiAqCIyDXPxchRBL591p0/09eL7PQqRkQlkabFLZIjHkp8khdGxdaRdNlNiwEhB95Uc57tdAlHJFYdvCjz3XBgkUJq6yJdu4fg6LFBd9KUcDNlrqwr8eOi9aMAe3pXnQicIuQKk58zFpLGNb5WiMubEqWFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkzUguTb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkzUguTb"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490a765e68eso4732895e9.1
        for <selinux@vger.kernel.org>; Sun, 31 May 2026 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780244293; x=1780849093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9EIWP7WI7ejnc3HkMg6P5AQBc99pV+sSSiz5HA+rPo=;
        b=LkzUguTbAny6lKWtJHpG3VdoJd6b2hk1iO36FcUeUkxP6/h7ZHyWYAqGt6TVTxe49N
         0A+2Iyyr2ju3/wRSZSKUP/a2/aO+gbQ8x3cX+qPjtZxHoG3QAoQQF0wCBGfAw17koyfl
         fcICCJKwUQF0P2CRuvhM11lb6ffr6Y8P+slGZxavbIH1m4Ae+rfjoDGRh3SWvdAAQJ0V
         QyeZdyZI0+0JpZ4vLSiotnk2LEzY8tNPGhzRxQw/wzl+6teACsmHJ7ddc2YxaJs7zOlu
         FxMTBhAunB0LZXFqwfdFZ0KhSAuDQx4djolu5n9A12F/KyZun85UB5K0E9PMhcMULde5
         nE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780244293; x=1780849093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P9EIWP7WI7ejnc3HkMg6P5AQBc99pV+sSSiz5HA+rPo=;
        b=ed6+QoP5go7Peb4VXP2QeRuY/04mQRXtXgs4uahnDpMSl0wJ+4XvQlLLDWGFPRc3mg
         wPR/7i3+qn/7wgRhF+jkx9djPCH/aQbcjN5yaNcRQ0qN11p9ugzf+zu/KZBaghhgyI8K
         HcAUXgMlMZfc/COxLF4AySxcvgcK86OG99xkmSFnfLIgRHquu1+/12OzQpavbBFs0fE8
         XvCXlsw7rcLXCXyuBcJb8ffa/QEsF5i2bw1/r+jWNNmM+zq0g4DzqSDu3L4HbmXKN3mJ
         yWAFJFEqglhWesVbsngM5F04eXulTZcr9aAQ5pa8FaeocHpavAwdbpW6R9kXZsI0w8UD
         9zjw==
X-Forwarded-Encrypted: i=1; AFNElJ8Srju8b67+IMD9Eh4uoJ9x3NLIdwMlmDIYErg9bSEPXjPnwlU1f090U5J9a5G2E/f3o4frWe4Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yzenq5K1SrCWXSjDK4XQgtNAKQlUwx8o+vsp+mGsfkvMW/zJVyZ
	QfTvdbQ/bqgMFfHIssBspt22uIV61LHD3kqTMR1aU1iurATKtQO0ZArV
X-Gm-Gg: Acq92OGJCv8PTKqkFRxS044s6pCMs/B5VIhjxcgH9yeoWnXZYHOCBjpBwWekYEDadgx
	d77+zT4ZeK6SHCKU5OX87wet8c+PxUlIbPtWmtSRRVAnQkU+UL0viEUEUYnrXyd0kAxpV1b+H+y
	qSCC/1nHCaMmZWtoYiBW+LZRZff3n1YOxSzXmiAu0RYbejqm2oDBoULUt9E5dGEwxiCFqkyPa2W
	o7LMnzQZ/MdgXyvWhyfHgZ5yrxHe42KbrAuACTC5UVkhl/WVJQo8Z8SUBF1iH42vE0IYvnjaRtn
	+/sPLvIO1yovER/HgD8VVyhTqZtfGR0jEyD7M7bg1dQseazwuVH3W8xTg+9hPMZ6JHT9RgKJm+I
	X7YX6IhkY2U/JefSsj02aGWTRmD/oqj3C2pP93URlLoybP2sLfZv7vXoeuLNXg7QCeG4sP6R7va
	D5+9AR1CasV77/Z6O9Sw4/5tawwbnE+jqFyZfihE+kS621Ttc6FMZT1NRb3RhNl02jf5mxGEk=
X-Received: by 2002:a05:600d:8497:10b0:490:6869:9601 with SMTP id 5b1f17b1804b1-490a292a48fmr95653825e9.6.1780244292718;
        Sun, 31 May 2026 09:18:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909ca6e124sm191663255e9.7.2026.05.31.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 09:18:12 -0700 (PDT)
Date: Sun, 31 May 2026 17:18:11 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>, selinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selinux: hooks: use kmalloc() to allocate path
 buffer
Message-ID: <20260531171811.16abb087@pumpkin>
In-Reply-To: <20260531151502.1467515-1-rppt@kernel.org>
References: <20260531151502.1467515-1-rppt@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 May 2026 18:15:02 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> selinux_genfs_get_sid() allocates memory for a path with __get_free_page().
> 
> Such usage does not require a "page" and the size of the buffer should
> actually be PATH_MAX which may be less than PAGE_SIZE on some
> architectures.
> 
> Replace __get_free_page() for allocation of a path buffer with kmalloc()
> and make it explicit that the buffer size is PATH_MAX.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> v2 changes:
> * explicitly use kmalloc() with PATH_MAX
> 
>  security/selinux/hooks.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0f704380a8c8..19493198ece1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1336,11 +1336,11 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
>  	struct super_block *sb = dentry->d_sb;
>  	char *buffer, *path;
>  
> -	buffer = (char *)__get_free_page(GFP_KERNEL);
> +	buffer = kmalloc(GFP_KERNEL, PATH_MAX);

At least get the args in the right order.

>  	if (!buffer)
>  		return -ENOMEM;
>  
> -	path = dentry_path_raw(dentry, buffer, PAGE_SIZE);
> +	path = dentry_path_raw(dentry, buffer, PATH_MAX);
>  	if (IS_ERR(path))
>  		rc = PTR_ERR(path);
>  	else {
> @@ -1361,7 +1361,7 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
>  			rc = 0;
>  		}
>  	}
> -	free_page((unsigned long)buffer);
> +	kfree(buffer);
>  	return rc;
>  }
>  

