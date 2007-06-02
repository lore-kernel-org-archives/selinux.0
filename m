Date: Fri, 1 Jun 2007 19:27:00 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Eric Paris <eparis@redhat.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        drepper@redhat.com, alan@redhat.com, roland@redhat.com,
        arjan@infradead.org, mingo@elte.hu, viro@zeniv.linux.org.uk,
        chrisw@redhat.com
Subject: Re: [PATCH] SELinux protection for exploiting null dereference
	using mmap
Message-ID: <20070602022700.GL3429@sequoia.sous-sol.org>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com> <Line.LNX.4.64.0705301954080.19731@d.namei> <1180590362.3969.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180590362.3969.11.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Eric Paris (eparis@redhat.com) wrote:
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 9eb9e0f..0aba455 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1240,9 +1240,11 @@ struct security_operations {
>  	void (*file_free_security) (struct file * file);
>  	int (*file_ioctl) (struct file * file, unsigned int cmd,
>  			   unsigned long arg);
> +	int (*mmap_zero) (void);

No longer used.

>  	int (*file_mmap) (struct file * file,
> -			  unsigned long reqprot,
> -			  unsigned long prot, unsigned long flags);
> +			  unsigned long reqprot, unsigned long prot,
> +			  unsigned long flags, unsigned long addr,
> +			  unsigned long addr_only);

Could just do file_mremap, since you've got 6 args here just to pass addr.

>  	int (*file_mprotect) (struct vm_area_struct * vma,
>  			      unsigned long reqprot,
>  			      unsigned long prot);
> @@ -1814,9 +1816,12 @@ static inline int security_file_ioctl (struct file *file, unsigned int cmd,
>  
>  static inline int security_file_mmap (struct file *file, unsigned long reqprot,
>  				      unsigned long prot,
> -				      unsigned long flags)
> +				      unsigned long flags,
> +				      unsigned long addr,
> +				      unsigned long addr_only)
>  {
> -	return security_ops->file_mmap (file, reqprot, prot, flags);
> +	return security_ops->file_mmap (file, reqprot, prot, flags, addr,
> +					addr_only);
>  }
>  
>  static inline int security_file_mprotect (struct vm_area_struct *vma,
> @@ -2489,7 +2494,9 @@ static inline int security_file_ioctl (struct file *file, unsigned int cmd,
>  
>  static inline int security_file_mmap (struct file *file, unsigned long reqprot,
>  				      unsigned long prot,
> -				      unsigned long flags)
> +				      unsigned long flags,
> +				      unsigned long addr,
> +				      unsigned long addr_only)
>  {
>  	return 0;
>  }
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 68b9ad2..bce4995 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1023,10 +1023,10 @@ unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
>  		}
>  	}
>  
> -	error = security_file_mmap(file, reqprot, prot, flags);
> +	error = security_file_mmap(file, reqprot, prot, flags, addr, 0);
>  	if (error)
>  		return error;
> -		
> +
>  	/* Clear old maps */
>  	error = -ENOMEM;
>  munmap_back:
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 5d4bd4f..ecb15e4 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -291,6 +291,10 @@ unsigned long do_mremap(unsigned long addr,
>  		if ((addr <= new_addr) && (addr+old_len) > new_addr)
>  			goto out;
>  
> +		ret = security_file_mmap(0, 0, 0, 0, new_addr, 1);
> +		if (ret)
> +			goto out;
> +
>  		ret = do_munmap(mm, new_addr, new_len);
>  		if (ret)
>  			goto out;

This is not sufficient assuming we support a cutoff greater than a
single page.  You can easily get get_unmapped_area to return something
as low as 0x1000.

> diff --git a/mm/nommu.c b/mm/nommu.c
> index 2b16b00..6f8ddee 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -639,7 +639,7 @@ static int validate_mmap_request(struct file *file,
>  	}
>  
>  	/* allow the security API to have its say */
> -	ret = security_file_mmap(file, reqprot, prot, flags);
> +	ret = security_file_mmap(NULL, 0, 0, 0, addr, 1);

Why?

>  	if (ret < 0)
>  		return ret;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
