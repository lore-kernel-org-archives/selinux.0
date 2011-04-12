Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3CIiN43012051
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2011 14:44:24 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3CIiMjr004802
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2011 18:44:23 GMT
From: Eric Paris <eparis@redhat.com>
To: slawrence@tresys.com
Cc: selinux@tycho.nsa.gov, qingtao.cao@windriver.com, dwalsh@redhat.com,
        eparis@redhat.com
Subject: [PATCH 1/2] libsepol: add support for filenametrans rule
Date: Tue, 12 Apr 2011 14:45:36 -0400
Message-Id: <1302633937-25134-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds libsepol support for filename_trans rules.  These rules
allow one to make labeling decisions for new objects based partially on
the last path component.  They are stored in a list.  If we find that
the number of rules grows to an significant size I will likely choose to
store these in a hash, both in libsepol and in the kernel.  But as long
as the number of such rules stays small, this should be good.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libsepol/include/sepol/policydb/policydb.h |   29 +++++
 libsepol/src/avrule_block.c                |    1 +
 libsepol/src/expand.c                      |   98 ++++++++++++++++
 libsepol/src/link.c                        |   49 ++++++++
 libsepol/src/policydb.c                    |  170 ++++++++++++++++++++++++++++
 libsepol/src/write.c                       |   85 ++++++++++++++
 6 files changed, 432 insertions(+), 0 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 94b8609..eebf1a9 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -136,6 +136,16 @@ typedef struct role_allow {
 	struct role_allow *next;
 } role_allow_t;
 
+/* filename_trans rules */
+typedef struct filename_trans {
+	uint32_t stype;
+	uint32_t ttype;
+	uint32_t tclass;
+	char *name;
+	uint32_t otype;
+	struct filename_trans *next;
+} filename_trans_t;
+
 /* Type attributes */
 typedef struct type_datum {
 	symtab_datum_t s;
@@ -247,6 +257,15 @@ typedef struct role_allow_rule {
 	struct role_allow_rule *next;
 } role_allow_rule_t;
 
+typedef struct filename_trans_rule {
+	type_set_t stypes;
+	type_set_t ttypes;
+	uint32_t tclass;
+	char *name;
+	uint32_t otype;	/* new type */
+	struct filename_trans_rule *next;
+} filename_trans_rule_t;
+
 typedef struct range_trans_rule {
 	type_set_t stypes;
 	type_set_t ttypes;
@@ -376,6 +395,9 @@ typedef struct avrule_decl {
 	scope_index_t required;	/* symbols needed to activate this block */
 	scope_index_t declared;	/* symbols declared within this block */
 
+	/* type transition rules with a 'name' component */
+	filename_trans_rule_t *filename_trans_rules;
+
 	/* for additive statements (type attribute, roles, and users) */
 	symtab_t symtab[SYM_NUM];
 
@@ -486,6 +508,9 @@ typedef struct policydb {
 	/* role transitions */
 	role_trans_t *role_tr;
 
+	/* type transition rules with a 'name' component */
+	filename_trans_t *filename_trans;
+
 	/* role allows */
 	role_allow_t *role_allow;
 
@@ -564,6 +589,8 @@ extern void avrule_destroy(avrule_t * x);
 extern void avrule_list_destroy(avrule_t * x);
 extern void role_trans_rule_init(role_trans_rule_t * x);
 extern void role_trans_rule_list_destroy(role_trans_rule_t * x);
+extern void filename_trans_rule_init(filename_trans_rule_t * x);
+extern void filename_trans_rule_list_destroy(filename_trans_rule_t * x);
 
 extern void role_datum_init(role_datum_t * x);
 extern void role_datum_destroy(role_datum_t * x);
@@ -632,6 +659,7 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_POLCAP		22
 #define POLICYDB_VERSION_PERMISSIVE	23
 #define POLICYDB_VERSION_BOUNDARY	24
+#define POLICYDB_VERSION_FILENAME_TRANS	25
 #define POLICYDB_VERSION_ROLETRANS	26
 
 /* Range of policy versions we understand*/
@@ -648,6 +676,7 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define MOD_POLICYDB_VERSION_PERMISSIVE		8
 #define MOD_POLICYDB_VERSION_BOUNDARY		9
 #define MOD_POLICYDB_VERSION_BOUNDARY_ALIAS	10
+#define MOD_POLICYDB_VERSION_FILENAME_TRANS	11
 #define MOD_POLICYDB_VERSION_ROLETRANS		12
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
index 8d1f8f6..16c89f3 100644
--- a/libsepol/src/avrule_block.c
+++ b/libsepol/src/avrule_block.c
@@ -98,6 +98,7 @@ void avrule_decl_destroy(avrule_decl_t * x)
 	cond_list_destroy(x->cond_list);
 	avrule_list_destroy(x->avrules);
 	role_trans_rule_list_destroy(x->role_tr_rules);
+	filename_trans_rule_list_destroy(x->filename_trans_rules);
 	role_allow_rule_list_destroy(x->role_allow_rules);
 	range_trans_rule_list_destroy(x->range_tr_rules);
 	scope_index_destroy(&x->required);
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 8539f88..b1af365 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1237,6 +1237,101 @@ static int copy_role_trans(expand_state_t * state, role_trans_rule_t * rules)
 	return 0;
 }
 
+static int expand_filename_trans(expand_state_t *state, filename_trans_rule_t *rules)
+{
+	unsigned int i, j;
+	filename_trans_t *new_trans, *tail, *cur_trans;
+	filename_trans_rule_t *cur_rule;
+	ebitmap_t stypes, ttypes;
+	ebitmap_node_t *snode, *tnode;
+
+	/* start at the end of the list */
+	tail = state->out->filename_trans;
+	while (tail && tail->next)
+		tail = tail->next;
+
+	cur_rule = rules;
+	while (cur_rule) {
+		ebitmap_init(&stypes);
+		ebitmap_init(&ttypes);
+
+		if (expand_convert_type_set(state->out, state->typemap,
+					    &cur_rule->stypes, &stypes, 1)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
+		if (expand_convert_type_set(state->out, state->typemap,
+					    &cur_rule->ttypes, &ttypes, 1)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
+		ebitmap_for_each_bit(&stypes, snode, i) {
+			if (!ebitmap_node_get_bit(snode, i))
+				continue;
+			ebitmap_for_each_bit(&ttypes, tnode, j) {
+				if (!ebitmap_node_get_bit(tnode, j))
+					continue;
+
+				cur_trans = state->out->filename_trans;
+				while (cur_trans) {
+					if ((cur_trans->stype == i + 1) &&
+					    (cur_trans->ttype == j + 1) &&
+					    (cur_trans->tclass == cur_rule->tclass) &&
+					    (!strcmp(cur_trans->name, cur_rule->name))) {
+						/* duplicate rule, who cares */
+						if (cur_trans->otype == cur_rule->otype)
+							break;
+
+						ERR(state->handle, "Conflicting filename trans rules %s %s %s : %s otype1:%s otype2:%s",
+						    cur_trans->name,
+						    state->out->p_type_val_to_name[i],
+						    state->out->p_type_val_to_name[j],
+						    state->out->p_class_val_to_name[cur_trans->tclass - 1],
+						    state->out->p_type_val_to_name[cur_trans->otype - 1],
+						    state->out->p_type_val_to_name[state->typemap[cur_rule->otype - 1] - 1]);
+						    
+						return -1;
+					}
+					cur_trans = cur_trans->next;
+				}
+				/* duplicate rule, who cares */
+				if (cur_trans)
+					continue;
+
+				new_trans = malloc(sizeof(*new_trans));
+				if (!new_trans) {
+					ERR(state->handle, "Out of memory!");
+					return -1;
+				}
+				memset(new_trans, 0, sizeof(*new_trans));
+				if (tail)
+					tail->next = new_trans;
+				else
+					state->out->filename_trans = new_trans;
+				tail = new_trans;
+
+				new_trans->name = strdup(cur_rule->name);
+				if (!new_trans->name) {
+					ERR(state->handle, "Out of memory!");
+					return -1;
+				}
+				new_trans->stype = i + 1;
+				new_trans->ttype = j + 1;
+				new_trans->tclass = cur_rule->tclass;
+				new_trans->otype = state->typemap[cur_rule->otype - 1];
+			}
+		}
+
+		ebitmap_destroy(&stypes);
+		ebitmap_destroy(&ttypes);
+
+		cur_rule = cur_rule->next;
+	}
+	return 0;
+}
+
 static int exp_rangetr_helper(uint32_t stype, uint32_t ttype, uint32_t tclass,
 			      mls_semantic_range_t * trange,
 			      expand_state_t * state)
@@ -2380,6 +2475,9 @@ static int copy_and_expand_avrule_block(expand_state_t * state)
 			goto cleanup;
 		}
 
+		if (expand_filename_trans(state, decl->filename_trans_rules))
+			goto cleanup;
+
 		/* expand the range transition rules */
 		if (expand_range_trans(state, decl->range_tr_rules))
 			goto cleanup;
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index e33db0f..23dbb1b 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1340,6 +1340,50 @@ static int copy_role_allow_list(role_allow_rule_t * list,
 	return -1;
 }
 
+static int copy_filename_trans_list(filename_trans_rule_t * list,
+				    filename_trans_rule_t ** dst,
+				    policy_module_t * module,
+				    link_state_t * state)
+{
+	filename_trans_rule_t *cur, *new_rule, *tail;
+
+	cur = list;
+	tail = *dst;
+	while (tail && tail->next)
+		tail = tail->next;
+
+	while (cur) {
+		new_rule = malloc(sizeof(*new_rule));
+		if (!new_rule)
+			goto err;
+
+		filename_trans_rule_init(new_rule);
+
+		if (*dst == NULL)
+			*dst = new_rule;
+		else
+			tail->next = new_rule;
+		tail = new_rule;
+
+		new_rule->name = strdup(cur->name);
+		if (!new_rule->name)
+			goto err;
+
+		if (type_set_or_convert(&cur->stypes, &new_rule->stypes, module, state) ||
+		    type_set_or_convert(&cur->ttypes, &new_rule->ttypes, module, state))
+			goto err;
+
+		new_rule->tclass = module->map[SYM_CLASSES][cur->tclass - 1];
+		new_rule->otype = module->map[SYM_TYPES][cur->otype - 1];
+
+		cur = cur->next;
+	}
+	return 0;
+err:
+	ERR(state->handle, "Out of memory!");
+	return -1;
+}
+
 static int copy_range_trans_list(range_trans_rule_t * rules,
 				 range_trans_rule_t ** dst,
 				 policy_module_t * mod, link_state_t * state)
@@ -1582,6 +1626,11 @@ static int copy_avrule_decl(link_state_t * state, policy_module_t * module,
 		return -1;
 	}
 
+	if (copy_filename_trans_list(src_decl->filename_trans_rules,
+				     &dest_decl->filename_trans_rules,
+				     module, state))
+		return -1;
+
 	if (copy_range_trans_list(src_decl->range_tr_rules,
 				  &dest_decl->range_tr_rules, module, state))
 		return -1;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index bbf3c88..2ecb636 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -138,6 +138,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	},
 	{
 	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_FILENAME_TRANS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
+	{
+	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_ROLETRANS,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
@@ -194,6 +201,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	},
 	{
 	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_FILENAME_TRANS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
+	{
+	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_ROLETRANS,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
@@ -250,6 +264,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	},
 	{
 	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_FILENAME_TRANS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
+	{
+	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_ROLETRANS,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = 0,
@@ -456,6 +477,33 @@ void role_trans_rule_list_destroy(role_trans_rule_t * x)
 	}
 }
 
+void filename_trans_rule_init(filename_trans_rule_t * x)
+{
+	memset(x, 0, sizeof(*x));
+	type_set_init(&x->stypes);
+	type_set_init(&x->ttypes);
+}
+
+static void filename_trans_rule_destroy(filename_trans_rule_t * x)
+{
+	if (!x)
+		return;
+	type_set_destroy(&x->stypes);
+	type_set_destroy(&x->ttypes);
+	free(x->name);
+}
+
+void filename_trans_rule_list_destroy(filename_trans_rule_t * x)
+{
+	filename_trans_rule_t *next;
+	while (x) {
+		next = x->next;
+		filename_trans_rule_destroy(x);
+		free(x);
+		x = next;
+	}
+}
+
 void role_allow_rule_init(role_allow_rule_t * x)
 {
 	memset(x, 0, sizeof(role_allow_rule_t));
@@ -1135,6 +1183,7 @@ void policydb_destroy(policydb_t * p)
 	role_allow_t *ra, *lra = NULL;
 	role_trans_t *tr, *ltr = NULL;
 	range_trans_t *rt, *lrt = NULL;
+	filename_trans_t *ft, *nft;
 
 	if (!p)
 		return;
@@ -1200,6 +1249,14 @@ void policydb_destroy(policydb_t * p)
 	if (ltr)
 		free(ltr);
 
+	ft = p->filename_trans;
+	while (ft) {
+		nft = ft->next;
+		free(ft->name);
+		free(ft);
+		ft = nft;
+	}
+
 	for (ra = p->role_allow; ra; ra = ra->next) {
 		if (lra)
 			free(lra);
@@ -2201,6 +2258,55 @@ int role_allow_read(role_allow_t ** r, struct policy_file *fp)
 	return 0;
 }
 
+int filename_trans_read(filename_trans_t **t, struct policy_file *fp)
+{
+	unsigned int i;
+	uint32_t buf[4], nel, len;
+	filename_trans_t *ft, *lft;
+	int rc;
+	char *name;
+
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+	nel = le32_to_cpu(buf[0]);
+
+	lft = NULL;
+	for (i = 0; i < nel; i++) {
+		ft = calloc(1, sizeof(struct filename_trans));
+		if (!ft)
+			return -1;
+		if (lft)
+			lft->next = ft;
+		else
+			*t = ft;
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
+			return -1;
+		len = le32_to_cpu(buf[0]);
+
+		name = calloc(len, sizeof(*name));
+		if (!name)
+			return -1;
+
+		ft->name = name;
+
+		rc = next_entry(name, fp, len);
+		if (rc < 0)
+			return -1;
+
+		rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
+		if (rc < 0)
+			return -1;
+
+		ft->stype = le32_to_cpu(buf[0]);
+		ft->ttype = le32_to_cpu(buf[1]);
+		ft->tclass = le32_to_cpu(buf[2]);
+		ft->otype = le32_to_cpu(buf[3]);
+	}
+	return 0;
+}
+
 static int ocontext_read_xen(struct policydb_compat_info *info,
 	policydb_t *p, struct policy_file *fp)
 {
@@ -3007,6 +3113,62 @@ static int role_allow_rule_read(role_allow_rule_t ** r, struct policy_file *fp)
 	return 0;
 }
 
+static int filename_trans_rule_read(filename_trans_rule_t ** r, struct policy_file *fp)
+{
+	uint32_t buf[2], nel;
+	unsigned int i, len;
+	filename_trans_rule_t *ftr, *lftr;
+	int rc;
+
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+	nel = le32_to_cpu(buf[0]);
+	lftr = NULL;
+	for (i = 0; i < nel; i++) {
+		ftr = malloc(sizeof(*ftr));
+		if (!ftr)
+			return -1;
+
+		filename_trans_rule_init(ftr);
+
+		if (lftr)
+			lftr->next = ftr;
+		else
+			*r = ftr;
+		lftr = ftr;
+
+		rc = next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
+			return -1;
+
+		len = le32_to_cpu(buf[0]);
+
+		ftr->name = malloc(len + 1);
+		if (!ftr->name)
+			return -1;
+
+		rc = next_entry(ftr->name, fp, len);
+		if (rc)
+			return -1;
+		ftr->name[len] = 0;
+
+		if (type_set_read(&ftr->stypes, fp))
+			return -1;
+
+		if (type_set_read(&ftr->ttypes, fp))
+			return -1;
+
+		rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
+		if (rc < 0)
+			return -1;
+		ftr->tclass = le32_to_cpu(buf[0]);
+		ftr->otype = le32_to_cpu(buf[1]);
+	}
+
+	return 0;
+}
+
 static int range_trans_rule_read(range_trans_rule_t ** r,
 				 struct policy_file *fp)
 {
@@ -3100,6 +3262,11 @@ static int avrule_decl_read(policydb_t * p, avrule_decl_t * decl,
 	    role_allow_rule_read(&decl->role_allow_rules, fp) == -1) {
 		return -1;
 	}
+
+	if (p->policyvers >= MOD_POLICYDB_VERSION_FILENAME_TRANS &&
+	    filename_trans_rule_read(&decl->filename_trans_rules, fp))
+		return -1;
+
 	if (p->policyvers >= MOD_POLICYDB_VERSION_RANGETRANS &&
 	    range_trans_rule_read(&decl->range_tr_rules, fp) == -1) {
 		return -1;
@@ -3491,6 +3658,9 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 			goto bad;
 		if (role_allow_read(&p->role_allow, fp))
 			goto bad;
+		if (r_policyvers >= POLICYDB_VERSION_FILENAME_TRANS &&
+		    filename_trans_read(&p->filename_trans, fp))
+			goto bad;
 	} else {
 		/* first read the AV rule blocks, then the scope tables */
 		avrule_block_destroy(p->global);
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index f9d59b6..c4f5035 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -528,6 +528,42 @@ static int role_allow_write(role_allow_t * r, struct policy_file *fp)
 	return POLICYDB_SUCCESS;
 }
 
+static int filename_trans_write(filename_trans_t * r, struct policy_file *fp)
+{
+	filename_trans_t *ft;
+	uint32_t buf[4];
+	size_t nel, items, len;
+
+	nel = 0;
+	for (ft = r; ft; ft = ft->next)
+		nel++;
+	buf[0] = cpu_to_le32(nel);
+	items = put_entry(buf, sizeof(uint32_t), 1, fp);
+	if (items != 1)
+		return POLICYDB_ERROR;
+	for (ft = r; ft; ft = ft->next) {
+		len = strlen(ft->name);
+		buf[0] = cpu_to_le32(len);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+
+		items = put_entry(ft->name, sizeof(char), len, fp);
+		if (items != len)
+			return POLICYDB_ERROR;
+
+		buf[0] = cpu_to_le32(ft->stype);
+		buf[1] = cpu_to_le32(ft->ttype);
+		buf[2] = cpu_to_le32(ft->tclass);
+		buf[3] = cpu_to_le32(ft->otype);
+		items = put_entry(buf, sizeof(uint32_t), 4, fp);
+		if (items != 4)
+			return POLICYDB_ERROR;
+	}
+
+	return POLICYDB_SUCCESS;
+}
+
 static int role_set_write(role_set_t * x, struct policy_file *fp)
 {
 	size_t items;
@@ -1496,6 +1532,47 @@ static int role_allow_rule_write(role_allow_rule_t * r, struct policy_file *fp)
 	return POLICYDB_SUCCESS;
 }
 
+static int filename_trans_rule_write(filename_trans_rule_t * t, struct policy_file *fp)
+{
+	int nel = 0;
+	size_t items;
+	uint32_t buf[2], len;
+	filename_trans_rule_t *ftr;
+
+	for (ftr = t; ftr; ftr = ftr->next)
+		nel++;
+
+	buf[0] = cpu_to_le32(nel);
+	items = put_entry(buf, sizeof(uint32_t), 1, fp);
+	if (items != 1)
+		return POLICYDB_ERROR;
+
+	for (ftr = t; ftr; ftr = ftr->next) {
+		len = strlen(ftr->name);
+		buf[0] = cpu_to_le32(len);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+
+		items = put_entry(ftr->name, sizeof(char), len, fp);
+		if (items != len)
+			return POLICYDB_ERROR;
+
+		if (type_set_write(&ftr->stypes, fp))
+			return POLICYDB_ERROR;
+		if (type_set_write(&ftr->ttypes, fp))
+			return POLICYDB_ERROR;
+
+		buf[0] = cpu_to_le32(ftr->tclass);
+		buf[1] = cpu_to_le32(ftr->otype);
+
+		items = put_entry(buf, sizeof(uint32_t), 2, fp);
+		if (items != 2)
+			return POLICYDB_ERROR;
+	}
+	return POLICYDB_SUCCESS;
+}
+
 static int range_trans_rule_write(range_trans_rule_t * t,
 				  struct policy_file *fp)
 {
@@ -1563,6 +1640,11 @@ static int avrule_decl_write(avrule_decl_t * decl, int num_scope_syms,
 	    role_allow_rule_write(decl->role_allow_rules, fp) == -1) {
 		return POLICYDB_ERROR;
 	}
+
+	if (p->policyvers >= MOD_POLICYDB_VERSION_FILENAME_TRANS &&
+	    filename_trans_rule_write(decl->filename_trans_rules, fp))
+		return POLICYDB_ERROR;
+
 	if (p->policyvers >= MOD_POLICYDB_VERSION_RANGETRANS &&
 	    range_trans_rule_write(decl->range_tr_rules, fp) == -1) {
 		return POLICYDB_ERROR;
@@ -1839,6 +1921,9 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 			return POLICYDB_ERROR;
 		if (role_allow_write(p->role_allow, fp))
 			return POLICYDB_ERROR;
+		if (p->policyvers >= POLICYDB_VERSION_FILENAME_TRANS &&
+		    filename_trans_write(p->filename_trans, fp))
+			return POLICYDB_ERROR;
 	} else {
 		if (avrule_block_write(p->global, num_syms, p, fp) == -1) {
 			return POLICYDB_ERROR;
-- 
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
