From: Steve Lawrence <slawrence@tresys.com>
Subject: Re: [PATCH 3/6] libsepol/cil: Add cil_tree_log() and supporting
 functions
To: James Carter <jwcart2@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
References: <1461075965-17161-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1461075965-17161-4-git-send-email-jwcart2@tycho.nsa.gov>
Message-ID: <57179680.2080100@tresys.com>
Date: Wed, 20 Apr 2016 10:47:28 -0400
MIME-Version: 1.0
In-Reply-To: <1461075965-17161-4-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/19/2016 10:26 AM, James Carter wrote:
> Provide more detailed log messages containing all relevant CIL and
> high-level language source file information through cil_tree_log().
> 
> cil_tree_log() uses two new functions: cil_tree_get_next_path() and
> cil_tree_get_cil_path().
> 
> cil_tree_get_next_path() traverses up the parse tree or AST until
> it finds the next CIL or high-level language source information nodes.
> It will return the path and whether or not the path is for a CIL file.
> 
> cil_tree_get_cil_path() uses cil_tree_get_next_path() to return
> the CIL path.
> 
> Example cil_tree_log() message:
>     Problem at line 21 of policy.cil (from line 11 of foo.hll) (from line 2 of bar.hll)
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  libsepol/cil/src/cil_tree.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
>  libsepol/cil/src/cil_tree.h |  4 +++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> index 6e56dd1..1ccf9f5 100644
> --- a/libsepol/cil/src/cil_tree.c
> +++ b/libsepol/cil/src/cil_tree.c
> @@ -59,6 +59,82 @@ __attribute__((noreturn)) __attribute__((format (printf, 1, 2))) void cil_tree_e
>  	exit(1);
>  }
>  
> +struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **path, int* is_cil)
> +{
> +	if (!node) {
> +		return NULL;
> +	}
> +
> +	node = node->parent;
> +
> +	while (node) {
> +		if (node->flavor == CIL_SRC_INFO) {
> +			/* AST */
> +			struct cil_src_info *info = node->data;
> +			*path = info->path;
> +			*is_cil = info->is_cil;
> +			return node;
> +		} else if (node->flavor == CIL_NODE && node->data == NULL) {
> +			if (node->cl_head->data == CIL_KEY_SRC_INFO) {
> +				/* Parse Tree */
> +				*path = node->cl_head->next->next->data;
> +				*is_cil = (node->cl_head->next->data == CIL_KEY_SRC_CIL);
> +				return node;
> +			}
> +		}
> +		node = node->parent;
> +	}
> +
> +	return NULL;
> +}
> +
> +char *cil_tree_get_cil_path(struct cil_tree_node *node)
> +{
> +	char *path = NULL;
> +	int is_cil;
> +
> +	while (node) {
> +		node = cil_tree_get_next_path(node, &path, &is_cil);
> +		if (node && is_cil) {
> +			return path;
> +		}
> +	}
> +
> +	return NULL;
> +}

Do we need to take into account things like copies from macro calls and
block inherits here? For example, say you inherit a block from another
CIL file. Right now, it looks like this just traverses up the current
node parents until it reaches a node with src_cil node, which isn't
necessarily the CIL file the blockinherit content came from. So the
path/line for a CIL statment will look like is was from what it was
copied into rather than where it was copied from.

> +
> +__attribute__((format (printf, 3, 4))) void cil_tree_log(struct cil_tree_node *node, enum cil_log_level lvl, const char* msg, ...)
> +{
> +	va_list ap;
> +
> +	va_start(ap, msg);
> +	cil_vlog(lvl, msg, ap);
> +	va_end(ap);
> +
> +	if (node) {
> +		char *path = NULL;
> +		int is_cil;
> +		unsigned hll_line = node->hll_line;
> +
> +		path = cil_tree_get_cil_path(node);
> +
> +		if (path != NULL) {

In what cases would path be NULL? Seems like there should always be a
cil path.

> +			cil_log(lvl, " at line %d of %s", node->line, path);
> +		}
> +
> +		while (node) {
> +			node = cil_tree_get_next_path(node, &path, &is_cil);
> +			if (node && !is_cil) {
> +				cil_log(lvl," (from line %d of %s)", hll_line, path);

Minor, but it might be worth condensing this a bit. If there were
multiple levels of HLL includes (which I could easily imagine in some
complex HLLs) this could get pretty long and difficult to read. Perhaps
just something like this?

foo.cil:10 > foo.hll:11 > bar.hll:12

vs

at line 10 of foo.cil (from line 12 of foo.hll) (from line 12 of bar.hll)

> +				path = NULL;
> +				hll_line = node->hll_line;
> +			}
> +		}
> +	}
> +
> +	cil_log(lvl,"\n");
> +}
> +
>  int cil_tree_init(struct cil_tree **tree)
>  {
>  	struct cil_tree *new_tree = cil_malloc(sizeof(*new_tree));
> diff --git a/libsepol/cil/src/cil_tree.h b/libsepol/cil/src/cil_tree.h
> index 43d6b98..318eecd 100644
> --- a/libsepol/cil/src/cil_tree.h
> +++ b/libsepol/cil/src/cil_tree.h
> @@ -51,6 +51,10 @@ struct cil_tree_node {
>  	void *data;
>  };
>  
> +struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **path, int* is_cil);
> +char *cil_tree_get_cil_path(struct cil_tree_node *node);
> +__attribute__((format (printf, 3, 4))) void cil_tree_log(struct cil_tree_node *node, enum cil_log_level lvl, const char* msg, ...);
> +
>  int cil_tree_init(struct cil_tree **tree);
>  void cil_tree_destroy(struct cil_tree **tree);
>  void cil_tree_subtree_destroy(struct cil_tree_node *node);
> 
