Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EACA1A00C9
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334643; cv=none; b=SXj/1YULEnuQ1+lxMAZSNQ6XzzqzCa85eLjOgC3kg6ehdc36rFJvLTqisPLkmgB7s9u3bzrFk4VEo0NkuCxmmh0Qttzylpi7VQEL8BiD9Q2lhq30W/ffHx1zlnCb+AhY06dLiUwkUSQr26MuWN05iFwf2+jtduUMOCvrR75imJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334643; c=relaxed/simple;
	bh=ZPm+hckMglq//sydxnbCeoY/neuiOWN4JYDIdTB9Edo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlDTmkjbk9M5rg71fo/I2lQ0dMmhxwlLj0gBLlodlqWY+iT+xsBO+h8Jk/PyRrcgX2vZfL+GS9H7kJnsG7sDX5vdsLg8YLJC/gS21hToar3e6F844SLn8mfzOac9n65PWYZn5tJ5kZnJUTRdkraIeF/vL/RM9TlueEvegECIwbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=CMwDzXvR; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="CMwDzXvR"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334635;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8O8TfkY6dZXkidKXcoGlUtfukV0LiKlEgt/5gw91Yak=;
	b=CMwDzXvRICgchnT9h79MJK4t0IU3jb8cK0aQSwzZ+8Q7eboJz42hRyh3usmTp+VS+s885P
	xo1sslDk5O2aeInF3SvuCn1ynnE7/QQhgc8EnEK3JhA9AxBrx5G/DKoArEFLy4I/HKQQjD
	htC2hjGIE0UL/9TOzvpIA+kagHQ5x5Q3lblo5hu1L+UmTpMmA1OtEcBr/D7qK+vkee6K0S
	cY1fDyyAs4Z6vrYEkeNhnCP3QrCD0C+IzBMwVRwpt16CDvyxWQPt+Bc3FHcHc9DsDwSvJ2
	BZ0q93pPDndjFDp6XCxeS5Eju6hAQtglUnu8g/d40nA9mBhigcfXtSL6ECP60g==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 14/47] libsemanage: declare file local function tables static
Date: Mon, 11 Nov 2024 15:16:33 +0100
Message-ID: <20241111141706.38039-14-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/booleans_activedb.c   | 2 +-
 libsemanage/src/booleans_file.c       | 2 +-
 libsemanage/src/booleans_policydb.c   | 2 +-
 libsemanage/src/fcontexts_file.c      | 2 +-
 libsemanage/src/genhomedircon.c       | 2 +-
 libsemanage/src/ibendports_file.c     | 2 +-
 libsemanage/src/ibendports_policydb.c | 2 +-
 libsemanage/src/ibpkeys_file.c        | 2 +-
 libsemanage/src/ibpkeys_policydb.c    | 2 +-
 libsemanage/src/interfaces_file.c     | 2 +-
 libsemanage/src/interfaces_policydb.c | 2 +-
 libsemanage/src/nodes_file.c          | 2 +-
 libsemanage/src/nodes_policydb.c      | 2 +-
 libsemanage/src/ports_file.c          | 2 +-
 libsemanage/src/ports_policydb.c      | 2 +-
 libsemanage/src/seusers_file.c        | 2 +-
 libsemanage/src/users_base_file.c     | 2 +-
 libsemanage/src/users_base_policydb.c | 2 +-
 libsemanage/src/users_extra_file.c    | 2 +-
 libsemanage/src/users_join.c          | 2 +-
 20 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/libsemanage/src/booleans_activedb.c b/libsemanage/src/booleans_activedb.c
index 6ebb520b..1d4e33b4 100644
--- a/libsemanage/src/booleans_activedb.c
+++ b/libsemanage/src/booleans_activedb.c
@@ -141,7 +141,7 @@ static int bool_commit_list(semanage_handle_t * handle,
 }
 
 /* BOOL RECORD: ACTIVEDB extension: method table */
-record_activedb_table_t SEMANAGE_BOOL_ACTIVEDB_RTABLE = {
+static record_activedb_table_t SEMANAGE_BOOL_ACTIVEDB_RTABLE = {
 	.read_list = bool_read_list,
 	.commit_list = bool_commit_list,
 };
diff --git a/libsemanage/src/booleans_file.c b/libsemanage/src/booleans_file.c
index 6d600bbc..dae42ffb 100644
--- a/libsemanage/src/booleans_file.c
+++ b/libsemanage/src/booleans_file.c
@@ -101,7 +101,7 @@ static int bool_parse(semanage_handle_t * handle,
 }
 
 /* BOOL RECORD: FILE extension: method table */
-record_file_table_t SEMANAGE_BOOL_FILE_RTABLE = {
+static record_file_table_t SEMANAGE_BOOL_FILE_RTABLE = {
 	.parse = bool_parse,
 	.print = bool_print,
 };
diff --git a/libsemanage/src/booleans_policydb.c b/libsemanage/src/booleans_policydb.c
index 26fcac0a..e838c3eb 100644
--- a/libsemanage/src/booleans_policydb.c
+++ b/libsemanage/src/booleans_policydb.c
@@ -36,7 +36,7 @@ typedef struct dbase_policydb dbase_t;
 #include "semanage_store.h"
 
 /* BOOLEAN RECRORD (SEPOL): POLICYDB extension: method table */
-record_policydb_table_t SEMANAGE_BOOL_POLICYDB_RTABLE = {
+static record_policydb_table_t SEMANAGE_BOOL_POLICYDB_RTABLE = {
 	.add = NULL,
 	.modify = NULL,
 /* FIXME: these casts depend on structs in libsepol matching structs
diff --git a/libsemanage/src/fcontexts_file.c b/libsemanage/src/fcontexts_file.c
index f3579410..16380fe3 100644
--- a/libsemanage/src/fcontexts_file.c
+++ b/libsemanage/src/fcontexts_file.c
@@ -158,7 +158,7 @@ static int fcontext_parse(semanage_handle_t * handle,
 }
 
 /* FCONTEXT RECORD: FILE extension: method table */
-record_file_table_t SEMANAGE_FCONTEXT_FILE_RTABLE = {
+static record_file_table_t SEMANAGE_FCONTEXT_FILE_RTABLE = {
 	.parse = fcontext_parse,
 	.print = fcontext_print,
 };
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 9e2fe453..61c95f34 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -130,7 +130,7 @@ typedef struct IgnoreDir {
 	char *dir;
 } ignoredir_t;
 
-ignoredir_t *ignore_head = NULL;
+static ignoredir_t *ignore_head = NULL;
 
 static void ignore_free(void) {
 	ignoredir_t *next;
diff --git a/libsemanage/src/ibendports_file.c b/libsemanage/src/ibendports_file.c
index 2fa2a67c..8ae02a9c 100644
--- a/libsemanage/src/ibendports_file.c
+++ b/libsemanage/src/ibendports_file.c
@@ -129,7 +129,7 @@ err:
 }
 
 /* IBENDPORT RECORD: FILE extension: method table */
-record_file_table_t SEMANAGE_IBENDPORT_FILE_RTABLE = {
+static record_file_table_t SEMANAGE_IBENDPORT_FILE_RTABLE = {
 	.parse = ibendport_parse,
 	.print = ibendport_print,
 };
diff --git a/libsemanage/src/ibendports_policydb.c b/libsemanage/src/ibendports_policydb.c
index 1029810e..67c4e905 100644
--- a/libsemanage/src/ibendports_policydb.c
+++ b/libsemanage/src/ibendports_policydb.c
@@ -30,7 +30,7 @@ typedef struct dbase_policydb dbase_t;
 #include "semanage_store.h"
 
 /* IBENDPORT RECORD (SEPOL): POLICYDB extension : method table */
-record_policydb_table_t SEMANAGE_IBENDPORT_POLICYDB_RTABLE = {
+static record_policydb_table_t SEMANAGE_IBENDPORT_POLICYDB_RTABLE = {
 	.add = NULL,
 	.modify = (record_policydb_table_modify_t)sepol_ibendport_modify,
 	.set = NULL,
diff --git a/libsemanage/src/ibpkeys_file.c b/libsemanage/src/ibpkeys_file.c
index edde69f0..a45c6d3f 100644
--- a/libsemanage/src/ibpkeys_file.c
+++ b/libsemanage/src/ibpkeys_file.c
@@ -153,7 +153,7 @@ err:
 }
 
 /* IBPKEY RECORD: FILE extension: method table */
-record_file_table_t SEMANAGE_IBPKEY_FILE_RTABLE = {
+static record_file_table_t SEMANAGE_IBPKEY_FILE_RTABLE = {
 	.parse = ibpkey_parse,
 	.print = ibpkey_print,
 };
diff --git a/libsemanage/src/ibpkeys_policydb.c b/libsemanage/src/ibpkeys_policydb.c
index 8d73cf6f..ac16bcb6 100644
--- a/libsemanage/src/ibpkeys_policydb.c
+++ b/libsemanage/src/ibpkeys_policydb.c
@@ -30,7 +30,7 @@ typedef struct dbase_policydb dbase_t;
 #include "semanage_store.h"
 
 /* PKEY RECORD (SEPOL): POLICYDB extension : method table */
-record_policydb_table_t SEMANAGE_IBPKEY_POLICYDB_RTABLE = {
+static record_policydb_table_t SEMANAGE_IBPKEY_POLICYDB_RTABLE = {
 	.add = NULL,
 	.modify = (record_policydb_table_modify_t)sepol_ibpkey_modify,
 	.set = NULL,
diff --git a/libsemanage/src/interfaces_file.c b/libsemanage/src/interfaces_file.c
index 244f0ae5..29badb54 100644
--- a/libsemanage/src/interfaces_file.c
+++ b/libsemanage/src/interfaces_file.c
@@ -145,7 +145,7 @@ static int iface_parse(semanage_handle_t * handle,
 }
 
 /* IFACE RECORD: FILE extension: method table */
-record_file_table_t SEMANAGE_IFACE_FILE_RTABLE = {
+static record_file_table_t SEMANAGE_IFACE_FILE_RTABLE = {
 	.parse = iface_parse,
 	.print = iface_print,
 };
diff --git a/libsemanage/src/interfaces_policydb.c b/libsemanage/src/interfaces_policydb.c
index 552ce7d5..8a02751a 100644
--- a/libsemanage/src/interfaces_policydb.c
+++ b/libsemanage/src/interfaces_policydb.c
@@ -36,7 +36,7 @@ typedef struct dbase_policydb dbase_t;
 #include "semanage_store.h"
 
 /* INTERFACE RECRORD (SEPOL): POLICYDB extension: method table */
-record_policydb_table_t SEMANAGE_IFACE_POLICYDB_RTABLE = {
+static record_policydb_table_t SEMANAGE_IFACE_POLICYDB_RTABLE = {
 	.add = NULL,
 	.modify = (record_policydb_table_modify_t) sepol_iface_modify,
 	.set = NULL,
diff --git a/libsemanage/src/nodes_file.c b/libsemanage/src/nodes_file.c
index 2d2b7fe0..e6e108cb 100644
--- a/libsemanage/src/nodes_file.c
+++ b/libsemanage/src/nodes_file.c
@@ -154,7 +154,7 @@ static int node_parse(semanage_handle_t * handle,
 }
 
 /* NODE RECORD: FILE extension: method table */
-record_file_table_t SEMANAGE_NODE_FILE_RTABLE = {
+static record_file_table_t SEMANAGE_NODE_FILE_RTABLE = {
 	.parse = node_parse,
 	.print = node_print,
 };
diff --git a/libsemanage/src/nodes_policydb.c b/libsemanage/src/nodes_policydb.c
index 7224f008..23464cf6 100644
--- a/libsemanage/src/nodes_policydb.c
+++ b/libsemanage/src/nodes_policydb.c
@@ -35,7 +35,7 @@ typedef struct dbase_policydb dbase_t;
 #include "semanage_store.h"
 
 /* NODE RECORD (SEPOL): POLICYDB extension : method table */
-record_policydb_table_t SEMANAGE_NODE_POLICYDB_RTABLE = {
+static record_policydb_table_t SEMANAGE_NODE_POLICYDB_RTABLE = {
 	.add = NULL,
 	.modify = (record_policydb_table_modify_t) sepol_node_modify,
 	.set = NULL,
diff --git a/libsemanage/src/ports_file.c b/libsemanage/src/ports_file.c
index 90909eb4..6158cb63 100644
--- a/libsemanage/src/ports_file.c
+++ b/libsemanage/src/ports_file.c
@@ -161,7 +161,7 @@ static int port_parse(semanage_handle_t * handle,
 }
 
 /* PORT RECORD: FILE extension: method table */
-record_file_table_t SEMANAGE_PORT_FILE_RTABLE = {
+static record_file_table_t SEMANAGE_PORT_FILE_RTABLE = {
 	.parse = port_parse,
 	.print = port_print,
 };
diff --git a/libsemanage/src/ports_policydb.c b/libsemanage/src/ports_policydb.c
index 37d7deb2..e7f4fc0d 100644
--- a/libsemanage/src/ports_policydb.c
+++ b/libsemanage/src/ports_policydb.c
@@ -35,7 +35,7 @@ typedef struct dbase_policydb dbase_t;
 #include "semanage_store.h"
 
 /* PORT RECORD (SEPOL): POLICYDB extension : method table */
-record_policydb_table_t SEMANAGE_PORT_POLICYDB_RTABLE = {
+static record_policydb_table_t SEMANAGE_PORT_POLICYDB_RTABLE = {
 	.add = NULL,
 	.modify = (record_policydb_table_modify_t) sepol_port_modify,
 	.set = NULL,
diff --git a/libsemanage/src/seusers_file.c b/libsemanage/src/seusers_file.c
index 21b970ac..7eb3f427 100644
--- a/libsemanage/src/seusers_file.c
+++ b/libsemanage/src/seusers_file.c
@@ -109,7 +109,7 @@ static int seuser_parse(semanage_handle_t * handle,
 }
 
 /* SEUSER RECORD: FILE extension: method table */
-record_file_table_t SEMANAGE_SEUSER_FILE_RTABLE = {
+static record_file_table_t SEMANAGE_SEUSER_FILE_RTABLE = {
 	.parse = seuser_parse,
 	.print = seuser_print,
 };
diff --git a/libsemanage/src/users_base_file.c b/libsemanage/src/users_base_file.c
index 4e4d8d9b..8fb00698 100644
--- a/libsemanage/src/users_base_file.c
+++ b/libsemanage/src/users_base_file.c
@@ -195,7 +195,7 @@ static int user_base_parse(semanage_handle_t * handle,
 }
 
 /* USER BASE record: FILE extension: method table */
-record_file_table_t SEMANAGE_USER_BASE_FILE_RTABLE = {
+static record_file_table_t SEMANAGE_USER_BASE_FILE_RTABLE = {
 	.parse = user_base_parse,
 	.print = user_base_print,
 };
diff --git a/libsemanage/src/users_base_policydb.c b/libsemanage/src/users_base_policydb.c
index b42279c8..2e2ea522 100644
--- a/libsemanage/src/users_base_policydb.c
+++ b/libsemanage/src/users_base_policydb.c
@@ -35,7 +35,7 @@ typedef struct dbase_policydb dbase_t;
 #include "semanage_store.h"
 
 /* USER BASE record: POLICYDB extension: method table */
-record_policydb_table_t SEMANAGE_USER_BASE_POLICYDB_RTABLE = {
+static record_policydb_table_t SEMANAGE_USER_BASE_POLICYDB_RTABLE = {
 	.add = NULL,
 	.modify = (record_policydb_table_modify_t) sepol_user_modify,
 	.set = NULL,
diff --git a/libsemanage/src/users_extra_file.c b/libsemanage/src/users_extra_file.c
index 7aa9df3c..b3a15da2 100644
--- a/libsemanage/src/users_extra_file.c
+++ b/libsemanage/src/users_extra_file.c
@@ -100,7 +100,7 @@ static int user_extra_parse(semanage_handle_t * handle,
 }
 
 /* USER EXTRA RECORD: FILE extension: method table */
-record_file_table_t SEMANAGE_USER_EXTRA_FILE_RTABLE = {
+static record_file_table_t SEMANAGE_USER_EXTRA_FILE_RTABLE = {
 	.parse = user_extra_parse,
 	.print = user_extra_print,
 };
diff --git a/libsemanage/src/users_join.c b/libsemanage/src/users_join.c
index b598209f..dba96f3d 100644
--- a/libsemanage/src/users_join.c
+++ b/libsemanage/src/users_join.c
@@ -22,7 +22,7 @@ typedef struct dbase_join dbase_t;
 #include "debug.h"
 
 /* USER record: JOIN extension: method table */
-record_join_table_t SEMANAGE_USER_JOIN_RTABLE = {
+static record_join_table_t SEMANAGE_USER_JOIN_RTABLE = {
 	.join = semanage_user_join,
 	.split = semanage_user_split,
 };
-- 
2.45.2

