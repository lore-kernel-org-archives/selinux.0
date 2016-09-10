From: Wei Yongjun <weiyj.lk@gmail.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 William Roberts <william.c.roberts@intel.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Subject: [PATCH -next] SELinux: fix error return code in policydb_read()
Date: Sat, 10 Sep 2016 07:43:48 +0000
Message-Id: <1473493428-26786-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return error code -EINVAL from the error handling case instead
of 0(rc is overwrite to 0 when policyvers >= POLICYDB_VERSION_ROLETRANS),
as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 security/selinux/ss/policydb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 8c661f0..ace6838 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2417,6 +2417,7 @@ int policydb_read(struct policydb *p, void *fp)
 		} else
 			tr->tclass = p->process_class;
 
+		rc = -EINVAL;
 		if (!policydb_role_isvalid(p, tr->role) ||
 		    !policydb_type_isvalid(p, tr->type) ||
 		    !policydb_class_isvalid(p, tr->tclass) ||
