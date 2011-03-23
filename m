Subject: Re: [v0 PATCH 2/3] SELinux: Compute role in newcontext for all
 classes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Harry Ciao <qingtao.cao@windriver.com>
Cc: jmorris@namei.org, eparis@parisplace.org, selinux@tycho.nsa.gov
In-Reply-To: <1300847325-20308-3-git-send-email-qingtao.cao@windriver.com>
References: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>
	 <1300847325-20308-3-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 23 Mar 2011 09:31:52 -0400
Message-ID: <1300887112.26747.17.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-03-23 at 10:28 +0800, Harry Ciao wrote:
> From: Harry Ciao <harrytaurus200@hotmail.com>
> 
> For the process class, the role_trans.type is compared with
> tcontext->type, that is, the program executable type.
> 
> For all the rest classes, the role_trans.type is compared with
> newcontext.type, that is, the type for the newly created object
> of that class.

I don't understand why you aren't applying the logic consistently for
all classes.  Compare with range_trans handling.  Also, if we think
there will be any significant number of these role_trans rules, you
might want to go ahead and start using a hashtab as was later done for
range_trans for efficient lookup.

> 
> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> ---
>  security/selinux/ss/services.c |   23 ++++++++++++-----------
>  1 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index a03cfaf..01fc3d5 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1443,17 +1443,18 @@ static int security_compute_sid(u32 ssid,
>  	}
>  
>  	/* Check for class-specific changes. */
> -	if  (tclass == policydb.process_class) {
> -		if (specified & AVTAB_TRANSITION) {
> -			/* Look for a role transition rule. */
> -			for (roletr = policydb.role_tr; roletr;
> -			     roletr = roletr->next) {
> -				if (roletr->role == scontext->role &&
> -				    roletr->type == tcontext->type) {
> -					/* Use the role transition rule. */
> -					newcontext.role = roletr->new_role;
> -					break;
> -				}
> +	if (specified & AVTAB_TRANSITION) {
> +		/* Look for a role transition rule. */
> +		for (roletr = policydb.role_tr; roletr; roletr = roletr->next) {
> +			if ((roletr->role == scontext->role) &&
> +			    (roletr->cclass == tclass) &&
> +			    ((roletr->cclass == policydb.process_class &&
> +			      roletr->type == tcontext->type) ||
> +			     (roletr->cclass != policydb.process_class &&
> +			      roletr->type == newcontext.type))){
> +				/* Use the role transition rule. */
> +				newcontext.role = roletr->new_role;
> +				break;
>  			}
>  		}
>  	}

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
