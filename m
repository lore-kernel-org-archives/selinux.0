Subject: [PATCH 3/3] selinux: Use an other error code for an input validation
 failure in sidtab_insert()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: Casey Schaufler <casey@schaufler-ca.com>,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <5704e656-708a-b611-5611-70fc65dc67e8@users.sourceforge.net>
Message-ID: <38273216-97ad-7955-941a-68485534d39f@users.sourceforge.net>
Date: Tue, 4 Apr 2017 13:16:01 +0200
MIME-Version: 1.0
In-Reply-To: <5704e656-708a-b611-5611-70fc65dc67e8@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 4 Apr 2017 12:23:41 +0200

The error code "-ENOMEM" was also returned so far when the parameter "s"
of this function contained a null pointer.
Now I find that the code "-EINVAL" is more appropriate in this case.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/sidtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index c5f436b15d19..2eb2a54b88d2 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -36,7 +36,7 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
 	struct sidtab_node *prev, *cur, *newnode;
 
 	if (!s)
-		return -ENOMEM;
+		return -EINVAL;
 
 	hvalue = SIDTAB_HASH(sid);
 	prev = NULL;
-- 
2.12.2
