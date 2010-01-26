From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 12/15] [src-policy] semodule: edit module
Date: Tue, 26 Jan 2010 17:08:18 -0500
Message-Id: <1264543701-20638-13-git-send-email-ccase@tresys.com>
In-Reply-To: <1264543701-20638-12-git-send-email-ccase@tresys.com>
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
 <1264543701-20638-12-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In order to ease the process of modifying an installed module, this
provides the -E,--edit option to semodule. It will retrieve the
specified module, open it in the default editor, and then reinstall the
module if editing completes successfully.

* Editor to be executed is discovered from the EDITOR environment
  variable.

* Transaction locks are held for the duration of the editing.

* If -E is specified multiple times, then the editor will be
  called on each one, consecutively (editing stops on a particular
  module when the editor exits).

* If the editor exits with a non-zero status, then the transaction
  will be aborted.

* If the editor exits without making any changes to the file (as
  determined from the time stamp), then the transaction will be not be
  committed unless another action requires it to be.

* The editor will be executed in the users SELinux context (as
  determined by getprevcon)

Example:

# export EDITOR=vim
# semodule -E alsa
<edit alsa module>
<after quiting editor module is installed>
---
 policycoreutils/semodule/semodule.8 |   18 +++
 policycoreutils/semodule/semodule.c |  289 ++++++++++++++++++++++++++++++++++-
 2 files changed, 304 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index bb6ae49..8baad8b 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -58,6 +58,24 @@ disable module
 .B  \-g,\-\-get=MODULE_NAME [-o,--output=FILE] [-c,--cil]
 Outputs module source to MODULE_NAME.ref. If output is set to '-' outputs on stdout, otherwise, outputs to the specified FILE. If cil is specified, then outputs the cil source instead of the original source.
 .TP
+.B  \-E,\-\-edit=MODULE_NAME
+Retrieves the specified module, open it in the default editor, and then reinstall the module if editing completes successfully.
+.TP
+.RS
+.IP \[bu]
+Editor to be executed is discovered from the EDITOR environment variable.
+.IP \[bu]
+Transaction locks are held for the duration of the editing.
+.IP \[bu]
+If -E is specified multiple times, then the editor will be called on each one, consecutively (editing stops on a particular module when the editor exits).
+.IP \[bu]
+If the editor exits with a non-zero status, then the transaction will be aborted.
+.IP \[bu]
+If the editor exits without making any changes to the file (as determined from the time stamp), then the transaction will be not be committed unless another action requires it to be.
+.IP \[bu]
+The editor will be executed in the users SELinux context (as determined by getprevcon).
+.RE
+.TP
 .B  \-s,\-\-store	   
 name of the store to operate on
 .TP
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index 0e3cc76..3536253 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -21,6 +21,8 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <limits.h>
+#include <sys/wait.h>
+#include <selinux/selinux.h>
 
 #include <semanage/modules.h>
 
@@ -29,14 +31,14 @@
 enum client_modes {
 	NO_MODE, INSTALL_M, UPGRADE_M, BASE_M, REMOVE_M,
 	LIST_M, RELOAD, PRIORITY_M, ENABLE_M, DISABLE_M,
-	GET_M,
+	GET_M, EDIT_M,
 };
 
 /* list of modes in which one ought to commit afterwards */
 static const int do_commit[] = {
 	0, 1, 1, 1, 1,
 	0, 0, 0, 1, 1,
-	0,
+	0, 1,
 };
 
 struct command {
@@ -125,6 +127,7 @@ static void usage(char *progname)
 	printf("  -e,--enable=MODULE_NAME   enable module\n");
 	printf("  -d,--disable=MODULE_NAME  disable module\n");
 	printf("  -g,--get=MODULE_NAME [-o FILE] [-c] get module source\n");
+	printf("  -E,--edit=MODULE_NAME     open the module in the users EDITOR\n");
 	printf("Other options:\n");
 	printf("  -s,--store	   name of the store to operate on\n");
 	printf("  -n,--noreload	   do not reload policy after commit\n");
@@ -182,6 +185,7 @@ static void parse_command_line(int argc, char **argv)
 		{"get", required_argument, NULL, 'g'},
 		{"output", required_argument, NULL, 'o'},
 		{"cil", 0, NULL, 'c'},
+		{"edit", required_argument, NULL, 'E'},
 		{NULL, 0, NULL, 0}
 	};
 	int i;
@@ -191,7 +195,7 @@ static void parse_command_line(int argc, char **argv)
 	create_store = 0;
 	priority = 400;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:l::vqr:u:RnBDp:e:d:g:o:c", opts,
+		getopt_long(argc, argv, "s:b:hi:l::vqr:u:RnBDp:e:d:g:o:cE:", opts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'b':
@@ -287,6 +291,9 @@ static void parse_command_line(int argc, char **argv)
 
 			break;
 			}
+		case 'E':
+			set_mode(EDIT_M, optarg);
+			break;
 		case '?':
 		default:{
 				usage(argv[0]);
@@ -805,6 +812,282 @@ cleanup_get:
 
 				break;
 			}
+		case EDIT_M:{
+				if (verbose) {
+					printf("Attempting to edit module '%s':\n", mode_arg);
+				}
+
+				semanage_module_key_t *modkey = NULL;
+				semanage_module_info_t *modinfo = NULL;
+				char *data = NULL;
+				size_t data_len = 0;
+
+				int fd = -1;
+				ssize_t nwrite = 0;
+				ssize_t nread = 0;
+
+				char tmp[] = "/tmp/semodule-XXXXXX";
+
+				pid_t pid;
+
+				struct stat sb;
+				time_t mtime;
+
+				/* get module source */
+				result = semanage_module_key_create(sh,
+								    &modkey);
+				if (result != 0) goto cleanup_edit;
+
+				result = semanage_module_key_set_priority(
+						sh,
+						modkey,
+						priority);
+				if (result != 0) goto cleanup_edit;
+
+				result = semanage_module_key_set_name(
+						sh,
+						modkey,
+						mode_arg);
+				if (result != 0) goto cleanup_edit;
+
+				result = semanage_module_get_module_info(
+						sh,
+						modkey,
+						&modinfo);
+				if (result != 0) goto cleanup_edit;
+
+				result = semanage_module_get(
+						sh,
+						modkey,
+						&data,
+						&data_len);
+				if (result != 0) goto cleanup_edit;
+
+				fd = mkstemp(tmp);
+				if (fd < 0) {
+					fprintf(stderr,
+						"%s: Unable to make temp file '%s'. (%s)\n",
+						argv[0],
+						tmp,
+						strerror(errno));
+					result = -1;
+					goto cleanup_get;
+				}
+
+				/* write out to temporary file */
+				while((size_t)nwrite != data_len) {
+					nwrite = write(fd,
+						       data + nwrite,
+						       data_len - nwrite);
+					if (nwrite < 0) {
+						fprintf(stderr,
+							"%s: Failed to write module to %s. (%s)\n",
+							argv[0],
+							tmp,
+							strerror(errno));
+						result = -1;
+						goto cleanup_edit;
+					}
+				}
+
+				result = fsync(fd);
+				if (result != 0) {
+					fprintf(stderr,
+						"%s: Failed to sync module to %s. (%s)\n",
+						argv[0],
+						tmp,
+						strerror(errno));
+					result = -1;
+					goto cleanup_edit;
+				}
+
+				/* get mod time for change detection */
+				result = fstat(fd, &sb);
+				if (result != 0) {
+					fprintf(stderr,
+						"%s: Failed to stat tmp file '%s'. (%s)\n",
+						argv[0],
+						tmp,
+						strerror(errno));
+					result = -1;
+					goto cleanup_edit;
+				}
+				mtime = sb.st_mtime;
+
+				close(fd);
+				fd = -1;
+
+				/* fork and execute editor */
+				pid = fork();
+				if (pid < 0) {
+					fprintf(stderr,
+						"%s: Failed to fork. (%s)\n",
+						argv[0],
+						strerror(errno));
+					result = -1;
+					goto cleanup_edit;
+				}
+
+				if (pid == 0) {		/* child */
+					char *cmd = getenv("EDITOR");
+					if (cmd == NULL) {
+						fprintf(stderr,
+							"%s: EDITOR not set!\n",
+							argv[0]);
+						exit(EXIT_FAILURE);
+					}
+
+					char **cargv = calloc(3, sizeof(char *));
+
+					cargv[0] = strdup(cmd);
+					if (cargv[0] == NULL) {
+						fprintf(stderr,
+							"%s: Out of memory!\n",
+							argv[0]);
+						exit(EXIT_FAILURE);
+					}
+
+					cargv[1] = strdup(tmp);
+					if (cargv[1] == NULL) {
+						fprintf(stderr,
+							"%s: Out of memory!\n",
+							argv[0]);
+						exit(EXIT_FAILURE);
+					}
+
+					security_context_t prevcon = NULL;
+
+					result = getprevcon(&prevcon);
+					if (result != 0) {
+						fprintf(stderr,
+							"%s: Failed to get previous context.\n",
+							argv[0]);
+						exit(EXIT_FAILURE);
+					}
+
+					result = setexeccon(prevcon);
+					if (result != 0) {
+						fprintf(stderr,
+							"%s: Failed to change context to: %s\n",
+							argv[0],
+							prevcon);
+						exit(EXIT_FAILURE);
+					}
+
+					result = execvp(cmd, cargv);
+					if (result != 0) {
+						fprintf(stderr,
+							"%s: Failed to execute editor '%s'. (%s)\n",
+							argv[0],
+							cmd,
+							strerror(errno));
+						exit(EXIT_FAILURE);
+					}
+				}
+
+				/* parent */
+				/* wait for child process to finish */
+				pid = wait(&result);
+				if (pid < 0) {
+					result = -1;
+					goto cleanup_edit;
+				}
+
+				if (WIFEXITED(result)) {
+					result = 0;
+				}
+				else {
+					result = -1;
+					goto cleanup_edit;
+				}
+
+				/* read the module into a buffer */
+				fd = open(tmp, O_RDONLY);
+				if (fd < 0) {
+					fprintf(stderr,
+						"%s: Failed to reopen tmp file '%s'. (%s)\n",
+						argv[0],
+						tmp,
+						strerror(errno));
+					result = -1;
+					goto cleanup_edit;
+				}
+
+				result = fstat(fd, &sb);
+				if (result != 0) {
+					fprintf(stderr,
+						"%s: Failed to stat tmp file '%s'. (%s)\n",
+						argv[0],
+						tmp,
+						strerror(errno));
+					result = -1;
+					goto cleanup_edit;
+				}
+				data_len = sb.st_size;
+
+				/* if not modified,
+				 * then don't commit or install
+				 */
+				if (mtime == sb.st_mtime) {
+					commit--;
+					goto cleanup_edit;
+				}
+
+				/* allocate a buffer for module */
+				free(data);
+				data = malloc(data_len);
+				if (data == NULL) {
+					fprintf(stderr,
+						"%s: Out of memory!\n",
+						argv[0]);
+					result = -1;
+					goto cleanup_edit;
+				}
+
+				/* read the module into the buffer */
+				while ((size_t)nread != data_len) {
+					nread = read(fd,
+						     data + nread,
+						     data_len - nread);
+					if (nread < 0) {
+						fprintf(stderr,
+							"%s: Failed to read in the tmp file '%s'. (%s)\n",
+							argv[0],
+							tmp,
+							strerror(errno));
+						result = -1;
+						goto cleanup_edit;
+					}
+				}
+
+				/* reinstall the module */
+				result = semanage_module_install_info(
+						sh,
+						modinfo,
+						data,
+						data_len);
+				if (result != 0) {
+					result = -1;
+					goto cleanup_edit;
+				}
+
+cleanup_edit:
+				/* don't commit if there was an error */
+				if (result != 0) commit--;
+
+				unlink(tmp);
+
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
