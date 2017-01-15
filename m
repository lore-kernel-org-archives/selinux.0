Subject: [PATCH 31/46] selinux: Move an assignment for the variable "rc" in
 role_read()
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <6df4c468-0b12-d053-6768-6f3245652427@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:31:10 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 22:25:20 +0100

A local variable was set to an error code in one case before a concrete
error situation was detected. Thus move the corresponding assignment into
an if branch to indicate a software failure there.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 34b670227c4d..49fc5d8990e9 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1439,10 +1439,10 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto bad;
 
 	if (strcmp(key, OBJECT_R) == 0) {
-		rc = -EINVAL;
 		if (role->value != OBJECT_R_VAL) {
 			printk(KERN_ERR "SELinux: Role %s has wrong value %d\n",
 			       OBJECT_R, role->value);
+			rc = -EINVAL;
 			goto bad;
 		}
 		rc = 0;
-- 
2.11.0
