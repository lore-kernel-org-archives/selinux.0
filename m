Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8PMYjVv002140
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 18:34:50 -0400
Received: by lacrr8 with SMTP id rr8so33548849lac.2
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 15:34:47 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] selinux: use kstrdup() in security_get_bools()
Date: Sat, 26 Sep 2015 00:34:18 +0200
Message-Id: <1443220459-11042-5-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is much simpler.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 security/selinux/ss/services.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 994c824a34c6..aa2bdcb20848 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2609,18 +2609,12 @@ int security_get_bools(int *len, char ***names, int **values)
 		goto err;
 
 	for (i = 0; i < *len; i++) {
-		size_t name_len;
-
 		(*values)[i] = policydb.bool_val_to_struct[i]->state;
-		name_len = strlen(sym_name(&policydb, SYM_BOOLS, i)) + 1;
 
 		rc = -ENOMEM;
-		(*names)[i] = kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
+		(*names)[i] = kstrdup(sym_name(&policydb, SYM_BOOLS, i), GFP_ATOMIC);
 		if (!(*names)[i])
 			goto err;
-
-		strncpy((*names)[i], sym_name(&policydb, SYM_BOOLS, i), name_len);
-		(*names)[i][name_len - 1] = 0;
 	}
 	rc = 0;
 out:
-- 
2.1.3
