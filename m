Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8PMYjW0002140
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 18:34:51 -0400
Received: by lacdq2 with SMTP id dq2so57552323lac.1
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 15:34:48 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] selinux: use sprintf return value
Date: Sat, 26 Sep 2015 00:34:19 +0200
Message-Id: <1443220459-11042-6-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

sprintf returns the number of characters printed (excluding '\0'), so
we can use that and avoid duplicating the length computation.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 security/selinux/ss/services.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index aa2bdcb20848..ebb5eb3c318c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1218,13 +1218,10 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
 	/*
 	 * Copy the user name, role name and type name into the context.
 	 */
-	sprintf(scontextp, "%s:%s:%s",
+	scontextp += sprintf(scontextp, "%s:%s:%s",
 		sym_name(&policydb, SYM_USERS, context->user - 1),
 		sym_name(&policydb, SYM_ROLES, context->role - 1),
 		sym_name(&policydb, SYM_TYPES, context->type - 1));
-	scontextp += strlen(sym_name(&policydb, SYM_USERS, context->user - 1)) +
-		     1 + strlen(sym_name(&policydb, SYM_ROLES, context->role - 1)) +
-		     1 + strlen(sym_name(&policydb, SYM_TYPES, context->type - 1));
 
 	mls_sid_to_context(context, &scontextp);
 
-- 
2.1.3
