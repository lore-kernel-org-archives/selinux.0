Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8PMYjVq002140
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 18:34:47 -0400
Received: by laclj5 with SMTP id lj5so17621683lac.3
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 15:34:44 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] selinux: remove pointless cast in
 selinux_inode_setsecurity()
Date: Sat, 26 Sep 2015 00:34:16 +0200
Message-Id: <1443220459-11042-3-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

security_context_to_sid() expects a const char* argument, so there's
no point in casting away the const qualifier of value.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fd50cd5ac2ec..5edb57df86f8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3162,7 +3162,7 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	if (!value || !size)
 		return -EACCES;
 
-	rc = security_context_to_sid((void *)value, size, &newsid, GFP_KERNEL);
+	rc = security_context_to_sid(value, size, &newsid, GFP_KERNEL);
 	if (rc)
 		return rc;
 
-- 
2.1.3
