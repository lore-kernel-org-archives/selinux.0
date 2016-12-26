Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBQLBFid016478
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 16:11:20 -0500
Received: from localhost.localdomain (private.iosenag.net [31.7.184.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 16BCF56078D
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 22:11:12 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] libsepol/tests: fix some memory leaks
Date: Mon, 26 Dec 2016 22:10:44 +0100
Message-Id: <20161226211044.5978-2-nicolas.iooss@m4x.org>
In-Reply-To: <20161226211044.5978-1-nicolas.iooss@m4x.org>
References: <20161226211044.5978-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When running "make test" with the Address Sanitizer (by adding
-fsanitize=address to compiler flags), a lot of memory leaks are
reported from checkpolicy. Anyway some leaks come from the tests and it
seems cleaner to start fixing these ones.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/tests/test-deps.c     |  2 ++
 libsepol/tests/test-expander.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/libsepol/tests/test-deps.c b/libsepol/tests/test-deps.c
index e7d2bebe0d93..ed23e0992ced 100644
--- a/libsepol/tests/test-deps.c
+++ b/libsepol/tests/test-deps.c
@@ -166,6 +166,7 @@ static void do_deps_modreq_global(int req_met, int b, char *policy, char *decl_t
 	ret = link_modules(h, base, mods, 1, 0);
 	CU_ASSERT_FATAL(ret == link_ret);
 	policydb_destroy(&mod);
+	sepol_handle_destroy(h);
 
 	if (!req_met)
 		return;
@@ -246,6 +247,7 @@ static void do_deps_modreq_opt(int req_met, int ret_val, int b, char *policy, ch
 	ret = link_modules(h, base, mods, 1, 0);
 	CU_ASSERT_FATAL(ret == ret_val);
 	policydb_destroy(&mod);
+	sepol_handle_destroy(h);
 	if (ret_val < 0)
 		return;
 
diff --git a/libsepol/tests/test-expander.c b/libsepol/tests/test-expander.c
index ded1d9de2003..bc946c778b1d 100644
--- a/libsepol/tests/test-expander.c
+++ b/libsepol/tests/test-expander.c
@@ -122,6 +122,9 @@ int expander_policy_init(policydb_t * mybase, int num_modules, policydb_t ** mym
 		return -1;
 	}
 
+	for (i = 0; i < num_modules + 1; i++) {
+		free(filename[i]);
+	}
 	return 0;
 }
 
@@ -173,6 +176,20 @@ int expander_test_cleanup(void)
 {
 	policydb_destroy(&basemod);
 	policydb_destroy(&base_expanded);
+	policydb_destroy(&basemod2);
+	policydb_destroy(&base_expanded2);
+	policydb_destroy(&mod2);
+	policydb_destroy(&base_only_mod);
+	policydb_destroy(&base_only_expanded);
+	policydb_destroy(&role_basemod);
+	policydb_destroy(&role_expanded);
+	policydb_destroy(&role_mod);
+	policydb_destroy(&user_basemod);
+	policydb_destroy(&user_expanded);
+	policydb_destroy(&user_mod);
+	policydb_destroy(&alias_basemod);
+	policydb_destroy(&alias_expanded);
+	policydb_destroy(&alias_mod);
 	free(typemap);
 
 	return 0;
-- 
2.11.0
