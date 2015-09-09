Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t89J9aa6029902
 for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2015 15:09:36 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol/cil: fix NULL pointer dereference when copying
 classpermission/set
Date: Wed, 9 Sep 2015 15:09:29 -0400
Message-ID: <1441825769-18936-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When copying classpermission or classpermissionset statements, we did
not properly initialize the new structs. This would cause a segfault
when one used either of these statements inside a tunableif block, e.g.

  (tunableif foo
    (true
      (classpermissionset cps (cls (perm1 perm2))))
    (false
      (classpermissionset cps (cls (perm1)))))

Reported-by: Dominick Grift <dac.override@gmail.com>
Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 libsepol/cil/src/cil_copy_ast.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 34d8d4c..c611dbc 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -282,6 +282,8 @@ int cil_copy_classpermission(__attribute__((unused)) struct cil_db *db, void *da
 		}
 	}
 
+	cil_classpermission_init(&new);
+
 	cil_copy_classperms_list(orig->classperms, &new->classperms);
 
 	*copy = new;
@@ -294,6 +296,8 @@ int cil_copy_classpermissionset(__attribute__((unused)) struct cil_db *db, void
 	struct cil_classpermissionset *orig = data;
 	struct cil_classpermissionset *new = NULL;
 
+	cil_classpermissionset_init(&new);
+
 	new->set_str = orig->set_str;
 
 	cil_copy_classperms_list(orig->classperms, &new->classperms);
-- 
2.4.3
