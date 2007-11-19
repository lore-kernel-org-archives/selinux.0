Date: Mon, 19 Nov 2007 22:33:35 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: Labeled NFS <labeled-nfs@linux-nfs.org>, selinux@tycho.nsa.gov
Subject: Re: [Labeled-nfs] [PATCH 08/13] NFS: Introduce lifecycle managment
 for label attribute.
In-Reply-To: <1195243824.20981.19.camel@moss-terrapins.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0711192226180.20955@us.intercode.com.au>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
 <1195243824.20981.19.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 Nov 2007, David P. Quigley wrote:


> +#ifdef CONFIG_SECURITY
> +#define	nfs_fattr_alloc(fattr)						\
> +{									\
> +	(fattr)->label = kmalloc(NFS_MAXLABELLEN, GFP_ATOMIC);		\
> +	(fattr)->label_len = NFS_MAXLABELLEN;				\
> +	memset((fattr)->label, 0, NFS_MAXLABELLEN);			\
> +}

These should be normal functions, perhaps in their own file which is 
conditionally built (and containing other label-specific code).

You need to check the return of kmalloc().

I suggest passing a gfp_t parameter to the allocation function to allow 
the caller to determine the allocation flags (unless you know it will 
always be GFP_ATOMIC).

Use kzalloc() instead of kmalloc() + memset().

It seems wasteful to always allocate the maximum sized label.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
