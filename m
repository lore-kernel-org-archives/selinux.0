Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0PHHlKl013553
 for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2017 12:17:47 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol: fix pp module to cil nodecon statement
Date: Wed, 25 Jan 2017 12:17:16 -0500
Message-ID: <1485364636-21338-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Policy modules do not have the concept of named IP addresses like CIL
does. So when converting nodecode statements from pp policy modules to
CIL, we need to wrap the IP address and mask parameters in parentheses
so that the CIL compiler does not try to resolve them as named
addresses, but instead treats them as anonymous.

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 libsepol/src/module_to_cil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 51a4784..2acb600 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2721,7 +2721,7 @@ static int ocontext_selinux_node_to_cil(struct policydb *pdb, struct ocontext *n
 			goto exit;
 		}
 
-		cil_printf("(nodecon %s %s ", addr, mask);
+		cil_printf("(nodecon (%s) (%s) ", addr, mask);
 
 		context_to_cil(pdb, &node->context[0]);
 
@@ -2753,7 +2753,7 @@ static int ocontext_selinux_node6_to_cil(struct policydb *pdb, struct ocontext *
 			goto exit;
 		}
 
-		cil_printf("(nodecon %s %s ", addr, mask);
+		cil_printf("(nodecon (%s) (%s) ", addr, mask);
 
 		context_to_cil(pdb, &node->context[0]);
 
-- 
2.7.4
