Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELgsEQ009324
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:55 -0400
Received: by mail-we0-f180.google.com with SMTP id t60so3056462wes.39
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:40 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.39
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:39 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 20/20] libsepol/tests: fix gcc -Warray-bounds warning
Date: Sun, 14 Sep 2014 23:41:51 +0200
Message-Id: <1410730911-14512-21-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

  test-linker-roles.c: In function 'module_role_tests':
  test-linker-roles.c:147:7: error: array subscript is above array bounds
  [-Werror=array-bounds]
    decls[2] = (test_find_decl_by_sym(base, SYM_TYPES,"tag_g_m2"))->decl_id;
         ^
---
 libsepol/tests/test-linker-roles.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/tests/test-linker-roles.c b/libsepol/tests/test-linker-roles.c
index 42f92d30f7f9..2c4a804704d6 100644
--- a/libsepol/tests/test-linker-roles.c
+++ b/libsepol/tests/test-linker-roles.c
@@ -101,7 +101,7 @@ void module_role_tests(policydb_t * base)
 {
 	role_datum_t *role;
 	avrule_decl_t *decl;
-	unsigned int decls[2];
+	unsigned int decls[3];
 	char *types[3];
 
 	/* These tests are run when the base is linked with 2 modules,
-- 
2.1.0
