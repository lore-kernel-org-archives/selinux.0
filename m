Subject: Re: [PATCH 1/3] libsepol/cil: make cil_resolve_name() fail for '.'
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161003204657.2635-1-nicolas.iooss@m4x.org>
 <20161003204657.2635-2-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <f347fc41-dbeb-b06e-5f19-d2287af87f7f@tycho.nsa.gov>
Date: Tue, 4 Oct 2016 10:39:59 -0400
MIME-Version: 1.0
In-Reply-To: <20161003204657.2635-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/03/2016 04:46 PM, Nicolas Iooss wrote:
> This CIL policy makes secilc crash with a NULL pointer dereference:
>
>     (class CLASS (PERM))
>     (classorder (CLASS))
>     (sid SID)
>     (sidorder (SID))
>     (user USER)
>     (role ROLE)
>     (type TYPE)
>     (category CAT)
>     (categoryorder (CAT))
>     (sensitivity SENS)
>     (sensitivityorder (SENS))
>     (sensitivitycategory SENS (CAT))
>     (allow TYPE self (CLASS (PERM)))
>     (roletype ROLE TYPE)
>     (userrole USER ROLE)
>     (userlevel USER (SENS))
>     (userrange USER ((SENS)(SENS (CAT))))
>     (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
>
>     (allow . self (CLASS (PERM)))
>
> Using "." in the allow statement makes strtok_r() return NULL in
> cil_resolve_name() and this result is then used in a call to
> cil_symtab_get_datum(), which is thus invalid.
>
> Instead of crashing, make secilc fail with an error message.
>
> This bug has been found by fuzzing secilc with american fuzzy lop.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/cil/src/cil_resolve_ast.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 917adf8d23da..5b86908c4120 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -4027,7 +4027,13 @@ int cil_resolve_name(struct cil_tree_node *ast_node, char *name, enum cil_sym_in
>  		char *current = strtok_r(name_dup, ".", &sp);
>  		char *next = strtok_r(NULL, ".", &sp);
>  		symtab_t *symtab = NULL;
> -		
> +
> +		if (current == NULL) {
> +			/* Only dots */
> +			cil_tree_log(ast_node, CIL_ERR, "Invalid name %s", name);

I added "free(name_dup);" here when I applied the patch.

Jim

> +			goto exit;
> +		}
> +
>  		node = ast_node;
>  		if (*name == '.') {
>  			/* Leading '.' */
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
