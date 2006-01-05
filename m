Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k05D6jXf016215
	for <selinux@tycho.nsa.gov>; Thu, 5 Jan 2006 08:06:45 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k05D5hYO001422
	for <selinux@tycho.nsa.gov>; Thu, 5 Jan 2006 13:05:43 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k05D5rs2009976
	for <selinux@tycho.nsa.gov>; Thu, 5 Jan 2006 08:05:53 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k05D5r8X009975
	for selinux@tycho.nsa.gov; Thu, 5 Jan 2006 08:05:53 -0500
Message-ID: <43BC7060.2040504@cornell.edu>
Date: Wed, 04 Jan 2006 20:03:28 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Manpages for dbase functions
Content-Type: multipart/mixed;
 boundary="------------050005090504090405060004"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050005090504090405060004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add manpages for all add/modify/del/exists/query/count/list/iterate 
functions.
Adds a copy for each type, and then links all the other ones to them.

Next time: records...


--------------050005090504090405060004
Content-Type: text/x-patch;
 name="libsemanage.dbase_man.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.dbase_man.diff"

diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/Makefile new/libsemanage/Makefile
--- old/libsemanage/Makefile	2005-11-15 08:06:18.000000000 -0500
+++ new/libsemanage/Makefile	2006-01-04 18:01:20.000000000 -0500
@@ -4,6 +4,7 @@ all: 
 install: 
 	$(MAKE) -C include install
 	$(MAKE) -C src install
+	$(MAKE) -C man install
 
 relabel:
 
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/Makefile new/libsemanage/man/Makefile
--- old/libsemanage/man/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/Makefile	2006-01-03 17:08:44.000000000 -0500
@@ -0,0 +1,7 @@
+# Installation directories.
+MAN3DIR ?= $(DESTDIR)/usr/share/man/man3
+
+install:
+	mkdir -p $(MAN3DIR)
+	install -m 644 man3/*.3 $(MAN3DIR)
+
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_add_local.3 new/libsemanage/man/man3/semanage_bool_add_local.3
--- old/libsemanage/man/man3/semanage_bool_add_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_add_local.3	2006-01-04 10:40:22.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_add_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_count.3 new/libsemanage/man/man3/semanage_bool_count.3
--- old/libsemanage/man/man3/semanage_bool_count.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_count.3	2006-01-04 19:29:19.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_count_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_count_active.3 new/libsemanage/man/man3/semanage_bool_count_active.3
--- old/libsemanage/man/man3/semanage_bool_count_active.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_count_active.3	2006-01-04 19:29:25.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_count_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_count_local.3 new/libsemanage/man/man3/semanage_bool_count_local.3
--- old/libsemanage/man/man3/semanage_bool_count_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_count_local.3	2006-01-04 19:29:21.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_count_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_exists.3 new/libsemanage/man/man3/semanage_bool_exists.3
--- old/libsemanage/man/man3/semanage_bool_exists.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_exists.3	2006-01-04 18:30:24.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_exists_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_exists_active.3 new/libsemanage/man/man3/semanage_bool_exists_active.3
--- old/libsemanage/man/man3/semanage_bool_exists_active.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_exists_active.3	2006-01-04 18:30:29.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_exists_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_exists_local.3 new/libsemanage/man/man3/semanage_bool_exists_local.3
--- old/libsemanage/man/man3/semanage_bool_exists_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_exists_local.3	2006-01-04 18:30:26.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_exists_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_iterate.3 new/libsemanage/man/man3/semanage_bool_iterate.3
--- old/libsemanage/man/man3/semanage_bool_iterate.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_iterate.3	2006-01-04 18:55:03.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_iterate_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_iterate_active.3 new/libsemanage/man/man3/semanage_bool_iterate_active.3
--- old/libsemanage/man/man3/semanage_bool_iterate_active.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_iterate_active.3	2006-01-04 18:55:07.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_iterate_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_iterate_local.3 new/libsemanage/man/man3/semanage_bool_iterate_local.3
--- old/libsemanage/man/man3/semanage_bool_iterate_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_iterate_local.3	2006-01-04 18:55:05.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_iterate_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_list.3 new/libsemanage/man/man3/semanage_bool_list.3
--- old/libsemanage/man/man3/semanage_bool_list.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_list.3	2006-01-04 19:08:47.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_list_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_list_active.3 new/libsemanage/man/man3/semanage_bool_list_active.3
--- old/libsemanage/man/man3/semanage_bool_list_active.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_list_active.3	2006-01-04 19:08:50.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_list_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_list_local.3 new/libsemanage/man/man3/semanage_bool_list_local.3
--- old/libsemanage/man/man3/semanage_bool_list_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_list_local.3	2006-01-04 19:08:48.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_list_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_modify_local.3 new/libsemanage/man/man3/semanage_bool_modify_local.3
--- old/libsemanage/man/man3/semanage_bool_modify_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_modify_local.3	2006-01-04 10:42:08.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_modify_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_query.3 new/libsemanage/man/man3/semanage_bool_query.3
--- old/libsemanage/man/man3/semanage_bool_query.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_query.3	2006-01-04 18:24:14.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_query_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_query_active.3 new/libsemanage/man/man3/semanage_bool_query_active.3
--- old/libsemanage/man/man3/semanage_bool_query_active.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_query_active.3	2006-01-04 18:24:11.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_query_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_query_local.3 new/libsemanage/man/man3/semanage_bool_query_local.3
--- old/libsemanage/man/man3/semanage_bool_query_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_query_local.3	2006-01-04 18:24:09.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_query_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_set_active.3 new/libsemanage/man/man3/semanage_bool_set_active.3
--- old/libsemanage/man/man3/semanage_bool_set_active.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_set_active.3	2006-01-04 10:42:38.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_set_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_bool_set_local.3 new/libsemanage/man/man3/semanage_bool_set_local.3
--- old/libsemanage/man/man3/semanage_bool_set_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_bool_set_local.3	2006-01-04 10:42:52.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_set_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_add_local.3 new/libsemanage/man/man3/semanage_fcontext_add_local.3
--- old/libsemanage/man/man3/semanage_fcontext_add_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_fcontext_add_local.3	2006-01-04 10:41:22.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_add_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_count.3 new/libsemanage/man/man3/semanage_fcontext_count.3
--- old/libsemanage/man/man3/semanage_fcontext_count.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_fcontext_count.3	2006-01-04 19:29:43.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_count_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_count_local.3 new/libsemanage/man/man3/semanage_fcontext_count_local.3
--- old/libsemanage/man/man3/semanage_fcontext_count_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_fcontext_count_local.3	2006-01-04 19:29:44.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_count_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_exists.3 new/libsemanage/man/man3/semanage_fcontext_exists.3
--- old/libsemanage/man/man3/semanage_fcontext_exists.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_fcontext_exists.3	2006-01-04 18:30:45.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_exists_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_exists_local.3 new/libsemanage/man/man3/semanage_fcontext_exists_local.3
--- old/libsemanage/man/man3/semanage_fcontext_exists_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_fcontext_exists_local.3	2006-01-04 18:30:48.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_exists_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_iterate.3 new/libsemanage/man/man3/semanage_fcontext_iterate.3
--- old/libsemanage/man/man3/semanage_fcontext_iterate.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_fcontext_iterate.3	2006-01-04 18:55:25.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_iterate_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_iterate_local.3 new/libsemanage/man/man3/semanage_fcontext_iterate_local.3
--- old/libsemanage/man/man3/semanage_fcontext_iterate_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_fcontext_iterate_local.3	2006-01-04 18:55:27.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_iterate_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_list.3 new/libsemanage/man/man3/semanage_fcontext_list.3
--- old/libsemanage/man/man3/semanage_fcontext_list.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_fcontext_list.3	2006-01-04 19:09:06.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_list_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_list_local.3 new/libsemanage/man/man3/semanage_fcontext_list_local.3
--- old/libsemanage/man/man3/semanage_fcontext_list_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_fcontext_list_local.3	2006-01-04 19:09:09.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_list_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_modify_local.3 new/libsemanage/man/man3/semanage_fcontext_modify_local.3
--- old/libsemanage/man/man3/semanage_fcontext_modify_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_fcontext_modify_local.3	2006-01-04 10:41:41.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_modify_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_query.3 new/libsemanage/man/man3/semanage_fcontext_query.3
--- old/libsemanage/man/man3/semanage_fcontext_query.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_fcontext_query.3	2006-01-04 18:24:43.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_query_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_query_local.3 new/libsemanage/man/man3/semanage_fcontext_query_local.3
--- old/libsemanage/man/man3/semanage_fcontext_query_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_fcontext_query_local.3	2006-01-04 18:24:41.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_query_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_fcontext_set_local.3 new/libsemanage/man/man3/semanage_fcontext_set_local.3
--- old/libsemanage/man/man3/semanage_fcontext_set_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_fcontext_set_local.3	2006-01-04 10:43:01.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_set_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_iface_add_local.3 new/libsemanage/man/man3/semanage_iface_add_local.3
--- old/libsemanage/man/man3/semanage_iface_add_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_iface_add_local.3	2006-01-04 10:40:42.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_add_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_iface_count.3 new/libsemanage/man/man3/semanage_iface_count.3
--- old/libsemanage/man/man3/semanage_iface_count.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_iface_count.3	2006-01-04 19:29:30.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_count_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_iface_count_local.3 new/libsemanage/man/man3/semanage_iface_count_local.3
--- old/libsemanage/man/man3/semanage_iface_count_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_iface_count_local.3	2006-01-04 19:29:32.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_count_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_iface_exists.3 new/libsemanage/man/man3/semanage_iface_exists.3
--- old/libsemanage/man/man3/semanage_iface_exists.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_iface_exists.3	2006-01-04 18:30:41.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_exists_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_iface_exists_local.3 new/libsemanage/man/man3/semanage_iface_exists_local.3
--- old/libsemanage/man/man3/semanage_iface_exists_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_iface_exists_local.3	2006-01-04 18:30:37.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_exists_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_iface_iterate.3 new/libsemanage/man/man3/semanage_iface_iterate.3
--- old/libsemanage/man/man3/semanage_iface_iterate.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_iface_iterate.3	2006-01-04 18:55:11.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_iterate_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_iface_iterate_local.3 new/libsemanage/man/man3/semanage_iface_iterate_local.3
--- old/libsemanage/man/man3/semanage_iface_iterate_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_iface_iterate_local.3	2006-01-04 18:55:13.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_iterate_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_iface_list.3 new/libsemanage/man/man3/semanage_iface_list.3
--- old/libsemanage/man/man3/semanage_iface_list.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_iface_list.3	2006-01-04 19:08:54.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_list_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_iface_list_local.3 new/libsemanage/man/man3/semanage_iface_list_local.3
--- old/libsemanage/man/man3/semanage_iface_list_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_iface_list_local.3	2006-01-04 19:08:56.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_list_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_iface_modify_local.3 new/libsemanage/man/man3/semanage_iface_modify_local.3
--- old/libsemanage/man/man3/semanage_iface_modify_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_iface_modify_local.3	2006-01-04 10:41:58.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_modify_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_iface_query.3 new/libsemanage/man/man3/semanage_iface_query.3
--- old/libsemanage/man/man3/semanage_iface_query.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_iface_query.3	2006-01-04 18:24:24.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_query_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_iface_query_local.3 new/libsemanage/man/man3/semanage_iface_query_local.3
--- old/libsemanage/man/man3/semanage_iface_query_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_iface_query_local.3	2006-01-04 18:24:26.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_query_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_iface_set_local.3 new/libsemanage/man/man3/semanage_iface_set_local.3
--- old/libsemanage/man/man3/semanage_iface_set_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_iface_set_local.3	2006-01-04 10:42:58.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_set_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_port_add_local.3 new/libsemanage/man/man3/semanage_port_add_local.3
--- old/libsemanage/man/man3/semanage_port_add_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_port_add_local.3	2006-01-04 10:40:35.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_add_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_port_count.3 new/libsemanage/man/man3/semanage_port_count.3
--- old/libsemanage/man/man3/semanage_port_count.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_port_count.3	2006-01-04 19:29:37.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_count_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_port_count_local.3 new/libsemanage/man/man3/semanage_port_count_local.3
--- old/libsemanage/man/man3/semanage_port_count_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_port_count_local.3	2006-01-04 19:29:39.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_count_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_port_exists.3 new/libsemanage/man/man3/semanage_port_exists.3
--- old/libsemanage/man/man3/semanage_port_exists.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_port_exists.3	2006-01-04 18:30:33.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_exists_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_port_exists_local.3 new/libsemanage/man/man3/semanage_port_exists_local.3
--- old/libsemanage/man/man3/semanage_port_exists_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_port_exists_local.3	2006-01-04 18:30:35.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_exists_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_port_iterate.3 new/libsemanage/man/man3/semanage_port_iterate.3
--- old/libsemanage/man/man3/semanage_port_iterate.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_port_iterate.3	2006-01-04 18:55:16.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_iterate_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_port_iterate_local.3 new/libsemanage/man/man3/semanage_port_iterate_local.3
--- old/libsemanage/man/man3/semanage_port_iterate_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_port_iterate_local.3	2006-01-04 18:55:22.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_iterate_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_port_list.3 new/libsemanage/man/man3/semanage_port_list.3
--- old/libsemanage/man/man3/semanage_port_list.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_port_list.3	2006-01-04 19:09:00.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_list_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_port_list_local.3 new/libsemanage/man/man3/semanage_port_list_local.3
--- old/libsemanage/man/man3/semanage_port_list_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_port_list_local.3	2006-01-04 19:09:02.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_list_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_port_modify_local.3 new/libsemanage/man/man3/semanage_port_modify_local.3
--- old/libsemanage/man/man3/semanage_port_modify_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_port_modify_local.3	2006-01-04 10:41:50.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_modify_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_port_query.3 new/libsemanage/man/man3/semanage_port_query.3
--- old/libsemanage/man/man3/semanage_port_query.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_port_query.3	2006-01-04 18:24:22.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_query_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_port_query_local.3 new/libsemanage/man/man3/semanage_port_query_local.3
--- old/libsemanage/man/man3/semanage_port_query_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_port_query_local.3	2006-01-04 18:24:18.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_query_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_port_set_local.3 new/libsemanage/man/man3/semanage_port_set_local.3
--- old/libsemanage/man/man3/semanage_port_set_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_port_set_local.3	2006-01-04 10:42:55.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_set_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_add.3 new/libsemanage/man/man3/semanage_seuser_add.3
--- old/libsemanage/man/man3/semanage_seuser_add.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_seuser_add.3	2006-01-04 10:41:04.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_add_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_count.3 new/libsemanage/man/man3/semanage_seuser_count.3
--- old/libsemanage/man/man3/semanage_seuser_count.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_seuser_count.3	2006-01-04 19:29:50.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_count_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_exists.3 new/libsemanage/man/man3/semanage_seuser_exists.3
--- old/libsemanage/man/man3/semanage_seuser_exists.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_seuser_exists.3	2006-01-04 18:30:54.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_exists_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_iterate.3 new/libsemanage/man/man3/semanage_seuser_iterate.3
--- old/libsemanage/man/man3/semanage_seuser_iterate.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_seuser_iterate.3	2006-01-04 18:55:35.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_iterate_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_list.3 new/libsemanage/man/man3/semanage_seuser_list.3
--- old/libsemanage/man/man3/semanage_seuser_list.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_seuser_list.3	2006-01-04 19:09:26.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_list_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_modify.3 new/libsemanage/man/man3/semanage_seuser_modify.3
--- old/libsemanage/man/man3/semanage_seuser_modify.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_seuser_modify.3	2006-01-04 10:42:28.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_modify_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_query.3 new/libsemanage/man/man3/semanage_seuser_query.3
--- old/libsemanage/man/man3/semanage_seuser_query.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_seuser_query.3	2006-01-04 18:24:34.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_query_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_seuser_set.3 new/libsemanage/man/man3/semanage_seuser_set.3
--- old/libsemanage/man/man3/semanage_seuser_set.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_seuser_set.3	2006-01-04 18:23:52.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_set_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_user_add_local.3 new/libsemanage/man/man3/semanage_user_add_local.3
--- old/libsemanage/man/man3/semanage_user_add_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_add_local.3	2006-01-04 19:48:34.000000000 -0500
@@ -0,0 +1,81 @@
+.TH semanage_user_add_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.SH "NAME"
+.B semanage_user_add_local \- 
+add a new user to the local store
+.br
+.B semanage_bool_add_local \- 
+add a new boolean to the local store
+.br
+.B semanage_port_add_local \-
+add a new port range to the local store 
+.br
+.B semanage_iface_add_local \- 
+add a new network interface to the local store
+.br
+.B semanage_fcontext_add_local \- 
+add a new context specification to the local store
+.br
+.B semanage_seuser_add \- 
+add a new seuser (login mapping)
+
+.SH "SYNOPSIS"
+.B #include <semanage/users_local.h> 
+.br
+.B #include <semanage/booleans_local.h>
+.br
+.B #include <semanage/ports_local.h>
+.br
+.B #include <semanage/interfaces_local.h>
+.br
+.B #include <semanage/fcontexts_local.h>
+.br
+.B #include <semanage/seusers.h>
+.sp
+
+.B FUNCTION: 
+see above
+.br
+.B OBJECT: 
+user, port, fcontext, iface, seuser
+.sp
+.sp
+.B extern int FUNCTION (
+.br
+.BI "	semanage_handle_t *" handle ","
+.br
+.BI "	semanage_OBJECT_key_t *" key ","
+.br
+.BI "	semanage_OBJECT_t *" data ");"
+
+.SH "DESCRIPTION"
+.TP
+.SS Add Group:
+The group of add functions are one of three ways to modify policy objects (the other two being the set group, and the modify group). The three groups differ in whether they allow new or existing objects with respect to the local store. Behavior with respect to policy is the same - the object will be added if new, or changed if it exists (except for booleans, which do not allow new additions). Add functions will not allow updates to existing objects in the local store - they can only add new objects.
+.TP
+.SS Behavior:
+The add functions will fail if a matching key is found in the local store. Otherwise, the object provided will be added to the local store, and then loaded into policy. Changes will become permanent when 
+.B semanage_commit 
+is invoked. Validity of the object being added is checked at commit time. 
+.TP
+.SS Parameters:
+The 
+.I handle
+is used to track persistent state across semanage calls, and for error reporting. The
+.I key 
+identifies the 
+.I data
+object, which will be written into the store. The key are data are properties of the caller, and are not stored or modified internally.
+.TP
+.SS Requirements:
+This function requires an semanage connection to be established (see 
+.B semanage_connect
+), and must be executed in a transaction (see 
+.B semanage_begin_transaction
+).
+
+.SH "RETURN VALUE"
+In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+Otherwise 0 is returned.
+
+.SH "SEE ALSO"
+.BR semanage_handle_create "(3), " semanage_begin_transaction "(3), " semanage_connect "(3), " semanage_commit "(3). "
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_user_count.3 new/libsemanage/man/man3/semanage_user_count.3
--- old/libsemanage/man/man3/semanage_user_count.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_count.3	2006-01-04 19:29:06.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_count_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_user_count_local.3 new/libsemanage/man/man3/semanage_user_count_local.3
--- old/libsemanage/man/man3/semanage_user_count_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_count_local.3	2006-01-04 19:28:47.000000000 -0500
@@ -0,0 +1,101 @@
+.TH semanage_user_count_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.SH "NAME"
+.B semanage_user_count \-
+return the number of users users in the persistent policy
+.br
+.B semanage_user_count_local \-
+return the number of users in the local store 
+.br
+.B semanage_bool_count \-
+return the number of booleans in the persistent policy
+.br
+.B semanage_bool_count_local \- 
+return the number of booleans in the local store
+.br
+.B semanage_bool_count_active \- 
+return the number of booleans in the currently active policy
+.br
+.B semanage_port_count \-
+return the number of port ranges in the persistent policy
+.br
+.B semanage_port_count_local \-
+return the number of port ranges in the local store
+.br
+.B semanage_iface_count \-
+return the number of network interfaces in the persistent policy
+.br
+.B semanage_iface_count_local \- 
+return the number of network interfaces in the local store
+.br
+.B semanage_fcontext_count \-
+return the number of context specifications in the persistent policy
+.br
+.B semanage_fcontext_count_local \- 
+return the number of context specifications in the local store
+.br
+.B semanage_seuser_count \- 
+return the number of seusers (login mappings)
+
+.SH "SYNOPSIS"
+.B #include <semanage/users_policy.h>
+.br
+.B #include <semanage/users_local.h> 
+.br
+.B #include <semanage/booleans_policy.h>
+.br
+.B #include <semanage/booleans_local.h>
+.br
+.B #include <semanage/booleans_active.h>
+.br
+.B #include <semanage/ports_policy.h>
+.br
+.B #include <semanage/ports_local.h>
+.br
+.B #include <semanage/interfaces_policy.h>
+.br
+.B #include <semanage/interfaces_local.h>
+.br
+.B #include <semanage/fcontexts_policy.h>
+.br
+.B #include <semanage/fcontexts_local.h>
+.br
+.B #include <semanage/seusers.h>
+.sp
+
+.B FUNCTION: 
+see above
+.br
+.B OBJECT: 
+user, port, fcontext, iface, seuser
+.sp
+.sp
+
+.B extern int FUNCTION (
+.br
+.BI "	semanage_handle_t *" handle ","
+.br
+.BI "	unsigned int* " response ");"
+
+.SH "DESCRIPTION"
+.TP
+.SS Behavior:
+The count functions will return the number of all objects in the selected location.
+
+.TP
+.SS Parameters:
+The 
+.I handle
+is used to track persistent state across semanage calls, and for error reporting. The number of objects will be stored at the location poined by 
+.I response.
+.TP
+.SS Requirements:
+This function requires an semanage connection to be established (see 
+.B semanage_connect
+)
+
+.SH "RETURN VALUE"
+In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+Otherwise a non-negative integer is returned (a commit number). The same number will be returned by all other semanage object read calls until the next commit.
+
+.SH "SEE ALSO"
+.BR semanage_handle_create "(3), " semanage_connect "(3), "
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_user_del_local.3 new/libsemanage/man/man3/semanage_user_del_local.3
--- old/libsemanage/man/man3/semanage_user_del_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_del_local.3	2006-01-04 19:48:42.000000000 -0500
@@ -0,0 +1,77 @@
+.TH semanage_user_del_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.SH "NAME"
+.B semanage_user_del_local \- 
+delete a user from the local store
+.br
+.B semanage_bool_del_local \- 
+delete a boolean from the local store
+.br
+.B semanage_port_del_local \- 
+delete a port range from the local store
+.br
+.B semanage_iface_del_local \- 
+delete a network interface from the local store
+.br
+.B semanage_fcontext_del_local \- 
+delete a context specification from the local store
+.br
+.B semanage_seuser_del \- 
+delete a seuser (login mapping)
+
+.SH "SYNOPSIS"
+.B #include <semanage/users_local.h> 
+.br
+.B #include <semanage/booleans_local.h>
+.br
+.B #include <semanage/ports_local.h>
+.br
+.B #include <semanage/interfaces_local.h>
+.br
+.B #include <semanage/fcontexts_local.h>
+.br
+.B #include <semanage/seusers.h>
+.sp
+
+.B FUNCTION: 
+see above
+.br
+.B OBJECT: 
+user, port, fcontext, iface, seuser
+.sp
+.sp
+
+.B extern int FUNCTION (
+.br
+.BI "	semanage_handle_t *" handle ","
+.br
+.BI "	semanage_OBJECT_key_t *" key ");"
+
+.SH "DESCRIPTION"
+.TP
+.SS Behavior:
+The delete functions will remove the object corresponding to the provided key from the local store. If no match is found, no action is taken. Changes will become permanent when  
+.B semanage_commit 
+is invoked. Additional checks may be performed at that time to ensure the system is left in a valid state. 
+.TP
+.SS Parameters:
+The 
+.I handle
+is used to track persistent state across semanage calls, and for error reporting. The
+.I key 
+identifies the 
+.I data
+object, which will be deleted from the local store. The key is a property of the caller, and will not be stored or modified internally.
+.TP
+.SS Requirements:
+This function requires an semanage connection to be established (see 
+.B semanage_connect
+), and must be executed in a transaction (see 
+.B semanage_begin_transaction
+).
+
+.SH "RETURN VALUE"
+In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+Otherwise 0 is returned.
+
+.SH "SEE ALSO"
+.BR semanage_handle_create "(3), " semanage_begin_transaction "(3), " semanage_connect "(3), " semanage_commit "(3). "
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_user_exists.3 new/libsemanage/man/man3/semanage_user_exists.3
--- old/libsemanage/man/man3/semanage_user_exists.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_exists.3	2006-01-04 18:30:17.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_exists_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_user_exists_local.3 new/libsemanage/man/man3/semanage_user_exists_local.3
--- old/libsemanage/man/man3/semanage_user_exists_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_exists_local.3	2006-01-04 18:40:42.000000000 -0500
@@ -0,0 +1,105 @@
+.TH semanage_user_exists_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.SH "NAME"
+.B semanage_user_exists \-
+check if a user exists in the persistent policy
+.br
+.B semanage_user_exists_local \- 
+check if a user exists in the local store
+.br
+.B semanage_bool_exists \-
+check if a boolean exists in the persistent policy
+.br
+.B semanage_bool_exists_local \- 
+check if a boolean exists in the local store 
+.br
+.B semanage_bool_exists_active \- 
+check if a boolean exists in the currently active policy
+.br
+.B semanage_port_exists \-
+check if a port range exists in the persistent policy
+.br
+.B semanage_port_exists_local \-
+check if a port range exists in the local store
+.br
+.B semanage_iface_exists \-
+check if a network interface exists in the persistent policy
+.br
+.B semanage_iface_exists_local \- 
+check if a network interface exists in the local store
+.br
+.B semanage_fcontext_exists \-
+check if a context specification exists in the persistent policy
+.br
+.B semanage_fcontext_exists_local \- 
+check if a context specification exists in the local store
+.br
+.B semanage_seuser_exists \- 
+check if a seuser exists (login mapping)
+
+.SH "SYNOPSIS"
+.B #include <semanage/users_policy.h>
+.br
+.B #include <semanage/users_local.h> 
+.br
+.B #include <semanage/booleans_policy.h>
+.br
+.B #include <semanage/booleans_local.h>
+.br
+.B #include <semanage/booleans_active.h>
+.br
+.B #include <semanage/ports_policy.h>
+.br
+.B #include <semanage/ports_local.h>
+.br
+.B #include <semanage/interfaces_policy.h>
+.br
+.B #include <semanage/interfaces_local.h>
+.br
+.B #include <semanage/fcontexts_policy.h>
+.br
+.B #include <semanage/fcontexts_local.h>
+.br
+.B #include <semanage/seusers.h>
+.sp
+
+.B FUNCTION: 
+see above
+.br
+.B OBJECT: 
+user, port, fcontext, iface, seuser
+.sp
+.sp
+
+.B extern int FUNCTION (
+.br
+.BI "	semanage_handle_t *" handle ","
+.br
+.BI "	semanage_OBJECT_key_t *" key ","
+.br
+.BI "	semanage_OBJECT_t **" response ");"
+
+.SH "DESCRIPTION"
+.TP
+.SS Behavior:
+The exists functions will return 0 if a matching key is not found, and 1 otherwise. 
+.TP
+.SS Parameters:
+The 
+.I handle
+is used to track persistent state across semanage calls, and for error reporting. The
+.I key 
+identifies the object being checked. The result of the test will be stored in the address pointed by 
+.I response
+The key is a property of the caller, and will not be stored or modified internally. 
+.TP
+.SS Requirements:
+This function requires an semanage connection to be established (see 
+.B semanage_connect
+)
+
+.SH "RETURN VALUE"
+In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+Otherwise a non-negative integer is returned (a commit number). The same number will be returned by all other read calls to the semanage database until the next commit.
+
+.SH "SEE ALSO"
+.BR semanage_handle_create "(3), " semanage_connect "(3), "
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_user_iterate.3 new/libsemanage/man/man3/semanage_user_iterate.3
--- old/libsemanage/man/man3/semanage_user_iterate.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_iterate.3	2006-01-04 18:54:54.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_iterate_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_user_iterate_local.3 new/libsemanage/man/man3/semanage_user_iterate_local.3
--- old/libsemanage/man/man3/semanage_user_iterate_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_iterate_local.3	2006-01-04 19:28:05.000000000 -0500
@@ -0,0 +1,116 @@
+.TH semanage_user_iterate_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.SH "NAME"
+.B semanage_user_iterate \-
+execute a callback for all users users in the persistent policy
+.br
+.B semanage_user_iterate_local \-
+execute a callback for all users in the local store 
+.br
+.B semanage_bool_iterate \-
+execute a callback for all booleans in the persistent policy
+.br
+.B semanage_bool_iterate_local \- 
+execute a callback for all booleans in the local store
+.br
+.B semanage_bool_iterate_active \- 
+execute a callback for all booleans in the currently active policy
+.br
+.B semanage_port_iterate \-
+execute a callback for all port ranges in the persistent policy
+.br
+.B semanage_port_iterate_local \-
+execute a callback for all port ranges in the local store
+.br
+.B semanage_iface_iterate \-
+execute a callback for all network interfaces in the persistent policy
+.br
+.B semanage_iface_iterate_local \- 
+execute a callback for all network interfaces in the local store
+.br
+.B semanage_fcontext_iterate \-
+execute a callback for all context specifications in the persistent policy
+.br
+.B semanage_fcontext_iterate_local \- 
+execute a callback for all context specifications in the local store
+.br
+.B semanage_seuser_iterate \- 
+execute a callback for all seusers (login mappings)
+
+.SH "SYNOPSIS"
+.B #include <semanage/users_policy.h>
+.br
+.B #include <semanage/users_local.h> 
+.br
+.B #include <semanage/booleans_policy.h>
+.br
+.B #include <semanage/booleans_local.h>
+.br
+.B #include <semanage/booleans_active.h>
+.br
+.B #include <semanage/ports_policy.h>
+.br
+.B #include <semanage/ports_local.h>
+.br
+.B #include <semanage/interfaces_policy.h>
+.br
+.B #include <semanage/interfaces_local.h>
+.br
+.B #include <semanage/fcontexts_policy.h>
+.br
+.B #include <semanage/fcontexts_local.h>
+.br
+.B #include <semanage/seusers.h>
+.sp
+
+.B FUNCTION: 
+see above
+.br
+.B OBJECT: 
+user, port, fcontext, iface, seuser
+.sp
+.sp
+
+.B extern int FUNCTION (
+.br
+.BI "	semanage_handle_t *" handle ","
+.br
+.BI "	int (*handler) (semanage_OBJECT_t *" object ","
+.br
+.BI "                   void *" varg "),"
+.br
+.BI "	void *" handler_arg ");"
+
+.SH "DESCRIPTION"
+.TP
+.SS Behavior:
+The iterate functions will execute the specified handler over all objects in the selected location. An arbitrary argument can be passed into the handler function along with each object. 
+
+The object passed in is property of the libsemanage library, and may not be modified or preserved - use 
+.B semanage_OBJECT_clone 
+if that is necessary.
+
+The handler code may not invoke any semanage write requests for the same object type (i.e. modifying the underlying store is not allowed). The iterate functions are reentrant only while inside a transaction (see
+.B semanage_begin_transaction
+). It is not safe to execute other semanage read or write requests within iterate if not inside a transaction. The handler may return -1 to signal error exit, 0 to signal continue, and 1 to signal successful exit early (the iterate function will stop accordingly). 
+
+.TP
+.SS Parameters:
+The 
+.I handle
+is used to track persistent state across semanage calls, and for error reporting. The
+.I handler
+is the function to execute, with 
+.I handler_arg
+as its second parameter, and each object as its first parameter.
+.TP
+.SS Requirements:
+This function requires an semanage connection to be established (see 
+.B semanage_connect
+)
+
+.SH "RETURN VALUE"
+In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+Otherwise a non-negative integer is returned (a commit number). The same number will be returned by all other semanage object read calls until the next commit.
+
+.SH "SEE ALSO"
+.BR semanage_handle_create "(3), " semanage_connect "(3), "
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_user_list.3 new/libsemanage/man/man3/semanage_user_list.3
--- old/libsemanage/man/man3/semanage_user_list.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_list.3	2006-01-04 19:08:41.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_list_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_user_list_local.3 new/libsemanage/man/man3/semanage_user_list_local.3
--- old/libsemanage/man/man3/semanage_user_list_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_list_local.3	2006-01-04 19:28:35.000000000 -0500
@@ -0,0 +1,107 @@
+.TH semanage_user_list_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.SH "NAME"
+.B semanage_user_list \-
+list all users users in the persistent policy
+.br
+.B semanage_user_list_local \-
+list all users in the local store 
+.br
+.B semanage_bool_list \-
+list all booleans in the persistent policy
+.br
+.B semanage_bool_list_local \- 
+list all booleans in the local store
+.br
+.B semanage_bool_list_active \- 
+list all booleans in the currently active policy
+.br
+.B semanage_port_list \-
+list all port ranges in the persistent policy
+.br
+.B semanage_port_list_local \-
+list all port ranges in the local store
+.br
+.B semanage_iface_list \-
+list all network interfaces in the persistent policy
+.br
+.B semanage_iface_list_local \- 
+list all network interfaces in the local store
+.br
+.B semanage_fcontext_list \-
+list all context specifications in the persistent policy
+.br
+.B semanage_fcontext_list_local \- 
+list all context specifications in the local store
+.br
+.B semanage_seuser_list \- 
+list all seusers (login mappings)
+
+.SH "SYNOPSIS"
+.B #include <semanage/users_policy.h>
+.br
+.B #include <semanage/users_local.h> 
+.br
+.B #include <semanage/booleans_policy.h>
+.br
+.B #include <semanage/booleans_local.h>
+.br
+.B #include <semanage/booleans_active.h>
+.br
+.B #include <semanage/ports_policy.h>
+.br
+.B #include <semanage/ports_local.h>
+.br
+.B #include <semanage/interfaces_policy.h>
+.br
+.B #include <semanage/interfaces_local.h>
+.br
+.B #include <semanage/fcontexts_policy.h>
+.br
+.B #include <semanage/fcontexts_local.h>
+.br
+.B #include <semanage/seusers.h>
+.sp
+
+.B FUNCTION: 
+see above
+.br
+.B OBJECT: 
+user, port, fcontext, iface, seuser
+.sp
+.sp
+
+.B extern int FUNCTION (
+.br
+.BI "	semanage_handle_t *" handle ","
+.br
+.BI "	semanage_user_t ***" objects ","
+.br
+.BI "	size_t* " count ");"
+
+.SH "DESCRIPTION"
+.TP
+.SS Behavior:
+The list functions will return an array of all the objects in the selected location.
+
+.TP
+.SS Parameters:
+The 
+.I handle
+is used to track persistent state across semanage calls, and for error reporting. The function will allocate and populate the the array of objects, and store it at the location pointed by  
+.I objects.
+It will write the number of objects at the location pointed by 
+.I count.
+The array, and all its objects become property of the caller. Each object must be freed with 
+.B semanage_OBJECT_free. 
+.TP
+.SS Requirements:
+This function requires an semanage connection to be established (see 
+.B semanage_connect
+)
+
+.SH "RETURN VALUE"
+In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+Otherwise a non-negative integer is returned (a commit number). The same number will be returned by all other semanage object read calls until the next commit.
+
+.SH "SEE ALSO"
+.BR semanage_handle_create "(3), " semanage_connect "(3), "
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_user_modify_local.3 new/libsemanage/man/man3/semanage_user_modify_local.3
--- old/libsemanage/man/man3/semanage_user_modify_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_modify_local.3	2006-01-04 19:48:22.000000000 -0500
@@ -0,0 +1,81 @@
+.TH semanage_user_modify_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.SH "NAME"
+.B semanage_user_modify_local \- 
+add or update a user in the local store
+.br
+.B semanage_bool_modify_local \- 
+add or update a boolean in the local store
+.br
+.B semanage_port_modify_local \- 
+add or update a port in the local store
+.br
+.B semanage_iface_modify_local \- 
+add or update an interface in the local store
+.br
+.B semanage_fcontext_modify_local \- 
+add or override a context specification in the local store
+.br
+.B semanage_seuser_modify \- 
+add a new seuser (login mapping)
+
+.SH "SYNOPSIS"
+.B #include <semanage/users_local.h> 
+.br
+.B #include <semanage/booleans_local.h>
+.br
+.B #include <semanage/ports_local.h>
+.br
+.B #include <semanage/interfaces_local.h>
+.br
+.B #include <semanage/fcontexts_local.h>
+.br
+.B #include <semanage/seusers.h>
+.sp
+
+.B FUNCTION: 
+see above
+.br
+.B OBJECT: 
+user, port, fcontext, iface, seuser
+.sp
+.sp
+.B extern int FUNCTION (
+.br
+.BI "	semanage_handle_t *" handle ","
+.br
+.BI "	semanage_OBJECT_key_t *" key ","
+.br
+.BI "	semanage_OBJECT_t *" data ");"
+
+.SH "DESCRIPTION"
+.TP
+.SS Modify Group:
+The group of modify functions are one of three ways to modify policy objects (the other two being the add group, and the set group). The three groups differ in whether they allow new or existing objects with respect to the local store. Behavior with respect to policy is the same - the object will be added if new, or changed if it exists (except for booleans, which do not allow new additions). Modify functions will update existing objects in the local store, and will also allow new objects.
+.TP
+.SS Behavior:
+If a matching key is found in the local store, the object provided will replace the current one. Otherwise, it will be added to the store, and later loaded into policy. Changes will become permanent when
+.B semanage_commit 
+is invoked. Validity of the object being added is checked at commit time. 
+.TP
+.SS Parameters:
+The 
+.I handle
+is used to track persistent state across semanage calls, and for error reporting. The
+.I key 
+identifies the 
+.I data
+object, which will be written into the store. The key are data are properties of the caller, and are not stored or modified internally.
+.TP
+.SS Requirements:
+This function requires an semanage connection to be established (see 
+.B semanage_connect
+), and must be executed in a transaction (see 
+.B semanage_begin_transaction
+).
+
+.SH "RETURN VALUE"
+In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+Otherwise 0 is returned.
+
+.SH "SEE ALSO"
+.BR semanage_handle_create "(3), " semanage_begin_transaction "(3), " semanage_connect "(3), " semanage_commit "(3). "
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_user_query.3 new/libsemanage/man/man3/semanage_user_query.3
--- old/libsemanage/man/man3/semanage_user_query.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_query.3	2006-01-04 18:24:01.000000000 -0500
@@ -0,0 +1 @@
+.so man3/semanage_user_query_local.3
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_user_query_local.3 new/libsemanage/man/man3/semanage_user_query_local.3
--- old/libsemanage/man/man3/semanage_user_query_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_query_local.3	2006-01-04 19:16:38.000000000 -0500
@@ -0,0 +1,106 @@
+.TH semanage_user_query_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.SH "NAME"
+.B semanage_user_query \-
+query a user in the persistent policy
+.br
+.B semanage_user_query_local \- 
+query a user in the local store
+.br
+.B semanage_bool_query \-
+query a boolean in the persistent policy
+.br
+.B semanage_bool_query_local \- 
+query a boolean in the local store 
+.br
+.B semanage_bool_query_active \- 
+query a boolean in the currently active policy
+.br
+.B semanage_port_query \-
+query a port range in the persistent policy
+.br
+.B semanage_port_query_local \-
+query a port range in the local store
+.br
+.B semanage_iface_query \-
+query a network interface in the persistent policy
+.br
+.B semanage_iface_query_local \- 
+query a network interface in the local store
+.br
+.B semanage_fcontext_query \-
+query a context specification in the persistent policy 
+.br
+.B semanage_fcontext_query_local \- 
+query a context specification in the local store
+.br
+.B semanage_seuser_query \- 
+query a seuser (login mapping)
+
+.SH "SYNOPSIS"
+.B #include <semanage/users_policy.h>
+.br
+.B #include <semanage/users_local.h> 
+.br
+.B #include <semanage/booleans_policy.h>
+.br
+.B #include <semanage/booleans_local.h>
+.br
+.B #include <semanage/booleans_active.h>
+.br
+.B #include <semanage/ports_policy.h>
+.br
+.B #include <semanage/ports_local.h>
+.br
+.B #include <semanage/interfaces_policy.h>
+.br
+.B #include <semanage/interfaces_local.h>
+.br
+.B #include <semanage/fcontexts_policy.h>
+.br
+.B #include <semanage/fcontexts_local.h>
+.br
+.B #include <semanage/seusers.h>
+.sp
+
+.B FUNCTION: 
+see above
+.br
+.B OBJECT: 
+user, port, fcontext, iface, seuser
+.sp
+.sp
+
+.B extern int FUNCTION (
+.br
+.BI "	semanage_handle_t *" handle ","
+.br
+.BI "	semanage_OBJECT_key_t *" key ","
+.br
+.BI "	semanage_OBJECT_t **" response ");"
+
+.SH "DESCRIPTION"
+.TP
+.SS Behavior:
+The query functions will fail if a matching key is not found. Otherwise, the corresponding object is returned. 
+.TP
+.SS Parameters:
+The 
+.I handle
+is used to track persistent state across semanage calls, and for error reporting. The
+.I key 
+identifies the object being queried, which will be stored in the address pointed by 
+.I response
+The key is a property of the caller, and will not be stored or modified internally. The object returned becomes a property of the caller, and must be freed with 
+.B semanage_OBJECT_free. 
+.TP
+.SS Requirements:
+This function requires an semanage connection to be established (see 
+.B semanage_connect
+)
+
+.SH "RETURN VALUE"
+In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+Otherwise a non-negative integer is returned (a commit number). The same number will be returned by all other semanage object read calls until the next commit.
+
+.SH "SEE ALSO"
+.BR semanage_handle_create "(3), " semanage_connect "(3), "
diff -Naurp --exclude pywrap-test.py --exclude-from excludes old/libsemanage/man/man3/semanage_user_set_local.3 new/libsemanage/man/man3/semanage_user_set_local.3
--- old/libsemanage/man/man3/semanage_user_set_local.3	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/man/man3/semanage_user_set_local.3	2006-01-04 19:45:04.000000000 -0500
@@ -0,0 +1,86 @@
+.TH semanage_user_set_local 3 "4 January 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
+.SH "NAME"
+.B semanage_user_set_local \- 
+update an existing user in the local store
+.br
+.B semanage_bool_set_local \- 
+update an existing boolean in the local store
+.br
+.B semanage_bool_set_active \- 
+update an existing boolean in the currently active policy
+.br
+.B semanage_port_set_local \- 
+update an existing port range in the local store
+.br
+.B semanage_iface_set_local \- 
+update an existing network interface in the local store
+.br
+.B semanage_fcontext_set_local \- 
+update an existing context specification in the local store
+.br
+.B semanage_seuser_set \- 
+update an existing seuser (login mapping)
+
+.SH "SYNOPSIS"
+.B #include <semanage/users_local.h> 
+.br
+.B #include <semanage/booleans_local.h>
+.br
+.B #include <semanage/booleans_active.h>
+.br
+.B #include <semanage/ports_local.h>
+.br
+.B #include <semanage/interfaces_local.h>
+.br
+.B #include <semanage/fcontexts_local.h>
+.br
+.B #include <semanage/seusers.h>
+.sp
+
+.B FUNCTION: 
+see above
+.br
+.B OBJECT: 
+user, port, fcontext, iface, seuser
+.sp
+.sp
+.B extern int FUNCTION (
+.br
+.BI "	semanage_handle_t *" handle ","
+.br
+.BI "	semanage_OBJECT_key_t *" key ","
+.br
+.BI "	semanage_OBJECT_t *" data ");"
+
+.SH "DESCRIPTION"
+.TP
+.SS Set Group:
+The group of set functions are one of three ways to modify policy objects (the other two being the add group, and the modify group). The three groups differ in whether they allow new or existing objects with respect to the local store. Behavior with respect to policy is the same - the object will be added if new, or changed if it exists (except for booleans, which do not allow new additions). Set functions will update existing objects in the local store, and will not allow new objects.
+.TP
+.SS Behavior:
+The set functions will fail if no matching key is found in the local store. Otherwise, the object provided will replace the current one in the local store, and will be loaded into policy. Changes will become permanent when 
+.B semanage_commit 
+is invoked. Validity of the object being added is checked at commit time. 
+.TP
+.SS Parameters:
+The 
+.I handle
+is used to track persistent state across semanage calls, and for error reporting. The
+.I key 
+identifies the 
+.I data
+object, which will be written into the store. The key are data are properties of the caller, and are not stored or modified internally.
+.TP
+.SS Requirements:
+This function requires an semanage connection to be established (see 
+.B semanage_connect
+), and must be executed in a transaction (see 
+.B semanage_begin_transaction
+).
+
+.SH "RETURN VALUE"
+In case of failure, -1 is returned, and the semanage error callback is invoked, describing the error.
+Otherwise 0 is returned.
+
+.SH "SEE ALSO"
+.BR semanage_handle_create "(3), " semanage_begin_transaction "(3), " semanage_connect "(3), " semanage_commit "(3). "

--------------050005090504090405060004--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
