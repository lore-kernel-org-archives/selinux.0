Message-Id: <200808061546.m76Fkwq1005199@ruuvi.it.helsinki.fi>
From: Vesa-Matti Kari <vmkari@cc.helsinki.fi>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Date: Wed, 6 Aug 2008 18:24:51 +0300
Subject: [PATCH] selinux: conditional expression type validation was off-by-one
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

expr_isvalid() in conditional.c was off-by-one and allowed
invalid expression type COND_LAST. However, it is this header file
that needs to be fixed. That way the if-statement's disjunction's
second component reads more naturally, "if expr type is greater than
the last allowed value" ( rather than using ">=" in conditional.c):

  if (expr->expr_type <= 0 || expr->expr_type > COND_LAST)

Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>
---
 security/selinux/ss/conditional.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index 65b9f83..53ddb01 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -28,7 +28,7 @@ struct cond_expr {
 #define COND_XOR	5 /* bool ^ bool */
 #define COND_EQ		6 /* bool == bool */
 #define COND_NEQ	7 /* bool != bool */
-#define COND_LAST	8
+#define COND_LAST	COND_NEQ
 	__u32 expr_type;
 	__u32 bool;
 	struct cond_expr *next;
-- 
1.5.4.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
