Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8U2n2Ns023534
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 22:49:02 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8U2hCS2015600
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 02:43:12 GMT
Message-ID: <433CA85F.7010102@cornell.edu>
Date: Thu, 29 Sep 2005 22:52:15 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: dwalsh@redhat.com
Subject: Re: [ 2/9 ] [ SEMANAGE ] Restore sepol compatibility
References: <433CA7CA.6000207@cornell.edu>
In-Reply-To: <433CA7CA.6000207@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------040700070706010403040601"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040700070706010403040601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch restores compatibility with sepol broken in the 
previous patch. It also adds stddef.h in a few places. The idea here is 
to keep things from breaking, not to replace typedefs in this library 
(this is a later patch).

--------------040700070706010403040601
Content-Type: text/x-patch;
 name="libsemanage.01.sepol_compat.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.01.sepol_compat.diff"

diff -Naur libsemanage/include/semanage/user_record.h libsemanage.new/include/semanage/user_record.h
--- libsemanage/include/semanage/user_record.h	2005-09-23 10:37:40.000000000 -0400
+++ libsemanage.new/include/semanage/user_record.h	2005-09-27 23:49:10.000000000 -0400
@@ -1,6 +1,8 @@
 #ifndef _SEMANAGE_USER_RECORD_H_
 #define _SEMANAGE_USER_RECORD_H_
 
+#include <stddef.h>
+
 struct semanage_user;
 struct semanage_user_key;
 typedef struct semanage_user* semanage_user_t;
diff -Naur libsemanage/src/boolean_record.c libsemanage.new/src/boolean_record.c
--- libsemanage/src/boolean_record.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage.new/src/boolean_record.c	2005-09-29 16:48:45.000000000 -0400
@@ -1,7 +1,7 @@
 #include <sepol/boolean_record.h>
 
-typedef sepol_bool_t semanage_bool_t;
-typedef sepol_bool_key_t semanage_bool_key_t;
+typedef sepol_bool_t* semanage_bool_t;
+typedef sepol_bool_key_t* semanage_bool_key_t;
 
 /* Key */
 int semanage_bool_key_create(const char* name, semanage_bool_key_t* key) {
diff -Naur libsemanage/src/context_record.c libsemanage.new/src/context_record.c
--- libsemanage/src/context_record.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage.new/src/context_record.c	2005-09-29 16:49:13.000000000 -0400
@@ -1,6 +1,6 @@
 #include <sepol/context_record.h>
 
-typedef sepol_context_t semanage_context_t;
+typedef sepol_context_t* semanage_context_t;
 
 /* User */
 const char* semanage_context_get_user(semanage_context_t con) {
diff -Naur libsemanage/src/iface_record.c libsemanage.new/src/iface_record.c
--- libsemanage/src/iface_record.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage.new/src/iface_record.c	2005-09-29 16:48:32.000000000 -0400
@@ -1,8 +1,8 @@
 #include <sepol/iface_record.h>
 
-typedef sepol_context_t semanage_context_t;
-typedef sepol_iface_t semanage_iface_t;
-typedef sepol_iface_key_t semanage_iface_key_t;
+typedef sepol_context_t* semanage_context_t;
+typedef sepol_iface_t* semanage_iface_t;
+typedef sepol_iface_key_t* semanage_iface_key_t;
 
 /* Key */
 int semanage_iface_compare(semanage_iface_t iface, semanage_iface_key_t key) {
diff -Naur libsemanage/src/port_record.c libsemanage.new/src/port_record.c
--- libsemanage/src/port_record.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage.new/src/port_record.c	2005-09-29 16:49:05.000000000 -0400
@@ -1,8 +1,8 @@
 #include <sepol/port_record.h>
 
-typedef sepol_context_t semanage_context_t;
-typedef sepol_port_t semanage_port_t;
-typedef sepol_port_key_t semanage_port_key_t;
+typedef sepol_context_t* semanage_context_t;
+typedef sepol_port_t* semanage_port_t;
+typedef sepol_port_key_t* semanage_port_key_t;
 
 /* Key */
 int semanage_port_compare(semanage_port_t port, semanage_port_key_t key) {
diff -Naur libsemanage/src/user_record.c libsemanage.new/src/user_record.c
--- libsemanage/src/user_record.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage.new/src/user_record.c	2005-09-29 16:48:56.000000000 -0400
@@ -1,7 +1,8 @@
+#include <stddef.h>
 #include <sepol/user_record.h>
 
-typedef sepol_user_t semanage_user_t;
-typedef sepol_user_key_t semanage_user_key_t;
+typedef sepol_user_t* semanage_user_t;
+typedef sepol_user_key_t* semanage_user_key_t;
 
 /* Key */
 int semanage_user_key_create(const char* name, semanage_user_key_t* key) {

--------------040700070706010403040601--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
