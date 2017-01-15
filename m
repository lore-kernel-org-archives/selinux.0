Subject: [PATCH 20/46] selinux: Move four assignments for the variable "rc" in
 range_read()
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <196aacb8-6aab-841b-3301-71da75628954@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:20:03 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 19:55:00 +0100

One local variable was set to an error code in four cases before
a concrete error situation was detected. Thus move the corresponding
assignments into if branches to indicate a software failure there.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index a696876fc327..4cd96ce51322 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1854,10 +1854,11 @@ static int range_read(struct policydb *p, void *fp)
 
 	nel = le32_to_cpu(buf[0]);
 	for (i = 0; i < nel; i++) {
-		rc = -ENOMEM;
 		rt = kzalloc(sizeof(*rt), GFP_KERNEL);
-		if (!rt)
+		if (!rt) {
+			rc = -ENOMEM;
 			goto out;
+		}
 
 		rc = next_entry(buf, fp, (sizeof(u32) * 2));
 		if (rc)
@@ -1873,24 +1874,26 @@ static int range_read(struct policydb *p, void *fp)
 		} else
 			rt->target_class = p->process_class;
 
-		rc = -EINVAL;
 		if (!policydb_type_isvalid(p, rt->source_type) ||
 		    !policydb_type_isvalid(p, rt->target_type) ||
-		    !policydb_class_isvalid(p, rt->target_class))
+		    !policydb_class_isvalid(p, rt->target_class)) {
+			rc = -EINVAL;
 			goto out;
+		}
 
-		rc = -ENOMEM;
 		r = kzalloc(sizeof(*r), GFP_KERNEL);
-		if (!r)
+		if (!r) {
+			rc = -ENOMEM;
 			goto out;
+		}
 
 		rc = mls_read_range_helper(r, fp);
 		if (rc)
 			goto out;
 
-		rc = -EINVAL;
 		if (!mls_range_isvalid(p, r)) {
 			printk(KERN_WARNING "SELinux:  rangetrans:  invalid range\n");
+			rc = -EINVAL;
 			goto out;
 		}
 
-- 
2.11.0
