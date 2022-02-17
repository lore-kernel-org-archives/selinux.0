Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2902BC433F5
	for <selinux@archiver.kernel.org>; Thu, 17 Feb 2022 12:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240527AbiBQMtt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Feb 2022 07:49:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240518AbiBQMtr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Feb 2022 07:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D91662A82D9
        for <selinux@vger.kernel.org>; Thu, 17 Feb 2022 04:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645102172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=I8DStT5Go3bMBRw+89dQYITdfLLnHqPDKQ4xQZ9V79Y=;
        b=Rexq1ArIIHaDST6NLF1/DI0vQn2hoJAQVKxJuXigskD7OA8SQfCJYVf4dw1+AiVREIBuit
        2ovaOu3os/4OrHoMoFdd4OOnOQL55XRRyukCD70Ls7Rd8ZgFVT3dF3aFsLupkKdyvf3/7e
        HAKrWd5pX46axdoSEVEslcRo0PIBH9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-KM6imJdTPNGvKbl0HCFZ-A-1; Thu, 17 Feb 2022 07:49:31 -0500
X-MC-Unique: KM6imJdTPNGvKbl0HCFZ-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 282841006AA4
        for <selinux@vger.kernel.org>; Thu, 17 Feb 2022 12:49:30 +0000 (UTC)
Received: from thinkpad-work.redhat.com (unknown [10.40.194.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 711596E1FC
        for <selinux@vger.kernel.org>; Thu, 17 Feb 2022 12:49:29 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsemanage: allow spaces in user/group names
Date:   Thu, 17 Feb 2022 13:49:23 +0100
Message-Id: <20220217124923.1193874-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

"semanage login -a" accepts whitespaces in user/group name
(e.g. users/groups from Active Directory), which may lead to issues down
the line since libsemanage doesn't expect whitespaces in
/var/lib/selinux/targeted/active/seusers and other config files.

Fixes:
  Artificial but simple reproducer
  # groupadd server_admins
  # sed -i "s/^server_admins/server admins/" /etc/group
  # semanage login -a -s staff_u %server\ admins
  # semanage login -l  (or "semodule -B")
  libsemanage.parse_assert_ch: expected character ':', but found 'a' (/var/lib/selinux/targeted/active/seusers: 6):
  %server admins:staff_u:s0-s0:c0.c1023 (No such file or directory).
  libsemanage.seuser_parse: could not parse seuser record (No such file or directory).
  libsemanage.dbase_file_cache: could not cache file database (No such file or directory).
  libsemanage.enter_ro: could not enter read-only section (No such file or directory).
  FileNotFoundError: [Errno 2] No such file or directory

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/src/booleans_file.c    |  2 +-
 libsemanage/src/fcontexts_file.c   |  6 +++---
 libsemanage/src/ibendports_file.c  |  4 ++--
 libsemanage/src/ibpkeys_file.c     |  4 ++--
 libsemanage/src/interfaces_file.c  |  6 +++---
 libsemanage/src/nodes_file.c       |  8 ++++----
 libsemanage/src/parse_utils.c      |  6 +++---
 libsemanage/src/parse_utils.h      | 11 +++++------
 libsemanage/src/ports_file.c       |  4 ++--
 libsemanage/src/seusers_file.c     |  6 +++---
 libsemanage/src/users_base_file.c  |  7 +++----
 libsemanage/src/users_extra_file.c |  4 ++--
 12 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/libsemanage/src/booleans_file.c b/libsemanage/src/booleans_file.c
index f79d0b44..6d600bbc 100644
--- a/libsemanage/src/booleans_file.c
+++ b/libsemanage/src/booleans_file.c
@@ -48,7 +48,7 @@ static int bool_parse(semanage_handle_t * handle,
 		goto last;
 
 	/* Extract name */
-	if (parse_fetch_string(handle, info, &str, '=') < 0)
+	if (parse_fetch_string(handle, info, &str, '=', 0) < 0)
 		goto err;
 
 	if (semanage_bool_set_name(handle, boolean, str) < 0)
diff --git a/libsemanage/src/fcontexts_file.c b/libsemanage/src/fcontexts_file.c
index 04cd365a..f3579410 100644
--- a/libsemanage/src/fcontexts_file.c
+++ b/libsemanage/src/fcontexts_file.c
@@ -90,7 +90,7 @@ static int fcontext_parse(semanage_handle_t * handle,
 		goto last;
 
 	/* Regexp */
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (semanage_fcontext_set_expr(handle, fcontext, str) < 0)
 		goto err;
@@ -100,7 +100,7 @@ static int fcontext_parse(semanage_handle_t * handle,
 	/* Type */
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (!strcasecmp(str, "-s"))
 		semanage_fcontext_set_type(fcontext, SEMANAGE_FCONTEXT_SOCK);
@@ -124,7 +124,7 @@ static int fcontext_parse(semanage_handle_t * handle,
 	/* Context */
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 
       process_context:
diff --git a/libsemanage/src/ibendports_file.c b/libsemanage/src/ibendports_file.c
index bafa8c1d..2fa2a67c 100644
--- a/libsemanage/src/ibendports_file.c
+++ b/libsemanage/src/ibendports_file.c
@@ -75,7 +75,7 @@ static int ibendport_parse(semanage_handle_t *handle,
 		goto err;
 
 	/* IB Device Name */
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (semanage_ibendport_set_ibdev_name(handle, ibendport, str) < 0)
 		goto err;
@@ -92,7 +92,7 @@ static int ibendport_parse(semanage_handle_t *handle,
 	/* context */
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (semanage_context_from_string(handle, str, &con) < 0) {
 		ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
diff --git a/libsemanage/src/ibpkeys_file.c b/libsemanage/src/ibpkeys_file.c
index 929bc31e..edde69f0 100644
--- a/libsemanage/src/ibpkeys_file.c
+++ b/libsemanage/src/ibpkeys_file.c
@@ -80,7 +80,7 @@ static int ibpkey_parse(semanage_handle_t *handle,
 		goto err;
 
 	/* Subnet Prefix */
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (semanage_ibpkey_set_subnet_prefix(handle, ibpkey, str) < 0)
 		goto err;
@@ -115,7 +115,7 @@ static int ibpkey_parse(semanage_handle_t *handle,
 		semanage_ibpkey_set_pkey(ibpkey, low);
 	}
 	/* Pkey context */
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (semanage_context_from_string(handle, str, &con) < 0) {
 		ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
diff --git a/libsemanage/src/interfaces_file.c b/libsemanage/src/interfaces_file.c
index c19c8f94..244f0ae5 100644
--- a/libsemanage/src/interfaces_file.c
+++ b/libsemanage/src/interfaces_file.c
@@ -72,7 +72,7 @@ static int iface_parse(semanage_handle_t * handle,
 		goto err;
 
 	/* Name */
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (semanage_iface_set_name(handle, iface, str) < 0)
 		goto err;
@@ -82,7 +82,7 @@ static int iface_parse(semanage_handle_t * handle,
 	/* Interface context */
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (semanage_context_from_string(handle, str, &con) < 0) {
 		ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
@@ -106,7 +106,7 @@ static int iface_parse(semanage_handle_t * handle,
 	/* Message context */
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (semanage_context_from_string(handle, str, &con) < 0) {
 		ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
diff --git a/libsemanage/src/nodes_file.c b/libsemanage/src/nodes_file.c
index c3647f2a..2d2b7fe0 100644
--- a/libsemanage/src/nodes_file.c
+++ b/libsemanage/src/nodes_file.c
@@ -77,7 +77,7 @@ static int node_parse(semanage_handle_t * handle,
 		goto err;
 
 	/* Protocol */
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (!strcasecmp(str, "ipv4"))
 		proto = SEMANAGE_PROTO_IP4;
@@ -96,7 +96,7 @@ static int node_parse(semanage_handle_t * handle,
 	/* Address */
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (semanage_node_set_addr(handle, node, proto, str) < 0)
 		goto err;
@@ -106,7 +106,7 @@ static int node_parse(semanage_handle_t * handle,
 	str = NULL;
 
 	/* Netmask */
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (semanage_node_set_mask(handle, node, proto, str) < 0)
 		goto err;
@@ -116,7 +116,7 @@ static int node_parse(semanage_handle_t * handle,
 	str = NULL;
 
 	/* Port context */
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (semanage_context_from_string(handle, str, &con) < 0) {
 		ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
diff --git a/libsemanage/src/parse_utils.c b/libsemanage/src/parse_utils.c
index 4fb54fc3..918dee43 100644
--- a/libsemanage/src/parse_utils.c
+++ b/libsemanage/src/parse_utils.c
@@ -239,7 +239,7 @@ int parse_fetch_int(semanage_handle_t * handle,
 	char *test = NULL;
 	int value = 0;
 
-	if (parse_fetch_string(handle, info, &str, delim) < 0)
+	if (parse_fetch_string(handle, info, &str, delim, 0) < 0)
 		goto err;
 
 	if (!isdigit((int)*str)) {
@@ -267,7 +267,7 @@ int parse_fetch_int(semanage_handle_t * handle,
 }
 
 int parse_fetch_string(semanage_handle_t * handle,
-		       parse_info_t * info, char **str, char delim)
+		       parse_info_t * info, char **str, char delim, int allow_spaces)
 {
 
 	char *start = info->ptr;
@@ -277,7 +277,7 @@ int parse_fetch_string(semanage_handle_t * handle,
 	if (parse_assert_noeof(handle, info) < 0)
 		goto err;
 
-	while (*(info->ptr) && !isspace(*(info->ptr)) &&
+	while (*(info->ptr) && (allow_spaces || !isspace(*(info->ptr))) &&
 	       (*(info->ptr) != delim)) {
 		info->ptr++;
 		len++;
diff --git a/libsemanage/src/parse_utils.h b/libsemanage/src/parse_utils.h
index 0f334860..3e44aca1 100644
--- a/libsemanage/src/parse_utils.h
+++ b/libsemanage/src/parse_utils.h
@@ -71,12 +71,11 @@ extern int parse_optional_str(parse_info_t * info, const char *str);
 int parse_fetch_int(semanage_handle_t * hgandle,
 		    parse_info_t * info, int *num, char delim);
 
-/* Extract the next string (delimited by 
- * whitespace), and move the read pointer past it.
- * Stop of the optional character delim is encountered,
- * or if whitespace/eof is encountered. Fail if the
- * string is of length 0. */
+/* Extract the next string and move the read pointer past it.
+ * Stop if the optional character delim (or eof) is encountered,
+ * or if whitespace is encountered and allow_spaces is 0.
+ * Fail if the string is of length 0. */
 extern int parse_fetch_string(semanage_handle_t * handle,
-			      parse_info_t * info, char **str_ptr, char delim);
+			      parse_info_t * info, char **str_ptr, char delim, int allow_spaces);
 
 #endif
diff --git a/libsemanage/src/ports_file.c b/libsemanage/src/ports_file.c
index ade4102f..1356021a 100644
--- a/libsemanage/src/ports_file.c
+++ b/libsemanage/src/ports_file.c
@@ -77,7 +77,7 @@ static int port_parse(semanage_handle_t * handle,
 		goto err;
 
 	/* Protocol */
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (!strcasecmp(str, "tcp"))
 		semanage_port_set_proto(port, SEMANAGE_PROTO_TCP);
@@ -123,7 +123,7 @@ static int port_parse(semanage_handle_t * handle,
 		semanage_port_set_port(port, low);
 
 	/* Port context */
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (semanage_context_from_string(handle, str, &con) < 0) {
 		ERR(handle, "invalid security context \"%s\" (%s: %u)\n%s",
diff --git a/libsemanage/src/seusers_file.c b/libsemanage/src/seusers_file.c
index 910bedf4..21b970ac 100644
--- a/libsemanage/src/seusers_file.c
+++ b/libsemanage/src/seusers_file.c
@@ -53,7 +53,7 @@ static int seuser_parse(semanage_handle_t * handle,
 		goto last;
 
 	/* Extract name */
-	if (parse_fetch_string(handle, info, &str, ':') < 0)
+	if (parse_fetch_string(handle, info, &str, ':', 1) < 0)
 		goto err;
 	if (semanage_seuser_set_name(handle, seuser, str) < 0)
 		goto err;
@@ -68,7 +68,7 @@ static int seuser_parse(semanage_handle_t * handle,
 		goto err;
 
 	/* Extract sename */
-	if (parse_fetch_string(handle, info, &str, ':') < 0)
+	if (parse_fetch_string(handle, info, &str, ':', 1) < 0)
 		goto err;
 	if (semanage_seuser_set_sename(handle, seuser, str) < 0)
 		goto err;
@@ -83,7 +83,7 @@ static int seuser_parse(semanage_handle_t * handle,
 		goto err;
 
 	/* NOTE: does not allow spaces/multiline */
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 
 	if (semanage_seuser_set_mlsrange(handle, seuser, str) < 0)
diff --git a/libsemanage/src/users_base_file.c b/libsemanage/src/users_base_file.c
index 0f0a8fdb..a0f8cd7e 100644
--- a/libsemanage/src/users_base_file.c
+++ b/libsemanage/src/users_base_file.c
@@ -83,7 +83,7 @@ static int user_base_parse(semanage_handle_t * handle,
 		goto err;
 
 	/* Parse user name */
-	if (parse_fetch_string(handle, info, &name_str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &name_str, ' ', 0) < 0)
 		goto err;
 
 	if (semanage_user_base_set_name(handle, user, name_str) < 0) {
@@ -150,7 +150,7 @@ static int user_base_parse(semanage_handle_t * handle,
 		goto err;
 
 	/* NOTE: does not allow spaces/multiline */
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (semanage_user_base_set_mlslevel(handle, user, str) < 0)
 		goto err;
@@ -165,8 +165,7 @@ static int user_base_parse(semanage_handle_t * handle,
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
 
-	/* NOTE: does not allow spaces/multiline */
-	if (parse_fetch_string(handle, info, &str, ';') < 0)
+	if (parse_fetch_string(handle, info, &str, ';', 1) < 0)
 		goto err;
 	if (semanage_user_base_set_mlsrange(handle, user, str) < 0)
 		goto err;
diff --git a/libsemanage/src/users_extra_file.c b/libsemanage/src/users_extra_file.c
index 8f2bebd6..7aa9df3c 100644
--- a/libsemanage/src/users_extra_file.c
+++ b/libsemanage/src/users_extra_file.c
@@ -57,7 +57,7 @@ static int user_extra_parse(semanage_handle_t * handle,
 		goto err;
 
 	/* Extract name */
-	if (parse_fetch_string(handle, info, &str, ' ') < 0)
+	if (parse_fetch_string(handle, info, &str, ' ', 0) < 0)
 		goto err;
 	if (semanage_user_extra_set_name(handle, user_extra, str) < 0)
 		goto err;
@@ -73,7 +73,7 @@ static int user_extra_parse(semanage_handle_t * handle,
 		goto err;
 
 	/* Extract prefix */
-	if (parse_fetch_string(handle, info, &str, ';') < 0)
+	if (parse_fetch_string(handle, info, &str, ';', 1) < 0)
 		goto err;
 	if (semanage_user_extra_set_prefix(handle, user_extra, str) < 0)
 		goto err;
-- 
2.30.2

