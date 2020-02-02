Return-Path: <SRS0=qlmh=3W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69FAC35249
	for <selinux@archiver.kernel.org>; Sun,  2 Feb 2020 19:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2F520679
	for <selinux@archiver.kernel.org>; Sun,  2 Feb 2020 19:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="CEI5nV7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgBBTfQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Feb 2020 14:35:16 -0500
Received: from mailomta4-sa.btinternet.com ([213.120.69.10]:28270 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726955AbgBBTfP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Feb 2020 14:35:15 -0500
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200202193511.PIVP7916.sa-prd-fep-048.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Sun, 2 Feb 2020 19:35:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1580672111; 
        bh=PHcNAbrqGAPI4MhmoYTUfct8MQfpXIKmXM1rbi9+9as=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=CEI5nV7sem/LyN/gNZb0UqhSiEPVR6XHajz2dD7wE5dIrU+8h8TdwE/H1Ms++5uulyxARXoRhVCfW1Yt3I652SAfZENguMBpne8CCYT/yONSjab0M6I3UnFUveeP4Tc8EiimP/rgD4TTnXBuUNTOB3J8nq9LxeC6llb9SCyaM/9uyxjzlB/Ud82JCYM7dJL43d3aSoRAeJE8rjOkgafYDTMgwjR1RynLjJEx/TNBa6AhwOK7vzYpuJEe5MOoWnoFMOPqk/N9QdACJkXVhShuzpDlqPhxna0m/PNMmWV767dL973VGd0cScwOkQYz9NOfyLUyqqFbBOjTJKJ7/SbpAw==
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.49.56.38]
X-OWM-Source-IP: 31.49.56.38 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrgeehgdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepfedurdegledrheeirdefkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledrheeirdefkedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.56.38) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5E1A3066036A6694; Sun, 2 Feb 2020 19:35:11 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     dhowells@redhat.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 1/1] selinux-testsuite: Add additional key permission tests
Date:   Sun,  2 Feb 2020 19:35:08 +0000
Message-Id: <20200202193508.15056-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200202193508.15056-1-richard_c_haines@btinternet.com>
References: <20200202193508.15056-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Tests the new inval, revoke, join and clear permissions associated
with the key class that were added in kernel 5.x.

Note: These tests require a kernel patch (for key perms + policy
capability "key_perms"), and a libsepol patch.

Permissions overview:
The current "setattr" perm name remains and is used for KEY_NEED_SETSEC.
This gives the following permissions for the 'key' class:
create	Create a key or keyring.
view	View attributes.
read	Read contents.
write	Update or modify.
search	Search (keyring) or find (key).
link	Link a key into the keyring.
setattr	kernel < 5.x Change permissions on a keyring.
	kernel >= 5.x Set owner, group, ACL.
inval	Invalidate key.
revoke	Revoke key.
join	Join keyring as session.
clear	Clear a keyring.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policy/test_keys.te          | 139 ++++++++++++++++++++++++++++-------
 tests/keys/keyctl.c          |  39 ++++++++++
 tests/keys/keyring_service.c |  12 ++-
 tests/keys/request_keys.c    |  70 ++++++++++++++----
 tests/keys/test              |  63 ++++++++++++++--
 5 files changed, 273 insertions(+), 50 deletions(-)

diff --git a/policy/test_keys.te b/policy/test_keys.te
index 78c0663..d0c2ea1 100644
--- a/policy/test_keys.te
+++ b/policy/test_keys.te
@@ -6,9 +6,11 @@ attribute keydomain;
 #
 ############################## Define Macro ################################
 #
-# Do not use domain_type() macro as it has allow 'key { link search }'
-# in base module so 'allow domain self:key ~{ link search };' will not work
-# here. Add these instead to allow key perms to be controlled by this module.
+# Do not use domain_type() macro as it has an allow rule in base module so
+# 'allow domain self:key ~{ link search };' will not work here.
+# It is caused by the Fedora policy being built with 'hide_broken_symptoms'
+# that adds 'allow domain domain:key { link search };'
+# Use this macro instead to allow key perms to be controlled by this module.
 #
 gen_require(`
 	type setrans_var_run_t, syslogd_t;
@@ -36,7 +38,7 @@ typeattribute test_key_t testdomain;
 typeattribute test_key_t keydomain;
 
 allow test_key_t self:process { setkeycreate };
-allow test_key_t self:key { create write search read view link setattr };
+allow test_key_t self:key all_key_perms;
 
 # Set new context on a keyring:
 type test_newcon_key_t;
@@ -124,6 +126,46 @@ typeattribute test_key_no_setattr_t keydomain;
 allow test_key_no_setattr_t self:process { setkeycreate };
 allow test_key_no_setattr_t self:key { create write search read view link };
 
+###################### Deny key { inval } ###########################
+type test_key_no_inval_t;
+key_domain_type(test_key_no_inval_t)
+unconfined_runs_test(test_key_no_inval_t)
+typeattribute test_key_no_inval_t testdomain;
+typeattribute test_key_no_inval_t keydomain;
+
+allow test_key_no_inval_t self:process { setkeycreate };
+allow test_key_no_inval_t self:key { view read write search link setattr revoke clear join create };
+
+###################### Deny key { revoke } ###########################
+type test_key_no_revoke_t;
+key_domain_type(test_key_no_revoke_t)
+unconfined_runs_test(test_key_no_revoke_t)
+typeattribute test_key_no_revoke_t testdomain;
+typeattribute test_key_no_revoke_t keydomain;
+
+allow test_key_no_revoke_t self:process { setkeycreate };
+allow test_key_no_revoke_t self:key { view read write search link setattr inval clear join create };
+
+###################### Deny key { clear } ###########################
+type test_key_no_clear_t;
+key_domain_type(test_key_no_clear_t)
+unconfined_runs_test(test_key_no_clear_t)
+typeattribute test_key_no_clear_t testdomain;
+typeattribute test_key_no_clear_t keydomain;
+
+allow test_key_no_clear_t self:process { setkeycreate };
+allow test_key_no_clear_t self:key { view read write search link setattr inval revoke join create };
+
+###################### Deny key { join } ###########################
+type test_key_no_join_t;
+key_domain_type(test_key_no_join_t)
+unconfined_runs_test(test_key_no_join_t)
+typeattribute test_key_no_join_t testdomain;
+typeattribute test_key_no_join_t keydomain;
+
+allow test_key_no_join_t self:process { setkeycreate };
+allow test_key_no_join_t self:key { view read write search link setattr inval clear revoke create };
+
 #
 ############## keyring_service / request_keys process tests ###############
 #
@@ -137,17 +179,21 @@ typeattribute test_keyring_service_t testdomain;
 typeattribute test_keyring_service_t keydomain;
 
 allow test_keyring_service_t self:process { setkeycreate };
-allow test_keyring_service_t self:key { create write search read view link setattr };
+allow test_keyring_service_t self:key all_key_perms;
 
 allow test_keyring_service_t test_file_t:file execute_no_trans;
 allow test_keyring_service_t self : process { dyntransition };
-allow test_keyring_service_t test_request_keys_t:process dyntransition;
-allow test_keyring_service_t test_request_keys_no_search_t:process dyntransition;
-allow test_keyring_service_t test_request_keys_no_read_t:process dyntransition;
-allow test_keyring_service_t test_request_keys_no_write_t:process dyntransition;
-allow test_keyring_service_t test_request_keys_no_view_t:process dyntransition;
-allow test_keyring_service_t test_request_keys_no_setattr_t:process dyntransition;
-allow test_keyring_service_t test_request_keys_no_link_t:process dyntransition;
+allow test_keyring_service_t test_request_keys_t:process { dyntransition };
+allow test_keyring_service_t test_request_keys_no_search_t:process { dyntransition };
+allow test_keyring_service_t test_request_keys_no_read_t:process { dyntransition };
+allow test_keyring_service_t test_request_keys_no_write_t:process { dyntransition };
+allow test_keyring_service_t test_request_keys_no_view_t:process { dyntransition };
+allow test_keyring_service_t test_request_keys_no_setattr_t:process { dyntransition };
+allow test_keyring_service_t test_request_keys_no_link_t:process { dyntransition };
+allow test_keyring_service_t test_request_keys_no_inval_t:process { dyntransition };
+allow test_keyring_service_t test_request_keys_no_revoke_t:process { dyntransition };
+allow test_keyring_service_t test_request_keys_no_join_t:process { dyntransition };
+allow test_keyring_service_t test_request_keys_no_clear_t:process { dyntransition };
 
 ################################# request_keys ############################
 type test_request_keys_t;
@@ -156,8 +202,8 @@ unconfined_runs_test(test_request_keys_t)
 typeattribute test_request_keys_t testdomain;
 typeattribute test_request_keys_t keydomain;
 
-allow test_request_keys_t self:key { create write search read view link setattr };
-allow test_request_keys_t test_keyring_service_t:key { search read write view link setattr };
+allow test_request_keys_t self:key all_key_perms;
+allow test_request_keys_t test_keyring_service_t:key all_key_perms;
 
 ################### request_keys deny { search } ############################
 type test_request_keys_no_search_t;
@@ -166,8 +212,8 @@ unconfined_runs_test(test_request_keys_no_search_t)
 typeattribute test_request_keys_no_search_t testdomain;
 typeattribute test_request_keys_no_search_t keydomain;
 
-allow test_request_keys_no_search_t self:key { create write search read view link setattr };
-allow test_request_keys_no_search_t test_keyring_service_t:key { write link view setattr };
+allow test_request_keys_no_search_t self:key all_key_perms;
+allow test_request_keys_no_search_t test_keyring_service_t:key { write link view setattr join };
 
 ################### request_keys deny { read } ############################
 type test_request_keys_no_read_t;
@@ -176,8 +222,8 @@ unconfined_runs_test(test_request_keys_no_read_t)
 typeattribute test_request_keys_no_read_t testdomain;
 typeattribute test_request_keys_no_read_t keydomain;
 
-allow test_request_keys_no_read_t self:key { create write search read view link setattr };
-allow test_request_keys_no_read_t test_keyring_service_t:key { write search view setattr link };
+allow test_request_keys_no_read_t self:key all_key_perms;
+allow test_request_keys_no_read_t test_keyring_service_t:key { write search view setattr link join };
 
 ################### request_keys deny { write } ############################
 type test_request_keys_no_write_t;
@@ -186,8 +232,8 @@ unconfined_runs_test(test_request_keys_no_write_t)
 typeattribute test_request_keys_no_write_t testdomain;
 typeattribute test_request_keys_no_write_t keydomain;
 
-allow test_request_keys_no_write_t self:key { create write search read view link setattr };
-allow test_request_keys_no_write_t test_keyring_service_t:key { read search view setattr link };
+allow test_request_keys_no_write_t self:key all_key_perms;
+allow test_request_keys_no_write_t test_keyring_service_t:key { read search view setattr link join };
 
 ################### request_keys deny { view } ############################
 type test_request_keys_no_view_t;
@@ -196,8 +242,8 @@ unconfined_runs_test(test_request_keys_no_view_t)
 typeattribute test_request_keys_no_view_t testdomain;
 typeattribute test_request_keys_no_view_t keydomain;
 
-allow test_request_keys_no_view_t self:key { create write search read view link setattr };
-allow test_request_keys_no_view_t test_keyring_service_t:key { search write setattr link };
+allow test_request_keys_no_view_t self:key all_key_perms;
+allow test_request_keys_no_view_t test_keyring_service_t:key { search write setattr link join };
 
 ################### request_keys deny { setattr } ############################
 type test_request_keys_no_setattr_t;
@@ -206,8 +252,8 @@ unconfined_runs_test(test_request_keys_no_setattr_t)
 typeattribute test_request_keys_no_setattr_t testdomain;
 typeattribute test_request_keys_no_setattr_t keydomain;
 
-allow test_request_keys_no_setattr_t self:key { create write search read view link setattr };
-allow test_request_keys_no_setattr_t test_keyring_service_t:key { search read write link view };
+allow test_request_keys_no_setattr_t self:key all_key_perms;
+allow test_request_keys_no_setattr_t test_keyring_service_t:key { search read write link view join };
 
 ################### request_keys deny { link } ############################
 type test_request_keys_no_link_t;
@@ -216,8 +262,49 @@ unconfined_runs_test(test_request_keys_no_link_t)
 typeattribute test_request_keys_no_link_t testdomain;
 typeattribute test_request_keys_no_link_t keydomain;
 
-allow test_request_keys_no_link_t self:key { create write search read view link setattr };
-allow test_request_keys_no_link_t test_keyring_service_t:key { read write search view setattr };
+allow test_request_keys_no_link_t self:key all_key_perms;
+allow test_request_keys_no_link_t test_keyring_service_t:key { read write search view setattr join };
+
+#################### request_keys deny (inval) ############################
+type test_request_keys_no_inval_t;
+key_domain_type(test_request_keys_no_inval_t)
+unconfined_runs_test(test_request_keys_no_inval_t)
+typeattribute test_request_keys_no_inval_t testdomain;
+typeattribute test_request_keys_no_inval_t keydomain;
+
+allow test_request_keys_no_inval_t self:key all_key_perms;
+allow test_request_keys_no_inval_t test_keyring_service_t:key { search link read write view setattr join };
+
+################### request_keys deny (revoke) ############################
+type test_request_keys_no_revoke_t;
+key_domain_type(test_request_keys_no_revoke_t)
+unconfined_runs_test(test_request_keys_no_revoke_t)
+typeattribute test_request_keys_no_revoke_t testdomain;
+typeattribute test_request_keys_no_revoke_t keydomain;
+
+allow test_request_keys_no_revoke_t self:key all_key_perms;
+allow test_request_keys_no_revoke_t test_keyring_service_t:key { search link read write view setattr inval join };
+
+################### request_keys deny (join) #######################
+type test_request_keys_no_join_t;
+key_domain_type(test_request_keys_no_join_t)
+unconfined_runs_test(test_request_keys_no_join_t)
+typeattribute test_request_keys_no_join_t testdomain;
+typeattribute test_request_keys_no_join_t keydomain;
+
+allow test_request_keys_no_join_t self:key all_key_perms;
+allow test_request_keys_no_join_t test_keyring_service_t:key { search link read write view setattr inval revoke clear };
+
+##################### request_keys deny (clear) ######################
+type test_request_keys_no_clear_t;
+key_domain_type(test_request_keys_no_clear_t)
+unconfined_runs_test(test_request_keys_no_clear_t)
+typeattribute test_request_keys_no_clear_t testdomain;
+typeattribute test_request_keys_no_clear_t keydomain;
+
+allow test_request_keys_no_clear_t self:key all_key_perms;
+allow test_request_keys_no_clear_t test_keyring_service_t:key { search link read write view setattr inval revoke };
+allow test_request_keys_no_clear_t test_keyring_service_t:key { join };
 
 #
 ########### Allow these domains to be entered from sysadm domain ############
diff --git a/tests/keys/keyctl.c b/tests/keys/keyctl.c
index 5aff8d8..ea7d553 100644
--- a/tests/keys/keyctl.c
+++ b/tests/keys/keyctl.c
@@ -184,5 +184,44 @@ int main(int argc, char *argv[])
 		       timeout, type, desc);
 	}
 
+	/*
+	 * Requires key { search }
+	 * From 5.x with policycap key_perms; requires key { inval }
+	 */
+	test_key = keyctl(KEYCTL_INVALIDATE, private);
+	if (test_key < 0) {
+		fprintf(stderr, "Failed KEYCTL_INVALIDATE(private): %s\n",
+			strerror(errno));
+		exit(12);
+	}
+	if (verbose)
+		printf("Invalidated 'private' key\n");
+
+	/*
+	 * Requires key { write setattr }
+	 * From 5.x with policycap key_perms; requires key { revoke }
+	 */
+	test_key = keyctl(KEYCTL_REVOKE, prime);
+	if (test_key < 0) {
+		fprintf(stderr, "Failed KEYCTL_REVOKE(prime): %s\n",
+			strerror(errno));
+		exit(13);
+	}
+	if (verbose)
+		printf("Revoked 'prime' key\n");
+
+	/*
+	 * Requires key { write }
+	 * From 5.x with policycap key_perms; requires key { clear }
+	 */
+	test_key = keyctl(KEYCTL_CLEAR, KEY_SPEC_PROCESS_KEYRING);
+	if (test_key < 0) {
+		fprintf(stderr, "Failed KEYCTL_CLEAR(KEY_SPEC_PROCESS_KEYRING): %s\n",
+			strerror(errno));
+		exit(14);
+	}
+	if (verbose)
+		printf("Cleared 'KEY_SPEC_PROCESS_KEYRING' keyring\n");
+
 	return 0;
 }
diff --git a/tests/keys/keyring_service.c b/tests/keys/keyring_service.c
index e5dcab0..f1d7378 100644
--- a/tests/keys/keyring_service.c
+++ b/tests/keys/keyring_service.c
@@ -15,9 +15,10 @@ int main(int argc, char **argv)
 {
 	int opt, pid, result, status;
 	bool verbose;
-	char *context_s, *request_keys_argv[4] = { NULL };
+	char *context_s, *request_keys_argv[5] = { NULL };
 	context_t context;
 	key_serial_t private, prime, base, newring;
+	char newringid_str[30];
 
 	verbose = false;
 
@@ -25,7 +26,7 @@ int main(int argc, char **argv)
 		switch (opt) {
 		case 'v':
 			verbose = true;
-			request_keys_argv[2] = strdup("-v");
+			request_keys_argv[3] = strdup("-v");
 			break;
 		default:
 			usage(argv[0]);
@@ -128,11 +129,14 @@ int main(int argc, char **argv)
 		signal(SIGTRAP, SIG_IGN);
 		request_keys_argv[0] = strdup(argv[optind + 1]);
 		request_keys_argv[1] = strdup(context_s);
+		sprintf(newringid_str, "%d", newring);
+		request_keys_argv[2] = strdup(newringid_str);
 		if (verbose)
-			printf("\tExec parameters:\n\t\t%s\n\t\t%s\n\t\t%s\n",
+			printf("\tExec parameters:\n\t\t%s\n\t\t%s\n\t\t0x%x\n\t\t%s\n",
 			       request_keys_argv[0],
 			       request_keys_argv[1],
-			       request_keys_argv[2]);
+			       atoi(request_keys_argv[2]),
+			       request_keys_argv[3]);
 
 		execv(request_keys_argv[0], request_keys_argv);
 		fprintf(stderr, "execv of: %s failed: %s\n",
diff --git a/tests/keys/request_keys.c b/tests/keys/request_keys.c
index 43b20d9..eb13103 100644
--- a/tests/keys/request_keys.c
+++ b/tests/keys/request_keys.c
@@ -10,11 +10,13 @@ int main(int argc, char **argv)
 	struct keyctl_dh_params params;
 
 	/*
-	 * There are two parameters passed:
+	 * There are three parameters passed:
 	 *    1 - The security context for setcon(3)
-	 *    2 - Verbose mode
+	 *    2 - A string containing the 'newring' key ID required to
+	 *        test the { clear } permission for keyctl(KEYCTL_CLEAR).
+	 *    3 - Verbose mode
 	 */
-	if (argv[2] != NULL)
+	if (argv[3] != NULL)
 		verbose = true;
 
 	if (verbose)
@@ -28,13 +30,13 @@ int main(int argc, char **argv)
 	if (result < 0) {
 		fprintf(stderr, "setcon() failed to set process context: %s\n",
 			argv[1]);
-		exit(1);
+		exit(51);
 	}
 
 	result = getcon(&context);
 	if (result < 0) {
 		fprintf(stderr, "Failed to obtain process context\n");
-		exit(2);
+		exit(52);
 	}
 	if (verbose)
 		printf("\tProcess context:\n\t\t%s\n", context);
@@ -46,12 +48,13 @@ int main(int argc, char **argv)
 	 *    keyctl(KEYCTL_JOIN_SESSION_KEYRING, "test-session")
 	 *
 	 * Requires key { link }
+	 * From 5.x with policycap key_perms; requires key { clear }
 	 */
 	test_key = keyctl(KEYCTL_SESSION_TO_PARENT);
 	if (test_key < 0) {
 		fprintf(stderr, "Failed KEYCTL_SESSION_TO_PARENT: %s\n",
 			strerror(errno));
-		exit(3);
+		exit(53);
 	}
 
 	/* Requires key { view } */
@@ -60,7 +63,7 @@ int main(int argc, char **argv)
 	if (result < 0) {
 		fprintf(stderr, "Failed to obtain parent session context: %s\n",
 			strerror(errno));
-		exit(4);
+		exit(54);
 	}
 	if (verbose)
 		printf("\tJoined session to parent. Parent keyring context:\n\t\t%s\n",
@@ -72,21 +75,21 @@ int main(int argc, char **argv)
 	if (private < 0) {
 		fprintf(stderr, "Failed to request 'private' key: %s\n",
 			strerror(errno));
-		exit(5);
+		exit(55);
 	}
 
 	prime = request_key("user", "prime", NULL, KEY_SPEC_SESSION_KEYRING);
 	if (prime < 0) {
 		fprintf(stderr, "Failed to request 'prime' key: %s\n",
 			strerror(errno));
-		exit(5);
+		exit(55);
 	}
 
 	base = request_key("user", "base", NULL, KEY_SPEC_SESSION_KEYRING);
 	if (base < 0) {
 		fprintf(stderr, "Failed to request 'base' key: %s\n",
 			strerror(errno));
-		exit(5);
+		exit(55);
 	}
 	if (verbose) {
 		printf("\tRequested 'private' key ID: 0x%x\n", private);
@@ -99,21 +102,21 @@ int main(int argc, char **argv)
 	if (test_key < 0) {
 		fprintf(stderr, "Failed KEYCTL_SET_TIMEOUT: %s\n",
 			strerror(errno));
-		exit(6);
+		exit(56);
 	}
 	if (verbose) {
 		test_key = keyctl(KEYCTL_DESCRIBE, base, r_con, sizeof(r_con));
 		if (test_key < 0) {
 			fprintf(stderr, "Failed KEYCTL_DESCRIBE: %s\n",
 				strerror(errno));
-			exit(7);
+			exit(57);
 		}
 		result = sscanf(r_con, "%[^;];%d;%d;%x;%s",
 				type, &nr, &nr, &nr, desc);
 		if (result < 0) {
 			fprintf(stderr, "Failed sscanf(): %s\n",
 				strerror(errno));
-			exit(7);
+			exit(57);
 		}
 		printf("\tSet %d second timeout on key Type: '%s' Description: '%s'\n",
 		       timeout, type, desc);
@@ -129,10 +132,49 @@ int main(int argc, char **argv)
 	if (compute < 0) {
 		fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
 			strerror(errno));
-		exit(8);
+		exit(58);
 	}
 	if (verbose)
 		printf("\tKEYCTL_DH_COMPUTE key ID size: %d\n", compute);
 
+	/*
+	 * Requires key { search }
+	 * From 5.x with policycap key_perms; requires key { inval }
+	 */
+	test_key = keyctl(KEYCTL_INVALIDATE, base);
+	if (test_key < 0) {
+		fprintf(stderr, "Failed KEYCTL_INVALIDATE(base): %s\n",
+			strerror(errno));
+		exit(59);
+	}
+	if (verbose)
+		printf("\tInvalidated 'base' key\n");
+
+	/*
+	 * Requires key { write setattr }
+	 * From 5.x with policycap key_perms; requires key { revoke }
+	 */
+	test_key = keyctl(KEYCTL_REVOKE, prime);
+	if (test_key < 0) {
+		fprintf(stderr, "Failed KEYCTL_REVOKE(prime): %s\n",
+			strerror(errno));
+		exit(60);
+	}
+	if (verbose)
+		printf("\tRevoked 'prime' key\n");
+
+	/*
+	 * Requires key { write }
+	 * From 5.x with policycap key_perms; requires key { clear }
+	 */
+	test_key = keyctl(KEYCTL_CLEAR, atoi(argv[2]));
+	if (test_key < 0) {
+		fprintf(stderr, "Failed KEYCTL_CLEAR(newring): %s\n",
+			strerror(errno));
+		exit(61);
+	}
+	if (verbose)
+		printf("\tCleared 'newring' keyring\n");
+
 	exit(0);
 }
diff --git a/tests/keys/test b/tests/keys/test
index 2dafb17..a4d41f4 100755
--- a/tests/keys/test
+++ b/tests/keys/test
@@ -29,6 +29,14 @@ BEGIN {
         $test_link_53 = 1;
     }
 
+    # Check if new 'key' permissions are supported: inval revoke join clear
+    $test_key_perms = 0;
+    $result = `cat /sys/fs/selinux/policy_capabilities/key_perms 2> /dev/null`;
+    if ( $result eq 1 ) {
+        $test_key_perms = 1;
+        $test_count += 7;
+    }
+
     plan tests => $test_count;
 }
 
@@ -65,6 +73,20 @@ else {
 $result = system "runcon -t test_key_no_setattr_t $basedir/keyctl $v 2>&1";
 ok( $result >> 8 eq 11 );
 
+if ($test_key_perms) {
+    print "Test key class + new permissions\n";
+    $result = system "runcon -t test_key_no_inval_t $basedir/keyctl $v 2>&1";
+    ok( $result >> 8 eq 12 );
+
+    $result = system "runcon -t test_key_no_revoke_t $basedir/keyctl $v 2>&1";
+    ok( $result >> 8 eq 13 );
+
+    $result = system "runcon -t test_key_no_clear_t $basedir/keyctl $v 2>&1";
+    ok( $result >> 8 eq 14 );
+
+# Deny key { join } is tested with permission checks between a keyring created by another process
+}
+
 print "Change keyring context\n";
 $result = system
 "runcon -t test_key_t $basedir/keyctl_relabel $v system_u:system_r:test_newcon_key_t:s0";
@@ -79,31 +101,60 @@ ok( $result eq 0 );
 $result = system(
 "runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_link_t $basedir/request_keys 2>&1"
 );
-ok( $result >> 8 eq 3 );
+if ( $test_key_perms and $test_link_53 ) {
+    ok( $result >> 8 eq 55 );
+}
+else {
+    ok( $result >> 8 eq 53 );
+}
 
 $result = system(
 "runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_write_t $basedir/request_keys 2>&1"
 );
-ok( $result >> 8 eq 5 );
+ok( $result >> 8 eq 55 );
 
 $result = system(
 "runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_view_t $basedir/request_keys 2>&1"
 );
-ok( $result >> 8 eq 4 );
+ok( $result >> 8 eq 54 );
 
 $result = system(
 "runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_search_t $basedir/request_keys 2>&1"
 );
-ok( $result >> 8 eq 5 );
+ok( $result >> 8 eq 55 );
 
 $result = system(
 "runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_setattr_t $basedir/request_keys 2>&1"
 );
-ok( $result >> 8 eq 6 );
+ok( $result >> 8 eq 56 );
 
 $result = system(
 "runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_read_t $basedir/request_keys 2>&1"
 );
-ok( $result >> 8 eq 8 );
+ok( $result >> 8 eq 58 );
+
+if ($test_key_perms) {
+    print
+"Test new permission checks between a keyring created by another process\n";
+    $result = system(
+"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_inval_t $basedir/request_keys 2>&1"
+    );
+    ok( $result >> 8 eq 59 );
+
+    $result = system(
+"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_revoke_t $basedir/request_keys 2>&1"
+    );
+    ok( $result >> 8 eq 60 );
+
+    $result = system(
+"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_clear_t $basedir/request_keys 2>&1"
+    );
+    ok( $result >> 8 eq 61 );
+
+    $result = system(
+"runcon -t test_keyring_service_t $basedir/keyring_service $v test_request_keys_no_join_t $basedir/request_keys 2>&1"
+    );
+    ok( $result >> 8 eq 53 );
+}
 
 exit;
-- 
2.24.1

