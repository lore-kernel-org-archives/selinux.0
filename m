Subject: Re: [PATCH v2] selinux: Only apply bounds checking to source types
To: selinux@tycho.nsa.gov
References: <1461947397-4478-1-git-send-email-sds@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fd18be76-8690-8de3-e83a-3c10b246e45e@tycho.nsa.gov>
Date: Tue, 3 May 2016 13:15:13 -0400
MIME-Version: 1.0
In-Reply-To: <1461947397-4478-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/29/2016 12:29 PM, Stephen Smalley wrote:
> The current bounds checking of both source and target types
> requires allowing any domain that has access to the child
> domain to also have the same permissions to the parent, which
> is undesirable.  Drop the target bounds checking.
> 
> KaiGai Kohei originally removed all use of target bounds in
> commit 7d52a155e38d ("selinux: remove dead code in
> type_attribute_bounds_av()") but this was reverted in
> commit 2ae3ba39389b ("selinux: libsepol: remove dead code in
> check_avtab_hierarchy_callback()") because it would have
> required explicitly allowing the parent any permissions
> to the child that the child is allowed to itself.
> 
> This change in contrast retains the logic for the case where both
> source and target types are bounded, thereby allowing access
> if the parent of the source is allowed the corresponding
> permissions to the parent of the target.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

I'm NAK'ing this one too.  It yields an ambiguity in how to resolve
bounds violations (two different ways), may lead to undesirable rules,
and doesn't optimize for the common case.  Version 3 on the way...

> ---
> v2 retains the logic for the case where both source and target
> types are bounded as described above, and amends the patch
> description to explain the difference from KaiGai's earlier attempt.
> 
>  security/selinux/ss/services.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 89df646..ca42265 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -573,28 +573,14 @@ static void type_attribute_bounds_av(struct context *scontext,
>  		masked = ~lo_avd.allowed & avd->allowed;
>  	}
>  
> -	if (target->bounds) {
> -		memset(&lo_avd, 0, sizeof(lo_avd));
> -
> -		memcpy(&lo_tcontext, tcontext, sizeof(lo_tcontext));
> -		lo_tcontext.type = target->bounds;
> -
> -		context_struct_compute_av(scontext,
> -					  &lo_tcontext,
> -					  tclass,
> -					  &lo_avd,
> -					  NULL);
> -		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
> -			return;		/* no masked permission */
> -		masked = ~lo_avd.allowed & avd->allowed;
> -	}
> -
>  	if (source->bounds && target->bounds) {
>  		memset(&lo_avd, 0, sizeof(lo_avd));
> +
>  		/*
> -		 * lo_scontext and lo_tcontext are already
> -		 * set up.
> +		 * lo_scontext is already set up above.
>  		 */
> +		memcpy(&lo_tcontext, tcontext, sizeof(lo_tcontext));
> +		lo_tcontext.type = target->bounds;
>  
>  		context_struct_compute_av(&lo_scontext,
>  					  &lo_tcontext,
> 
