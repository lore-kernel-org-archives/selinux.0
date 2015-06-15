Message-ID: <557ED456.80202@tycho.nsa.gov>
Date: Mon, 15 Jun 2015 09:34:14 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Nick Kralevich <nnk@google.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] policy_define.c: fix compiler warnings
References: <1434206958-9234-1-git-send-email-nnk@google.com>
In-Reply-To: <1434206958-9234-1-git-send-email-nnk@google.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/13/2015 10:49 AM, Nick Kralevich wrote:
> Fixes compiler warnings all similar to the following:
> 
> host C: checkpolicy <= external/selinux/checkpolicy/policy_define.c
> external/selinux/checkpolicy/policy_define.c:1572:2: warning: comparison of integers of different signs: 'int' and 'uint32_t' (aka 'unsigned int') [-Wsign-compare]
>         ebitmap_for_each_bit(&tclasses, node, i) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> external/selinux/checkpolicy/../libsepol/include/sepol/policydb/ebitmap.h:76:39: note: expanded from macro 'ebitmap_for_each_bit'
>         for (bit = ebitmap_start(e, &n); bit < ebitmap_length(e); bit = ebitmap_next(&n, bit)) \
>                                              ^ ~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Nick Kralevich <nnk@google.com>

Thanks, applied.

> ---
>  checkpolicy/policy_define.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 093bded..27d8fe7 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1521,7 +1521,8 @@ int define_compute_type_helper(int which, avrule_t ** rule)
>  	ebitmap_node_t *node;
>  	avrule_t *avrule;
>  	class_perm_node_t *perm;
> -	int i, add = 1;
> +	uint32_t i;
> +	int add = 1;
>  
>  	avrule = malloc(sizeof(avrule_t));
>  	if (!avrule) {
> @@ -2745,7 +2746,7 @@ static int dominate_role_recheck(hashtab_key_t key __attribute__ ((unused)),
>  	role_datum_t *rdp = (role_datum_t *) arg;
>  	role_datum_t *rdatum = (role_datum_t *) datum;
>  	ebitmap_node_t *node;
> -	int i;
> +	uint32_t i;
>  
>  	/* Don't bother to process against self role */
>  	if (rdatum->s.value == rdp->s.value)
> 
