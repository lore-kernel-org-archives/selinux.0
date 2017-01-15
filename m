Subject: [PATCH 21/46] selinux: Two function calls less in range_read() after
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
Message-ID: <1e37fe86-2e83-c1f0-f43b-69ed2fb5c7aa@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:21:15 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 20:20:15 +0100

Adjust a jump target to avoid two calls of the function "kfree" at the end
after a memory allocation failed for the local variable "rt".

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 4cd96ce51322..0d2f64558c0a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1857,7 +1857,7 @@ static int range_read(struct policydb *p, void *fp)
 		rt = kzalloc(sizeof(*rt), GFP_KERNEL);
 		if (!rt) {
 			rc = -ENOMEM;
-			goto out;
+			goto exit;
 		}
 
 		rc = next_entry(buf, fp, (sizeof(u32) * 2));
@@ -1909,6 +1909,7 @@ static int range_read(struct policydb *p, void *fp)
 out:
 	kfree(rt);
 	kfree(r);
+exit:
 	return rc;
 }
 
-- 
2.11.0
