Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBQLIkwu018050
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 16:18:49 -0500
Received: from localhost.localdomain (private.iosenag.net [31.7.184.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id ED2E156469F
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 22:18:46 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/5] checkpolicy: fix memory leaks in genfscon statements
 parsing
Date: Mon, 26 Dec 2016 22:18:30 +0100
Message-Id: <20161226211832.7165-3-nicolas.iooss@m4x.org>
In-Reply-To: <20161226211832.7165-1-nicolas.iooss@m4x.org>
References: <20161226211832.7165-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When parsing several genfscon statements for the same filesystem, the
content of local variable "fstype" is never freed. Moreover variable
"type" is never freed when define_genfs_context_helper() succeeds.

Fix these leaks by calling free() appropriately.

These leaks have been detected with gcc Address Sanitizer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/policy_define.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index ff902787c2aa..780e325af65d 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -5288,6 +5288,9 @@ int define_genfs_context_helper(char *fstype, int has_type)
 		else
 			policydbp->genfs = newgenfs;
 		genfs = newgenfs;
+	} else {
+		free(fstype);
+		fstype = NULL;
 	}
 
 	newc = (ocontext_t *) malloc(sizeof(ocontext_t));
@@ -5345,7 +5348,7 @@ int define_genfs_context_helper(char *fstype, int has_type)
 		    (!newc->v.sclass || !c->v.sclass
 		     || newc->v.sclass == c->v.sclass)) {
 			yyerror2("duplicate entry for genfs entry (%s, %s)",
-				 fstype, newc->u.name);
+				 genfs->fstype, newc->u.name);
 			goto fail;
 		}
 		len = strlen(newc->u.name);
@@ -5359,6 +5362,7 @@ int define_genfs_context_helper(char *fstype, int has_type)
 		p->next = newc;
 	else
 		genfs->head = newc;
+	free(type);
 	return 0;
       fail:
 	if (type)
-- 
2.11.0
