Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D651A0BE7
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334649; cv=none; b=MPiMAkcn0mLBuUOQ7dWbmQTnl8cUM22uhtW7eG+21eaMcoWMlNUn6JywHWsotkc/8/f59syiN87bfYZB7TxV7rDcWA/UP9PVSQlrxKdUeaNLjPtZC/xpxcWgJIwZb6tGHFadt8fFr2LPUmcSyJO6yIirVKNfdL3mgYAQP8U8f/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334649; c=relaxed/simple;
	bh=cRhZkXsckYaChAkcU5Wz4uatOMbALrwUaOVKArdDHSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pfv/3ERQOIVO2yv+r3zRX9jRgeNXASCcoLMj5R+uxGRaSbz8c4k4QImPn79t//qouM4cb3TNCklmEFxyVd3+ohKMkTDfUYtRAL2nL1VWE/CIREAyjbg6/ZCJQ7MXsNxpoxf1qA++NqoqAAgsmvnxNLj6rypO+Grv9wYTeyN3F6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=pUWYiVkz; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="pUWYiVkz"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334642;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0EtM2Fv/ey4BXWo5eBfMWWDB5K8gcgA/687gFl8mRQ=;
	b=pUWYiVkzSPffgV8HIuHMj/Ngcs8M+xw8dklWlYylkjMmnrXcpvmpnq8FkuitQdWOszmaLN
	bOCe5nlapKtInKT44k4ROO+3aB2sTvxpHwWhnCr1+LS4d+f2oLedw7kODIHyN13hI1/Ew3
	itK7QB54sqUNja4/yGtaluxq+qUjIkcuXGQbk6BOxJyXfvRKD5t+QlJhncMnyXpwK7uPXY
	5lSaqHHnb+qq9XuU5t3lir7QherwBin12zhBTZQfMI+VajSXklihAj4KGWreCIh7gewUyz
	Nid1hmY8fOGQzqPmcjFB2yNjQ0Il1LShzhOgi5xAsCnWk5oxbswwOXOZmDG77A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 47/47] libsemanage/tests: misc cleanup
Date: Mon, 11 Nov 2024 15:17:06 +0100
Message-ID: <20241111141706.38039-47-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

* Explicitly mark unused function parameters and drop compiler warning
  override
* Move declaration of `semanage_handle_t *sh` from individual source
  files to utilities.h, since it is defined in utilities.c
* Declare file local variables static
* Drop unused macros
* Avoid casts dropping const qualifier
* Avoid usage of reserved identifier names (leading underscores)
* Silence UBSAN underflow warning by adding explicit cast

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/tests/Makefile              |  2 +-
 libsemanage/tests/test_bool.c           | 12 +++++-----
 libsemanage/tests/test_fcontext.c       | 21 ++++++-----------
 libsemanage/tests/test_handle.c         | 11 +++++----
 libsemanage/tests/test_ibendport.c      | 18 +++++++--------
 libsemanage/tests/test_iface.c          | 12 +++++-----
 libsemanage/tests/test_node.c           | 12 +++++-----
 libsemanage/tests/test_other.c          |  4 +---
 libsemanage/tests/test_port.c           | 12 +++++-----
 libsemanage/tests/test_semanage_store.c | 13 +++++------
 libsemanage/tests/test_user.c           | 12 +++++-----
 libsemanage/tests/test_utilities.c      |  2 +-
 libsemanage/tests/utilities.c           | 10 +++++----
 libsemanage/tests/utilities.h           | 30 +++++++++++++------------
 14 files changed, 81 insertions(+), 90 deletions(-)

diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index b0869558..241ff17a 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -5,7 +5,7 @@ CILS = $(sort $(wildcard *.cil))
 ###########################################################################
 
 EXECUTABLE = libsemanage-tests
-CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
+CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I../src -I../include
 override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
 
diff --git a/libsemanage/tests/test_bool.c b/libsemanage/tests/test_bool.c
index 9356a1ae..fdbee733 100644
--- a/libsemanage/tests/test_bool.c
+++ b/libsemanage/tests/test_bool.c
@@ -55,8 +55,6 @@ static void test_bool_count_local(void);
 static void test_bool_iterate_local(void);
 static void test_bool_list_local(void);
 
-extern semanage_handle_t *sh;
-
 int boolean_test_init(void)
 {
 	if (create_test_store() < 0) {
@@ -601,9 +599,10 @@ static void test_bool_count(void)
 }
 
 /* Function bool_iterate */
-unsigned int counter_bool_iterate = 0;
+static unsigned int counter_bool_iterate = 0;
 
-static int handler_bool_iterate(const semanage_bool_t *record, void *varg)
+static int handler_bool_iterate(__attribute__((unused)) const semanage_bool_t *record,
+				__attribute__((unused)) void *varg)
 {
 	counter_bool_iterate++;
 	return 0;
@@ -857,9 +856,10 @@ static void test_bool_count_local(void)
 }
 
 /* Function bool_iterate_local */
-unsigned int counter_bool_iterate_local = 0;
+static unsigned int counter_bool_iterate_local = 0;
 
-static int handler_bool_iterate_local(const semanage_bool_t *record, void *varg)
+static int handler_bool_iterate_local(__attribute__((unused)) const semanage_bool_t *record,
+				      __attribute__((unused)) void *varg)
 {
 	counter_bool_iterate_local++;
 	return 0;
diff --git a/libsemanage/tests/test_fcontext.c b/libsemanage/tests/test_fcontext.c
index 8943d741..291ed261 100644
--- a/libsemanage/tests/test_fcontext.c
+++ b/libsemanage/tests/test_fcontext.c
@@ -21,25 +21,19 @@
 #include "utilities.h"
 #include "test_fcontext.h"
 
-char FCONTEXTS[] =
+static const char FCONTEXTS[] =
     "/etc/selinux(/.*) -s system_u:object_r:first_t:s0\n"
     "/etc/selinux/targeted -- system_u:object_r:second_t:s0\n"
     "/etc/selinux(/.*) -b system_u:object_r:third_t:s0\n";
-unsigned int FCONTEXTS_LEN = sizeof(FCONTEXTS);
+static const unsigned int FCONTEXTS_LEN = sizeof(FCONTEXTS);
 
 #define FCONTEXTS_COUNT 3
 
 #define FCONTEXT1_EXPR "/etc/selinux(/.*)"
 #define FCONTEXT1_TYPE SEMANAGE_FCONTEXT_SOCK
-#define FCONTEXT1_CON "system_u:object_r:first_t:s0"
 
 #define FCONTEXT2_EXPR "/etc/selinux/targeted"
 #define FCONTEXT2_TYPE SEMANAGE_FCONTEXT_REG
-#define FCONTEXT2_CON "system_u:object_r:second_t:s0"
-
-#define FCONTEXT3_EXPR "/etc/selinux(/.*)"
-#define FCONTEXT3_TYPE SEMANAGE_FCONTEXT_BLOCK
-#define FCONTEXT3_CON "system_u:object_r:third_t:s0"
 
 #define FCONTEXT_NONEXISTENT_EXPR "/asdf"
 #define FCONTEXT_NONEXISTENT_TYPE SEMANAGE_FCONTEXT_ALL
@@ -71,8 +65,6 @@ static void test_fcontext_count_local(void);
 static void test_fcontext_iterate_local(void);
 static void test_fcontext_list_local(void);
 
-extern semanage_handle_t *sh;
-
 static int write_file_contexts(const char *data, unsigned int data_len)
 {
 	FILE *fptr = fopen("test-policy/store/active/file_contexts", "w+");
@@ -653,9 +645,10 @@ static void test_fcontext_count(void)
 }
 
 /* Function semanage_fcontext_iterate */
-unsigned int counter_fcontext_iterate = 0;
+static unsigned int counter_fcontext_iterate = 0;
 
-static int handler_fcontext_iterate(const semanage_fcontext_t *record, void *varg)
+static int handler_fcontext_iterate(const semanage_fcontext_t *record,
+				    __attribute__((unused)) void *varg)
 {
 	CU_ASSERT_PTR_NOT_NULL(record);
 	counter_fcontext_iterate++;
@@ -934,10 +927,10 @@ static void test_fcontext_count_local(void)
 }
 
 /* Function semanage_fcontext_iterate_local */
-unsigned int counter_fcontext_iterate_local = 0;
+static unsigned int counter_fcontext_iterate_local = 0;
 
 static int handler_fcontext_iterate_local(const semanage_fcontext_t *record,
-				   void *varg)
+					  __attribute__((unused)) void *varg)
 {
 	CU_ASSERT_PTR_NOT_NULL(record);
 	counter_fcontext_iterate_local++;
diff --git a/libsemanage/tests/test_handle.c b/libsemanage/tests/test_handle.c
index 00a6cb92..704569eb 100644
--- a/libsemanage/tests/test_handle.c
+++ b/libsemanage/tests/test_handle.c
@@ -34,8 +34,6 @@ static void test_msg_set_callback(void);
 static void test_root(void);
 static void test_select_store(void);
 
-extern semanage_handle_t *sh;
-
 int handle_test_init(void)
 {
 	if (create_test_store() < 0) {
@@ -234,10 +232,11 @@ static void test_mls_enabled(void)
 }
 
 /* Function semanage_set_callback */
-int msg_set_callback_count = 0;
+static int msg_set_callback_count = 0;
 
-static void helper_msg_set_callback(void *varg, semanage_handle_t *handle,
-			     const char *fmt, ...)
+static void helper_msg_set_callback(__attribute__((unused)) void *varg,
+				    __attribute__((unused)) semanage_handle_t *handle,
+				    __attribute__((unused)) const char *fmt, ...)
 {
 	msg_set_callback_count++;
 }
@@ -300,7 +299,7 @@ static void helper_select_store(const char *name, enum semanage_connect_type typ
 	/* FIXME: the storename parameter of semanage_select_store should be
 	 * 'const char *'
 	 */
-	semanage_select_store(sh, (char *) name, type);
+	semanage_select_store(sh, name, type);
 
 	int res = semanage_connect(sh);
 
diff --git a/libsemanage/tests/test_ibendport.c b/libsemanage/tests/test_ibendport.c
index a6ce7a34..ea99c101 100644
--- a/libsemanage/tests/test_ibendport.c
+++ b/libsemanage/tests/test_ibendport.c
@@ -46,8 +46,6 @@ static void test_ibendport_count_local(void);
 static void test_ibendport_iterate_local(void);
 static void test_ibendport_list_local(void);
 
-extern semanage_handle_t *sh;
-
 int ibendport_test_init(void)
 {
 	if (create_test_store() < 0) {
@@ -254,9 +252,9 @@ static void test_ibendport_count(void)
 }
 
 /* Function semanage_ibendport_iterate */
-unsigned int helper_ibendport_iterate_counter = 0;
+static unsigned int helper_ibendport_iterate_counter = 0;
 
-static int helper_ibendport_iterate(const semanage_ibendport_t *ibendport,
+static int helper_ibendport_iterate(__attribute__((unused)) const semanage_ibendport_t *ibendport,
 			     void *fn_arg)
 {
 	CU_ASSERT(fn_arg == (void *) 42);
@@ -264,7 +262,7 @@ static int helper_ibendport_iterate(const semanage_ibendport_t *ibendport,
 	return 0;
 }
 
-static int helper_ibendport_iterate_error(const semanage_ibendport_t *ibendport,
+static int helper_ibendport_iterate_error(__attribute__((unused)) const semanage_ibendport_t *ibendport,
 				   void *fn_arg)
 {
 	CU_ASSERT(fn_arg == (void *) 42);
@@ -272,7 +270,7 @@ static int helper_ibendport_iterate_error(const semanage_ibendport_t *ibendport,
 	return -1;
 }
 
-static int helper_ibendport_iterate_break(const semanage_ibendport_t *ibendport,
+static int helper_ibendport_iterate_break(__attribute__((unused)) const semanage_ibendport_t *ibendport,
 				   void *fn_arg)
 {
 	CU_ASSERT(fn_arg == (void *) 42);
@@ -439,9 +437,9 @@ static void test_ibendport_count_local(void)
 }
 
 /* Function semanage_ibendport_iterate_local */
-unsigned int helper_ibendport_iterate_local_counter = 0;
+static unsigned int helper_ibendport_iterate_local_counter = 0;
 
-static int helper_ibendport_iterate_local(const semanage_ibendport_t *ibendport,
+static int helper_ibendport_iterate_local(__attribute__((unused)) const semanage_ibendport_t *ibendport,
 				   void *fn_arg)
 {
 	CU_ASSERT(fn_arg == (void *) 42);
@@ -449,7 +447,7 @@ static int helper_ibendport_iterate_local(const semanage_ibendport_t *ibendport,
 	return 0;
 }
 
-static int helper_ibendport_iterate_local_error(const semanage_ibendport_t *ibendport,
+static int helper_ibendport_iterate_local_error(__attribute__((unused)) const semanage_ibendport_t *ibendport,
 					 void *fn_arg)
 {
 	CU_ASSERT(fn_arg == (void *) 42);
@@ -457,7 +455,7 @@ static int helper_ibendport_iterate_local_error(const semanage_ibendport_t *iben
 	return -1;
 }
 
-static int helper_ibendport_iterate_local_break(const semanage_ibendport_t *ibendport,
+static int helper_ibendport_iterate_local_break(__attribute__((unused)) const semanage_ibendport_t *ibendport,
 					 void *fn_arg)
 {
 	CU_ASSERT(fn_arg == (void *) 42);
diff --git a/libsemanage/tests/test_iface.c b/libsemanage/tests/test_iface.c
index 2b84cb8e..19f70797 100644
--- a/libsemanage/tests/test_iface.c
+++ b/libsemanage/tests/test_iface.c
@@ -61,8 +61,6 @@ static void test_iface_count_local(void);
 static void test_iface_iterate_local(void);
 static void test_iface_list_local(void);
 
-extern semanage_handle_t *sh;
-
 int iface_test_init(void)
 {
 	if (create_test_store() < 0) {
@@ -492,9 +490,10 @@ static void test_iface_count(void)
 
 /* Function semanage_iface_iterate */
 
-unsigned int counter_iface_iterate = 0;
+static unsigned int counter_iface_iterate = 0;
 
-static int handler_iface_iterate(const semanage_iface_t *record, void *varg)
+static int handler_iface_iterate(__attribute__((unused)) const semanage_iface_t *record,
+				 __attribute__((unused)) void *varg)
 {
 	counter_iface_iterate++;
 	return 0;
@@ -632,9 +631,10 @@ static void test_iface_count_local(void)
 }
 
 /* Function semanage_iface_iterate_local */
-unsigned int counter_iface_iterate_local = 0;
+static unsigned int counter_iface_iterate_local = 0;
 
-static int handler_iface_iterate_local(const semanage_iface_t *record, void *varg)
+static int handler_iface_iterate_local(__attribute__((unused)) const semanage_iface_t *record,
+				       __attribute__((unused)) void *varg)
 {
 	counter_iface_iterate_local++;
 	return 0;
diff --git a/libsemanage/tests/test_node.c b/libsemanage/tests/test_node.c
index 0db38d97..e07b5973 100644
--- a/libsemanage/tests/test_node.c
+++ b/libsemanage/tests/test_node.c
@@ -67,8 +67,6 @@ static void test_node_count_local(void);
 static void test_node_iterate_local(void);
 static void test_node_list_local(void);
 
-extern semanage_handle_t *sh;
-
 int node_test_init(void)
 {
 	if (create_test_store() < 0) {
@@ -620,9 +618,10 @@ static void test_node_count(void)
 }
 
 /* Function semanage_node_iterate */
-unsigned int counter_node_iterate = 0;
+static unsigned int counter_node_iterate = 0;
 
-static int handler_node_iterate(const semanage_node_t *record, void *varg)
+static int handler_node_iterate(__attribute__((unused)) const semanage_node_t *record,
+				__attribute__((unused)) void *varg)
 {
 	counter_node_iterate++;
 	return 0;
@@ -777,9 +776,10 @@ static void test_node_count_local(void)
 }
 
 /* Function semanage_node_iterate_local */
-unsigned int counter_node_iterate_local = 0;
+static unsigned int counter_node_iterate_local = 0;
 
-static int handler_node_iterate_local(const semanage_node_t *record, void *varg)
+static int handler_node_iterate_local(__attribute__((unused)) const semanage_node_t *record,
+				      __attribute__((unused)) void *varg)
 {
 	counter_node_iterate_local++;
 	return 0;
diff --git a/libsemanage/tests/test_other.c b/libsemanage/tests/test_other.c
index 0a57e247..9ea9737a 100644
--- a/libsemanage/tests/test_other.c
+++ b/libsemanage/tests/test_other.c
@@ -27,8 +27,6 @@ void test_semanage_context(void);
 /* debug.h */
 void test_debug(void);
 
-extern semanage_handle_t *sh;
-
 int other_test_init(void)
 {
 	return 0;
@@ -116,7 +114,7 @@ void test_debug(void)
 	CU_ASSERT(semanage_module_info_create(sh, &modinfo) >= 0);
 
 	/* test */
-	CU_ASSERT(semanage_module_info_set_priority(sh, modinfo, -42) < 0);
+	CU_ASSERT(semanage_module_info_set_priority(sh, modinfo, (uint16_t)-42) < 0);
 
 	/* cleanup */
 	semanage_module_info_destroy(sh, modinfo);
diff --git a/libsemanage/tests/test_port.c b/libsemanage/tests/test_port.c
index e6393d78..2c0b980b 100644
--- a/libsemanage/tests/test_port.c
+++ b/libsemanage/tests/test_port.c
@@ -65,8 +65,6 @@ static void test_port_list_local(void);
 /* internal */
 static void test_port_validate_local(void);
 
-extern semanage_handle_t *sh;
-
 int port_test_init(void)
 {
 	if (create_test_store() < 0) {
@@ -539,9 +537,10 @@ static void test_port_count(void)
 }
 
 /* Function semanage_port_iterate */
-unsigned int counter_port_iterate = 0;
+static unsigned int counter_port_iterate = 0;
 
-static int handler_port_iterate(const semanage_port_t *record, void *varg)
+static int handler_port_iterate(__attribute__((unused)) const semanage_port_t *record,
+				__attribute__((unused)) void *varg)
 {
 	counter_port_iterate++;
 	return 0;
@@ -716,9 +715,10 @@ static void test_port_count_local(void)
 }
 
 /* Function semanage_port_iterate_local */
-unsigned int counter_port_iterate_local = 0;
+static unsigned int counter_port_iterate_local = 0;
 
-static int handler_port_iterate_local(const semanage_port_t *record, void *varg)
+static int handler_port_iterate_local(__attribute__((unused)) const semanage_port_t *record,
+				      __attribute__((unused)) void *varg)
 {
 	counter_port_iterate_local++;
 	return 0;
diff --git a/libsemanage/tests/test_semanage_store.c b/libsemanage/tests/test_semanage_store.c
index 2e6c38e1..28a76d4f 100644
--- a/libsemanage/tests/test_semanage_store.c
+++ b/libsemanage/tests/test_semanage_store.c
@@ -43,13 +43,12 @@
 #include <unistd.h>
 #include <CUnit/Basic.h>
 
-extern semanage_handle_t *sh;
-const char *rootpath = "./test-policy";
-const char *polpath = "./test-policy/store/";
-const char *readlockpath = "./test-policy/store/semanage.read.LOCK";
-const char *translockpath = "./test-policy/store/semanage.trans.LOCK";
-const char *actpath = "./test-policy/store/active";
-const char *modpath = "./test-policy/store/active/modules";
+static const char *const rootpath = "./test-policy";
+static const char *const polpath = "./test-policy/store/";
+static const char *const readlockpath = "./test-policy/store/semanage.read.LOCK";
+static const char *const translockpath = "./test-policy/store/semanage.trans.LOCK";
+static const char *const actpath = "./test-policy/store/active";
+static const char *const modpath = "./test-policy/store/active/modules";
 
 /* The suite initialization function.
  * Returns zero on success, non-zero otherwise.
diff --git a/libsemanage/tests/test_user.c b/libsemanage/tests/test_user.c
index b6fda51a..776a061c 100644
--- a/libsemanage/tests/test_user.c
+++ b/libsemanage/tests/test_user.c
@@ -50,8 +50,6 @@ static void test_user_count_local(void);
 static void test_user_iterate_local(void);
 static void test_user_list_local(void);
 
-extern semanage_handle_t *sh;
-
 int user_test_init(void)
 {
 	if (create_test_store() < 0) {
@@ -515,9 +513,10 @@ static void test_user_count(void)
 }
 
 /* Function semanage_user_iterate */
-unsigned int counter_user_iterate = 0;
+static unsigned int counter_user_iterate = 0;
 
-static int handler_user_iterate(const semanage_user_t *record, void *varg)
+static int handler_user_iterate(__attribute__((unused)) const semanage_user_t *record,
+				__attribute__((unused)) void *varg)
 {
 	counter_user_iterate++;
 	return 0;
@@ -648,9 +647,10 @@ static void test_user_count_local(void)
 }
 
 /* Function semanage_user_iterate_local */
-unsigned int counter_user_iterate_local = 0;
+static unsigned int counter_user_iterate_local = 0;
 
-static int handler_user_iterate_local(const semanage_user_t *record, void *varg)
+static int handler_user_iterate_local(__attribute__((unused)) const semanage_user_t *record,
+				      __attribute__((unused)) void *varg)
 {
 	counter_user_iterate_local++;
 	return 0;
diff --git a/libsemanage/tests/test_utilities.c b/libsemanage/tests/test_utilities.c
index e1ff4e7d..bbd5af30 100644
--- a/libsemanage/tests/test_utilities.c
+++ b/libsemanage/tests/test_utilities.c
@@ -47,7 +47,7 @@ static void test_semanage_str_replace(void);
 static void test_semanage_findval(void);
 static void test_slurp_file_filter(void);
 
-char fname[] = {
+static char fname[] = {
 	'T', 'E', 'S', 'T', '_', 'T', 'E', 'M', 'P', '_', 'X', 'X', 'X', 'X',
 	'X', 'X', '\0'
 };
diff --git a/libsemanage/tests/utilities.c b/libsemanage/tests/utilities.c
index 806869e0..91ecf94a 100644
--- a/libsemanage/tests/utilities.c
+++ b/libsemanage/tests/utilities.c
@@ -24,14 +24,16 @@
 
 #include "utilities.h"
 
-int test_store_enabled = 0;
+static int test_store_enabled = 0;
 
 semanage_handle_t *sh = NULL;
 
 /* Silence any error output caused by our tests
  * by using this dummy function to catch messages.
  */
-void test_msg_handler(void *varg, semanage_handle_t *handle, const char *fmt,
+void test_msg_handler(__attribute__((unused)) void *varg,
+		      __attribute__((unused)) semanage_handle_t *handle,
+		      __attribute__((unused)) const char *fmt,
 		      ...)
 {
 }
@@ -213,7 +215,7 @@ void helper_handle_create(void) {
 		semanage_set_create_store(sh, 1);
 		semanage_set_reload(sh, 0);
 		semanage_set_store_root(sh, "");
-		semanage_select_store(sh, (char *) "store",
+		semanage_select_store(sh, "store",
 				      SEMANAGE_CON_DIRECT);
 	}
 }
@@ -271,7 +273,7 @@ void setup_handle_invalid_store(level_t level) {
 
 	helper_handle_create();
 
-	semanage_select_store(sh, (char *) "", SEMANAGE_CON_INVALID);
+	semanage_select_store(sh, "", SEMANAGE_CON_INVALID);
 
 	if (level >= SH_CONNECT)
 		helper_connect();
diff --git a/libsemanage/tests/utilities.h b/libsemanage/tests/utilities.h
index 298b3280..4b6b8bae 100644
--- a/libsemanage/tests/utilities.h
+++ b/libsemanage/tests/utilities.h
@@ -34,13 +34,13 @@
 
 #define CU_ASSERT_CONTEXT_EQUAL(CON1,CON2) \
 	do { \
-		char *__str; \
-		char *__str2; \
-		CU_ASSERT(semanage_context_to_string(sh, CON1, &__str) >= 0); \
-		CU_ASSERT(semanage_context_to_string(sh, CON2, &__str2) >= 0); \
-		CU_ASSERT_STRING_EQUAL(__str, __str2); \
-		free(__str2); \
-		free(__str); \
+		char *str__; \
+		char *str2__; \
+		CU_ASSERT(semanage_context_to_string(sh, CON1, &str__) >= 0); \
+		CU_ASSERT(semanage_context_to_string(sh, CON2, &str2__) >= 0); \
+		CU_ASSERT_STRING_EQUAL(str__, str2__); \
+		free(str2__); \
+		free(str__); \
 	} while (0)
 
 
@@ -49,9 +49,9 @@
 
 #undef CU_ASSERT_FATAL
 #define CU_ASSERT_FATAL(value) do { \
-		int _value = (value); \
-		CU_ASSERT(_value); \
-		assert(_value); \
+		int value_ = (value); \
+		CU_ASSERT(value_); \
+		assert(value_); \
 	} while (0)
 
 #undef CU_FAIL_FATAL
@@ -62,18 +62,20 @@
 
 #undef CU_ASSERT_PTR_NOT_NULL_FATAL
 #define CU_ASSERT_PTR_NOT_NULL_FATAL(value) do { \
-		const void *_value = (value); \
-		CU_ASSERT_PTR_NOT_NULL(_value); \
-		assert(_value != NULL); \
+		const void *value_ = (value); \
+		CU_ASSERT_PTR_NOT_NULL(value_); \
+		assert(value_ != NULL); \
 	} while (0)
 
 #endif /* __CHECKER__ */
 
-#define I_NULL  -1
+#define I_NULL (-1)
 #define I_FIRST  0
 #define I_SECOND 1
 #define I_THIRD  2
 
+extern semanage_handle_t *sh;
+
 typedef enum { SH_NULL, SH_HANDLE, SH_CONNECT, SH_TRANS } level_t;
 
 void test_msg_handler(void *varg, semanage_handle_t *handle, const char *fmt,
-- 
2.45.2

