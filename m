Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3E7C352A2
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 13:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28D9214AF
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 13:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Luc/GVIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgBFNNC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:13:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35136 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727325AbgBFNNC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 08:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580994781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nU82ZHZptAFpbrkz0dlfioRCEDi4mgbZvbBpHkPRli0=;
        b=Luc/GVIwT7SoTUDFPBF2ZNF/Yrn8X4YsZ12SW3caaOXSaXRuNtxxF25rrTRiBvoh0DXdCK
        ks9zolApQEUsNNgjomwyCudX3gOAE+EbDJLtfR4Daz3wVvFBHHa4D0caYofZ4/aqqN8tjW
        iyH5qxC4EMH7O5L9IcEzBN2sc01hT0o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-CNS6OKYCNjqySQpifVzdOw-1; Thu, 06 Feb 2020 08:12:58 -0500
X-MC-Unique: CNS6OKYCNjqySQpifVzdOw-1
Received: by mail-wm1-f69.google.com with SMTP id m4so2600742wmi.5
        for <selinux@vger.kernel.org>; Thu, 06 Feb 2020 05:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nU82ZHZptAFpbrkz0dlfioRCEDi4mgbZvbBpHkPRli0=;
        b=YYi78+iKQDbVHMerqQGacjQNN/N8w7d1MOxt5UtYG92S1nvbULqxQdWpXKfqNZlMNU
         gJG1bxx1pp4h0GaaGxkThxjvyivi8Kpl/eKfmF2ebgNfatRFfpo2KtJZLOCSMpnHmY2T
         8qboC3U/Y5RqqTOzxl6HerFsFhbMndpoO1S6jpJpVEOwCUMmkOSeyIhYScIAVOq++6ii
         ytsbg2jE0HaQed1gWNulawaqXCLzJsXl8p3sSYIcfTj4FHxw97qU6a6jcWKAhpOYd5HD
         uYdtNRzYrUH5W4jaVgN0AEul3jenGQH5PN32tKZceYzcMHRabPMBRz+5g+DQ3b1o9YcY
         M60g==
X-Gm-Message-State: APjAAAU6xorxRaMI8DXThqbSuXWn5Ff44jXdtDiRoyUBPJxO7+zTKt9T
        jarSANqYnPCzrZtSN9QwuErR0KzuFYQjKwR39VDl5mrofAJY8c6UocnZmc6ZYCBOiAQYaBoGq1h
        zdc1kdc+8xiR0TCYHqA==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr4629047wmb.80.1580994777010;
        Thu, 06 Feb 2020 05:12:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwoiQPrYBa4JRdxl8CEmtWxr14K8dPlemRHZS4N3t3098cfpTVvnC8FY3f4r6M7PTcqn36CGw==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr4629011wmb.80.1580994776605;
        Thu, 06 Feb 2020 05:12:56 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h13sm4506472wrw.54.2020.02.06.05.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 05:12:55 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [RFC PATCH 1/2] libsemanage: support changing policy version via API
Date:   Thu,  6 Feb 2020 14:12:52 +0100
Message-Id: <20200206131253.535302-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206131253.535302-1-omosnace@redhat.com>
References: <20200206131253.535302-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This change will be needed to support explicly specifying the policy
version in semodule (in a subsequent patch).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsemanage/include/semanage/handle.h |  6 +++
 libsemanage/src/direct_api.c          |  9 ++++-
 libsemanage/src/handle.c              | 24 ++++++++++++
 libsemanage/src/handle.h              |  1 +
 libsemanage/src/libsemanage.map       |  6 +++
 libsemanage/src/semanage_store.c      | 54 ++++++++++++++++-----------
 libsemanage/src/semanage_store.h      |  6 ++-
 7 files changed, 81 insertions(+), 25 deletions(-)

diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
index 946d69bc..70b37863 100644
--- a/libsemanage/include/semanage/handle.h
+++ b/libsemanage/include/semanage/handle.h
@@ -85,6 +85,12 @@ extern void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disab
 /* Set whether or not to execute setfiles to check file contexts upon commit */
 extern void semanage_set_check_contexts(semanage_handle_t * sh, int do_check_contexts);
 
+/* Get the kernel policy version. */
+extern unsigned semanage_get_policyvers(semanage_handle_t *sh);
+
+/* Set the kernel policy version. */
+extern int semanage_set_policyvers(semanage_handle_t *sh, unsigned policyvers);
+
 /* Get the default priority. */
 extern uint16_t semanage_get_default_priority(semanage_handle_t *sh);
 
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 1088a0ac..78c40018 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1204,6 +1204,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	size_t fc_buffer_len = 0;
 	const char *ofilename = NULL;
 	const char *path;
+	char kernel_path[PATH_MAX];
 	int retval = -1, num_modinfos = 0, i;
 	sepol_policydb_t *out = NULL;
 	struct cil_db *cildb = NULL;
@@ -1593,9 +1594,13 @@ rebuild:
 	if (retval < 0)
 		goto cleanup;
 
+	if (semanage_get_full_kernel_path(sh, SEMANAGE_FINAL_TMP, kernel_path)) {
+		ERR(sh, "Unable to build path to kernel policy.");
+		goto cleanup;
+	}
+
 	retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_KERNEL),
-			semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_KERNEL),
-			sh->conf->file_mode);
+			kernel_path, sh->conf->file_mode);
 	if (retval < 0) {
 		goto cleanup;
 	}
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 5e59aef7..78818930 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -81,6 +81,9 @@ semanage_handle_t *semanage_handle_create(void)
 		goto err;
 	sepol_msg_set_callback(sh->sepolh, semanage_msg_relay_handler, sh);
 
+	/* Default policy version is taken from config */
+	sh->policyvers = sh->conf->policyvers;
+
 	/* Default priority is 400 */
 	sh->priority = 400;
 
@@ -246,6 +249,27 @@ void semanage_set_check_contexts(semanage_handle_t * sh, int do_check_contexts)
 	return;
 }
 
+unsigned semanage_get_policyvers(semanage_handle_t *sh)
+{
+	assert(sh != NULL);
+	return sh->policyvers;
+}
+
+int semanage_set_policyvers(semanage_handle_t *sh, unsigned policyvers)
+{
+	assert(sh != NULL);
+
+	/* Verify policy version */
+	if (   policyvers < POLICYDB_VERSION_MIN
+	    || policyvers > POLICYDB_VERSION_MAX) {
+		ERR(sh, "Policy version %u is invalid.", policyvers);
+		return -1;
+	}
+
+	sh->policyvers = policyvers;
+	return 0;
+}
+
 uint16_t semanage_get_default_priority(semanage_handle_t *sh)
 {
 	assert(sh != NULL);
diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
index a91907b0..ee389226 100644
--- a/libsemanage/src/handle.h
+++ b/libsemanage/src/handle.h
@@ -57,6 +57,7 @@ struct semanage_handle {
 
 	semanage_conf_t *conf;
 
+	unsigned policyvers;
 	uint16_t priority;
 	int is_connected;
 	int is_in_transaction;
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 02036696..8c05b9ad 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -63,3 +63,9 @@ LIBSEMANAGE_1.1 {
 	  semanage_module_remove_key;
 	  semanage_set_store_root;
 } LIBSEMANAGE_1.0;
+
+LIBSEMANAGE_1.2 {
+  global:
+	  semanage_get_policyvers;
+	  semanage_set_policyvers;
+} LIBSEMANAGE_1.1;
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 58dded6e..52217be7 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -277,9 +277,7 @@ cleanup:
 
 static int semanage_init_final_suffix(semanage_handle_t *sh)
 {
-	int ret = 0;
 	int status = 0;
-	char path[PATH_MAX];
 	size_t offset = strlen(selinux_policy_root());
 
 	semanage_final_suffix[SEMANAGE_FINAL_TOPLEVEL] = strdup("");
@@ -350,19 +348,9 @@ static int semanage_init_final_suffix(semanage_handle_t *sh)
 		goto cleanup;
 	}
 
-	ret = snprintf(path,
-		       sizeof(path),
-		       "%s.%d",
-		       selinux_binary_policy_path() + offset,
-		       sh->conf->policyvers);
-	if (ret < 0 || ret >= (int)sizeof(path)) {
-		ERR(sh, "Unable to compose policy binary path.");
-		status = -1;
-		goto cleanup;
-	}
-
-	semanage_final_suffix[SEMANAGE_KERNEL] = strdup(path);
-	if (semanage_final_suffix[SEMANAGE_KERNEL] == NULL) {
+	semanage_final_suffix[SEMANAGE_KERNEL_PREFIX] =
+		strdup(selinux_binary_policy_path() + offset);
+	if (semanage_final_suffix[SEMANAGE_KERNEL_PREFIX] == NULL) {
 		ERR(sh, "Unable to allocate space for policy binary path.");
 		status = -1;
 		goto cleanup;
@@ -503,6 +491,20 @@ const char *semanage_final_path(enum semanage_final_defs store,
 	return semanage_final_paths[store][path_name];
 }
 
+/* Return a fully-qualified path + filename to kernel policy for the given
+ * semanage store.
+ */
+int semanage_get_full_kernel_path(semanage_handle_t * sh,
+				  enum semanage_final_defs root,
+				  char out[PATH_MAX])
+{
+	int ret = snprintf(out, PATH_MAX, "%s.%u",
+			   semanage_final_path(root, SEMANAGE_KERNEL_PREFIX),
+			   sh->policyvers);
+
+	return ret < 0 || ret >= PATH_MAX ? -1 : 0;
+}
+
 /* Return a fully-qualified path + filename to the semanage
  * configuration file. If semanage.conf file in the semanage
  * root is cannot be read, use the default semanage.conf as a
@@ -1568,12 +1570,16 @@ static int semanage_validate_and_compile_fcontexts(semanage_handle_t * sh)
 	int status = -1;
 
 	if (sh->do_check_contexts) {
+		char path[PATH_MAX];
 		int ret;
+
+		if (semanage_get_full_kernel_path(sh, SEMANAGE_FINAL_TMP, path)) {
+			ERR(sh, "Unable to build path to kernel policy.");
+			goto cleanup;
+		}
+
 		ret = semanage_exec_prog(
-			sh,
-			sh->conf->setfiles,
-			semanage_final_path(SEMANAGE_FINAL_TMP,
-					    SEMANAGE_KERNEL),
+			sh, sh->conf->setfiles, path,
 			semanage_final_path(SEMANAGE_FINAL_TMP,
 					    SEMANAGE_FC));
 		if (ret != 0) {
@@ -2233,15 +2239,19 @@ int semanage_verify_linked(semanage_handle_t * sh)
 int semanage_verify_kernel(semanage_handle_t * sh)
 {
 	int retval = -1;
-	const char *kernel_filename =
-	    semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_KERNEL);
+	char path[PATH_MAX];
 	semanage_conf_t *conf = sh->conf;
 	external_prog_t *e;
+
 	if (conf->kernel_prog == NULL) {
 		return 0;
 	}
+	if (semanage_get_full_kernel_path(sh, SEMANAGE_FINAL_TMP, path)) {
+		ERR(sh, "Unable to build path to kernel policy.");
+		goto cleanup;
+	}
 	for (e = conf->kernel_prog; e != NULL; e = e->next) {
-		if (semanage_exec_prog(sh, e, kernel_filename, "$<") != 0) {
+		if (semanage_exec_prog(sh, e, path, "$<") != 0) {
 			goto cleanup;
 		}
 	}
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index 34bf8523..d5567782 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -81,7 +81,7 @@ enum semanage_final_path_defs {
 	SEMANAGE_FC_HOMEDIRS_BIN,
 	SEMANAGE_FC_LOCAL,
 	SEMANAGE_FC_LOCAL_BIN,
-	SEMANAGE_KERNEL,
+	SEMANAGE_KERNEL_PREFIX,
 	SEMANAGE_NC,
 	SEMANAGE_SEUSERS,
 	SEMANAGE_FINAL_PATH_NUM
@@ -102,6 +102,10 @@ extern const char *semanage_path(enum semanage_store_defs store,
 extern const char *semanage_final_path(enum semanage_final_defs root,
 				       enum semanage_final_path_defs suffix);
 
+int semanage_get_full_kernel_path(semanage_handle_t * sh,
+				  enum semanage_final_defs root,
+				  char out[PATH_MAX]);
+
 int semanage_create_store(semanage_handle_t * sh, int create);
 
 int semanage_store_access_check(void);
-- 
2.24.1

