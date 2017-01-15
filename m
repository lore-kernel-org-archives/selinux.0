Subject: [PATCH 36/46] selinux: Move an assignment for the variable "rc" in
 mls_read_range_helper()
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <02c3392e-3507-4d91-a8c0-6d933a034058@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:36:01 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 15 Jan 2017 11:22:23 +0100

A local variable was set to an error code in one case before a concrete
error situation was detected. Thus move the corresponding assignment into
an if branch to indicate a software failure there.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 9b595f2e0d9f..7cf635c650dc 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -996,10 +996,10 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
 	if (rc)
 		goto out;
 
-	rc = -EINVAL;
 	items = le32_to_cpu(buf[0]);
 	if (items > ARRAY_SIZE(buf)) {
 		printk(KERN_ERR "SELinux: mls:  range overflow\n");
+		rc = -EINVAL;
 		goto out;
 	}
 
-- 
2.11.0
