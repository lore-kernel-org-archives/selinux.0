Subject: Re: [PATCH 1/1] libsepol/cil: fix type confusion in cil_copy_ast
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170205141401.18021-1-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <a3084839-6486-c1bd-116e-a1a8535d86f1@tycho.nsa.gov>
Date: Wed, 8 Feb 2017 10:56:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170205141401.18021-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/05/2017 09:14 AM, Nicolas Iooss wrote:
> When running secilc on the following CIL file, the program tries to free
> the data associated with type X using cil_destroy_typeattribute():
>
>     (macro sys_obj_type ((user ARG1)) (typeattribute X))
>
>     (block B
>         (type X)
>         (call sys_obj_type (Y))
>     )
>
> By adding some printf statements to cil_typeattribute_init(),
> cil_type_init() and cil_destroy_typeattribute(), the error message I get
> when using gcc's address sanitizer is:
>
> $ secilc -o /dev/null -f /dev/null test.cil -vvvvvv
> creating TYPE 0x60400000dfd0
> Parsing 2017-02-02_crashing_nulptrderef_cil.cil
> Building AST from Parse Tree
> creating TYPEATTR 0x60600000e420
> creating TYPE 0x60400000df50
> Destroying Parse Tree
> Resolving AST
> Failed to resolve call statement at 2017-02-02_crashing_nulptrderef_cil.cil:5
> Problem at 2017-02-02_crashing_nulptrderef_cil.cil:5
> Pass 8 of resolution failed
> Failed to resolve ast
> Failed to compile cildb: -2
> Destroying TYPEATTR 0x60600000e420, types (nil) name X
> Destroying TYPEATTR 0x60400000df50, types 0xbebebebe00000000 name X
> ASAN:DEADLYSIGNAL
> =================================================================
> ==30684==ERROR: AddressSanitizer: SEGV on unknown address
> 0x000000000000 (pc 0x7fc0539d114a bp 0x7ffc1fbcb300 sp
> 0x7ffc1fbcb2f0 T0)
>     #0 0x7fc0539d1149 in ebitmap_destroy /usr/src/selinux/libsepol/src/ebitmap.c:356
>     #1 0x7fc053b96201 in cil_destroy_typeattribute ../cil/src/cil_build_ast.c:2370
>     #2 0x7fc053b42ea4 in cil_destroy_data ../cil/src/cil.c:616
>     #3 0x7fc053c595bf in cil_tree_node_destroy ../cil/src/cil_tree.c:235
>     #4 0x7fc053c59819 in cil_tree_children_destroy ../cil/src/cil_tree.c:201
>     #5 0x7fc053c59958 in cil_tree_subtree_destroy ../cil/src/cil_tree.c:172
>     #6 0x7fc053c59a27 in cil_tree_destroy ../cil/src/cil_tree.c:165
>     #7 0x7fc053b44fd7 in cil_db_destroy ../cil/src/cil.c:299
>     #8 0x4026a1 in main /usr/src/selinux/secilc/secilc.c:335
>     #9 0x7fc0535e5290 in __libc_start_main (/usr/lib/libc.so.6+0x20290)
>     #10 0x403af9 in _start (/usr/src/selinux/DESTDIR/usr/bin/secilc+0x403af9)
>
> AddressSanitizer can not provide additional info.
> SUMMARY: AddressSanitizer: SEGV /usr/src/selinux/libsepol/src/ebitmap.c:356 in ebitmap_destroy
> ==30684==ABORTING
>
> When copying the AST tree in cil_resolve_call1(),
> __cil_copy_node_helper() calls cil_copy_typeattribute() to grab type X
> in the symbol table of block B, and creates a node with the data of X
> but with CIL_TYPEATTRIBUTE flavor.
>
> This example is a "type confusion" bug between cil_type and
> cil_typeattribute structures. It can be generalized to any couple of
> structures sharing the same symbol table (an easy way of finding other
> couples is by reading the code of cil_flavor_to_symtab_index()).
>
> Fix this issue in a "generic" way in __cil_copy_node_helper(), by
> verifying that the flavor of the found data is the same as expected and
> triggering an error when it is not.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied with one addition. I added the line "new->flavor = FLAVOR(data);" to 
make sure the data flavor matches. I don't think that that is needed because 
cil_destroy_data() will not be called on the new node (since a previous node 
exists), but I would rather be safe and have the flavor match.

Thanks,
Jim

> ---
>  libsepol/cil/src/cil_copy_ast.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
> index 5debd0d5359c..17a8c991c66d 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -1987,6 +1987,13 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
>  		new->data = data;
>
>  		if (orig->flavor >= CIL_MIN_DECLARATIVE) {
> +			/* Check the flavor of data if was found in the destination symtab */
> +			if (DATUM(data)->nodes->head && FLAVOR(data) != orig->flavor) {
> +				cil_tree_log(orig, CIL_ERR, "Incompatible flavor when trying to copy %s", DATUM(data)->name);
> +				cil_tree_log(NODE(data), CIL_ERR, "Note: conflicting declaration");
> +				rc = SEPOL_ERR;
> +				goto exit;
> +			}
>  			rc = cil_symtab_insert(symtab, ((struct cil_symtab_datum*)orig->data)->name, ((struct cil_symtab_datum*)data), new);
>
>  			namespace = new;
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
