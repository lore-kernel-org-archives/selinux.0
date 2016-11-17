Subject: Re: [PATCH v3 3/3] expand_terule_helper: cleanups
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov
References: <1479401768-19811-1-git-send-email-william.c.roberts@intel.com>
 <1479401768-19811-3-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7959ade9-b727-4891-70a8-4966977b95dc@tycho.nsa.gov>
Date: Thu, 17 Nov 2016 16:44:25 -0500
MIME-Version: 1.0
In-Reply-To: <1479401768-19811-3-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/17/2016 11:56 AM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> 1. Use the new helper to convert from AVRULE to AVTAB values.
> 2. Only check once for invalid AVRULE specified parameter.
> 3. Drop assert and just return error on invalid specification.
> 
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Thanks, applied all three.

> ---
>  libsepol/src/expand.c | 32 ++++++++++----------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 5e2c066..32df6f8 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1691,26 +1691,22 @@ static int expand_terule_helper(sepol_handle_t * handle,
>  	avtab_ptr_t node;
>  	class_perm_node_t *cur;
>  	int conflict;
> -	uint32_t oldtype = 0, spec = 0;
> -
> -	if (specified & AVRULE_TRANSITION) {
> -		spec = AVTAB_TRANSITION;
> -	} else if (specified & AVRULE_MEMBER) {
> -		spec = AVTAB_MEMBER;
> -	} else if (specified & AVRULE_CHANGE) {
> -		spec = AVTAB_CHANGE;
> -	} else {
> -		assert(0);	/* unreachable */
> +	uint32_t oldtype = 0;
> +
> +	if (!(specified & (AVRULE_TRANSITION|AVRULE_MEMBER|AVRULE_CHANGE))) {
> +		ERR(handle, "Invalid specification: %"PRIu32"\n", specified);
> +		return EXPAND_RULE_ERROR;
>  	}
>  
> +	avkey.specified = avrule_to_avtab_spec(specified);
> +	avkey.source_type = stype + 1;
> +	avkey.target_type = ttype + 1;
> +
>  	cur = perms;
>  	while (cur) {
>  		uint32_t remapped_data =
>  		    typemap ? typemap[cur->data - 1] : cur->data;
> -		avkey.source_type = stype + 1;
> -		avkey.target_type = ttype + 1;
>  		avkey.target_class = cur->tclass;
> -		avkey.specified = spec;
>  
>  		conflict = 0;
>  		/* check to see if the expanded TE already exists --
> @@ -1772,15 +1768,7 @@ static int expand_terule_helper(sepol_handle_t * handle,
>  		}
>  
>  		avdatump = &node->datum;
> -		if (specified & AVRULE_TRANSITION) {
> -			avdatump->data = remapped_data;
> -		} else if (specified & AVRULE_MEMBER) {
> -			avdatump->data = remapped_data;
> -		} else if (specified & AVRULE_CHANGE) {
> -			avdatump->data = remapped_data;
> -		} else {
> -			assert(0);	/* should never occur */
> -		}
> +		avdatump->data = remapped_data;
>  
>  		cur = cur->next;
>  	}
> 
