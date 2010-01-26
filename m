From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 11/15] [src-policy] semodule: get module source
Date: Tue, 26 Jan 2010 17:08:17 -0500
Message-Id: <1264543701-20638-12-git-send-email-ccase@tresys.com>
In-Reply-To: <1264543701-20638-11-git-send-email-ccase@tresys.com>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com>
 <1264543701-20638-2-git-send-email-ccase@tresys.com>
 <1264543701-20638-3-git-send-email-ccase@tresys.com>
 <1264543701-20638-4-git-send-email-ccase@tresys.com>
 <1264543701-20638-5-git-send-email-ccase@tresys.com>
 <1264543701-20638-6-git-send-email-ccase@tresys.com>
 <1264543701-20638-7-git-send-email-ccase@tresys.com>
 <1264543701-20638-8-git-send-email-ccase@tresys.com>
 <1264543701-20638-9-git-send-email-ccase@tresys.com>
 <1264543701-20638-10-git-send-email-ccase@tresys.com>
 <1264543701-20638-11-git-send-email-ccase@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This adds the ability to retrieve the module source using semodule.

  -g,--get=MODULE_NAME [-o FILE] [-c] get module source

* More than one -g is allowed per command invocation.

* If output_name is “-“ then output is sent to standard out.

* If output is specified multiple times with oufile_name "-", then
  append to stdout.

* If -o is not specified then the module is output to
  <module name>.<language ext> in the current directory.

* If there is an existing file with the output file name (with or
  without -o), then emit error and exit.

* -c will output the CIL instead of the source format.

Example:

# semodule -g alsa

This will retrieve the high level language source for the alsa module
and save it to alsa.ref in the current directory.
---
 policycoreutils/semodule/semodule.8 |    3 +
 policycoreutils/semodule/semodule.c |  227 ++++++++++++++++++++++++++++++++++-
 2 files changed, 228 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 5fc10b3..bb6ae49 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -55,6 +55,9 @@ enable module
 .B  \-d,\-\-disable=MODULE_NAME
 disable module
 .TP
+.B  \-g,\-\-get=MODULE_NAME [-o,--output=FILE] [-c,--cil]
+Outputs module source to MODULE_NAME.ref. If output is set to '-' outputs on stdout, otherwise, outputs to the specified FILE. If cil is specified, then outputs the cil source instead of the original source.
+.TP
 .B  \-s,\-\-store	   
 name of the store to operate on
 .TP
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index c6b0d3c..0e3cc76 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -20,6 +20,7 @@
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <limits.h>
 
 #include <semanage/modules.h>
 
@@ -27,17 +28,22 @@
 
 enum client_modes {
 	NO_MODE, INSTALL_M, UPGRADE_M, BASE_M, REMOVE_M,
-	LIST_M, RELOAD, PRIORITY_M, ENABLE_M, DISABLE_M
+	LIST_M, RELOAD, PRIORITY_M, ENABLE_M, DISABLE_M,
+	GET_M,
 };
+
 /* list of modes in which one ought to commit afterwards */
 static const int do_commit[] = {
 	0, 1, 1, 1, 1,
 	0, 0, 0, 1, 1,
+	0,
 };
 
 struct command {
 	enum client_modes mode;
 	char *arg;
+	char *output;
+	int cil;
 };
 static struct command *commands = NULL;
 static int num_commands = 0;
@@ -61,6 +67,7 @@ static void cleanup(void)
 {
 	while (--num_commands >= 0) {
 		free(commands[num_commands].arg);
+		free(commands[num_commands].output);
 	}
 	free(commands);
 }
@@ -117,6 +124,7 @@ static void usage(char *progname)
 	printf("  -p,--priority=PRIORITY    set priority for following operations (1-999)\n");
 	printf("  -e,--enable=MODULE_NAME   enable module\n");
 	printf("  -d,--disable=MODULE_NAME  disable module\n");
+	printf("  -g,--get=MODULE_NAME [-o FILE] [-c] get module source\n");
 	printf("Other options:\n");
 	printf("  -s,--store	   name of the store to operate on\n");
 	printf("  -n,--noreload	   do not reload policy after commit\n");
@@ -139,6 +147,8 @@ static void set_mode(enum client_modes new_mode, char *arg)
 	commands = c;
 	commands[num_commands].mode = new_mode;
 	commands[num_commands].arg = NULL;
+	commands[num_commands].output = NULL;
+	commands[num_commands].cil = 0;
 	num_commands++;
 	if (arg != NULL) {
 		if ((s = strdup(arg)) == NULL) {
@@ -169,6 +179,9 @@ static void parse_command_line(int argc, char **argv)
 		{"priority", required_argument, NULL, 'p'},
 		{"enable", required_argument, NULL, 'e'},
 		{"disable", required_argument, NULL, 'd'},
+		{"get", required_argument, NULL, 'g'},
+		{"output", required_argument, NULL, 'o'},
+		{"cil", 0, NULL, 'c'},
 		{NULL, 0, NULL, 0}
 	};
 	int i;
@@ -178,7 +191,7 @@ static void parse_command_line(int argc, char **argv)
 	create_store = 0;
 	priority = 400;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:l::vqr:u:RnBDp:e:d:", opts,
+		getopt_long(argc, argv, "s:b:hi:l::vqr:u:RnBDp:e:d:g:o:c", opts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'b':
@@ -227,6 +240,53 @@ static void parse_command_line(int argc, char **argv)
 		case 'd':
 			set_mode(DISABLE_M, optarg);
 			break;
+		case 'g':
+			set_mode(GET_M, optarg);
+			break;
+		case 'o':{
+			/* no mode specified?? */
+			if (num_commands == 0) {
+				usage(argv[0]);
+				exit(1);
+			}
+
+			struct command *last = &commands[num_commands - 1];
+
+			/* only GET_M mode valid with -o */
+			if (last->mode != GET_M) {
+				usage(argv[0]);
+				exit(1);
+			}
+
+			last->output = strdup(optarg);
+			if (last->output == NULL) {
+				fprintf(stderr,
+					"%s: Out of memory!\n",
+					argv[0]);
+				exit(1);
+			}
+
+			break;
+			}
+		case 'c':{
+			/* no mode specified?? */
+			if (num_commands == 0) {
+				usage(argv[0]);
+				exit(1);
+			}
+
+			struct command *last = &commands[num_commands - 1];
+
+			/* only GET_M mode valid with -c */
+			if (last->mode != GET_M) {
+				usage(argv[0]);
+				exit(1);
+			}
+
+			last->cil = 1;
+
+			break;
+			}
 		case '?':
 		default:{
 				usage(argv[0]);
@@ -350,6 +410,8 @@ int main(int argc, char *argv[])
 	for (i = 0; i < num_commands; i++) {
 		enum client_modes mode = commands[i].mode;
 		char *mode_arg = commands[i].arg;
+		char *mode_output = commands[i].output;
+		int mode_cil = commands[i].cil;
 
 		switch (mode) {
 		case INSTALL_M:{
@@ -582,6 +644,167 @@ cleanup_disable:
 
 				break;
 			}
+		case GET_M:{
+				if (verbose) {
+					printf("Attempting to get module '%s':\n", mode_arg);
+				}
+
+				semanage_module_key_t *modkey = NULL;
+				semanage_module_info_t *modinfo = NULL;
+				const char *lang_ext = NULL;
+				char *data = NULL;
+				size_t data_len = 0;
+
+				int fd = -1;
+				FILE *out = NULL;
+				size_t nwrite = 0;
+
+				result = semanage_module_key_create(sh,
+								    &modkey);
+				if (result != 0) goto cleanup_get;
+
+				result = semanage_module_key_set_priority(
+						sh,
+						modkey,
+						priority);
+				if (result != 0) goto cleanup_get;
+
+				result = semanage_module_key_set_name(
+						sh,
+						modkey,
+						mode_arg);
+				if (result != 0) goto cleanup_get;
+
+				if (mode_cil == 0) {
+					result = semanage_module_get(
+							sh,
+							modkey,
+							&data,
+							&data_len);
+				}
+				else {
+					result = semanage_module_get_cil(
+							sh,
+							modkey,
+							&data,
+							&data_len);
+				}
+				if (result != 0) goto cleanup_get;
+
+				/* get language extension */
+				result = semanage_module_get_module_info(
+						sh,
+						modkey,
+						&modinfo);
+				if (result != 0) goto cleanup_get;
+
+				if (mode_cil == 0) {
+					result = semanage_module_info_get_lang_ext(
+							sh,
+							modinfo,
+							&lang_ext);
+					if (result != 0) goto cleanup_get;
+				}
+				else {
+					/* current cil is refpol */
+					lang_ext = "ref";
+				}
+
+				if (mode_output == NULL ||
+				    strcmp(mode_output, "-") != 0) {
+					char path[PATH_MAX];
+
+					if (mode_output == NULL) {
+						/* by default write out to <name>.<lang> */
+						/* compose path */
+
+						result = snprintf(path,
+								  sizeof(path) - 1,
+								  "%s.%s",
+								  mode_arg,
+								  lang_ext);
+						if (result < 0 ||
+						    result >= (int)sizeof(path)) {
+							fprintf(stderr,
+								"%s: Unable to compose path for output file.\n",
+								argv[0]);
+							result = -1;
+							goto cleanup_get;
+						}
+						result = 0;
+					}
+					else {
+						if (strlen(mode_output) > sizeof(path) - 1) {
+							fprintf(stderr,
+								"%s: Path too long (%d > %d): '%s'\n",
+								argv[0],
+								strlen(mode_output),
+								sizeof(path) - 1,
+								mode_output);
+							result = -1;
+							goto cleanup_get;
+						}
+						strcpy(path, mode_output);
+					}
+
+					/* open file iff it doesn't exist */
+					fd = open(path,
+						  O_WRONLY | O_CREAT | O_EXCL,
+						  S_IRUSR | S_IWUSR);
+					if (fd < 0) {
+						fprintf(stderr,
+							"%s: Unable to open output '%s'. (%s)\n",
+							argv[0],
+							path,
+							strerror(errno));
+						result = -1;
+						goto cleanup_get;
+					}
+
+					out = fdopen(fd, "w");
+					if (out == NULL) {
+						fprintf(stderr,
+							"%s: Unable to open output '%s'. (%s)\n",
+							argv[0],
+							path,
+							strerror(errno));
+						result = -1;
+						goto cleanup_get;
+					}
+				}
+				else {
+					/* otherwise we must be special '-' */
+					out = stdout;
+				}
+
+				nwrite = fwrite(data,
+						data_len,
+						1,
+						out);
+				if (nwrite != 1) {
+					fprintf(stderr,
+						"%s: Failed to write module to output.\n",
+						argv[0]);
+					result = -1;
+					goto cleanup_get;
+				}
+
+cleanup_get:
+				if (out != NULL && out != stdout) {
+					fclose(out);
+					fd = -1;
+				}
+				if (fd >= 0) close(fd);
+				free(data);
+
+				semanage_module_info_destroy(sh, modinfo);
+				free(modinfo);
+
+				semanage_module_key_destroy(sh, modkey);
+				free(modkey);
+
+				break;
+			}
 		default:{
 				fprintf(stderr,
 					"%s:  Unknown mode specified.\n",
-- 
1.6.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
