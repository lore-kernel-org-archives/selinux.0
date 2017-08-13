From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Alexey Dobriyan <adobriyan@gmail.com>, Daniel Jurgens
 <danielj@mellanox.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Junil Lee <junil0814.lee@lge.com>, Paul Moore <paul@paul-moore.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
Message-ID: <230e56f6-3dd9-5e6e-fa06-df22d61e0831@users.sourceforge.net>
Date: Sun, 13 Aug 2017 16:48:10 +0200
MIME-Version: 1.0
In-Reply-To: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 3/4] selinux: Delete an unnecessary return statement
 in ebitmap_destroy()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 13 Aug 2017 15:50:26 +0200

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/ebitmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 03581d7ef817..697bd748760a 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -339,7 +339,6 @@ void ebitmap_destroy(struct ebitmap *e)
 
 	e->highbit = 0;
 	e->node = NULL;
-	return;
 }
 
 int ebitmap_read(struct ebitmap *e, void *fp)
-- 
2.14.0
