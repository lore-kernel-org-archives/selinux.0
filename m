Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELg5sE009297
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:09 -0400
Received: by mail-wi0-f182.google.com with SMTP id e4so3197331wiv.15
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:15 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.14
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:14 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 03/20] policycoreutils/hll/pp: fix potential use of
 uninitialized variable
Date: Sun, 14 Sep 2014 23:41:34 +0200
Message-Id: <1410730911-14512-4-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

"gcc -O2 -Wall -Werror" failed with two errors when building pp due to
the use of unitialized variables.
---
 policycoreutils/hll/pp/pp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index 1c476b73c39b..fd80657321bc 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -2604,6 +2604,10 @@ static int file_contexts_to_cil(struct sepol_module_package *mod_pkg)
 			cilmode = "pipe";
 		} else if (!strcmp(mode, "-l")) {
 			cilmode = "symlink";
+		} else {
+			rc = -1;
+			log_err("Invalid mode in file context line: %s", line);
+			goto exit;
 		}
 
 		cil_printf("(filecon \"%s\" %s ", regex, cilmode);
@@ -2930,7 +2934,7 @@ static int get_decl_roles(struct policydb *pdb, struct role_datum ***decl_roles,
 {
 	int rc = -1;
 	uint32_t num;
-	struct role_datum **roles;
+	struct role_datum **roles = NULL;
 	struct decl_roles_args args;
 	args.pdb = pdb;
 
-- 
2.1.0
