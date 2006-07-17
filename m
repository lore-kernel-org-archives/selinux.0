Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6HKV6WW029358
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 16:31:06 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k6HKV3XE013821
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 20:31:05 GMT
Subject: [PATCH 6/6] netfilter integration: add netfilter contexts sorting
	test case
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 16:32:38 -0400
Message-Id: <1153168358.10090.51.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add unit test for netfilter contexts sorting.

 libsemanage/tests/Makefile              |    6 +-
 libsemanage/tests/nc_sort_malformed     |   25 ++++++++++
 libsemanage/tests/nc_sort_sorted        |   25 ++++++++++
 libsemanage/tests/nc_sort_unsorted      |   27 +++++++++++
 libsemanage/tests/test_semanage_store.c |   73 ++++++++++++++++++++++++++++++++
 libsemanage/tests/test_semanage_store.h |    2
 6 files changed, 155 insertions(+), 3 deletions(-)

diff --exclude .svn -purN trunk/libsemanage/tests/Makefile netfilter-integration/libsemanage/tests/Makefile
--- trunk/libsemanage/tests/Makefile	2006-07-11 11:53:29.388406000 -0400
+++ netfilter-integration/libsemanage/tests/Makefile	2006-07-11 16:13:43.470536750 -0400
@@ -5,7 +5,7 @@ SOURCES = $(wildcard *.c)
 TESTSRC=../src
 
 # Add the required external object files here:
-LIBSEMANAGE = ../src/libsemanage.a
+LIBS = ../src/libsemanage.a ../../libselinux/src/libselinux.a ../../libsepol/src/libsepol.a
 
 ###########################################################################
 
@@ -13,13 +13,13 @@ EXECUTABLE = libsemanage-tests
 CC = gcc
 CFLAGS = -c -g -o0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
 INCLUDE = -I$(TESTSRC) -I$(TESTSRC)/../include/semanage
-LDFLAGS = -lcunit -lsemanage
+LDFLAGS = -lcunit
 OBJECTS = $(SOURCES:.c=.o) 
 
 all: $(EXECUTABLE) 
 
 $(EXECUTABLE): $(OBJECTS) 
-	$(CC) $(OBJECTS) $(LIBSEMANAGE) $(LDFLAGS) -o $@
+	$(CC) $(OBJECTS) $(LIBS) $(LDFLAGS) -o $@
 
 %.o: %.c
 	$(CC) $(CFLAGS) $(INCLUDE) $*.c -o $*.o
diff --exclude .svn -purN trunk/libsemanage/tests/nc_sort_malformed netfilter-integration/libsemanage/tests/nc_sort_malformed
--- trunk/libsemanage/tests/nc_sort_malformed	1969-12-31 19:00:00.000000000 -0500
+++ netfilter-integration/libsemanage/tests/nc_sort_malformed	2006-07-17 15:33:02.231944000 -0400
@@ -0,0 +1,25 @@
+1 *mangle
+1 :PREROUTING ACCEPT [0:0]
+1 :INPUT ACCEPT [0:0]
+1 :FORWARD ACCEPT [0:0]
+1 :OUTPUT ACCEPT [0:0]
+1 :POSTROUTING ACCEPT [0:0]
+1 :selinux_input - [0:0]
+1 :selinux_output - [0:0]
+1 :selinux_new_input - [0:0]
+1 :selinux_new_output - [0:0]
+1 -A INPUT -j selinux_input
+1 -A OUTPUT -j selinux_output
+1 -A selinux_input -m state --state NEW -j selinux_new_input
+1 -A selinux_input -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore
+1 -A selinux_output -m state --state NEW -j selinux_new_output
+1 -A selinux_output -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore
+1 -A selinux_new_input -j SECMARK --selctx system_u:object_r:server_packet_t
+5 -A selinux_new_input -p tcp --dport 80 -j SECMARK --selctx system_u:object_r:http_server_packet_t
+-A selinux_new_input -j CONNSECMARK --save
+9 -A selinux_new_input -j RETURN
+1 -A selinux_new_output -j SECMARK --selctx system_u:object_r:client_packet_t
+5 -A selinux_new_output -p tcp --dport 80 -j SECMARK --selctx system_u:object_r:http_client_packet_t
+9 -A selinux_new_output -j CONNSECMARK --save
+9 -A selinux_new_output -j RETURN
+9 COMMIT
diff --exclude .svn -purN trunk/libsemanage/tests/nc_sort_sorted netfilter-integration/libsemanage/tests/nc_sort_sorted
--- trunk/libsemanage/tests/nc_sort_sorted	1969-12-31 19:00:00.000000000 -0500
+++ netfilter-integration/libsemanage/tests/nc_sort_sorted	2006-07-17 15:34:15.080496750 -0400
@@ -0,0 +1,25 @@
+*mangle
+:PREROUTING ACCEPT [0:0]
+:INPUT ACCEPT [0:0]
+:FORWARD ACCEPT [0:0]
+:OUTPUT ACCEPT [0:0]
+:POSTROUTING ACCEPT [0:0]
+:selinux_input - [0:0]
+:selinux_output - [0:0]
+:selinux_new_input - [0:0]
+:selinux_new_output - [0:0]
+-A INPUT -j selinux_input
+-A OUTPUT -j selinux_output
+-A selinux_input -m state --state NEW -j selinux_new_input
+-A selinux_input -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore
+-A selinux_output -m state --state NEW -j selinux_new_output
+-A selinux_output -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore
+-A selinux_new_input -j SECMARK --selctx system_u:object_r:server_packet_t
+-A selinux_new_output -j SECMARK --selctx system_u:object_r:client_packet_t
+-A selinux_new_input -p tcp --dport 80 -j SECMARK --selctx system_u:object_r:http_server_packet_t
+-A selinux_new_output -p tcp --dport 80 -j SECMARK --selctx system_u:object_r:http_client_packet_t
+-A selinux_new_input -j CONNSECMARK --save
+-A selinux_new_input -j RETURN
+-A selinux_new_output -j CONNSECMARK --save
+-A selinux_new_output -j RETURN
+COMMIT
diff --exclude .svn -purN trunk/libsemanage/tests/nc_sort_unsorted netfilter-integration/libsemanage/tests/nc_sort_unsorted
--- trunk/libsemanage/tests/nc_sort_unsorted	1969-12-31 19:00:00.000000000 -0500
+++ netfilter-integration/libsemanage/tests/nc_sort_unsorted	2006-07-17 15:38:15.691534000 -0400
@@ -0,0 +1,27 @@
+1 *mangle
+1 :PREROUTING ACCEPT [0:0]
+1 :INPUT ACCEPT [0:0]
+1 :FORWARD ACCEPT [0:0]
+1 :OUTPUT ACCEPT [0:0]
+1 :POSTROUTING ACCEPT [0:0]
+1 :selinux_input - [0:0]
+1 :selinux_output - [0:0]
+1 :selinux_new_input - [0:0]
+1 :selinux_new_output - [0:0]
+# a comment
+1 -A INPUT -j selinux_input
+1 -A OUTPUT -j selinux_output
+1 -A selinux_input -m state --state NEW -j selinux_new_input
+1 -A selinux_input -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore
+1 -A selinux_output -m state --state NEW -j selinux_new_output
+	# another comment
+1 -A selinux_output -m state --state RELATED,ESTABLISHED -j CONNSECMARK --restore
+1-A selinux_new_input -j SECMARK --selctx system_u:object_r:server_packet_t
+5 -A selinux_new_input -p tcp --dport 80 -j SECMARK --selctx system_u:object_r:http_server_packet_t
+9 -A selinux_new_input -j CONNSECMARK --save
+9 -A selinux_new_input -j RETURN
+1 -A selinux_new_output -j SECMARK --selctx system_u:object_r:client_packet_t
+5 -A selinux_new_output -p tcp --dport 80 -j SECMARK --selctx system_u:object_r:http_client_packet_t
+9 -A selinux_new_output -j CONNSECMARK --save
+9 -A selinux_new_output -j RETURN
+9 COMMIT
diff --exclude .svn -purN trunk/libsemanage/tests/test_semanage_store.c netfilter-integration/libsemanage/tests/test_semanage_store.c
--- trunk/libsemanage/tests/test_semanage_store.c	2006-07-11 11:53:29.388406000 -0400
+++ netfilter-integration/libsemanage/tests/test_semanage_store.c	2006-07-14 11:17:57.552473750 -0400
@@ -1,5 +1,6 @@
 /* Authors: Christopher Ashworth <cashworth@tresys.com>
  *          Caleb Case <ccase@tresys.com>
+ *          Chris PeBenito <cpebenito@tresys.com>
  *
  * Copyright (C) 2006 Tresys Technology, LLC
  *
@@ -35,6 +36,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 #include <unistd.h>
 #include <CUnit/Basic.h>
 
@@ -118,6 +123,11 @@ int semanage_store_add_tests(CU_pSuite s
 		CU_cleanup_registry();
 		return CU_get_error();
 	}
+
+	if (NULL == CU_add_test(suite, "semanage_nc_sort", test_semanage_nc_sort)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
 	
 	return 0;
 }
@@ -278,3 +288,66 @@ void test_semanage_get_lock(void)
 	CU_ASSERT( err == 0 );
 }
 
+/* Tests the semanage_nc_sort function in semanage_store.c
+ */
+void test_semanage_nc_sort(void)
+{
+	char *source_buf, *sorted_buf = NULL, *good_buf, *bad_buf;
+	size_t source_buf_len, sorted_buf_len, good_buf_len, bad_buf_len;
+	int sourcefd, goodfd, badfd, err;
+	struct stat sb;
+
+	/* open source file */
+	sourcefd = open("nc_sort_unsorted",O_RDONLY);
+	if( sourcefd < 0 ) {
+		CU_FAIL("Missing nc_sort_unsorted test file.");
+		return;
+	}
+	fstat(sourcefd, &sb);
+	source_buf_len = sb.st_size;
+	source_buf =(char*) mmap(NULL, source_buf_len, PROT_READ, MAP_PRIVATE, sourcefd, 0);
+
+	/* open good result file */
+	goodfd = open("nc_sort_sorted",O_RDONLY);
+	if( goodfd < 0 ) {
+		CU_FAIL("Missing nc_sort_sorted test file.");
+		goto out2;
+	}
+	fstat(goodfd, &sb);
+	good_buf_len = sb.st_size;
+	good_buf =(char*) mmap(NULL, good_buf_len, PROT_READ, MAP_PRIVATE, goodfd, 0);
+
+	/* open malformed source file (missing priorities) */
+	badfd = open("nc_sort_malformed",O_RDONLY);
+	if( badfd < 0 ) {
+		CU_FAIL("Missing nc_sort_malformed test file.");
+		goto out1;
+	}
+	fstat(badfd, &sb);
+	bad_buf_len = sb.st_size;
+	bad_buf =(char*) mmap(NULL, bad_buf_len, PROT_READ, MAP_PRIVATE, badfd, 0);
+
+	/* sort test file */
+	err = semanage_nc_sort(sh,source_buf,source_buf_len,&sorted_buf,&sorted_buf_len);
+	CU_ASSERT_FALSE(err);
+	CU_ASSERT_STRING_EQUAL(sorted_buf,good_buf);
+
+	/* reset for reuse in next test */
+	free(sorted_buf);
+	sorted_buf = NULL;
+
+	/* sort malformed source file */
+	err = semanage_nc_sort(sh,bad_buf,bad_buf_len,&sorted_buf,&sorted_buf_len);
+	CU_ASSERT_EQUAL(err,-1);
+
+	free(sorted_buf);
+
+	munmap(bad_buf,bad_buf_len);
+	close(badfd);
+out1:
+	munmap(good_buf,good_buf_len);
+	close(goodfd);
+out2:
+	munmap(source_buf,source_buf_len);
+	close(sourcefd);
+}
diff --exclude .svn -purN trunk/libsemanage/tests/test_semanage_store.h netfilter-integration/libsemanage/tests/test_semanage_store.h
--- trunk/libsemanage/tests/test_semanage_store.h	2006-07-11 11:53:29.388406000 -0400
+++ netfilter-integration/libsemanage/tests/test_semanage_store.h	2006-07-14 11:15:32.859431000 -0400
@@ -1,4 +1,5 @@
 /* Authors: Christopher Ashworth <cashworth@tresys.com>
+ *          Chris PeBenito <cpebenito@tresys.com>
  *
  * Copyright (C) 2006 Tresys Technology, LLC
  *
@@ -28,5 +29,6 @@ int semanage_store_add_tests(CU_pSuite s
 
 void test_semanage_store_access_check(void);
 void test_semanage_get_lock(void);
+void test_semanage_nc_sort(void);
 
 #endif


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
