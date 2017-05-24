Message-ID: <1495660470.15706.1.camel@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] libsepol: make role_list_destroy() do nothing when
 role_list is NULL
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Wed, 24 May 2017 17:14:30 -0400
In-Reply-To: <20170522214555.9052-1-nicolas.iooss@m4x.org>
References: <20170522214555.9052-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-05-22 at 23:45 +0200, Nicolas Iooss wrote:
> When a function called by sepol_module_policydb_to_cil() fails before
> role_list_create() has been called, role_list is still NULL but is
> dereferenced in role_list_destroy(). Here is a gdb session on hll/pp:
> 
>     Unknown value for handle-unknown: 6
> 
>     Program received signal SIGSEGV, Segmentation fault.
>     0x00007ffff7a68a37 in role_list_destroy () at module_to_cil.c:215
>     215     struct list_node *curr = role_list->head;
> 
>     (gdb) bt
>     #0  0x00007ffff7a68a37 in role_list_destroy () at
>     module_to_cil.c:215
>     #1  sepol_module_policydb_to_cil (fp=fp@entry=0x7ffff79925e0
>     <_IO_2_1_stdout_>, pdb=<optimized out>, linked=linked@entry=0) at
>     module_to_cil.c:4060
>     #2  0x00007ffff7a6ac75 in sepol_module_package_to_cil
>     (fp=fp@entry=0x7ffff79925e0 <_IO_2_1_stdout_>, mod_pkg=0x604280)
> at
>     module_to_cil.c:4080
>     #3  0x0000000000401a58 in main (argc=<optimized out>,
>     argv=<optimized out>) at pp.c:150
> 
> This issue has been found while fuzzing hll/pp with the American
> Fuzzy
> Lop.

Thanks, applied.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/module_to_cil.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/libsepol/src/module_to_cil.c
> b/libsepol/src/module_to_cil.c
> index 7d8eb204d2fd..c989830a198c 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -211,7 +211,12 @@ static void list_destroy(struct list **list)
>  
>  static void role_list_destroy(void)
>  {
> -	struct list_node *curr = role_list->head;
> +	struct list_node *curr;
> +
> +	if (role_list == NULL) {
> +		return;
> +	}
> +	curr = role_list->head;
>  
>  	while (curr != NULL) {
>  		free(curr->data);
