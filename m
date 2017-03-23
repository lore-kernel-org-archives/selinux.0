Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NGmXYT001400
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 12:48:34 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3 v3] checkpolicy: Add options to convert binary policy to
 CIL or a policy.conf
Date: Thu, 23 Mar 2017 12:48:57 -0400
Message-Id: <1490287737-31103-4-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1490287737-31103-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1490287737-31103-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Use the same option "-C" used to ouput CIL from a policy.conf, but now
generate CIL from a binary policy instead of giving an error.i

Use the option "-F" to generate a policy.conf file from a binary policy.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 checkpolicy/checkpolicy.8 |  5 ++++-
 checkpolicy/checkpolicy.c | 55 +++++++++++++++++++++++++++++++----------------
 2 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index 600d5cd..7b28696 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -3,7 +3,7 @@
 checkpolicy \- SELinux policy compiler
 .SH SYNOPSIS
 .B checkpolicy
-.I "[\-b] [\-C] [\-d] [\-M] [\-c policyvers] [\-o output_file] [input_file]"
+.I "[\-b[F]] [\-C] [\-d] [\-M] [\-c policyvers] [\-o output_file] [input_file]"
 .br
 .SH "DESCRIPTION"
 This manual page describes the
@@ -27,6 +27,9 @@ Write CIL policy file rather than binary policy file.
 .B \-d,\-\-debug
 Enter debug mode after loading the policy.
 .TP
+.B \-F,\-\-conf
+Write policy.conf file rather than binary policy file. Can only be used with binary policy file.
+.TP
 .B \-M,\-\-mls
 Enable the MLS policy when checking and compiling the policy.
 .TP
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index b744d6a..534fc22 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -75,6 +75,8 @@
 #include <sys/mman.h>
 
 #include <sepol/module_to_cil.h>
+#include <sepol/kernel_to_cil.h>
+#include <sepol/kernel_to_conf.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/services.h>
 #include <sepol/policydb/conditional.h>
@@ -105,7 +107,7 @@ unsigned int policyvers = POLICYDB_VERSION_MAX;
 static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	printf
-	    ("usage:  %s [-b] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M]"
+	    ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M]"
 	     "[-c policyvers (%d-%d)] [-o output_file] [-t target_platform (selinux,xen)]"
 	     "[input_file]\n",
 	     progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
@@ -388,7 +390,7 @@ int main(int argc, char **argv)
 	size_t scontext_len, pathlen;
 	unsigned int i;
 	unsigned int protocol, port;
-	unsigned int binary = 0, debug = 0, cil = 0;
+	unsigned int binary = 0, debug = 0, cil = 0, conf = 0;
 	struct val_to_name v;
 	int ret, ch, fd, target = SEPOL_TARGET_SELINUX;
 	unsigned int nel, uret;
@@ -411,11 +413,12 @@ int main(int argc, char **argv)
 		{"handle-unknown", required_argument, NULL, 'U'},
 		{"mls", no_argument, NULL, 'M'},
 		{"cil", no_argument, NULL, 'C'},
+		{"conf",no_argument, NULL, 'F'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
 	};
 
-	while ((ch = getopt_long(argc, argv, "o:t:dbU:MCVc:h", long_options, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "o:t:dbU:MCFVc:h", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'o':
 			outfile = optarg;
@@ -461,6 +464,9 @@ int main(int argc, char **argv)
 		case 'C':
 			cil = 1;
 			break;
+		case 'F':
+			conf = 1;
+			break;
 		case 'c':{
 				long int n;
 				errno = 0;
@@ -510,12 +516,12 @@ int main(int argc, char **argv)
 	sepol_set_policydb(&policydb);
 	sepol_set_sidtab(&sidtab);
 
+	if (cil && conf) {
+		fprintf(stderr, "Can't convert to CIL and policy.conf at the same time\n");
+		exit(1);
+	}
+
 	if (binary) {
-		if (cil) {
-			fprintf(stderr,	"%s:  Converting kernel policy to CIL is not supported\n",
-				argv[0]);
-			exit(1);
-		}
 		fd = open(file, O_RDONLY);
 		if (fd < 0) {
 			fprintf(stderr, "Can't open '%s':  %s\n",
@@ -568,6 +574,10 @@ int main(int argc, char **argv)
 			}
 		}
 	} else {
+		if (conf) {
+			fprintf(stderr, "Can only generate policy.conf from binary policy\n");
+			exit(1);
+		}
 		if (policydb_init(&parse_policy))
 			exit(1);
 		/* We build this as a base policy first since that is all the parser understands */
@@ -621,15 +631,20 @@ int main(int argc, char **argv)
 		policydb.policyvers = policyvers;
 
 		if (!cil) {
-			printf
-				("%s:  writing binary representation (version %d) to %s\n",
-				 argv[0], policyvers, outfile);
-			policydb.policy_type = POLICY_KERN;
-
-			policy_file_init(&pf);
-			pf.type = PF_USE_STDIO;
-			pf.fp = outfp;
-			ret = policydb_write(&policydb, &pf);
+			if (!conf) {
+				printf("%s:  writing binary representation (version %d) to %s\n", argv[0], policyvers, outfile);
+
+				policydb.policy_type = POLICY_KERN;
+
+				policy_file_init(&pf);
+				pf.type = PF_USE_STDIO;
+				pf.fp = outfp;
+				ret = policydb_write(&policydb, &pf);
+			} else {
+				printf("%s:  writing policy.conf to %s\n",
+				       argv[0], outfile);
+				ret = sepol_kernel_policydb_to_conf(outfp, policydbp);
+			}
 			if (ret) {
 				fprintf(stderr, "%s:  error writing %s\n",
 						argv[0], outfile);
@@ -637,7 +652,11 @@ int main(int argc, char **argv)
 			}
 		} else {
 			printf("%s:  writing CIL to %s\n",argv[0], outfile);
-			ret = sepol_module_policydb_to_cil(outfp, policydbp, 1);
+			if (binary) {
+				ret = sepol_kernel_policydb_to_cil(outfp, policydbp);
+			} else {
+				ret = sepol_module_policydb_to_cil(outfp, policydbp, 1);
+			}
 			if (ret) {
 				fprintf(stderr, "%s:  error writing %s\n", argv[0], outfile);
 				exit(1);
-- 
2.7.4
