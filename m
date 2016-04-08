Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u38F1FTh004320
 for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2016 11:01:15 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2 v3] policycoreutils/hll/pp: Warn if module name different
 than output filename
Date: Fri,  8 Apr 2016 11:02:32 -0400
Message-Id: <1460127753-29728-2-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1460127753-29728-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1460127753-29728-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since CIL treats files as modules and does not have a separate
module statement it can cause confusion when a Refpolicy module
has a name that is not the same as its base filename because older
SELinux userspaces will refer to the module by its module name while
a CIL-based userspace will refer to it by its filename.

Because of this, provide a warning message when converting a policy
package to CIL and the output filename is different than the module
name.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 policycoreutils/hll/pp/pp.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index 866734f..9245975 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -28,6 +28,7 @@
 
 #include <sepol/module.h>
 #include <sepol/module_to_cil.h>
+#include <sepol/policydb/module.h>
 
 char *progname;
 
@@ -68,6 +69,8 @@ int main(int argc, char **argv)
 		{ NULL, 0, NULL, 0 }
 	};
 	struct sepol_module_package *mod_pkg = NULL;
+	char *ifile = NULL;
+	char *ofile = NULL;
 	FILE *in = NULL;
 	FILE *out = NULL;
 	int outfd = -1;
@@ -89,20 +92,23 @@ int main(int argc, char **argv)
 	}
 
 	if (argc >= optind + 1 && strcmp(argv[1], "-") != 0) {
-		in = fopen(argv[1], "rb");
+		ifile = argv[1];
+		in = fopen(ifile, "rb");
 		if (in == NULL) {
-			log_err("Failed to open %s: %s", argv[1], strerror(errno));
+			log_err("Failed to open %s: %s", ifile, strerror(errno));
 			rc = -1;
 			goto exit;
 		}
 	} else {
+		ifile = "stdin";
 		in = stdin;
 	}
 
 	if (argc >= optind + 2 && strcmp(argv[2], "-") != 0) {
-		out = fopen(argv[2], "w");
+		ofile = argv[2];
+		out = fopen(ofile, "w");
 		if (out == NULL) {
-			log_err("Failed to open %s: %s", argv[2], strerror(errno));
+			log_err("Failed to open %s: %s", ofile, strerror(errno));
 			rc = -1;
 			goto exit;
 		}
@@ -122,6 +128,25 @@ int main(int argc, char **argv)
 	fclose(in);
 	in = NULL;
 
+	if (ofile) {
+		char *mod_name = mod_pkg->policy->p.name;
+		char *cil_path = strdup(ofile);
+		if (cil_path == NULL) {
+			log_err("No memory available for strdup\n");
+			rc = -1;
+			goto exit;
+		}
+		char *cil_name = basename(cil_path);
+		char *separator = strrchr(cil_name, '.');
+		if (separator) {
+			*separator = '\0';
+		}
+		if (strcmp(mod_name, cil_name) != 0) {
+			fprintf(stderr,	"Warning: SELinux userspace will refer to the module from %s as %s rather than %s\n", ifile, cil_name, mod_name);
+		}
+		free(cil_path);
+	}
+
 	rc = sepol_module_package_to_cil(out, mod_pkg);
 	if (rc != 0) {
 		goto exit;
-- 
2.5.5
