Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u45Kgehp013386
 for <selinux@tycho.nsa.gov>; Thu, 5 May 2016 16:42:41 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 6/6 v3] libsepol: When generating CIL use HLL line mark for
 neverallows
Date: Thu,  5 May 2016 16:44:19 -0400
Message-Id: <1462481059-12437-7-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1462481059-12437-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1462481059-12437-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When converting pp files to CIL or generating CIL using checkpolicy
or checkmodule use CIL's HLL line mark annotations to record the
original file and line numbers for neverallow rules so that CIL can
produce more informative error messages. (Unfortunately, the original
line number information is not saved in pp files, so there is no benefit
for policy modules.)

This is only done for neverallow rules currently.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/module_to_cil.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 38f0dc3..b9a4af7 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1073,6 +1073,10 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 	struct type_set *ts;
 
 	for (avrule = avrule_list; avrule != NULL; avrule = avrule->next) {
+		if (avrule->specified == AVRULE_NEVERALLOW && avrule->source_filename) {
+			cil_println(0, ";;* lmx %lu %s\n",avrule->source_line, avrule->source_filename);
+		}
+
 		ts = &avrule->stypes;
 		rc = process_typeset(indent, pdb, ts, attr_list, &snames, &num_snames);
 		if (rc != 0) {
@@ -1103,6 +1107,10 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 
 		names_destroy(&snames, &num_snames);
 		names_destroy(&tnames, &num_tnames);
+
+		if (avrule->specified == AVRULE_NEVERALLOW && avrule->source_filename) {
+			cil_println(0, ";;* lme\n");
+		}
 	}
 
 	return 0;
-- 
2.5.5
