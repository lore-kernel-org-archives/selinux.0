Subject: Re: [PATCH] SELinux: fix off by 1 reference of class_to_string in
	context_struct_compute_av
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1213040592.4597.8.camel@localhost.localdomain>
References: <1213040592.4597.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 09 Jun 2008 16:08:16 -0400
Message-Id: <1213042096.30576.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-06-09 at 15:43 -0400, Eric Paris wrote:
> The class_to_string array is referenced by tclass.  My code mistakenly
> was using tclass - 1.  If the proceeding class is a userspace class
> rather than kernel class this may cause a denial/EINVAL even if unknown
> handling is set to allow.  The bug shouldn't be allowing excess
> priveladges since those are given based on the contents of another array
> which should be correctly referenced.
> 
> At this point in time its pretty unlikely this is going to cause
> problems.  The most recently added kernel classes which could be
> affected are association, dccp_socket, and peer.  Its pretty unlikely
> any policy with handle_unknown=allow doesn't have association and
> dccp_socket undefined (they've been around longer than unknown handling)
> and peer is conditionalized on a policy cap which should only be defined
> if that class exists in policy.
> 
> -Eric

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> 
> ---
> 
> Should be fine to push this to .26 but I don't think is absolutely
> necessary.
> 
>  security/selinux/ss/services.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index dcc2e1c..9294fe2 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -332,7 +332,7 @@ static int context_struct_compute_av(struct context *scontext,
>  		goto inval_class;
>  	if (unlikely(tclass > policydb.p_classes.nprim))
>  		if (tclass > kdefs->cts_len ||
> -		    !kdefs->class_to_string[tclass - 1] ||
> +		    !kdefs->class_to_string[tclass] ||
>  		    !policydb.allow_unknown)
>  			goto inval_class;
>  
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
