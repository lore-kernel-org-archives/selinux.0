Subject: Re: [PATCH v3] module_to_cil: fix possible use of initialized value
To: <william.c.roberts@intel.com>, <selinux@tycho.nsa.gov>,
 <seandroid-list@tycho.nsa.gov>, <sds@tycho.nsa.gov>
References: <1470329224-17870-1-git-send-email-william.c.roberts@intel.com>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <0fbd1c81-eaba-478c-19d2-6d1ed4704a2a@tresys.com>
Date: Fri, 5 Aug 2016 07:42:55 -0400
MIME-Version: 1.0
In-Reply-To: <1470329224-17870-1-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/04/2016 12:47 PM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> Correct errors like these reported by gcc:
> 
> module_to_cil.c: In function ‘block_to_cil’:
> module_to_cil.c:229:20: error: ‘attr_list’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   struct list_node *curr = (*attr_list)->head;
> 
> Usages of attr_list_destroy() were called when list_init()
> fails.
> 
> stack_init() and stack_destroy() also suffered from the
> aforementioned issue.
> 
> To correct the issue, initialize stack and list variables to
> NULL.
> 
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Applied. Thanks!

- Steve

> ---
>  libsepol/src/module_to_cil.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index b9a4af7..c74f357 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -1303,11 +1303,11 @@ static int cond_list_to_cil(int indent, struct policydb *pdb, struct cond_node *
>  {
>  	int rc = -1;
>  	struct cond_node *cond;
> -	struct list *attr_list;
> +	struct list *attr_list = NULL;
>  
>  	rc = list_init(&attr_list);
>  	if (rc != 0) {
> -		goto exit;
> +		goto exit;;
>  	}
>  
>  	for (cond = cond_list; cond != NULL; cond = cond->next) {
> @@ -3482,7 +3482,7 @@ static int block_to_cil(struct policydb *pdb, struct avrule_block *block, struct
>  {
>  	int rc = -1;
>  	struct avrule_decl *decl;
> -	struct list *attr_list;
> +	struct list *attr_list = NULL;
>  
>  	decl = block->branch_list;
>  
> @@ -3631,7 +3631,7 @@ static int blocks_to_cil(struct policydb *pdb)
>  	int rc = -1;
>  	struct avrule_block *block;
>  	int indent = 0;
> -	struct stack *stack;
> +	struct stack *stack = NULL;
>  
>  	rc = stack_init(&stack);
>  	if (rc != 0) {
> @@ -3699,7 +3699,7 @@ static int linked_blocks_to_cil(struct policydb *pdb)
>  	// Since it is linked, all optional blocks have been resolved
>  	int rc = -1;
>  	struct avrule_block *block;
> -	struct stack *stack;
> +	struct stack *stack = NULL;
>  
>  	rc = stack_init(&stack);
>  	if (rc != 0) {
> 
