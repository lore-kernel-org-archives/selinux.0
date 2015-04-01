Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t31Ex6Ql011705
 for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2015 10:59:06 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3 v4] checkpolicy: Add support for generating CIL
Date: Wed,  1 Apr 2015 11:01:26 -0400
Message-Id: <1427900486-6560-4-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1427900486-6560-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1427900486-6560-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add support to checkpolicy and checkmodule for generating CIL as their
output.

Add new options "-C" and "--cil" to specify CIL as the output format.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 checkpolicy/checkmodule.8 |  5 ++-
 checkpolicy/checkmodule.c | 63 +++++++++++++++++++++--------------
 checkpolicy/checkpolicy.8 |  5 ++-
 checkpolicy/checkpolicy.c | 83 +++++++++++++++++++++++++++++++----------------
 4 files changed, 102 insertions(+), 54 deletions(-)

diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
index 2a7ab5c..ee95882 100644
--- a/checkpolicy/checkmodule.8
+++ b/checkpolicy/checkmodule.8
@@ -3,7 +3,7 @@
 checkmodule \- SELinux policy module compiler
 .SH SYNOPSIS
 .B checkmodule
-.I "[\-h] [\-b] [\-m] [\-M] [\-U handle_unknown ] [\-V] [\-o output_file] [input_file]"
+.I "[\-h] [\-b] [\-C] [\-m] [\-M] [\-U handle_unknown ] [\-V] [\-o output_file] [input_file]"
 .SH "DESCRIPTION"
 This manual page describes the
 .BR checkmodule
@@ -25,6 +25,9 @@ the module package into the module store and load the resulting policy.
 Read an existing binary policy module file rather than a source policy
 module file.  This option is a development/debugging aid.
 .TP
+.B \-C,\-\-cil
+Write CIL policy file rather than binary policy file.
+.TP
 .B \-h,\-\-help
 Print usage.
 .TP
diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index 0255928..6561b9e 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -20,6 +20,7 @@
 #include <errno.h>
 #include <sys/mman.h>
 
+#include <sepol/module_to_cil.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/services.h>
 #include <sepol/policydb/conditional.h>
@@ -108,20 +109,9 @@ static int read_binary_policy(policydb_t * p, const char *file, const char *prog
 	return 0;
 }
 
-static int write_binary_policy(policydb_t * p, const char *file, char *progname)
+static int write_binary_policy(policydb_t * p, FILE *outfp)
 {
-	FILE *outfp = NULL;
 	struct policy_file pf;
-	int ret;
-
-	printf("%s:  writing binary representation (version %d) to %s\n",
-	       progname, policyvers, file);
-
-	outfp = fopen(file, "w");
-	if (!outfp) {
-		perror(file);
-		exit(1);
-	}
 
 	p->policy_type = policy_type;
 	p->policyvers = policyvers;
@@ -130,13 +120,7 @@ static int write_binary_policy(policydb_t * p, const char *file, char *progname)
 	policy_file_init(&pf);
 	pf.type = PF_USE_STDIO;
 	pf.fp = outfp;
-	ret = policydb_write(p, &pf);
-	if (ret) {
-		fprintf(stderr, "%s:  error writing %s\n", progname, file);
-		return -1;
-	}
-	fclose(outfp);
-	return 0;
+	return policydb_write(p, &pf);
 }
 
 static void usage(char *progname)
@@ -162,7 +146,7 @@ static void usage(char *progname)
 int main(int argc, char **argv)
 {
 	const char *file = txtfile, *outfile = NULL;
-	unsigned int binary = 0;
+	unsigned int binary = 0, cil = 0;
 	int ch;
 	int show_version = 0;
 	policydb_t modpolicydb;
@@ -173,10 +157,11 @@ int main(int argc, char **argv)
 		{"version", no_argument, NULL, 'V'},
 		{"handle-unknown", required_argument, NULL, 'U'},
 		{"mls", no_argument, NULL, 'M'},
+		{"cil", no_argument, NULL, 'C'},
 		{NULL, 0, NULL, 0}
 	};
 
-	while ((ch = getopt_long(argc, argv, "ho:bVU:mM", long_options, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "ho:bVU:mMC", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'h':
 			usage(argv[0]);
@@ -212,6 +197,9 @@ int main(int argc, char **argv)
 		case 'M':
 			mlspol = 1;
 			break;
+		case 'C':
+			cil = 1;
+			break;
 		default:
 			usage(argv[0]);
 		}
@@ -269,7 +257,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (modpolicydb.policy_type == POLICY_BASE) {
+	if (modpolicydb.policy_type == POLICY_BASE && !cil) {
 		/* Verify that we can successfully expand the base module. */
 		policydb_t kernpolicydb;
 
@@ -295,10 +283,37 @@ int main(int argc, char **argv)
 
 	printf("%s:  policy configuration loaded\n", argv[0]);
 
-	if (outfile &&
-	    write_binary_policy(&modpolicydb, outfile, argv[0]) == -1) {
+	if (outfile) {
+		FILE *outfp = fopen(outfile, "w");
+
+		if (!outfp) {
+			perror(outfile);
+			exit(1);
+		}
+
+		if (!cil) {
+			printf("%s:  writing binary representation (version %d) to %s\n",
+				   argv[0], policyvers, file);
+
+			if (write_binary_policy(&modpolicydb, outfp) != 0) {
+				fprintf(stderr, "%s:  error writing %s\n", argv[0], outfile);
+				exit(1);
+			}
+		} else {
+			printf("%s:  writing CIL to %s\n",argv[0], outfile);
+
+			if (sepol_module_policydb_to_cil(outfp, &modpolicydb, 0) != 0) {
+				fprintf(stderr, "%s:  error writing %s\n", argv[0], outfile);
+				exit(1);
+			}
+		}
+
+		fclose(outfp);
+	} else if (cil) {
+		fprintf(stderr, "%s:  No file to write CIL was specified\n", argv[0]);
 		exit(1);
 	}
+
 	policydb_destroy(&modpolicydb);
 
 	return 0;
diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index 0086bdc..600d5cd 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -3,7 +3,7 @@
 checkpolicy \- SELinux policy compiler
 .SH SYNOPSIS
 .B checkpolicy
-.I "[\-b] [\-d] [\-M] [\-c policyvers] [\-o output_file] [input_file]"
+.I "[\-b] [\-C] [\-d] [\-M] [\-c policyvers] [\-o output_file] [input_file]"
 .br
 .SH "DESCRIPTION"
 This manual page describes the
@@ -21,6 +21,9 @@ policy.conf or policy, depending on whether the \-b flag is specified.
 .B \-b,\-\-binary
 Read an existing binary policy file rather than a source policy.conf file.
 .TP
+.B \-C,\-\-cil
+Write CIL policy file rather than binary policy file.
+.TP
 .B \-d,\-\-debug
 Enter debug mode after loading the policy.
 .TP
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 61a2e89..5186f7f 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -74,6 +74,7 @@
 #include <ctype.h>
 #endif
 
+#include <sepol/module_to_cil.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/services.h>
 #include <sepol/policydb/conditional.h>
@@ -376,6 +377,7 @@ static int check_level(hashtab_key_t key, hashtab_datum_t datum, void *arg __att
 
 int main(int argc, char **argv)
 {
+	policydb_t parse_policy;
 	sepol_security_class_t tclass;
 	sepol_security_id_t ssid, tsid, *sids, oldsid, newsid, tasksid;
 	sepol_security_context_t scontext;
@@ -386,7 +388,7 @@ int main(int argc, char **argv)
 	size_t scontext_len, pathlen;
 	unsigned int i;
 	unsigned int protocol, port;
-	unsigned int binary = 0, debug = 0;
+	unsigned int binary = 0, debug = 0, cil = 0;
 	struct val_to_name v;
 	int ret, ch, fd, target = SEPOL_TARGET_SELINUX;
 	unsigned int nel, uret;
@@ -408,11 +410,12 @@ int main(int argc, char **argv)
 		{"version", no_argument, NULL, 'V'},
 		{"handle-unknown", required_argument, NULL, 'U'},
 		{"mls", no_argument, NULL, 'M'},
+		{"cil", no_argument, NULL, 'C'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
 	};
 
-	while ((ch = getopt_long(argc, argv, "o:t:dbU:MVc:h", long_options, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "o:t:dbU:MCVc:h", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'o':
 			outfile = optarg;
@@ -455,6 +458,9 @@ int main(int argc, char **argv)
 		case 'M':
 			mlspol = 1;
 			break;
+		case 'C':
+			cil = 1;
+			break;
 		case 'c':{
 				long int n;
 				errno = 0;
@@ -505,6 +511,11 @@ int main(int argc, char **argv)
 	sepol_set_sidtab(&sidtab);
 
 	if (binary) {
+		if (cil) {
+			fprintf(stderr,	"%s:  Converting kernel policy to CIL is not supported\n",
+				argv[0]);
+			exit(1);
+		}
 		fd = open(file, O_RDONLY);
 		if (fd < 0) {
 			fprintf(stderr, "Can't open '%s':  %s\n",
@@ -557,8 +568,6 @@ int main(int argc, char **argv)
 			}
 		}
 	} else {
-		policydb_t parse_policy;
-
 		if (policydb_init(&parse_policy))
 			exit(1);
 		/* We build this as a base policy first since that is all the parser understands */
@@ -577,23 +586,24 @@ int main(int argc, char **argv)
 		if (hashtab_map(policydbp->p_levels.table, check_level, NULL))
 			exit(1);
 
-		if (policydb_init(&policydb)) {
-			fprintf(stderr, "%s:  policydb_init failed\n", argv[0]);
-			exit(1);
-		}
-
 		/* Linking takes care of optional avrule blocks */
-		if (link_modules(NULL, &parse_policy, NULL, 0, 0)) {
+		if (link_modules(NULL, policydbp, NULL, 0, 0)) {
 			fprintf(stderr, "Error while resolving optionals\n");
 			exit(1);
 		}
 
-		if (expand_module(NULL, &parse_policy, &policydb, 0, 1)) {
-			fprintf(stderr, "Error while expanding policy\n");
-			exit(1);
+		if (!cil) {
+			if (policydb_init(&policydb)) {
+				fprintf(stderr, "%s:  policydb_init failed\n", argv[0]);
+				exit(1);
+			}
+			if (expand_module(NULL, policydbp, &policydb, 0, 1)) {
+				fprintf(stderr, "Error while expanding policy\n");
+				exit(1);
+			}
+			policydb_destroy(policydbp);
+			policydbp = &policydb;
 		}
-		policydb_destroy(&parse_policy);
-		policydbp = &policydb;
 	}
 
 	if (policydb_load_isids(&policydb, &sidtab))
@@ -602,29 +612,46 @@ int main(int argc, char **argv)
 	printf("%s:  policy configuration loaded\n", argv[0]);
 
 	if (outfile) {
-		printf
-		    ("%s:  writing binary representation (version %d) to %s\n",
-		     argv[0], policyvers, outfile);
 		outfp = fopen(outfile, "w");
 		if (!outfp) {
 			perror(outfile);
 			exit(1);
 		}
 
-		policydb.policy_type = POLICY_KERN;
 		policydb.policyvers = policyvers;
 
-		policy_file_init(&pf);
-		pf.type = PF_USE_STDIO;
-		pf.fp = outfp;
-		ret = policydb_write(&policydb, &pf);
-		if (ret) {
-			fprintf(stderr, "%s:  error writing %s\n",
-				argv[0], outfile);
-			exit(1);
+		if (!cil) {
+			printf
+				("%s:  writing binary representation (version %d) to %s\n",
+				 argv[0], policyvers, outfile);
+			policydb.policy_type = POLICY_KERN;
+
+			policy_file_init(&pf);
+			pf.type = PF_USE_STDIO;
+			pf.fp = outfp;
+			ret = policydb_write(&policydb, &pf);
+			if (ret) {
+				fprintf(stderr, "%s:  error writing %s\n",
+						argv[0], outfile);
+				exit(1);
+			}
+		} else {
+			printf("%s:  writing CIL to %s\n",argv[0], outfile);
+			ret = sepol_module_policydb_to_cil(outfp, policydbp, 1);
+			if (ret) {
+				fprintf(stderr, "%s:  error writing %s\n", argv[0], outfile);
+				exit(1);
+			}
+		}
+
+		if (outfile) {
+			fclose(outfp);
 		}
-		fclose(outfp);
+	} else if (cil) {
+		fprintf(stderr, "%s:  No file to write CIL was specified\n", argv[0]);
+		exit(1);
 	}
+
 	if (!debug) {
 		policydb_destroy(&policydb);
 		exit(0);
-- 
1.9.3
