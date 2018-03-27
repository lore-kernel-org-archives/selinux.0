To: Pierre-Hugues Husson <phh@phh.me>, selinux@tycho.nsa.gov
Cc: Tri Vo <trong@android.com>, Pierre-Hugues Husson <phhusson@gmail.com>
References: <20180322230435.21048-1-phh@phh.me>
 <20180322230435.21048-2-phh@phh.me>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <1398c436-67c1-63b8-fde8-0e5d6713d832@tycho.nsa.gov>
Date: Tue, 27 Mar 2018 09:58:37 -0400
MIME-Version: 1.0
In-Reply-To: <20180322230435.21048-2-phh@phh.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re:  [PATCH v2 1/1] Detect identical genfscon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/22/2018 07:04 PM, Pierre-Hugues Husson wrote:
> From: Pierre-Hugues Husson <phhusson@gmail.com>
> 
> Currently secilc doesn't deal with duplicate genfscon rules
> 
> This commit fixes this, and implements multiple_decls behaviour.
> 
> To reduce the code changes, the compare function returns in its LSB
> whether the rules are only a matching rule match, or a full match.
> ---
>   libsepol/cil/src/cil_post.c | 34 ++++++++++++++++++++++++++++++++--
>   1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index a2122454..c054e9ce 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -53,6 +53,26 @@
>   static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t *out, int max, struct cil_db *db);
>   static int __cil_expr_list_to_bitmap(struct cil_list *expr_list, ebitmap_t *out, int max, struct cil_db *db);
>   
> +/* compare function returns whether a,b have the same context in the LSB */
> +static int compact(void* array, uint32_t *count, int len, int (*compare)(const void *, const void *), int multiple_decls) {
> +	char *a = (char*)array;
> +	uint32_t i, j = 0;
> +	int c;
> +	for(i=1; i<*count; i++) {
> +		c = compare(a+i*len, a+j*len);
> +		/* If LSB is set, it means the rules match except for the context
> +		 * We never want this */
> +		if(c&1) return SEPOL_ERR;
> +
> +		if(!multiple_decls && c == 0) return SEPOL_ERR;
> +
> +		if(c) j++;
> +		if(i != j) memcpy(a+j*len, a+i*len, len);
> +	}
> +	*count = j;
> +	return SEPOL_OK;
> +}
> +
>   static int cil_verify_is_list(struct cil_list *list, enum cil_flavor flavor)
>   {
>   	struct cil_list_item *curr;
> @@ -202,9 +222,14 @@ int cil_post_genfscon_compare(const void *a, const void *b)
>   	struct cil_genfscon *agenfscon = *(struct cil_genfscon**)a;
>   	struct cil_genfscon *bgenfscon = *(struct cil_genfscon**)b;
>   
> -	rc = strcmp(agenfscon->fs_str, bgenfscon->fs_str);
> +	rc = 2*strcmp(agenfscon->fs_str, bgenfscon->fs_str);
>   	if (rc == 0) {
> -		rc = strcmp(agenfscon->path_str, bgenfscon->path_str);
> +		rc = 2*strcmp(agenfscon->path_str, bgenfscon->path_str);
> +		if(rc == 0) {
> +			rc = strcmp(agenfscon->context_str, bgenfscon->context_str);

Unfortunately, the field context_str is only used for contexts that have been 
assigned a name.

I am working on a version that will also report errors. Hopefully, I will post 
that later today.

Jim

> +			if(rc > 0) rc = 1;
> +			if(rc < 0) rc = -1;
> +		}
>   	}
>   
>   	return rc;
> @@ -2118,6 +2143,11 @@ static int cil_post_db(struct cil_db *db)
>   
>   	qsort(db->netifcon->array, db->netifcon->count, sizeof(db->netifcon->array), cil_post_netifcon_compare);
>   	qsort(db->genfscon->array, db->genfscon->count, sizeof(db->genfscon->array), cil_post_genfscon_compare);
> +	rc = compact(db->genfscon->array, &db->genfscon->count, sizeof(db->genfscon->array), cil_post_genfscon_compare, db->multiple_decls);
> +	if (rc != SEPOL_OK) {
> +		cil_log(CIL_INFO, "Failed to de-dupe genfscon\n");
> +		goto exit;
> +	}
>   	qsort(db->ibpkeycon->array, db->ibpkeycon->count, sizeof(db->ibpkeycon->array), cil_post_ibpkeycon_compare);
>   	qsort(db->ibendportcon->array, db->ibendportcon->count, sizeof(db->ibendportcon->array), cil_post_ibendportcon_compare);
>   	qsort(db->portcon->array, db->portcon->count, sizeof(db->portcon->array), cil_post_portcon_compare);
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
