Subject: Re: [PATCH 1/1] libsepol/cil: avoid freeing uninitialized values
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170317213040.21714-1-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <a972f7b3-786e-b1ff-6d70-acaa2a34e260@tycho.nsa.gov>
Date: Tue, 21 Mar 2017 14:28:42 -0400
MIME-Version: 1.0
In-Reply-To: <20170317213040.21714-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/17/2017 05:30 PM, Nicolas Iooss wrote:
> cil_resolve_ast() begins by checking whether one of its parameters is
> NULL and "goto exit;" when it is the case. As extra_args has not been
> initialized there, this leads to calling cil_destroy_tree_node_stack(),
> __cil_ordered_lists_destroy()... on garbage values.
>
> In practise this cannot happen because cil_resolve_ast() is only called
> by cil_compile() after cil_build_ast() succeeded. As the if condition
> exists nonetheless, fix the body of the if block in order to silence a
> warning reported by clang Static Analyzer.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied.

Thanks,
Jim

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 87817ca29a5f..187050116379 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -3797,7 +3797,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
>  	uint32_t changed = 0;
>
>  	if (db == NULL || current == NULL) {
> -		goto exit;
> +		return rc;
>  	}
>
>  	extra_args.db = db;
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
