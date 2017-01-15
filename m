Subject: [PATCH 28/46] selinux: Return directly after a failed kzalloc() in
 user_read()
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <3582dff5-b96a-dde7-2d1c-bca7ab4aeb0e@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:28:03 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 22:08:22 +0100

Return directly after a call of the function "kzalloc" failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 3e43556e67b8..1c046d39e2a7 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1542,10 +1542,9 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 	__le32 buf[3];
 	u32 len;
 
-	rc = -ENOMEM;
 	usrdatum = kzalloc(sizeof(*usrdatum), GFP_KERNEL);
 	if (!usrdatum)
-		goto bad;
+		return -ENOMEM;
 
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		to_read = 3;
-- 
2.11.0
