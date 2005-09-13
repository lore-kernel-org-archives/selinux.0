Message-ID: <43264DAD.5090903@cornell.edu>
Date: Mon, 12 Sep 2005 23:55:25 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>
In-Reply-To: <43258D48.80702@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------050201090004070606080106"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050201090004070606080106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch changes printf/fprintf usage in policydb.c, and
avtab.c to the new debug system. This allows the user to set the print 
function.
It also writes to stderr by default, as opposed to stdout (which is 
wrong, imho).
As a side effect, this will append a more verbose prefix everywhere
that gives the exact function name, rather than "security : mls" or 
whatever.

This also removes the __sepol_debug_printf debug system from
gen*, and changes genbools and genusers to use the newer system.

I haven't really tested this, but it's fairly straightforward, and I don't
see what can break - it compiles without warnings.

============
We need to reduce the number of debug systems in the selinux libraries.
printf's should be eradicated. There's also the alternative system that 
semanage
uses, based on buffering the errors - I'm not clear how that will
be made to work in concert with sepol debugging.



--------------050201090004070606080106
Content-Type: text/x-patch;
 name="libsepol.debug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.debug.diff"

diff -Naur libsepol/src/avtab.c libsepol.new/src/avtab.c
--- libsepol/src/avtab.c	2005-08-21 12:56:16.000000000 -0400
+++ libsepol.new/src/avtab.c	2005-09-12 23:30:54.000000000 -0400
@@ -37,6 +37,7 @@
 #include <sepol/avtab.h>
 #include <sepol/policydb.h>
 
+#include "debug.h"
 #include "private.h"
 
 #define AVTAB_HASH(keyp) \
@@ -357,19 +358,19 @@
 	if (vers < POLICYDB_VERSION_AVTAB) {
 		buf32 = next_entry(fp, sizeof(uint32_t));
 		if (!buf32) {
-			printf("security: avtab: truncated entry\n");
+			DEBUG(__FUNCTION__, "truncated entry\n");
 			return -1;
 		}
 		items2 = le32_to_cpu(buf32[0]);
 
 		if (items2 < 5 || items2 > 8) {
-			printf("security: avtab: invalid item count\n");
+			DEBUG(__FUNCTION__, "invalid item count\n");
 			return -1;
 		}
 
 		buf32 = next_entry(fp, sizeof(uint32_t)*items2);
 		if (!buf32) {
-			printf("security: avtab: truncated entry\n");
+			DEBUG(__FUNCTION__, "truncated entry\n");
 			return -1;
 		}
 
@@ -377,19 +378,19 @@
 		val = le32_to_cpu(buf32[items++]);
 		key.source_type = (uint16_t)val;
 		if (key.source_type != val) {
-			printf("security: avtab: truncated source type\n");
+			DEBUG(__FUNCTION__, "truncated source type\n");
 			return -1;
 		}
 		val = le32_to_cpu(buf32[items++]);
 		key.target_type = (uint16_t)val;
 		if (key.target_type != val) {
-			printf("security: avtab: truncated target type\n");
+			DEBUG(__FUNCTION__, "truncated target type\n");
 			return -1;
 		}
 		val = le32_to_cpu(buf32[items++]);
 		key.target_class = (uint16_t)val;
 		if (key.target_class != val) {
-			printf("security: avtab: truncated target class\n");
+			DEBUG(__FUNCTION__, "truncated target class\n");
 			return -1;
 		}
 
@@ -397,12 +398,13 @@
 		enabled = (val & AVTAB_ENABLED_OLD) ? AVTAB_ENABLED : 0;
 
 		if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
-			printf("security: avtab: null entry\n");
+			DEBUG(__FUNCTION__, "null entry\n");
 			return -1;
 		}
 		if ((val & AVTAB_AV) &&
 		    (val & AVTAB_TYPE)) {
-			printf("security: avtab: entry has both access vectors and types\n");
+			DEBUG(__FUNCTION__, "entry has both access "
+				"vectors and types\n");
 			return -1;
 		}
 
@@ -416,7 +418,8 @@
 		}
 
 		if (items != items2) {
-			printf("security: avtab: entry only had %d items, expected %d\n", items2, items);
+			DEBUG(__FUNCTION__, "entry only had %d items, "
+				"expected %d\n", items2, items);
 			return -1;
 		}
 		return 0;
@@ -424,7 +427,7 @@
 	
 	buf16 = next_entry(fp, sizeof(uint16_t)*4);
 	if (!buf16) {
-		printf("security: avtab: truncated entry\n");
+		DEBUG(__FUNCTION__, "truncated entry\n");
 		return -1;
 	}
 	items = 0;
@@ -439,13 +442,13 @@
 				set++;
 	}
 	if (!set || set > 1) {
-		printf("security: avtab: more than one specifier\n");
+		DEBUG(__FUNCTION__, "more than one specifier\n");
 		return -1;
 	}
 		
 	buf32 = next_entry(fp, sizeof(uint32_t));
 	if (!buf32) {
-		printf("security: avtab: truncated entry\n");
+		DEBUG(__FUNCTION__, "truncated entry\n");
 		return -1;
 	}
 	datum.data = le32_to_cpu(*buf32);
@@ -467,22 +470,22 @@
 
 	buf = next_entry(fp, sizeof(uint32_t));
 	if (!buf) {
-		printf("security: avtab: truncated table\n");
+		DEBUG(__FUNCTION__, "truncated table\n");
 		goto bad;
 	}
 	nel = le32_to_cpu(buf[0]);
 	if (!nel) {
-		printf("security: avtab: table is empty\n");
+		DEBUG(__FUNCTION__, "table is empty\n");
 		goto bad;
 	}
 	for (i = 0; i < nel; i++) {
 		rc = avtab_read_item(fp, vers, a, avtab_insertf, NULL);
 		if (rc) {
 			if (rc == -ENOMEM)
-				printf("security: avtab: out of memory\n");
+				DEBUG(__FUNCTION__, "out of memory\n");
 			if (rc == -EEXIST)
-				printf("security: avtab: duplicate entry\n");
-			printf("Failed on entry %d of %u\n", i, nel);
+				DEBUG(__FUNCTION__, "duplicate entry\n");
+			DEBUG(__FUNCTION__, "failed on entry %d of %u\n", i, nel);
 			goto bad;
 		}
 	}
diff -Naur libsepol/src/debug.c libsepol.new/src/debug.c
--- libsepol/src/debug.c	2005-07-18 10:28:43.000000000 -0400
+++ libsepol.new/src/debug.c	2005-09-12 23:41:51.000000000 -0400
@@ -31,6 +31,11 @@
 
 void (*DEBUG) (const char* fname, const char* fmt, ...) = default_printf;
 
+/* Compatibility */
+void sepol_debug(int on) {
+        sepol_debug_compat(on);
+};
+
 void sepol_debug_compat(int on) {
 	DEBUG = (on)? default_printf : suppress_printf;
 }
diff -Naur libsepol/src/genbools.c libsepol.new/src/genbools.c
--- libsepol/src/genbools.c	2005-08-31 16:51:16.000000000 -0400
+++ libsepol.new/src/genbools.c	2005-09-12 23:40:43.000000000 -0400
@@ -6,6 +6,7 @@
 #include <sepol/policydb.h>
 #include <sepol/conditional.h>
 
+#include "debug.h"
 #include "private.h"
 
 static char *strtrim(char *dest, char *source, int size) {
@@ -43,7 +44,8 @@
 			else if (!strncasecmp(tok, "false", sizeof("false")-1))
 				*val = 0;
 			if (*val != 0 && *val != 1) {
-				fprintf(stderr,"illegal value for boolean %s=%s\n", name, tok);
+				DEBUG(__FUNCTION__, "illegal value for boolean "
+					"%s=%s\n", name, tok);
 				return -1;
 			}
 			
@@ -73,7 +75,7 @@
 		if (ret==1) {
 			datum = hashtab_search(policydb->p_bools.table, name);
 			if (!datum) {
-				fprintf(stderr,"unknown boolean %s\n", name);
+				DEBUG(__FUNCTION__, "unknown boolean %s\n", name);
 				errors++;
 				continue;
 			}
@@ -92,7 +94,7 @@
 			if (ret==1) {
 				datum = hashtab_search(policydb->p_bools.table, name);
 				if (!datum) {
-					fprintf(stderr,"unknown boolean %s\n", name);
+					DEBUG(__FUNCTION__, "unknown boolean %s\n", name);
 					errors++;
 					continue;
 				}
@@ -122,13 +124,12 @@
 	sepol_set_policyvers(policydb.policy_type, policydb.policyvers);
 
 	if (load_booleans(&policydb, booleans) < 0) {
-		__sepol_debug_printf("%s:  Warning!  Error while reading %s\n",
-				     __FUNCTION__, booleans);
+		DEBUG(__FUNCTION__, "Warning! Error while reading %s\n",
+				     booleans);
 	}
 
 	if (evaluate_conds(&policydb) < 0) {
-		__sepol_debug_printf("%s:  Error while re-evaluating conditionals\n",
-				     __FUNCTION__);
+		DEBUG(__FUNCTION__, "error while re-evaluating conditionals\n");
 		errno = EINVAL;
 		goto err_destroy;
 	}
@@ -138,8 +139,7 @@
 	pf.len = len;
 	rc = policydb_write(&policydb, &pf);
 	if (rc) {
-		__sepol_debug_printf("%s: Can't write new binary policy image\n",
-				     __FUNCTION__);
+		DEBUG(__FUNCTION__, "unable to write new binary policy image\n");
 		errno = EINVAL;
 		goto err_destroy;
 	}
@@ -184,13 +184,14 @@
 	for (i = 0; i < nel; i++) {
 		datum = hashtab_search(policydb.p_bools.table, names[i]);
 		if (!datum) {
-			__sepol_debug_printf("%s:  boolean %s no longer in policy\n", 
-					     __FUNCTION__, names[i]);
+			DEBUG(__FUNCTION__, "boolean %s no longer in policy\n",
+				names[i]);
 			errors++;
 			continue;
 		}
 		if (values[i] != 0 && values[i] != 1) {
-			fprintf(stderr,"illegal value %d for boolean %s\n", values[i], names[i]);
+			DEBUG(__FUNCTION__, "illegal value %d for boolean %s\n",
+				values[i], names[i]);
 			errors++;
 			continue;
 		}
@@ -198,8 +199,7 @@
 	}
 
 	if (evaluate_conds(&policydb) < 0) {
-		__sepol_debug_printf("%s:  Error while re-evaluating conditionals\n",
-				     __FUNCTION__);
+		DEBUG(__FUNCTION__, "error while re-evaluating conditionals\n");
 		errno = EINVAL;
 		goto err_destroy;
 	}
@@ -209,8 +209,7 @@
 	pf.len = len;
 	rc = policydb_write(&policydb, &pf);
 	if (rc) {
-		__sepol_debug_printf("%s:  Can't write binary policy\n",
-				     __FUNCTION__);
+		DEBUG(__FUNCTION__, "unable to write binary policy\n");
 		errno = EINVAL;
 		goto err_destroy;
 	}
diff -Naur libsepol/src/genusers.c libsepol.new/src/genusers.c
--- libsepol/src/genusers.c	2005-08-31 16:51:16.000000000 -0400
+++ libsepol.new/src/genusers.c	2005-09-12 23:43:51.000000000 -0400
@@ -12,33 +12,12 @@
 #include "debug.h"
 #include "private.h"
 
-static int gdebug=1;
-
-void sepol_debug(int on) { 
-	gdebug=on; 
-
-	/* New debug system */
-	sepol_debug_compat(on);
-};
-
-#ifdef __GNUC__
-__attribute__ ((format (printf, 1, 2)))
-#endif
-void __sepol_debug_printf(const char *fmt, ...) {
-	if (gdebug) {
-		va_list ap;
-		va_start(ap, fmt);
-		vfprintf (stderr, fmt, ap);
-		va_end(ap);
-	}
-}
-
 extern int selinux_delusers;
 
 #undef BADLINE
 #define BADLINE() { \
-	__sepol_debug_printf("%s:  invalid entry %s on line %u\n", \
-		path, buffer, lineno); \
+	DEBUG(__FUNCTION__, "invalid entry %s (%s:%u)\n", \
+		buffer, path, lineno); \
 	continue; \
 }
 
@@ -96,8 +75,7 @@
 			/* Adding a new user definition. */
 			usrdatum = (user_datum_t *) malloc(sizeof(user_datum_t));
 			if (!id || !usrdatum) {
-				__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
-					path, buffer, lineno);
+				DEBUG(__FUNCTION__,"out of memory\n");
 				errno = ENOMEM;
 				free(buffer);
 				fclose(fp);
@@ -110,8 +88,7 @@
 			rc = hashtab_insert(policydb->p_users.table,
 					    id, (hashtab_datum_t) usrdatum);
 			if (rc) {
-				__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
-					path, buffer, lineno);
+				DEBUG(__FUNCTION__, "out of memory\n");
 				errno = ENOMEM;
 				free(buffer);
 				fclose(fp);
@@ -158,16 +135,15 @@
 
 			roldatum = hashtab_search(policydb->p_roles.table, q);
 			if (!roldatum) {
-				__sepol_debug_printf("%s:  undefined role %s in %s on line %u\n",
-					path, q, buffer, lineno);
+				DEBUG(__FUNCTION__, "undefined role %s (%s:%u)\n",
+					q, path, lineno);
 				continue;
 			}
 			/* Set the role and every role it dominates */
 			ebitmap_for_each_bit(&roldatum->dominates, rnode, bit) {
 				if (ebitmap_node_get_bit(rnode, bit))
 					if (ebitmap_set_bit(&usrdatum->roles.roles, bit, 1)) {
-						__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
-							path, buffer, lineno);
+						DEBUG(__FUNCTION__, "out of memory\n");
 						errno = ENOMEM;
 						free(buffer);
 						fclose(fp);
@@ -203,9 +179,7 @@
 
 			scontext = malloc(p - q);
 			if (!scontext) {
-				__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
-					path, buffer, lineno);
-				errno = ENOMEM;
+				DEBUG(__FUNCTION__, "out of memory\n");
 				free(buffer);
 				fclose(fp);
 				return -1;
@@ -223,8 +197,8 @@
 			context_init(&context);
 			rc = mls_context_to_sid(policydb, oldc, &r, &context);
 			if (rc) {
-				__sepol_debug_printf("%s:  invalid level %s in %s on line %u\n",
-					path, scontext, buffer, lineno);
+				DEBUG(__FUNCTION__, "invalid level %s (%s:%u)\n",
+					scontext, path, lineno);
 				free(scontext);
 				continue;
 
@@ -250,8 +224,7 @@
 
 			scontext = malloc(p - q);
 			if (!scontext) {
-				__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
-					path, buffer, lineno);
+				DEBUG(__FUNCTION__, "out of memory\n");
 				errno = ENOMEM;
 				free(buffer);
 				fclose(fp);
@@ -270,8 +243,8 @@
 			context_init(&context);
 			rc = mls_context_to_sid(policydb, oldc, &r, &context);
 			if (rc) {
-				__sepol_debug_printf("%s:  invalid range %s in %s on line %u\n",
-					path, scontext, buffer, lineno);
+				DEBUG(__FUNCTION__, "invalid range %s (%s:%u)\n",
+					scontext, path, lineno);
 				free(scontext);
 				continue;
 			}
@@ -362,16 +335,16 @@
 	/* Load base set of system users from the policy package. */
 	snprintf(path, sizeof path, "%s/system.users", usersdir);
 	if (load_users(&policydb, path) < 0) {
-		__sepol_debug_printf("%s: Can't load system.users:  %s\n",
-				     __FUNCTION__, strerror(errno));
+		DEBUG(__FUNCTION__, "unable to load system.users: %s\n",
+				strerror(errno));
 		goto err_destroy;
 	}
 
 	/* Load locally defined users. */
 	snprintf(path, sizeof path, "%s/local.users", usersdir);
 	if (load_users(&policydb, path) < 0) {
-		__sepol_debug_printf("%s:  Can't load local.users:  %s\n",
-				     __FUNCTION__, strerror(errno));
+		DEBUG(__FUNCTION__, "unable to load local.users: %s\n",
+				strerror(errno));
 		goto err_destroy;
 	}
 
@@ -407,22 +380,22 @@
 	/* Load base set of system users from the policy package. */
 	snprintf(path, sizeof path, "%s/system.users", usersdir);
 	if (load_users(policydb, path) < 0) {
-		__sepol_debug_printf("%s: Can't load system.users:  %s\n",
-				     __FUNCTION__, strerror(errno));
+		DEBUG(__FUNCTION__, "unable to load system.users: %s\n",
+				strerror(errno));
 		return -1;
 	}
 
 	/* Load locally defined users. */
 	snprintf(path, sizeof path, "%s/local.users", usersdir);
 	if (load_users(policydb, path) < 0) {
-		__sepol_debug_printf("%s:  Can't load local.users:  %s\n",
-				     __FUNCTION__, strerror(errno));
+		DEBUG(__FUNCTION__, "unable to load local.users: %s\n",
+				strerror(errno));
 		return -1;
 	}
 
 	if (policydb_reindex_users(policydb) < 0) {
-		__sepol_debug_printf("%s:  Can't reindex users:  %s\n",
-				     __FUNCTION__, strerror(errno));
+		DEBUG(__FUNCTION__, "unable to reindex users: %s\n",
+				strerror(errno));
 		return -1;
 
 	}
diff -Naur libsepol/src/policydb.c libsepol.new/src/policydb.c
--- libsepol/src/policydb.c	2005-08-31 16:51:17.000000000 -0400
+++ libsepol.new/src/policydb.c	2005-09-12 23:27:29.000000000 -0400
@@ -1005,20 +1005,20 @@
 	ocontext_t *head, *c;
 
 	if (sepol_sidtab_init(s)) {
-		printf("security:  out of memory on SID table init\n");
+		DEBUG(__FUNCTION__, "out of memory on SID table init\n");
 		return -1;
 	}
 
 	head = p->ocontexts[OCON_ISID];
 	for (c = head; c; c = c->next) {
 		if (!c->context[0].user) {
-			printf("security:  SID %s was never defined.\n", 
-			       c->u.name);
+			DEBUG(__FUNCTION__, "SID %s was never defined\n",
+				c->u.name);
 			return -1;
 		}
 		if (sepol_sidtab_insert(s, c->sid[0], &c->context[0])) {
-			printf("security:  unable to load initial SID %s.\n", 
-			       c->u.name);
+			DEBUG(__FUNCTION__, "unable to load initial SID %s\n",
+				c->u.name);
 			return -1;
 		}
 	}
@@ -1078,7 +1078,7 @@
 	items = le32_to_cpu(buf[0]);
 	buf = next_entry(fp, sizeof(uint32_t)*items);
 	if (!buf) {
-		printf("security: mls:  truncated range\n");
+		DEBUG(__FUNCTION__, "truncated range\n");
 		goto out;
 	}
 	r->level[0].sens = le32_to_cpu(buf[0]);
@@ -1089,19 +1089,19 @@
 
 	rc = ebitmap_read(&r->level[0].cat, fp);
 	if (rc) {
-		printf("security: mls:  error reading low categories\n");
+		DEBUG(__FUNCTION__, "error reading low categories\n");
 		goto out;
 	}
 	if (items > 1) {
 		rc = ebitmap_read(&r->level[1].cat, fp);
 		if (rc) {
-			printf("security: mls:  error reading high categories\n");
+			DEBUG(__FUNCTION__, "error reading high categories\n");
 			goto bad_high;
 		}
 	} else {
 		rc = ebitmap_cpy(&r->level[1].cat, &r->level[0].cat);
 		if (rc) {
-			printf("security: mls:  out of memory\n");
+			DEBUG(__FUNCTION__, "out of memory\n");
 			goto bad_high;
 		}
 	}
@@ -1127,7 +1127,7 @@
 
 	buf = next_entry(fp, sizeof(uint32_t)*3);
 	if (!buf) {
-		printf("security: context truncated\n");
+		DEBUG(__FUNCTION__, "context truncated\n");
 		return -1;
 	}
 	c->user = le32_to_cpu(buf[0]);
@@ -1135,14 +1135,14 @@
 	c->type = le32_to_cpu(buf[2]);
 	if (p->policyvers >= POLICYDB_VERSION_MLS) {
 		if (mls_read_range_helper(&c->range, fp)) {
-			printf("security: error reading MLS range of "
-			       "context\n");
+			DEBUG(__FUNCTION__, "error reading MLS range "
+				"of context\n");
 			return -1;
 		}
 	}
 
 	if (!policydb_context_isvalid(p, c)) {
-		printf("security:  invalid security context\n");
+		DEBUG(__FUNCTION__, "invalid security context\n");
 		context_destroy(c);
 		return -1;
 	}
@@ -1402,7 +1402,8 @@
 		cladatum->comdatum = hashtab_search(p->p_commons.table,
 						    cladatum->comkey);
 		if (!cladatum->comdatum) {
-			printf("security:  unknown common %s\n", cladatum->comkey);
+			DEBUG(__FUNCTION__, "unknown common %s\n",
+				cladatum->comkey);
 			goto bad;
 		}
 	}
@@ -1477,8 +1478,8 @@
 
 	if (strcmp(key, OBJECT_R) == 0) {
 		if (role->value != OBJECT_R_VAL) {
-			printf("Role %s has wrong value %d\n",
-			       OBJECT_R, role->value);
+			DEBUG(__FUNCTION__, "role %s has wrong value %d\n",
+				OBJECT_R, role->value);
 			role_destroy(key, role, NULL);
 			return -1;
 		}
@@ -1758,7 +1759,8 @@
                 for (genfs_p = NULL, genfs = p->genfs; genfs;
                      genfs_p = genfs, genfs = genfs->next) {
                         if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
-                                printf("security:  dup genfs fstype %s\n", newgenfs->fstype);
+				DEBUG(__FUNCTION__, "dup genfs fstype %s\n", 
+					newgenfs->fstype);
                                 goto bad;
                         }       
                         if (strcmp(newgenfs->fstype, genfs->fstype) < 0)
@@ -1801,8 +1803,11 @@
                         for (l = NULL, c = newgenfs->head; c;
                              l = c, c = c->next) {
                                 if (!strcmp(newc->u.name, c->u.name) &&
-                                    (!c->v.sclass || !newc->v.sclass || newc->v.sclass == c->v.sclass)) {
-                                        printf("security:  dup genfs entry (%s,%s)\n", newgenfs->fstype, c->u.name);
+                                    (!c->v.sclass || !newc->v.sclass || 
+				     newc->v.sclass == c->v.sclass)) {
+					DEBUG(__FUNCTION__, "dup genfs entry "
+						"(%s,%s)\n", newgenfs->fstype, 
+							c->u.name);
                                         goto bad;
                                 }
                                 len = strlen(newc->u.name);
@@ -1836,13 +1841,13 @@
 
 	buf = next_entry(fp, sizeof(uint32_t));
 	if (!buf) {
-		printf("security: mls: truncated level\n");
+		DEBUG(__FUNCTION__, "truncated level\n");
 		goto bad;
 	}
 	lp->sens = le32_to_cpu(buf[0]);
 
 	if (ebitmap_read(&lp->cat, fp)) {
-		printf("security: mls:  error reading level categories\n");
+		DEBUG(__FUNCTION__, "error reading level categories\n");
 		goto bad;
 	}
 	return 0;
@@ -2422,31 +2427,35 @@
                 target_str = POLICYDB_MOD_STRING;
         }
         else {
-                printf("security:  policydb magic number %#08x does not match expected magic number %#08x or %#08x\n",
+		DEBUG(__FUNCTION__, "policydb magic number %#08x does not "
+			"match expected magic number %#08x or %#08x\n",
 			buf[0], POLICYDB_MAGIC, POLICYDB_MOD_MAGIC);
 		return -1;
 	}
 
         len = buf[1];
         if (len != strlen(target_str)) {
-                printf("security:  policydb string length %zu does not match expected length %zu\n", len, strlen(target_str));
+		DEBUG(__FUNCTION__, "policydb string length %zu does not match "
+			"expected length %zu\n", len, strlen(target_str));
                 return -1;
         }
 
 	buf = next_entry(fp, len);
 	if (!buf) {
-		printf("security:  truncated policydb string identifier\n");
+		DEBUG(__FUNCTION__, "truncated policydb string identifier\n");
 		return -1;
 	}
 	policydb_str = malloc(len + 1);
 	if (!policydb_str) {
-		printf("security:  unable to allocate memory for policydb string of length %zu\n", len);
+		DEBUG(__FUNCTION__, "unable to allocate memory for policydb "
+			"string of length %zu\n", len);
 		return -1;
 	}
 	memcpy(policydb_str, buf, len);
 	policydb_str[len] = 0;
 	if (strcmp(policydb_str, target_str)) {
-		printf("security:  policydb string %s does not match my string %s\n", policydb_str, target_str);
+		DEBUG(__FUNCTION__, "policydb string %s does not match "
+			"my string %s\n", policydb_str, target_str);
 		free(policydb_str);
 		return -1;
 	}
@@ -2474,7 +2483,8 @@
 		   tells us which. */
 		policy_type = buf[bufindex];
                 if (policy_type != POLICY_MOD && policy_type != POLICY_BASE) {
-                        printf("Unknown module type: %#08x\n", policy_type);
+			DEBUG(__FUNCTION__, "unknown module type: %#08x\n",
+				policy_type);
                         return -1;
                 }
 		bufindex++;
@@ -2484,17 +2494,19 @@
         if (policy_type == POLICY_KERN || policy_type == POLICY_BASE) {
                 if (r_policyvers < POLICYDB_VERSION_MIN ||
                     r_policyvers > POLICYDB_VERSION_MAX) {
-                        printf("security:  policydb version %d does not match "
-                               "my version range %d-%d\n", buf[bufindex], POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
+			DEBUG(__FUNCTION__, "policydb version %d does not match "
+				"my version range %d-%d\n", buf[bufindex], 
+				POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
                         return -1;
                 }
         }
         else if (policy_type == POLICY_MOD) {
                 if (r_policyvers < MOD_POLICYDB_VERSION_MIN ||
                     r_policyvers > MOD_POLICYDB_VERSION_MAX) {
-                        printf("security:  policydb module version %d does not match "
-                               "my version range %d-%d\n", buf[bufindex],
-                               MOD_POLICYDB_VERSION_MIN, MOD_POLICYDB_VERSION_MAX);
+			DEBUG(__FUNCTION__, "policydb module version %d does "
+				"not match my version range %d-%d\n",
+				buf[bufindex], MOD_POLICYDB_VERSION_MIN,
+				MOD_POLICYDB_VERSION_MAX);
                         return -1;
                 }
         }
@@ -2515,13 +2527,15 @@
 
 	info = policydb_lookup_compat(r_policyvers, policy_type);
 	if (!info) {
-		printf("security:  unable to find policy compat info for version %d\n", r_policyvers);
+		DEBUG(__FUNCTION__, "unable to find policy compat info "
+			"for version %d\n", r_policyvers);
 		goto bad;
 	}
 
 	if (buf[bufindex] != info->sym_num || buf[bufindex + 1] != info->ocon_num) {
-		printf("security:  policydb table sizes (%d,%d) do not match mine (%d,%d)\n",
-		       buf[bufindex], buf[bufindex + 1], info->sym_num, info->ocon_num);
+		DEBUG(__FUNCTION__, "policydb table sizes (%d,%d) do not "
+			"match mine (%d,%d)\n", buf[bufindex], buf[bufindex + 1],
+			info->sym_num, info->ocon_num);
 		goto bad;
 	}
 
diff -Naur libsepol/src/private.h libsepol.new/src/private.h
--- libsepol/src/private.h	2005-08-21 12:56:17.000000000 -0400
+++ libsepol.new/src/private.h	2005-09-12 23:41:19.000000000 -0400
@@ -31,10 +31,6 @@
 };
 
 extern struct policydb_compat_info *policydb_lookup_compat(unsigned int version, unsigned int type);
-#ifdef __GNUC__
-__attribute__ ((format (printf, 1, 2)))
-#endif
-extern void __sepol_debug_printf(const char *fmt, ...);
 
 /* Reading from a policy "file". */
 static inline void *next_entry(struct policy_file * fp, size_t bytes)

--------------050201090004070606080106--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
