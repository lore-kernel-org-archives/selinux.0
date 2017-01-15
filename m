Subject: [PATCH 41/46] selinux: Move two assignments for the variable "rc" in
 roles_init()
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <aa7a9b62-1016-2e22-6104-d992d6b556bf@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:41:25 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 15 Jan 2017 12:40:35 +0100

One local variable was set to an error code in two cases before
a concrete error situation was detected. Thus move the corresponding
assignments into if branches to indicate a software failure there.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index ccc146bfd4c2..be445abf047b 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -182,15 +182,17 @@ static int roles_init(struct policydb *p)
 	if (!role)
 		return -ENOMEM;
 
-	rc = -EINVAL;
 	role->value = ++p->p_roles.nprim;
-	if (role->value != OBJECT_R_VAL)
+	if (role->value != OBJECT_R_VAL) {
+		rc = -EINVAL;
 		goto out;
+	}
 
-	rc = -ENOMEM;
 	key = kstrdup(OBJECT_R, GFP_KERNEL);
-	if (!key)
+	if (!key) {
+		rc = -ENOMEM;
 		goto out;
+	}
 
 	rc = hashtab_insert(p->p_roles.table, key, role);
 	if (rc)
-- 
2.11.0
