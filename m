From: Steve Lawrence <slawrence@tresys.com>
Subject: Re: [PATCH 5/6] libsepol/cil: Remove path field from cil_tree_node
 struct
To: James Carter <jwcart2@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
References: <1461075965-17161-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1461075965-17161-6-git-send-email-jwcart2@tycho.nsa.gov>
Message-ID: <571796AD.3090000@tresys.com>
Date: Wed, 20 Apr 2016 10:48:13 -0400
MIME-Version: 1.0
In-Reply-To: <1461075965-17161-6-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/19/2016 10:26 AM, James Carter wrote:
> Remove path field from cil_tree_node struct and all references
> to it in CIL. This will reduce memory usage by 5%.
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  libsepol/cil/src/cil_binary.c    | 14 +++++++++++++-
>  libsepol/cil/src/cil_build_ast.c |  2 --
>  libsepol/cil/src/cil_copy_ast.c  |  1 -
>  libsepol/cil/src/cil_parser.c    | 23 +++++++++++------------
>  libsepol/cil/src/cil_tree.c      |  1 -
>  libsepol/cil/src/cil_tree.h      |  1 -
>  6 files changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 0a98ecd..9db42d5 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -4227,6 +4227,9 @@ exit:
>  static avrule_t *__cil_init_sepol_avrule(uint32_t kind, struct cil_tree_node *node)
>  {
>  	avrule_t *avrule;
> +	struct cil_tree_node *source_node;
> +	char *source_path;
> +	int is_cil;
>  
>  	avrule = cil_malloc(sizeof(avrule_t));
>  	avrule->specified = kind;
> @@ -4235,8 +4238,17 @@ static avrule_t *__cil_init_sepol_avrule(uint32_t kind, struct cil_tree_node *no
>  	__cil_init_sepol_type_set(&avrule->ttypes);
>  	avrule->perms = NULL;
>  	avrule->line = node->line;
> -	avrule->source_filename = node->path;
> +
> +	avrule->source_filename = NULL;
>  	avrule->source_line = node->line;
> +	source_node = cil_tree_get_next_path(node, &source_path, &is_cil);
> +	if (source_node) {
> +		avrule->source_filename = source_path;
> +		if (!is_cil) {
> +			avrule->source_line = node->hll_line;

Can we not use ->line instead of ->hll_live when is_cil is true?

> +		}
> +	}
> +
>  	avrule->next = NULL;
>  	return avrule;
>  }
