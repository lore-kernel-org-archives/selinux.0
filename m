Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F802701B6;
	Fri, 21 Aug 2026 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787337290; cv=none; b=SrffF0IxUwmk7+v9rnBQg3wm0ISLCdz4V2Nsy2IbNryOW+imbPd7eEIQ9LOPU5od4Jv0r0jNNIL6j/3nt0tk3QrolVtv31AvTyZ02mrPqGRrmJaSabfhXXkqYasSsp0cZH05kMklWWV9Opx7WPhMmod7hr+ecdZBywNrb2MR9qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787337290; c=relaxed/simple;
	bh=fVr+wxu9Ixq/fMW3AgVfjo3ZziXDIROe48bL5m3NI14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoEPW8b3Jg/yzL6u0vBpzECnfzQD3ddaFYgWEmCWSpbjPh1uofvzY9Hpo6esMobejuDlgRJy+fgf+jwuSHwby7wPd7vCQXrxWjFC9gFqirOYb/iJ95fSv+fWZp83wDoIObXBbIUiXif8Gjx94Z7vCFG4Gr+w6syRei86hrfjF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE6JOs5Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE6JOs5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F3C1F000E9;
	Fri, 21 Aug 2026 18:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787337288;
	bh=oMBCnKRxKdS8Q3i2Mwvd1NJnQGm8tP9hnWkr5qGiIIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VE6JOs5ZJj3dEjBzNPO4iPDfwuEjv0FsIv+vdc8KAnBGDN/QyXvPtzibDYbgCaNB+
	 0qKQDP7MVhwfGi4k8B3e5K3OgNolhxfJ4A6wZnnTYQFzqZrel/QFBM7QcLzRON1VA2
	 LazEpVjV6bJmbfnO2imsIZUM0mqHw4kD6blPmx+UpT1lUA2lqkJRbDWFZ5Umqd56/S
	 LlNgcQcce4ULiYlUhok3cGbtugaiJxEgWRfzd+HqDvXBBRk47VVPvUYd7I4Gq/4PJt
	 aWDJcrVOZbmLbUu5lbHdTfLcpSOkTNZmfg1nD1l0OAGtiGJgcy4cWISjaFOf0C7k4X
	 bmw4bpPl83HUA==
Date: Fri, 21 Aug 2026 19:34:41 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?utf-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] proc: refactor /proc/$pid/mem to use struct as
 private_data
Message-ID: <aoiXvKXQK__0cSWL@gremlin>
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

On Tue, Aug 18, 2026 at 09:51:05PM +0200, Jann Horn wrote:
> Refactor the handlers for proc_mem_operations to use the new struct
> mem_private as ->private_data, rather than directly storing an mm_struct*
> in ->private_data.
>
> This is in preparation for adding more state in mem_private in the next
> commit.
>
> Signed-off-by: Jann Horn <jannh@google.com>

You had me at helper struct Jann, you had me at helper struct :)

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

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

OK I see that we mm_grab() in proc_mem_open().

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
Cheers, Lorenzo
