Subject: [PATCH 16/46] selinux: Move two assignments for the variable "rc" in
 filename_trans_read()
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <d7e6f9c9-c6dc-5fd5-5537-85fe1617abb1@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:16:02 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 18:50:52 +0100

One local variable was set to an error code in two cases before
a concrete error situation was detected. Thus move the corresponding
assignments into if branches to indicate a software failure there.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index e7b882251da8..106a1da1d68a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1930,16 +1930,17 @@ static int filename_trans_read(struct policydb *p, void *fp)
 		ft = NULL;
 		otype = NULL;
 		name = NULL;
-
-		rc = -ENOMEM;
 		ft = kzalloc(sizeof(*ft), GFP_KERNEL);
-		if (!ft)
+		if (!ft) {
+			rc = -ENOMEM;
 			goto out;
+		}
 
-		rc = -ENOMEM;
 		otype = kmalloc(sizeof(*otype), GFP_KERNEL);
-		if (!otype)
+		if (!otype) {
+			rc = -ENOMEM;
 			goto out;
+		}
 
 		/* length of the path component string */
 		rc = next_entry(buf, fp, sizeof(u32));
-- 
2.11.0
