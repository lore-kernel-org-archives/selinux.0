Date: Fri, 31 Mar 2017 18:21:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Paul Moore <paul@paul-moore.com>,
 Markus Elfring <elfring@users.sourceforge.net>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 William Roberts <william.c.roberts@intel.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] selinux: Fix an uninitialized variable bug
Message-ID: <20170331152118.GA8141@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We removed this initialization as a cleanup but it is probably required.

The concern is that "nel" can be zero.  I'm not an expert on SELinux
code but I think it looks possible to write an SELinux policy which
triggers this bug.  GCC doesn't catch this, but my static checker does.

Fixes: 9c312e79d6af ("selinux: Delete an unnecessary variable initialisation in range_read()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 658247f98dc1..0080122760ad 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1832,7 +1832,7 @@ u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
 
 static int range_read(struct policydb *p, void *fp)
 {
-	struct range_trans *rt;
+	struct range_trans *rt = NULL;
 	struct mls_range *r = NULL;
 	int i, rc;
 	__le32 buf[2];
