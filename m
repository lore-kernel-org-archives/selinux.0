Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t76EUWJL018630
 for <selinux@tycho.nsa.gov>; Thu, 6 Aug 2015 10:30:34 -0400
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH v2 3/3] policycoreutils/semodule: update semodule to allow
 extracting modules
Date: Thu, 6 Aug 2015 10:30:14 -0400
Message-ID: <1438871414-62292-4-git-send-email-ykhodorkovskiy@tresys.com>
In-Reply-To: <1438871414-62292-1-git-send-email-ykhodorkovskiy@tresys.com>
References: <1438871414-62292-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add --extract/-E, --cil/-c, and --hll/-H to extract modules. If -c/-H
are not provided, the module will be output as HLL by default. Only
--cil or --hll (which will use the lang_ext in the semodule store) are valid
options to use with -E. The module is written to the current working directory
as <module_name>.<lang_ext>.

If a module exists as HLL and is exported as CIL, it will first compile into
CIL and cache to the module store. Once compiled, exporting will
continue.

If no priority is provided when extracting a module, then extraction at
the default priority, 400, will be attempted. If the module does not
exist at the default priority, then it will be exported at the highest
existing priority.

Examples:

Extract the wireshark module in a .cil format. If the module only exists
as HLL on the system, the module will be compiled into CIL and placed
into the module store. This command will then write wireshark.cil to the CWD.

    semodule --cil --extract wireshark

Extract the wireshark module in HLL format. Since the original HLL file
was a policy package, a wireshark.pp will be written to the CWD.

    semodule -E wireshark

Extract the wireshark module as CIL and HLL and extract the puppet
module as CIL at priority 400.

    semodule --hll -E wireshark --cil -E wireshark -X 400 --cil -E puppet

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 policycoreutils/semodule/semodule.8 |  14 ++++
 policycoreutils/semodule/semodule.c | 146 +++++++++++++++++++++++++++++++++++-
 2 files changed, 156 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index dde0efb..9cd04e7 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -41,6 +41,11 @@ remove existing module
 .B  \-l,\-\-list-modules=[KIND]
 display list of installed modules (other than base)
 .TP
+.B  \-E,\-\-extract=MODULE_PKG
+Extract a module from the store as an HLL or CIL file to the current directory.
+A module is extracted as HLL by default. The name of the module written is
+<module-name>.<lang_ext>
+.TP
 .B  KIND:
 .TP
 standard
@@ -81,6 +86,12 @@ Use an alternate path for the policy store root
 .TP
 .B  \-v,\-\-verbose     
 be verbose
+.TP
+.B  \-c,\-\-cil
+Extract module as a CIL file. This only affects the \-\-extract option.
+.TP
+.B  \-H,\-\-hll
+Extract module as an HLL file. This only affects the \-\-extract option.
 
 .SH EXAMPLE
 .nf
@@ -108,6 +119,9 @@ $ semodule \-l full
 $ semodule \-B \-p "/tmp"
 # Set an alternate path for the policy store root
 $ semodule \-B \-S "/tmp/var/lib/selinux"
+# Write the HLL version of puppet and the CIL version of wireshark
+# modules at priority 400 to the current working directory
+$ semodule \-X 400 \-g wireshark \-\-cil \-g puppet \-\-hll
 .fi
 
 .SH SEE ALSO
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index baff057..bcfaa2b 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -20,16 +20,17 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <libgen.h>
+#include <limits.h>
 
 #include <semanage/modules.h>
 
 enum client_modes {
-	NO_MODE, INSTALL_M, REMOVE_M,
+	NO_MODE, INSTALL_M, REMOVE_M, EXTRACT_M, CIL_M, HLL_M,
 	LIST_M, RELOAD, PRIORITY_M, ENABLE_M, DISABLE_M
 };
 /* list of modes in which one ought to commit afterwards */
 static const int do_commit[] = {
-	0, 1, 1,
+	0, 1, 1, 0, 0, 0,
 	0, 0, 0, 1, 1,
 };
 
@@ -49,10 +50,12 @@ static int disable_dontaudit;
 static int preserve_tunables;
 static int ignore_module_cache;
 static uint16_t priority;
+static int priority_set = 0;
 
 static semanage_handle_t *sh = NULL;
 static char *store;
 static char *store_root;
+int extract_cil = 0;
 
 extern char *optarg;
 extern int optind;
@@ -130,6 +133,7 @@ static void usage(char *progname)
 	printf("  -X,--priority=PRIORITY    set priority for following operations (1-999)\n");
 	printf("  -e,--enable=MODULE_NAME   enable module\n");
 	printf("  -d,--disable=MODULE_NAME  disable module\n");
+	printf("  -E,--extract=MODULE_NAME  extract module\n");
 	printf("Other options:\n");
 	printf("  -s,--store	   name of the store to operate on\n");
 	printf("  -N,-n,--noreload do not reload policy after commit\n");
@@ -140,6 +144,8 @@ static void usage(char *progname)
 	printf("  -C,--ignore-module-cache	Rebuild CIL modules compiled from HLL files\n");
 	printf("  -p,--path        use an alternate path for the policy root\n");
 	printf("  -S,--store-path  use an alternate path for the policy store root\n");
+	printf("  -c, --cil extract module as cil. This only affects module extraction.\n");
+	printf("  -H, --hll extract module as hll. This only affects module extraction.\n");
 }
 
 /* Sets the global mode variable to new_mode, but only if no other
@@ -175,6 +181,9 @@ static void parse_command_line(int argc, char **argv)
 		{"base", required_argument, NULL, 'b'},
 		{"help", 0, NULL, 'h'},
 		{"install", required_argument, NULL, 'i'},
+		{"extract", required_argument, NULL, 'E'},
+		{"cil", 0, NULL, 'c'},
+		{"hll", 0, NULL, 'H'},
 		{"list-modules", optional_argument, NULL, 'l'},
 		{"verbose", 0, NULL, 'v'},
 		{"remove", required_argument, NULL, 'r'},
@@ -192,13 +201,15 @@ static void parse_command_line(int argc, char **argv)
 		{"store-path", required_argument, NULL, 'S'},
 		{NULL, 0, NULL, 0}
 	};
+	int extract_selected = 0;
+	int cil_hll_set = 0;
 	int i;
 	verbose = 0;
 	reload = 0;
 	no_reload = 0;
 	priority = 400;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:l::vqr:u:RnNBDCPX:e:d:p:S:", opts,
+		getopt_long(argc, argv, "s:b:hi:l::vqr:u:RnNBDCPX:e:d:p:S:E:cH", opts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'b':
@@ -211,6 +222,18 @@ static void parse_command_line(int argc, char **argv)
 		case 'i':
 			set_mode(INSTALL_M, optarg);
 			break;
+		case 'E':
+			set_mode(EXTRACT_M, optarg);
+			extract_selected = 1;
+			break;
+		case 'c':
+			set_mode(CIL_M, NULL);
+			cil_hll_set = 1;
+			break;
+		case 'H':
+			set_mode(HLL_M, NULL);
+			cil_hll_set = 1;
+			break;
 		case 'l':
 			set_mode(LIST_M, optarg);
 			break;
@@ -281,10 +304,15 @@ static void parse_command_line(int argc, char **argv)
 		usage(argv[0]);
 		exit(1);
 	}
+	if (extract_selected == 0 && cil_hll_set == 1) {
+		fprintf(stderr, "--cil and --hll require a module to export with the --extract option.\n");
+		usage(argv[0]);
+		exit(1);
+	}
 
 	if (optind < argc) {
 		int mode;
-		/* if -i/u/r was the last command treat any remaining
+		/* if -i/u/r/E was the last command treat any remaining
 		 * arguments as args. Will allow 'semodule -i *.pp' to
 		 * work as expected.
 		 */
@@ -293,6 +321,8 @@ static void parse_command_line(int argc, char **argv)
 			mode = INSTALL_M;
 		} else if (commands && commands[num_commands - 1].mode == REMOVE_M) {
 			mode = REMOVE_M;
+		} else if (commands && commands[num_commands - 1].mode == EXTRACT_M) {
+			mode = EXTRACT_M;
 		} else {
 			fprintf(stderr, "unknown additional arguments:\n");
 			while (optind < argc)
@@ -389,6 +419,113 @@ int main(int argc, char *argv[])
 				    semanage_module_install_file(sh, mode_arg);
 				break;
 			}
+		case EXTRACT_M:{
+				semanage_module_info_t *extract_info = NULL;
+				semanage_module_key_t *modkey = NULL;
+				uint16_t curr_priority;
+				void *data = NULL;
+				size_t data_len = 0;
+				char output_path[PATH_MAX];
+				const char *output_name = NULL;
+				const char *lang_ext = NULL;
+				int rlen;
+				FILE *output_fd = NULL;
+
+				result = semanage_module_key_create(sh, &modkey);
+				if (result != 0) {
+					goto cleanup_extract;
+				}
+
+				result = semanage_module_key_set_name(sh, modkey, mode_arg);
+				if (result != 0) {
+					goto cleanup_extract;
+				}
+
+				if (priority_set == 0) {
+					result = semanage_module_get_module_info(sh, modkey, &extract_info);
+					if (result != 0) {
+						goto cleanup_extract;
+					}
+
+					semanage_module_info_get_priority(sh, extract_info, &curr_priority);
+					printf("Module '%s' does not exist at the default priority '%d'. "
+							"Extracting at highest existing priority '%d'.\n", mode_arg, priority, curr_priority);
+					priority = curr_priority;
+				}
+
+				result  = semanage_module_key_set_priority(sh, modkey, priority);
+				if (result != 0) {
+					goto cleanup_extract;
+				}
+
+				if (verbose) {
+					printf
+						("Attempting to extract module '%s':\n",
+							mode_arg);
+				}
+				result = semanage_module_extract(sh, modkey, extract_cil, &data, &data_len, &extract_info);
+				if (result != 0) {
+					goto cleanup_extract;
+				}
+
+				if (extract_cil) {
+					lang_ext = "cil";
+				} else {
+					result = semanage_module_info_get_lang_ext(sh, extract_info, &lang_ext);
+					if (result != 0) {
+						goto cleanup_extract;
+					}
+				}
+
+				result = semanage_module_info_get_name(sh, extract_info, &output_name);
+				if (result != 0) {
+					goto cleanup_extract;
+				}
+
+				rlen = snprintf(output_path, PATH_MAX, "%s.%s", output_name, lang_ext);
+				if (rlen < 0 || rlen >= PATH_MAX) {
+					fprintf(stderr, "%s: Failed to generate output path.\n", argv[0]);
+					result = -1;
+					goto cleanup_extract;
+				}
+
+				if (access(output_path, F_OK) == 0) {
+					fprintf(stderr, "%s: %s is already extracted with extension %s.\n", argv[0], mode_arg, lang_ext);
+					result = -1;
+					goto cleanup_extract;
+				}
+
+				output_fd = fopen(output_path, "w");
+				if (output_fd == NULL) {
+					fprintf(stderr, "%s: Unable to open %s\n", argv[0], output_path);
+					result = -1;
+					goto cleanup_extract;
+				}
+
+				if (fwrite(data, 1, data_len, output_fd) < data_len) {
+					fprintf(stderr, "%s: Unable to write to %s\n", argv[0], output_path);
+					result = -1;
+					goto cleanup_extract;
+				}
+cleanup_extract:
+				if (output_fd != NULL) {
+					fclose(output_fd);
+				}
+				if (data_len > 0) {
+					munmap(data, data_len);
+				}
+				semanage_module_info_destroy(sh, extract_info);
+				free(extract_info);
+				semanage_module_key_destroy(sh, modkey);
+				free(modkey);
+				break;
+			}
+		case CIL_M:
+				extract_cil = 1;
+				break;
+		case HLL_M:
+				extract_cil = 0;
+				break;
 		case REMOVE_M:{
 				if (verbose) {
 					printf
@@ -515,6 +652,7 @@ cleanup_list:
 		case PRIORITY_M:{
 				char *endptr = NULL;
 				priority = (uint16_t)strtoul(mode_arg, &endptr, 10);
+				priority_set = 1;
 
 				if ((result = semanage_set_default_priority(sh, priority)) != 0) {
 					fprintf(stderr,
-- 
1.9.3
