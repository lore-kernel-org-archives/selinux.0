Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5CG1Q9e001154
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 12:01:26 -0400
Received: by igbzc4 with SMTP id zc4so14911773igb.0
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 09:01:24 -0700 (PDT)
From: Jeff Vander Stoep <jeffv@google.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] checkpolicy: switch operations to extended perms
Date: Fri, 12 Jun 2015 09:01:12 -0700
Message-Id: <1434124872-12384-1-git-send-email-jeffv@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The ioctl operations code is being renamed to the more generic
"extended permissions." This commit brings the policy compiler
up to date with the kernel patch.

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 checkpolicy/policy_define.c                | 343 +++++++++++++++--------------
 checkpolicy/policy_define.h                |   2 +-
 checkpolicy/policy_parse.y                 |  43 ++--
 checkpolicy/policy_scan.l                  |   6 +
 checkpolicy/test/dispol.c                  |  47 ++--
 libsepol/include/sepol/policydb/avtab.h    |  26 +--
 libsepol/include/sepol/policydb/policydb.h |  33 ++-
 libsepol/src/avtab.c                       |  54 ++---
 libsepol/src/expand.c                      | 102 ++++-----
 libsepol/src/policydb.c                    |   2 +-
 libsepol/src/write.c                       |  30 +--
 11 files changed, 363 insertions(+), 325 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 093bded..8c01739 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1728,32 +1728,31 @@ avrule_t *define_cond_pol_list(avrule_t * avlist, avrule_t * sl)
 	return sl;
 }
 
-#define operation_perm_test(x, p) (1 & (p[x >> 5] >> (x & 0x1f)))
-#define operation_perm_set(x, p) (p[x >> 5] |= (1 << (x & 0x1f)))
-#define operation_perm_clear(x, p) (p[x >> 5] &= ~(1 << (x & 0x1f)))
+#define xperm_test(x, p) (1 & (p[x >> 5] >> (x & 0x1f)))
+#define xperm_set(x, p) (p[x >> 5] |= (1 << (x & 0x1f)))
+#define xperm_clear(x, p) (p[x >> 5] &= ~(1 << (x & 0x1f)))
 
-typedef struct av_operations_range {
+typedef struct av_ioctl_range {
 	uint16_t low;
 	uint16_t high;
-} av_operations_range_t;
+} av_ioctl_range_t;
 
-struct av_operations_range_list {
+struct av_ioctl_range_list {
 	uint8_t omit;
-	av_operations_range_t range;
-	struct av_operations_range_list *next;
+	av_ioctl_range_t range;
+	struct av_ioctl_range_list *next;
 };
 
-int avrule_sort_operations(
-		struct av_operations_range_list **rangehead)
+int avrule_sort_ioctls(struct av_ioctl_range_list **rangehead)
 {
-	struct av_operations_range_list *r, *r2, *sorted, *sortedhead = NULL;
+	struct av_ioctl_range_list *r, *r2, *sorted, *sortedhead = NULL;
 
 	/* order list by range.low */
 	for (r = *rangehead; r != NULL; r = r->next) {
-		sorted = malloc(sizeof(struct av_operations_range_list));
+		sorted = malloc(sizeof(struct av_ioctl_range_list));
 		if (sorted == NULL)
 			goto error;
-		memcpy(sorted, r, sizeof(struct av_operations_range_list));
+		memcpy(sorted, r, sizeof(struct av_ioctl_range_list));
 		sorted->next = NULL;
 		if (sortedhead == NULL) {
 			sortedhead = sorted;
@@ -1792,9 +1791,9 @@ error:
 	return -1;
 }
 
-int avrule_merge_operations(struct av_operations_range_list **rangehead)
+int avrule_merge_ioctls(struct av_ioctl_range_list **rangehead)
 {
-	struct av_operations_range_list *r, *tmp;
+	struct av_ioctl_range_list *r, *tmp;
 	r = *rangehead;
 	while (r != NULL && r->next != NULL) {
 		/* merge */
@@ -1812,14 +1811,14 @@ int avrule_merge_operations(struct av_operations_range_list **rangehead)
 	return 0;
 }
 
-int avrule_read_operations(struct av_operations_range_list **rangehead)
+int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
 {
 	char *id;
-	struct av_operations_range_list *rnew, *r = NULL;
+	struct av_ioctl_range_list *rnew, *r = NULL;
 	*rangehead = NULL;
 	uint8_t omit = 0;
 
-	/* read in all the operations */
+	/* read in all the ioctl commands */
 	while ((id = queue_remove(id_queue))) {
 		if (strcmp(id,"~") == 0) {
 			/* these are values to be omitted */
@@ -1837,7 +1836,7 @@ int avrule_read_operations(struct av_operations_range_list **rangehead)
 			free(id);
 		} else {
 			/* read in new low value */
-			rnew = malloc(sizeof(struct av_operations_range_list));
+			rnew = malloc(sizeof(struct av_ioctl_range_list));
 			if (rnew == NULL)
 				goto error;
 			rnew->next = NULL;
@@ -1862,11 +1861,11 @@ error:
 }
 
 /* flip to included ranges */
-int avrule_omit_operations(struct av_operations_range_list **rangehead)
+int avrule_omit_ioctls(struct av_ioctl_range_list **rangehead)
 {
-	struct av_operations_range_list *rnew, *r, *newhead, *r2;
+	struct av_ioctl_range_list *rnew, *r, *newhead, *r2;
 
-	rnew = calloc(1, sizeof(struct av_operations_range_list));
+	rnew = calloc(1, sizeof(struct av_ioctl_range_list));
 	if (!rnew)
 		goto error;
 
@@ -1884,7 +1883,7 @@ int avrule_omit_operations(struct av_operations_range_list **rangehead)
 
 	while (r) {
 		r2->range.high = r->range.low - 1;
-		rnew = calloc(1, sizeof(struct av_operations_range_list));
+		rnew = calloc(1, sizeof(struct av_ioctl_range_list));
 		if (!rnew)
 			goto error;
 		r2->next = rnew;
@@ -1910,27 +1909,27 @@ error:
 	return -1;
 }
 
-int avrule_operation_ranges(struct av_operations_range_list **rangelist)
+int avrule_ioctl_ranges(struct av_ioctl_range_list **rangelist)
 {
-	struct av_operations_range_list *rangehead;
+	struct av_ioctl_range_list *rangehead;
 	uint8_t omit;
 
 	/* read in ranges to include and omit */
-	if (avrule_read_operations(&rangehead))
+	if (avrule_read_ioctls(&rangehead))
 		return -1;
 	omit = rangehead->omit;
 	if (rangehead == NULL) {
-		yyerror("error processing ioctl operations");
+		yyerror("error processing ioctl commands");
 		return -1;
 	}
-	/* sort and merge the input operations */
-	if (avrule_sort_operations(&rangehead))
+	/* sort and merge the input ioctls */
+	if (avrule_sort_ioctls(&rangehead))
 		return -1;
-	if (avrule_merge_operations(&rangehead))
+	if (avrule_merge_ioctls(&rangehead))
 		return -1;
 	/* flip ranges if these are ommited*/
 	if (omit) {
-		if (avrule_omit_operations(&rangehead))
+		if (avrule_omit_ioctls(&rangehead))
 			return -1;
 	}
 
@@ -1938,7 +1937,7 @@ int avrule_operation_ranges(struct av_operations_range_list **rangelist)
 	return 0;
 }
 
-int define_te_avtab_operation_helper(int which, avrule_t ** rule)
+int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 {
 	char *id;
 	class_perm_node_t *perms, *tail = NULL, *cur_perms = NULL;
@@ -1959,7 +1958,7 @@ int define_te_avtab_operation_helper(int which, avrule_t ** rule)
 	avrule->line = policydb_lineno;
 	avrule->source_line = source_lineno;
 	avrule->source_filename = strdup(source_file);
-	avrule->ops = NULL;
+	avrule->xperms = NULL;
 	if (!avrule->source_filename) {
 		yyerror("out of memory");
 		return -1;
@@ -2023,95 +2022,102 @@ out:
 }
 
 /* index of the u32 containing the permission */
-#define OP_IDX(x) (x >> 5)
+#define XPERM_IDX(x) (x >> 5)
 /* set bits 0 through x-1 within the u32 */
-#define OP_SETBITS(x) ((1 << (x & 0x1f)) - 1)
+#define XPERM_SETBITS(x) ((1 << (x & 0x1f)) - 1)
 /* low value for this u32 */
-#define OP_LOW(x) (x << 5)
+#define XPERM_LOW(x) (x << 5)
 /* high value for this u32 */
-#define OP_HIGH(x) (((x + 1) << 5) - 1)
-void avrule_operation_setrangebits(uint16_t low, uint16_t high, av_operations_t *ops)
+#define XPERM_HIGH(x) (((x + 1) << 5) - 1)
+void avrule_xperm_setrangebits(uint16_t low, uint16_t high,
+				av_extended_perms_t *xperms)
 {
 	unsigned int i;
 	uint16_t h = high + 1;
-	/* for each u32 that this low-high range touches, set type permissions */
-	for (i = OP_IDX(low); i <= OP_IDX(high); i++) {
+	/* for each u32 that this low-high range touches, set driver permissions */
+	for (i = XPERM_IDX(low); i <= XPERM_IDX(high); i++) {
 		/* set all bits in u32 */
-		if ((low <= OP_LOW(i)) && (high >= OP_HIGH(i)))
-			ops->perms[i] |= ~0U;
+		if ((low <= XPERM_LOW(i)) && (high >= XPERM_HIGH(i)))
+			xperms->perms[i] |= ~0U;
 		/* set low bits */
-		else if ((low <= OP_LOW(i)) && (high < OP_HIGH(i)))
-			ops->perms[i] |= OP_SETBITS(h);
+		else if ((low <= XPERM_LOW(i)) && (high < XPERM_HIGH(i)))
+			xperms->perms[i] |= XPERM_SETBITS(h);
 		/* set high bits */
-		else if ((low > OP_LOW(i)) && (high >= OP_HIGH(i)))
-			ops->perms[i] |= ~0U - OP_SETBITS(low);
+		else if ((low > XPERM_LOW(i)) && (high >= XPERM_HIGH(i)))
+			xperms->perms[i] |= ~0U - XPERM_SETBITS(low);
 		/* set middle bits */
-		else if ((low > OP_LOW(i)) && (high <= OP_HIGH(i)))
-			ops->perms[i] |= OP_SETBITS(h) - OP_SETBITS(low);
+		else if ((low > XPERM_LOW(i)) && (high <= XPERM_HIGH(i)))
+			xperms->perms[i] |= XPERM_SETBITS(h) - XPERM_SETBITS(low);
 	}
 }
 
-int avrule_operation_used(av_operations_t *ops)
+int avrule_xperms_used(av_extended_perms_t *xperms)
 {
 	unsigned int i;
 
-	for (i = 0; i < sizeof(ops->perms)/sizeof(ops->perms[0]); i++) {
-		if (ops->perms[i])
+	for (i = 0; i < sizeof(xperms->perms)/sizeof(xperms->perms[0]); i++) {
+		if (xperms->perms[i])
 			return 1;
 	}
 	return 0;
 }
 
-#define OP_TYPE(x) (x >> 8)
-#define OP_NUM(x) (x & 0xff)
-#define OP_CMD(type, num) ((type << 8) + num)
-int avrule_operation_partialtype(struct av_operations_range_list *rangelist,
-				av_operations_t *complete_type,
-				av_operations_t **operations)
+/*
+ * using definitions found in kernel document ioctl-number.txt
+ * The kernel components of an ioctl command are:
+ * dir, size, driver, and fucntion. Only the driver and function fields
+ * are considered here
+ */
+#define IOC_DRIV(x) (x >> 8)
+#define IOC_FUNC(x) (x & 0xff)
+#define IOC_CMD(driver, func) ((driver << 8) + func)
+int avrule_ioctl_partialdriver(struct av_ioctl_range_list *rangelist,
+				av_extended_perms_t *complete_driver,
+				av_extended_perms_t **extended_perms)
 {
-	struct av_operations_range_list *r;
-	av_operations_t *ops;
+	struct av_ioctl_range_list *r;
+	av_extended_perms_t *xperms;
 	uint8_t low, high;
 
-	ops = calloc(1, sizeof(av_operations_t));
-	if (!ops) {
+	xperms = calloc(1, sizeof(av_extended_perms_t));
+	if (!xperms) {
 		yyerror("out of memory");
 		return - 1;
 	}
 
 	r = rangelist;
 	while(r) {
-		low = OP_TYPE(r->range.low);
-		high = OP_TYPE(r->range.high);
-		if (complete_type) {
-			if (!operation_perm_test(low, complete_type->perms))
-				operation_perm_set(low, ops->perms);
-			if (!operation_perm_test(high, complete_type->perms))
-				operation_perm_set(high, ops->perms);
+		low = IOC_DRIV(r->range.low);
+		high = IOC_DRIV(r->range.high);
+		if (complete_driver) {
+			if (!xperm_test(low, complete_driver->perms))
+				xperm_set(low, xperms->perms);
+			if (!xperm_test(high, complete_driver->perms))
+				xperm_set(high, xperms->perms);
 		} else {
-			operation_perm_set(low, ops->perms);
-			operation_perm_set(high, ops->perms);
+			xperm_set(low, xperms->perms);
+			xperm_set(high, xperms->perms);
 		}
 		r = r->next;
 	}
-	if (avrule_operation_used(ops)) {
-		*operations = ops;
+	if (avrule_xperms_used(xperms)) {
+		*extended_perms = xperms;
 	} else {
-		free(ops);
-		*operations = NULL;
+		free(xperms);
+		*extended_perms = NULL;
 	}
 	return 0;
 
 }
 
-int avrule_operation_completetype(struct av_operations_range_list *rangelist,
-			av_operations_t **operations)
+int avrule_ioctl_completedriver(struct av_ioctl_range_list *rangelist,
+			av_extended_perms_t **extended_perms)
 {
-	struct av_operations_range_list *r;
-	av_operations_t *ops;
+	struct av_ioctl_range_list *r;
+	av_extended_perms_t *xperms;
 	uint16_t low, high;
-	ops = calloc(1, sizeof(av_operations_t));
-	if (!ops) {
+	xperms = calloc(1, sizeof(av_extended_perms_t));
+	if (!xperms) {
 		yyerror("out of memory");
 		return - 1;
 	}
@@ -2119,83 +2125,86 @@ int avrule_operation_completetype(struct av_operations_range_list *rangelist,
 	r = rangelist;
 	while(r) {
 		/*
-		 * Any type that has numbers 0x00 - 0xff is a complete type,
+		 * Any driver code that has sequence 0x00 - 0xff is a complete code,
 		 *
-		 * if command number = 0xff, then round high up to next type,
-		 * else 0x00 - 0xfe keep current type
+		 * if command number = 0xff, then round high up to next code,
+		 * else 0x00 - 0xfe keep current code
 		 * of this range. temporarily u32 for the + 1
 		 * to account for possible rollover before right shift
 		 */
-		high = OP_TYPE((uint32_t) (r->range.high + 1));
-		/* if 0x00 keep current type else 0x01 - 0xff round up to next type */
-		low = OP_TYPE(r->range.low);
-		if (OP_NUM(r->range.low))
+		high = IOC_DRIV((uint32_t) (r->range.high + 1));
+		/* if 0x00 keep current driver code else 0x01 - 0xff round up to next code*/
+		low = IOC_DRIV(r->range.low);
+		if (IOC_FUNC(r->range.low))
 			low++;
 		if (high > low)
-			avrule_operation_setrangebits(low, high - 1, ops);
+			avrule_xperm_setrangebits(low, high - 1, xperms);
 		r = r->next;
 	}
-	if (avrule_operation_used(ops)) {
-		*operations = ops;
+	if (avrule_xperms_used(xperms)) {
+		xperms->driver = 0x00;
+		xperms->specified = AVRULE_XPERMS_IOCTLDRIVER;
+		*extended_perms = xperms;
 	} else {
-		free(ops);
-		*operations = NULL;
+		free(xperms);
+		*extended_perms = NULL;
 	}
 	return 0;
 }
 
-int avrule_operation_num(struct av_operations_range_list *rangelist,
-		av_operations_t **operations, unsigned int type)
+int avrule_ioctl_func(struct av_ioctl_range_list *rangelist,
+		av_extended_perms_t **extended_perms, unsigned int driver)
 {
-	struct av_operations_range_list *r;
-	av_operations_t *ops;
+	struct av_ioctl_range_list *r;
+	av_extended_perms_t *xperms;
 	uint16_t low, high;
 
-	*operations = NULL;
-	ops = calloc(1, sizeof(av_operations_t));
-	if (!ops) {
+	*extended_perms = NULL;
+	xperms = calloc(1, sizeof(av_extended_perms_t));
+	if (!xperms) {
 		yyerror("out of memory");
 		return - 1;
 	}
 
 	r = rangelist;
-	/* for the passed in types, find the ranges that apply */
+	/* for the passed in driver code, find the ranges that apply */
 	while (r) {
 		low = r->range.low;
 		high = r->range.high;
-		if ((type != OP_TYPE(low)) && (type != OP_TYPE(high))) {
+		if ((driver != IOC_DRIV(low)) && (driver != IOC_DRIV(high))) {
 			r = r->next;
 			continue;
 		}
 
-		if (type == OP_TYPE(low)) {
-			if (high > OP_CMD(type, 0xff))
-				high = OP_CMD(type, 0xff);
+		if (driver == IOC_DRIV(low)) {
+			if (high > IOC_CMD(driver, 0xff))
+				high = IOC_CMD(driver, 0xff);
 
 		} else {
-			if (low < OP_CMD(type, 0))
-				low = OP_CMD(type, 0);
+			if (low < IOC_CMD(driver, 0))
+				low = IOC_CMD(driver, 0);
 		}
 
-		low = OP_NUM(low);
-		high = OP_NUM(high);
-		avrule_operation_setrangebits(low, high, ops);
-		ops->type = type;
+		low = IOC_FUNC(low);
+		high = IOC_FUNC(high);
+		avrule_xperm_setrangebits(low, high, xperms);
+		xperms->driver = driver;
+		xperms->specified = AVRULE_XPERMS_IOCTLFUNCTION;
 		r = r->next;
 	}
 
-	if (avrule_operation_used(ops)) {
-		*operations = ops;
+	if (avrule_xperms_used(xperms)) {
+		*extended_perms = xperms;
 	} else {
-		free(ops);
-		*operations = NULL;
+		free(xperms);
+		*extended_perms = NULL;
 	}
 	return 0;
 }
 
-void avrule_operation_freeranges(struct av_operations_range_list *rangelist)
+void avrule_ioctl_freeranges(struct av_ioctl_range_list *rangelist)
 {
-	struct av_operations_range_list *r, *tmp;
+	struct av_ioctl_range_list *r, *tmp;
 	r = rangelist;
 	while (r) {
 		tmp = r;
@@ -2204,12 +2213,12 @@ void avrule_operation_freeranges(struct av_operations_range_list *rangelist)
 	}
 }
 
-unsigned int operation_for_each_bit(unsigned int *bit, av_operations_t *ops)
+unsigned int xperms_for_each_bit(unsigned int *bit, av_extended_perms_t *xperms)
 {
 	unsigned int i;
-	for (i = *bit; i < sizeof(ops->perms)*8; i++) {
-		if (operation_perm_test(i,ops->perms)) {
-			operation_perm_clear(i, ops->perms);
+	for (i = *bit; i < sizeof(xperms->perms)*8; i++) {
+		if (xperm_test(i,xperms->perms)) {
+			xperm_clear(i, xperms->perms);
 			*bit = i;
 			return 1;
 		}
@@ -2261,35 +2270,22 @@ int avrule_cpy(avrule_t *dest, avrule_t *src)
 	return 0;
 }
 
-int define_te_avtab_operation(int which)
+int define_te_avtab_ioctl(avrule_t *avrule_template)
 {
-	char *id;
-	avrule_t *avrule_template;
 	avrule_t *avrule;
-	struct av_operations_range_list *rangelist;
-	av_operations_t *complete_type, *partial_type, *ops;
+	struct av_ioctl_range_list *rangelist;
+	av_extended_perms_t *complete_driver, *partial_driver, *xperms;
 	unsigned int i;
 
-	if (pass == 1) {
-		for (i = 0; i < 4; i++) {
-			while ((id = queue_remove(id_queue)))
-				free(id);
-		}
-		return 0;
-	}
-
-	/* populate avrule template with source/target/tclass */
-	if (define_te_avtab_operation_helper(which, &avrule_template))
-		return -1;
 
-	/* organize operation ranges */
-	if (avrule_operation_ranges(&rangelist))
+	/* organize ioctl ranges */
+	if (avrule_ioctl_ranges(&rangelist))
 		return -1;
 
-	/* create rule for ioctl operation types that are entirely enabled */
-	if (avrule_operation_completetype(rangelist, &complete_type))
+	/* create rule for ioctl driver types that are entirely enabled */
+	if (avrule_ioctl_completedriver(rangelist, &complete_driver))
 		return -1;
-	if (complete_type) {
+	if (complete_driver) {
 		avrule = (avrule_t *) calloc(1, sizeof(avrule_t));
 		if (!avrule) {
 			yyerror("out of memory");
@@ -2297,31 +2293,28 @@ int define_te_avtab_operation(int which)
 		}
 		if (avrule_cpy(avrule, avrule_template))
 			return -1;
-		avrule->ops = complete_type;
-		if (which == AVRULE_OPNUM_ALLOWED)
-			avrule->specified = AVRULE_OPTYPE_ALLOWED;
-		else if (which == AVRULE_OPNUM_AUDITALLOW)
-			avrule->specified = AVRULE_OPTYPE_AUDITALLOW;
-		else if (which == AVRULE_OPNUM_DONTAUDIT)
-			avrule->specified = AVRULE_OPTYPE_DONTAUDIT;
-
+		avrule->xperms = complete_driver;
 		append_avrule(avrule);
 	}
 
-	/* flag ioctl types that are partially enabled */
-	if (avrule_operation_partialtype(rangelist, complete_type, &partial_type))
+	/* flag ioctl driver codes that are partially enabled */
+	if (avrule_ioctl_partialdriver(rangelist, complete_driver, &partial_driver))
 		return -1;
 
-	if (!partial_type || !avrule_operation_used(partial_type))
+	if (!partial_driver || !avrule_xperms_used(partial_driver))
 		goto done;
 
-	/* create rule for each partially enabled type */
+	/*
+	 * create rule for each partially used driver codes
+	 * "partially used" meaning that the code number e.g. socket 0x89
+	 * has some permission bits set and others not set.
+	 */
 	i = 0;
-	while (operation_for_each_bit(&i, partial_type)) {
-		if (avrule_operation_num(rangelist, &ops, i))
+	while (xperms_for_each_bit(&i, partial_driver)) {
+		if (avrule_ioctl_func(rangelist, &xperms, i))
 			return -1;
 
-		if (ops) {
+		if (xperms) {
 			avrule = (avrule_t *) calloc(1, sizeof(avrule_t));
 			if (!avrule) {
 				yyerror("out of memory");
@@ -2329,15 +2322,45 @@ int define_te_avtab_operation(int which)
 			}
 			if (avrule_cpy(avrule, avrule_template))
 				return -1;
-			avrule->ops = ops;
+			avrule->xperms = xperms;
 			append_avrule(avrule);
 		}
 	}
 
 done:
-	if (partial_type)
-		free(partial_type);
+	if (partial_driver)
+		free(partial_driver);
+
+	return 0;
+}
+
+int define_te_avtab_extended_perms(int which)
+{
+	char *id;
+	unsigned int i;
+	avrule_t *avrule_template;
+
+	if (pass == 1) {
+		for (i = 0; i < 4; i++) {
+			while ((id = queue_remove(id_queue)))
+				free(id);
+		}
+		return 0;
+	}
 
+	/* populate avrule template with source/target/tclass */
+	if (define_te_avtab_xperms_helper(which, &avrule_template))
+		return -1;
+
+	id = queue_remove(id_queue);
+	if (strcmp(id,"ioctl") == 0) {
+		if (define_te_avtab_ioctl(avrule_template))
+			return -1;
+		free(id);
+	} else {
+		yyerror("only ioctl extended permissions are supported");
+		return -1;
+	}
 	return 0;
 }
 
@@ -2365,7 +2388,7 @@ int define_te_avtab_helper(int which, avrule_t ** rule)
 	avrule->line = policydb_lineno;
 	avrule->source_line = source_lineno;
 	avrule->source_filename = strdup(source_file);
-	avrule->ops = NULL;
+	avrule->xperms = NULL;
 	if (!avrule->source_filename) {
 		yyerror("out of memory");
 		return -1;
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 43c7c08..964baae 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -58,7 +58,7 @@ int define_roleattribute(void);
 int define_filename_trans(void);
 int define_sens(void);
 int define_te_avtab(int which);
-int define_te_avtab_operation(int which);
+int define_te_avtab_extended_perms(int which);
 int define_typealias(void);
 int define_typeattribute(void);
 int define_typebounds(void);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 059b7b8..d8b8ac0 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -126,6 +126,9 @@ typedef int (* require_func_t)(int pass);
 %token AUDITALLOW
 %token AUDITDENY
 %token DONTAUDIT
+%token ALLOWXPERM
+%token AUDITALLOWXPERM
+%token DONTAUDITXPERM
 %token SOURCE
 %token TARGET
 %token SAMEUSER
@@ -457,9 +460,9 @@ te_avtab_def		: allow_def
 			| auditdeny_def
 			| dontaudit_def
 			| neverallow_def
-			| operation_allow_def
-			| operation_auditallow_def
-			| operation_dontaudit_def
+			| xperm_allow_def
+			| xperm_auditallow_def
+			| xperm_dontaudit_def
 			;
 allow_def		: ALLOW names names ':' names names  ';'
 			{if (define_te_avtab(AVRULE_ALLOWED)) return -1; }
@@ -476,14 +479,14 @@ dontaudit_def		: DONTAUDIT names names ':' names names ';'
 neverallow_def		: NEVERALLOW names names ':' names names  ';'
 			{if (define_te_avtab(AVRULE_NEVERALLOW)) return -1; }
 		        ;
-operation_allow_def	: ALLOW names names ':' names  operations ';'
-			{if (define_te_avtab_operation(AVRULE_OPNUM_ALLOWED)) return -1; }
+xperm_allow_def		: ALLOWXPERM names names ':' names identifier xperms ';'
+			{if (define_te_avtab_extended_perms(AVRULE_XPERMS_ALLOWED)) return -1; }
 		        ;
-operation_auditallow_def: AUDITALLOW names names ':' names operations ';'
-			{if (define_te_avtab_operation(AVRULE_OPNUM_AUDITALLOW)) return -1; }
+xperm_auditallow_def	: AUDITALLOWXPERM names names ':' names identifier xperms ';'
+			{if (define_te_avtab_extended_perms(AVRULE_XPERMS_AUDITALLOW)) return -1; }
 		        ;
-operation_dontaudit_def	: DONTAUDIT names names ':' names operations ';'
-			{if (define_te_avtab_operation(AVRULE_OPNUM_DONTAUDIT)) return -1; }
+xperm_dontaudit_def	: DONTAUDITXPERM names names ':' names identifier xperms ';'
+			{if (define_te_avtab_extended_perms(AVRULE_XPERMS_DONTAUDIT)) return -1; }
 		        ;
 attribute_role_def	: ATTRIBUTE_ROLE identifier ';'
 			{if (define_attrib_role()) return -1; }
@@ -749,26 +752,26 @@ genfs_context_def	: GENFSCON filesystem path '-' identifier security_context_def
 ipv4_addr_def		: IPV4_ADDR
 			{ if (insert_id(yytext,0)) return -1; }
 			;
-operations		: operation
+xperms		: xperm
 			{ if (insert_separator(0)) return -1; }
-			| nested_operation_set
+			| nested_xperm_set
 			{ if (insert_separator(0)) return -1; }
-			| tilde operation
+			| tilde xperm
                         { if (insert_id("~", 0)) return -1; }
-			| tilde nested_operation_set
+			| tilde nested_xperm_set
 			{ if (insert_id("~", 0)) return -1;
 			  if (insert_separator(0)) return -1; }
 			;
-nested_operation_set	: '{' nested_operation_list '}'
+nested_xperm_set	: '{' nested_xperm_list '}'
 			;
-nested_operation_list	: nested_operation_element
-			| nested_operation_list nested_operation_element
+nested_xperm_list	: nested_xperm_element
+			| nested_xperm_list nested_xperm_element
 			;
-nested_operation_element: operation '-' { if (insert_id("-", 0)) return -1; } operation
-			| operation
-			| nested_operation_set
+nested_xperm_element: xperm '-' { if (insert_id("-", 0)) return -1; } xperm
+			| xperm
+			| nested_xperm_set
 			;
-operation		: number
+xperm		: number
                         { if (insert_id(yytext,0)) return -1; }
 			;
 security_context_def	: identifier ':' identifier ':' identifier opt_mls_range_def
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 108edbc..e94a917 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -142,6 +142,12 @@ AUDITDENY |
 auditdeny		        { return(AUDITDENY); }
 DONTAUDIT |
 dontaudit                       { return(DONTAUDIT); }
+ALLOWXPERM |
+allowxperm		        { return(ALLOWXPERM); }
+AUDITALLOWXPERM |
+auditallowxperm		        { return(AUDITALLOWXPERM); }
+DONTAUDITXPERM |
+dontauditxperm                  { return(DONTAUDITXPERM); }
 SOURCE |
 source			        { return(SOURCE); }
 TARGET |
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 157361a..0c6b8d8 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -54,11 +54,11 @@ int render_access_mask(uint32_t mask, avtab_key_t * key, policydb_t * p,
 	return 0;
 }
 
-#define operation_perm_test(x, p) (1 & (p[x >> 5] >> (x & 0x1f)))
+#define xperms_test(x, p) (1 & (p[x >> 5] >> (x & 0x1f)))
 #define next_bit_in_range(i, p) \
-	((i + 1 < sizeof(p)*8) && operation_perm_test((i + 1), p))
+	((i + 1 < sizeof(p)*8) && xperms_test((i + 1), p))
 
-int render_operations(avtab_operations_t *ops, avtab_key_t * key, FILE * fp)
+int render_ioctl(avtab_extended_perms_t * xperms, FILE * fp)
 {
 	uint16_t value;
 	uint16_t low_bit;
@@ -67,28 +67,28 @@ int render_operations(avtab_operations_t *ops, avtab_key_t * key, FILE * fp)
 	unsigned int in_range = 0;
 
 	fprintf(fp, "{ ");
-	for (bit = 0; bit < sizeof(ops->perms)*8; bit++) {
-		if (!operation_perm_test(bit, ops->perms))
+	for (bit = 0; bit < sizeof(xperms->perms)*8; bit++) {
+		if (!xperms_test(bit, xperms->perms))
 			continue;
 
-		if (in_range && next_bit_in_range(bit, ops->perms)) {
+		if (in_range && next_bit_in_range(bit, xperms->perms)) {
 			/* continue until high value found */
 			continue;
-		} else if (next_bit_in_range(bit, ops->perms)) {
+		} else if (next_bit_in_range(bit, xperms->perms)) {
 			/* low value */
 			low_bit = bit;
 			in_range = 1;
 			continue;
 		}
 
-		if (key->specified & AVTAB_OPNUM) {
-			value = ops->type<<8 | bit;
-			low_value = ops->type<<8 | low_bit;
+		if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
+			value = xperms->driver<<8 | bit;
+			low_value = xperms->driver<<8 | low_bit;
 			if (in_range)
 				fprintf(fp, "0x%hx-0x%hx ", low_value, value);
 			else
 				fprintf(fp, "0x%hx ", value);
-		} else if (key->specified & AVTAB_OPTYPE) {
+		} else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) {
 			value = bit << 8;
 			low_value = low_bit << 8;
 			if (in_range)
@@ -104,6 +104,15 @@ int render_operations(avtab_operations_t *ops, avtab_key_t * key, FILE * fp)
 	return 0;
 }
 
+int render_xperms(avtab_extended_perms_t * xperms, FILE * fp)
+{
+	if ((xperms->specified == AVTAB_XPERMS_IOCTLFUNCTION) ||
+			(xperms->specified == AVTAB_XPERMS_IOCTLDRIVER))
+		render_ioctl(xperms, fp);
+
+	return 0;
+}
+
 int render_type(uint32_t type, policydb_t * p, FILE * fp)
 {
 	fprintf(fp, "%s", p->p_type_val_to_name[type - 1]);
@@ -197,15 +206,15 @@ int render_av_rule(avtab_key_t * key, avtab_datum_t * datum, uint32_t what,
 			render_type(datum->data, p, fp);
 			fprintf(fp, ";\n");
 		}
-	} else if (key->specified & AVTAB_OP) {
-		if (key->specified & (AVTAB_OPNUM_ALLOWED|AVTAB_OPTYPE_ALLOWED))
-			fprintf(fp, "allow ");
-		else if (key->specified & (AVTAB_OPNUM_AUDITALLOW|AVTAB_OPTYPE_AUDITALLOW))
-			fprintf(fp, "auditallow ");
-		else if (key->specified & (AVTAB_OPNUM_DONTAUDIT|AVTAB_OPTYPE_DONTAUDIT))
-			fprintf(fp, "dontaudit ");
+	} else if (key->specified & AVTAB_XPERMS) {
+		if (key->specified & AVTAB_XPERMS_ALLOWED)
+			fprintf(fp, "allowxperm ");
+		else if (key->specified & AVTAB_XPERMS_AUDITALLOW)
+			fprintf(fp, "auditallowxperm ");
+		else if (key->specified & AVTAB_XPERMS_DONTAUDIT)
+			fprintf(fp, "dontauditxperm ");
 		render_key(key, p, fp);
-		render_operations(datum->ops, key, fp);
+		render_xperms(datum->xperms, fp);
 		fprintf(fp, ";\n");
 	} else {
 		fprintf(fp, "     ERROR: no valid rule type specified\n");
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index 2ea821c..14bc082 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -59,28 +59,28 @@ typedef struct avtab_key {
 #define AVTAB_MEMBER		0x0020
 #define AVTAB_CHANGE		0x0040
 #define AVTAB_TYPE		(AVTAB_TRANSITION | AVTAB_MEMBER | AVTAB_CHANGE)
-#define AVTAB_OPNUM_ALLOWED	0x0100
-#define AVTAB_OPNUM_AUDITALLOW	0x0200
-#define AVTAB_OPNUM_DONTAUDIT	0x0400
-#define AVTAB_OPNUM		(AVTAB_OPNUM_ALLOWED | AVTAB_OPNUM_AUDITALLOW | AVTAB_OPNUM_DONTAUDIT)
-#define AVTAB_OPTYPE_ALLOWED	0x1000
-#define AVTAB_OPTYPE_AUDITALLOW	0x2000
-#define AVTAB_OPTYPE_DONTAUDIT	0x4000
-#define AVTAB_OPTYPE		(AVTAB_OPTYPE_ALLOWED | AVTAB_OPTYPE_AUDITALLOW | AVTAB_OPTYPE_DONTAUDIT)
-#define AVTAB_OP		(AVTAB_OPNUM | AVTAB_OPTYPE)
+#define AVTAB_XPERMS_ALLOWED	0x0100
+#define AVTAB_XPERMS_AUDITALLOW	0x0200
+#define AVTAB_XPERMS_DONTAUDIT	0x0400
+#define AVTAB_XPERMS		(AVTAB_XPERMS_ALLOWED | AVTAB_XPERMS_AUDITALLOW | AVTAB_XPERMS_DONTAUDIT)
 #define AVTAB_ENABLED_OLD	0x80000000
 #define AVTAB_ENABLED		0x8000	/* reserved for used in cond_avtab */
 	uint16_t specified;	/* what fields are specified */
 } avtab_key_t;
 
-typedef struct avtab_operations {
-	uint8_t type;
+typedef struct avtab_extended_perms {
+
+#define AVTAB_XPERMS_IOCTLFUNCTION	0x01
+#define AVTAB_XPERMS_IOCTLDRIVER	0x02
+	/* extension of the avtab_key specified */
+	uint8_t specified;
+	uint8_t driver;
 	uint32_t perms[8];
-} avtab_operations_t;
+} avtab_extended_perms_t;
 
 typedef struct avtab_datum {
 	uint32_t data;		/* access vector or type */
-	avtab_operations_t *ops;
+	avtab_extended_perms_t *xperms;
 } avtab_datum_t;
 
 typedef struct avtab_node *avtab_ptr_t;
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 1d8310c..78b09c4 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -241,11 +241,14 @@ typedef struct class_perm_node {
 	struct class_perm_node *next;
 } class_perm_node_t;
 
-typedef struct av_operations {
-	uint8_t type;
-	/* 256 bits of ioctl number permissions */
+typedef struct av_extended_perms {
+#define AVRULE_XPERMS_IOCTLFUNCTION	0x01
+#define AVRULE_XPERMS_IOCTLDRIVER	0x02
+	uint8_t specified;
+	uint8_t driver;
+	/* 256 bits of permissions */
 	uint32_t perms[8];
-} av_operations_t;
+} av_extended_perms_t;
 
 typedef struct avrule {
 /* these typedefs are almost exactly the same as those in avtab.h - they are
@@ -260,24 +263,18 @@ typedef struct avrule {
 #define AVRULE_MEMBER			0x0020
 #define AVRULE_CHANGE			0x0040
 #define AVRULE_TYPE       (AVRULE_TRANSITION | AVRULE_MEMBER | AVRULE_CHANGE)
-#define AVRULE_OPNUM_ALLOWED 		0x0100
-#define AVRULE_OPNUM_AUDITALLOW		0x0200
-#define AVRULE_OPNUM_DONTAUDIT		0x0400
-#define AVRULE_OPNUM         (AVRULE_OPNUM_ALLOWED | AVRULE_OPNUM_AUDITALLOW | \
-				AVRULE_OPNUM_DONTAUDIT)
-#define AVRULE_OPTYPE_ALLOWED		0x1000
-#define AVRULE_OPTYPE_AUDITALLOW	0x2000
-#define AVRULE_OPTYPE_DONTAUDIT		0x4000
-#define AVRULE_OPTYPE         (AVRULE_OPTYPE_ALLOWED | AVRULE_OPTYPE_AUDITALLOW | \
-				AVRULE_OPTYPE_DONTAUDIT)
-#define AVRULE_OP         (AVRULE_OPNUM | AVRULE_OPTYPE)
+#define AVRULE_XPERMS_ALLOWED 		0x0100
+#define AVRULE_XPERMS_AUDITALLOW	0x0200
+#define AVRULE_XPERMS_DONTAUDIT		0x0400
+#define AVRULE_XPERMS	(AVRULE_XPERMS_ALLOWED | AVRULE_XPERMS_AUDITALLOW | \
+				AVRULE_XPERMS_DONTAUDIT)
 	uint32_t specified;
 #define RULE_SELF 1
 	uint32_t flags;
 	type_set_t stypes;
 	type_set_t ttypes;
 	class_perm_node_t *perms;
-	av_operations_t * ops;
+	av_extended_perms_t *xperms;
 	unsigned long line;	/* line number from policy.conf where
 				 * this rule originated  */
 	/* source file name and line number (e.g. .te file) */
@@ -709,11 +706,11 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_DEFAULT_TYPE	28
 #define POLICYDB_VERSION_CONSTRAINT_NAMES	29
 #define POLICYDB_VERSION_XEN_DEVICETREE		30 /* Xen-specific */
-#define POLICYDB_VERSION_IOCTL_OPERATIONS	30 /* Linux-specific */
+#define POLICYDB_VERSION_XPERMS_IOCTL	30 /* Linux-specific */
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_IOCTL_OPERATIONS
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_XPERMS_IOCTL
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index d3745fe..799b98f 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -93,7 +93,7 @@ avtab_insert_node(avtab_t * h, int hvalue, avtab_ptr_t prev, avtab_key_t * key,
 		  avtab_datum_t * datum)
 {
 	avtab_ptr_t newnode;
-	avtab_operations_t *ops;
+	avtab_extended_perms_t *xperms;
 
 	newnode = (avtab_ptr_t) malloc(sizeof(struct avtab_node));
 	if (newnode == NULL)
@@ -101,16 +101,16 @@ avtab_insert_node(avtab_t * h, int hvalue, avtab_ptr_t prev, avtab_key_t * key,
 	memset(newnode, 0, sizeof(struct avtab_node));
 	newnode->key = *key;
 
-	if (key->specified & AVTAB_OP) {
-		ops = calloc(1, sizeof(avtab_operations_t));
-		if (ops == NULL) {
+	if (key->specified & AVTAB_XPERMS) {
+		xperms = calloc(1, sizeof(avtab_extended_perms_t));
+		if (xperms == NULL) {
 			free(newnode);
 			return NULL;
 		}
-		if (datum->ops) /* else caller populates ops*/
-			*ops = *(datum->ops);
+		if (datum->xperms) /* else caller populates xperms */
+			*xperms = *(datum->xperms);
 
-		newnode->datum.ops = ops;
+		newnode->datum.xperms = xperms;
 	} else {
 		newnode->datum = *datum;
 	}
@@ -144,7 +144,8 @@ int avtab_insert(avtab_t * h, avtab_key_t * key, avtab_datum_t * datum)
 		    key->target_type == cur->key.target_type &&
 		    key->target_class == cur->key.target_class &&
 		    (specified & cur->key.specified)) {
-			if (specified & AVTAB_OPNUM)
+			/* Extended permissions are not necessarily unique */
+			if (specified & AVTAB_XPERMS)
 				break;
 			return SEPOL_EEXIST;
 		}
@@ -416,12 +417,9 @@ static uint16_t spec_order[] = {
 	AVTAB_TRANSITION,
 	AVTAB_CHANGE,
 	AVTAB_MEMBER,
-	AVTAB_OPNUM_ALLOWED,
-	AVTAB_OPNUM_AUDITALLOW,
-	AVTAB_OPNUM_DONTAUDIT,
-	AVTAB_OPTYPE_ALLOWED,
-	AVTAB_OPTYPE_AUDITALLOW,
-	AVTAB_OPTYPE_DONTAUDIT
+	AVTAB_XPERMS_ALLOWED,
+	AVTAB_XPERMS_AUDITALLOW,
+	AVTAB_XPERMS_DONTAUDIT
 };
 
 int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
@@ -433,14 +431,14 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 	uint32_t buf32[8], items, items2, val;
 	avtab_key_t key;
 	avtab_datum_t datum;
-	avtab_operations_t ops;
+	avtab_extended_perms_t xperms;
 	unsigned set;
 	unsigned int i;
 	int rc;
 
 	memset(&key, 0, sizeof(avtab_key_t));
 	memset(&datum, 0, sizeof(avtab_datum_t));
-	memset(&ops, 0, sizeof(avtab_operations_t));
+	memset(&xperms, 0, sizeof(avtab_extended_perms_t));
 
 	if (vers < POLICYDB_VERSION_AVTAB) {
 		rc = next_entry(buf32, fp, sizeof(uint32_t));
@@ -533,26 +531,32 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 		return -1;
 	}
 
-	if ((vers < POLICYDB_VERSION_IOCTL_OPERATIONS) &&
-			(key.specified & AVTAB_OP)) {
-		ERR(fp->handle, "policy version %u does not support ioctl "
-				"operation rules and one was specified\n", vers);
+	if ((vers < POLICYDB_VERSION_XPERMS_IOCTL) &&
+			(key.specified & AVTAB_XPERMS)) {
+		ERR(fp->handle, "policy version %u does not support extended "
+				"permissions rules and one was specified\n", vers);
 		return -1;
-	} else if (key.specified & AVTAB_OP) {
+	} else if (key.specified & AVTAB_XPERMS) {
 		rc = next_entry(&buf8, fp, sizeof(uint8_t));
 		if (rc < 0) {
 			ERR(fp->handle, "truncated entry");
 			return -1;
 		}
-		ops.type = buf8;
+		xperms.specified = buf8;
+		rc = next_entry(&buf8, fp, sizeof(uint8_t));
+		if (rc < 0) {
+			ERR(fp->handle, "truncated entry");
+			return -1;
+		}
+		xperms.driver = buf8;
 		rc = next_entry(buf32, fp, sizeof(uint32_t)*8);
 		if (rc < 0) {
 			ERR(fp->handle, "truncated entry");
 			return -1;
 		}
-		for (i = 0; i < ARRAY_SIZE(ops.perms); i++)
-			ops.perms[i] = le32_to_cpu(buf32[i]);
-		datum.ops = &ops;
+		for (i = 0; i < ARRAY_SIZE(xperms.perms); i++)
+			xperms.perms[i] = le32_to_cpu(buf32[i]);
+		datum.xperms = &xperms;
 	} else {
 		rc = next_entry(buf32, fp, sizeof(uint32_t));
 		if (rc < 0) {
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index b999890..478eaff 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1604,24 +1604,25 @@ static int expand_range_trans(expand_state_t * state,
 static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
 				   avtab_t * avtab, avtab_key_t * key,
 				   cond_av_list_t ** cond,
-				   av_operations_t *operations)
+				   av_extended_perms_t *xperms)
 {
 	avtab_ptr_t node;
 	avtab_datum_t avdatum;
 	cond_av_list_t *nl;
-	int type_match = 0;
+	int match = 0;
 
-	/* AVTAB_OPNUM entries are not necessarily unique */
-	if (key->specified & AVTAB_OPNUM) {
+	/* AVTAB_XPERMS entries are not necessarily unique */
+	if (key->specified & AVTAB_XPERMS) {
 		node = avtab_search_node(avtab, key);
 		while (node) {
-			if (node->datum.ops->type == operations->type) {
-				type_match = 1;
+			if ((node->datum.xperms->specified == xperms->specified) &&
+				(node->datum.xperms->driver == xperms->driver)) {
+				match = 1;
 				break;
 			}
 			node = avtab_search_node_next(node, key->specified);
 		}
-		if (!type_match)
+		if (!match)
 			node = NULL;
 	} else {
 		node = avtab_search_node(avtab, key);
@@ -1780,11 +1781,11 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 				cond_av_list_t ** cond,
 				uint32_t stype, uint32_t ttype,
 				class_perm_node_t * perms, avtab_t * avtab,
-				int enabled, av_operations_t *operations)
+				int enabled, av_extended_perms_t *extended_perms)
 {
 	avtab_key_t avkey;
 	avtab_datum_t *avdatump;
-	avtab_operations_t *ops;
+	avtab_extended_perms_t *xperms;
 	avtab_ptr_t node;
 	class_perm_node_t *cur;
 	uint32_t spec = 0;
@@ -1802,22 +1803,14 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 		spec = AVTAB_AUDITDENY;
 	} else if (specified & AVRULE_NEVERALLOW) {
 		spec = AVTAB_NEVERALLOW;
-	} else if (specified & AVRULE_OPNUM_ALLOWED) {
-		spec = AVTAB_OPNUM_ALLOWED;
-	} else if (specified & AVRULE_OPNUM_AUDITALLOW) {
-		spec = AVTAB_OPNUM_AUDITALLOW;
-	} else if (specified & AVRULE_OPNUM_DONTAUDIT) {
+	} else if (specified & AVRULE_XPERMS_ALLOWED) {
+		spec = AVTAB_XPERMS_ALLOWED;
+	} else if (specified & AVRULE_XPERMS_AUDITALLOW) {
+		spec = AVTAB_XPERMS_AUDITALLOW;
+	} else if (specified & AVRULE_XPERMS_DONTAUDIT) {
 		if (handle && handle->disable_dontaudit)
 			return EXPAND_RULE_SUCCESS;
-		spec = AVTAB_OPNUM_DONTAUDIT;
-	} else if (specified & AVRULE_OPTYPE_ALLOWED) {
-		spec = AVTAB_OPTYPE_ALLOWED;
-	} else if (specified & AVRULE_OPTYPE_AUDITALLOW) {
-		spec = AVTAB_OPTYPE_AUDITALLOW;
-	} else if (specified & AVRULE_OPTYPE_DONTAUDIT) {
-		if (handle && handle->disable_dontaudit)
-			return EXPAND_RULE_SUCCESS;
-		spec = AVTAB_OPTYPE_DONTAUDIT;
+		spec = AVTAB_XPERMS_DONTAUDIT;
 	} else {
 		assert(0);	/* unreachable */
 	}
@@ -1829,7 +1822,7 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 		avkey.target_class = cur->tclass;
 		avkey.specified = spec;
 
-		node = find_avtab_node(handle, avtab, &avkey, cond, operations);
+		node = find_avtab_node(handle, avtab, &avkey, cond, extended_perms);
 		if (!node)
 			return EXPAND_RULE_ERROR;
 		if (enabled) {
@@ -1859,20 +1852,21 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 				avdatump->data &= ~cur->data;
 			else
 				avdatump->data = ~cur->data;
-		} else if (specified & AVRULE_OP) {
-			if (!avdatump->ops) {
-				ops = (avtab_operations_t *)
-					calloc(1, sizeof(avtab_operations_t));
-				if (!ops) {
+		} else if (specified & AVRULE_XPERMS) {
+			if (!avdatump->xperms) {
+				xperms = (avtab_extended_perms_t *)
+					calloc(1, sizeof(avtab_extended_perms_t));
+				if (!xperms) {
 					ERR(handle, "Out of memory!");
 					return -1;
 				}
-				node->datum.ops = ops;
-			}
-			node->datum.ops->type = operations->type;
-			for (i = 0; i < ARRAY_SIZE(operations->perms); i++) {
-				node->datum.ops->perms[i] |= operations->perms[i];
+				node->datum.xperms = xperms;
 			}
+			node->datum.xperms->specified = extended_perms->specified;
+			node->datum.xperms->driver = extended_perms->driver;
+
+			for (i = 0; i < ARRAY_SIZE(xperms->perms); i++)
+				node->datum.xperms->perms[i] |= extended_perms->perms[i];
 		} else {
 			assert(0);	/* should never occur */
 		}
@@ -1897,10 +1891,10 @@ static int expand_rule_helper(sepol_handle_t * handle,
 		if (!ebitmap_node_get_bit(snode, i))
 			continue;
 		if (source_rule->flags & RULE_SELF) {
-			if (source_rule->specified & (AVRULE_AV | AVRULE_OP)) {
+			if (source_rule->specified & (AVRULE_AV | AVRULE_XPERMS)) {
 				retval = expand_avrule_helper(handle, source_rule->specified,
 							      cond, i, i, source_rule->perms,
-							      dest_avtab, enabled, source_rule->ops);
+							      dest_avtab, enabled, source_rule->xperms);
 				if (retval != EXPAND_RULE_SUCCESS)
 					return retval;
 			} else {
@@ -1915,10 +1909,10 @@ static int expand_rule_helper(sepol_handle_t * handle,
 		ebitmap_for_each_bit(ttypes, tnode, j) {
 			if (!ebitmap_node_get_bit(tnode, j))
 				continue;
-			if (source_rule->specified & (AVRULE_AV | AVRULE_OP)) {
+			if (source_rule->specified & (AVRULE_AV | AVRULE_XPERMS)) {
 				retval = expand_avrule_helper(handle, source_rule->specified,
 							      cond, i, j, source_rule->perms,
-							      dest_avtab, enabled, source_rule->ops);
+							      dest_avtab, enabled, source_rule->xperms);
 				if (retval != EXPAND_RULE_SUCCESS)
 					return retval;
 			} else {
@@ -3155,24 +3149,25 @@ static int expand_avtab_insert(avtab_t * a, avtab_key_t * k, avtab_datum_t * d)
 {
 	avtab_ptr_t node;
 	avtab_datum_t *avd;
-	avtab_operations_t *ops;
+	avtab_extended_perms_t *xperms;
 	unsigned int i;
-	unsigned int type_match = 0;
+	unsigned int match = 0;
 
-	if (k->specified & AVTAB_OPNUM) {
+	if (k->specified & AVTAB_XPERMS) {
 		/*
-		 * AVTAB_OPNUM entries are not necessarily unique.
-		 * find node with matching ops->type
+		 * AVTAB_XPERMS entries are not necessarily unique.
+		 * find node with matching xperms
 		 */
 		node = avtab_search_node(a, k);
 		while (node) {
-			if (node->datum.ops->type == d->ops->type) {
-				type_match = 1;
+			if ((node->datum.xperms->specified == d->xperms->specified) &&
+				(node->datum.xperms->driver == d->xperms->driver)) {
+				match = 1;
 				break;
 			}
 			node = avtab_search_node_next(node, k->specified);
 		}
-		if (!type_match)
+		if (!match)
 			node = NULL;
 	} else {
 		node = avtab_search_node(a, k);
@@ -3189,7 +3184,7 @@ static int expand_avtab_insert(avtab_t * a, avtab_key_t * k, avtab_datum_t * d)
 	}
 
 	avd = &node->datum;
-	ops = node->datum.ops;
+	xperms = node->datum.xperms;
 	switch (k->specified & ~AVTAB_ENABLED) {
 	case AVTAB_ALLOWED:
 	case AVTAB_AUDITALLOW:
@@ -3198,14 +3193,11 @@ static int expand_avtab_insert(avtab_t * a, avtab_key_t * k, avtab_datum_t * d)
 	case AVTAB_AUDITDENY:
 		avd->data &= d->data;
 		break;
-	case AVTAB_OPNUM_ALLOWED:
-	case AVTAB_OPNUM_AUDITALLOW:
-	case AVTAB_OPNUM_DONTAUDIT:
-	case AVTAB_OPTYPE_ALLOWED:
-	case AVTAB_OPTYPE_AUDITALLOW:
-	case AVTAB_OPTYPE_DONTAUDIT:
-		for (i = 0; i < ARRAY_SIZE(ops->perms); i++)
-			ops->perms[i] |= d->ops->perms[i];
+	case AVTAB_XPERMS_ALLOWED:
+	case AVTAB_XPERMS_AUDITALLOW:
+	case AVTAB_XPERMS_DONTAUDIT:
+		for (i = 0; i < ARRAY_SIZE(xperms->perms); i++)
+			xperms->perms[i] |= d->xperms->perms[i];
 		break;
 	default:
 		ERR(NULL, "Type conflict!");
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 8c3c7ac..1677eb5 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -180,7 +180,7 @@ static struct policydb_compat_info policydb_compat[] = {
 	},
 	{
 	 .type = POLICY_KERN,
-	 .version = POLICYDB_VERSION_IOCTL_OPERATIONS,
+	 .version = POLICYDB_VERSION_XPERMS_IOCTL,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 6e78eb3..d87ea61 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -221,28 +221,32 @@ static int avtab_write_item(policydb_t * p,
 	items = put_entry(buf16, sizeof(uint16_t), 4, fp);
 	if (items != 4)
 		return POLICYDB_ERROR;
-	if ((p->policyvers < POLICYDB_VERSION_IOCTL_OPERATIONS) &&
-			(cur->key.specified & AVTAB_OP)) {
-		ERR(fp->handle, "policy version %u does not support ioctl operation"
-				" rules and one was specified", p->policyvers);
+	if ((p->policyvers < POLICYDB_VERSION_XPERMS_IOCTL) &&
+			(cur->key.specified & AVTAB_XPERMS)) {
+		ERR(fp->handle, "policy version %u does not support ioctl extended"
+				"permissions rules and one was specified", p->policyvers);
 		return POLICYDB_ERROR;
 	}
 
 	if (p->target_platform != SEPOL_TARGET_SELINUX &&
-			(cur->key.specified & AVTAB_OP)) {
+			(cur->key.specified & AVTAB_XPERMS)) {
 		ERR(fp->handle, "Target platform %s does not support ioctl "
-				"operation rules and one was specified",
+				"extended permissions rules and one was specified",
 				policydb_target_strings[p->target_platform]);
 		return POLICYDB_ERROR;
 	}
 
-	if (cur->key.specified & AVTAB_OP) {
-		buf8 = cur->datum.ops->type;
+	if (cur->key.specified & AVTAB_XPERMS) {
+		buf8 = cur->datum.xperms->specified;
 		items = put_entry(&buf8, sizeof(uint8_t),1,fp);
 		if (items != 1)
 			return POLICYDB_ERROR;
-		for (i = 0; i < ARRAY_SIZE(cur->datum.ops->perms); i++)
-			buf32[i] = cpu_to_le32(cur->datum.ops->perms[i]);
+		buf8 = cur->datum.xperms->driver;
+		items = put_entry(&buf8, sizeof(uint8_t),1,fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+		for (i = 0; i < ARRAY_SIZE(cur->datum.xperms->perms); i++)
+			buf32[i] = cpu_to_le32(cur->datum.xperms->perms[i]);
 		items = put_entry(buf32, sizeof(uint32_t),8,fp);
 		if (items != 8)
 			return POLICYDB_ERROR;
@@ -1546,9 +1550,9 @@ static int avrule_write(avrule_t * avrule, struct policy_file *fp)
 	uint32_t buf[32], len;
 	class_perm_node_t *cur;
 
-	if (avrule->specified & AVRULE_OP) {
-		ERR(fp->handle, "module policy does not support ioctl operation"
-				" rules and one was specified");
+	if (avrule->specified & AVRULE_XPERMS) {
+		ERR(fp->handle, "module policy does not support extended"
+				" permissions rules and one was specified");
 		return POLICYDB_ERROR;
 	}
 
-- 
2.2.0.rc0.207.ga3a616c
