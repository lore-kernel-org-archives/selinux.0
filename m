Subject: Re: [PATCH 2/2] libsepol: fix checkpolicy dontaudit compiler bug
To: william.c.roberts@intel.com, nnk@google.com, selinux@tycho.nsa.gov
References: <[PATCH] libsepol: fix checkpolicy dontaudit compiler bug>
 <1479238801-13053-1-git-send-email-william.c.roberts@intel.com>
 <1479238801-13053-3-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <975ba9db-54e7-f220-dc7d-112e0fc734c9@tycho.nsa.gov>
Date: Tue, 15 Nov 2016 15:11:15 -0500
MIME-Version: 1.0
In-Reply-To: <1479238801-13053-3-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/15/2016 02:40 PM, william.c.roberts@intel.com wrote:
> From: Stephen Smalley <sds@tycho.nsa.gov>
> 
> The combining logic for dontaudit rules was wrong, causing
> a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:C p;
> rule.
> 
> This is a reimplimation of 6201bb5e2 that avoids the cumbersome
> pointer assignments on alloced.
> 
> Reported-by: Nick Kralevich <nnk@google.com>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libsepol/src/expand.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 004a029..ef04908 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1604,7 +1604,8 @@ static int expand_range_trans(expand_state_t * state,
>  static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
>  				   avtab_t * avtab, avtab_key_t * key,
>  				   cond_av_list_t ** cond,
> -				   av_extended_perms_t *xperms)
> +				   av_extended_perms_t *xperms,
> +				   uint32_t init_data)
>  {
>  	avtab_ptr_t node;
>  	avtab_datum_t avdatum;
> @@ -1640,6 +1641,7 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
>  
>  	if (!node) {
>  		memset(&avdatum, 0, sizeof avdatum);
> +		avdatum.data = init_data;
>  		/* this is used to get the node - insertion is actually unique */
>  		node = avtab_insert_nonunique(avtab, key, &avdatum);
>  		if (!node) {
> @@ -1750,7 +1752,7 @@ static int expand_terule_helper(sepol_handle_t * handle,
>  			return EXPAND_RULE_CONFLICT;
>  		}
>  
> -		node = find_avtab_node(handle, avtab, &avkey, cond, NULL);
> +		node = find_avtab_node(handle, avtab, &avkey, cond, NULL, 0);
>  		if (!node)
>  			return -1;
>  		if (enabled) {
> @@ -1824,7 +1826,15 @@ static int expand_avrule_helper(sepol_handle_t * handle,
>  		avkey.target_class = cur->tclass;
>  		avkey.specified = spec;
>  
> -		node = find_avtab_node(handle, avtab, &avkey, cond, extended_perms);
> +		node = find_avtab_node(handle, avtab, &avkey, cond,
> +				       extended_perms,
> +				       /*
> +					* dontaudit rules need to be
> +					* initialized on creation, others can
> +					* be 0.
> +					*/
> +				       specified & AVRULE_DONTAUDIT
> +					    ? ~cur->data : 0);

There seems to be a lack of symmetry here.  Either we should initialize
them all to the proper value (including AUDITDENY, which I think might
be broken too, although no one uses it anymore since the transition to
DONTAUDIT), or we should initialize the ones that are ORed to 0 and the
ones that are ANDed to ~0 and then let the subsequent OR'ing or AND'ing
adjust appropriately.

>  		if (!node)
>  			return EXPAND_RULE_ERROR;
>  		if (enabled) {
> @@ -1850,10 +1860,7 @@ static int expand_avrule_helper(sepol_handle_t * handle,
>  			 */
>  			avdatump->data &= cur->data;
>  		} else if (specified & AVRULE_DONTAUDIT) {
> -			if (avdatump->data)
> -				avdatump->data &= ~cur->data;
> -			else
> -				avdatump->data = ~cur->data;
> +			avdatump->data &= ~cur->data;
>  		} else if (specified & AVRULE_XPERMS) {
>  			xperms = avdatump->xperms;
>  			if (!xperms) {
> 
