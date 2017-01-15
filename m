Subject: [PATCH 19/46] selinux: Return directly after a failed next_entry() in
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
Message-ID: <9e75f8b7-1275-b2e6-a01c-d0c5ebac1a44@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:19:02 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 19:35:59 +0100

Return directly after a call of the function "next_entry" failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 5f122e846332..a696876fc327 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1850,7 +1850,7 @@ static int range_read(struct policydb *p, void *fp)
 
 	rc = next_entry(buf, fp, sizeof(u32));
 	if (rc)
-		goto out;
+		return rc;
 
 	nel = le32_to_cpu(buf[0]);
 	for (i = 0; i < nel; i++) {
-- 
2.11.0
