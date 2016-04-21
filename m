Subject: Re: [PATCH] Fix extended permissions neverallow checking
To: Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov
References: <1461185389-3133-1-git-send-email-jeffv@google.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <57190F37.7050107@tycho.nsa.gov>
Date: Thu, 21 Apr 2016 13:34:47 -0400
MIME-Version: 1.0
In-Reply-To: <1461185389-3133-1-git-send-email-jeffv@google.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/20/2016 04:49 PM, Jeff Vander Stoep wrote:
> Commit 99fc177b "Add neverallow support for ioctl extended permissions"
> first checks to see if the ioctl permission is granted, then checks to
> see if the same source/target violates a neverallowed ioctl command.
> Unfortunately this does not address the case where the ioctl permission
> and extended permissions are granted on different attributes. Example,
> the following will incorrectly cause a neverallow violation.
> 
> allow untrusted_app self:tcp_socket ioctl;
> allowxperm domain domain:tcp_socket unpriv_sock_ioctls;
> neverallowxperm untrusted_app domain:tcp_socket ~unpriv_sock_ioctls;
> 
> The fix is to enumerate over the source and target attributes when
> looking for extended permission violations.
> 
> Note: The bug this addresses incorrectly asserts that a violation has
> occurred. Actual neverallow violations are always caught.
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>

Thanks, applied.

> ---
>  libsepol/src/assertion.c | 93 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 60 insertions(+), 33 deletions(-)
> 
> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> index fbf397f..f4429ad 100644
> --- a/libsepol/src/assertion.c
> +++ b/libsepol/src/assertion.c
> @@ -147,36 +147,49 @@ static int report_assertion_extended_permissions(sepol_handle_t *handle,
>  	avtab_key_t tmp_key;
>  	avtab_extended_perms_t *xperms;
>  	avtab_extended_perms_t error;
> +	ebitmap_t *sattr = &p->type_attr_map[k->source_type - 1];
> +	ebitmap_t *tattr = &p->type_attr_map[k->target_type - 1];
> +	ebitmap_node_t *snode, *tnode;
> +	unsigned int i, j;
>  	int rc = 1;
>  	int ret = 0;
>  
>  	memcpy(&tmp_key, k, sizeof(avtab_key_t));
>  	tmp_key.specified = AVTAB_XPERMS_ALLOWED;
>  
> -	for (node = avtab_search_node(avtab, &tmp_key);
> -	     node;
> -	     node = avtab_search_node_next(node, tmp_key.specified)) {
> -		xperms = node->datum.xperms;
> -		if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
> -				&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
> +	ebitmap_for_each_bit(sattr, snode, i) {
> +		if (!ebitmap_node_get_bit(snode, i))
>  			continue;
> +		ebitmap_for_each_bit(tattr, tnode, j) {
> +			if (!ebitmap_node_get_bit(tnode, j))
> +				continue;
> +			tmp_key.source_type = i + 1;
> +			tmp_key.target_type = j + 1;
> +			for (node = avtab_search_node(avtab, &tmp_key);
> +			     node;
> +			     node = avtab_search_node_next(node, tmp_key.specified)) {
> +				xperms = node->datum.xperms;
> +				if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
> +						&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
> +					continue;
>  
> -		rc = check_extended_permissions(avrule->xperms, xperms);
> -		/* failure on the extended permission check_extended_permissionss */
> -		if (rc) {
> -			extended_permissions_violated(&error, avrule->xperms, xperms);
> -			ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of policy.conf) violated by\n"
> -					"allowxperm %s %s:%s %s;",
> -					avrule->source_line, avrule->source_filename, avrule->line,
> -					p->p_type_val_to_name[stype],
> -					p->p_type_val_to_name[ttype],
> -					p->p_class_val_to_name[curperm->tclass - 1],
> -					sepol_extended_perms_to_string(&error));
> -
> -			rc = 0;
> -			ret++;
> +				rc = check_extended_permissions(avrule->xperms, xperms);
> +				/* failure on the extended permission check_extended_permissionss */
> +				if (rc) {
> +					extended_permissions_violated(&error, avrule->xperms, xperms);
> +					ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of policy.conf) violated by\n"
> +							"allowxperm %s %s:%s %s;",
> +							avrule->source_line, avrule->source_filename, avrule->line,
> +							p->p_type_val_to_name[stype],
> +							p->p_type_val_to_name[ttype],
> +							p->p_class_val_to_name[curperm->tclass - 1],
> +							sepol_extended_perms_to_string(&error));
> +
> +					rc = 0;
> +					ret++;
> +				}
> +			}
>  		}
> -
>  	}
>  
>  	/* failure on the regular permissions */
> @@ -319,28 +332,42 @@ oom:
>   *    granted
>   */
>  static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab,
> -						avtab_key_t *k)
> +						avtab_key_t *k, policydb_t *p)
>  {
>  	avtab_ptr_t node;
>  	avtab_key_t tmp_key;
>  	avtab_extended_perms_t *xperms;
>  	av_extended_perms_t *neverallow_xperms = avrule->xperms;
> +	ebitmap_t *sattr = &p->type_attr_map[k->source_type - 1];
> +	ebitmap_t *tattr = &p->type_attr_map[k->target_type - 1];
> +	ebitmap_node_t *snode, *tnode;
> +	unsigned int i, j;
>  	int rc = 1;
>  
>  	memcpy(&tmp_key, k, sizeof(avtab_key_t));
>  	tmp_key.specified = AVTAB_XPERMS_ALLOWED;
>  
> -	for (node = avtab_search_node(avtab, &tmp_key);
> -	     node;
> -	     node = avtab_search_node_next(node, tmp_key.specified)) {
> -		xperms = node->datum.xperms;
> -		if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
> -				&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
> +	ebitmap_for_each_bit(sattr, snode, i) {
> +		if (!ebitmap_node_get_bit(snode, i))
>  			continue;
> -
> -		rc = check_extended_permissions(neverallow_xperms, xperms);
> -		if (rc)
> -			break;
> +		ebitmap_for_each_bit(tattr, tnode, j) {
> +			if (!ebitmap_node_get_bit(tnode, j))
> +				continue;
> +			tmp_key.source_type = i + 1;
> +			tmp_key.target_type = j + 1;
> +			for (node = avtab_search_node(avtab, &tmp_key);
> +			     node;
> +			     node = avtab_search_node_next(node, tmp_key.specified)) {
> +				xperms = node->datum.xperms;
> +
> +				if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
> +						&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
> +					continue;
> +				rc = check_extended_permissions(neverallow_xperms, xperms);
> +				if (rc)
> +					break;
> +			}
> +		}
>  	}
>  
>  	return rc;
> @@ -386,7 +413,7 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
>  		goto exit;
>  
>  	if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
> -		rc = check_assertion_extended_permissions(avrule, avtab, k);
> +		rc = check_assertion_extended_permissions(avrule, avtab, k, p);
>  		if (rc == 0)
>  			goto exit;
>  	}
> 
