Date: Tue, 5 Jun 2007 15:49:41 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Eric Paris <eparis@redhat.com>
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        Alan Cox <alan@redhat.com>, drepper@redhat.com, roland@redhat.com,
        arjan@infradead.org, mingo@elte.hu, viro@zeniv.linux.org.uk,
        jmorris@namei.org, chrisw@redhat.com, sds@tycho.nsa.gov,
        sgrubb@redhat.com
Subject: Re: [PATCH] Protection for exploiting null dereference using mmap
Message-ID: <20070605224941.GD3723@sequoia.sous-sol.org>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com> <20070603205653.GE25869@devserv.devel.redhat.com> <1180964306.14220.34.camel@moss-spartans.epoch.ncsc.mil> <1181075666.3978.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1181075666.3978.31.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Eric Paris (eparis@redhat.com) wrote:
> +mmap_protect_memory

I'm terrible at names, but something like mmap_minimum_addr would be a
little clearer at describing that it's a lower bound on mapping memory.
BTW, this is also an arch specific issue, those with disjoint kernel
and user memory space don't suffer (yet another reason to default to 0).

> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -615,6 +615,15 @@ static ctl_table kern_table[] = {
>  		.proc_handler   = &proc_dointvec,
>  	},
>  #endif
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "mmap_protect_memory",
> +		.data		= &mmap_protect_memory,
> +		.maxlen         = sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec,
> +		.strategy	= &sysctl_intvec,

I don't think this strategy does anything without some boundary values.

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
> @@ -390,9 +394,16 @@ unsigned long do_mremap(unsigned long addr,
>  
>  			new_addr = get_unmapped_area(vma->vm_file, 0, new_len,
>  						vma->vm_pgoff, map_flags);
> -			ret = new_addr;
> -			if (new_addr & ~PAGE_MASK)
> +			if (new_addr & ~PAGE_MASK) {
> +				ret = new_addr;
>  				goto out;
> +			}
> +
> +			ret = security_file_mmap(0, 0, 0, 0, new_addr, 1);
> +			if (ret)
> +				goto out;
> +
> +			ret = new_addr;

Nit: unnecessary assignment...

>  		}
>  		ret = move_vma(vma, addr, old_len, new_len, new_addr);
		^^^
...as it's overwritten immediately after.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
