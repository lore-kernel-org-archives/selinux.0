Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2KFIa8Q027563
 for <selinux@tycho.nsa.gov>; Mon, 20 Mar 2017 11:18:36 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] libsepol/cil: Use hexadecimal numbers when writing Xen
 rules
Date: Mon, 20 Mar 2017 11:18:59 -0400
Message-Id: <1490023139-12045-4-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1490023139-12045-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1490023139-12045-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When writing a policy.conf file from CIL source, use hexadecimal
numbers in ioportcon, iomemcon, and pcidevicecon rules.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_policy.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 2e6814a..77179e6 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1831,7 +1831,11 @@ static void cil_iomemcons_to_policy(FILE *out, struct cil_sort *iomemcons, int m
 
 	for (i = 0; i<iomemcons->count; i++) {
 		iomemcon = iomemcons->array[i];
-		fprintf(out, "iomemcon %" PRIu64 "-%" PRIu64 " ", iomemcon->iomem_low, iomemcon->iomem_high);
+		if (iomemcon->iomem_low == iomemcon->iomem_high) {
+			fprintf(out, "iomemcon %"PRIx64" ", iomemcon->iomem_low);
+		} else {
+			fprintf(out, "iomemcon %"PRIx64"-%"PRIx64" ", iomemcon->iomem_low, iomemcon->iomem_high);
+		}
 		cil_context_to_policy(out, iomemcon->context, mls);
 		fprintf(out, ";\n");
 	}
@@ -1844,7 +1848,7 @@ static void cil_ioportcons_to_policy(FILE *out, struct cil_sort *ioportcons, int
 
 	for (i = 0; i < ioportcons->count; i++) {
 		ioportcon = ioportcons->array[i];
-		fprintf(out, "ioportcon %d-%d ", ioportcon->ioport_low, ioportcon->ioport_high);
+		fprintf(out, "ioportcon 0x%x-0x%x ", ioportcon->ioport_low, ioportcon->ioport_high);
 		cil_context_to_policy(out, ioportcon->context, mls);
 		fprintf(out, ";\n");
 	}
@@ -1857,7 +1861,7 @@ static void cil_pcidevicecons_to_policy(FILE *out, struct cil_sort *pcidevicecon
 
 	for (i = 0; i < pcidevicecons->count; i++) {
 		pcidevicecon = pcidevicecons->array[i];
-		fprintf(out, "pcidevicecon %d ", pcidevicecon->dev);
+		fprintf(out, "pcidevicecon 0x%x ", pcidevicecon->dev);
 		cil_context_to_policy(out, pcidevicecon->context, mls);
 		fprintf(out, ";\n");
 	}
-- 
2.7.4
