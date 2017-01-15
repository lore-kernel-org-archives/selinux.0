Subject: [PATCH 13/46] selinux: Move four assignments for the variable "rc" in
 genfs_read()
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <99ebe15e-c30f-d129-82a0-a809769aa5dc@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:13:06 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 17:21:59 +0100

One local variable was set to an error code in four cases before
a concrete error situation was detected. Thus move the corresponding
assignments into if branches to indicate a software failure there.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 7544e374dec9..a12d9166f0e4 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2012,11 +2012,11 @@ static int genfs_read(struct policydb *p, void *fp)
 		if (rc)
 			goto out;
 		len = le32_to_cpu(buf[0]);
-
-		rc = -ENOMEM;
 		newgenfs = kzalloc(sizeof(*newgenfs), GFP_KERNEL);
-		if (!newgenfs)
+		if (!newgenfs) {
+			rc = -ENOMEM;
 			goto out;
+		}
 
 		rc = str_read(&newgenfs->fstype, GFP_KERNEL, fp, len);
 		if (rc)
@@ -2024,10 +2024,10 @@ static int genfs_read(struct policydb *p, void *fp)
 
 		for (genfs_p = NULL, genfs = p->genfs; genfs;
 		     genfs_p = genfs, genfs = genfs->next) {
-			rc = -EINVAL;
 			if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
 				printk(KERN_ERR "SELinux:  dup genfs fstype %s\n",
 				       newgenfs->fstype);
+				rc = -EINVAL;
 				goto out;
 			}
 			if (strcmp(newgenfs->fstype, genfs->fstype) < 0)
@@ -2051,11 +2051,11 @@ static int genfs_read(struct policydb *p, void *fp)
 			if (rc)
 				goto out;
 			len = le32_to_cpu(buf[0]);
-
-			rc = -ENOMEM;
 			newc = kzalloc(sizeof(*newc), GFP_KERNEL);
-			if (!newc)
+			if (!newc) {
+				rc = -ENOMEM;
 				goto out;
+			}
 
 			rc = str_read(&newc->u.name, GFP_KERNEL, fp, len);
 			if (rc)
@@ -2072,12 +2072,12 @@ static int genfs_read(struct policydb *p, void *fp)
 
 			for (l = NULL, c = genfs->head; c;
 			     l = c, c = c->next) {
-				rc = -EINVAL;
 				if (!strcmp(newc->u.name, c->u.name) &&
 				    (!c->v.sclass || !newc->v.sclass ||
 				     newc->v.sclass == c->v.sclass)) {
 					printk(KERN_ERR "SELinux:  dup genfs entry (%s,%s)\n",
 					       genfs->fstype, c->u.name);
+					rc = -EINVAL;
 					goto out;
 				}
 				len = strlen(newc->u.name);
-- 
2.11.0
