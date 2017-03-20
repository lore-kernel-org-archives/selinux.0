Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2KFIa8P027563
 for <selinux@tycho.nsa.gov>; Mon, 20 Mar 2017 11:18:36 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] libsepol: Update module_to_cil to output hexadecimal for
 Xen rules
Date: Mon, 20 Mar 2017 11:18:58 -0400
Message-Id: <1490023139-12045-3-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1490023139-12045-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1490023139-12045-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When generating CIL, use hexadecimal numbers in ioportcon,
iomemcon, and pcidevicecon statements.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/module_to_cil.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 8c4fff9..6c33b94 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -34,6 +34,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <inttypes.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
@@ -2854,9 +2855,9 @@ static int ocontext_xen_ioport_to_cil(struct policydb *pdb, struct ocontext *iop
 		high = ioport->u.ioport.high_ioport;
 
 		if (low == high) {
-			cil_printf("(ioportcon %i ", low);
+			cil_printf("(ioportcon 0x%x ", low);
 		} else {
-			cil_printf("(ioportcon (%i %i) ", low, high);
+			cil_printf("(ioportcon (0x%x 0x%x) ", low, high);
 		}
 
 		context_to_cil(pdb, &ioport->context[0]);
@@ -2878,9 +2879,9 @@ static int ocontext_xen_iomem_to_cil(struct policydb *pdb, struct ocontext *iome
 		high = iomem->u.iomem.high_iomem;
 
 		if (low == high) {
-			cil_printf("(iomemcon %#lX ", (unsigned long)low);
+			cil_printf("(iomemcon 0x%"PRIx64" ", low);
 		} else {
-			cil_printf("(iomemcon (%#lX %#lX) ", (unsigned long)low, (unsigned long)high);
+			cil_printf("(iomemcon (0x%"PRIx64" 0x%"PRIx64") ", low, high);
 		}
 
 		context_to_cil(pdb, &iomem->context[0]);
@@ -2896,7 +2897,7 @@ static int ocontext_xen_pcidevice_to_cil(struct policydb *pdb, struct ocontext *
 	struct ocontext *pcid;
 
 	for (pcid = pcids; pcid != NULL; pcid = pcid->next) {
-		cil_printf("(pcidevicecon %#lx ", (unsigned long)pcid->u.device);
+		cil_printf("(pcidevicecon 0x%lx ", (unsigned long)pcid->u.device);
 		context_to_cil(pdb, &pcid->context[0]);
 		cil_printf(")\n");
 	}
-- 
2.7.4
