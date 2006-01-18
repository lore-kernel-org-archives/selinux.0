Message-ID: <43CE2D21.4050409@cornell.edu>
Date: Wed, 18 Jan 2006 04:57:21 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Fix up hidden definitions again...
Content-Type: multipart/mixed;
 boundary="------------020404020604000403090508"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020404020604000403090508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------020404020604000403090508
Content-Type: text/x-patch;
 name="libsemanage.hidden_update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.hidden_update.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/boolean_record.c new/libsemanage/src/boolean_record.c
--- old/libsemanage/src/boolean_record.c	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/boolean_record.c	2006-01-18 04:55:56.000000000 -0700
@@ -60,7 +60,7 @@ int semanage_bool_compare2(
 }
 hidden_def(semanage_bool_compare2)
 
-int semanage_bool_compare2_qsort(
+static int semanage_bool_compare2_qsort(
 	const semanage_bool_t** boolean,
 	const semanage_bool_t** boolean2) {
 
diff -Naurp --exclude-from excludes old/libsemanage/src/port_internal.h new/libsemanage/src/port_internal.h
--- old/libsemanage/src/port_internal.h	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/port_internal.h	2006-01-18 04:50:46.000000000 -0700
@@ -24,6 +24,7 @@ hidden_proto(semanage_port_set_proto)
 hidden_proto(semanage_port_get_proto_str)
 hidden_proto(semanage_port_get_con)
 hidden_proto(semanage_port_set_con)
+hidden_proto(semanage_port_list_local)
 
 /* PORT RECORD: method table */
 extern record_table_t SEMANAGE_PORT_RTABLE;
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_local.c new/libsemanage/src/ports_local.c
--- old/libsemanage/src/ports_local.c	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/ports_local.c	2006-01-18 04:51:03.000000000 -0700
@@ -74,6 +74,7 @@ int semanage_port_list_local(
 	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
 	return dbase_list(handle, dconfig, records, count);
 }
+hidden_def(semanage_port_list_local)
 
 int hidden semanage_port_validate_local(
 	semanage_handle_t* handle) {

--------------020404020604000403090508--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
