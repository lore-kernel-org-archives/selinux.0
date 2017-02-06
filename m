Subject: Re: [PATCH 1/8] libsepol: fix -Wwrite-strings warnings
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170205155820.29157-1-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <9c8fea99-e280-8958-1b14-d7aa61db2709@tycho.nsa.gov>
Date: Mon, 6 Feb 2017 13:00:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170205155820.29157-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/05/2017 10:58 AM, Nicolas Iooss wrote:
> When compiling with -Wwrite-strings, clang reports some warnings like:
>
>     module_to_cil.c:784:13: error: assigning to 'char *' from 'const
>     char [5]' discards qualifiers
>     [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>                     statement = "type";
>                               ^ ~~~~~~
>     module_to_cil.c:787:13: error: assigning to 'char *' from 'const
>     char [5]' discards qualifiers
>     [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>                     statement = "role";
>                               ^ ~~~~~~
>
> Add a const type attribute to local variables which only handle constant
> strings.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied all of these except for patch 3, which I used the patch that I posted in 
response.

Thanks,
Jim

> ---
>  libsepol/cil/src/cil_binary.c |  4 ++--
>  libsepol/cil/src/cil_policy.c | 18 +++++++++---------
>  libsepol/src/module_to_cil.c  |  2 +-
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 19cbc1b87c1e..ac371aef7b2d 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -1923,7 +1923,7 @@ static void __cil_expr_to_string(struct cil_list *expr, enum cil_flavor flavor,
>  				cil_asprintf(out, "%s %s", CIL_KEY_NOT, s1);
>  				free(s1);
>  			} else {
> -				char *opstr = "";
> +				const char *opstr = "";
>
>  				__cil_expr_to_string_helper(curr->next->next, flavor, &s2);
>
> @@ -4376,7 +4376,7 @@ static void __cil_print_classperm(struct cil_list *cp_list)
>
>  static void __cil_print_permissionx(struct cil_permissionx *px)
>  {
> -	char *kind_str = "";
> +	const char *kind_str = "";
>  	char *expr_str;
>
>  	switch (px->kind) {
> diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
> index bb832f250db7..2e6814a60eae 100644
> --- a/libsepol/cil/src/cil_policy.c
> +++ b/libsepol/cil/src/cil_policy.c
> @@ -183,7 +183,7 @@ static void cil_gather_statements(struct cil_tree_node *start, struct cil_list *
>  	cil_tree_walk(start, __cil_gather_statements_helper, NULL, NULL, lists);
>  }
>
> -static void cil_simple_rules_to_policy(FILE *out, struct cil_list *rules, char *kind)
> +static void cil_simple_rules_to_policy(FILE *out, struct cil_list *rules, const char *kind)
>  {
>  	struct cil_list_item *i1;
>
> @@ -194,7 +194,7 @@ static void cil_simple_rules_to_policy(FILE *out, struct cil_list *rules, char *
>
>  static void cil_cats_to_policy(FILE *out, struct cil_cats *cats)
>  {
> -	char *lead = "";
> +	const char *lead = "";
>  	struct cil_cat *first = NULL, *last = NULL, *cat;
>  	struct cil_list_item *i1;
>
> @@ -471,7 +471,7 @@ static char *__cil_cons_leaf_operand_to_string(struct cil_db *db, struct cil_lis
>  {
>  	struct cil_list_item *i1;
>  	enum cil_flavor flavor = operand->flavor;
> -	char *o_str;
> +	const char *o_str;
>  	size_t o_len;
>
>  	if (flavor == CIL_CONS_OPERAND) {
> @@ -559,7 +559,7 @@ static char *__cil_cons_leaf_operand_to_string(struct cil_db *db, struct cil_lis
>  static char *__cil_cons_leaf_op_to_string(struct cil_list_item *op, char *new)
>  {
>  	enum cil_flavor flavor = (enum cil_flavor)op->data;
> -	char *op_str;
> +	const char *op_str;
>  	size_t len;
>
>  	switch (flavor) {
> @@ -1009,7 +1009,7 @@ static void cil_bools_to_policy(FILE *out, struct cil_list *bools)
>  {
>  	struct cil_list_item *i1;
>  	struct cil_bool *bool;
> -	char *value;
> +	const char *value;
>
>  	cil_list_for_each(i1, bools) {
>  		bool = i1->data;
> @@ -1108,7 +1108,7 @@ static void cil_xperms_to_policy(FILE *out, struct cil_permissionx *permx)
>  	ebitmap_node_t *node;
>  	unsigned int i, first = 0, last = 0;
>  	int need_first = CIL_TRUE, need_last = CIL_TRUE;
> -	char *kind;
> +	const char *kind;
>
>  	if (permx->kind == CIL_PERMX_KIND_IOCTL) {
>  		kind = "ioctl";
> @@ -1156,7 +1156,7 @@ static void cil_xperms_to_policy(FILE *out, struct cil_permissionx *permx)
>
>  static void cil_av_rulex_to_policy(FILE *out, struct cil_avrule *rule)
>  {
> -	char *kind;
> +	const char *kind;
>  	struct cil_symtab_datum *src, *tgt;
>
>  	src = rule->src;
> @@ -1187,7 +1187,7 @@ static void cil_av_rulex_to_policy(FILE *out, struct cil_avrule *rule)
>
>  static void cil_av_rule_to_policy(FILE *out, struct cil_avrule *rule)
>  {
> -	char *kind;
> +	const char *kind;
>  	struct cil_symtab_datum *src, *tgt;
>  	struct cil_list *classperms_strs;
>  	struct cil_list_item *i1;
> @@ -1225,7 +1225,7 @@ static void cil_av_rule_to_policy(FILE *out, struct cil_avrule *rule)
>
>  static void cil_type_rule_to_policy(FILE *out, struct cil_type_rule *rule)
>  {
> -	char *kind;
> +	const char *kind;
>  	struct cil_symtab_datum *src, *tgt, *res;
>  	struct cil_list *class_list;
>  	struct cil_list_item *i1;
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 2acb600dddae..8c4fff9c3d9f 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -775,7 +775,7 @@ static int cil_print_attr_strs(int indent, struct policydb *pdb, int is_type, st
>  	int rc = 0;
>  	struct ebitmap_node *node;
>  	unsigned int i;
> -	char *statement;
> +	const char *statement;
>  	int has_positive = pos && (ebitmap_cardinality(pos) > 0);
>  	int has_negative = neg && (ebitmap_cardinality(neg) > 0);
>  	char **val_to_name;
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
