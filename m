Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3AJCwq2022698
 for <selinux@tycho.nsa.gov>; Mon, 10 Apr 2017 15:12:58 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 7A9105613AE
 for <selinux@tycho.nsa.gov>; Mon, 10 Apr 2017 21:12:49 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] libsepol: do not leak memory when an error occurs
Date: Mon, 10 Apr 2017 21:11:48 +0200
Message-Id: <20170410191149.17419-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170410191149.17419-1-nicolas.iooss@m4x.org>
References: <20170410191149.17419-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

name_list_to_string() and constraint_expr_to_string() both define an
exit label to clean-up dynamically-allocated memory when an error
occurs, but they miss some variables. Free the missing ones too.

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 18b2a6f86fe3..45acdeb1a4e0 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1153,6 +1153,7 @@ static int name_list_to_string(char **names, int num_names, char **string)
 
 	return 0;
 exit:
+	free(str);
 	return rc;
 }
 
@@ -1697,7 +1698,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 	const char *fmt_str;
 	const char *attr1;
 	const char *attr2;
-	char *names;
+	char *names = NULL;
 	char **name_list = NULL;
 	int num_names = 0;
 	struct type_set *ts;
@@ -1798,6 +1799,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 
 				names_destroy(&name_list, &num_names);
 				free(names);
+				names = NULL;
 			}
 
 			num_params = 0;
@@ -1887,6 +1889,7 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 
 exit:
 	names_destroy(&name_list, &num_names);
+	free(names);
 
 	free(new_val);
 	free(val1);
-- 
2.12.0
