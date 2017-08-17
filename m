From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: =?UTF-8?q?Gr=C3=A9goire=20Colbert?= <gc.github-com@artefarita.com>
Date: Thu, 17 Aug 2017 14:50:09 -0400
Message-Id: <20170817185009.20292-1-jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH] Fixed bad reference in roleattribute
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Grégoire Colbert <gc.github-com@artefarita.com>

"roleattribute" was referencing "typeattributeset", but I believe it should be referencing "roleattributeset" instead.
---
 secilc/docs/cil_role_statements.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/secilc/docs/cil_role_statements.md b/secilc/docs/cil_role_statements.md
index 0c4cadb..d92f628 100644
--- a/secilc/docs/cil_role_statements.md
+++ b/secilc/docs/cil_role_statements.md
@@ -84,7 +84,7 @@ This example will declare [`role`](cil_role_statements.md#role) and [`type`](cil
 roleattribute
 -------------
 
-Declares a role attribute identifier in the current namespace. The identifier may have zero or more [`role`](cil_role_statements.md#role) and [`roleattribute`](cil_role_statements.md#roleattribute) identifiers associated to it via the [`typeattributeset`](cil_type_statements.md#typeattributeset) statement.
+Declares a role attribute identifier in the current namespace. The identifier may have zero or more [`role`](cil_role_statements.md#role) and [`roleattribute`](cil_role_statements.md#roleattribute) identifiers associated to it via the [`roleattributeset`](cil_role_statements.md#roleattributeset) statement.
 
 **Statement definition:**
 
-- 
2.9.4
