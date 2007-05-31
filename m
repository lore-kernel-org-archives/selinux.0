Date: Wed, 30 May 2007 18:40:57 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, drepper@redhat.com,
        alan@redhat.com, roland@redhat.com, arjan@infradead.org, mingo@elte.hu,
        viro@zeniv.linux.org.uk, jmorris@namei.org, chrisw@redhat.com
Subject: Re: [PATCH] SELinux protection for exploiting null dereference
	using mmap
Message-ID: <20070531014057.GI3429@sequoia.sous-sol.org>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Eric Paris (eparis@redhat.com) wrote:
> +	int (*mmap_zero) (void);
>  	int (*file_mmap) (struct file * file,
>  			  unsigned long reqprot,
>  			  unsigned long prot, unsigned long flags);

When I looked into this originally, I expected to use existing file_mmap
hook, augmented with addr (of course, adding smth for mremap as well).

> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1026,6 +1026,12 @@ unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
>  	error = security_file_mmap(file, reqprot, prot, flags);
>  	if (error)
>  		return error;
> +
> +	if (unlikely(addr < PAGE_SIZE)) {
> +		error = security_mmap_zero();
> +		if (error)
> +			return error;
> +	}

I believe this is correct (despite the distinction of MAP_FIXED vs
!MAP_FIXED).

> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -291,6 +291,12 @@ unsigned long do_mremap(unsigned long addr,
>  		if ((addr <= new_addr) && (addr+old_len) > new_addr)
>  			goto out;
>  
> +		if (unlikely(new_addr < PAGE_SIZE)) {
> +			ret = security_mmap_zero();
> +			if (ret)
> +				goto out;
> +			ret = -EINVAL;
> +		}

This, on the other hand, I believe is correct only to the degree that
the current semantics of get_unmapped_area stay unchanged.  This is why
I had expected passing the addr to the module directly, since the cutoff
point is a lot like policy (one page is somewhat arbitrary).

thanks,
-chris

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
