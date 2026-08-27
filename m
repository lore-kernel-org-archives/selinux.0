Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7046B427FB9
	for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859555; cv=none; b=C4Q0bpbduP6s+iG9t9CGgWVN3TgDs10URqT3+MmopRQol8xyyxXZ1DB3X554Erlg0Rl+cFexgZuQZFY3E4Ef1LJ8CD59vK8Iet4sXEr+o3b3ECT4BWeLMpy9JKv/n2De8XnLE+usCpIbLat0jr5olQ4Kvi31pRgcXzrSbz5qjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859555; c=relaxed/simple;
	bh=iPf7ChaqIsVoGcvfLFkYqgjfgPL7ty9oLZe40l5pQ94=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=kq47uOcuar0HY1l1xbH4eT7huPSfCbOFM16T8BgSrLxDe7SF9+i+pYBUh+BWrL+Gz6xkDYyD1XS7me0Ab+k//HKIkQ5fpkA5WPIWVa3cXv8H7bOXH/YEbeDC3kGmJz7zZFzjTqTcrt3pNXYoBfDb/3t7NA9oAoT7ggo/a4QlIEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HpOZ5ZZW; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HpOZ5ZZW"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90cc64f7f86so924606d6.2
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787859552; x=1788464352; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mtXig1FMjrSYmMbsrTikOQfn2mLp1bwY+1B2vUa6dN4=;
        b=HpOZ5ZZW8h78vYnfkwrPzKV8DX0KqSCR//l4g862xZTEXiKVVxyIcR2zzsem301V5o
         P/4fPlMtdSMoYxb3tqRXMVZnPeaLd4uWE713kzq1d3jwoxdnDwKE5FuOY3gZXTJblRak
         QQkjj5JncGdZ3w3Dq4iveA73hPubX69bFD3/I2G82ECysx4QaH/2KgUtdEPDvEFenTUZ
         jYRhuLyJ4KzX9ZoAcjQsDbqtuBA+6TRMr+uxDibVsiMXe118kJGre5+Ic8Hx+0fusc5z
         T/YZ+lgB4Ojagsb3774ECWnXt5iNCShHu3rzfaJJAIEAqIXHvT20aofkChCffRUTrvk/
         fmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787859552; x=1788464352;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mtXig1FMjrSYmMbsrTikOQfn2mLp1bwY+1B2vUa6dN4=;
        b=XG3OyrUU+xOmae+NZ3z5yfH4s/cGnyoiuxeFTJV8W6yDf947UMrbo08bsnoyWb+t71
         zGdkASqUSb5yisACU21WPpxuhSsEWdqWeJCbiK1s4/SpTX8xmXSmwCrhaiKd3eqvLrrs
         LwHEeM40KfAfEAa09brZOtV9Y3p2WYyYn+uQLb17zCSkxb2Cjll2NXnv9Jwmn9VsQ9QC
         GP44alpH6uuqcczTa7ao64TqHwTMDEULw/xfk+FKXUQZMLWiT303OTATSibOQreMQ+Zw
         vKJsuf2QZ33ytY7k4JQ2/KQBNYzJTO7WkhhP37buTICvmCs9jNLY6LfKggII7t2Y/oAj
         M8oQ==
X-Forwarded-Encrypted: i=1; AHgh+Rql+PDRRSOvZ0s03DoS7cZpXoWVvv6MXvMsIc0qWTHbPdDF24N1GjYqmzyoRAIVKaGqYfR58VB9@vger.kernel.org
X-Gm-Message-State: AFuF++knsDOnoLGNRgpki4GKPyRsIApS4pzg2Tcz3wD8FPdt15WJwqZw
	qMxiLLxoK9xRlV5T2YRh2x7b51REmjHYP3m7UpHIUs/oLRyWTI2AgmY0+KGboBXgXw==
X-Gm-Gg: AR+sD13EX6AbSqH5x6d509KCyA2sZu4RitSDZTA5Xp1lwX3M54/jGjDsMSZOz1w8aSh
	OwonDi/1k0sPZj0dornX11qyScObmVQM3LwP5td4OmI9ljmBAUah60xsUmWA/SuYVQomkjBZVAN
	+dfn399ae8HIlSW/Qzuqadh3saiHsAjndgF6L7cyDsJLTnSqSBUKJrlL4nD1YK44d5/VKqmWSxF
	w9HXgjLE3pFXU1I01h7rnQv45XAhyvEpXlIopN067iXYc3nMYBNPtjzT/fWKu71qSOhH6tdJZ+X
	vxkx6iGDkdpJBjzdfoOW0Xft1xOOjJqQKYaZvT2A508mo/n3agJVtycKy+H/7qZvihkc0jsH25p
	+2oOZPuJEqLVoTrgto2iQCPtSIRxEnQB5ZWOCoJoxQjZSjb0GU3zczrdbjpupVacFH8J3ilUCCP
	QmvdfdU5iHA4Df5tDOuc6EaPHXS+0KdVd7M51z0dnMynNxVeTiLCcnAlOIx3u5RhfZkjp/rv/98
	ELL6ceFuXAW8UrrfexKotAkb6Y2zzz1sZa6ifyCRF8c
X-Received: by 2002:a05:6214:e43:b0:908:9fd5:ed42 with SMTP id 6a1803df08f44-90ce0f06bdbmr20681366d6.28.1787859551742;
        Thu, 27 Aug 2026 12:39:11 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cd73fc28dsm24026946d6.34.2026.08.27.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 12:39:10 -0700 (PDT)
Date: Thu, 27 Aug 2026 15:39:10 -0400
Message-ID: <5fa5ef078f41cd57d0e52ab2ab023094@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260827_1122/pstg-lib:20260827_1501/pstg-pwork:20260827_1122
From: Paul Moore <paul@paul-moore.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, selinux@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] selinux: preserve user SID across nested backing files
References: <20260820175832.44512-1-kmehltretter@gmail.com>
In-Reply-To: <20260820175832.44512-1-kmehltretter@gmail.com>

On Aug 20, 2026 Karl Mehltretter <kmehltretter@gmail.com> wrote:
> 
> SELinux saves the user file SID in a backing-file security blob so it
> remains available after mmap() replaces vma->vm_file with a backing file.
> 
> For nested backing files (overlayfs over overlayfs, or FUSE passthrough
> backed by overlayfs), user_file may itself be a backing file.  Its
> fsec->sid is the SID of the mounter that opened it, rather than the user
> that opened the top-level file.  mprotect() then checks fd { use } against
> the mounter SID.  This can incorrectly deny access without a domain
> transition, or check the wrong target SID after one.
> 
> Copy the saved user SID when user_file is a backing file.  Keep using the
> regular file SID for the first backing layer.
> 
> With two nested overlayfs mounts and SELinux enforcing,
> mprotect(PROT_READ) returns EACCES with an fd { use } denial against the
> mounter SID.  With this change, mprotect() succeeds.
> 
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access checks")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
> Changes in v2:
> - Add selinux_file_user_sid() helper instead of open-coding the lookup
>   (Amir).
> 
> Tested on arm64 QEMU at fd6e2388a3ea with SELinux enforcing and two
> nested overlayfs mounts. The policy omitted only
> base_t -> mounter_t:fd { use } among the relevant cross-domain allows:
> 
>   baseline: mprotect(PROT_READ) returned EACCES with that denial
>   patched:  mprotect(PROT_READ) succeeded; test exited 0

If you could share the distro and some more details on the testing
methodology that would be helpful.

> This patch fixes SID propagation only. backing_file_user_path() still
> resolves to the middle layer for a nested mapping, so the audit path and
> inode do not correspond to uf_sid, and that layer's mounter is not
> re-checked. Preserving the full user path likely needs a VFS-side change,
> such as having backing_file_open() store file_user_path(user_file).

Additional comments below, and while this patch is useful in fixing some
of the problems (thank you!), we obviously need to fix the others as
well.  Is this something you think you will be able to work on?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1ead2eee1944..171b90412ff1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3843,13 +3843,20 @@ static int selinux_file_alloc_security(struct file *file)
>  	return 0;
>  }
>  
> +static inline u32 selinux_file_user_sid(const struct file *file)
> +{
> +	if (unlikely(file->f_mode & FMODE_BACKING))
> +		return selinux_backing_file(file)->uf_sid;
> +	return selinux_file(file)->sid;
> +}

I'm a little concerned that this only works for one additional level of
filesystem stacking.  Yes, I know that OVL_MAX_NESTING and
FILESYSTEM_MAX_STACK_DEPTH are currently set at "2", but it's not an
unreasonable concern that at some point in the future that number will
increase without proper notification or testing and we will once again
have a problem.

At the absolute minimum we should have a BUILD_BUG_ON() for the stacking
depth.  It would be good if we could watch both the overlayfs and vfs
constants, but the overlayfs constant isn't available outside
fs/overlayfs/inode.c (thankfully it is currently set to the vfs limit).

  BUIILD_BUG_ON(FILESYSTEM_MAX_STACK_DEPTH > 2);

Ideally, the code would be written to keep diving down the stack until
it hit the true backing file.  No one likes to see recursion, but at the
point where this function is called there should already be a reasonable
bound on the stacking depth and the work involved.

--
paul-moore.com
