Subject: [PATCH 42/46] selinux: One function call less in roles_init() after
 error detection
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <e26b4b88-b04f-0a82-0396-8b53a80d03a9@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:42:13 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 15 Jan 2017 12:56:54 +0100

The kfree() function was called in up to two cases by the
roles_init() function during error handling even if the passed variable
contained a null pointer.

* Adjust a jump target according to the Linux coding style convention.

* Delete an initialisation for the variable "key" at the beginning
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index be445abf047b..7dd5c6f7786f 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -174,7 +174,7 @@ static struct policydb_compat_info *policydb_lookup_compat(int version)
  */
 static int roles_init(struct policydb *p)
 {
-	char *key = NULL;
+	char *key;
 	int rc;
 	struct role_datum *role;
 
@@ -185,13 +185,13 @@ static int roles_init(struct policydb *p)
 	role->value = ++p->p_roles.nprim;
 	if (role->value != OBJECT_R_VAL) {
 		rc = -EINVAL;
-		goto out;
+		goto free_role;
 	}
 
 	key = kstrdup(OBJECT_R, GFP_KERNEL);
 	if (!key) {
 		rc = -ENOMEM;
-		goto out;
+		goto free_role;
 	}
 
 	rc = hashtab_insert(p->p_roles.table, key, role);
@@ -201,6 +201,7 @@ static int roles_init(struct policydb *p)
 	return 0;
 out:
 	kfree(key);
+free_role:
 	kfree(role);
 	return rc;
 }
-- 
2.11.0
