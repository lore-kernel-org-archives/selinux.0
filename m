Subject: Re: [PATCH 2/2] libsepol: do not mark db as unused when it is used
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170531200615.9166-1-nicolas.iooss@m4x.org>
 <20170531200615.9166-2-nicolas.iooss@m4x.org>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <90f7cbab-16a8-ba82-11be-74c2c92cb896@tycho.nsa.gov>
Date: Thu, 1 Jun 2017 12:36:08 -0400
MIME-Version: 1.0
In-Reply-To: <20170531200615.9166-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/31/2017 04:06 PM, Nicolas Iooss wrote:
> ---
>   libsepol/cil/src/cil_build_ast.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 0a9a5e57491a..7fcee61042c5 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -4256,7 +4256,7 @@ void cil_destroy_filecon(struct cil_filecon *filecon)
>   	free(filecon);
>   }
>   
> -int cil_gen_ibpkeycon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_ibpkeycon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>   {
>   	enum cil_syntax syntax[] = {
>   		CIL_SYN_STRING,
> @@ -4667,7 +4667,7 @@ void cil_destroy_netifcon(struct cil_netifcon *netifcon)
>   	free(netifcon);
>   }
>   
> -int cil_gen_ibendportcon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
> +int cil_gen_ibendportcon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
>   {
>   	enum cil_syntax syntax[] = {
>   		CIL_SYN_STRING,
> 

In both cases, the only use of db is to check that it is not null. Better to 
just remove those checks.

Thanks for the bug report.


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
