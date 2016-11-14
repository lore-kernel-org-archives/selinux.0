From: "Roberts, William C" <william.c.roberts@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: RE: [PATCH v2] libsepol: fix checkpolicy dontaudit compiler bug
Date: Mon, 14 Nov 2016 18:43:38 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC561CD24A5C@ORSMSX103.amr.corp.intel.com>
References: <1479145685-4899-1-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1479145685-4899-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of Stephen
> Smalley
> Sent: Monday, November 14, 2016 9:48 AM
> To: selinux@tycho.nsa.gov
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Subject: [PATCH v2] libsepol: fix checkpolicy dontaudit compiler bug
> 
> The combining logic for dontaudit rules was wrong, causing a dontaudit A B:C *;
> rule to be clobbered by a dontaudit A B:C p; rule.
> 
> Reported-by: Nick Kralevich <nnk@google.com>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  libsepol/src/expand.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c index 004a029..d7adbf8
> 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1604,7 +1604,8 @@ static int expand_range_trans(expand_state_t * state,
> static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
>  				   avtab_t * avtab, avtab_key_t * key,
>  				   cond_av_list_t ** cond,
> -				   av_extended_perms_t *xperms)
> +				   av_extended_perms_t *xperms,
> +				   char *alloced)
>  {
>  	avtab_ptr_t node;
>  	avtab_datum_t avdatum;
> @@ -1658,6 +1659,11 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t *
> handle,
>  			nl->next = *cond;
>  			*cond = nl;
>  		}
> +		if (alloced)
> +			*alloced = 1;
> +	} else {
> +		if (alloced)
> +			*alloced = 0;
>  	}
> 
>  	return node;
> @@ -1750,7 +1756,7 @@ static int expand_terule_helper(sepol_handle_t *
> handle,
>  			return EXPAND_RULE_CONFLICT;
>  		}
> 
> -		node = find_avtab_node(handle, avtab, &avkey, cond, NULL);
> +		node = find_avtab_node(handle, avtab, &avkey, cond, NULL,
> NULL);
>  		if (!node)
>  			return -1;
>  		if (enabled) {
> @@ -1790,6 +1796,7 @@ static int expand_avrule_helper(sepol_handle_t *
> handle,
>  	class_perm_node_t *cur;
>  	uint32_t spec = 0;
>  	unsigned int i;
> +	char alloced;
> 
>  	if (specified & AVRULE_ALLOWED) {
>  		spec = AVTAB_ALLOWED;
> @@ -1824,7 +1831,8 @@ static int expand_avrule_helper(sepol_handle_t *
> handle,
>  		avkey.target_class = cur->tclass;
>  		avkey.specified = spec;
> 
> -		node = find_avtab_node(handle, avtab, &avkey, cond,
> extended_perms);
> +		node = find_avtab_node(handle, avtab, &avkey, cond,
> +				       extended_perms, &alloced);
>  		if (!node)
>  			return EXPAND_RULE_ERROR;
>  		if (enabled) {
> @@ -1850,7 +1858,7 @@ static int expand_avrule_helper(sepol_handle_t *
> handle,
>  			 */
>  			avdatump->data &= cur->data;
>  		} else if (specified & AVRULE_DONTAUDIT) {
> -			if (avdatump->data)
> +			if (!alloced)
>  				avdatump->data &= ~cur->data;
>  			else
>  				avdatump->data = ~cur->data;

This seems awkward to me. If the insertion created a new empty node
why wouldn't !avdump->data be true (note the addition of the not operator)?

Or perhaps a mechanism to actual set the data on allocation, this way the logic is
Just &=.

> --
> 2.7.4
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
