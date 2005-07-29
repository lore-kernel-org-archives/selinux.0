Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6TJb9gA003422
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 15:37:09 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6TJUHhF018738
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 19:30:17 GMT
Subject: [ libsemanage ] Relay libsepol records
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: jbrindle@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1122658154.28860.19.camel@celtics.boston.redhat.com>
References: <1122658154.28860.19.camel@celtics.boston.redhat.com>
Content-Type: multipart/mixed; boundary="=-kVQHL407yai6K5F+69BQ"
Date: Fri, 29 Jul 2005 15:28:23 -0400
Message-Id: <1122665303.28860.30.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-kVQHL407yai6K5F+69BQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch relays records in libsemange to
the ones in libsepol - depends on previous patch for libsepol.

Records being added will be used in the future.


--=-kVQHL407yai6K5F+69BQ
Content-Disposition: attachment; filename=libsemanage-relay_records.diff
Content-Type: text/x-patch; name=libsemanage-relay_records.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -p -aru libsemanage.work/include/semanage/context_record.h libsemanage-relay_records/include/semanage/context_record.h
--- libsemanage.work/include/semanage/context_record.h	2005-07-29 15:21:53.000000000 -0400
+++ libsemanage-relay_records/include/semanage/context_record.h	2005-07-29 15:24:46.000000000 -0400
@@ -0,0 +1,78 @@
+#ifndef _SEMANAGE_CONTEXT_RECORD_H_
+#define _SEMANAGE_CONTEXT_RECORD_H_ 
+
+/* Implementation via sepol */
+#include <sepol/context_record.h>
+typedef sepol_context_t semanage_context_t;
+
+/* User */
+static inline 
+const char* semanage_context_get_user(semanage_context_t con) {
+	return sepol_context_get_user(con);
+}
+
+static inline
+int semanage_context_set_user(semanage_context_t con, const char* user) {
+	return sepol_context_set_user(con, user);
+}
+
+/* Role */
+static inline
+const char* semanage_context_get_role(semanage_context_t con) {
+	return sepol_context_get_role(con);
+}
+
+static inline
+int semanage_context_set_role(semanage_context_t con, const char* role) {
+	return sepol_context_set_role(con, role);
+}
+
+/* Type */
+static inline
+const char* semanage_context_get_type(semanage_context_t con) {
+	return sepol_context_get_type(con);
+}
+
+static inline 
+int semanage_context_set_type(semanage_context_t con, const char* type) {
+	return sepol_context_set_type(con, type);
+}
+
+/* MLS */
+static inline 
+const char* semanage_context_get_mls(semanage_context_t con) {
+	return sepol_context_get_mls(con);
+}
+
+static inline
+int semanage_context_set_mls(semanage_context_t con, const char* mls_range) {
+	return sepol_context_set_mls(con, mls_range);
+}
+
+/* Create/Clone/Destroy */
+static inline
+int semanage_context_create(semanage_context_t* con_ptr) {
+	return sepol_context_create(con_ptr);
+}
+
+static inline
+int semanage_context_clone(semanage_context_t con, semanage_context_t* con_ptr) {
+	return sepol_context_clone(con, con_ptr);
+}
+
+static inline
+void semanage_context_free(semanage_context_t con) {
+	sepol_context_free(con);
+}
+	
+/* Parse to/from string */
+static inline
+int semanage_context_from_string(const char* str, semanage_context_t* con) {
+	return sepol_context_from_string(str, con);
+}
+
+static inline 
+char* semanage_context_to_string(semanage_context_t con) {
+	return sepol_context_to_string(con);
+}
+#endif 
diff -p -aru libsemanage.work/include/semanage/port_record.h libsemanage-relay_records/include/semanage/port_record.h
--- libsemanage.work/include/semanage/port_record.h	2005-07-29 15:21:55.000000000 -0400
+++ libsemanage-relay_records/include/semanage/port_record.h	2005-07-29 15:24:46.000000000 -0400
@@ -0,0 +1,95 @@
+#ifndef _SEMANAGE_PORT_RECORD_H_
+#define _SEMANAGE_PORT_RECORD_H_ 
+
+#include <semanage/context_record.h>
+
+/* Implentation via sepol */
+#include <sepol/port_record.h>
+typedef sepol_port_t semanage_port_t;
+typedef sepol_port_key_t semanage_port_key_t;
+
+#define SEMANAGE_PROTO_UDP SEPOL_PROTO_UDP
+#define SEMANAGE_PROTO_TCP SEPOL_PROTO_TCP
+
+/* Key */
+static inline
+int semanage_port_compare(semanage_port_t port, semanage_port_key_t key) {
+	return sepol_port_compare(port, key);
+}
+
+static inline
+int semanage_port_key_create(
+	int low, int high, int proto, 
+	semanage_port_key_t* key) {
+	return sepol_port_key_create(low, high, proto, key);
+}
+
+static inline
+void semanage_port_key_free(semanage_port_key_t key) {
+	sepol_port_key_free(key);
+}	
+
+/* Protocol */
+static inline
+int semanage_port_get_proto(semanage_port_t port) {
+	return sepol_port_get_proto(port);
+}
+
+static inline
+int semanage_port_set_proto(semanage_port_t port, int proto) {
+	return sepol_port_set_proto(port, proto);
+}
+
+static inline
+const char* semanage_port_get_proto_str(semanage_port_t port) {
+	return sepol_port_get_proto_str(port);
+}
+
+/* Port */
+static inline
+int semanage_port_get_low(semanage_port_t port) {
+	return sepol_port_get_low(port);
+}
+
+static inline
+int semanage_port_get_high(semanage_port_t port) {
+	return sepol_port_get_high(port);
+}
+
+static inline 
+int semanage_port_set_port(semanage_port_t port, int port_num) {
+	return sepol_port_set_port(port, port_num);
+}
+
+static inline
+int semanage_port_set_range(semanage_port_t port, int low, int high) {
+	return sepol_port_set_range(port, low, high);
+}
+
+/* Context */
+static inline
+semanage_context_t semanage_port_get_con(semanage_port_t port) {
+	return sepol_port_get_con(port);	
+}
+
+static inline
+int semanage_port_set_con(semanage_port_t port, semanage_context_t con) {
+	return sepol_port_set_con(port, con);
+}
+
+/* Create/Clone/Destroy */
+static inline
+int semanage_port_create(semanage_port_t* port_ptr) {
+	return sepol_port_create(port_ptr);
+}
+
+static inline
+int semanage_port_clone(semanage_port_t port, semanage_port_t* port_ptr) {
+	return sepol_port_clone(port, port_ptr);
+}
+
+static inline
+void semanage_port_free(semanage_port_t port) {
+	sepol_port_free(port);
+}
+#endif
diff -p -aru libsemanage.work/include/semanage/user_record.h libsemanage-relay_records/include/semanage/user_record.h
--- libsemanage.work/include/semanage/user_record.h	2005-07-29 15:21:58.000000000 -0400
+++ libsemanage-relay_records/include/semanage/user_record.h	2005-07-29 15:24:46.000000000 -0400
@@ -0,0 +1,119 @@
+#ifndef _SEMANAGE_USER_RECORD_H_
+#define _SEMANAGE_USER_RECORD_H_
+
+/* Implementation via sepol */
+#include <sepol/user_record.h>
+typedef sepol_user_t semanage_user_t;
+typedef sepol_user_key_t semanage_user_key_t;
+
+/* Key */
+static inline
+int semanage_user_key_create(const char* name, semanage_user_key_t* key) {
+	return sepol_user_key_create(name, key);
+}
+
+static inline 
+void semanage_user_key_free(semanage_user_key_t key) {
+	sepol_user_key_free(key);
+}
+
+static inline
+int semanage_user_compare(semanage_user_t user, semanage_user_key_t key) {
+	return sepol_user_compare(user, key);
+}
+	
+/* Name */
+static inline
+const char* semanage_user_get_name(semanage_user_t user) {
+	return sepol_user_get_name(user);
+}
+
+static inline
+int semanage_user_set_name(semanage_user_t user, const char* name) {
+	return sepol_user_set_name(user, name);
+}
+
+/* MLS */
+static inline
+const char* semanage_user_get_mlslevel(semanage_user_t user) {
+	return sepol_user_get_mlslevel(user);
+}
+
+static inline
+int semanage_user_set_mlslevel(semanage_user_t user, const char* mls_level) {
+	return sepol_user_set_mlslevel(user, mls_level);
+}
+
+static inline
+const char* semanage_user_get_mlsrange(semanage_user_t user) {
+	return sepol_user_get_mlsrange(user);
+}
+
+static inline
+int semanage_user_set_mlsrange(semanage_user_t user, const char* mls_range) {
+	return sepol_user_set_mlsrange(user, mls_range);
+}
+
+/* Role management */
+static inline
+int semanage_user_get_num_roles(semanage_user_t user) {
+	return sepol_user_get_num_roles(user);
+}
+
+static inline
+const char* semanage_user_get_defrole(semanage_user_t user) {
+	return sepol_user_get_defrole(user);
+}
+
+static inline
+int semanage_user_add_role(semanage_user_t user, const char* role) {
+	return sepol_user_add_role(user, role);
+}
+
+static inline
+int semanage_user_del_role(semanage_user_t user, const char* role) {
+	return sepol_user_del_role(user, role);
+}
+
+static inline
+int semanage_user_has_role(semanage_user_t user, const char* role) {
+	return sepol_user_has_role(user, role);
+}
+
+static inline
+int semanage_user_set_defrole(semanage_user_t user, const char* role) {
+	return sepol_user_set_defrole(user, role);
+}
+
+static inline 
+int semanage_user_get_roles(
+	semanage_user_t user,
+	const char*** roles_arr, 
+	size_t* num_roles) {
+	return sepol_user_get_roles(user, roles_arr, num_roles);
+}
+
+static inline
+int semanage_user_set_roles(
+	semanage_user_t user,
+	const char** roles_arr,
+	size_t num_roles) {
+	return sepol_user_set_roles(user, roles_arr, num_roles);
+}
+
+/* Create/Clone/Destroy */
+static inline
+int semanage_user_create(semanage_user_t* user_ptr) {
+	return sepol_user_create(user_ptr);
+}
+
+static inline
+int semanage_user_clone(semanage_user_t user, semanage_user_t* user_ptr) {
+	return sepol_user_clone(user, user_ptr);
+}
+
+static inline
+void semanage_user_free(semanage_user_t user) {
+	sepol_user_free(user);
+}
+#endif

--=-kVQHL407yai6K5F+69BQ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
