Subject: Re: [ SEPOL ] Further users cleanup
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1129916287.27663.94.camel@moss-spartans.epoch.ncsc.mil>
References: <435903C2.2050805@cornell.edu>
	 <1129908379.27663.59.camel@moss-spartans.epoch.ncsc.mil>
	 <4359199A.40303@cornell.edu>
	 <1129916287.27663.94.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-pL1NTDtRpSY+lhgDpKbx"
Date: Tue, 25 Oct 2005 11:00:31 -0400
Message-Id: <1130252431.17609.326.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-pL1NTDtRpSY+lhgDpKbx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-10-21 at 13:38 -0400, Stephen Smalley wrote:
> Also need to fix this:
> $ relinfo.pl src/libsepol.so.1
> src/libsepol.so.1: 68 relocations, 61 relative (89%), 94 PLT entries, 60 for local syms (63%), 0 users
> 
> There shouldn't be any for local syms; need to bring over dso.h and
> hidden_def/hidden_proto stuff from libselinux.

Attached patch does this for the sepol_bool functions used internally by
libsepol.  Same kind of change needs to be made for all sepol functions
that one sees in readelf -r libsepol.so.1

-- 
Stephen Smalley
National Security Agency

--=-pL1NTDtRpSY+lhgDpKbx
Content-Disposition: attachment; filename=libsepol-hidebool.patch
Content-Type: text/x-patch; name=libsepol-hidebool.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -X /home/sds/dontdiff -Nrup libsepol.old/src/boolean_internal.h libsepol/src/boolean_internal.h
--- libsepol.old/src/boolean_internal.h	1969-12-31 19:00:00.000000000 -0500
+++ libsepol/src/boolean_internal.h	2005-10-25 10:40:03.000000000 -0400
@@ -0,0 +1,11 @@
+#include <sepol/boolean_record.h>
+#include "dso.h"
+
+hidden_proto(sepol_bool_key_create)
+hidden_proto(sepol_bool_key_unpack)
+hidden_proto(sepol_bool_get_name)
+hidden_proto(sepol_bool_set_name)
+hidden_proto(sepol_bool_get_value)
+hidden_proto(sepol_bool_set_value)
+hidden_proto(sepol_bool_create)
+hidden_proto(sepol_bool_free)
diff -X /home/sds/dontdiff -Nrup libsepol.old/src/boolean_record.c libsepol/src/boolean_record.c
--- libsepol.old/src/boolean_record.c	2005-10-25 10:44:19.000000000 -0400
+++ libsepol/src/boolean_record.c	2005-10-25 10:44:29.000000000 -0400
@@ -2,7 +2,7 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include <sepol/boolean_record.h>
+#include "boolean_internal.h"
 #include "debug.h"
 
 struct sepol_bool {
@@ -36,6 +36,7 @@ int sepol_bool_key_create(
 	*key_ptr = tmp_key;
 	return STATUS_SUCCESS;
 }
+hidden_def(sepol_bool_key_create)
 
 void sepol_bool_key_unpack(
 	sepol_bool_key_t* key,
@@ -43,6 +44,7 @@ void sepol_bool_key_unpack(
 
 	*name = key->name;
 }
+hidden_def(sepol_bool_key_unpack)
 
 int sepol_bool_key_extract(sepol_bool_t* boolean, sepol_bool_key_t** key_ptr) {
 	if (sepol_bool_key_create(boolean->name, key_ptr) < 0) {
@@ -71,6 +73,7 @@ int sepol_bool_compare(
 const char* sepol_bool_get_name(sepol_bool_t* boolean) {
 	return boolean->name;
 }
+hidden_def(sepol_bool_get_name)
 
 int sepol_bool_set_name(sepol_bool_t* boolean, const char* name) {
 	boolean->name = strdup(name);
@@ -81,15 +84,18 @@ int sepol_bool_set_name(sepol_bool_t* bo
 	}
 	return STATUS_SUCCESS;
 }
+hidden_def(sepol_bool_set_name)
 
 /* Value */
 int sepol_bool_get_value(sepol_bool_t* boolean) {
 	return boolean->value;
 }
+hidden_def(sepol_bool_get_value)
 
 void sepol_bool_set_value(sepol_bool_t* boolean, int value) {
 	boolean->value = value;
 }
+hidden_def(sepol_bool_set_value)
 
 /* Create */
 int sepol_bool_create(sepol_bool_t** bool_ptr) {
@@ -107,6 +113,7 @@ int sepol_bool_create(sepol_bool_t** boo
 	*bool_ptr = boolean;
 	return STATUS_SUCCESS;
 }
+hidden_def(sepol_bool_create)
 
 /* Deep copy clone */
 int sepol_bool_clone(sepol_bool_t* boolean, sepol_bool_t** bool_ptr) {
@@ -137,3 +144,4 @@ void sepol_bool_free(sepol_bool_t* boole
 	free(boolean->name);
 	free(boolean);
 }
+hidden_def(sepol_bool_free)
diff -X /home/sds/dontdiff -Nrup libsepol.old/src/booleans.c libsepol/src/booleans.c
--- libsepol.old/src/booleans.c	2005-10-25 10:44:19.000000000 -0400
+++ libsepol/src/booleans.c	2005-10-25 10:44:29.000000000 -0400
@@ -10,7 +10,7 @@
 #include <sepol/policydb/hashtab.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/conditional.h>
-#include <sepol/boolean_record.h>
+#include "boolean_internal.h"
 
 static int bool_update (
 	policydb_t* policydb,
diff -X /home/sds/dontdiff -Nrup libsepol.old/src/dso.h libsepol/src/dso.h
--- libsepol.old/src/dso.h	1969-12-31 19:00:00.000000000 -0500
+++ libsepol/src/dso.h	2005-10-25 10:24:46.000000000 -0400
@@ -0,0 +1,23 @@
+#ifndef _SEPOL_DSO_H
+#define _SEPOL_DSO_H	1
+
+#ifdef SHARED
+# define hidden __attribute__ ((visibility ("hidden")))
+# define hidden_proto(fct) __hidden_proto (fct, fct##_internal)
+# define __hidden_proto(fct, internal)	\
+     extern __typeof (fct) internal;	\
+     extern __typeof (fct) fct __asm (#internal) hidden;
+# if defined(__alpha__) || defined(__mips__)
+#  define hidden_def(fct) \
+     asm (".globl " #fct "\n" #fct " = " #fct "_internal");
+# else
+#  define hidden_def(fct) \
+     asm (".globl " #fct "\n.set " #fct ", " #fct "_internal");
+#endif
+#else
+# define hidden
+# define hidden_proto(fct)
+# define hidden_def(fct)
+#endif
+
+#endif
diff -X /home/sds/dontdiff -Nrup libsepol.old/src/Makefile libsepol/src/Makefile
--- libsepol.old/src/Makefile	2005-10-25 10:44:19.000000000 -0400
+++ libsepol/src/Makefile	2005-10-25 10:44:29.000000000 -0400
@@ -27,7 +27,7 @@ $(LIBSO): $(LOBJS)
 	$(CC) $(CFLAGS) -c -o $@ $<
 
 %.lo:  %.c
-	$(CC) $(CFLAGS) -fPIC -c -o $@ $<
+	$(CC) $(CFLAGS) -fpic -DSHARED -c -o $@ $<
 
 install: all
 	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)

--=-pL1NTDtRpSY+lhgDpKbx--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
