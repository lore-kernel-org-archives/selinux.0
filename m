Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB46641D624
	for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377507; cv=none; b=OfEuW80ucrKOQfduCXA8I4AKj7dpxLMPKr34Bsqit7eiK61saDyVYETv9pIrHzh8gfgG4RSGQ9Oof417R3jOByjGY5tHRvADvWJahSyy0bOFixyWeH69bDUesNnXWKxgO5x3PbfRL36Ov4pWKos7YovZ1ivxaXEq1A7g74vXz4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377507; c=relaxed/simple;
	bh=5pLrB+Z0svUX1goB0zkOvvyegBeWvHrq0c41CGFrLtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRM6BUtC6ZBK6gTh0ZPstsJwQJiGQOX4KBJnNnAQzblGQXk+RTZUahYEYxFY5PTbhsP510PEGzpvjP45Q83a6EHEDKtswye5xgb0UV5VjRaMZX4iSfpAWYdnnKIc4L3RdiZ+E0lsV9ZbXdU7NIfpqFkdko+QcCKUrVAB4Ql/M48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOBfFzig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOBfFzig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ED81F00893;
	Mon, 14 Sep 2026 09:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789377505;
	bh=rEaZggJBPL+4+dS4aZ/TY/vF45Qc1pEZgbzA07X7U18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BOBfFzigMfyEW3/BXeOpzPR1ElInyPaw524Ck/P+l/M613ulNgg8Nw8TT4jkoHwYQ
	 WtharuJdCIwfN6yZ3HIBJpSXYWAPFtHosPVIfW01RZk3ojMm148+fH11dfnO60LtUj
	 aR5ZHJxV/ZHCJk50e1AeSAgNSc/fbjVTyJ/1aGF0kwqLuISH5YtIUMvoY4UpbiORHB
	 0QXaXGuUMJmgXnH/CtRSZSX70cEHjk7podxbFZ60iQ9qguUaWGa2wY5TJ+gZ88COmL
	 D07bY7lC2STrDl3bWk1/axKjBi7PJkKevxWjdbRbWgYv9TvwPY9udEl14cZrrkBO9g
	 /JgMYTuxDO82A==
Date: Mon, 14 Sep 2026 10:18:21 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnacek@gmail.com, 
	jannh@google.com, jack@suse.cz, cgzones@googlemail.com, brauner@kernel.org
Subject: Re: [PATCH v3] selinux: mark status and policy inodes as immutable,
 drop status mmap write checks
Message-ID: <aqe6QA7Gn7B_7EhB@gremlin>
References: <20260911163734.22981-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911163734.22981-2-stephen.smalley.work@gmail.com>

On Fri, Sep 11, 2026 at 12:37:35PM -0400, Stephen Smalley wrote:
> The selinuxfs "status" and "policy" files are read-only interfaces
> that are also mmap'd by userspace. They are created 0444 by
> simple_fill_super() but a CAP_DAC_OVERRIDE caller can still open them
> O_WRONLY/O_RDWR, open(O_RDONLY|O_TRUNC) them, or truncate(2) them.
>
> Mark both inodes S_IMMUTABLE at fill_super time. inode_permission()
> tests IS_IMMUTABLE before the DAC / capability checks, so all of the
> above are rejected at the VFS layer without ever reaching the file
> operations. Since a writable file can no longer exist, do_mmap() clear

Micro nit: clear -> clears.

> VM_MAYWRITE for MAP_SHARED mappings on its own, and the
> sel_mmap_handle_status() write/mprotect guards are dead; drop them.
> MAP_PRIVATE writable mappings become permitted (they were previously
> -EPERM) and CoW harmlessly to a private page, matching how
> sel_mmap_policy() has always treated the private case.
>
> The sel_mmap_policy() VM_SHARED guard becomes redundant for the same
> reason; leave dropping it to the pending "selinux: reject writable
> opens of policy file, drop mmap shared/write check" patch so that the
> patches do not conflict.
>
> Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
> cc: ljs@kernel.org
> cc: jannh@google.com
> cc: jack@suse.cz
> cc: cgzones@googlemail.com
> cc: brauner@kernel.org
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

With nits addressed, LGTM so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> v3 implements Jan's suggestion to mark the inodes immutable rather than
> implementing open-time checks.
>
>  security/selinux/selinuxfs.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 292302eb60f3..0941ce79ea0b 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -247,11 +247,6 @@ static int sel_mmap_handle_status(struct file *filp,
>  	/* only allows one page from the head */
>  	if (vma->vm_pgoff > 0 || size != PAGE_SIZE)
>  		return -EIO;
> -	/* disallow writable mapping */
> -	if (vma->vm_flags & VM_WRITE)
> -		return -EPERM;
> -	/* disallow mprotect() turns it into writable */
> -	vm_flags_clear(vma, VM_MAYWRITE);
>
>  	return remap_pfn_range(vma, vma->vm_start,
>  			       page_to_pfn(status),
> @@ -1818,6 +1813,17 @@ static struct dentry *sel_make_swapover_dir(struct super_block *sb, u64 *ino)
>
>  #define NULL_FILE_NAME "null"
>
> +static void sel_mark_immutable(struct dentry *root, const char *name)
> +{
> +	struct qstr q = QSTR(name);
> +	struct dentry *dentry = try_lookup_noperm(&q, root);
> +
> +	if (!IS_ERR_OR_NULL(dentry)) {
> +		d_inode(dentry)->i_flags |= S_IMMUTABLE;
> +		dput(dentry);
> +	}
> +}

Hmm, maybe worth returning an error here on lookup failure? I think probably it
can't happen in reality right now but that'd make it consistent with the other
functions here.

> +
>  static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct selinux_fs_info *fsi;
> @@ -1857,6 +1863,9 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
>  	if (ret)
>  		goto err;
>
> +	sel_mark_immutable(sb->s_root, "status");
> +	sel_mark_immutable(sb->s_root, "policy");
> +
>  	fsi = sb->s_fs_info;
>  	fsi->bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME, &fsi->last_ino);
>  	if (IS_ERR(fsi->bool_dir)) {
> --
> 2.55.0
>

--
Cheers, Lorenzo
