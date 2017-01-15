Subject: [PATCH 12/46] selinux: Move assignments for two pointers in
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
Message-ID: <05e70901-776f-8f3c-f0f3-014a42712dc6@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:12:03 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 16:56:51 +0100

Move the assignment for the local variables "newc" and "newgenfs" behind
a call of the function "next_entry" at the beginning so that they will
only be set after a successful call.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 754f829d2027..7544e374dec9 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1997,14 +1997,14 @@ static int genfs_read(struct policydb *p, void *fp)
 	int i, j, rc;
 	u32 nel, nel2, len, len2;
 	__le32 buf[1];
-	struct ocontext *l, *c;
-	struct ocontext *newc = NULL;
-	struct genfs *genfs_p, *genfs;
-	struct genfs *newgenfs = NULL;
+	struct ocontext *l, *c, *newc;
+	struct genfs *genfs_p, *genfs, *newgenfs;
 
 	rc = next_entry(buf, fp, sizeof(u32));
 	if (rc)
 		return rc;
+	newc = NULL;
+	newgenfs = NULL;
 	nel = le32_to_cpu(buf[0]);
 
 	for (i = 0; i < nel; i++) {
-- 
2.11.0
