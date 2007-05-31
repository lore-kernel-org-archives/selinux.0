Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4V07ONg005860
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 20:07:24 -0400
Received: from mail8.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4V07Lam009513
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 00:07:22 GMT
Date: Wed, 30 May 2007 20:07:18 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, drepper@redhat.com,
        alan@redhat.com, roland@redhat.com, arjan@infradead.org, mingo@elte.hu,
        viro@zeniv.linux.org.uk, chrisw@redhat.com
Subject: Re: [PATCH] SELinux protection for exploiting null dereference using
 mmap
In-Reply-To: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
Message-ID: <Line.LNX.4.64.0705301954080.19731@d.namei>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 30 May 2007, Eric Paris wrote:

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

I think this check should be folded into the security_file_mmap hook, 
which will need an address parameter.  The code seems to have changed a 
bit upstream vs. what you're using, but I think it'll work.

A useful side effect will be removal of the address check from the 
callsites and to allow the security module to check the address 
value itself.

In the case of do_mremap(), perhaps add another flag to indicate that 
it's an address value check only?  Seems ugly, but perhaps less so than a 
special hook for this.

> +	return avc_has_perm(sid, sid, SECCLASS_PROCESS_SPECIAL,
> +			    PROCESS_SPECIAL__MMAP_ZERO, NULL);

A new class for this seems odd. 

Is this class likely to be used for other similar checks?  I think it at 
least needs a better name.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
