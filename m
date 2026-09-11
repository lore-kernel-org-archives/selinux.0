Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43F377559
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140240; cv=none; b=RWcwL3HpqPid1NsXe5iWpgh0AW5t4khVth8yvMEQTOWdJtakxEnfhMgw2ESfiWN8QxV7961ShBHrfqOukKejtGSMYFW1I6JrgkatLb9yp+/4y4Z+XqwtT0WiE6ej9SyxHtKFMUZBuTcuHqu9beUuU4qvle1mGbFDvJ7FZnnrM0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140240; c=relaxed/simple;
	bh=tkFigKZGVj59e9B5d1dJHF0CujC9/XNYve0+SOJ1PcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qa63aApeoyx5yrfwTCvPeUUa1Z872ra5JLVs/aoqRvK0+2ay7+NTz5vvU+rbAeQHs+c6MAYKvvK9upBaW7NaCTig+qLJYvNsNTpeJDSjbWNI3M7EMixRvtfyaAxb5G87XmztXJQOeglvYRA65TInLKq4LM+oaY8jjOdW5c3E53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qkcy2WQ8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CIm8viYw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KkINFER+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HMO/1zcm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qkcy2WQ8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CIm8viYw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KkINFER+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HMO/1zcm"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 865EB21BF9;
	Fri, 11 Sep 2026 15:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789140232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nF7duzHVCnjqVNR9ugj1LW8lR0sENnQtDlnUtPbxMzw=;
	b=qkcy2WQ8nYeUodT+mFBNlWFxfYFFHxEOOEocMLH5l5xgqbHKp2f2LrXUA1ANdPEaBz+YfP
	1W1/lK7nnpk1zDsuqj6FbKJ6lieVKAhlhyBsMBAudavPF4EYf+uD/mShURR3nYSgh4cdoz
	MzaePu8jIlTy2lwqjqLFHVXgVBtSoFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789140232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nF7duzHVCnjqVNR9ugj1LW8lR0sENnQtDlnUtPbxMzw=;
	b=CIm8viYw0O0HZ6HMHyyAxZ4HV0yosUQUK6Hr/qGiU2AMVO9PR1Ae6Z8ugXsvva7EKPZ3Nf
	7DIfI8gYFT24wNDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789140228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nF7duzHVCnjqVNR9ugj1LW8lR0sENnQtDlnUtPbxMzw=;
	b=KkINFER+hcR5M/eG2ZEndLU+OqRi1n9ureyzLNNkssQ5ixiYhzQIRYcQWgYcr/psxhn9+m
	z0le6BDKvTxDwxTAVmlbh8Ckxk4KFZwzE9TphgX6RLMQL6z/R9QheF2htxWlwxldq/aLq6
	KMj+l0eDy1ax5WMD6XjHdIWjmAJLtgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789140228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nF7duzHVCnjqVNR9ugj1LW8lR0sENnQtDlnUtPbxMzw=;
	b=HMO/1zcmAQAXs5lMxj86N34Wpe4FG/8KiPjOfWdt8vRK/KDS1Ma+Erph5dEFOm8n4j6tfX
	U2ggLHkziORsTSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F6F8132D3;
	Fri, 11 Sep 2026 15:23:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3HpFFwQdpGofMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Sep 2026 15:23:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E1E63A079E; Fri, 11 Sep 2026 17:23:47 +0200 (CEST)
Date: Fri, 11 Sep 2026 17:23:47 +0200
From: Jan Kara <jack@suse.cz>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnacek@gmail.com, 
	ljs@kernel.org, jannh@google.com, jack@suse.cz, cgzones@googlemail.com, 
	brauner@kernel.org
Subject: Re: [PATCH v2] selinux: reject writable opens of status file, drop
 mmap write checks
Message-ID: <vacb35v2k5omae7ad5hcvtnzkciib4zcdb2kbokgd5gt377vc4@mdqmy6namwrn>
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
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spam-Flag: NO
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

On Fri 11-09-26 10:58:41, Stephen Smalley wrote:
> Similar to what
> https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/ does for the
> policy file, update the .open handler for the status file to reject
> writable opens, and update the .mmap handler to stop clearing
> VM_MAYWRITE and checking for VM_WRITE. This does NOT prevent
> truncation via open(O_RDONLY|O_TRUNC) or truncate(), which is
> left to another patch.
> 
> Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
> cc: ljs@kernel.org
> cc: jannh@google.com
> cc: jack@suse.cz
> cc: cgzones@googlemail.com
> cc: brauner@kernel.org
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Hum, so rather than having special checks in ->open, why don't you set
S_IMMUTABLE bit for the inodes which you really don't want anybody to
modify? That will block both writeable opens as well as truncate...

								Honza

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
>  
>  	return remap_pfn_range(vma, vma->vm_start,
>  			       page_to_pfn(status),
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
