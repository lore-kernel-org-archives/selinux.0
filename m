Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0FMvJaZ018323
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 17:57:19 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0FMwB1f003716
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 22:58:11 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l0FMwBb2010885
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 17:58:11 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l0FMwAZe016529
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 17:58:10 -0500
Received: from [10.11.14.46] (vpn-14-46.rdu.redhat.com [10.11.14.46])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l0FMw9ao013464
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 17:58:09 -0500
Message-ID: <45AC06E8.3020708@mentalrootkit.com>
Date: Mon, 15 Jan 2007 17:57:44 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: [PATCH] add central errno.h to libsepol
Content-Type: multipart/mixed;
 boundary="------------010104070105020504050804"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010104070105020504050804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch adds a central errno.h to libsepol and converts 
several existing error numbers. This will unify the error numbers, 
remove duplication, and prevent overlapping error numbers (a source of 
potential bugs). Existing return values from functions exposed as part 
of the binary interface are not changed.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

  checkpolicy/policy_parse.y                    |   15 ++---
  libsepol/include/sepol/errno.h                |   38 +++++++++++++
  libsepol/include/sepol/policydb/hashtab.h     |   43 ++++++++++-----
  libsepol/include/sepol/policydb/link.h        |   11 +--
  libsepol/src/avtab.c                          |   18 +++---
  libsepol/src/expand.c                         |    7 +-
  libsepol/src/hashtab.c                        |   45 +++++++++++-----
  libsepol/src/link.c                           |   33 ++++++-----
  libsepol/src/policydb.c                       |    6 +-
  libsepol/src/private.h                        |    4 +
  policycoreutils/semodule_deps/semodule_deps.c |    9 +--
  11 files changed, 156 insertions(+), 73 deletions(-)

--------------010104070105020504050804
Content-Type: text/x-patch;
 name="sepol-errno.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sepol-errno.patch"

diff -r ff3cba3a9a02 checkpolicy/policy_parse.y
--- a/checkpolicy/policy_parse.y	Thu Jan 11 16:25:56 2007 -0500
+++ b/checkpolicy/policy_parse.y	Sat Jan 13 19:28:54 2007 -0500
@@ -13,13 +13,14 @@
  * 	Added conditional policy language extensions
  *
  * Updated: Joshua Brindle <jbrindle@tresys.com>
- *	    Karl MacMillan <kmacmillan@tresys.com>
+ *	    Karl MacMillan <kmacmillan@mentalrootkit.com>
  *          Jason Tang     <jtang@tresys.com>
  *
  *	Added support for binary policy modules
  *
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2005 Tresys Technology, LLC
+ * Copyright (C) 2007 Red Hat Inc.
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
@@ -1059,11 +1060,11 @@ static int define_common_perms(void)
 	ret = hashtab_insert(policydbp->p_commons.table,
 			     (hashtab_key_t) id, (hashtab_datum_t) comdatum);
 
-	if (ret == HASHTAB_PRESENT) {
+	if (ret == SEPOL_EEXIST) {
 		yyerror("duplicate common definition");
 		goto bad;
 	}
-	if (ret == HASHTAB_OVERFLOW) {
+	if (ret == SEPOL_ENOMEM) {
 		yyerror("hash table overflow");
 		goto bad;
 	}
@@ -1091,14 +1092,14 @@ static int define_common_perms(void)
 				     (hashtab_key_t) perm,
 				     (hashtab_datum_t) perdatum);
 
-		if (ret == HASHTAB_PRESENT) {
+		if (ret == SEPOL_EEXIST) {
 			sprintf(errormsg,
 				"duplicate permission %s in common %s", perm,
 				id);
 			yyerror(errormsg);
 			goto bad_perm;
 		}
-		if (ret == HASHTAB_OVERFLOW) {
+		if (ret == SEPOL_ENOMEM) {
 			yyerror("hash table overflow");
 			goto bad_perm;
 		}
@@ -1220,12 +1221,12 @@ static int define_av_perms(int inherits)
 				     (hashtab_key_t) id,
 				     (hashtab_datum_t) perdatum);
 
-		if (ret == HASHTAB_PRESENT) {
+		if (ret == SEPOL_EEXIST) {
 			sprintf(errormsg, "duplicate permission %s", id);
 			yyerror(errormsg);
 			goto bad;
 		}
-		if (ret == HASHTAB_OVERFLOW) {
+		if (ret == SEPOL_ENOMEM) {
 			yyerror("hash table overflow");
 			goto bad;
 		}
diff -r ff3cba3a9a02 libsepol/include/sepol/errno.h
--- a/libsepol/include/sepol/errno.h	Thu Jan 11 16:25:56 2007 -0500
+++ b/libsepol/include/sepol/errno.h	Sat Jan 13 19:17:27 2007 -0500
@@ -0,0 +1,38 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __sepol_errno_h__
+#define __sepol_errno_h__
+
+#define SEPOL_OK             0
+#define SEPOL_ERR            -1
+#define SEPOL_ENOTSUP        -2  /* feature not supported in module language */
+#define SEPOL_EREQ           -3  /* requirements not met */
+#define SEPOL_ENOMEM         -10
+#define SEPOL_ERANGE         -11
+#define SEPOL_EEXIST         -12
+#define SEPOL_ENOENT         -13
+
+/* compatibility error codes */
+#define SEPOL_LINK_ERROR      SEPOL_ERR
+#define SEPOL_LINK_NOTSUP     SEPOL_ENOTSUP
+#define SEPOL_LINK_REQNOTMET  SEPOL_EREQ
+
+#endif
diff -r ff3cba3a9a02 libsepol/include/sepol/policydb/hashtab.h
--- a/libsepol/include/sepol/policydb/hashtab.h	Thu Jan 11 16:25:56 2007 -0500
+++ b/libsepol/include/sepol/policydb/hashtab.h	Sat Jan 13 19:24:19 2007 -0500
@@ -1,5 +1,25 @@
 
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+
+/*
+ * Updated : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
 
 /* FLASK */
 
@@ -14,8 +34,9 @@
 #ifndef _SEPOL_POLICYDB_HASHTAB_H_
 #define _SEPOL_POLICYDB_HASHTAB_H_
 
+#include <sepol/errno.h>
+
 #include <stdint.h>
-#include <errno.h>
 #include <stdio.h>
 
 typedef char *hashtab_key_t;	/* generic key type */
@@ -39,12 +60,6 @@ typedef struct hashtab_val {
 
 typedef hashtab_val_t *hashtab_t;
 
-/* Define status codes for hash table functions */
-#define HASHTAB_SUCCESS     0
-#define HASHTAB_OVERFLOW    -ENOMEM
-#define HASHTAB_PRESENT     -EEXIST
-#define HASHTAB_MISSING     -ENOENT
-
 /*
    Creates a new hash table with the specified characteristics.
 
@@ -61,9 +76,9 @@ extern hashtab_t hashtab_create(unsigned
 /*
    Inserts the specified (key, datum) pair into the specified hash table.
 
-   Returns HASHTAB_OVERFLOW if insufficient space is available or
-   HASHTAB_PRESENT  if there is already an entry with the same key or
-   HASHTAB_SUCCESS otherwise.
+   Returns SEPOL_ENOMEM if insufficient space is available or
+   SEPOL_EEXIST  if there is already an entry with the same key or
+   SEPOL_OK otherwise.
  */
 extern int hashtab_insert(hashtab_t h, hashtab_key_t k, hashtab_datum_t d);
 
@@ -72,8 +87,8 @@ extern int hashtab_insert(hashtab_t h, h
    Applies the specified destroy function to (key,datum,args) for
    the entry.
 
-   Returns HASHTAB_MISSING if no entry has the specified key or
-   HASHTAB_SUCCESS otherwise.
+   Returns SEPOL_ENOENT if no entry has the specified key or
+   SEPOL_OK otherwise.
  */
 extern int hashtab_remove(hashtab_t h, hashtab_key_t k,
 			  void (*destroy) (hashtab_key_t k,
@@ -86,8 +101,8 @@ extern int hashtab_remove(hashtab_t h, h
    then the specified destroy function is applied to (key,datum,args)
    for the entry prior to replacing the entry's contents.
 
-   Returns HASHTAB_OVERFLOW if insufficient space is available or
-   HASHTAB_SUCCESS otherwise.
+   Returns SEPOL_ENOMEM if insufficient space is available or
+   SEPOL_OK otherwise.
  */
 extern int hashtab_replace(hashtab_t h, hashtab_key_t k, hashtab_datum_t d,
 			   void (*destroy) (hashtab_key_t k,
diff -r ff3cba3a9a02 libsepol/include/sepol/policydb/link.h
--- a/libsepol/include/sepol/policydb/link.h	Thu Jan 11 16:25:56 2007 -0500
+++ b/libsepol/include/sepol/policydb/link.h	Sat Jan 13 19:25:08 2007 -0500
@@ -1,11 +1,12 @@
 /* Authors: Jason Tang <jtang@tresys.com>
  *	    Joshua Brindle <jbrindle@tresys.com>
- *          Karl MacMillan <kmacmillan@tresys.com>
+ *          Karl MacMillan <kmacmillan@mentalrootkit.com>
  *
  * A set of utility functions that aid policy decision when dealing
  * with hierarchal items.
  *
  * Copyright (C) 2005 Tresys Technology, LLC
+ * Copyright (C) 2007 Red Hat, Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -26,13 +27,11 @@
 #define _SEPOL_POLICYDB_LINK_H
 
 #include <sepol/handle.h>
+#include <sepol/errno.h>
 #include <sepol/policydb/policydb.h>
+
+
 #include <stddef.h>
-
-/* error codes */
-#define SEPOL_LINK_ERROR      1	/* general error */
-#define SEPOL_LINK_NOTSUP     2	/* feature not supported in module language */
-#define SEPOL_LINK_REQNOTMET  3	/* requirements not met */
 
 extern int link_modules(sepol_handle_t * handle,
 			policydb_t * b, policydb_t ** mods, int len,
diff -r ff3cba3a9a02 libsepol/src/avtab.c
--- a/libsepol/src/avtab.c	Thu Jan 11 16:25:56 2007 -0500
+++ b/libsepol/src/avtab.c	Sat Jan 13 19:19:57 2007 -0500
@@ -1,7 +1,8 @@
 
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
 
-/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+/* Updated: Frank Mayer <mayerf@tresys.com>
+ *          and Karl MacMillan <kmacmillan@mentalrootkit.com>
  *
  * 	Added conditional policy language extensions
  *
@@ -9,8 +10,10 @@
  *
  *      Code cleanup
  *
+ * Updated: Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
  * Copyright (C) 2003 Tresys Technology, LLC
- * Copyright (C) 2003 Red Hat, Inc.
+ * Copyright (C) 2003,2007 Red Hat, Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -36,6 +39,7 @@
 #include <stdlib.h>
 #include <sepol/policydb/avtab.h>
 #include <sepol/policydb/policydb.h>
+#include <sepol/errno.h>
 
 #include "debug.h"
 #include "private.h"
@@ -77,7 +81,7 @@ int avtab_insert(avtab_t * h, avtab_key_
 	    key->specified & ~(AVTAB_ENABLED | AVTAB_ENABLED_OLD);
 
 	if (!h)
-		return -ENOMEM;
+		return SEPOL_ENOMEM;
 
 	hvalue = AVTAB_HASH(key);
 	for (prev = NULL, cur = h->htable[hvalue];
@@ -86,7 +90,7 @@ int avtab_insert(avtab_t * h, avtab_key_
 		    key->target_type == cur->key.target_type &&
 		    key->target_class == cur->key.target_class &&
 		    (specified & cur->key.specified))
-			return -EEXIST;
+			return SEPOL_EEXIST;
 		if (key->source_type < cur->key.source_type)
 			break;
 		if (key->source_type == cur->key.source_type &&
@@ -100,7 +104,7 @@ int avtab_insert(avtab_t * h, avtab_key_
 
 	newnode = avtab_insert_node(h, hvalue, prev, key, datum);
 	if (!newnode)
-		return -ENOMEM;
+		return SEPOL_ENOMEM;
 
 	return 0;
 }
@@ -470,9 +474,9 @@ int avtab_read(avtab_t * a, struct polic
 	for (i = 0; i < nel; i++) {
 		rc = avtab_read_item(fp, vers, a, avtab_insertf, NULL);
 		if (rc) {
-			if (rc == -ENOMEM)
+			if (rc == SEPOL_ENOMEM)
 				ERR(fp->handle, "out of memory");
-			if (rc == -EEXIST)
+			if (rc == SEPOL_EEXIST)
 				ERR(fp->handle, "duplicate entry");
 			ERR(fp->handle, "failed on entry %d of %u", i, nel);
 			goto bad;
diff -r ff3cba3a9a02 libsepol/src/expand.c
--- a/libsepol/src/expand.c	Thu Jan 11 16:25:56 2007 -0500
+++ b/libsepol/src/expand.c	Sat Jan 13 19:21:44 2007 -0500
@@ -1,8 +1,9 @@
-/* Authors: Karl MacMillan <kmacmillan@tresys.com>
+/* Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
  *          Jason Tang <jtang@tresys.com>
  *	    Joshua Brindle <jbrindle@tresys.com>
  *
  * Copyright (C) 2004-2005 Tresys Technology, LLC
+ * Copyright (C) 2007 Red Hat, Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -84,7 +85,7 @@ static int type_copy_callback(hashtab_ke
 	if (!new_type) {
 		ERR(state->handle, "Out of memory!");
 		free(new_id);
-		return -ENOMEM;
+		return SEPOL_ENOMEM;
 	}
 	memset(new_type, 0, sizeof(type_datum_t));
 
@@ -467,7 +468,7 @@ static int alias_copy_callback(hashtab_k
 	if (!new_alias) {
 		ERR(state->handle, "Out of memory!");
 		free(new_id);
-		return -ENOMEM;
+		return SEPOL_ENOMEM;
 	}
 	memset(new_alias, 0, sizeof(type_datum_t));
 	if (alias->flavor == TYPE_TYPE)
diff -r ff3cba3a9a02 libsepol/src/hashtab.c
--- a/libsepol/src/hashtab.c	Thu Jan 11 16:25:56 2007 -0500
+++ b/libsepol/src/hashtab.c	Sat Jan 13 19:25:58 2007 -0500
@@ -1,5 +1,26 @@
 
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+
+/*
+ * Updated : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
 
 /* FLASK */
 
@@ -48,7 +69,7 @@ int hashtab_insert(hashtab_t h, hashtab_
 	hashtab_ptr_t prev, cur, newnode;
 
 	if (!h)
-		return HASHTAB_OVERFLOW;
+		return SEPOL_ENOMEM;
 
 	hvalue = h->hash_value(h, key);
 	prev = NULL;
@@ -59,11 +80,11 @@ int hashtab_insert(hashtab_t h, hashtab_
 	}
 
 	if (cur && (h->keycmp(h, key, cur->key) == 0))
-		return HASHTAB_PRESENT;
+		return SEPOL_EEXIST;
 
 	newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
 	if (newnode == NULL)
-		return HASHTAB_OVERFLOW;
+		return SEPOL_ENOMEM;
 	memset(newnode, 0, sizeof(struct hashtab_node));
 	newnode->key = key;
 	newnode->datum = datum;
@@ -76,7 +97,7 @@ int hashtab_insert(hashtab_t h, hashtab_
 	}
 
 	h->nel++;
-	return HASHTAB_SUCCESS;
+	return SEPOL_OK;
 }
 
 int hashtab_remove(hashtab_t h, hashtab_key_t key,
@@ -87,7 +108,7 @@ int hashtab_remove(hashtab_t h, hashtab_
 	hashtab_ptr_t cur, last;
 
 	if (!h)
-		return HASHTAB_MISSING;
+		return SEPOL_ENOENT;
 
 	hvalue = h->hash_value(h, key);
 	last = NULL;
@@ -98,7 +119,7 @@ int hashtab_remove(hashtab_t h, hashtab_
 	}
 
 	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
-		return HASHTAB_MISSING;
+		return SEPOL_ENOENT;
 
 	if (last == NULL)
 		h->htable[hvalue] = cur->next;
@@ -109,7 +130,7 @@ int hashtab_remove(hashtab_t h, hashtab_
 		destroy(cur->key, cur->datum, args);
 	free(cur);
 	h->nel--;
-	return HASHTAB_SUCCESS;
+	return SEPOL_OK;
 }
 
 int hashtab_replace(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum,
@@ -120,7 +141,7 @@ int hashtab_replace(hashtab_t h, hashtab
 	hashtab_ptr_t prev, cur, newnode;
 
 	if (!h)
-		return HASHTAB_OVERFLOW;
+		return SEPOL_ENOMEM;
 
 	hvalue = h->hash_value(h, key);
 	prev = NULL;
@@ -138,7 +159,7 @@ int hashtab_replace(hashtab_t h, hashtab
 	} else {
 		newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
 		if (newnode == NULL)
-			return HASHTAB_OVERFLOW;
+			return SEPOL_ENOMEM;
 		memset(newnode, 0, sizeof(struct hashtab_node));
 		newnode->key = key;
 		newnode->datum = datum;
@@ -151,7 +172,7 @@ int hashtab_replace(hashtab_t h, hashtab
 		}
 	}
 
-	return HASHTAB_SUCCESS;
+	return SEPOL_OK;
 }
 
 hashtab_datum_t hashtab_search(hashtab_t h, const hashtab_key_t key)
@@ -206,7 +227,7 @@ int hashtab_map(hashtab_t h,
 	hashtab_ptr_t cur;
 
 	if (!h)
-		return HASHTAB_SUCCESS;
+		return SEPOL_OK;
 
 	for (i = 0; i < h->size; i++) {
 		cur = h->htable[i];
@@ -217,7 +238,7 @@ int hashtab_map(hashtab_t h,
 			cur = cur->next;
 		}
 	}
-	return HASHTAB_SUCCESS;
+	return SEPOL_OK;
 }
 
 void hashtab_map_remove_on_error(hashtab_t h,
diff -r ff3cba3a9a02 libsepol/src/link.c
--- a/libsepol/src/link.c	Thu Jan 11 16:25:56 2007 -0500
+++ b/libsepol/src/link.c	Sat Jan 13 19:15:16 2007 -0500
@@ -1,8 +1,9 @@
-/* Authors: Karl MacMillan <kmacmillan@tresys.com>
+/* Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
  *	    Joshua Brindle <jbrindle@tresys.com>
  *          Jason Tang <jtang@tresys.com>
  *
  * Copyright (C) 2004-2005 Tresys Technology, LLC
+ * Copyright (C) 2007 Red Hat, Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -148,14 +149,14 @@ static int permission_copy_callback(hash
 			new_id = strdup(perm_id);
 			if (new_id == NULL) {
 				ERR(state->handle, "Memory error");
-				ret = -SEPOL_LINK_ERROR;
+				ret = SEPOL_ERR;
 				goto err;
 			}
 			new_perm =
 			    (perm_datum_t *) calloc(1, sizeof(perm_datum_t));
 			if (new_perm == NULL) {
 				ERR(state->handle, "Memory error");
-				ret = -SEPOL_LINK_ERROR;
+				ret = SEPOL_ERR;
 				goto err;
 			}
 			ret = hashtab_insert(dest_class->permissions.table,
@@ -174,7 +175,7 @@ static int permission_copy_callback(hash
 			    "Module %s depends on permission %s in class %s, not satisfied",
 			    state->cur_mod_name, perm_id,
 			    state->dest_class_name);
-			return -SEPOL_LINK_REQNOTMET;
+			return SEPOL_EREQ;
 		}
 	}
 
@@ -227,7 +228,7 @@ static int class_copy_callback(hashtab_k
 		    hashtab_search(state->cur->policy->p_classes_scope.table,
 				   id);
 		if (scope == NULL) {
-			ret = -SEPOL_LINK_ERROR;
+			ret = SEPOL_ERR;
 			goto err;
 		}
 		if (scope->scope == SCOPE_DECL) {
@@ -235,7 +236,7 @@ static int class_copy_callback(hashtab_k
 			ERR(state->handle,
 			    "%s: Modules may not yet declare new classes.",
 			    state->cur_mod_name);
-			ret = -SEPOL_LINK_NOTSUP;
+			ret = SEPOL_ENOTSUP;
 			goto err;
 		} else {
 			/* It would be nice to error early here because the requirement is
@@ -252,18 +253,18 @@ static int class_copy_callback(hashtab_k
 			    (class_datum_t *) calloc(1, sizeof(class_datum_t));
 			if (new_class == NULL) {
 				ERR(state->handle, "Memory error\n");
-				ret = -SEPOL_LINK_ERROR;
+				ret = SEPOL_ERR;
 				goto err;
 			}
 			if (symtab_init
 			    (&new_class->permissions, PERM_SYMTAB_SIZE)) {
-				ret = -SEPOL_LINK_ERROR;
+				ret = SEPOL_ERR;
 				goto err;
 			}
 			new_id = strdup(id);
 			if (new_id == NULL) {
 				ERR(state->handle, "Memory error\n");
-				ret = -SEPOL_LINK_ERROR;
+				ret = SEPOL_ERR;
 				goto err;
 			}
 			ret = hashtab_insert(state->base->p_classes.table,
@@ -589,13 +590,13 @@ static int sens_copy_callback(hashtab_ke
 		scope =
 		    hashtab_search(state->cur->policy->p_sens_scope.table, id);
 		if (!scope)
-			return -SEPOL_LINK_ERROR;
+			return SEPOL_ERR;
 		if (scope->scope == SCOPE_DECL) {
 			/* disallow declarations in modules */
 			ERR(state->handle,
 			    "%s: Modules may not declare new sensitivities.",
 			    state->cur_mod_name);
-			return -SEPOL_LINK_NOTSUP;
+			return SEPOL_ENOTSUP;
 		}
 	}
 
@@ -620,13 +621,13 @@ static int cat_copy_callback(hashtab_key
 		scope =
 		    hashtab_search(state->cur->policy->p_cat_scope.table, id);
 		if (!scope)
-			return -SEPOL_LINK_ERROR;
+			return SEPOL_ERR;
 		if (scope->scope == SCOPE_DECL) {
 			/* disallow declarations in modules */
 			ERR(state->handle,
 			    "%s: Modules may not declare new categories.",
 			    state->cur_mod_name);
-			return -SEPOL_LINK_NOTSUP;
+			return SEPOL_ENOTSUP;
 		}
 	}
 
@@ -1916,7 +1917,7 @@ static int enable_avrules(link_state_t *
 			}
 			rc = is_decl_requires_met(state, decl, &req);
 			if (rc < 0) {
-				ret = -SEPOL_LINK_ERROR;
+				ret = SEPOL_ERR;
 				goto out;
 			} else if (rc == 0) {
 				decl->enabled = 0;
@@ -1925,7 +1926,7 @@ static int enable_avrules(link_state_t *
 				if (!(block->flags & AVRULE_OPTIONAL)) {
 					print_missing_requirements(state, block,
 								   &req);
-					ret = -SEPOL_LINK_REQNOTMET;
+					ret = SEPOL_EREQ;
 					goto out;
 				}
 			}
@@ -2209,7 +2210,7 @@ int link_modules(sepol_handle_t * handle
 	}
 
 	if (enable_avrules(&state, state.base)) {
-		retval = -SEPOL_LINK_REQNOTMET;
+		retval = SEPOL_EREQ;
 		goto cleanup;
 	}
 
diff -r ff3cba3a9a02 libsepol/src/policydb.c
--- a/libsepol/src/policydb.c	Thu Jan 11 16:25:56 2007 -0500
+++ b/libsepol/src/policydb.c	Sat Jan 13 19:22:42 2007 -0500
@@ -17,7 +17,7 @@
  *
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2005 Tresys Technology, LLC
- * Copyright (C) 2003 - 2004 Red Hat, Inc.
+ * Copyright (C) 2003 - 2007 Red Hat, Inc.
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -1176,9 +1176,9 @@ int symtab_insert(policydb_t * pol, uint
 		 * (i.e. aliases) */
 		if (value)
 			*value = ++pol->symtab[sym].nprim;
-	} else if (rc == HASHTAB_PRESENT && scope == SCOPE_REQ) {
+	} else if (rc == SEPOL_EEXIST && scope == SCOPE_REQ) {
 		retval = 1;	/* symbol not added -- need to free() later */
-	} else if (rc == HASHTAB_PRESENT && scope == SCOPE_DECL) {
+	} else if (rc == SEPOL_EEXIST && scope == SCOPE_DECL) {
 		if (sym == SYM_ROLES || sym == SYM_USERS) {
 			/* allow multiple declarations for these two */
 			retval = 1;
diff -r ff3cba3a9a02 libsepol/src/private.h
--- a/libsepol/src/private.h	Thu Jan 11 16:25:56 2007 -0500
+++ b/libsepol/src/private.h	Sat Jan 13 19:17:03 2007 -0500
@@ -2,9 +2,11 @@
 
 /* Endian conversion for reading and writing binary policies */
 
+#include <sepol/policydb/policydb.h>
+
 #include <byteswap.h>
 #include <endian.h>
-#include <sepol/policydb/policydb.h>
+#include <errno.h>
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define cpu_to_le16(x) (x)
diff -r ff3cba3a9a02 policycoreutils/semodule_deps/semodule_deps.c
--- a/policycoreutils/semodule_deps/semodule_deps.c	Thu Jan 11 16:25:56 2007 -0500
+++ b/policycoreutils/semodule_deps/semodule_deps.c	Sat Jan 13 19:32:48 2007 -0500
@@ -1,7 +1,7 @@
 /* Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
  *
  * Copyright (C) 2006 Tresys Technology, LLC
- * Copyright (C) 2006 Red Hat, Inc.
+ * Copyright (C) 2006-2007 Red Hat, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -16,6 +16,7 @@
  * of avrule_blocks - even in an ABI safe way - seems undesirable.
  */
 #include <sepol/module.h>
+#include <sepol/errno.h>
 #include <sepol/policydb/policydb.h>
 
 #include <getopt.h>
@@ -201,15 +202,15 @@ static int generate_requires(policydb_t 
 						    hashtab_insert(mods,
 								   mod_name,
 								   reqs);
-						if (ret != HASHTAB_SUCCESS)
+						if (ret != SEPOL_OK)
 							return ret;
 					}
 					ret =
 					    hashtab_insert(reqs, req_name,
 							   NULL);
 					if (!
-					    (ret == HASHTAB_PRESENT
-					     || ret == HASHTAB_SUCCESS))
+					    (ret == SEPOL_EEXIST
+					     || ret == SEPOL_OK))
 						return -1;
 				}
 			}

--------------010104070105020504050804--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
