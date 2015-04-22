Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3MKrkuB010340
 for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2015 16:53:46 -0400
Received: by iebrs15 with SMTP id rs15so47160888ieb.3
 for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2015 13:53:43 -0700 (PDT)
From: Jeff Vander Stoep <jeffv@google.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Add support for ioctl command whitelisting
Date: Wed, 22 Apr 2015 13:53:25 -0700
Message-Id: <1429736005-30200-1-git-send-email-jeffv@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Adds support for new policy statements whitelisting individual ioctl
commands. Ioctls provide many of the operations necessary for driver control.
The typical driver supports a device specific set of operations accessible
by the ioctl system call and specified by the command argument. SELinux
provides per operation access control to many system operations e.g. chown,
kill, setuid, ipc_lock, etc. Ioclts on the other hand are granted on a per
file descriptor basis using the ioctl permission, meaning that the set of
operations provided by the driver are granted on an all-or-nothing basis.
In some cases this may be acceptable, but often the same driver provides a
large and diverse set of operations such as benign and necessary functionality
as well as dangerous capabilities or access to system information that should
be restricted.

Example policy:
allow <source> <target>:<class> { 0x8900-0x8905 0x8910 }
auditallow <source> <target>:<class> 0x8901

The ioctl permission is still required in order to make an ioctl call. If no
individual ioctl commands are specified, only the ioctl permission is
checked by the kernel - i.e. status quo. This allows ioctl whitelisting to
done in a targeted manner, protecting desired drivers without requiring every
ioctl command to be known and specified before use and otherwise allowing
existing policy to be used as-is.

This only implements ioctl whitelisting support for monolithic kernel policies
built via checkpolicy. Support for modules and CIL remains to be done.

Bug: 19419509
Change-Id: I198e8c9279b94d8ce4ae5625018daa99577ee970
Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 checkpolicy/policy_define.c                | 615 +++++++++++++++++++++++++++++
 checkpolicy/policy_define.h                |   2 +-
 checkpolicy/policy_parse.y                 |  34 ++
 libsepol/include/sepol/policydb/avtab.h    |  37 +-
 libsepol/include/sepol/policydb/policydb.h |  39 +-
 libsepol/src/avtab.c                       |  66 +++-
 libsepol/src/expand.c                      | 109 ++++-
 libsepol/src/policydb.c                    |   2 +-
 libsepol/src/write.c                       |  35 +-
 9 files changed, 886 insertions(+), 53 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index de01f6f..093bded 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -40,6 +40,7 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <inttypes.h>
+#include <ctype.h>
 
 #include <sepol/policydb/expand.h>
 #include <sepol/policydb/policydb.h>
@@ -1727,6 +1728,619 @@ avrule_t *define_cond_pol_list(avrule_t * avlist, avrule_t * sl)
 	return sl;
 }
 
+#define operation_perm_test(x, p) (1 & (p[x >> 5] >> (x & 0x1f)))
+#define operation_perm_set(x, p) (p[x >> 5] |= (1 << (x & 0x1f)))
+#define operation_perm_clear(x, p) (p[x >> 5] &= ~(1 << (x & 0x1f)))
+
+typedef struct av_operations_range {
+	uint16_t low;
+	uint16_t high;
+} av_operations_range_t;
+
+struct av_operations_range_list {
+	uint8_t omit;
+	av_operations_range_t range;
+	struct av_operations_range_list *next;
+};
+
+int avrule_sort_operations(
+		struct av_operations_range_list **rangehead)
+{
+	struct av_operations_range_list *r, *r2, *sorted, *sortedhead = NULL;
+
+	/* order list by range.low */
+	for (r = *rangehead; r != NULL; r = r->next) {
+		sorted = malloc(sizeof(struct av_operations_range_list));
+		if (sorted == NULL)
+			goto error;
+		memcpy(sorted, r, sizeof(struct av_operations_range_list));
+		sorted->next = NULL;
+		if (sortedhead == NULL) {
+			sortedhead = sorted;
+			continue;
+		}
+	        for (r2 = sortedhead; r2 != NULL; r2 = r2->next) {
+			if (sorted->range.low < r2->range.low) {
+				/* range is the new head */
+				sorted->next = r2;
+				sortedhead = sorted;
+				break;
+			} else if ((r2 ->next != NULL) &&
+					(r->range.low < r2->next->range.low)) {
+				/* insert range between elements */
+				sorted->next = r2->next;
+				r2->next = sorted;
+				break;
+			} else if (r2->next == NULL) {
+				/* range is the new tail*/
+				r2->next = sorted;
+				break;
+			}
+		}
+	}
+
+	r = *rangehead;
+	while (r != NULL) {
+		r2 = r;
+		r = r->next;
+		free(r2);
+	}
+	*rangehead = sortedhead;
+	return 0;
+error:
+	yyerror("out of memory");
+	return -1;
+}
+
+int avrule_merge_operations(struct av_operations_range_list **rangehead)
+{
+	struct av_operations_range_list *r, *tmp;
+	r = *rangehead;
+	while (r != NULL && r->next != NULL) {
+		/* merge */
+		if ((r->range.high + 1) >= r->next->range.low) {
+			/* keep the higher of the two */
+			if (r->range.high < r->next->range.high)
+				r->range.high = r->next->range.high;
+			tmp = r->next;
+			r->next = r->next->next;
+			free(tmp);
+			continue;
+		}
+		r = r->next;
+	}
+	return 0;
+}
+
+int avrule_read_operations(struct av_operations_range_list **rangehead)
+{
+	char *id;
+	struct av_operations_range_list *rnew, *r = NULL;
+	*rangehead = NULL;
+	uint8_t omit = 0;
+
+	/* read in all the operations */
+	while ((id = queue_remove(id_queue))) {
+		if (strcmp(id,"~") == 0) {
+			/* these are values to be omitted */
+			free(id);
+			omit = 1;
+		} else if (strcmp(id,"-") == 0) {
+			/* high value of range */
+			free(id);
+			id = queue_remove(id_queue);
+			r->range.high = (uint16_t) strtoul(id,NULL,0);
+			if (r->range.high < r->range.low) {
+				yyerror("Ioctl ranges must be in ascending order.");
+				return -1;
+			}
+			free(id);
+		} else {
+			/* read in new low value */
+			rnew = malloc(sizeof(struct av_operations_range_list));
+			if (rnew == NULL)
+				goto error;
+			rnew->next = NULL;
+			if (*rangehead == NULL) {
+				*rangehead = rnew;
+				r = *rangehead;
+			} else {
+				r->next = rnew;
+				r = r->next;
+			}
+			rnew->range.low = (uint16_t) strtoul(id,NULL,0);
+			rnew->range.high = rnew->range.low;
+			free(id);
+		}
+	}
+	r = *rangehead;
+	r->omit = omit;
+	return 0;
+error:
+	yyerror("out of memory");
+	return -1;
+}
+
+/* flip to included ranges */
+int avrule_omit_operations(struct av_operations_range_list **rangehead)
+{
+	struct av_operations_range_list *rnew, *r, *newhead, *r2;
+
+	rnew = calloc(1, sizeof(struct av_operations_range_list));
+	if (!rnew)
+		goto error;
+
+	newhead = rnew;
+
+	r = *rangehead;
+	r2 = newhead;
+
+	if (r->range.low == 0) {
+		r2->range.low = r->range.high + 1;
+		r = r->next;
+	} else {
+		r2->range.low = 0;
+	}
+
+	while (r) {
+		r2->range.high = r->range.low - 1;
+		rnew = calloc(1, sizeof(struct av_operations_range_list));
+		if (!rnew)
+			goto error;
+		r2->next = rnew;
+		r2 = r2->next;
+
+		r2->range.low = r->range.high + 1;
+		if (!r->next)
+			r2->range.high = 0xffff;
+		r = r->next;
+	}
+
+	r = *rangehead;
+	while (r != NULL) {
+		r2 = r;
+		r = r->next;
+		free(r2);
+	}
+	*rangehead = newhead;
+	return 0;
+
+error:
+	yyerror("out of memory");
+	return -1;
+}
+
+int avrule_operation_ranges(struct av_operations_range_list **rangelist)
+{
+	struct av_operations_range_list *rangehead;
+	uint8_t omit;
+
+	/* read in ranges to include and omit */
+	if (avrule_read_operations(&rangehead))
+		return -1;
+	omit = rangehead->omit;
+	if (rangehead == NULL) {
+		yyerror("error processing ioctl operations");
+		return -1;
+	}
+	/* sort and merge the input operations */
+	if (avrule_sort_operations(&rangehead))
+		return -1;
+	if (avrule_merge_operations(&rangehead))
+		return -1;
+	/* flip ranges if these are ommited*/
+	if (omit) {
+		if (avrule_omit_operations(&rangehead))
+			return -1;
+	}
+
+	*rangelist = rangehead;
+	return 0;
+}
+
+int define_te_avtab_operation_helper(int which, avrule_t ** rule)
+{
+	char *id;
+	class_perm_node_t *perms, *tail = NULL, *cur_perms = NULL;
+	ebitmap_t tclasses;
+	ebitmap_node_t *node;
+	avrule_t *avrule;
+	unsigned int i;
+	int add = 1, ret = 0;
+
+	avrule = (avrule_t *) malloc(sizeof(avrule_t));
+	if (!avrule) {
+		yyerror("out of memory");
+		ret = -1;
+		goto out;
+	}
+	avrule_init(avrule);
+	avrule->specified = which;
+	avrule->line = policydb_lineno;
+	avrule->source_line = source_lineno;
+	avrule->source_filename = strdup(source_file);
+	avrule->ops = NULL;
+	if (!avrule->source_filename) {
+		yyerror("out of memory");
+		return -1;
+	}
+
+	while ((id = queue_remove(id_queue))) {
+		if (set_types
+		    (&avrule->stypes, id, &add,
+		     which == AVRULE_NEVERALLOW ? 1 : 0)) {
+			ret = -1;
+			goto out;
+		}
+	}
+	add = 1;
+	while ((id = queue_remove(id_queue))) {
+		if (strcmp(id, "self") == 0) {
+			free(id);
+			avrule->flags |= RULE_SELF;
+			continue;
+		}
+		if (set_types
+		    (&avrule->ttypes, id, &add,
+		     which == AVRULE_NEVERALLOW ? 1 : 0)) {
+			ret = -1;
+			goto out;
+		}
+	}
+
+	ebitmap_init(&tclasses);
+	ret = read_classes(&tclasses);
+	if (ret)
+		goto out;
+
+	perms = NULL;
+	ebitmap_for_each_bit(&tclasses, node, i) {
+		if (!ebitmap_node_get_bit(node, i))
+			continue;
+		cur_perms =
+		    (class_perm_node_t *) malloc(sizeof(class_perm_node_t));
+		if (!cur_perms) {
+			yyerror("out of memory");
+			ret = -1;
+			goto out;
+		}
+		class_perm_node_init(cur_perms);
+		cur_perms->tclass = i + 1;
+		if (!perms)
+			perms = cur_perms;
+		if (tail)
+			tail->next = cur_perms;
+		tail = cur_perms;
+	}
+
+	ebitmap_destroy(&tclasses);
+
+	avrule->perms = perms;
+	*rule = avrule;
+
+out:
+	return ret;
+}
+
+/* index of the u32 containing the permission */
+#define OP_IDX(x) (x >> 5)
+/* set bits 0 through x-1 within the u32 */
+#define OP_SETBITS(x) ((1 << (x & 0x1f)) - 1)
+/* low value for this u32 */
+#define OP_LOW(x) (x << 5)
+/* high value for this u32 */
+#define OP_HIGH(x) (((x + 1) << 5) - 1)
+void avrule_operation_setrangebits(uint16_t low, uint16_t high, av_operations_t *ops)
+{
+	unsigned int i;
+	uint16_t h = high + 1;
+	/* for each u32 that this low-high range touches, set type permissions */
+	for (i = OP_IDX(low); i <= OP_IDX(high); i++) {
+		/* set all bits in u32 */
+		if ((low <= OP_LOW(i)) && (high >= OP_HIGH(i)))
+			ops->perms[i] |= ~0U;
+		/* set low bits */
+		else if ((low <= OP_LOW(i)) && (high < OP_HIGH(i)))
+			ops->perms[i] |= OP_SETBITS(h);
+		/* set high bits */
+		else if ((low > OP_LOW(i)) && (high >= OP_HIGH(i)))
+			ops->perms[i] |= ~0U - OP_SETBITS(low);
+		/* set middle bits */
+		else if ((low > OP_LOW(i)) && (high <= OP_HIGH(i)))
+			ops->perms[i] |= OP_SETBITS(h) - OP_SETBITS(low);
+	}
+}
+
+int avrule_operation_used(av_operations_t *ops)
+{
+	unsigned int i;
+
+	for (i = 0; i < sizeof(ops->perms)/sizeof(ops->perms[0]); i++) {
+		if (ops->perms[i])
+			return 1;
+	}
+	return 0;
+}
+
+#define OP_TYPE(x) (x >> 8)
+#define OP_NUM(x) (x & 0xff)
+#define OP_CMD(type, num) ((type << 8) + num)
+int avrule_operation_partialtype(struct av_operations_range_list *rangelist,
+				av_operations_t *complete_type,
+				av_operations_t **operations)
+{
+	struct av_operations_range_list *r;
+	av_operations_t *ops;
+	uint8_t low, high;
+
+	ops = calloc(1, sizeof(av_operations_t));
+	if (!ops) {
+		yyerror("out of memory");
+		return - 1;
+	}
+
+	r = rangelist;
+	while(r) {
+		low = OP_TYPE(r->range.low);
+		high = OP_TYPE(r->range.high);
+		if (complete_type) {
+			if (!operation_perm_test(low, complete_type->perms))
+				operation_perm_set(low, ops->perms);
+			if (!operation_perm_test(high, complete_type->perms))
+				operation_perm_set(high, ops->perms);
+		} else {
+			operation_perm_set(low, ops->perms);
+			operation_perm_set(high, ops->perms);
+		}
+		r = r->next;
+	}
+	if (avrule_operation_used(ops)) {
+		*operations = ops;
+	} else {
+		free(ops);
+		*operations = NULL;
+	}
+	return 0;
+
+}
+
+int avrule_operation_completetype(struct av_operations_range_list *rangelist,
+			av_operations_t **operations)
+{
+	struct av_operations_range_list *r;
+	av_operations_t *ops;
+	uint16_t low, high;
+	ops = calloc(1, sizeof(av_operations_t));
+	if (!ops) {
+		yyerror("out of memory");
+		return - 1;
+	}
+
+	r = rangelist;
+	while(r) {
+		/*
+		 * Any type that has numbers 0x00 - 0xff is a complete type,
+		 *
+		 * if command number = 0xff, then round high up to next type,
+		 * else 0x00 - 0xfe keep current type
+		 * of this range. temporarily u32 for the + 1
+		 * to account for possible rollover before right shift
+		 */
+		high = OP_TYPE((uint32_t) (r->range.high + 1));
+		/* if 0x00 keep current type else 0x01 - 0xff round up to next type */
+		low = OP_TYPE(r->range.low);
+		if (OP_NUM(r->range.low))
+			low++;
+		if (high > low)
+			avrule_operation_setrangebits(low, high - 1, ops);
+		r = r->next;
+	}
+	if (avrule_operation_used(ops)) {
+		*operations = ops;
+	} else {
+		free(ops);
+		*operations = NULL;
+	}
+	return 0;
+}
+
+int avrule_operation_num(struct av_operations_range_list *rangelist,
+		av_operations_t **operations, unsigned int type)
+{
+	struct av_operations_range_list *r;
+	av_operations_t *ops;
+	uint16_t low, high;
+
+	*operations = NULL;
+	ops = calloc(1, sizeof(av_operations_t));
+	if (!ops) {
+		yyerror("out of memory");
+		return - 1;
+	}
+
+	r = rangelist;
+	/* for the passed in types, find the ranges that apply */
+	while (r) {
+		low = r->range.low;
+		high = r->range.high;
+		if ((type != OP_TYPE(low)) && (type != OP_TYPE(high))) {
+			r = r->next;
+			continue;
+		}
+
+		if (type == OP_TYPE(low)) {
+			if (high > OP_CMD(type, 0xff))
+				high = OP_CMD(type, 0xff);
+
+		} else {
+			if (low < OP_CMD(type, 0))
+				low = OP_CMD(type, 0);
+		}
+
+		low = OP_NUM(low);
+		high = OP_NUM(high);
+		avrule_operation_setrangebits(low, high, ops);
+		ops->type = type;
+		r = r->next;
+	}
+
+	if (avrule_operation_used(ops)) {
+		*operations = ops;
+	} else {
+		free(ops);
+		*operations = NULL;
+	}
+	return 0;
+}
+
+void avrule_operation_freeranges(struct av_operations_range_list *rangelist)
+{
+	struct av_operations_range_list *r, *tmp;
+	r = rangelist;
+	while (r) {
+		tmp = r;
+		r = r->next;
+		free(tmp);
+	}
+}
+
+unsigned int operation_for_each_bit(unsigned int *bit, av_operations_t *ops)
+{
+	unsigned int i;
+	for (i = *bit; i < sizeof(ops->perms)*8; i++) {
+		if (operation_perm_test(i,ops->perms)) {
+			operation_perm_clear(i, ops->perms);
+			*bit = i;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+int avrule_cpy(avrule_t *dest, avrule_t *src)
+{
+	class_perm_node_t *src_perms;
+	class_perm_node_t *dest_perms, *dest_tail;
+	dest_tail = NULL;
+
+	avrule_init(dest);
+	dest->specified = src->specified;
+	dest->flags = src->flags;
+	if (type_set_cpy(&dest->stypes, &src->stypes)) {
+		yyerror("out of memory");
+		return - 1;
+	}
+	if (type_set_cpy(&dest->ttypes, &src->ttypes)) {
+		yyerror("out of memory");
+		return - 1;
+	}
+	dest->line = src->line;
+	dest->source_filename = strdup(source_file);
+	dest->source_line = src->source_line;
+
+	/* increment through the class perms and copy over */
+	src_perms = src->perms;
+	while (src_perms) {
+		dest_perms = (class_perm_node_t *) calloc(1, sizeof(class_perm_node_t));
+		class_perm_node_init(dest_perms);
+		if (!dest_perms) {
+			yyerror("out of memory");
+			return -1;
+		}
+		if (!dest->perms)
+			dest->perms = dest_perms;
+		else
+			dest_tail->next = dest_perms;
+
+		dest_perms->tclass = src_perms->tclass;
+		dest_perms->data = src_perms->data;
+		dest_perms->next = NULL;
+		dest_tail = dest_perms;
+		src_perms = src_perms->next;
+	}
+	return 0;
+}
+
+int define_te_avtab_operation(int which)
+{
+	char *id;
+	avrule_t *avrule_template;
+	avrule_t *avrule;
+	struct av_operations_range_list *rangelist;
+	av_operations_t *complete_type, *partial_type, *ops;
+	unsigned int i;
+
+	if (pass == 1) {
+		for (i = 0; i < 4; i++) {
+			while ((id = queue_remove(id_queue)))
+				free(id);
+		}
+		return 0;
+	}
+
+	/* populate avrule template with source/target/tclass */
+	if (define_te_avtab_operation_helper(which, &avrule_template))
+		return -1;
+
+	/* organize operation ranges */
+	if (avrule_operation_ranges(&rangelist))
+		return -1;
+
+	/* create rule for ioctl operation types that are entirely enabled */
+	if (avrule_operation_completetype(rangelist, &complete_type))
+		return -1;
+	if (complete_type) {
+		avrule = (avrule_t *) calloc(1, sizeof(avrule_t));
+		if (!avrule) {
+			yyerror("out of memory");
+			return -1;
+		}
+		if (avrule_cpy(avrule, avrule_template))
+			return -1;
+		avrule->ops = complete_type;
+		if (which == AVRULE_OPNUM_ALLOWED)
+			avrule->specified = AVRULE_OPTYPE_ALLOWED;
+		else if (which == AVRULE_OPNUM_AUDITALLOW)
+			avrule->specified = AVRULE_OPTYPE_AUDITALLOW;
+		else if (which == AVRULE_OPNUM_DONTAUDIT)
+			avrule->specified = AVRULE_OPTYPE_DONTAUDIT;
+
+		append_avrule(avrule);
+	}
+
+	/* flag ioctl types that are partially enabled */
+	if (avrule_operation_partialtype(rangelist, complete_type, &partial_type))
+		return -1;
+
+	if (!partial_type || !avrule_operation_used(partial_type))
+		goto done;
+
+	/* create rule for each partially enabled type */
+	i = 0;
+	while (operation_for_each_bit(&i, partial_type)) {
+		if (avrule_operation_num(rangelist, &ops, i))
+			return -1;
+
+		if (ops) {
+			avrule = (avrule_t *) calloc(1, sizeof(avrule_t));
+			if (!avrule) {
+				yyerror("out of memory");
+				return -1;
+			}
+			if (avrule_cpy(avrule, avrule_template))
+				return -1;
+			avrule->ops = ops;
+			append_avrule(avrule);
+		}
+	}
+
+done:
+	if (partial_type)
+		free(partial_type);
+
+	return 0;
+}
+
 int define_te_avtab_helper(int which, avrule_t ** rule)
 {
 	char *id;
@@ -1751,6 +2365,7 @@ int define_te_avtab_helper(int which, avrule_t ** rule)
 	avrule->line = policydb_lineno;
 	avrule->source_line = source_lineno;
 	avrule->source_filename = strdup(source_file);
+	avrule->ops = NULL;
 	if (!avrule->source_filename) {
 		yyerror("out of memory");
 		return -1;
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index a87ced3..43c7c08 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -9,7 +9,6 @@
  * for NULL (ie 0) because that is a potentially valid return.
  */
 #define COND_ERR ((avrule_t *)-1)
-
 #define TRUE 1
 #define FALSE 0
 
@@ -59,6 +58,7 @@ int define_roleattribute(void);
 int define_filename_trans(void);
 int define_sens(void);
 int define_te_avtab(int which);
+int define_te_avtab_operation(int which);
 int define_typealias(void);
 int define_typeattribute(void);
 int define_typebounds(void);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 8b81f04..059b7b8 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -457,6 +457,9 @@ te_avtab_def		: allow_def
 			| auditdeny_def
 			| dontaudit_def
 			| neverallow_def
+			| operation_allow_def
+			| operation_auditallow_def
+			| operation_dontaudit_def
 			;
 allow_def		: ALLOW names names ':' names names  ';'
 			{if (define_te_avtab(AVRULE_ALLOWED)) return -1; }
@@ -473,6 +476,15 @@ dontaudit_def		: DONTAUDIT names names ':' names names ';'
 neverallow_def		: NEVERALLOW names names ':' names names  ';'
 			{if (define_te_avtab(AVRULE_NEVERALLOW)) return -1; }
 		        ;
+operation_allow_def	: ALLOW names names ':' names  operations ';'
+			{if (define_te_avtab_operation(AVRULE_OPNUM_ALLOWED)) return -1; }
+		        ;
+operation_auditallow_def: AUDITALLOW names names ':' names operations ';'
+			{if (define_te_avtab_operation(AVRULE_OPNUM_AUDITALLOW)) return -1; }
+		        ;
+operation_dontaudit_def	: DONTAUDIT names names ':' names operations ';'
+			{if (define_te_avtab_operation(AVRULE_OPNUM_DONTAUDIT)) return -1; }
+		        ;
 attribute_role_def	: ATTRIBUTE_ROLE identifier ';'
 			{if (define_attrib_role()) return -1; }
 		        ;
@@ -737,6 +749,28 @@ genfs_context_def	: GENFSCON filesystem path '-' identifier security_context_def
 ipv4_addr_def		: IPV4_ADDR
 			{ if (insert_id(yytext,0)) return -1; }
 			;
+operations		: operation
+			{ if (insert_separator(0)) return -1; }
+			| nested_operation_set
+			{ if (insert_separator(0)) return -1; }
+			| tilde operation
+                        { if (insert_id("~", 0)) return -1; }
+			| tilde nested_operation_set
+			{ if (insert_id("~", 0)) return -1;
+			  if (insert_separator(0)) return -1; }
+			;
+nested_operation_set	: '{' nested_operation_list '}'
+			;
+nested_operation_list	: nested_operation_element
+			| nested_operation_list nested_operation_element
+			;
+nested_operation_element: operation '-' { if (insert_id("-", 0)) return -1; } operation
+			| operation
+			| nested_operation_set
+			;
+operation		: number
+                        { if (insert_id(yytext,0)) return -1; }
+			;
 security_context_def	: identifier ':' identifier ':' identifier opt_mls_range_def
 	                ;
 opt_mls_range_def	: ':' mls_range_def
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index 3f56a0e..2ea821c 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -50,22 +50,37 @@ typedef struct avtab_key {
 	uint16_t source_type;
 	uint16_t target_type;
 	uint16_t target_class;
-#define AVTAB_ALLOWED     1
-#define AVTAB_AUDITALLOW  2
-#define AVTAB_AUDITDENY   4
-#define AVTAB_NEVERALLOW 128
-#define AVTAB_AV         (AVTAB_ALLOWED | AVTAB_AUDITALLOW | AVTAB_AUDITDENY)
-#define AVTAB_TRANSITION 16
-#define AVTAB_MEMBER     32
-#define AVTAB_CHANGE     64
-#define AVTAB_TYPE       (AVTAB_TRANSITION | AVTAB_MEMBER | AVTAB_CHANGE)
-#define AVTAB_ENABLED_OLD 0x80000000
-#define AVTAB_ENABLED    0x8000	/* reserved for used in cond_avtab */
+#define AVTAB_ALLOWED		0x0001
+#define AVTAB_AUDITALLOW	0x0002
+#define AVTAB_AUDITDENY		0x0004
+#define AVTAB_NEVERALLOW	0x0080
+#define AVTAB_AV		(AVTAB_ALLOWED | AVTAB_AUDITALLOW | AVTAB_AUDITDENY)
+#define AVTAB_TRANSITION	0x0010
+#define AVTAB_MEMBER		0x0020
+#define AVTAB_CHANGE		0x0040
+#define AVTAB_TYPE		(AVTAB_TRANSITION | AVTAB_MEMBER | AVTAB_CHANGE)
+#define AVTAB_OPNUM_ALLOWED	0x0100
+#define AVTAB_OPNUM_AUDITALLOW	0x0200
+#define AVTAB_OPNUM_DONTAUDIT	0x0400
+#define AVTAB_OPNUM		(AVTAB_OPNUM_ALLOWED | AVTAB_OPNUM_AUDITALLOW | AVTAB_OPNUM_DONTAUDIT)
+#define AVTAB_OPTYPE_ALLOWED	0x1000
+#define AVTAB_OPTYPE_AUDITALLOW	0x2000
+#define AVTAB_OPTYPE_DONTAUDIT	0x4000
+#define AVTAB_OPTYPE		(AVTAB_OPTYPE_ALLOWED | AVTAB_OPTYPE_AUDITALLOW | AVTAB_OPTYPE_DONTAUDIT)
+#define AVTAB_OP		(AVTAB_OPNUM | AVTAB_OPTYPE)
+#define AVTAB_ENABLED_OLD	0x80000000
+#define AVTAB_ENABLED		0x8000	/* reserved for used in cond_avtab */
 	uint16_t specified;	/* what fields are specified */
 } avtab_key_t;
 
+typedef struct avtab_operations {
+	uint8_t type;
+	uint32_t perms[8];
+} avtab_operations_t;
+
 typedef struct avtab_datum {
 	uint32_t data;		/* access vector or type */
+	avtab_operations_t *ops;
 } avtab_datum_t;
 
 typedef struct avtab_node *avtab_ptr_t;
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 31efc3a..1d8310c 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -241,25 +241,43 @@ typedef struct class_perm_node {
 	struct class_perm_node *next;
 } class_perm_node_t;
 
+typedef struct av_operations {
+	uint8_t type;
+	/* 256 bits of ioctl number permissions */
+	uint32_t perms[8];
+} av_operations_t;
+
 typedef struct avrule {
 /* these typedefs are almost exactly the same as those in avtab.h - they are
  * here because of the need to include neverallow and dontaudit messages */
-#define AVRULE_ALLOWED     1
-#define AVRULE_AUDITALLOW  2
-#define AVRULE_AUDITDENY   4
-#define AVRULE_DONTAUDIT   8
-#define AVRULE_NEVERALLOW 128
+#define AVRULE_ALLOWED			0x0001
+#define AVRULE_AUDITALLOW		0x0002
+#define AVRULE_AUDITDENY		0x0004
+#define AVRULE_DONTAUDIT		0x0008
+#define AVRULE_NEVERALLOW		0x0080
 #define AVRULE_AV         (AVRULE_ALLOWED | AVRULE_AUDITALLOW | AVRULE_AUDITDENY | AVRULE_DONTAUDIT | AVRULE_NEVERALLOW)
-#define AVRULE_TRANSITION 16
-#define AVRULE_MEMBER     32
-#define AVRULE_CHANGE     64
+#define AVRULE_TRANSITION		0x0010
+#define AVRULE_MEMBER			0x0020
+#define AVRULE_CHANGE			0x0040
 #define AVRULE_TYPE       (AVRULE_TRANSITION | AVRULE_MEMBER | AVRULE_CHANGE)
+#define AVRULE_OPNUM_ALLOWED 		0x0100
+#define AVRULE_OPNUM_AUDITALLOW		0x0200
+#define AVRULE_OPNUM_DONTAUDIT		0x0400
+#define AVRULE_OPNUM         (AVRULE_OPNUM_ALLOWED | AVRULE_OPNUM_AUDITALLOW | \
+				AVRULE_OPNUM_DONTAUDIT)
+#define AVRULE_OPTYPE_ALLOWED		0x1000
+#define AVRULE_OPTYPE_AUDITALLOW	0x2000
+#define AVRULE_OPTYPE_DONTAUDIT		0x4000
+#define AVRULE_OPTYPE         (AVRULE_OPTYPE_ALLOWED | AVRULE_OPTYPE_AUDITALLOW | \
+				AVRULE_OPTYPE_DONTAUDIT)
+#define AVRULE_OP         (AVRULE_OPNUM | AVRULE_OPTYPE)
 	uint32_t specified;
 #define RULE_SELF 1
 	uint32_t flags;
 	type_set_t stypes;
 	type_set_t ttypes;
 	class_perm_node_t *perms;
+	av_operations_t * ops;
 	unsigned long line;	/* line number from policy.conf where
 				 * this rule originated  */
 	/* source file name and line number (e.g. .te file) */
@@ -690,11 +708,12 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_NEW_OBJECT_DEFAULTS	27
 #define POLICYDB_VERSION_DEFAULT_TYPE	28
 #define POLICYDB_VERSION_CONSTRAINT_NAMES	29
-#define POLICYDB_VERSION_XEN_DEVICETREE 30
+#define POLICYDB_VERSION_XEN_DEVICETREE		30 /* Xen-specific */
+#define POLICYDB_VERSION_IOCTL_OPERATIONS	30 /* Linux-specific */
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_XEN_DEVICETREE
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_IOCTL_OPERATIONS
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index d6041d4..d3745fe 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -93,12 +93,28 @@ avtab_insert_node(avtab_t * h, int hvalue, avtab_ptr_t prev, avtab_key_t * key,
 		  avtab_datum_t * datum)
 {
 	avtab_ptr_t newnode;
+	avtab_operations_t *ops;
+
 	newnode = (avtab_ptr_t) malloc(sizeof(struct avtab_node));
 	if (newnode == NULL)
 		return NULL;
 	memset(newnode, 0, sizeof(struct avtab_node));
 	newnode->key = *key;
-	newnode->datum = *datum;
+
+	if (key->specified & AVTAB_OP) {
+		ops = calloc(1, sizeof(avtab_operations_t));
+		if (ops == NULL) {
+			free(newnode);
+			return NULL;
+		}
+		if (datum->ops) /* else caller populates ops*/
+			*ops = *(datum->ops);
+
+		newnode->datum.ops = ops;
+	} else {
+		newnode->datum = *datum;
+	}
+
 	if (prev) {
 		newnode->next = prev->next;
 		prev->next = newnode;
@@ -127,8 +143,11 @@ int avtab_insert(avtab_t * h, avtab_key_t * key, avtab_datum_t * datum)
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
 		    key->target_class == cur->key.target_class &&
-		    (specified & cur->key.specified))
+		    (specified & cur->key.specified)) {
+			if (specified & AVTAB_OPNUM)
+				break;
 			return SEPOL_EEXIST;
+		}
 		if (key->source_type < cur->key.source_type)
 			break;
 		if (key->source_type == cur->key.source_type &&
@@ -396,23 +415,32 @@ static uint16_t spec_order[] = {
 	AVTAB_AUDITALLOW,
 	AVTAB_TRANSITION,
 	AVTAB_CHANGE,
-	AVTAB_MEMBER
+	AVTAB_MEMBER,
+	AVTAB_OPNUM_ALLOWED,
+	AVTAB_OPNUM_AUDITALLOW,
+	AVTAB_OPNUM_DONTAUDIT,
+	AVTAB_OPTYPE_ALLOWED,
+	AVTAB_OPTYPE_AUDITALLOW,
+	AVTAB_OPTYPE_DONTAUDIT
 };
 
 int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 		    int (*insertf) (avtab_t * a, avtab_key_t * k,
 				    avtab_datum_t * d, void *p), void *p)
 {
+	uint8_t buf8;
 	uint16_t buf16[4], enabled;
-	uint32_t buf32[7], items, items2, val;
+	uint32_t buf32[8], items, items2, val;
 	avtab_key_t key;
 	avtab_datum_t datum;
+	avtab_operations_t ops;
 	unsigned set;
 	unsigned int i;
 	int rc;
 
 	memset(&key, 0, sizeof(avtab_key_t));
 	memset(&datum, 0, sizeof(avtab_datum_t));
+	memset(&ops, 0, sizeof(avtab_operations_t));
 
 	if (vers < POLICYDB_VERSION_AVTAB) {
 		rc = next_entry(buf32, fp, sizeof(uint32_t));
@@ -505,12 +533,34 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 		return -1;
 	}
 
-	rc = next_entry(buf32, fp, sizeof(uint32_t));
-	if (rc < 0) {
-		ERR(fp->handle, "truncated entry");
+	if ((vers < POLICYDB_VERSION_IOCTL_OPERATIONS) &&
+			(key.specified & AVTAB_OP)) {
+		ERR(fp->handle, "policy version %u does not support ioctl "
+				"operation rules and one was specified\n", vers);
 		return -1;
+	} else if (key.specified & AVTAB_OP) {
+		rc = next_entry(&buf8, fp, sizeof(uint8_t));
+		if (rc < 0) {
+			ERR(fp->handle, "truncated entry");
+			return -1;
+		}
+		ops.type = buf8;
+		rc = next_entry(buf32, fp, sizeof(uint32_t)*8);
+		if (rc < 0) {
+			ERR(fp->handle, "truncated entry");
+			return -1;
+		}
+		for (i = 0; i < ARRAY_SIZE(ops.perms); i++)
+			ops.perms[i] = le32_to_cpu(buf32[i]);
+		datum.ops = &ops;
+	} else {
+		rc = next_entry(buf32, fp, sizeof(uint32_t));
+		if (rc < 0) {
+			ERR(fp->handle, "truncated entry");
+			return -1;
+		}
+		datum.data = le32_to_cpu(*buf32);
 	}
-	datum.data = le32_to_cpu(*buf32);
 	return insertf(a, &key, &datum, p);
 }
 
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index a8b1115..b999890 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1603,13 +1603,29 @@ static int expand_range_trans(expand_state_t * state,
 */
 static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
 				   avtab_t * avtab, avtab_key_t * key,
-				   cond_av_list_t ** cond)
+				   cond_av_list_t ** cond,
+				   av_operations_t *operations)
 {
 	avtab_ptr_t node;
 	avtab_datum_t avdatum;
 	cond_av_list_t *nl;
+	int type_match = 0;
 
-	node = avtab_search_node(avtab, key);
+	/* AVTAB_OPNUM entries are not necessarily unique */
+	if (key->specified & AVTAB_OPNUM) {
+		node = avtab_search_node(avtab, key);
+		while (node) {
+			if (node->datum.ops->type == operations->type) {
+				type_match = 1;
+				break;
+			}
+			node = avtab_search_node_next(node, key->specified);
+		}
+		if (!type_match)
+			node = NULL;
+	} else {
+		node = avtab_search_node(avtab, key);
+	}
 
 	/* If this is for conditional policies, keep searching in case
 	   the node is part of my conditional avtab. */
@@ -1733,7 +1749,7 @@ static int expand_terule_helper(sepol_handle_t * handle,
 			return EXPAND_RULE_CONFLICT;
 		}
 
-		node = find_avtab_node(handle, avtab, &avkey, cond);
+		node = find_avtab_node(handle, avtab, &avkey, cond, NULL);
 		if (!node)
 			return -1;
 		if (enabled) {
@@ -1764,13 +1780,15 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 				cond_av_list_t ** cond,
 				uint32_t stype, uint32_t ttype,
 				class_perm_node_t * perms, avtab_t * avtab,
-				int enabled)
+				int enabled, av_operations_t *operations)
 {
 	avtab_key_t avkey;
 	avtab_datum_t *avdatump;
+	avtab_operations_t *ops;
 	avtab_ptr_t node;
 	class_perm_node_t *cur;
 	uint32_t spec = 0;
+	unsigned int i;
 
 	if (specified & AVRULE_ALLOWED) {
 		spec = AVTAB_ALLOWED;
@@ -1784,6 +1802,22 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 		spec = AVTAB_AUDITDENY;
 	} else if (specified & AVRULE_NEVERALLOW) {
 		spec = AVTAB_NEVERALLOW;
+	} else if (specified & AVRULE_OPNUM_ALLOWED) {
+		spec = AVTAB_OPNUM_ALLOWED;
+	} else if (specified & AVRULE_OPNUM_AUDITALLOW) {
+		spec = AVTAB_OPNUM_AUDITALLOW;
+	} else if (specified & AVRULE_OPNUM_DONTAUDIT) {
+		if (handle && handle->disable_dontaudit)
+			return EXPAND_RULE_SUCCESS;
+		spec = AVTAB_OPNUM_DONTAUDIT;
+	} else if (specified & AVRULE_OPTYPE_ALLOWED) {
+		spec = AVTAB_OPTYPE_ALLOWED;
+	} else if (specified & AVRULE_OPTYPE_AUDITALLOW) {
+		spec = AVTAB_OPTYPE_AUDITALLOW;
+	} else if (specified & AVRULE_OPTYPE_DONTAUDIT) {
+		if (handle && handle->disable_dontaudit)
+			return EXPAND_RULE_SUCCESS;
+		spec = AVTAB_OPTYPE_DONTAUDIT;
 	} else {
 		assert(0);	/* unreachable */
 	}
@@ -1795,7 +1829,7 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 		avkey.target_class = cur->tclass;
 		avkey.specified = spec;
 
-		node = find_avtab_node(handle, avtab, &avkey, cond);
+		node = find_avtab_node(handle, avtab, &avkey, cond, operations);
 		if (!node)
 			return EXPAND_RULE_ERROR;
 		if (enabled) {
@@ -1825,6 +1859,20 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 				avdatump->data &= ~cur->data;
 			else
 				avdatump->data = ~cur->data;
+		} else if (specified & AVRULE_OP) {
+			if (!avdatump->ops) {
+				ops = (avtab_operations_t *)
+					calloc(1, sizeof(avtab_operations_t));
+				if (!ops) {
+					ERR(handle, "Out of memory!");
+					return -1;
+				}
+				node->datum.ops = ops;
+			}
+			node->datum.ops->type = operations->type;
+			for (i = 0; i < ARRAY_SIZE(operations->perms); i++) {
+				node->datum.ops->perms[i] |= operations->perms[i];
+			}
 		} else {
 			assert(0);	/* should never occur */
 		}
@@ -1849,10 +1897,10 @@ static int expand_rule_helper(sepol_handle_t * handle,
 		if (!ebitmap_node_get_bit(snode, i))
 			continue;
 		if (source_rule->flags & RULE_SELF) {
-			if (source_rule->specified & AVRULE_AV) {
+			if (source_rule->specified & (AVRULE_AV | AVRULE_OP)) {
 				retval = expand_avrule_helper(handle, source_rule->specified,
 							      cond, i, i, source_rule->perms,
-							      dest_avtab, enabled);
+							      dest_avtab, enabled, source_rule->ops);
 				if (retval != EXPAND_RULE_SUCCESS)
 					return retval;
 			} else {
@@ -1867,10 +1915,10 @@ static int expand_rule_helper(sepol_handle_t * handle,
 		ebitmap_for_each_bit(ttypes, tnode, j) {
 			if (!ebitmap_node_get_bit(tnode, j))
 				continue;
-			if (source_rule->specified & AVRULE_AV) {
+			if (source_rule->specified & (AVRULE_AV | AVRULE_OP)) {
 				retval = expand_avrule_helper(handle, source_rule->specified,
 							      cond, i, j, source_rule->perms,
-							      dest_avtab, enabled);
+							      dest_avtab, enabled, source_rule->ops);
 				if (retval != EXPAND_RULE_SUCCESS)
 					return retval;
 			} else {
@@ -3107,18 +3155,31 @@ static int expand_avtab_insert(avtab_t * a, avtab_key_t * k, avtab_datum_t * d)
 {
 	avtab_ptr_t node;
 	avtab_datum_t *avd;
-	int rc;
-
-	node = avtab_search_node(a, k);
-	if (!node) {
-		rc = avtab_insert(a, k, d);
-		if (rc)
-			ERR(NULL, "Out of memory!");
-		return rc;
+	avtab_operations_t *ops;
+	unsigned int i;
+	unsigned int type_match = 0;
+
+	if (k->specified & AVTAB_OPNUM) {
+		/*
+		 * AVTAB_OPNUM entries are not necessarily unique.
+		 * find node with matching ops->type
+		 */
+		node = avtab_search_node(a, k);
+		while (node) {
+			if (node->datum.ops->type == d->ops->type) {
+				type_match = 1;
+				break;
+			}
+			node = avtab_search_node_next(node, k->specified);
+		}
+		if (!type_match)
+			node = NULL;
+	} else {
+		node = avtab_search_node(a, k);
 	}
 
-	if ((k->specified & AVTAB_ENABLED) !=
-	    (node->key.specified & AVTAB_ENABLED)) {
+	if (!node || ((k->specified & AVTAB_ENABLED) !=
+			(node->key.specified & AVTAB_ENABLED))) {
 		node = avtab_insert_nonunique(a, k, d);
 		if (!node) {
 			ERR(NULL, "Out of memory!");
@@ -3128,6 +3189,7 @@ static int expand_avtab_insert(avtab_t * a, avtab_key_t * k, avtab_datum_t * d)
 	}
 
 	avd = &node->datum;
+	ops = node->datum.ops;
 	switch (k->specified & ~AVTAB_ENABLED) {
 	case AVTAB_ALLOWED:
 	case AVTAB_AUDITALLOW:
@@ -3136,6 +3198,15 @@ static int expand_avtab_insert(avtab_t * a, avtab_key_t * k, avtab_datum_t * d)
 	case AVTAB_AUDITDENY:
 		avd->data &= d->data;
 		break;
+	case AVTAB_OPNUM_ALLOWED:
+	case AVTAB_OPNUM_AUDITALLOW:
+	case AVTAB_OPNUM_DONTAUDIT:
+	case AVTAB_OPTYPE_ALLOWED:
+	case AVTAB_OPTYPE_AUDITALLOW:
+	case AVTAB_OPTYPE_DONTAUDIT:
+		for (i = 0; i < ARRAY_SIZE(ops->perms); i++)
+			ops->perms[i] |= d->ops->perms[i];
+		break;
 	default:
 		ERR(NULL, "Type conflict!");
 		return -1;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index d1c0018..8c3c7ac 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -180,7 +180,7 @@ static struct policydb_compat_info policydb_compat[] = {
 	},
 	{
 	 .type = POLICY_KERN,
-	 .version = POLICYDB_VERSION_XEN_DEVICETREE,
+	 .version = POLICYDB_VERSION_IOCTL_OPERATIONS,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index c97a4da..5e12d6b 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -101,6 +101,7 @@ static int avtab_write_item(policydb_t * p,
 			    unsigned merge, unsigned commit, uint32_t * nel)
 {
 	avtab_ptr_t node;
+	uint8_t buf8;
 	uint16_t buf16[4];
 	uint32_t buf32[10], lookup, val;
 	size_t items, items2;
@@ -220,10 +221,38 @@ static int avtab_write_item(policydb_t * p,
 	items = put_entry(buf16, sizeof(uint16_t), 4, fp);
 	if (items != 4)
 		return POLICYDB_ERROR;
-	buf32[0] = cpu_to_le32(cur->datum.data);
-	items = put_entry(buf32, sizeof(uint32_t), 1, fp);
-	if (items != 1)
+	if ((p->policyvers < POLICYDB_VERSION_IOCTL_OPERATIONS) &&
+			(cur->key.specified & AVTAB_OP)) {
+		ERR(fp->handle, "policy version %u does not support ioctl operation"
+				" rules and one was specified", p->policyvers);
+		return POLICYDB_ERROR;
+	}
+
+	if (p->target_platform != SEPOL_TARGET_SELINUX &&
+			(cur->key.specified & AVTAB_OP)) {
+		ERR(fp->handle, "Target platform %s does not support ioctl "
+				"operation rules and one was specified",
+				policydb_target_strings[p->target_platform]);
 		return POLICYDB_ERROR;
+	}
+
+	if (cur->key.specified & AVTAB_OP) {
+		buf8 = cur->datum.ops->type;
+		items = put_entry(&buf8, sizeof(uint8_t),1,fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+		for (i = 0; i < ARRAY_SIZE(cur->datum.ops->perms); i++)
+			buf32[i] = cpu_to_le32(cur->datum.ops->perms[i]);
+		items = put_entry(buf32, sizeof(uint32_t),8,fp);
+		if (items != 8)
+			return POLICYDB_ERROR;
+	} else {
+		buf32[0] = cpu_to_le32(cur->datum.data);
+		items = put_entry(buf32, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+	}
+
 	return POLICYDB_SUCCESS;
 }
 
-- 
2.2.0.rc0.207.ga3a616c
