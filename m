Subject: Re: [PATCH] selinux: convert type_val_to_struct to flex_array
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20100803194452.22236.49318.stgit@paris.rdu.redhat.com>
References: <20100803194452.22236.49318.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Aug 2010 15:14:06 -0400
Message-ID: <1280949246.21957.213.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-08-03 at 15:44 -0400, Eric Paris wrote:
> In rawhide type_val_to_struct will allocate 26848 bytes, an order 3
> allocations.  While this hasn't been seen to fail it isn't outside the
> realm of possibiliy on systems with severe memory fragmentation.  Convert
> to flex_array so no allocation will ever be bigger than PAGE_SIZE.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
> 
>  security/selinux/ss/policydb.c |   28 +++++++++++++++++++++-------
>  security/selinux/ss/policydb.h |    2 +-
>  security/selinux/ss/services.c |   17 ++++++++++++-----
>  3 files changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 4ca9b5c..b7ef93e 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -297,7 +297,11 @@ static int type_index(void *key, void *datum, void *datap)
>  		    || typdatum->bounds > p->p_types.nprim)
>  			return -EINVAL;
>  		p->p_type_val_to_name[typdatum->value - 1] = key;
> -		p->type_val_to_struct[typdatum->value - 1] = typdatum;
> +		/* this flex array was all preallocated, this cannot fail */
> +		if (flex_array_put_ptr(p->type_val_to_struct_array,
> +				       typdatum->value - 1, typdatum,
> +				       GFP_KERNEL | __GFP_ZERO))

Curious:  do we need to pass any gfp flag values if we are
preallocating?  Can the flags here just be 0?

> +			BUG();
>  	}
>  
>  	return 0;
> @@ -474,11 +478,17 @@ static int policydb_index_others(struct policydb *p)
>  	if (!p->user_val_to_struct)
>  		goto out;
>  
> +	/* Yes, I want the sizeof the pointer, not the structure */
>  	rc = -ENOMEM;
> -	p->type_val_to_struct =
> -		kmalloc(p->p_types.nprim * sizeof(*(p->type_val_to_struct)),
> -			GFP_KERNEL);
> -	if (!p->type_val_to_struct)
> +	p->type_val_to_struct_array = flex_array_alloc(sizeof(struct type_dataum *),

What is a type_dataum and where can I find one?  

> +						       p->p_types.nprim,
> +						       GFP_KERNEL | __GFP_ZERO);
> +	if (!p->type_val_to_struct_array)
> +		goto out;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
