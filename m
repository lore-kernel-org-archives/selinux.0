Message-ID: <421F4817.2050303@redhat.com>
Date: Fri, 25 Feb 2005 10:45:27 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <SELinux@tycho.nsa.gov>
Subject: Patch's to make load_policy (and libsepol) be quiet.
Content-Type: multipart/mixed;
 boundary="------------010605020607020604010300"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010605020607020604010300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------010605020607020604010300
Content-Type: text/plain;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/load_policy/load_policy.c policycoreutils-1.21.20/load_policy/load_policy.c
--- nsapolicycoreutils/load_policy/load_policy.c	2005-02-22 16:37:16.000000000 -0500
+++ policycoreutils-1.21.20/load_policy/load_policy.c	2005-02-25 10:26:45.000000000 -0500
@@ -49,6 +49,7 @@
 			break;
 		case 'q':
 			quiet = 1;
+			sepol_debug(0);
 			break;
 		default:
 			usage(argv[0]);
@@ -87,7 +88,9 @@
 
 	ret = sepol_genusers(map, sb.st_size, selinux_users_path(), &data, &data_size);
 	if (ret < 0) {
-		fprintf(stderr, _("%s:  Error while setting user configuration from %s:  %s\n"), argv[0], selinux_users_path(), strerror(errno));
+		/* No users file; non-fatal. */
+		if (! quiet) 
+			fprintf(stderr, _("%s:  Error while setting user configuration from %s/{local.users,system.users}:  %s\n"), argv[0], selinux_users_path(), strerror(errno));
 		data = map;
 		data_size = sb.st_size;
 	}

--------------010605020607020604010300
Content-Type: text/plain;
 name="libsepol-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsepol/include/sepol/sepol.h libsepol-1.3.6/include/sepol/sepol.h
--- nsalibsepol/include/sepol/sepol.h	2005-02-17 17:55:48.000000000 -0500
+++ libsepol-1.3.6/include/sepol/sepol.h	2005-02-25 10:18:10.000000000 -0500
@@ -32,5 +32,6 @@
 /* Check context validity against currently set binary policy. */
 extern int sepol_check_context(char *context);
 
-
+/* Turn on or off sepol error messages. */
+extern void sepol_debug(int on);
 #endif
diff --exclude-from=exclude -N -u -r nsalibsepol/src/genbools.c libsepol-1.3.6/src/genbools.c
--- nsalibsepol/src/genbools.c	2005-02-25 09:44:03.000000000 -0500
+++ libsepol-1.3.6/src/genbools.c	2005-02-25 09:50:17.000000000 -0500
@@ -87,7 +87,7 @@
 	pf.data = data;
 	pf.len = len;
 	if (policydb_read(&policydb,&pf, 0)) {
-		fprintf(stderr, "Can't read binary policy:  %s\n",
+		__sepol_debug_printf("Can't read binary policy:  %s\n",
 			strerror(errno));
 		return -1;
 	}
@@ -97,12 +97,12 @@
 	sepol_set_policyvers(policydb.policyvers);
 
 	if (load_booleans(&policydb, booleans) < 0) {
-		fprintf(stderr, "Warning!  Error while reading %s:  %s\n",
+		__sepol_debug_printf("Warning!  Error while reading %s:  %s\n",
 			booleans, strerror(errno));
 	}
 
 	if (evaluate_conds(&policydb) < 0) {
-		fprintf(stderr, "Error while re-evaluating conditionals: %s\n",
+		__sepol_debug_printf("Error while re-evaluating conditionals: %s\n",
 			strerror(errno));
 		return -1;
 	}
@@ -111,7 +111,7 @@
 	pf.len = len;
 	rc = policydb_write(&policydb, &pf);
 	if (rc) {
-		fprintf(stderr, "Can't write binary policy:  %s\n",
+		__sepol_debug_printf("Can't write binary policy:  %s\n",
 			strerror(errno));
 		return -1;
 	}
@@ -129,7 +129,7 @@
 	pf.data = data;
 	pf.len = len;
 	if (policydb_read(&policydb,&pf, 0)) {
-		fprintf(stderr, "Can't read binary policy:  %s\n",
+		__sepol_debug_printf("Can't read binary policy:  %s\n",
 			strerror(errno));
 		return -1;
 	}
@@ -154,7 +154,7 @@
 	}
 
 	if (evaluate_conds(&policydb) < 0) {
-		fprintf(stderr, "Error while re-evaluating conditionals: %s\n",
+		__sepol_debug_printf("Error while re-evaluating conditionals: %s\n",
 			strerror(errno));
 		return -1;
 	}
@@ -163,7 +163,7 @@
 	pf.len = len;
 	rc = policydb_write(&policydb, &pf);
 	if (rc) {
-		fprintf(stderr, "Can't write binary policy:  %s\n",
+		__sepol_debug_printf("Can't write binary policy:  %s\n",
 			strerror(errno));
 		return -1;
 	}
diff --exclude-from=exclude -N -u -r nsalibsepol/src/genusers.c libsepol-1.3.6/src/genusers.c
--- nsalibsepol/src/genusers.c	2005-02-25 09:44:03.000000000 -0500
+++ libsepol-1.3.6/src/genusers.c	2005-02-25 09:59:11.000000000 -0500
@@ -7,12 +7,25 @@
 
 #include <sepol/policydb.h>
 #include <sepol/mls.h>
+#include <stdarg.h>
 
 #include "private.h"
 
+static int gdebug=1;
+
+void sepol_debug(int on) { gdebug=on; };
+
+void __sepol_debug_printf(const char *fmt, ...) {
+	if (gdebug) {
+		va_list ap;
+		va_start(ap, fmt);
+		vfprintf (stderr, fmt, ap);
+		va_end(ap);
+	}
+}
 #undef BADLINE
 #define BADLINE() { \
-	fprintf(stderr, "%s:  invalid entry %s on line %u\n", \
+	__sepol_debug_printf("%s:  invalid entry %s on line %u\n", \
 		path, buffer, lineno); \
 	continue; \
 }
@@ -68,7 +81,7 @@
 			/* Adding a new user definition. */
 			usrdatum = (user_datum_t *) malloc(sizeof(user_datum_t));
 			if (!id || !usrdatum) {
-				fprintf(stderr, "%s:  out of memory for %s on line %u\n",
+				__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
 					path, buffer, lineno);
 				errno = ENOMEM;
 				free(buffer);
@@ -81,7 +94,7 @@
 			rc = hashtab_insert(policydb->p_users.table,
 					    id, (hashtab_datum_t) usrdatum);
 			if (rc) {
-				fprintf(stderr, "%s:  out of memory for %s on line %u\n",
+				__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
 					path, buffer, lineno);
 				errno = ENOMEM;
 				free(buffer);
@@ -128,7 +141,7 @@
 
 			roldatum = hashtab_search(policydb->p_roles.table, q);
 			if (!roldatum) {
-				fprintf(stderr, "%s:  undefined role %s in %s on line %u\n",
+				__sepol_debug_printf("%s:  undefined role %s in %s on line %u\n",
 					path, q, buffer, lineno);
 				continue;
 			}
@@ -136,7 +149,7 @@
 			for (bit = ebitmap_startbit(&roldatum->dominates); bit < ebitmap_length(&roldatum->dominates); bit++) {
 				if (ebitmap_get_bit(&roldatum->dominates, bit))
 					if (ebitmap_set_bit(&usrdatum->roles, bit, 1)) {
-						fprintf(stderr, "%s:  out of memory for %s on line %u\n",
+						__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
 							path, buffer, lineno);
 						errno = ENOMEM;
 						free(buffer);
@@ -172,7 +185,7 @@
 
 			scontext = malloc(p - q);
 			if (!scontext) {
-				fprintf(stderr, "%s:  out of memory for %s on line %u\n",
+				__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
 					path, buffer, lineno);
 				errno = ENOMEM;
 				free(buffer);
@@ -191,7 +204,7 @@
 			context_init(&context);
 			rc = mls_context_to_sid(policydb, oldc, &r, &context);
 			if (rc) {
-				fprintf(stderr, "%s:  invalid level %s in %s on line %u\n",
+				__sepol_debug_printf("%s:  invalid level %s in %s on line %u\n",
 					path, scontext, buffer, lineno);
 				free(scontext);
 				continue;
@@ -218,7 +231,7 @@
 
 			scontext = malloc(p - q);
 			if (!scontext) {
-				fprintf(stderr, "%s:  out of memory for %s on line %u\n",
+				__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
 					path, buffer, lineno);
 				errno = ENOMEM;
 				free(buffer);
@@ -237,7 +250,7 @@
 			context_init(&context);
 			rc = mls_context_to_sid(policydb, oldc, &r, &context);
 			if (rc) {
-				fprintf(stderr, "%s:  invalid range %s in %s on line %u\n",
+				__sepol_debug_printf("%s:  invalid range %s in %s on line %u\n",
 					path, scontext, buffer, lineno);
 				free(scontext);
 				continue;
@@ -334,7 +347,7 @@
 	pf.data = data;
 	pf.len = len;
 	if (policydb_read(&policydb,&pf, 0)) {
-		fprintf(stderr, "%s:  Can't read binary policy:  %s\n",
+		__sepol_debug_printf("%s:  Can't read binary policy:  %s\n",
 			__FUNCTION__, strerror(errno));
 		return -1;
 	}
@@ -342,7 +355,7 @@
 	/* Load base set of system users from the policy package. */
 	snprintf(path, sizeof path, "%s/system.users", usersdir);
 	if (load_users(&policydb, path) < 0) {
-		fprintf(stderr, "%s: Can't load system.users:  %s\n",
+		__sepol_debug_printf("%s: Can't load system.users:  %s\n",
 			__FUNCTION__, strerror(errno));
 		return -1;
 	}
@@ -350,7 +363,7 @@
 	/* Load locally defined users. */
 	snprintf(path, sizeof path, "%s/local.users", usersdir);
 	if (load_users(&policydb, path) < 0) {
-		fprintf(stderr, "%s:  Can't load local.users:  %s\n",
+		__sepol_debug_printf("%s:  Can't load local.users:  %s\n",
 			__FUNCTION__, strerror(errno));
 		return -1;
 	}
@@ -374,7 +387,7 @@
 	pf.len = 0;
 	rc = policydb_write(&policydb, &pf);
 	if (rc) {
-		fprintf(stderr, "Can't compute length of binary policy:  %s\n",
+		__sepol_debug_printf("Can't compute length of binary policy:  %s\n",
 			strerror(errno));
 		return -1;
 	}
@@ -383,7 +396,7 @@
 	pf.type = PF_USE_MEMORY;	
 	pf.data = malloc(pf.len);
 	if (!pf.data) {
-		fprintf(stderr, "%s:  %s\n", __FUNCTION__, strerror(errno));
+		__sepol_debug_printf("%s:  %s\n", __FUNCTION__, strerror(errno));
 		return -1;
 	}
 
@@ -394,7 +407,7 @@
 	/* Write out the new binary policy image. */
 	rc = policydb_write(&policydb, &pf);
 	if (rc) {
-		fprintf(stderr, "Can't write binary policy:  %s\n",
+		__sepol_debug_printf("Can't write binary policy:  %s\n",
 			strerror(errno));
 		free(pf.data);
 		return -1;
diff --exclude-from=exclude -N -u -r nsalibsepol/src/libsepol.map libsepol-1.3.6/src/libsepol.map
--- nsalibsepol/src/libsepol.map	2005-02-17 17:55:49.000000000 -0500
+++ libsepol-1.3.6/src/libsepol.map	2005-02-25 10:19:28.000000000 -0500
@@ -1,4 +1,4 @@
 {
-  global: sepol_genbools*; sepol_set_policydb_from_file; sepol_check_context; sepol_genusers;
+  global: sepol_genbools*; sepol_set_policydb_from_file; sepol_check_context; sepol_genusers; sepol_debug;
   local: *;
 };
diff --exclude-from=exclude -N -u -r nsalibsepol/src/private.h libsepol-1.3.6/src/private.h
--- nsalibsepol/src/private.h	2005-02-07 10:23:04.000000000 -0500
+++ libsepol-1.3.6/src/private.h	2005-02-25 10:20:39.000000000 -0500
@@ -25,6 +25,7 @@
 };
 
 extern struct policydb_compat_info *policydb_lookup_compat(int version);
+extern void __sepol_debug_printf(const char *fmt, ...);
 
 /* Reading from a policy "file". */
 static inline void *next_entry(struct policy_file * fp, size_t bytes)

--------------010605020607020604010300--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
