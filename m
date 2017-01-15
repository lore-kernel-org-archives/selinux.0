Subject: [PATCH 23/46] selinux: Move an assignment for a pointer in
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
Message-ID: <668d71a5-d55c-449e-9de8-b5d70d7e11c9@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:23:08 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 21:00:45 +0100

Move the assignment for the local variable "r" behind a call of the
function "next_entry" at the beginning so that it will only be set
after a successful call.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 6121a26ada64..5101592ae172 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1840,7 +1840,7 @@ u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
 static int range_read(struct policydb *p, void *fp)
 {
 	struct range_trans *rt;
-	struct mls_range *r = NULL;
+	struct mls_range *r;
 	int i, rc;
 	__le32 buf[2];
 	u32 nel;
@@ -1852,6 +1852,7 @@ static int range_read(struct policydb *p, void *fp)
 	if (rc)
 		return rc;
 
+	r = NULL;
 	nel = le32_to_cpu(buf[0]);
 	for (i = 0; i < nel; i++) {
 		rt = kzalloc(sizeof(*rt), GFP_KERNEL);
-- 
2.11.0
