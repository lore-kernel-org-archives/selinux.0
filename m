Subject: [PATCH 27/46] selinux: Move an assignment for the variable "rc" in
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
Message-ID: <6b93ee88-d4c0-b5e3-6f7e-fc74acfddd43@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:27:08 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 22:02:14 +0100

A local variable was set to an error code in one case before a concrete
error situation was detected. Thus move the corresponding assignment into
an if branch to indicate a software failure there.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index edfcfd3bbc60..3e43556e67b8 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1608,10 +1608,11 @@ static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (rc)
 		goto bad;
 
-	rc = -ENOMEM;
 	levdatum->level = kmalloc(sizeof(*levdatum->level), GFP_ATOMIC);
-	if (!levdatum->level)
+	if (!levdatum->level) {
+		rc = -ENOMEM;
 		goto bad;
+	}
 
 	rc = mls_read_level(levdatum->level, fp);
 	if (rc)
-- 
2.11.0
