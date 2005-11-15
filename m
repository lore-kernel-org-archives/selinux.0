Message-ID: <43799085.4000608@cornell.edu>
Date: Tue, 15 Nov 2005 02:38:45 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Mls cleanups (2)
References: <437931EA.8080605@cornell.edu>
In-Reply-To: <437931EA.8080605@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------090808000302020901060805"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090808000302020901060805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>
> - Hide functions mls_to_string and mls_from string into internal 
> header, since they have no user in the static lib. I introduced those 
> functions, and we should not be adding any functions to the static lib 
> - we should be removing them.
> - Hide functions mls_sid_to_context, mls_context_to_sid, and 
> mls_compute_context_len in the internal header, since they have no 
> user in the static lib *and* are deprecated (though I still use them 
> in a few places)
On second thought, this whole header is not used outside of libsepol (no 
in-tree users).
Move the rest of it into src/mls.h. Applies on top of the other patch.




--------------090808000302020901060805
Content-Type: text/x-patch;
 name="libsepol.mls_cleanup2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.mls_cleanup2.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsepol/include/sepol/policydb/mls.h new/libsepol/include/sepol/policydb/mls.h
--- old/libsepol/include/sepol/policydb/mls.h	2005-11-15 02:35:54.000000000 -0500
+++ new/libsepol/include/sepol/policydb/mls.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,56 +0,0 @@
-
-/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
-/*
- * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
- *
- *	Support for enhanced MLS infrastructure.
- *
- * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-/* FLASK */
-
-/*
- * Multi-level security (MLS) policy operations.
- */
-
-#ifndef _SEPOL_POLICYDB_MLS_H_
-#define _SEPOL_POLICYDB_MLS_H_
-
-#include <sepol/handle.h>
-#include <sepol/policydb/context.h>
-#include <sepol/policydb/policydb.h>
-
-extern int mls_context_isvalid(policydb_t *p, context_struct_t * c);
-
-extern int mls_convert_context(policydb_t * oldp,
-			policydb_t * newp,
-			context_struct_t * context);
-
-extern int mls_compute_sid(policydb_t *policydb,
-		    context_struct_t *scontext,
-		    context_struct_t *tcontext,
-		    sepol_security_class_t tclass,
-		    uint32_t specified,
-		    context_struct_t *newcontext);
-
-extern int mls_setup_user_range(
-	context_struct_t *fromcon, user_datum_t *user,
-	context_struct_t *usercon, int mls);
-
-#endif	
-
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsepol/src/mls.h new/libsepol/src/mls.h
--- old/libsepol/src/mls.h	2005-11-15 02:35:54.000000000 -0500
+++ new/libsepol/src/mls.h	2005-11-15 02:34:08.000000000 -0500
@@ -1,9 +1,30 @@
+/* Author: Stephen Smalley, <sds@epoch.ncsc.mil> 
+ * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
+ * 
+ *      Support for enhanced MLS infrastructure.
+ *
+ * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
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
 #ifndef _SEPOL_MLS_INTERNAL_H_
 #define _SEPOL_MLS_INTERNAL_H_
 
 #include "policydb_internal.h"
 #include <sepol/policydb/context.h>
-#include <sepol/policydb/mls.h>
 #include "handle.h"
 
 extern int mls_from_string(
@@ -37,5 +58,26 @@ extern int mls_context_to_sid(
 	char **scontext,
 	context_struct_t *context);
 
+extern int mls_context_isvalid(
+	policydb_t *p, 
+	context_struct_t * c);
+
+extern int mls_convert_context(
+	policydb_t * oldp,
+	policydb_t * newp,
+	context_struct_t * context);
+
+extern int mls_compute_sid(
+	policydb_t *policydb,
+	context_struct_t *scontext,
+	context_struct_t *tcontext,
+	sepol_security_class_t tclass,
+	uint32_t specified,
+	context_struct_t *newcontext);
+
+extern int mls_setup_user_range(
+        context_struct_t *fromcon, user_datum_t *user,
+        context_struct_t *usercon, int mls);
+
 #endif
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsepol/src/policydb.c new/libsepol/src/policydb.c
--- old/libsepol/src/policydb.c	2005-10-26 09:34:29.000000000 -0400
+++ new/libsepol/src/policydb.c	2005-11-15 02:34:49.000000000 -0500
@@ -46,12 +46,12 @@
 
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/expand.h>
-#include <sepol/policydb/mls.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/avrule_block.h>
 
 #include "private.h"
 #include "debug.h"
+#include "mls.h"
 
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
 static struct policydb_compat_info policydb_compat[] = {
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsepol/src/services.c new/libsepol/src/services.c
--- old/libsepol/src/services.c	2005-11-01 17:32:59.000000000 -0500
+++ new/libsepol/src/services.c	2005-11-15 02:34:22.000000000 -0500
@@ -52,7 +52,6 @@
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/sidtab.h>
 #include <sepol/policydb/services.h>
-#include <sepol/policydb/mls.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/flask.h>
 
@@ -61,6 +60,7 @@
 #include "context.h"
 #include "av_permissions.h"
 #include "dso.h"
+#include "mls.h"
 
 #define BUG() do { ERR(NULL, "Badness at %s:%d", __FILE__, __LINE__); } while (0)
 #define BUG_ON(x) do { if (x) ERR(NULL, "Badness at %s:%d", __FILE__, __LINE__); } while (0)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsepol/src/write.c new/libsepol/src/write.c
--- old/libsepol/src/write.c	2005-10-26 09:34:29.000000000 -0400
+++ new/libsepol/src/write.c	2005-11-15 02:34:30.000000000 -0500
@@ -36,13 +36,13 @@
 
 #include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/avtab.h>
-#include <sepol/policydb/mls.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/expand.h>
 
 #include "debug.h"
 #include "private.h"
+#include "mls.h"
 
 struct policy_data
 {

--------------090808000302020901060805--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
