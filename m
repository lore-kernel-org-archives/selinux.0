Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8MChmNs018952
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 08:43:49 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8MCdP6p018780
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 12:39:26 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j8MCdHah026180
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 08:39:17 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j8MCdHXK026179
	for selinux@tycho.nsa.gov; Thu, 22 Sep 2005 08:39:17 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8M5GZNs016476
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 01:16:35 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8M5CG6p016174
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 05:12:16 GMT
Message-ID: <43323EF2.20201@cornell.edu>
Date: Thu, 22 Sep 2005 01:19:46 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: kmacmillan@tresys.com, dwalsh@redhat.com
Subject: Re: [ SEMANAGE ] Redesign dbase
References: <43320A2E.5000906@cornell.edu> <4332121F.2010904@cornell.edu>
In-Reply-To: <4332121F.2010904@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------040700020407080901060906"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040700020407080901060906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Allright, here's the same patch again, with the query issue fixed.
Also, I've implemented the function which creates the cache (main 
processing loop),
and renamed some things. I've clarified the specification for
record.parse(), and added some things to parse_info structure.

----

This can become functional as soon as I implement the record parse/print 
functions,
and put the database_config array into the semanage handle.

Then a function to write the cache on commit (which is trivial)...
and handlers to load things into policy, based on dbase_iterate().



--------------040700020407080901060906
Content-Type: text/x-patch;
 name="libsemanage.redesign2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.redesign2.diff"

diff -Naru libsemanage/include/semanage/boolean_record.h libsemanage.new/include/semanage/boolean_record.h
--- libsemanage/include/semanage/boolean_record.h	2005-09-21 10:42:24.000000000 -0400
+++ libsemanage.new/include/semanage/boolean_record.h	2005-09-21 20:47:18.000000000 -0400
@@ -1,67 +1,52 @@
 #ifndef _SEMANAGE_BOOLEAN_RECORD_H_
 #define _SEMANAGE_BOOLEAN_RECORD_H_
 
-/* Implementation via sepol */
-#include <sepol/bool_record.h>
-typedef sepol_bool_t semanage_bool_t;
-typedef sepol_bool_key_t semanage_bool_key_t;
+struct semanage_bool; 
+struct semanage_bool_key;
+typedef struct semanage_bool* semanage_bool_t;
+typedef struct semanage_bool_key* semanage_bool_key_t;
 
 /* Key */
-static inline
-int semanage_bool_key_create(const char* name, semanage_bool_key_t* key) {
-	return sepol_bool_key_create(name, key);
-}
-
-static inline
-int semanage_bool_key_extract(semanage_bool_t boolean, semanage_bool_key_t* key) {
-	return sepol_bool_key_extract(boolean, key);
-}
-
-static inline 
-void semanage_bool_key_free(semanage_bool_key_t key) {
-	sepol_bool_key_free(key);
-}
-
-static inline
-int semanage_bool_compare(semanage_bool_t boolean, semanage_bool_key_t key) {
-	return sepol_bool_compare(boolean, key);
-}
+extern int semanage_bool_key_create(
+	const char* name, 
+	semanage_bool_key_t* key);
+
+extern int semanage_bool_key_extract(
+	semanage_bool_t boolean, 
+	semanage_bool_key_t* key);
+
+extern void semanage_bool_key_free(
+	semanage_bool_key_t key);
+
+extern int semanage_bool_compare(
+	semanage_bool_t boolean, 
+	semanage_bool_key_t key);
 	
 /* Name */
-static inline
-const char* semanage_bool_get_name(semanage_bool_t boolean) {
-	return sepol_bool_get_name(boolean);
-}
-
-static inline
-int semanage_bool_set_name(semanage_bool_t boolean, const char* name) {
-	return sepol_bool_set_name(boolean, name);
-}
+extern const char* semanage_bool_get_name(
+	semanage_bool_t boolean);
+
+extern int semanage_bool_set_name(
+	semanage_bool_t boolean, 
+	const char* name);
 
 /* Value */
-static inline
-int semanage_bool_get_value(semanage_bool_t boolean) {
-	return sepol_bool_get_value(boolean);
-}
-
-static inline
-void semanage_bool_set_value(semanage_bool_t boolean, int value) {
-	sepol_bool_set_value(boolean, value);
-}
+extern int semanage_bool_get_value(
+	semanage_bool_t boolean);
+
+extern void semanage_bool_set_value(
+	semanage_bool_t boolean, 
+	int value);
 
 /* Create/Clone/Destroy */
-static inline
-int semanage_bool_create(semanage_bool_t* bool_ptr) {
-	return sepol_bool_create(bool_ptr);
-}
-
-static inline
-int semanage_bool_clone(semanage_bool_t boolean, semanage_bool_t* bool_ptr) {
-	return sepol_bool_clone(boolean, bool_ptr);
-}
-
-static inline
-void semanage_bool_free(semanage_bool_t boolean) {
-	sepol_bool_free(boolean);
-}
+extern int semanage_bool_create(
+	semanage_bool_t* bool_ptr);
+
+extern int semanage_bool_clone(
+	semanage_bool_t boolean, 
+	semanage_bool_t* bool_ptr);
+
+extern void semanage_bool_free(
+	semanage_bool_t boolean);
+
 #endif
diff -Naru libsemanage/include/semanage/context_record.h libsemanage.new/include/semanage/context_record.h
--- libsemanage/include/semanage/context_record.h	2005-08-02 09:18:47.000000000 -0400
+++ libsemanage.new/include/semanage/context_record.h	2005-09-21 20:44:37.000000000 -0400
@@ -1,78 +1,58 @@
 #ifndef _SEMANAGE_CONTEXT_RECORD_H_
 #define _SEMANAGE_CONTEXT_RECORD_H_ 
 
-/* Implementation via sepol */
-#include <sepol/context_record.h>
-typedef sepol_context_t semanage_context_t;
+struct semanage_context;
+typedef struct semanage_context* semanage_context_t;
 
 /* User */
-static inline 
-const char* semanage_context_get_user(semanage_context_t con) {
-	return sepol_context_get_user(con);
-}
-
-static inline
-int semanage_context_set_user(semanage_context_t con, const char* user) {
-	return sepol_context_set_user(con, user);
-}
+extern const char* semanage_context_get_user(
+	semanage_context_t con);
+
+extern int semanage_context_set_user(
+	semanage_context_t con, 
+	const char* user);
 
 /* Role */
-static inline
-const char* semanage_context_get_role(semanage_context_t con) {
-	return sepol_context_get_role(con);
-}
-
-static inline
-int semanage_context_set_role(semanage_context_t con, const char* role) {
-	return sepol_context_set_role(con, role);
-}
+extern const char* semanage_context_get_role(
+	semanage_context_t con);
+
+extern int semanage_context_set_role(
+	semanage_context_t con, 
+	const char* role);
 
 /* Type */
-static inline
-const char* semanage_context_get_type(semanage_context_t con) {
-	return sepol_context_get_type(con);
-}
-
-static inline 
-int semanage_context_set_type(semanage_context_t con, const char* type) {
-	return sepol_context_set_type(con, type);
-}
+extern const char* semanage_context_get_type(
+	semanage_context_t con);
+
+extern int semanage_context_set_type(
+	semanage_context_t con, 
+	const char* type);
 
 /* MLS */
-static inline 
-const char* semanage_context_get_mls(semanage_context_t con) {
-	return sepol_context_get_mls(con);
-}
-
-static inline
-int semanage_context_set_mls(semanage_context_t con, const char* mls_range) {
-	return sepol_context_set_mls(con, mls_range);
-}
+extern const char* semanage_context_get_mls(
+	semanage_context_t con);
+
+extern int semanage_context_set_mls(
+	semanage_context_t con, 
+	const char* mls_range);
 
 /* Create/Clone/Destroy */
-static inline
-int semanage_context_create(semanage_context_t* con_ptr) {
-	return sepol_context_create(con_ptr);
-}
-
-static inline
-int semanage_context_clone(semanage_context_t con, semanage_context_t* con_ptr) {
-	return sepol_context_clone(con, con_ptr);
-}
-
-static inline
-void semanage_context_free(semanage_context_t con) {
-	sepol_context_free(con);
-}
+extern int semanage_context_create(
+	semanage_context_t* con_ptr);
+
+extern int semanage_context_clone(
+	semanage_context_t con, 
+	semanage_context_t* con_ptr);
+
+extern void semanage_context_free(
+	semanage_context_t con);
 	
 /* Parse to/from string */
-static inline
-int semanage_context_from_string(const char* str, semanage_context_t* con) {
-	return sepol_context_from_string(str, con);
-}
-
-static inline 
-char* semanage_context_to_string(semanage_context_t con) {
-	return sepol_context_to_string(con);
-}
+extern int semanage_context_from_string(
+	const char* str, 
+	semanage_context_t* con);
+
+extern char* semanage_context_to_string(
+	semanage_context_t con);
+
 #endif 
diff -Naru libsemanage/include/semanage/iface_record.h libsemanage.new/include/semanage/iface_record.h
--- libsemanage/include/semanage/iface_record.h	2005-09-19 15:31:27.000000000 -0400
+++ libsemanage.new/include/semanage/iface_record.h	2005-09-21 20:44:40.000000000 -0400
@@ -3,81 +3,59 @@
 
 #include <semanage/context_record.h>
 
-/* Implentation via sepol */
-#include <sepol/iface_record.h>
-typedef sepol_iface_t semanage_iface_t;
-typedef sepol_iface_key_t semanage_iface_key_t;
+struct semanage_iface;
+struct semanage_iface_key;
+typedef struct semanage_iface* semanage_iface_t;
+typedef struct semanage_iface_key* semanage_iface_key_t;
 
 /* Key */
-static inline
-int semanage_iface_compare(semanage_iface_t iface, semanage_iface_key_t key) {
-	return sepol_iface_compare(iface, key);
-}
+extern int semanage_iface_compare(
+	semanage_iface_t iface, 
+	semanage_iface_key_t key);
 
-static inline
-int semanage_iface_key_create(
+extern int semanage_iface_key_create(
 	const char* name,
-	semanage_iface_key_t* key_ptr) {
-	return sepol_iface_key_create(name, key_ptr);
-}
+	semanage_iface_key_t* key_ptr);
 
-static inline
-int semanage_iface_key_extract(
+extern int semanage_iface_key_extract(
 	semanage_iface_t iface,
-	semanage_iface_key_t* key_ptr) {
-	return sepol_iface_key_extract(iface, key_ptr);
-}
-
-static inline
-void semanage_iface_key_free(semanage_iface_key_t key) {
-	sepol_iface_key_free(key);
-}
+	semanage_iface_key_t* key_ptr);
+
+extern void semanage_iface_key_free(
+	semanage_iface_key_t key);
 
 /* Name */
-static inline
-const char* semanage_iface_get_name(semanage_iface_t iface) {
-        return sepol_iface_get_name(iface);
-}
-
-static inline
-int semanage_iface_set_name(semanage_user_t iface, const char* name) {
-        return sepol_iface_set_name(iface, name);
-}
-	
+extern const char* semanage_iface_get_name(
+	semanage_iface_t iface);
+
+extern int semanage_iface_set_name(
+	semanage_user_t iface, 
+	const char* name);
+
 /* Context */
-static inline
-semanage_context_t semanage_iface_get_ifcon(semanage_iface_t iface) {
-	return sepol_iface_get_ifcon(iface);
-}
-
-static inline
-int semanage_iface_set_ifcon(semanage_iface_t iface, semanage_context_t con) {
-	return sepol_iface_set_ifcon(iface, con);
-}
-
-static inline
-semanage_context_t semanage_iface_get_msgcon(semanage_iface_t iface) {
-	return sepol_iface_get_msgcon(iface);	
-}
-
-static inline
-int semanage_iface_set_msgcon(semanage_iface_t iface, semanage_context_t con) {
-	return sepol_iface_set_msgcon(iface, con);
-}
+extern semanage_context_t semanage_iface_get_ifcon(
+	semanage_iface_t iface);
+
+extern int semanage_iface_set_ifcon(
+	semanage_iface_t iface, 
+	semanage_context_t con);
+
+extern semanage_context_t semanage_iface_get_msgcon(
+	semanage_iface_t iface);
+
+extern int semanage_iface_set_msgcon(
+	semanage_iface_t iface, 
+	semanage_context_t con);
 
 /* Create/Clone/Destroy */
-static inline
-int semanage_iface_create(semanage_iface_t* iface_ptr) {
-	return sepol_iface_create(iface_ptr);
-}
-
-static inline
-int semanage_iface_clone(semanage_iface_t iface, semanage_iface_t* iface_ptr) {
-	return sepol_iface_clone(iface, iface_ptr);
-}
-
-static inline
-void semanage_iface_free(semanage_iface_t iface) {
-	sepol_iface_free(iface);
-}
+extern int semanage_iface_create(
+	semanage_iface_t* iface_ptr);
+
+extern int semanage_iface_clone(
+	semanage_iface_t iface, 
+	semanage_iface_t* iface_ptr);
+
+extern void semanage_iface_free(
+	semanage_iface_t iface);
+
 #endif
diff -Naru libsemanage/include/semanage/port_record.h libsemanage.new/include/semanage/port_record.h
--- libsemanage/include/semanage/port_record.h	2005-08-02 09:18:47.000000000 -0400
+++ libsemanage.new/include/semanage/port_record.h	2005-09-21 20:46:12.000000000 -0400
@@ -3,100 +3,74 @@
 
 #include <semanage/context_record.h>
 
-/* Implentation via sepol */
-#include <sepol/port_record.h>
-typedef sepol_port_t semanage_port_t;
-typedef sepol_port_key_t semanage_port_key_t;
+struct semanage_port;
+struct semanage_port_key;
+typedef struct semanage_port* semanage_port_t;
+typedef struct semanage_port_key* semanage_port_key_t;
 
 #define SEMANAGE_PROTO_UDP SEPOL_PROTO_UDP
 #define SEMANAGE_PROTO_TCP SEPOL_PROTO_TCP
 
 /* Key */
-static inline
-int semanage_port_compare(semanage_port_t port, semanage_port_key_t key) {
-	return sepol_port_compare(port, key);
-}
-
-static inline
-int semanage_port_key_create(
-	int low, int high, int proto, 
-	semanage_port_key_t* key_ptr) {
-	return sepol_port_key_create(low, high, proto, key_ptr);
-}
+extern int semanage_port_compare(
+	semanage_port_t port, 
+	semanage_port_key_t key);
+
+extern int semanage_port_key_create(
+	int low, int high, 
+	int proto, 
+	semanage_port_key_t* key_ptr);
 
-static inline
-int semanage_port_key_extract(
+extern int semanage_port_key_extract(
 	semanage_port_t port,
-	semanage_port_key_t* key_ptr) {
-	return sepol_port_key_extract(port, key_ptr);
-}
-
-static inline
-void semanage_port_key_free(semanage_port_key_t key) {
-	sepol_port_key_free(key);
-}	
+	semanage_port_key_t* key_ptr);
+
+extern void semanage_port_key_free(
+	semanage_port_key_t key);
 
 /* Protocol */
-static inline
-int semanage_port_get_proto(semanage_port_t port) {
-	return sepol_port_get_proto(port);
-}
-
-static inline
-int semanage_port_set_proto(semanage_port_t port, int proto) {
-	return sepol_port_set_proto(port, proto);
-}
-
-static inline
-const char* semanage_port_get_proto_str(semanage_port_t port) {
-	return sepol_port_get_proto_str(port);
-}
+extern int semanage_port_get_proto(
+	semanage_port_t port);
+
+extern int semanage_port_set_proto(
+	semanage_port_t port, 
+	int proto);
+
+extern const char* semanage_port_get_proto_str(
+	semanage_port_t port);
 
 /* Port */
-static inline
-int semanage_port_get_low(semanage_port_t port) {
-	return sepol_port_get_low(port);
-}
-
-static inline
-int semanage_port_get_high(semanage_port_t port) {
-	return sepol_port_get_high(port);
-}
-
-static inline 
-int semanage_port_set_port(semanage_port_t port, int port_num) {
-	return sepol_port_set_port(port, port_num);
-}
-
-static inline
-int semanage_port_set_range(semanage_port_t port, int low, int high) {
-	return sepol_port_set_range(port, low, high);
-}
+extern int semanage_port_get_low(
+	semanage_port_t port);
+
+extern int semanage_port_get_high(
+	semanage_port_t port);
+
+extern int semanage_port_set_port(
+	semanage_port_t port, 
+	int port_num);
+
+extern int semanage_port_set_range(
+	semanage_port_t port, 
+	int low, int high);
 
 /* Context */
-static inline
-semanage_context_t semanage_port_get_con(semanage_port_t port) {
-	return sepol_port_get_con(port);	
-}
-
-static inline
-int semanage_port_set_con(semanage_port_t port, semanage_context_t con) {
-	return sepol_port_set_con(port, con);
-}
+extern semanage_context_t semanage_port_get_con(
+	semanage_port_t port);
+
+extern int semanage_port_set_con(
+	semanage_port_t port, 
+	semanage_context_t con);
 
 /* Create/Clone/Destroy */
-static inline
-int semanage_port_create(semanage_port_t* port_ptr) {
-	return sepol_port_create(port_ptr);
-}
-
-static inline
-int semanage_port_clone(semanage_port_t port, semanage_port_t* port_ptr) {
-	return sepol_port_clone(port, port_ptr);
-}
-
-static inline
-void semanage_port_free(semanage_port_t port) {
-	sepol_port_free(port);
-}
+extern int semanage_port_create(
+	semanage_port_t* port_ptr);
+
+extern int semanage_port_clone(
+	semanage_port_t port, 
+	semanage_port_t* port_ptr);
+
+extern void semanage_port_free(
+	semanage_port_t port);
+
 #endif
diff -Naru libsemanage/include/semanage/ports.h libsemanage.new/include/semanage/ports.h
--- libsemanage/include/semanage/ports.h	2005-09-14 11:44:43.000000000 -0400
+++ libsemanage.new/include/semanage/ports.h	2005-09-21 18:35:15.000000000 -0400
@@ -27,14 +27,12 @@
 	int* response);
 
 extern int semanage_port_iterate(
-	int (*handler) (semanage_port_key_t key,
-	                semanage_port_t record,
+	int (*handler) (semanage_port_t record,
 	                void* varg),
 	void* handler_arg);
 
 extern int semanage_port_list(
-	semanage_port_key_t** keyset,
-	semanage_port_t** dataset,
+	semanage_port_t** records,
 	size_t* count);
 
 #endif 
diff -Naru libsemanage/include/semanage/user_record.h libsemanage.new/include/semanage/user_record.h
--- libsemanage/include/semanage/user_record.h	2005-08-02 09:18:47.000000000 -0400
+++ libsemanage.new/include/semanage/user_record.h	2005-09-21 20:55:32.000000000 -0400
@@ -1,124 +1,91 @@
 #ifndef _SEMANAGE_USER_RECORD_H_
 #define _SEMANAGE_USER_RECORD_H_
 
-/* Implementation via sepol */
-#include <sepol/user_record.h>
-typedef sepol_user_t semanage_user_t;
-typedef sepol_user_key_t semanage_user_key_t;
+struct semanage_user;
+struct semanage_user_key;
+typedef struct semanage_user* semanage_user_t;
+typedef struct semanage_user_key* semanage_user_key_t;
 
 /* Key */
-static inline
-int semanage_user_key_create(const char* name, semanage_user_key_t* key) {
-	return sepol_user_key_create(name, key);
-}
-
-static inline
-int semanage_user_key_extract(semanage_user_t user, semanage_user_key_t* key) {
-	return sepol_user_key_extract(user, key);
-}
-
-static inline 
-void semanage_user_key_free(semanage_user_key_t key) {
-	sepol_user_key_free(key);
-}
-
-static inline
-int semanage_user_compare(semanage_user_t user, semanage_user_key_t key) {
-	return sepol_user_compare(user, key);
-}
+extern int semanage_user_key_create(
+	const char* name, 
+	semanage_user_key_t* key);
+
+extern int semanage_user_key_extract(
+	semanage_user_t user, 
+	semanage_user_key_t* key);
+
+extern void semanage_user_key_free(
+	semanage_user_key_t key);
+
+extern int semanage_user_compare(
+	semanage_user_t user, 
+	semanage_user_key_t key);
 	
 /* Name */
-static inline
-const char* semanage_user_get_name(semanage_user_t user) {
-	return sepol_user_get_name(user);
-}
-
-static inline
-int semanage_user_set_name(semanage_user_t user, const char* name) {
-	return sepol_user_set_name(user, name);
-}
+extern const char* semanage_user_get_name(
+	semanage_user_t user);
+
+extern int semanage_user_set_name(
+	semanage_user_t user, 
+	const char* name);
 
 /* MLS */
-static inline
-const char* semanage_user_get_mlslevel(semanage_user_t user) {
-	return sepol_user_get_mlslevel(user);
-}
-
-static inline
-int semanage_user_set_mlslevel(semanage_user_t user, const char* mls_level) {
-	return sepol_user_set_mlslevel(user, mls_level);
-}
-
-static inline
-const char* semanage_user_get_mlsrange(semanage_user_t user) {
-	return sepol_user_get_mlsrange(user);
-}
-
-static inline
-int semanage_user_set_mlsrange(semanage_user_t user, const char* mls_range) {
-	return sepol_user_set_mlsrange(user, mls_range);
-}
+extern const char* semanage_user_get_mlslevel(
+	semanage_user_t user);
+
+extern int semanage_user_set_mlslevel(
+	semanage_user_t user, 
+	const char* mls_level);
+
+extern const char* semanage_user_get_mlsrange(
+	semanage_user_t user);
+
+extern int semanage_user_set_mlsrange(
+	semanage_user_t user, 
+	const char* mls_range);
 
 /* Role management */
-static inline
-int semanage_user_get_num_roles(semanage_user_t user) {
-	return sepol_user_get_num_roles(user);
-}
-
-static inline
-const char* semanage_user_get_defrole(semanage_user_t user) {
-	return sepol_user_get_defrole(user);
-}
-
-static inline
-int semanage_user_add_role(semanage_user_t user, const char* role) {
-	return sepol_user_add_role(user, role);
-}
-
-static inline
-int semanage_user_del_role(semanage_user_t user, const char* role) {
-	return sepol_user_del_role(user, role);
-}
-
-static inline
-int semanage_user_has_role(semanage_user_t user, const char* role) {
-	return sepol_user_has_role(user, role);
-}
-
-static inline
-int semanage_user_set_defrole(semanage_user_t user, const char* role) {
-	return sepol_user_set_defrole(user, role);
-}
+extern int semanage_user_get_num_roles(
+	semanage_user_t user);
+
+extern const char* semanage_user_get_defrole(
+	semanage_user_t user);
+
+extern int semanage_user_add_role(
+	semanage_user_t user, 
+	const char* role);
+
+extern int semanage_user_del_role(
+	semanage_user_t user, 
+	const char* role);
 
-static inline 
-int semanage_user_get_roles(
+extern int semanage_user_has_role(
+	semanage_user_t user, 
+	const char* role);
+
+extern int semanage_user_set_defrole(
+	semanage_user_t user, 
+	const char* role);
+
+extern int semanage_user_get_roles(
 	semanage_user_t user,
 	const char*** roles_arr, 
-	size_t* num_roles) {
-	return sepol_user_get_roles(user, roles_arr, num_roles);
-}
+	size_t* num_roles);
 
-static inline
-int semanage_user_set_roles(
+extern int semanage_user_set_roles(
 	semanage_user_t user,
 	const char** roles_arr,
-	size_t num_roles) {
-	return sepol_user_set_roles(user, roles_arr, num_roles);
-}
+	size_t num_roles);
 
 /* Create/Clone/Destroy */
-static inline
-int semanage_user_create(semanage_user_t* user_ptr) {
-	return sepol_user_create(user_ptr);
-}
-
-static inline
-int semanage_user_clone(semanage_user_t user, semanage_user_t* user_ptr) {
-	return sepol_user_clone(user, user_ptr);
-}
-
-static inline
-void semanage_user_free(semanage_user_t user) {
-	sepol_user_free(user);
-}
+extern int semanage_user_create(
+	semanage_user_t* user_ptr);
+
+extern int semanage_user_clone(
+	semanage_user_t user, 
+	semanage_user_t* user_ptr);
+
+extern void semanage_user_free(
+	semanage_user_t user);
 #endif
diff -Naru libsemanage/include/semanage/users.h libsemanage.new/include/semanage/users.h
--- libsemanage/include/semanage/users.h	2005-09-14 11:44:43.000000000 -0400
+++ libsemanage.new/include/semanage/users.h	2005-09-21 18:35:39.000000000 -0400
@@ -27,14 +27,12 @@
 	int* response);
 
 extern int semanage_user_iterate(
-	int (*handler) (semanage_user_key_t key,
-	                semanage_user_t record,
+	int (*handler) (semanage_user_t record,
 	                void* varg),
 	void* handler_arg);
 
 extern int semanage_user_list(
-	semanage_user_key_t** keyset,
-	semanage_user_t** dataset,
+	semanage_user_t** records,
 	size_t* count);
 
 #endif 
diff -Naru libsemanage/src/boolean_record.c libsemanage.new/src/boolean_record.c
--- libsemanage/src/boolean_record.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/boolean_record.c	2005-09-21 20:53:17.000000000 -0400
@@ -0,0 +1,52 @@
+#include <sepol/boolean_record.h>
+
+typedef sepol_bool_t semanage_bool_t;
+typedef sepol_bool_key_t semanage_bool_key_t;
+
+/* Key */
+int semanage_bool_key_create(const char* name, semanage_bool_key_t* key) {
+	return sepol_bool_key_create(name, key);
+}
+
+int semanage_bool_key_extract(semanage_bool_t boolean, semanage_bool_key_t* key) {
+	return sepol_bool_key_extract(boolean, key);
+}
+
+void semanage_bool_key_free(semanage_bool_key_t key) {
+	sepol_bool_key_free(key);
+}
+
+int semanage_bool_compare(semanage_bool_t boolean, semanage_bool_key_t key) {
+	return sepol_bool_compare(boolean, key);
+}
+	
+/* Name */
+const char* semanage_bool_get_name(semanage_bool_t boolean) {
+	return sepol_bool_get_name(boolean);
+}
+
+int semanage_bool_set_name(semanage_bool_t boolean, const char* name) {
+	return sepol_bool_set_name(boolean, name);
+}
+
+/* Value */
+int semanage_bool_get_value(semanage_bool_t boolean) {
+	return sepol_bool_get_value(boolean);
+}
+
+void semanage_bool_set_value(semanage_bool_t boolean, int value) {
+	sepol_bool_set_value(boolean, value);
+}
+
+/* Create/Clone/Destroy */
+int semanage_bool_create(semanage_bool_t* bool_ptr) {
+	return sepol_bool_create(bool_ptr);
+}
+
+int semanage_bool_clone(semanage_bool_t boolean, semanage_bool_t* bool_ptr) {
+	return sepol_bool_clone(boolean, bool_ptr);
+}
+
+void semanage_bool_free(semanage_bool_t boolean) {
+	sepol_bool_free(boolean);
+}
diff -Naru libsemanage/src/context_record.c libsemanage.new/src/context_record.c
--- libsemanage/src/context_record.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/context_record.c	2005-09-21 20:53:27.000000000 -0400
@@ -0,0 +1,61 @@
+#include <sepol/context_record.h>
+
+typedef sepol_context_t semanage_context_t;
+
+/* User */
+const char* semanage_context_get_user(semanage_context_t con) {
+	return sepol_context_get_user(con);
+}
+
+int semanage_context_set_user(semanage_context_t con, const char* user) {
+	return sepol_context_set_user(con, user);
+}
+
+/* Role */
+const char* semanage_context_get_role(semanage_context_t con) {
+	return sepol_context_get_role(con);
+}
+
+int semanage_context_set_role(semanage_context_t con, const char* role) {
+	return sepol_context_set_role(con, role);
+}
+
+/* Type */
+const char* semanage_context_get_type(semanage_context_t con) {
+	return sepol_context_get_type(con);
+}
+
+int semanage_context_set_type(semanage_context_t con, const char* type) {
+	return sepol_context_set_type(con, type);
+}
+
+/* MLS */
+const char* semanage_context_get_mls(semanage_context_t con) {
+	return sepol_context_get_mls(con);
+}
+
+int semanage_context_set_mls(semanage_context_t con, const char* mls_range) {
+	return sepol_context_set_mls(con, mls_range);
+}
+
+/* Create/Clone/Destroy */
+int semanage_context_create(semanage_context_t* con_ptr) {
+	return sepol_context_create(con_ptr);
+}
+
+int semanage_context_clone(semanage_context_t con, semanage_context_t* con_ptr) {
+	return sepol_context_clone(con, con_ptr);
+}
+
+void semanage_context_free(semanage_context_t con) {
+	sepol_context_free(con);
+}
+	
+/* Parse to/from string */
+int semanage_context_from_string(const char* str, semanage_context_t* con) {
+	return sepol_context_from_string(str, con);
+}
+
+char* semanage_context_to_string(semanage_context_t con) {
+	return sepol_context_to_string(con);
+}
diff -Naru libsemanage/src/database_file.c libsemanage.new/src/database_file.c
--- libsemanage/src/database_file.c	2005-09-21 10:42:25.000000000 -0400
+++ libsemanage.new/src/database_file.c	2005-09-22 01:10:19.000000000 -0400
@@ -1,41 +1,150 @@
 #include <stdlib.h>
 #include <stddef.h>
+#include <stdio.h>
+#include <stdio_ext.h>
+#include <errno.h>
 #include "debug.h"
 #include "database.h"
 #include "record_file.h"
-#include "record_file_handlers.h"
 #include "users_file.h"
 #include "ports_file.h"
 
+/* Representation of the database once loaded in memory */
+typedef struct cache_entry {
+	record_t data;
+	struct cache_entry* prev;
+	struct cache_entry* next;
+} cache_entry_t;
+
+/* Database-specific configuration */
 struct dbase_config {
+
+	/* What's the format of this database */
 	record_table_t* rtable;
+
+	/* Where is it stored */
+	const char* filename;
+
+	/* Once parsed, it is cached here */
+	cache_entry_t* cache;
+	size_t cache_sz;
 };
 
-dbase_config_t* dbase[DBASE_COUNT];
+static int dbase_cache_add(
+	dbase_config_t* dconfig,
+	record_t data) {
 
-int dbase_init() {
-	int i;
-	for (i = 0; i < DBASE_COUNT; i++) {
-		dbase[i] = (dbase_config_t*) malloc(sizeof(dbase_config_t));
-		if (dbase[i] == NULL) 
-			goto err;
+	cache_entry_t* entry = 
+		(cache_entry_t*) malloc(sizeof (cache_entry_t));
+	if (entry == NULL)
+		goto omem;
+	entry->data = data;
+	entry->prev = NULL;
+	entry->next = dconfig->cache;
+	if (dconfig->cache != NULL)
+		dconfig->cache->prev = entry;
+	dconfig->cache = entry;
+	dconfig->cache_sz++;
+
+	return STATUS_SUCCESS;
+	omem:
+	/* FIXME: handle error condition */
+	return STATUS_ERR;
+}
+
+static int dbase_open_file(parse_info_t* info) {
+
+	info->file_stream = fopen(info->filename, "r");
+	if (!info->file_stream && (errno != ENOENT)) {
+		/* FIXME: handle error condition */
+		return STATUS_ERR;
 	}
+	if (info->file_stream)
+		__fsetlocking(info->file_stream, FSETLOCKING_BYCALLER);
+
+        return STATUS_SUCCESS;
+}
+
+static void dbase_close_file(parse_info_t* info) {
+	if (info->file_stream && (fclose(info->file_stream) < 0))
+		/* FIXME: handle error condition */
+	info->file_stream = NULL;
+}
 
-	dbase[DBASE_USERS]->rtable = &RTABLE_USER;
-	dbase[DBASE_PORTS]->rtable = &RTABLE_PORT; 	
+static int dbase_cache_fill(
+	dbase_config_t* dconfig) {
+
+	/* Already cached */
+	if (dconfig->cache != NULL)
+		return STATUS_SUCCESS;
+
+	int perr_fatal = 0;
+	/* FIXME: pass from caller? */
+
+	record_t process_record = NULL;
+	int pstatus = STATUS_SUCCESS;
+	parse_info_t parse_info;
+	parse_info.filename = dconfig->filename;
+	parse_info.parse_arg = NULL;
+	/* FIXME: pass from caller? */
+
+	if (dbase_open_file(&parse_info) < 0)
+		goto err;
+
+	/* Main processing loop */
+	do {
+		/* Create record */
+		if (dconfig->rtable->create(&process_record) < 0)
+			goto err;
+
+		/* Parse record */
+		pstatus = dconfig->rtable->parse(&parse_info, process_record);
+
+		/* Parse error is fatal, exit */
+		if (perr_fatal && (pstatus < 0))
+			goto err;
 
+		/* Parse error is not fatal */
+		else if (pstatus < 0)
+			continue;
+
+		/* Add record to list */
+		if (dbase_cache_add(dconfig, process_record) < 0)
+			goto err;
+
+        } while (pstatus != STATUS_NODATA);
+
+	dbase_close_file(&parse_info);
 	return STATUS_SUCCESS;
-	
+
 	err:
-	for (i--; i >= 0; i--) 
-		free(dbase[i]);
+	/* FIXME: handle failure */
+	dconfig->rtable->free(process_record);
+	dbase_close_file(&parse_info);
 	return STATUS_ERR;
-}	
+}
+
+static int dbase_cache_locate(
+	dbase_config_t* dconfig,
+	record_key_t key, 
+	cache_entry_t** entry) {
+	
+	cache_entry_t* ptr;
+
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
 
-void dbase_close() {
-	int i;
-	for (i = 0; i < DBASE_COUNT; i++)
-		free(dbase[i]);
+	for (ptr = dconfig->cache; ptr != NULL; ptr = ptr->next) { 
+		if (! dconfig->rtable->compare(ptr->data, key)) {
+			*entry = ptr;	
+			return STATUS_SUCCESS;
+		}
+	}
+
+	return STATUS_NODATA;	
+	err:
+	/* FIXME: handle error condition */
+	return STATUS_ERR;
 }
 
 int dbase_add(
@@ -43,25 +152,27 @@
 	record_key_t key,
 	record_t data) {
 
-	iterate_config_t config;
-	record_add_arg_t handler_arg;
+	int exists;
+
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
 
-	handler_arg.rtable = dconfig->rtable;
-	handler_arg.key = key;
-	handler_arg.data = data;
-	/* handler_arg.derr_fatal =  */
-
-	config.rtable = dconfig->rtable;
-	/* config.filename = */
-	/* config.parse_arg = */
-	/* config.perr_fatal = */
-	config.modify = 1;
-	config.handler = record_add;
-	config.handler_arg = &handler_arg;
-	/* config.merr_fatal = */
+	if (dbase_exists(dconfig, key, &exists) < 0)
+		goto err;
+
+	else if (exists) { 
+		/* FIXME: handle error condition */
+		goto err;
+	}
+
+	if (dbase_cache_add(dconfig, data) < 0)
+		goto err;
 
-	/* Stub */
 	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error condition */
+	return STATUS_ERR;
 }
 
 int dbase_modify(
@@ -69,48 +180,60 @@
 	record_key_t key,
 	record_t data) {
 
-	iterate_config_t config;
-	record_modify_arg_t handler_arg;
+	cache_entry_t* entry;
+	int status;
+
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
 
-	handler_arg.rtable = dconfig->rtable;
-	handler_arg.key = key;
-	handler_arg.data = data;
-	/* handler_arg.merr_fatal = */
-	
-	config.rtable = dconfig->rtable;
-	/* config.filename = */
-	/* config.parse_arg = */
-	/* config.perr_fatal = */
-	config.modify = 1;
-	config.handler = record_modify;
-	config.handler_arg = &handler_arg;
-	/* config.merr_fatal = */
+	status = dbase_cache_locate(dconfig, key, &entry);
+	if (status < 0)
+		goto err;
+	if (status == STATUS_NODATA)
+		return dbase_add(dconfig,key,data);
+	else
+		entry->data = data;
 
-	/* Stub */
 	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error condition */
+	return STATUS_ERR;
+
 }
 
 int dbase_del(
 	dbase_config_t* dconfig,
 	record_key_t key) {
 
-	iterate_config_t config;
-	record_del_arg_t handler_arg;
+	cache_entry_t* entry;
+	int status;
 
-	handler_arg.rtable = dconfig->rtable;
-	handler_arg.key = key;
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
 
-	config.rtable = dconfig->rtable;
-	/* config.filename = */
-	/* config.parse_arg = */
-	/* config.perr_fatal = */
-	config.modify = 1;
-	config.handler = record_del;
-	config.handler_arg = &handler_arg;
-	/* config.merr_fatal = */
+	status = dbase_cache_locate(dconfig, key, &entry);
+	if (status < 0)
+		goto err;
+	
+	else if (status != STATUS_NODATA) {
+		if (entry->next != NULL)
+			entry->next->prev = entry->prev;
+
+		if (entry->prev != NULL)
+			entry->prev->next = entry->next;
+		else
+			dconfig->cache = entry->next;
+
+		dconfig->rtable->free(entry->data);
+		dconfig->cache_sz--;
+		free(entry);
+	}
 
-	/* Stub */
 	return STATUS_SUCCESS;
+	err:
+	/* FIXME: Handle error condition */
+	return STATUS_ERR;
 }
 
 int dbase_query(
@@ -118,24 +241,23 @@
 	record_key_t key,
 	record_t* response) {
 
-	iterate_config_t config;
-	record_query_arg_t handler_arg;
+	cache_entry_t* entry;
+	int status;
+
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
 
-	handler_arg.rtable = dconfig->rtable;
-	handler_arg.key = key;
-	handler_arg.response = response;
-
-	config.rtable = dconfig->rtable;
-	/* config.filename = */
-	/* config.parse_arg = */
-	/* config.perr_fatal = */
-	config.modify = 0;
-	config.handler = record_query;
-	config.handler_arg = &handler_arg;
-	/* config.merr_fatal = */	
+	status = dbase_cache_locate(dconfig, key, &entry);
+	if (status < 0 || status == STATUS_NODATA)
+		goto err;
+
+	if (dconfig->rtable->clone(entry->data, *response) < 0)
+		goto err;
 
-	/* Stub */
 	return STATUS_SUCCESS;
+	err:
+	/* FIXME: Handle error condition */
+	return STATUS_ERR;
 }
 
 int dbase_exists(
@@ -143,95 +265,103 @@
 	record_key_t key,
 	int* response) {
 
-	iterate_config_t config;
-	record_exists_arg_t handler_arg;
+	cache_entry_t* entry;
+	int status;
 
-	handler_arg.rtable = dconfig->rtable;
-	handler_arg.key = key;
-	handler_arg.response = response;
-
-	config.rtable = dconfig->rtable;
-	/* config.filename = */
-	/* config.parse_arg = */
-	/* config.perr_fatal = */
-	config.modify = 0;
-	config.handler = record_exists;
-	config.handler_arg = &handler_arg;
-	/* config.merr_fatal = */	
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
 
-	/* Stub */
+	status = dbase_cache_locate(dconfig, key, &entry);
+	if (status < 0)
+		goto err;
+
+	*response = (status != STATUS_NODATA);
 	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error condition */
+	return STATUS_ERR;
 }
 
 int dbase_count(
 	dbase_config_t* dconfig,
 	int* response) {
-	
-	iterate_config_t config;
-	record_count_arg_t handler_arg;
 
-	handler_arg.rtable = dconfig->rtable;
-	handler_arg.response = response;
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
 
-	config.rtable = dconfig->rtable;
-	/* config.filename = */
-	/* config.parse_arg = */
-	/* config.perr_fatal = */
-	config.modify = 0;
-	config.handler = record_count;
-	config.handler_arg = &handler_arg;
-	/* config.merr_fatal = */
-
-	/* Stub */
+	*response = dconfig->cache_sz;
 	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: Handle error condition */
+	return STATUS_ERR;
 }
 
 int dbase_iterate(
 	dbase_config_t* dconfig,
-	int (*fn) (record_key_t key,
-	           record_t record,
-	           void* varg),
+	int (*fn) (record_t record, void* varg),
 	void* fn_arg) {
 
-	iterate_config_t config;
-	record_iterate_arg_t handler_arg;
+	int status;	
+	cache_entry_t* ptr;
+	
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
 
-	handler_arg.rtable = dconfig->rtable;
-	handler_arg.fn = fn;
-	handler_arg.fn_arg = fn_arg;
-
-	config.rtable = dconfig->rtable;
-	/* config.filename = */
-	/* config.parse_arg = */
-	/* config.perr_fatal = */
-	config.modify = 0;
-	config.handler = record_iterate;
-	config.handler_arg = &handler_arg;
-	/* config.merr_fatal = */
+	for (ptr = dconfig->cache; ptr != NULL; ptr = ptr->next) {
+		status = fn(ptr->data, fn_arg);
+		if (status < 0)
+			goto err;
 
-	/* Stub */
+		else if (status > 0)
+			break;
+	}
+	
 	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: Handle error condition */
+	return STATUS_ERR;
 }
 
 int dbase_list(
 	dbase_config_t* dconfig,
-	record_key_t** keyset,
-	record_t** dataset,	
+	record_t** records,	
 	size_t* count) {
 
-	iterate_config_t config;
-	config.rtable = dconfig->rtable;
-	/* config.filename = */
-	/* config.parse_arg = */
-	/* config.perr_fatal = */
-	config.modify = 0;
-	/* config.handler = */
-	/* config.handler_arg = */
-	/* config.merr_fatal = */
-
-	/* Stub */
-	keyset = NULL;
-	dataset = NULL;
-	count = NULL;
-	return STATUS_SUCCESS;
+	cache_entry_t* ptr;
+	record_t* tmp_records = NULL;
+	size_t tmp_count;
+	int i = 0;
+	
+	if (dbase_cache_fill(dconfig) < 0)
+		goto err;
+
+	tmp_count = dconfig->cache_sz;
+
+	if (tmp_count > 0) {
+		tmp_records = (record_t*) calloc(tmp_count, sizeof (record_t));
+		if (tmp_records == NULL) 
+			goto omem;			
+	
+		for (ptr = dconfig->cache; ptr != NULL; ptr = ptr->next) 
+			if (dconfig->rtable->clone(ptr->data, &tmp_records[i++]) < 0)
+				goto err;
+
+	}
+	*records = tmp_records;
+	*count = tmp_count;
+
+	return STATUS_SUCCESS;	
+
+	omem:
+	/* FIXME: handle error condition */
+
+	err:
+	for (; i >= 0; i--) 
+		free(tmp_records[i]);
+	free(tmp_records);
+	/* FIXME: handle error condition */
+	return STATUS_ERR;
 }
diff -Naru libsemanage/src/database.h libsemanage.new/src/database.h
--- libsemanage/src/database.h	2005-09-21 10:42:25.000000000 -0400
+++ libsemanage.new/src/database.h	2005-09-21 18:31:37.000000000 -0400
@@ -12,11 +12,6 @@
 struct dbase_config;
 typedef struct dbase_config dbase_config_t;
 
-#define DBASE_COUNT 2
-#define DBASE_USERS 0
-#define DBASE_PORTS 1
-extern dbase_config_t* dbase[DBASE_COUNT];
-
 extern int dbase_add(
 	dbase_config_t* dconfig,
 	record_key_t key,
@@ -47,15 +42,13 @@
 
 extern int dbase_iterate(
 	dbase_config_t* dconfig,
-	int (*fn) (record_key_t key,
-	           record_t record,
+	int (*fn) (record_t record,
 	           void* varg),
 	void* fn_arg);
 
 extern int dbase_list(
 	dbase_config_t* dconfig,
-	record_key_t** keyset,
-	record_t** dataset,	
+	record_t** records,	
 	size_t* count);
 
 #endif 
diff -Naru libsemanage/src/iface_record.c libsemanage.new/src/iface_record.c
--- libsemanage/src/iface_record.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/iface_record.c	2005-09-21 20:57:09.000000000 -0400
@@ -0,0 +1,65 @@
+#include <sepol/iface_record.h>
+
+typedef sepol_context_t semanage_context_t;
+typedef sepol_iface_t semanage_iface_t;
+typedef sepol_iface_key_t semanage_iface_key_t;
+
+/* Key */
+int semanage_iface_compare(semanage_iface_t iface, semanage_iface_key_t key) {
+	return sepol_iface_compare(iface, key);
+}
+
+int semanage_iface_key_create(
+	const char* name,
+	semanage_iface_key_t* key_ptr) {
+	return sepol_iface_key_create(name, key_ptr);
+}
+
+int semanage_iface_key_extract(
+	semanage_iface_t iface,
+	semanage_iface_key_t* key_ptr) {
+	return sepol_iface_key_extract(iface, key_ptr);
+}
+
+void semanage_iface_key_free(semanage_iface_key_t key) {
+	sepol_iface_key_free(key);
+}
+
+/* Name */
+const char* semanage_iface_get_name(semanage_iface_t iface) {
+        return sepol_iface_get_name(iface);
+}
+
+int semanage_iface_set_name(semanage_iface_t iface, const char* name) {
+        return sepol_iface_set_name(iface, name);
+}
+	
+/* Context */
+semanage_context_t semanage_iface_get_ifcon(semanage_iface_t iface) {
+	return sepol_iface_get_ifcon(iface);
+}
+
+int semanage_iface_set_ifcon(semanage_iface_t iface, semanage_context_t con) {
+	return sepol_iface_set_ifcon(iface, con);
+}
+
+semanage_context_t semanage_iface_get_msgcon(semanage_iface_t iface) {
+	return sepol_iface_get_msgcon(iface);	
+}
+
+int semanage_iface_set_msgcon(semanage_iface_t iface, semanage_context_t con) {
+	return sepol_iface_set_msgcon(iface, con);
+}
+
+/* Create/Clone/Destroy */
+int semanage_iface_create(semanage_iface_t* iface_ptr) {
+	return sepol_iface_create(iface_ptr);
+}
+
+int semanage_iface_clone(semanage_iface_t iface, semanage_iface_t* iface_ptr) {
+	return sepol_iface_clone(iface, iface_ptr);
+}
+
+void semanage_iface_free(semanage_iface_t iface) {
+	sepol_iface_free(iface);
+}
diff -Naru libsemanage/src/port_record.c libsemanage.new/src/port_record.c
--- libsemanage/src/port_record.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/port_record.c	2005-09-21 20:57:27.000000000 -0400
@@ -0,0 +1,78 @@
+#include <sepol/port_record.h>
+
+typedef sepol_context_t semanage_context_t;
+typedef sepol_port_t semanage_port_t;
+typedef sepol_port_key_t semanage_port_key_t;
+
+/* Key */
+int semanage_port_compare(semanage_port_t port, semanage_port_key_t key) {
+	return sepol_port_compare(port, key);
+}
+
+int semanage_port_key_create(
+	int low, int high, int proto, 
+	semanage_port_key_t* key_ptr) {
+	return sepol_port_key_create(low, high, proto, key_ptr);
+}
+
+int semanage_port_key_extract(
+	semanage_port_t port,
+	semanage_port_key_t* key_ptr) {
+	return sepol_port_key_extract(port, key_ptr);
+}
+
+void semanage_port_key_free(semanage_port_key_t key) {
+	sepol_port_key_free(key);
+}	
+
+/* Protocol */
+int semanage_port_get_proto(semanage_port_t port) {
+	return sepol_port_get_proto(port);
+}
+
+int semanage_port_set_proto(semanage_port_t port, int proto) {
+	return sepol_port_set_proto(port, proto);
+}
+
+const char* semanage_port_get_proto_str(semanage_port_t port) {
+	return sepol_port_get_proto_str(port);
+}
+
+/* Port */
+int semanage_port_get_low(semanage_port_t port) {
+	return sepol_port_get_low(port);
+}
+
+int semanage_port_get_high(semanage_port_t port) {
+	return sepol_port_get_high(port);
+}
+
+int semanage_port_set_port(semanage_port_t port, int port_num) {
+	return sepol_port_set_port(port, port_num);
+}
+
+int semanage_port_set_range(semanage_port_t port, int low, int high) {
+	return sepol_port_set_range(port, low, high);
+}
+
+/* Context */
+semanage_context_t semanage_port_get_con(semanage_port_t port) {
+	return sepol_port_get_con(port);	
+}
+
+int semanage_port_set_con(semanage_port_t port, semanage_context_t con) {
+	return sepol_port_set_con(port, con);
+}
+
+/* Create/Clone/Destroy */
+int semanage_port_create(semanage_port_t* port_ptr) {
+	return sepol_port_create(port_ptr);
+}
+
+int semanage_port_clone(semanage_port_t port, semanage_port_t* port_ptr) {
+	return sepol_port_clone(port, port_ptr);
+}
+
+void semanage_port_free(semanage_port_t port) {
+	sepol_port_free(port);
+}
diff -Naru libsemanage/src/ports.c libsemanage.new/src/ports.c
--- libsemanage/src/ports.c	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage.new/src/ports.c	2005-09-21 19:17:03.000000000 -0400
@@ -1,4 +1,5 @@
 #include <stddef.h>
+#include <stdlib.h>
 #include <semanage/port_record.h>
 #include <semanage/ports.h>
 
@@ -11,55 +12,53 @@
 	semanage_port_key_t key,
 	semanage_port_t data) {
 	
-	return dbase_add(dbase[DBASE_PORTS], key, data);
+	return dbase_add(NULL /* FIXME */, key, data);
 }
 
 int semanage_port_modify(
 	semanage_port_key_t key,
 	semanage_port_t data) {
 	
-	return dbase_modify(dbase[DBASE_PORTS], key, data);
+	return dbase_modify(NULL /* FIXME */, key, data);
 }
 
 int semanage_port_del(
 	semanage_port_key_t key) {
 
-	return dbase_del(dbase[DBASE_PORTS], key);
+	return dbase_del(NULL /* FIXME */, key);
 }
 
 int semanage_port_query(
 	semanage_port_key_t key,
 	semanage_port_t* response) {
 
-	return dbase_query(dbase[DBASE_PORTS], key, response);
+	return dbase_query(NULL /* FIXME */, key, response);
 }
 
 int semanage_port_exists(
 	semanage_port_key_t key,
 	int* response) {
 
-	return dbase_exists(dbase[DBASE_PORTS], key, response);
+	return dbase_exists(NULL /* FIXME */, key, response);
 }
 
 int semanage_port_count(
 	int* response) {
 
-	return dbase_count(dbase[DBASE_PORTS], response);
+	return dbase_count(NULL /*FIXME */, response);
 }
 
 int semanage_port_iterate(
-	int (*handler) (semanage_port_key_t key,
-	                semanage_port_t record,
+	int (*handler) (semanage_port_t record,
 	                void* varg),
 	void* handler_arg) {
 
-	return dbase_iterate(dbase[DBASE_PORTS], handler, handler_arg);
+	return dbase_iterate(NULL /* FIXME */, handler, handler_arg);
 }
 
 int semanage_port_list(
-	semanage_port_key_t** keyset,
-	semanage_port_t** dataset,
+	semanage_port_t** records,
 	size_t* count) {
 
-	return dbase_list(dbase[DBASE_PORTS], keyset, dataset, count);
+	return dbase_list(NULL /* FIXME */, records, count);
 }
diff -Naru libsemanage/src/record_file.c libsemanage.new/src/record_file.c
--- libsemanage/src/record_file.c	2005-09-21 10:42:25.000000000 -0400
+++ libsemanage.new/src/record_file.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,9 +0,0 @@
-#include "debug.h"
-#include "record_file.h"
-
-int record_iterate_file(iterate_config_t* config) {
-
-	/* Stub */
-	config = NULL;
-	return STATUS_SUCCESS;
-}
diff -Naru libsemanage/src/record_file.h libsemanage.new/src/record_file.h
--- libsemanage/src/record_file.h	2005-09-19 15:30:24.000000000 -0400
+++ libsemanage.new/src/record_file.h	2005-09-22 00:44:49.000000000 -0400
@@ -9,17 +9,17 @@
 #define RECORD_DEFINED
 #endif
 
-/* Signals available to handlers during processing. */
-#define RECORD_HANDLER_SIGOK    0x00000001 /* Continue */
-#define RECORD_HANDLER_SIGERR   0x00000002 /* Exit with error */
-#define RECORD_HANDLER_SIGMATCH 0x00000004 /* Match is found */
-#define RECORD_HANDLER_SIGDEL   0x00000008 /* Delete current record */
-#define RECORD_HANDLER_SIGADD   0x00000010 /* Add feedback record */
-#define RECORD_HANDLER_SIGEXIT  0x00000020 /* Exit successfully */
-
 /* Structure available during parsing (created internally) */
 typedef struct parse_info {
-	/* Stub */	
+	/* Parser controlled */
+	/* Stub */
+
+	/* Engine-controlled */
+	const char* filename;   /* Input stream file name */
+	FILE* file_stream;      /* Input stream handle */
+
+	/* Caller supplied */
+	void* parse_arg;
 } parse_info_t;
 
 /* Record table format - necessary during processing */
@@ -41,7 +41,9 @@
 	/* Deep-copy clone of this record */
 	int (*clone) (record_t rec, record_t* new_rec);
 
-	/* Fill record structuure based on supplied parse info */
+	/* Fill record structuure based on supplied parse info.
+	 * Parser must return STATUS_NODATA when EOF is encountered.
+	 * Parser must handle NULL file stream correctly */
 	int (*parse) (parse_info_t* info, record_t record);
 
 	/* Print record to stream */
@@ -52,33 +54,4 @@
 	void (*free) (record_t rec);
 } record_table_t;
 
-/* Structure to configure iterate */
-typedef struct iterate_config {
-
-	/* What and How? */
-	const char* filename;            /* Filename to process */
-	record_table_t* rtable;		 /* Table that describes how to do that */
-
-	/* Parsing stage */
-	void* parse_arg;                 /* Argument to pass to parser */
-	int perr_fatal;                  /* Is parse error fatal ? */
-
-	/* Processing stage */
-	int (*handler) (                  /* Processing handler */
-		record_t process_record,      /* Current record, or NULL */
-		record_t* feedback_record,    /* Record for SIGADD */
-		void* arg);                   /* Caller supplied argument */
-	void* handler_arg;                /* Argument to pass to handler */
-	int modify;                       /* Will the handler issue 
-					   * modification signals */
-	/* Post-processing */
-	int merr_fatal;                   /* Is lack of SIGMATCH fatal? */
-} iterate_config_t;
-
-/*
- * Iterate over all records in the given file,
- * subject to the provided parse and processing config.
- */
-extern int record_iterate_file(iterate_config_t* config);
-
 #endif 
diff -Naru libsemanage/src/record_file_handlers.c libsemanage.new/src/record_file_handlers.c
--- libsemanage/src/record_file_handlers.c	2005-09-21 10:42:25.000000000 -0400
+++ libsemanage.new/src/record_file_handlers.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,72 +0,0 @@
-#include "debug.h"
-#include "record_file.h"
-#include "record_file_handlers.h"
-
-#ifndef RECORD_DEFINED
-typedef void* record_t;
-typedef void* record_key_t;
-#define RECORD_DEFINED
-#endif
-
-int record_query(record_t process_rec, record_t* unused, void* varg) {
-
-	/* Stub */
-	process_rec = NULL;
-	unused = NULL;
-	varg = NULL;
-	return RECORD_HANDLER_SIGEXIT;
-}
-
-int record_exists(record_t process_rec, record_t* unused, void* varg) {
-
-	/* Stub */
-	process_rec = NULL;
-	unused = NULL;
-	varg = NULL;
-	return RECORD_HANDLER_SIGEXIT;
-}
-
-int record_add(record_t process_rec, record_t* new_rec, void* varg) {
-	
-	/* Stub */
-	process_rec = NULL;
-	new_rec = NULL;
-	varg = NULL;
-	return RECORD_HANDLER_SIGEXIT;
-}
-
-int record_modify (record_t process_rec, record_t* new_rec, void* varg) {
-
-	/* Stub */
-	process_rec = NULL;
-	new_rec = NULL;
-	varg = NULL;
-	return RECORD_HANDLER_SIGEXIT;
-}
-
-int record_del(record_t process_rec, record_t* unused, void* varg) {
-
-	/* Stub */
-	process_rec = NULL;
-	unused = NULL;
-	varg = NULL;
-	return RECORD_HANDLER_SIGEXIT;
-}
-
-int record_count(record_t process_rec, record_t* unused, void* varg) {
-
-	/* Stub */
-	process_rec = NULL;
-	unused = NULL;
-	varg = NULL;
-	return RECORD_HANDLER_SIGEXIT;
-}
-
-int record_iterate(record_t process_rec, record_t* unused, void* varg) {
-
-	/* Stub */
-	process_rec = NULL;
-	unused = NULL;
-	varg = NULL;
-	return RECORD_HANDLER_SIGEXIT;
-}
diff -Naru libsemanage/src/record_file_handlers.h libsemanage.new/src/record_file_handlers.h
--- libsemanage/src/record_file_handlers.h	2005-09-21 10:42:25.000000000 -0400
+++ libsemanage.new/src/record_file_handlers.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,62 +0,0 @@
-#ifndef _SEMANAGE_RECORD_FILE_HANDLERS_H_
-#define _SEMANAGE_RECORD_FILE_HANDLERS_H_
-
-#include "record_file.h"
-
-#ifndef RECORD_DEFINED
-typedef void* record_t;
-typedef void* record_key_t;
-#define RECORD_DEFINED
-#endif
-
-typedef struct record_query_arg {
-	record_table_t* rtable;
-	record_key_t key;
-	record_t* response;
-} record_query_arg_t;
-
-typedef struct record_del_arg {
-	record_table_t* rtable;
-	record_key_t key;
-} record_del_arg_t;
-
-typedef struct record_exists_arg {
-	record_table_t* rtable;
-	record_key_t key;
-	int* response;
-} record_exists_arg_t;
-
-typedef struct record_add_arg {
-	record_table_t* rtable;
-	record_key_t key;
-	record_t data;
-	int derr_fatal;
-} record_add_arg_t;
-
-typedef struct record_modify_arg {
-	record_table_t* rtable;
-	record_key_t key;
-	record_t data;
-	int merr_fatal;
-} record_modify_arg_t;
-
-typedef struct record_count_arg {
-	record_table_t* rtable;
-	int* response;
-} record_count_arg_t;
-
-typedef struct record_iterate_arg {
-	record_table_t* rtable;
-	int (*fn) (record_key_t key, record_t rec, void* varg);
-	void* fn_arg;
-} record_iterate_arg_t;
-
-extern int record_query(record_t rec, record_t* unused, void* varg);
-extern int record_exists(record_t rec, record_t* unused, void* varg);
-extern int record_add(record_t rec, record_t* new_rec, void* varg);
-extern int record_modify (record_t rec, record_t* new_rec, void* varg);
-extern int record_del(record_t rec, record_t* unused, void* varg);
-extern int record_count(record_t rec, record_t* unused, void* varg);
-extern int record_iterate(record_t rec, record_t* unused, void* varg);
-
-#endif
diff -Naru libsemanage/src/user_record.c libsemanage.new/src/user_record.c
--- libsemanage/src/user_record.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/user_record.c	2005-09-21 20:54:36.000000000 -0400
@@ -0,0 +1,99 @@
+#include <sepol/user_record.h>
+
+typedef sepol_user_t semanage_user_t;
+typedef sepol_user_key_t semanage_user_key_t;
+
+/* Key */
+int semanage_user_key_create(const char* name, semanage_user_key_t* key) {
+	return sepol_user_key_create(name, key);
+}
+
+int semanage_user_key_extract(semanage_user_t user, semanage_user_key_t* key) {
+	return sepol_user_key_extract(user, key);
+}
+
+void semanage_user_key_free(semanage_user_key_t key) {
+	sepol_user_key_free(key);
+}
+
+int semanage_user_compare(semanage_user_t user, semanage_user_key_t key) {
+	return sepol_user_compare(user, key);
+}
+	
+/* Name */
+const char* semanage_user_get_name(semanage_user_t user) {
+	return sepol_user_get_name(user);
+}
+
+int semanage_user_set_name(semanage_user_t user, const char* name) {
+	return sepol_user_set_name(user, name);
+}
+
+/* MLS */
+const char* semanage_user_get_mlslevel(semanage_user_t user) {
+	return sepol_user_get_mlslevel(user);
+}
+
+int semanage_user_set_mlslevel(semanage_user_t user, const char* mls_level) {
+	return sepol_user_set_mlslevel(user, mls_level);
+}
+
+const char* semanage_user_get_mlsrange(semanage_user_t user) {
+	return sepol_user_get_mlsrange(user);
+}
+
+int semanage_user_set_mlsrange(semanage_user_t user, const char* mls_range) {
+	return sepol_user_set_mlsrange(user, mls_range);
+}
+
+/* Role management */
+int semanage_user_get_num_roles(semanage_user_t user) {
+	return sepol_user_get_num_roles(user);
+}
+
+const char* semanage_user_get_defrole(semanage_user_t user) {
+	return sepol_user_get_defrole(user);
+}
+
+int semanage_user_add_role(semanage_user_t user, const char* role) {
+	return sepol_user_add_role(user, role);
+}
+
+int semanage_user_del_role(semanage_user_t user, const char* role) {
+	return sepol_user_del_role(user, role);
+}
+
+int semanage_user_has_role(semanage_user_t user, const char* role) {
+	return sepol_user_has_role(user, role);
+}
+
+int semanage_user_set_defrole(semanage_user_t user, const char* role) {
+	return sepol_user_set_defrole(user, role);
+}
+
+int semanage_user_get_roles(
+	semanage_user_t user,
+	const char*** roles_arr, 
+	size_t* num_roles) {
+	return sepol_user_get_roles(user, roles_arr, num_roles);
+}
+
+int semanage_user_set_roles(
+	semanage_user_t user,
+	const char** roles_arr,
+	size_t num_roles) {
+	return sepol_user_set_roles(user, roles_arr, num_roles);
+}
+
+/* Create/Clone/Destroy */
+int semanage_user_create(semanage_user_t* user_ptr) {
+	return sepol_user_create(user_ptr);
+}
+
+int semanage_user_clone(semanage_user_t user, semanage_user_t* user_ptr) {
+	return sepol_user_clone(user, user_ptr);
+}
+
+void semanage_user_free(semanage_user_t user) {
+	sepol_user_free(user);
+}
diff -Naru libsemanage/src/users.c libsemanage.new/src/users.c
--- libsemanage/src/users.c	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage.new/src/users.c	2005-09-21 18:43:24.000000000 -0400
@@ -1,4 +1,5 @@
 #include <stddef.h>
+#include <stdlib.h>
 #include <semanage/user_record.h>
 #include <semanage/users.h>
 
@@ -11,55 +12,53 @@
 	semanage_user_key_t key,
 	semanage_user_t data) {
 	
-	return dbase_add(dbase[DBASE_USERS], key, data);
+	return dbase_add(NULL /*FIXME */, key, data);
 }
 
 int semanage_user_modify(
 	semanage_user_key_t key,
 	semanage_user_t data) {
 	
-	return dbase_modify(dbase[DBASE_USERS], key, data);
+	return dbase_modify(NULL /* FIXME */, key, data);
 }
 
 int semanage_user_del(
 	semanage_user_key_t key) {
 
-	return dbase_del(dbase[DBASE_USERS], key);
+	return dbase_del(NULL /* FIXME */, key);
 }
 
 int semanage_user_query(
 	semanage_user_key_t key,
 	semanage_user_t* response) {
 
-	return dbase_query(dbase[DBASE_USERS], key, response);
+	return dbase_query(NULL /* FIXME */, key, response);
 }
 
 int semanage_user_exists(
 	semanage_user_key_t key,
 	int* response) {
 
-	return dbase_exists(dbase[DBASE_USERS], key, response);
+	return dbase_exists(NULL /* FIXME */, key, response);
 }
 
 int semanage_user_count(
 	int* response) {
 
-	return dbase_count(dbase[DBASE_USERS], response);
+	return dbase_count(NULL /* FIXME */, response);
 }
 
 int semanage_user_iterate(
-	int (*handler) (semanage_user_key_t key,
-	                semanage_user_t record,
+	int (*handler) (semanage_user_t record,
 	                void* varg),
 	void* handler_arg) {
 
-	return dbase_iterate(dbase[DBASE_USERS], handler, handler_arg);
+	return dbase_iterate(NULL /* FIXME */, handler, handler_arg);
 }
 
 int semanage_user_list(
-	semanage_user_key_t** keyset,
-	semanage_user_t** dataset,
+	semanage_user_t** records,
 	size_t* count) {
 
-	return dbase_list(dbase[DBASE_USERS], keyset, dataset, count);
+	return dbase_list(NULL /* FIXME */, records, count);
 }

--------------040700020407080901060906--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
