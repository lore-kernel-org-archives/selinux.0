Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6E36B924
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139551; cv=none; b=peuIEaFdTvQfZB1u73rzwZC3gcOfmSnWhRHbgiEz1h4ATO4/S9AspJ8ydHNS3NbpAJ67t9AHgEDYqOx8linru1IGppNNWa3jzh4tB1vES8EBMKcIv8JjqUCQUYDAOD7+bfQaIJSTGFyMM7Yir9w0wHnZUR+o742w6+GNcmy2fXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139551; c=relaxed/simple;
	bh=WmW1qaZejDt/B9IJjz77Ksu/SUCLDzbcfwlJ1cUMCz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZxujS3InOlFnWKtwQqJ+2ukdtnnWIecbj1wtFbig6VU/ghnb55yO40kJSRdlbST/BR9WWH+OPV0PWZLqsUL9Ktu/AtejIOmerv229TxPmZiEwmzGJGlHYpNnxgppqgQZBU1EgLEznF4rWxEOK59koFQuSuMTmL3aJ3my2bxU0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozuyu64K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozuyu64K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F271B1F000FF;
	Fri, 11 Sep 2026 15:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139549;
	bh=ubHT+s37AfawNEZdCKubNBx5lR6AzGVvTl2t0ajaS/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ozuyu64KIR2SKXURCsqUwO8PQ+VuSKdudoHuA8Jl3XRrOFD/eDIN1iQIrq0mp8i/p
	 1rL4RJ0VSMaKfe6bUbP24icPHjfg2Y/SymPVSqy2DH7X5tNiNo0CczMqdV6xTn+uR3
	 ICecKrTHqaWhTAJ33B9T0SuNOd8zfWEt3wpY/+3i2Vv77+bu31/z2R6jKSlqGLhx/2
	 xJb5CwfYaQuFp16LiYc0VX5P5wI7g509MlTbMqSRWXBQI0NHTtZfjw6aARJ5BTPHEd
	 zkKuLhdIfonpwBDxuOpRnxL91eUi8Bnfz7Xdj4WcjnsO1vVoEa57VS/HxDVGcGfgRz
	 l+K3tpMsIeRNA==
Date: Fri, 11 Sep 2026 16:12:24 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnacek@gmail.com, 
	jannh@google.com, jack@suse.cz, cgzones@googlemail.com, brauner@kernel.org
Subject: Re: [PATCH v2] selinux: reject writable opens of status file, drop
 mmap write checks
Message-ID: <aqQZ0sx-0fHpjBOK@gremlin>
References: <20260911145840.19039-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911145840.19039-2-stephen.smalley.work@gmail.com>

On Fri, Sep 11, 2026 at 10:58:41AM -0400, Stephen Smalley wrote:
> Similar to what
> https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/ does for the

NIT: Probably better to have that as a Link: tag ?

> policy file, update the .open handler for the status file to reject
> writable opens, and update the .mmap handler to stop clearing
> VM_MAYWRITE and checking for VM_WRITE. This does NOT prevent
> truncation via open(O_RDONLY|O_TRUNC) or truncate(), which is
> left to another patch.

Makes sense!

>
> Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
> cc: ljs@kernel.org
> cc: jannh@google.com
> cc: jack@suse.cz
> cc: cgzones@googlemail.com
> cc: brauner@kernel.org
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Seems reasonable to me so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> v2 corrects my previous incorrect claim re preventing truncation,
> deferring that to a separate patch like the still-pending one
> from cgzones, and also moves the FMODE_WRITE check before the
> status page allocation.
>
>  security/selinux/selinuxfs.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 292302eb60f3..835594d221fc 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -214,8 +214,12 @@ static const struct file_operations sel_handle_unknown_ops = {
>
>  static int sel_open_handle_status(struct inode *inode, struct file *filp)
>  {
> -	struct page    *status = selinux_kernel_status_page();
> +	struct page    *status;
>
> +	if (filp->f_mode & FMODE_WRITE)
> +		return -EACCES;
> +
> +	status = selinux_kernel_status_page();
>  	if (!status)
>  		return -ENOMEM;
>
> @@ -247,11 +251,6 @@ static int sel_mmap_handle_status(struct file *filp,
>  	/* only allows one page from the head */
>  	if (vma->vm_pgoff > 0 || size != PAGE_SIZE)
>  		return -EIO;
> -	/* disallow writable mapping */
> -	if (vma->vm_flags & VM_WRITE)
> -		return -EPERM;
> -	/* disallow mprotect() turns it into writable */
> -	vm_flags_clear(vma, VM_MAYWRITE);

A note for any curious as to why I didn't touch this in my patch - it's because
it's a PFN remap.

This means it's a kernel-owned mapping, where dropping VMA_MAYWRITE_BIT is
permitted, so it wouldn't have fallen foul of my series' checks which disallow
this for non-kernel-owned mappings.

>
>  	return remap_pfn_range(vma, vma->vm_start,
>  			       page_to_pfn(status),
> --
> 2.55.0
>

--
Cheers, Lorenzo
