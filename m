Subject: Re: [patch] selinux:  change handling of invalid classes (Was: Re:
	2.6.26-rc5-mm1 selinux whine)
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>, selinux@tycho.nsa.gov
In-Reply-To: <1213041836.30576.27.camel@moss-spartans.epoch.ncsc.mil>
References: <20080609012438.88a50622.akpm@linux-foundation.org>
	 <1213041836.30576.27.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 09 Jun 2008 16:08:45 -0400
Message-Id: <1213042125.4597.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-06-09 at 16:03 -0400, Stephen Smalley wrote:
> On Mon, 2008-06-09 at 01:24 -0700, Andrew Morton wrote:
> > Getting a few of these with FC5:
> > 
> > SELinux: context_struct_compute_av:  unrecognized class 69
> > SELinux: context_struct_compute_av:  unrecognized class 69
> > 
> > one came out when I logged in.
> > 
> > No other symptoms, yet.
> 
> Change handling of invalid classes by SELinux, reporting class values
> unknown to the kernel as errors (w/ ratelimit applied) and handling
> class values unknown to policy as normal denials.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: Eric Paris <eparis@redhat.com>

> 
> ---
> 
>  security/selinux/ss/services.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index d06df33..b7b9baa 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -408,9 +408,19 @@ static int context_struct_compute_av(struct context *scontext,
>  	return 0;
>  
>  inval_class:
> -	printk(KERN_ERR "SELinux: %s:  unrecognized class %d\n", __func__,
> -		tclass);
> -	return -EINVAL;
> +	if (!tclass || tclass > kdefs->cts_len ||
> +	    !kdefs->class_to_string[tclass]) {
> +		if (printk_ratelimit())
> +			printk(KERN_ERR "SELinux: %s:  unrecognized class %d\n",
> +			       __func__, tclass);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Known to the kernel, but not to the policy.
> +	 * Handle as a denial (allowed is 0).
> +	 */
> +	return 0;
>  }
>  
>  /*
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
