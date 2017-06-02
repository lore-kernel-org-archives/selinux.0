Subject: Re: [PATCH] libsepol/cil: fix error check in new cil_resolve_name
To: Steve Lawrence <slawrence@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
References: <20170602112107.16109-1-slawrence@tresys.com>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <75dfc1c1-660e-3d4e-976c-ec548116355f@tycho.nsa.gov>
Date: Fri, 2 Jun 2017 12:26:41 -0400
MIME-Version: 1.0
In-Reply-To: <20170602112107.16109-1-slawrence@tresys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/02/2017 07:21 AM, Steve Lawrence wrote:
> This prevented cil_resolve_name() from returning an actual thing when a
> name resolved to an alias. This appears to have only affected resolution
> dealing with sensitivity and category aliases. Type aliases were not
> affected since places that dealt with types handled type aliases
> specifically and did not rely on this behavior from cil_resolve_name().
> 
> Signed-off-by: Steve Lawrence <slawrence@tresys.com>

Applied.

Thanks,
Jim

> ---
>   libsepol/cil/src/cil_resolve_ast.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index fc44a5e..d1a5ed8 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -4125,7 +4125,7 @@ int cil_resolve_name(struct cil_tree_node *ast_node, char *name, enum cil_sym_in
>   	struct cil_tree_node *node = NULL;
>   
>   	rc = cil_resolve_name_keep_aliases(ast_node, name, sym_index, extra_args, datum);
> -	if (rc != SEPOL_ERR) {
> +	if (rc != SEPOL_OK) {
>   		goto exit;
>   	}
>   
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
