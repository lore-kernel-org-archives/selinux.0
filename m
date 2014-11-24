Message-ID: <54735BC4.7050207@tresys.com>
Date: Mon, 24 Nov 2014 11:24:36 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Fix expand logic for policy versions older than 24.
References: <1416841579-7924-1-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1416841579-7924-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Acked-By: Steve Lawrence <slawrence@tresys.com>

On 11/24/2014 10:06 AM, Stephen Smalley wrote:
> This was broken for older policy versions when we updated to
> version 24.
> 
> Broken by commit 787f2f00f5d8ed6f5f.
> 
> Change-Id: I4063334c5c0462ef5c3706611c7dff5c60c612aa
> Reported-by: William Roberts <bill.c.roberts@gmail.com>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  libsepol/src/expand.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 23eb6ed..57293ae 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -3159,12 +3159,12 @@ static int expand_avtab_node(avtab_key_t * k, avtab_datum_t * d, void *args)
>  	newkey.target_class = k->target_class;
>  	newkey.specified = k->specified;
>  
> -	if (stype->flavor != TYPE_ATTRIB && ttype->flavor != TYPE_ATTRIB) {
> +	if (stype && ttype && stype->flavor != TYPE_ATTRIB && ttype->flavor != TYPE_ATTRIB) {
>  		/* Both are individual types, no expansion required. */
>  		return expand_avtab_insert(expa, k, d);
>  	}
>  
> -	if (stype->flavor != TYPE_ATTRIB) {
> +	if (stype && stype->flavor != TYPE_ATTRIB) {
>  		/* Source is an individual type, target is an attribute. */
>  		newkey.source_type = k->source_type;
>  		ebitmap_for_each_bit(tattr, tnode, j) {
> @@ -3178,7 +3178,7 @@ static int expand_avtab_node(avtab_key_t * k, avtab_datum_t * d, void *args)
>  		return 0;
>  	}
>  
> -	if (ttype->flavor != TYPE_ATTRIB) {
> +	if (ttype && ttype->flavor != TYPE_ATTRIB) {
>  		/* Target is an individual type, source is an attribute. */
>  		newkey.target_type = k->target_type;
>  		ebitmap_for_each_bit(sattr, snode, i) {
> @@ -3289,12 +3289,12 @@ int expand_cond_av_node(policydb_t * p,
>  	newkey.target_class = k->target_class;
>  	newkey.specified = k->specified;
>  
> -	if (stype->flavor != TYPE_ATTRIB && ttype->flavor != TYPE_ATTRIB) {
> +	if (stype && ttype && stype->flavor != TYPE_ATTRIB && ttype->flavor != TYPE_ATTRIB) {
>  		/* Both are individual types, no expansion required. */
>  		return expand_cond_insert(newl, expa, k, d);
>  	}
>  
> -	if (stype->flavor != TYPE_ATTRIB) {
> +	if (stype && stype->flavor != TYPE_ATTRIB) {
>  		/* Source is an individual type, target is an attribute. */
>  		newkey.source_type = k->source_type;
>  		ebitmap_for_each_bit(tattr, tnode, j) {
> @@ -3308,7 +3308,7 @@ int expand_cond_av_node(policydb_t * p,
>  		return 0;
>  	}
>  
> -	if (ttype->flavor != TYPE_ATTRIB) {
> +	if (ttype && ttype->flavor != TYPE_ATTRIB) {
>  		/* Target is an individual type, source is an attribute. */
>  		newkey.target_type = k->target_type;
>  		ebitmap_for_each_bit(sattr, snode, i) {
> 
