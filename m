Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122263A5435;
	Tue, 30 Jun 2026 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815001; cv=none; b=Q9YRf6E53A/WQSdPWHOwVpxADCpgXDsa29gQXaDAaPBD9j42ROoyk+PDXFOA8jZFkDJirziHUj+AaY2ILczZrr5+Qqxp92VTCt7asjuYPsIJu/XMJi1XNmfmegRpzsuPuQbb1nxk5I90NzPR0DDKrufPghRu5krEtb7uUS/yY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815001; c=relaxed/simple;
	bh=y24taf2KLn8PBbdvFws5hh9bTUpSUli2HoJnw7JcbIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ao2EL5URaybhlFYrsubJZVc76kxDWO4EKK6Ybz8MInfWgdCNOtDHXBHnHWIsI6JJS6qCgxHG583FtF2VzfRUzxvqkMAZHot/UUVekSftDGqP9wSIZ2UbVF6+QpN4zDIYuxfPOEYVbC5g3izaDL/AKCIaMhsQx7cynOWpmZzO/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haSJO5sD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haSJO5sD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6BE1F00A3A;
	Tue, 30 Jun 2026 10:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782814999;
	bh=49ts4IqbNlyVo/a5KI5Cw42L0znHHzETSbQQLPw8WoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=haSJO5sDiavz86iFpzFpaa7YVPpl2dTpam7dInbs9VGCwx57I70qG4SLcnhW+ndaZ
	 nC+sv9qUoOa32w3WgtoERbV5cJHLon31ieoK/kH1mxuNKyqQxhGcUHW3fPoFXarifJ
	 KHdfcqrl2eHPx37dTjFK+/9/hrIfM4s8wE9Mn+tEEKeVrmUHhiWcp+syIyx8Us3Oqw
	 42Kf7gmrr2zz2CHI9GL4kGNQC4e6Q0ynbFL/KVh0kZ8Zzzw6ZitjMeewJKbDFweOiW
	 xYqpZEleMMbqP+o+0+XTnWOlZ3dXA1OQa6leTFnQj7QSDKWCxLicPSuOVjpmhpP7BV
	 9+jl/idViOlrA==
Date: Tue, 30 Jun 2026 13:23:13 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2] selinux: hooks: use kmalloc() to allocate path buffer
Message-ID: <akOZERjhp302jhut@kernel.org>
References: <20260630-security-v2-1-560d33c13ee6@kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630-security-v2-1-560d33c13ee6@kernel.org>

Should have been:

Subject: [PATCH v4] selinux: hooks: use kmalloc() to allocate path buffer

On Tue, Jun 30, 2026 at 01:15:24PM +0300, Mike Rapoport (Microsoft) wrote:
> selinux_genfs_get_sid() allocates memory for a path with __get_free_page().
> 
> Such usage does not require a "page" and the size of the buffer should
> actually be PATH_MAX which may be less than PAGE_SIZE on some
> architectures.
> 
> Replace __get_free_page() for allocation of a path buffer with kmalloc()
> and make it explicit that the buffer size is PATH_MAX.
> 
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> This is a (tiny) part of larger work of replacing page allocator calls
> with kmalloc:
> 
> Also in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/security
> ---
> v4 changes:
> * rebase on v7.2-rc1
> 
> v3: https://lore.kernel.org/all/20260531165852.1478916-1-rppt@kernel.org
> * get the args in the right order
> 
> v2: https://lore.kernel.org/all/20260531151502.1467515-1-rppt@kernel.org
> * explicitly use kmalloc() with PATH_MAX
> ---
>  security/selinux/hooks.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1a713d96206f..d1f089917a82 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1336,11 +1336,11 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
>  	struct super_block *sb = dentry->d_sb;
>  	char *buffer, *path;
>  
> -	buffer = (char *)__get_free_page(GFP_KERNEL);
> +	buffer = kmalloc(PATH_MAX, GFP_KERNEL);
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
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260520-security-6cdd60da7129
> 
> Best regards,
> --  
> Sincerely yours,
> Mike.
> 

-- 
Sincerely yours,
Mike.
