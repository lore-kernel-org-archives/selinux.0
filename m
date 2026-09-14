Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1B63AFB1C
	for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372615; cv=none; b=jHUPWJFRcGpVX9dAQL7R41pJqo7toOyJLUdyOcK5vZhS/TFPuefu1fK+NAiO5gtzzLyfyz9XOabH0N9ud8IL318xtFJVCBBKqJfsq71lYaOth2mzn8ZSiT2ZXdcKdXvARnnWkLvoRLRodJaGVUV3OmExMAc7vP3hxKQDwt0zjdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372615; c=relaxed/simple;
	bh=nBSNkJA9XM/A850HU5MqtJXQF6/du2+T+XOkRhpzC1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHxSxvBMFzIxM5mMYqaA9yi1bqJvVAcmGahV6y83yPoUrcZDLJhZB3VzBcY8XJ61EnAJbnFIr4t9XapYzrYAkLPILCmScJXsxdw8Aghn7Q4Y2/jdu1Deq196BSci4mSYK5Z/yw55eWvoDxNofODlHx1ry+bSxx2AWEJGzK4oZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PSG8bEj0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hs2zSuk0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=idTyItqo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4coIhYAB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PSG8bEj0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hs2zSuk0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="idTyItqo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4coIhYAB"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D50B421900;
	Mon, 14 Sep 2026 07:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789372608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZuuzZGJA3HsREAO5KoNcqfgh1cQkSGsJasV+ApWrOrs=;
	b=PSG8bEj085rhKfFoEY15Va5nWblKjgj6lW4C25+RyXWrYuLQRu5cA3xe0x1Sjo9Nm6Vsgn
	O5TVukgdrSG4/SlM1pi1JBaTY4cGOzslbaaweRS7giZ90MGbsV24QdcsxyIdwQRAd+r82l
	X+O14TTKRJckHXSxkxxbveezq17Ovrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789372608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZuuzZGJA3HsREAO5KoNcqfgh1cQkSGsJasV+ApWrOrs=;
	b=Hs2zSuk0CqElw9J/Mq/EgpPEIlxxG5Q7YyJiqaGcxtzplkkOg0ysWf3B1q6m/r/3z8bqHk
	bJTwzOqBI6dRltBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789372603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZuuzZGJA3HsREAO5KoNcqfgh1cQkSGsJasV+ApWrOrs=;
	b=idTyItqoFLh9bBopBKc6o7I9e7w2m+Lx7TPQ4EPfFJgX9VeNt9y0Vy3GZDB/lgOq37nWED
	m0SJAUe7QgwasNME5s67iUdOL8YGDAJJR46Btg+tELfpFMtkArAUrROgDtHMP95xqVgKON
	n6mnJpNGCwowK7+w/KCaFeNnT+Jycao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789372603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZuuzZGJA3HsREAO5KoNcqfgh1cQkSGsJasV+ApWrOrs=;
	b=4coIhYABteByWGzrkyZPNLAzwuTjL6xzLvzETwbPJSydAi35ubmz0SZuONRjdy31rXO5me
	T+tCxBHxvz/6nXCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87F74136A1;
	Mon, 14 Sep 2026 07:56:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9w0qIbuop2o2cgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Sep 2026 07:56:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2346CA0B5A; Mon, 14 Sep 2026 09:56:43 +0200 (CEST)
Date: Mon, 14 Sep 2026 09:56:43 +0200
From: Jan Kara <jack@suse.cz>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnacek@gmail.com, 
	ljs@kernel.org, jannh@google.com, jack@suse.cz, cgzones@googlemail.com, 
	brauner@kernel.org
Subject: Re: [PATCH v3] selinux: mark status and policy inodes as immutable,
 drop status mmap write checks
Message-ID: <jjdsufnvzeva3biccbadiv3e46773o6pujj37hjhipq4ijn4r5@mhogw3hgygxf>
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
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,paul-moore.com,gmail.com,kernel.org,google.com,suse.cz,googlemail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO

On Fri 11-09-26 12:37:35, Stephen Smalley wrote:
> The selinuxfs "status" and "policy" files are read-only interfaces
> that are also mmap'd by userspace. They are created 0444 by
> simple_fill_super() but a CAP_DAC_OVERRIDE caller can still open them
> O_WRONLY/O_RDWR, open(O_RDONLY|O_TRUNC) them, or truncate(2) them.
> 
> Mark both inodes S_IMMUTABLE at fill_super time. inode_permission()
> tests IS_IMMUTABLE before the DAC / capability checks, so all of the
> above are rejected at the VFS layer without ever reaching the file
> operations. Since a writable file can no longer exist, do_mmap() clear
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

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

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
Jan Kara <jack@suse.com>
SUSE Labs, CR
