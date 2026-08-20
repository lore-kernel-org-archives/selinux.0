Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3417418A48;
	Thu, 20 Aug 2026 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224849; cv=none; b=BTJtr6hGpFiz6QZn4zb7RwtfeqpPTSZPuJR4aAeF3jEnuBMqzC4SmDbetXTd4AZKOqsbmTvrxlGn2mJqa26gQd6cmRGq76R2vwfzSha+xgHR/J1lWE2T/kbZ908oK9UVm6t1KBI1X+w1z6dLKJmXJE4mFfc0HlTohhyQU5V/cdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224849; c=relaxed/simple;
	bh=mNKo+VeGUQvoC3HvVzi9u54tvLkXnQ+9tpx5PWNNcQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qITC7G9a50KFXY8b1CMLUhF33tdeLypQAFlGDTKim/g1qrFOLf3JudnIPnd/PXnpcfpwAmMPu3XupE3Q05RKvtzhatuKwZx1vfHtnSxzK96lLmwLFA9vm5WvMXPmBm5YIP1ibjgZVUr/2nqsFSyzs1dN6NoCDBzqk2KBwUfrlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZF3erbxi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OfVmpSul; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DT/kVxbG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=paRH9hh0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZF3erbxi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OfVmpSul";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DT/kVxbG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="paRH9hh0"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 33D3385041;
	Thu, 20 Aug 2026 11:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787224836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tk8jiJdcjWsP4GhLOTgEUqckIP3KNVGr11ane1BhbCI=;
	b=ZF3erbxirjWV5nK4xzrbZfVT2O07TlMViOfP300cWFayelaGeKLsNk8LnWhR0Ub7k9Qb0r
	esXasTH/LcTKHRpHhiBDPkefP3+BiSJuymIMfBYJWFBrFTsWp6dMRjktRnWlTBBfA0lzyv
	ABcue/sUx+mR+asrIVKnVEr9HXvR5gA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787224836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tk8jiJdcjWsP4GhLOTgEUqckIP3KNVGr11ane1BhbCI=;
	b=OfVmpSul/tf1tTue3qzy23FO6thfCUnoi31375KiZboJV0+JrSzTGv9ZiTW9r5KZjK6MlF
	8Ju7a+e/DDu4G2BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787224832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tk8jiJdcjWsP4GhLOTgEUqckIP3KNVGr11ane1BhbCI=;
	b=DT/kVxbGZ9DAq4jap/S4imDE9t9bAwAQIWRYYy2h9s22K3c+L9qQAioHE2McDQ2FMCPQTo
	zQhroHvJMkycZODk3BZWf/D8izEYAb7d+3jrrqcUhUisGx7dq6nwBowXSA7ETEsaXuOVIN
	xvNIQoA+rzKFVKJfwzIicxW/XwndYTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787224832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tk8jiJdcjWsP4GhLOTgEUqckIP3KNVGr11ane1BhbCI=;
	b=paRH9hh0L1JywzeFQYaxAykZpRkx60X7NaCFq9r4bRRR7t0I2YZz5z8TOP+nrnrNFb6FhF
	xoY44CJ2ozOSn9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2336D27A8;
	Thu, 20 Aug 2026 11:20:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VUaWCADjhmq9MgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 20 Aug 2026 11:20:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BB7A8A13B9; Thu, 20 Aug 2026 13:20:16 +0200 (CEST)
Date: Thu, 20 Aug 2026 13:20:16 +0200
From: Jan Kara <jack@suse.cz>
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?utf-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] proc: refactor /proc/$pid/mem to use struct as
 private_data
Message-ID: <2vwbng2vmyvssphmthcuzuicpfv2e3oe6ybbakct4fcbachjdr@ixzg6tvsjccu>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-1-90cd2357ee05@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-selinux-pokemem-v1-1-90cd2357ee05@google.com>
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_HAS_CURRENCY(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[paul-moore.com,namei.org,hallyn.com,gmail.com,google.com,zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,redhat.com,linux-foundation.org,infradead.org,suse.de,kvack.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]

On Tue 18-08-26 21:51:05, Jann Horn wrote:
> Refactor the handlers for proc_mem_operations to use the new struct
> mem_private as ->private_data, rather than directly storing an mm_struct*
> in ->private_data.
> 
> This is in preparation for adding more state in mem_private in the next
> commit.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/proc/base.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 780f81259052..bec6197329dc 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -848,11 +848,24 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
>  	return 0;
>  }
>  
> +/* private_data for proc_mem_operations */
> +struct mem_private {
> +	struct mm_struct *mm;
> +};
> +
>  static int mem_open(struct inode *inode, struct file *file)
>  {
> +	struct mem_private *priv __free(kfree) = kmalloc_obj(struct mem_private);
> +
> +	if (!priv)
> +		return -ENOMEM;
>  	if (WARN_ON_ONCE(!(file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
>  		return -EINVAL;
> -	return __mem_open(inode, file, PTRACE_MODE_ATTACH);
> +	priv->mm = proc_mem_open(inode, PTRACE_MODE_ATTACH);
> +	if (IS_ERR_OR_NULL(priv->mm))
> +		return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> +	file->private_data = no_free_ptr(priv);
> +	return 0;
>  }
>  
>  static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
> @@ -880,7 +893,8 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
>  static ssize_t mem_rw(struct file *file, char __user *buf,
>  			size_t count, loff_t *ppos, int write)
>  {
> -	struct mm_struct *mm = file->private_data;
> +	struct mem_private *priv = file->private_data;
> +	struct mm_struct *mm = priv->mm;
>  	unsigned long addr = *ppos;
>  	ssize_t copied;
>  	char *page;
> @@ -970,12 +984,21 @@ static int mem_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +static int mem_release_with_private(struct inode *inode, struct file *file)
> +{
> +	struct mem_private *priv = file->private_data;
> +
> +	mmdrop(priv->mm);
> +	kfree(priv);
> +	return 0;
> +}
> +
>  static const struct file_operations proc_mem_operations = {
>  	.llseek		= mem_lseek,
>  	.read		= mem_read,
>  	.write		= mem_write,
>  	.open		= mem_open,
> -	.release	= mem_release,
> +	.release	= mem_release_with_private,
>  	.fop_flags	= FOP_UNSIGNED_OFFSET,
>  };
>  
> 
> -- 
> 2.55.0.737.g08866a6d13-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
