Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F8A183CC3
	for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740321; cv=none; b=apTqdM/10LY5S8KVDG7jfmU8oN9xgd7OPEP23abWPTA4V2cC+KnZ0GnQHWhyXp7aI7FsiBHqRj4UoqFD6vWy8wmgcpREXbCi5rtK4quNR+rBa52HolQZFUIl9OTLFqVy1zDHe0d2JeeK1dpFuyQBkq0BQqVfaMluXxILXieM7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740321; c=relaxed/simple;
	bh=25KUdmLVhv/D5q2FvdZWc7JGZ9OCigCw9GZlEI+NPEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ez1HcU1ng1+bRGavodmlsz1nkR7iTN/XDej6zTV1sB9TAJBcE3AqXhHHWQ8/M4w7eIbqOxpkm+qFtleiOCErcJA+OeAZEyjvnju3qVrAh1PXiQjavJakJbSkoP28CU2n/7/oqHpW0XJ+xZX3CrXP3mHwi5we1GaojvjvnPWwwvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com; spf=none smtp.mailfrom=perfinion.com; dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b=GPv/+rnU; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=perfinion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b="GPv/+rnU"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso2312341eec.0
        for <selinux@vger.kernel.org>; Thu, 29 Jan 2026 18:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20230601.gappssmtp.com; s=20230601; t=1769740317; x=1770345117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1UMRE/PpIsInazozpSjPxoMXoQEJLo5cUk2jWiUd9Y=;
        b=GPv/+rnUbIEFujwQWvuvPmquVU3wFeURfQVC9iEByGLL/uLfjL63zcBuuFMdfWhYVm
         sE3b4ZafTPd3HXok0BSTtl8F+t5pUz1Vt/6IKnCs2HnsT09OV/1vDGj+ZpcCd8kXckmp
         BQ1kCWzOI3G6SWyGVhpmxKzg5mfQuzbOx9zkJRK802wdOYCl8jfdqI3rxeV+w25Syhuj
         ryyI9deok3v/YwdB7UZHrZk+PvMnTvsRIIx50izpDKJbHlM5XeyzyNU7hwC5H6n90DgK
         K2c5GsM3vi+B+c3ol/QKOCeZ2WGAGC711432TrUyHL6A01QQPrrDa0kC/ARkBA71PBJq
         ORJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769740317; x=1770345117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1UMRE/PpIsInazozpSjPxoMXoQEJLo5cUk2jWiUd9Y=;
        b=nG6nbe2wZm0cUOMvVstPnegseUwJE/POGHsEh1sT9usn0P1U1dwpG2vzPQhuYPSsxL
         83x0XUZ6KmDTJgeRv/VVdFLuf4P4sDVxLtrINgXfCvT7oxXJJifn+UfdyNjp0/X1/1Wl
         l/CpzjV6LrnI01Uz/PscS+0+Mf1qddYF4ZYeABKP8NNp/6NDv5vLCDfTGjpl1jjKmLs2
         1RRTu0FwJppxcQkneeDtOKHhzTJQU/ICjrkUXF0EF5Afx1f1NhUDTJKJXNn2Vt/n+7fb
         iUwpj33ns1Slbv4mC6ZYzWUDGkAQzZ+1cEQRmWgKjY3RI+gcd0WJbr+BETiQ//51TpKh
         sUUQ==
X-Gm-Message-State: AOJu0YxqNH0oWOSec5AHdHuCYY/TBlkUsZkBcWHEMwK+H4/Tlwh7Zle1
	oObZ93qCLIDE/34D39Y5piscyk8Cks+trDXvETMNcticaKjeb4OFpmvh32FAsskAIF0MuiIwygw
	l2POY
X-Gm-Gg: AZuq6aJy7vGlgXM1L6MEbimNcIjmU3k/gRjKRQAdn5anXAaZL8wAvVO2NMdNWa2dvDq
	FH+mBiXJbqguzhS6cRv7DmwYAULy6cJzYekH8ZkMZqVsRU0MxMhXAFKA3r+mIUwVX/QNqgL7XqP
	JZwJVom/11jDAogh5siOQxSlYFuAWsJUtdi+PR+nkxwvIZqLr1I5LOsipmeFRFZb9oDC2+eUkFA
	o07tr5t/rPm5fbfun/qSFWeyh27hXbZ/WYB/s8hTEQzOwtdkZeubX3rKQtMhayk1fKLuwupmENk
	ICYKm3F279SzG82aJ066nR5M8m36dTtpf3YAedwmlGVT2ApCjRHJ8Hka5744Xud6IM4n+0nfzJN
	Cr/JzUnazTzMIiKZkchxXhtGYJ2NVS8jNPpOgw8zArRenBzQhKRp7QJP4SGfvEd1sSVvG9ggoIZ
	1XrF1MM2Y0U9lBqq3we62oEQol6YfOmj9h7MLN1OfjFya1quY=
X-Received: by 2002:a05:7301:2f99:b0:2b0:4c6c:9ff4 with SMTP id 5a478bee46e88-2b7c890a91amr843315eec.41.1769740316658;
        Thu, 29 Jan 2026 18:31:56 -0800 (PST)
Received: from localhost (142-254-17-81.fiber.dynamic.sonic.net. [142.254.17.81])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b7a170ca0esm9459447eec.15.2026.01.29.18.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 18:31:56 -0800 (PST)
Date: Thu, 29 Jan 2026 18:31:55 -0800
From: Jason Zaman <jason@perfinion.com>
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH userspace v2] libsepol: add bpf_token_perms polcap
Message-ID: <aXwYG58XDo-L3Pni@anduin.perfinion.com>
References: <20251008233305.2098-1-ericsu@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008233305.2098-1-ericsu@linux.microsoft.com>

On Wed, Oct 08, 2025 at 04:33:04PM -0700, Eric Suen wrote:
> New policy capability 'bpf_token_perms' required by patch to support SELinux
> for BPF token control:
>   https://lore.kernel.org/selinux/20250806180149.1995-1-ericsu@linux.microsoft.com/
> 
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>

Thanks, merged.
As discussed in the recent maintainer call, this will be in the 3.10
release soon.

wkr,
Jason
> ---
> Changes in v2:
> - Rebase to the latest changes
> 
>  libsepol/include/sepol/policydb/polcaps.h | 1 +
>  libsepol/src/polcaps.c                    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
> index 5a3fbdb4..ef529e76 100644
> --- a/libsepol/include/sepol/policydb/polcaps.h
> +++ b/libsepol/include/sepol/policydb/polcaps.h
> @@ -21,6 +21,7 @@ enum {
>  	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
>  	POLICYDB_CAP_FUNCTIONFS_SECLABEL,
>  	POLICYDB_CAP_MEMFD_CLASS,
> +	POLICYDB_CAP_BPF_TOKEN_PERMS,
>  	__POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index 526f35ed..31b52d70 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -20,6 +20,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX + 1] = {
>  	[POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]		= "genfs_seclabel_wildcard",
>  	[POLICYDB_CAP_FUNCTIONFS_SECLABEL]		= "functionfs_seclabel",
>  	[POLICYDB_CAP_MEMFD_CLASS]			= "memfd_class",
> +	[POLICYDB_CAP_BPF_TOKEN_PERMS]                  = "bpf_token_perms",
>  };
>  
>  int sepol_polcap_getnum(const char *name)
> -- 
> 2.50.1
> 
> 
