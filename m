Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u38F1FTi004320
 for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2016 11:01:15 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2 v3] checkpolicy: Fail if module name different than output
 base filename
Date: Fri,  8 Apr 2016 11:02:33 -0400
Message-Id: <1460127753-29728-3-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1460127753-29728-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1460127753-29728-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since CIL treats files as modules and does not have a separate
module statement it can cause confusion when a Refpolicy module
has a name that is different than its base filename because older
SELinux userspaces will refer to the module by its module name while
a CIL-based userspace will refer to it by its filename.

Because of this, have checkmodule fail when compiling a module and
the output base filename is different than the module name.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 checkpolicy/checkmodule.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index 5957d29..418f77b 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -19,6 +19,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <sys/mman.h>
+#include <libgen.h>
 
 #include <sepol/module_to_cil.h>
 #include <sepol/policydb/policydb.h>
@@ -258,6 +259,25 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (policy_type != POLICY_BASE && outfile) {
+		char *mod_name = modpolicydb.name;
+		char *out_path = strdup(outfile);
+		if (out_path == NULL) {
+			fprintf(stderr, "%s:  out of memory\n", argv[0]);
+			exit(1);
+		}
+		char *out_name = basename(out_path);
+		char *separator = strrchr(out_name, '.');
+		if (separator) {
+			*separator = '\0';
+		}
+		if (strcmp(mod_name, out_name) != 0) {
+			fprintf(stderr,	"%s:  Module name %s is different than the output base filename %s\n", argv[0], mod_name, out_name);
+			exit(1);
+		}
+		free(out_path);
+	}
+
 	if (modpolicydb.policy_type == POLICY_BASE && !cil) {
 		/* Verify that we can successfully expand the base module. */
 		policydb_t kernpolicydb;
-- 
2.5.5
