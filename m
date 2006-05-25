Subject: Re: Bugs with bool_ids usage (libsepol)
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Cedric Roux <Cedric.Roux@eurecom.fr>, selinux@tycho.nsa.gov
In-Reply-To: <1148569615.20976.110.camel@moss-spartans.epoch.ncsc.mil>
References: <Pine.LNX.4.44.0605101702540.19909-100000@perignan.eurecom.fr>
	 <1147283537.22880.52.camel@jackjack.columbia.tresys.com>
	 <1148569615.20976.110.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 25 May 2006 11:24:21 -0400
Message-Id: <1148570661.10246.27.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-05-25 at 11:06 -0400, Stephen Smalley wrote:
> On Wed, 2006-05-10 at 13:52 -0400, Karl MacMillan wrote:
> > On Wed, 2006-05-10 at 17:17 +0200, Cedric Roux wrote:
> > > Dear SELinux people,
> > > 
> > > there is a bug with the way you handle bool_ids in libsepol.
> > > For example, we see this code:
> > >         for (i = 0; i < needle->nbools; i++)
> > >                 new_node->bool_ids[i] = needle->bool_ids[i];
> > > in libsepol-1.12/src/conditional.c:cond_node_find
> > > The only problem is that bool_ids is defined as:
> > >         uint32_t bool_ids[COND_MAX_BOOLS];
> > > with:
> > > #define COND_MAX_BOOLS 5
> > > in libsepol-1.12/include/sepol/policydb/conditional.h
> > > 
> > > But we have that nbools may be bigger than COND_MAX_BOOLS.
> > > That would result in a funny behavior if someone somewhere
> > > on this little planet decided to put more than COND_MAX_BOOLS
> > > boolean variables in an if statement, don't you think?
> > > 
> > > I tried to do some tests.
> > > 
> > > With something like (manipulating policy.conf from refpolicy):
> > >     if (ftpd_is_daemon && secure_mode && secure_mode_insmod && 
> > >         allow_cvs_read_shadow && allow_execmem && allow_kerberos && 
> > >         allow_smbd_anon_write && allow_ypbind && allow_execmod) {
> > >            DO_SOMETHING
> > >     }
> > > checkpolicy crashes on a malloc (so I need 9 boolean variables for a
> > > malloc to be very unhappy with the state of the heap).
> > > 
> > > You should do something about this I think.
> > > 
> > > I didn't get the point with the bool_ids yet, so I don't know
> > > how to fix that. Maybe do something like:
> > >         for (i = 0; i < min(needle->nbools, COND_MAX_BOOLS); i++)
> > > is the solution, maybe not. It's up to you!
> > > 
> > > Anyway you will need to check every usage of bool_ids.
> > > 
> > 
> > Thanks for the bug report. The code in question is making an incorrect
> > assumption about what COND_MAX_BOOLS is used for. That vaguely named
> > define is not intended to limit the number of unique booleans in a
> > conditional expression. The only limit in conditional expressions should
> > be the stack depth.
> > 
> > I should be able to get a patch to fix this out sometime soon.
> 
> Patch below has been committed to the selinux sourceforge tree.
> 

What about this patch instead - it seems to make the usage of nbools and
bool_ids more natural and potentially improves the comparison speed for
larger conditionals.

Karl

diff --exclude=.svn
-pruN ../../trunk/libsepol/include/sepol/policydb/conditional.h ./libsepol/include/sepol/policydb/conditional.h
--- ../../trunk/libsepol/include/sepol/policydb/conditional.h	2006-05-08
10:46:39.000000000 -0400
+++ ./libsepol/include/sepol/policydb/conditional.h	2006-05-25
10:49:45.000000000 -0400
@@ -28,14 +28,6 @@
 
 #define COND_EXPR_MAXDEPTH 10
 
-/* this is the max unique bools in a conditional expression
- * for which we precompute all outcomes for the expression.
- *
- * NOTE - do _NOT_ use value greater than 5 because
- * cond_node_t->expr_pre_comp can only hold at most 32 values
- */
-#define COND_MAX_BOOLS 5
-
 /*
  * A conditional expression is a list of operators and operands
  * in reverse polish notation.
@@ -82,7 +74,7 @@ typedef struct cond_node {
 	avrule_t *avfalse_list;
 	/* these fields are not written to binary policy */
 	unsigned int nbools;
-	uint32_t bool_ids[COND_MAX_BOOLS];
+	uint32_t *bool_ids;
 	uint32_t expr_pre_comp;
 	/*                                               */
 	struct cond_node *next;
diff --exclude=.svn
-pruN ../../trunk/libsepol/src/conditional.c ./libsepol/src/conditional.c
--- ../../trunk/libsepol/src/conditional.c	2006-05-08 10:46:39.000000000
-0400
+++ ./libsepol/src/conditional.c	2006-05-25 11:14:48.000000000 -0400
@@ -26,6 +26,13 @@
 
 #include "private.h"
 
+/* this is the max unique bools in a conditional expression
+ * for which we precompute all outcomes for the expression.
+ *
+ * NOTE - do _NOT_ use value greater than 5 because
+ * cond_node_t->expr_pre_comp can only hold at most 32 values
+ */
+#define COND_MAX_BOOLS 5
 
 /* move all type rules to top of t/f lists to help kernel on evaluation
*/
 static void cond_optimize(cond_av_list_t **l) {
@@ -58,28 +65,31 @@ void cond_optimize_lists(cond_list_t* cl
 }
 
 
-static int bool_present(unsigned int target, unsigned int bools[],
unsigned int num_bools) {
+static int bool_present(uint32_t target, uint32_t *bools, unsigned int
num_bools) {
 	unsigned int i = 0;
-	int ret = 1;
 
-	if (num_bools > COND_MAX_BOOLS) {
+	if (bools == NULL)
 		return 0;
+
+	for (i = 0; i < num_bools; i++) {
+		if (target == bools[i])
+			return 1;
 	}
-	while( i < num_bools && target != bools[i]) i++;
-	if (i == num_bools) ret = 0; /* got to end w/o match */
-	return ret;
+	return 0;
 }
 
 static int same_bools(cond_node_t *a, cond_node_t *b) {
-	unsigned int i, x;
+	unsigned int i;
 	
-	x = a->nbools;
-
 	/* same number of bools? */
-	if (x != b->nbools) return 0;
+	if (a->nbools != b->nbools)
+		return 0;
 
 	/* make sure all the bools in a are also in b */
-	for(i = 0; i < x; i++) if (!bool_present(a->bool_ids[i], b->bool_ids,
x)) return 0;
+	for(i = 0; i < a->nbools; i++) {
+		if (!bool_present(a->bool_ids[i], b->bool_ids, b->nbools))
+			return 0;
+	}
 	return 1;
 }
 
@@ -93,18 +103,24 @@ int cond_expr_equal(cond_node_t *a, cond
 	if (a == NULL || b == NULL)
 		return 0;
 
-	if(a->nbools != b->nbools) return 0;
+	if (a->nbools != b->nbools)
+		return 0;
 
 	/* if exprs have <= COND_MAX_BOOLS we can check the precompute values
 	 * for the expressions.
 	 */
-	if (a->nbools <= COND_MAX_BOOLS && b->nbools <= COND_MAX_BOOLS)	    
-	{
-		if(!same_bools(a,b)) return 0;
+	if (a->nbools <= COND_MAX_BOOLS && b->nbools <= COND_MAX_BOOLS)	{
+		if(!same_bools(a,b))
+			return 0;
 		return (a->expr_pre_comp == b->expr_pre_comp);
 	}
 
-	/* for long expressions we check for exactly the same expression */
+	/* For long expressions first make certain that they have the same
+	 * booleans and then compare the expressions.
+	 */
+	if (!same_bools(a,b))
+	    return 0;
+
 	cur_a = a->expr;
 	cur_b = b->expr;
 	while (1) {
@@ -155,6 +171,12 @@ cond_node_t *cond_node_find(policydb_t *
 	}
         new_node->cur_state = cond_evaluate_expr(p, new_node->expr);
         new_node->nbools = needle->nbools;
+	new_node->bool_ids = (uint32_t*)malloc(new_node->nbools *
sizeof(uint32_t));
+	if (new_node->bool_ids == NULL) {
+		cond_expr_destroy(new_node->expr);
+		free(new_node);
+		return NULL;
+	}
         for (i = 0; i < needle->nbools; i++)
                 new_node->bool_ids[i] = needle->bool_ids[i];
         new_node->expr_pre_comp = needle->expr_pre_comp;
@@ -321,14 +343,13 @@ int cond_normalize_expr(policydb_t *p, c
 {
 	cond_expr_t *ne,*e;
 	cond_av_list_t *tmp;
-	unsigned int i, j, orig_value[COND_MAX_BOOLS];
+	uint32_t i, j, *orig_value;
 	int k;
 	uint32_t test = 0x0;
 	avrule_t *tmp2;
 
 	cn->nbools = 0;
-
-	memset(cn->bool_ids, 0,sizeof(cn->bool_ids) );
+	cn->bool_ids = NULL;
 	cn->expr_pre_comp = 0x0;
 
 	/* take care of !expr case */
@@ -365,11 +386,13 @@ int cond_normalize_expr(policydb_t *p, c
 			i = 0;
 			/* see if we've already seen this bool */
 			if (!bool_present(e->bool, cn->bool_ids, cn->nbools)) {
-				/* count em all but only record up to COND_MAX_BOOLS */
-				if (cn->nbools < COND_MAX_BOOLS)
-					cn->bool_ids[cn->nbools++] = e->bool;
-				else
-					cn->nbools++;
+				cn->bool_ids = (uint32_t*)realloc(cn->bool_ids,
+								  (cn->nbools + 1) * sizeof(uint32_t));
+				if (cn->bool_ids == NULL) {
+					fprintf(stderr, "Out of memory\n");
+					return -1;
+				}
+				cn->bool_ids[cn->nbools++] = e->bool;
 			}
 			break;
 		default:
@@ -379,6 +402,11 @@ int cond_normalize_expr(policydb_t *p, c
  
 	/* only precompute for exprs with <= COND_AX_BOOLS */
 	if (cn->nbools <=  COND_MAX_BOOLS) {
+		orig_value = (uint32_t*)malloc(cn->nbools * sizeof(uint32_t));
+		if (orig_value == NULL) {
+			fprintf(stderr, "memory error\n");
+			return -1;
+		}
 		/* save the default values for the bools so we can play with them */
 		for(i = 0; i < cn->nbools; i++) {
 			orig_value[i] = p->bool_val_to_struct[cn->bool_ids[i] - 1]->state;
@@ -404,7 +432,9 @@ int cond_normalize_expr(policydb_t *p, c
 		
 		/* restore bool default values */
 		for(i = 0; i < cn->nbools; i++)
-			p->bool_val_to_struct[cn->bool_ids[i] - 1]->state = orig_value[i] ;
+			p->bool_val_to_struct[cn->bool_ids[i] - 1]->state = orig_value[i];
+		
+		free(orig_value);
 	}
 	return 0;
 }
@@ -460,6 +490,7 @@ void cond_node_destroy(cond_node_t *node
 		return;
 
 	cond_expr_destroy(node->expr);
+	free(node->bool_ids);
         avrule_list_destroy(node->avtrue_list);
         avrule_list_destroy(node->avfalse_list);
 	cond_av_list_destroy(node->true_list);


> Index: libsepol/src/conditional.c
> ===================================================================
> RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/conditional.c,v
> retrieving revision 1.15
> diff -u -p -r1.15 conditional.c
> --- libsepol/src/conditional.c	5 May 2006 18:54:47 -0000	1.15
> +++ libsepol/src/conditional.c	25 May 2006 13:36:41 -0000
> @@ -26,6 +26,8 @@
>  
>  #include "private.h"
>  
> +#undef min
> +#define min(a,b) (((a) < (b)) ? (a) : (b))
>  
>  /* move all type rules to top of t/f lists to help kernel on evaluation */
>  static void cond_optimize(cond_av_list_t **l) {
> @@ -155,7 +157,7 @@ cond_node_t *cond_node_find(policydb_t *
>  	}
>          new_node->cur_state = cond_evaluate_expr(p, new_node->expr);
>          new_node->nbools = needle->nbools;
> -        for (i = 0; i < needle->nbools; i++)
> +        for (i = 0; i < min(needle->nbools, COND_MAX_BOOLS); i++)
>                  new_node->bool_ids[i] = needle->bool_ids[i];
>          new_node->expr_pre_comp = needle->expr_pre_comp;
>          new_node->true_list = NULL;
> Index: libsepol/src/link.c
> ===================================================================
> RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/link.c,v
> retrieving revision 1.18
> diff -u -p -r1.18 link.c
> --- libsepol/src/link.c	28 Apr 2006 18:34:46 -0000	1.18
> +++ libsepol/src/link.c	25 May 2006 13:36:23 -0000
> @@ -33,6 +33,9 @@
>  
>  #include "debug.h"
>  
> +#undef min
> +#define min(a,b) (((a) < (b)) ? (a) : (b))
> +
>  typedef struct policy_module {
>          policydb_t *policy;
>          uint32_t num_decls;
> @@ -1017,7 +1020,7 @@ static int copy_cond_list(cond_node_t *l
>                          cur_expr->bool = module->map[SYM_BOOLS][cur_expr->bool - 1];
>                  }
>                  new_node->nbools = cur->nbools;
> -                for (i = 0; i < cur->nbools; i++) {
> +                for (i = 0; i < min(cur->nbools, COND_MAX_BOOLS); i++) {
>                          uint32_t remapped_id = module->map[SYM_BOOLS][cur->bool_ids[i] - 1];
>                          assert(remapped_id != 0);
>                          new_node->bool_ids[i] = remapped_id;
> 
> 
-- 
Karl MacMillan
Tresys Technology
www.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
