Subject: [PATCH 25/46] selinux: Return directly after a failed kzalloc() in
 sens_read()
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <8f253493-ae7f-ca02-a6f3-333e896eeb7d@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:25:01 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 21:42:02 +0100

Return directly after a call of the function "kzalloc" failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index eb898dcbe502..5caa1fa5ea80 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1593,10 +1593,9 @@ static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
 	__le32 buf[2];
 	u32 len;
 
-	rc = -ENOMEM;
 	levdatum = kzalloc(sizeof(*levdatum), GFP_ATOMIC);
 	if (!levdatum)
-		goto bad;
+		return -ENOMEM;
 
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc)
-- 
2.11.0
