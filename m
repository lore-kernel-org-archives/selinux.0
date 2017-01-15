Subject: [PATCH 09/46] selinux: Delete an error message for a failed memory
 allocation in policydb_read()
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <c589a851-2bf6-c44f-1df7-11f242285a73@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:07:58 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Jan 2017 14:20:41 +0100

Omit an extra message for a memory allocation failure in this function.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/policydb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index fe8992382a71..53e6d06e772a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2269,11 +2269,8 @@ int policydb_read(struct policydb *p, void *fp)
 
 	rc = -ENOMEM;
 	policydb_str = kmalloc(len + 1, GFP_KERNEL);
-	if (!policydb_str) {
-		printk(KERN_ERR "SELinux:  unable to allocate memory for policydb "
-		       "string of length %d\n", len);
+	if (!policydb_str)
 		goto bad;
-	}
 
 	rc = next_entry(policydb_str, fp, len);
 	if (rc) {
-- 
2.11.0
