Subject: [PATCH 18/46] selinux: One function call less in
 filename_trans_read() after error detection
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <358b5114-aeb3-d5fa-bcf9-239bd383d3b5@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:18:06 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 19:19:42 +0100

Adjust a jump target to avoid a function call at the end after a memory
allocation failed for the local variable "ft".

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 2be5b18eb149..5f122e846332 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1932,7 +1932,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
 		ft = kzalloc(sizeof(*ft), GFP_KERNEL);
 		if (!ft) {
 			rc = -ENOMEM;
-			goto out;
+			goto free_name;
 		}
 
 		otype = kmalloc(sizeof(*otype), GFP_KERNEL);
@@ -1986,6 +1986,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
 	return 0;
 out:
 	kfree(ft);
+free_name:
 	kfree(name);
 	kfree(otype);
 
-- 
2.11.0
