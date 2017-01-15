Subject: [PATCH 40/46] selinux: Return directly after a failed kzalloc() in
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
Message-ID: <2c370330-a80c-9879-2013-3a99a21dc06d@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:40:07 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 15 Jan 2017 12:10:09 +0100

Return directly after a call of the function "kzalloc" failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 8b9ed3f1b132..ccc146bfd4c2 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -178,10 +178,9 @@ static int roles_init(struct policydb *p)
 	int rc;
 	struct role_datum *role;
 
-	rc = -ENOMEM;
 	role = kzalloc(sizeof(*role), GFP_KERNEL);
 	if (!role)
-		goto out;
+		return -ENOMEM;
 
 	rc = -EINVAL;
 	role->value = ++p->p_roles.nprim;
-- 
2.11.0
