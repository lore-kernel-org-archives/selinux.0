Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6920C15A
	for <selinux@vger.kernel.org>; Sat, 17 Feb 2024 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708206858; cv=none; b=At1gBDR6o3vM0MDCo6K5D7k1nWcQfKB16UUDiDs9gUNE9YkxzjHlXw8glNapg6OpJcrQX73rUSOmlwe4XGo3l5O2oTRTBCeKzURwIQ2hrnju683t26v6o7iy0J904BUejDtbJTFP0J1yNiyxbfuVXCp7UR0tuEChtpPBrArQiUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708206858; c=relaxed/simple;
	bh=LvY6sFnud2tZEE18QYCzhImv6tCwMl+8OqBiVSATXZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMCfw3y9y8LwlLfkbx+HlOnnFjS6PiDJhowqQMSdHIY4sx1/vynP6E6tXxRYmHGVk1xXbf4XJK7qgdC87Ex1u/6tnG6T9NagH6P3wu1fLQsuKDFMdcKj4jFmsz33ftrMLqGJKMTkQPLJnFKUsz5Fnj7j48B2MKD3GQVgfjr7Waw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CETC88xG; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CETC88xG"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c03d475b63so2290525b6e.2
        for <selinux@vger.kernel.org>; Sat, 17 Feb 2024 13:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708206856; x=1708811656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3J6Z5hMs5weo/eIcZZ6dBUYJ2MWLXTuJvka1k2oHI2U=;
        b=CETC88xGUG4dpuuz6epxdYFi1xpdJrKqMLDa8X725u5F3uENildZ3NosmLxk7RPH6j
         ru7wIXgmFlErBeLkIyDxxKDG0+5xdf+qjaExfGDvS8ZPteng2SQzavLXK63cyzlUI21a
         EIIisF371pLFVsFNzl+7TFjhi6I3vDue3xDLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708206856; x=1708811656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J6Z5hMs5weo/eIcZZ6dBUYJ2MWLXTuJvka1k2oHI2U=;
        b=pN/ktysWHHyZfQWL8VHG9ZmJ5h0OuTLhv6/thMrEh4xR5eq4pEJCWt32ztzOURnDnX
         fpb6rK5YTB1TJJLBXv3cHftc+DRW8FBAnQZr3BX8DaJi6eN0p7VeKFDLdFoZoXPpc8Cs
         nS70yvCiZWOrzGb++9kKzVq2DWhV97x0/hFPjAg2brmguvCM+Cr6WReimrx/R2SWA6s7
         FXQuHpIIOviz1abh8/xtZvHc5B/KS3AacVAndCdTupCiC30fXVMxqG3g/BY1qCd3qrFN
         Vh/2zKVKI3YDTET34LkUKTGrIZezjnNxKrO01eyVxesUGJECnF69j3uUFkihYP0e9nvW
         1RYQ==
X-Gm-Message-State: AOJu0YzL599DYaoPtHuGYI7sJjhD8Amevwo7rjzgqFlm7VgV3gbOj75t
	rdeBvqKeXiV7mQOuKWCiE+LTM639tswQgns6E4IOrQqIlS+gRXc8GFVHMycHz1/rraZI7ZXmQ/M
	=
X-Google-Smtp-Source: AGHT+IEj3vEls3sa7LRITM9uGfk1YUsiRFGiUjSLrMv44Gjlp3p385Z7T917YypoVW0M0aEX7PnDfw==
X-Received: by 2002:a05:6808:109:b0:3bf:e036:f0e7 with SMTP id b9-20020a056808010900b003bfe036f0e7mr8415654oie.56.1708206855863;
        Sat, 17 Feb 2024 13:54:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id pl6-20020a17090b268600b00297138f0496sm2288903pjb.31.2024.02.17.13.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:54:15 -0800 (PST)
Date: Sat, 17 Feb 2024 13:54:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Steve Langasek <steve.langasek@canonical.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] Always build for LFS mode on 32-bit archs.
Message-ID: <202402171351.439742DA@keescook>
References: <20240216003252.29057-1-steve.langasek@canonical.com>
 <Zc6tzKPsYZRICHya@homer.dodds.net>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc6tzKPsYZRICHya@homer.dodds.net>

On Thu, Feb 15, 2024 at 04:35:24PM -0800, Steve Langasek wrote:
> index a0948853..78953870 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -1,6 +1,7 @@
>  #ifndef _SELINUX_H_
>  #define _SELINUX_H_
>  
> +#include <stdint.h>
>  #include <sys/types.h>
>  #include <stdarg.h>
>  
> @@ -521,7 +522,11 @@ extern int matchpathcon_index(const char *path,
>     with the same inode (e.g. due to multiple hard links).  If so, then
>     use the latter of the two specifications based on their order in the 
>     file contexts configuration.  Return the used specification index. */
> -extern int matchpathcon_filespec_add(ino_t ino, int specind, const char *file);
> +typedef uint64_t libselinux_ino_t;
> +#if _FILE_OFFSET_BITS == 64 && __BITS_PER_LONG < 64
> +#define matchpathcon_filespec_add matchpathcon_filespec_add64
> +#endif
> +extern int matchpathcon_filespec_add(libselinux_ino_t ino, int specind, const char *file);

What's the ABI goal here? I think the type is wrong -- doesn't this need
to be uint32_t not a uint64_t for the wrapper?

-- 
Kees Cook
