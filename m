Subject: Re: [PATCH 2/5] libsepol test commons
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com
In-Reply-To: <1154614656.4909.20.camel@twoface.columbia.tresys.com>
References: <1154614656.4909.20.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 11:26:11 -0400
Message-Id: <1154618771.9569.1.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-03 at 10:17 -0400, Joshua Brindle wrote:
> This adds the common functions that are used by more than one test and
> the debug files used for debugging tests.

updated for symtab_datum_t change

diff -pruN -x policies trunk.old/libsepol/tests/debug.c trunk/libsepol/tests/debug.c
--- trunk.old/libsepol/tests/debug.c	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/debug.c	2006-07-26 11:01:56.000000000 -0400
@@ -0,0 +1,69 @@
+/*
+ * Author: Joshua Brindle <jbrindle@tresys.com>
+ *
+ * Copyright (C) 2006 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/* This includes functions used to debug tests (display bitmaps, conditional expressions, etc */
+
+#include "debug.h"
+
+#include <stdlib.h>
+
+void print_ebitmap(ebitmap_t * bitmap, FILE * fp)
+{
+	uint32_t i;
+	for (i = 0; i < bitmap->highbit; i++) {
+		fprintf(fp, "%d", ebitmap_get_bit(bitmap, i));
+	}
+	fprintf(fp, "\n");
+}
+
+/* stolen from dispol.c */
+void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp)
+{
+
+	cond_expr_t *cur;
+	for (cur = exp; cur != NULL; cur = cur->next) {
+		switch (cur->expr_type) {
+		case COND_BOOL:
+			fprintf(fp, "%s ", p->p_bool_val_to_name[cur->bool - 1]);
+			break;
+		case COND_NOT:
+			fprintf(fp, "! ");
+			break;
+		case COND_OR:
+			fprintf(fp, "|| ");
+			break;
+		case COND_AND:
+			fprintf(fp, "&& ");
+			break;
+		case COND_XOR:
+			fprintf(fp, "^ ");
+			break;
+		case COND_EQ:
+			fprintf(fp, "== ");
+			break;
+		case COND_NEQ:
+			fprintf(fp, "!= ");
+			break;
+		default:
+			fprintf(fp, "error! (%d)", cur->expr_type);
+			break;
+		}
+	}
+}
diff -pruN -x policies trunk.old/libsepol/tests/debug.h trunk/libsepol/tests/debug.h
--- trunk.old/libsepol/tests/debug.h	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/debug.h	2006-07-26 11:01:56.000000000 -0400
@@ -0,0 +1,27 @@
+/*
+ * Author: Joshua Brindle <jbrindle@tresys.com>
+ *
+ * Copyright (C) 2006 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/* This includes functions used to debug tests (display bitmaps, conditional expressions, etc */
+
+#include <sepol/policydb/policydb.h>
+#include <sepol/policydb/conditional.h>
+
+extern void print_ebitmap(ebitmap_t * bitmap, FILE * fp);
+extern void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp);
diff -pruN -x policies trunk.old/libsepol/tests/test-common.c trunk/libsepol/tests/test-common.c
--- trunk.old/libsepol/tests/test-common.c	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-common.c	2006-08-02 13:27:49.000000000 -0400
@@ -0,0 +1,262 @@
+/*
+ * Author: Joshua Brindle <jbrindle@tresys.com>
+ *         Chad Sellers <csellers@tresys.com>
+ *         Chris PeBenito <cpebenito@tresys.com>
+ *
+ * Copyright (C) 2006 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/* This has tests that are common between test suites*/
+
+#include <sepol/policydb/avrule_block.h>
+
+#include <CUnit/Basic.h>
+
+void test_sym_presence(policydb_t * p, char *id, int sym_type, unsigned int scope_type, unsigned int *decls, unsigned int len)
+{
+	scope_datum_t *scope;
+	int found;
+	unsigned int i, j;
+	/* make sure it is in global symtab */
+	if (!hashtab_search(p->symtab[sym_type].table, id)) {
+		fprintf(stderr, "symbol %s not found in table %d\n", id, sym_type);
+		CU_FAIL_FATAL();
+	}
+	/* make sure its scope is correct */
+	scope = hashtab_search(p->scope[sym_type].table, id);
+	CU_ASSERT_FATAL(scope != NULL);
+	CU_ASSERT(scope->scope == scope_type);
+	CU_ASSERT(scope->decl_ids_len == len);
+	if (scope->decl_ids_len != len)
+		fprintf(stderr, "sym %s has %d decls, %d expected\n", id, scope->decl_ids_len, len);
+	for (i = 0; i < len; i++) {
+		found = 0;
+		for (j = 0; j < len; j++) {
+			if (decls[i] == scope->decl_ids[j])
+				found++;
+		}
+		CU_ASSERT(found == 1);
+	}
+
+}
+
+static int common_test_index(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	common_datum_t *d = (common_datum_t *) datum;
+	policydb_t *p = (policydb_t *) data;
+
+	CU_ASSERT(p->sym_val_to_name[SYM_COMMONS][d->s.value - 1] == (char *)key);
+	return 0;
+}
+
+static int class_test_index(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	class_datum_t *d = (class_datum_t *) datum;
+	policydb_t *p = (policydb_t *) data;
+
+	CU_ASSERT(p->sym_val_to_name[SYM_CLASSES][d->s.value - 1] == (char *)key);
+	CU_ASSERT(p->class_val_to_struct[d->s.value - 1] == d);
+	return 0;
+}
+
+static int role_test_index(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	role_datum_t *d = (role_datum_t *) datum;
+	policydb_t *p = (policydb_t *) data;
+
+	CU_ASSERT(p->sym_val_to_name[SYM_ROLES][d->s.value - 1] == (char *)key);
+	CU_ASSERT(p->role_val_to_struct[d->s.value - 1] == d);
+	return 0;
+}
+
+static int type_test_index(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	type_datum_t *d = (type_datum_t *) datum;
+	policydb_t *p = (policydb_t *) data;
+
+	if (!d->primary)
+		return 0;
+
+	CU_ASSERT(p->sym_val_to_name[SYM_TYPES][d->s.value - 1] == (char *)key);
+	CU_ASSERT(p->type_val_to_struct[d->s.value - 1] == d);
+
+	return 0;
+}
+
+static int user_test_index(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	user_datum_t *d = (user_datum_t *) datum;
+	policydb_t *p = (policydb_t *) data;
+
+	CU_ASSERT(p->sym_val_to_name[SYM_USERS][d->s.value - 1] == (char *)key);
+	CU_ASSERT(p->user_val_to_struct[d->s.value - 1] == d);
+	return 0;
+}
+
+static int cond_test_index(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	cond_bool_datum_t *d = (cond_bool_datum_t *) datum;
+	policydb_t *p = (policydb_t *) data;
+
+	CU_ASSERT(p->sym_val_to_name[SYM_BOOLS][d->s.value - 1] == (char *)key);
+	CU_ASSERT(p->bool_val_to_struct[d->s.value - 1] == d);
+	return 0;
+}
+
+static int level_test_index(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	level_datum_t *d = (level_datum_t *) datum;
+	policydb_t *p = (policydb_t *) data;
+
+	CU_ASSERT(p->sym_val_to_name[SYM_LEVELS][d->level->sens - 1] == (char *)key);
+	return 0;
+}
+
+static int cat_test_index(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	cat_datum_t *d = (cat_datum_t *) datum;
+	policydb_t *p = (policydb_t *) data;
+
+	CU_ASSERT(p->sym_val_to_name[SYM_CATS][d->s.value - 1] == (char *)key);
+	return 0;
+}
+
+static int (*test_index_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum, void *p) = {
+common_test_index, class_test_index, role_test_index, type_test_index, user_test_index, cond_test_index, level_test_index, cat_test_index,};
+
+void test_policydb_indexes(policydb_t * p)
+{
+	int i;
+
+	for (i = 0; i < SYM_NUM; i++) {
+		hashtab_map(p->symtab[i].table, test_index_f[i], p);
+	}
+}
+
+void test_alias_datum(policydb_t * p, char *id, char *primary_id, char mode, unsigned int flavor)
+{
+	type_datum_t *type, *primary;
+	unsigned int my_primary, my_flavor, my_value;
+
+	type = hashtab_search(p->p_types.table, id);
+	primary = hashtab_search(p->p_types.table, primary_id);
+
+	CU_ASSERT_PTR_NOT_NULL(type);
+	CU_ASSERT_PTR_NOT_NULL(primary);
+
+	if (type && primary) {
+		if (mode) {
+			my_flavor = type->flavor;
+		} else {
+			my_flavor = flavor;
+		}
+
+		if (my_flavor == TYPE_TYPE) {
+			my_primary = 0;
+			my_value = primary->s.value;
+		} else if (my_flavor == TYPE_ALIAS) {
+			my_primary = primary->s.value;
+			CU_ASSERT_NOT_EQUAL(type->s.value, primary->s.value);
+			my_value = type->s.value;
+		} else {
+			CU_FAIL("not an alias");
+		}
+
+		CU_ASSERT(type->primary == my_primary);
+		CU_ASSERT(type->flavor == my_flavor);
+		CU_ASSERT(type->s.value == my_value);
+	}
+}
+
+role_datum_t *test_role_type_set(policydb_t * p, char *id, avrule_decl_t * decl, char **types, unsigned int len, unsigned int flags)
+{
+	ebitmap_node_t *tnode;
+	unsigned int i, j, new, found = 0;
+	role_datum_t *role;
+
+	if (decl)
+		role = hashtab_search(decl->p_roles.table, id);
+	else
+		role = hashtab_search(p->p_roles.table, id);
+
+	if (!role)
+		printf("role %s can't be found! \n", id);
+
+	CU_ASSERT_FATAL(role != NULL);
+
+	ebitmap_for_each_bit(&role->types.types, tnode, i) {
+		if (ebitmap_node_get_bit(tnode, i)) {
+			new = 0;
+			for (j = 0; j < len; j++) {
+				if (strcmp(p->sym_val_to_name[SYM_TYPES][i], types[j]) == 0) {
+					found++;
+					new = 1;
+				}
+			}
+			if (new == 0) {
+				printf("\nRole %s had type %s not in types array\n", id, p->sym_val_to_name[SYM_TYPES][i]);
+			}
+			CU_ASSERT(new == 1);
+		}
+	}
+	CU_ASSERT(found == len);
+	if (found != len)
+		printf("\nrole %s has %d types, %d expected\n", p->sym_val_to_name[SYM_ROLES][role->s.value - 1], found, len);
+	/* roles should never have anything in the negset */
+	CU_ASSERT(role->types.negset.highbit == 0);
+	CU_ASSERT(role->types.flags == flags);
+
+	return role;
+}
+
+void test_attr_types(policydb_t * p, char *id, avrule_decl_t * decl, char **types, int len)
+{
+	ebitmap_node_t *tnode;
+	int j, new, found = 0;
+	unsigned int i;
+	type_datum_t *attr;
+
+	if (decl)
+		attr = hashtab_search(decl->p_types.table, id);
+	else
+		attr = hashtab_search(p->p_types.table, id);
+
+	if (attr == NULL)
+		printf("could not find attr %s in decl %d\n", id, decl->decl_id);
+	CU_ASSERT_FATAL(attr != NULL);
+	CU_ASSERT(attr->flavor == TYPE_ATTRIB);
+	CU_ASSERT(attr->primary == 1);
+
+	ebitmap_for_each_bit(&attr->types, tnode, i) {
+		if (ebitmap_node_get_bit(tnode, i)) {
+			new = 0;
+			for (j = 0; j < len; j++) {
+				if (strcmp(p->sym_val_to_name[SYM_TYPES][i], types[j]) == 0) {
+					found++;
+					new = 1;
+				}
+			}
+			if (new == 0) {
+				printf("\nattr %s had type %s not in types array\n", id, p->sym_val_to_name[SYM_TYPES][i]);
+			}
+			CU_ASSERT(new == 1);
+		}
+	}
+	CU_ASSERT(found == len);
+	if (found != len)
+		printf("\nattr %s has %d types, %d expected\n", id, found, len);
+}
diff -pruN -x policies trunk.old/libsepol/tests/test-common.h trunk/libsepol/tests/test-common.h
--- trunk.old/libsepol/tests/test-common.h	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-common.h	2006-08-02 13:27:49.000000000 -0400
@@ -0,0 +1,78 @@
+/*
+ * Author: Joshua Brindle <jbrindle@tresys.com>
+ *         Chad Sellers <csellers@tresys.com>
+ *
+ * Copyright (C) 2006 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __TEST_COMMON_H__
+#define __TEST_COMMON_H__
+
+#include <sepol/policydb/policydb.h>
+
+/* p		the policy being inspected
+ * id		string symbol identifier
+ * sym_type	symbol type (eg., SYM_ROLES, SYM_TYPES)
+ * scope_type	what scope the role should have (eg., SCOPE_DECL or SCOPE_REQ)
+ * decls	integer array of decl id's that we expect the role to have in the scope table
+ * len		number of elements in decls
+ * 
+ * This is a utility function to test for the symbol's presence in the global symbol table, 
+ * the scope table, and that the decl blocks we think this symbol is in are correct
+ */
+extern void test_sym_presence(policydb_t * p, char *id, int sym_type, unsigned int scope_type, unsigned int *decls, unsigned int len);
+
+/* Test the indexes in the policydb to ensure their correctness. These include
+ * the sym_val_to_name[], class_val_to_struct, role_val_to_struct, type_val_to_struct,
+ * user_val_to_struct, and bool_val_to_struct indexes.
+ */
+extern void test_policydb_indexes(policydb_t * p);
+
+/* Test alias datum to ensure that it is as expected
+ *
+ * id = the key for the alias
+ * primary_id = the key for its primary
+ * mode: 0 = test the datum according to the flavor value in the call
+         1 = automatically detect the flavor value and test the datum accordingly
+ * flavor = flavor value if in mode 0
+ */
+extern void test_alias_datum(policydb_t * p, char *id, char *primary_id, char mode, unsigned int flavor);
+
+/* p		the policy being inspected
+ * id		string role identifier
+ * decl		the decl block which we are looking in for the role datum
+ * types	the array of string types which we expect the role has in its type ebitmap
+ * len		number of elements in types
+ * flags	the expected flags in the role typeset (eg., * or ~)
+ *
+ * This is a utility function to test whether the type set associated with a role in a specific
+ * avrule decl block matches our expectations
+ */
+extern role_datum_t *test_role_type_set(policydb_t * p, char *id, avrule_decl_t * decl, char **types, unsigned int len, unsigned int flags);
+
+/* p		the policy being inspected
+ * id		string attribute identifier
+ * decl		the decl block which we are looking in for the attribute datum
+ * types	the array of string types which we expect the attribute has in its type ebitmap
+ * len		number of elements in types
+ *
+ * This is a utility function to test whether the type set associated with an attribute in a specific
+ * avrule decl block matches our expectations 
+ */
+extern void test_attr_types(policydb_t * p, char *id, avrule_decl_t * decl, char **types, int len);
+
+#endif



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
